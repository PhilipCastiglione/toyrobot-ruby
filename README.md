Toy Robot Simulator
===================

[![Travis CI Build Status](https://travis-ci.org/araile/toyrobot-ruby.svg?branch=master)](https://travis-ci.org/araile/toyrobot-ruby)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/umocx44phb1pj92h/branch/master?svg=true)](https://ci.appveyor.com/project/araile/toyrobot-ruby/branch/master)

This is a Ruby simulation of a toy robot moving on a square tabletop.


## Environment

This application requires Ruby 2.0 or greater.
It has been tested in the following environments:

  - macOS 10.12, Ruby 2.4.1 with [Homebrew][brew] (development machine)
  - Linux, Ruby 2.0.x – 2.4.x ([tested with Travis CI][travis])
  - Linux, JRuby 9.x ([tested with Travis CI][travis])
  - Windows, Ruby 2.0.x – 2.4.x ([tested with AppVeyor][appveyor])

[brew]: https://brew.sh
[travis]: https://travis-ci.org/araile/toyrobot-ruby
[appveyor]: https://ci.appveyor.com/project/araile/toyrobot-ruby


## Installation

To learn how to install Ruby, visit:
[https://www.ruby-lang.org/en/documentation/installation/](https://www.ruby-lang.org/en/documentation/installation/)


## Dependencies

To install the dependencies, `cd` to the root directory of the project
and invoke:

    $ gem install bundler
    $ bundle install


## Usage

To run the application with an input file, invoke:

    $ bin/robot commands.txt

The file must consist of a sequence of commands for the robot, with one
command per line. For example:

    PLACE 0,0,NORTH
    MOVE
    RIGHT
    MOVE
    REPORT

Invoke `bin/robot` without arguments to read the commands from standard input.


## Testing

[RSpec](http://rspec.info) is required for testing. This is installed using
Bundler (see the *Dependencies* section above).

Tests are located in the *spec* folder. To run the tests, invoke:

    $ bundle exec rake


## Overview

This is a similation of a toy robot moving on a square tabletop of dimensions
5&times;5 units. There are no other obstructions on the table surface. The
robot is free to roam around the surface of the table, and is prevented from
falling to destruction.

The application reads a series of text commands, one per line. It accepts the
following commands:

  - `PLACE x,y,f` will put the toy robot in position (*x*,&nbsp;*y*) and
    facing in direction *f*, where *f* is one of `NORTH`, `EAST`, `SOUTH`, or
    `WEST`. Point (0,&nbsp;0) is the south-west corner; point (4,&nbsp;4) is
    the north-east corner.

  - `MOVE` will move the robot one unit forward.

  - `LEFT` and `RIGHT` will rotate the robot 90 degrees in the specified
    direction, without changing its position.

  - `REPORT` will print the current position and direction of the robot, in
    the form `x,y,f`. For example, if the robot is at (1,&nbsp;2) and facing
    north, `REPORT` will print `1,2,NORTH`.

The robot will not be placed on the table until it received a `PLACE` command.
Until then, it must discard any other commands it receives.

The robot must not fall off the table during movement or initial placement.


## Design

The application consists of the following:

  * A *lib* folder defining a `Robot` module.
  * A *bin* folder containing a script to launch the application.
  * A *spec* folder containing RSpec tests.

### Launch

*bin/robot* is a short script which includes all the files from the *lib*
folder that define the application.

It then calls the `Robot.main` method, which is defined in
*lib/robot/main.rb*. This method does the following:

 1. First it reads user input, which consists of a series of commands for the
    robot, one per line.

    If the script was invoked with one or more arguments, text is read from
    the file specified by the first argument. If it was invoked without
    arguments, text is read from standard input.

 1. Once it has some text, it creates a `Robot` instance and 'runs' it with
    the text. The results of any `REPORT` commands in the text are written to
    standard output.

### Robot module

The `Robot` module is defined by files in the *lib* and *lib/robot* folders.
It consists of the following:

  - A `Robot` class (*lib/robot.rb*)
    which reads a sequence of commands and responds to them, tracking the
    position and direction of the robot.

  - A `Grid` class (*lib/robot/grid.rb*)
    which stores the width and height of the tabletop.

  - A `Position` class (*lib/robot/position.rb*)
    which stores a given (*x*, *y*) coordinate. This class is responsible for
    clamping the values to within the range defined by a given `Grid`.

  - A `DIRECTIONS` array (*lib/robot.rb*)
    containing the symbols `:north`, `:east`, `:south` and `:west`.

  - A `Parser` class (*lib/robot/parser.rb*)
    which reads lines from a string and translates them into 'tokens' to be
    processed by the `Robot` class.

  - A `main` method (*lib/robot/main.rb*)
    which is described in the *Launch* section above.


## Discussion

For this application I chose to use a TDD approach. I wrote tests with RSpec,
and wrote code to satisfy the tests.

I found that this helped me to isolate different elements of functionality,
and design an appropriate interface for each class. It also allowed me to
delay the task of parsing user input, to focus on making the robot work as
expected. Once the robot was functional, its API was simple enough for me that
writing the command parser was relatively straightforward.

### Movement

The robot uses an instance of the `Grid` class to store the width and height
of the table. (In hindsight, a name like `TableTop` would be more
descriptive.) It defaults to a size of 5&times;5 units, but can be initialised
with any other size, provided that the width and height are both greater than
zero.

I chose to use the `Position` class to manage the position and movement of the
robot on the table:

  - The robot's initial position is `nil`, representing that it is off the
    table.

  - When the robot is placed on the table, it creates a `Position` instance
    and stores it as its current position.

  - When the robot moves, it asks its current `Position` to create a new
    `Position` that is one step in the given direction. The robot stores this
    new instance as its current position.

This design makes it easy for the `Position` class to take on the
responsibility of *validating* the robot's movement:

  - When a `Position` instance is initialised, the values are clamped such
    that it represents a point on the edge of the table that is closest to the
    requested position. Only these clamped coordinates are stored.

  - As a result, if the robot attempts to step off the edge of the table, it
    will be corrected by the `Position` class, remaining in the same spot on
    the table.

This removes responsibility from the `Robot` class, simplifying the
implementations of the robot commands.

One ambiguous point in the problem description is how to handle an invalid
position when *placing* the robot (rather than moving it). Should the
application discard the command, or place the robot somewhere else that *is*
on the table? I have chosen the latter as this behaviour is provided for free
by the above design: the robot will be placed at the closest point on the edge
of the table.


### Parsing

The application uses a `Parser` class to process user input. This reads
commands from user input and translates them into command *tokens*, which are
then passed up to the `Robot` class to perform the appropriate actions.

The `Parser` class is wholly responsible for discarding invalid commands and
converting the command arguments into appropriate types.

I chose the following rules for parsing commands:

  - Extraneous whitespace is ignored.

  - Extraneous command arguments are ignored.
    For example, `LEFT 2 3 4` is interpreted as `LEFT`.

  - Invalid commands are quietly ignored.

  - The parser is stateless. (The `Robot` class is responsible for ignoring
    commands before the first `PLACE` command.)

In addition, I decided to be strict about parsing the `x,y,f` arguments to the
`PLACE x,y,f` command. A `PLACE` command will only be valid if the following
are true:

  - It has three values.
  - The first two values are integers.
  - The third value is one of the four recognised directions.

I used `Integer()` to convert *x* and *y* to integers, as this raises an
exception if they cannot be converted. If I had used `to_i` instead, any
invalid values would be treated as 0, calling for the robot to be placed on
the south and/or west edges of the table.

When a valid command is parsed, the result is an array of tokens. These are
interpreted by the `Robot` class, which decides how to act on them.

#### Parsing Example

Given the user input:

    PLACE 0,0,NORTH
    MOVE
    REPORT

The `Parser` class will pass three arrays up to the `Robot` class:

    [:place, 0, 0, :north]
    [:move]
    [:report]

The `Robot` will then perform the equivalent of the following code:

    robot.place(0, 0, :north)
    robot.move
    robot.report


## License

MIT License

Copyright (c) 2017 Liam Cooke

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
