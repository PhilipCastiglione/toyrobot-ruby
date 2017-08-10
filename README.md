Toy Robot Simulator
===================

This is a Ruby simulation of a toy robot moving on a square tabletop.


## Environment

This application was developed on macOS 10.12 with Ruby 2.4.1
(installed with Homebrew).


## Dependencies

To install the dependencies, `cd` to the root directory of the project
and invoke:

    $ gem install bundler
    $ bundle install


## Installation

To learn how to install Ruby, visit:
[https://www.ruby-lang.org/en/documentation/installation/](https://www.ruby-lang.org/en/documentation/installation/)


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
Bundler (see the Dependencies section above).

Tests are located in the *spec* folder. To run the tests, invoke:

    $ rake spec


## Overview

TODO


## Discussion

TODO


## Contributing

TODO


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
