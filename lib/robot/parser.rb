module Robot
  ##
  # User input parser module.
  module Parser
    ##
    # Parse user input consisting of a series of commands, one per line.
    #
    # For each valid command, this yields an array of tokens, where the first
    # token is a symbol representing the command, and the remaining tokens are
    # the command's arguments.
    #
    def self.parse(text)
      text.split("\n").each do |line|
        tokens = line.split
        command = tokens.first.downcase.to_sym rescue nil

        if command == :place
          args = parse_arg_for_place(tokens[1])
          yield [command] + args unless args.nil?
        elsif %i[move left right report].include? command
          yield [command]
        end
      end
    end

    ##
    # Parse the arguments for a PLACE command.
    #
    # This attempts to parse a string of the form +x,y,f+. Values +x+ and +y+
    # must be integers, and +f+ must be one of +NORTH+, +EAST+, +SOUTH+, or
    # +WEST+.
    #
    # Returns an array of three elements [x, y, f] if the string is parsed
    # successfully, and +nil+ otherwise.
    #
    def self.parse_arg_for_place(string)
      tokens = string.split(',') rescue []
      return nil unless tokens.length == 3

      begin
        x = Integer(tokens[0])
        y = Integer(tokens[1])
      rescue ArgumentError, TypeError
        return nil
      end

      direction = tokens[2].downcase.to_sym rescue nil
      [x, y, direction] if DIRECTIONS.include? direction
    end

    private_class_method :parse_arg_for_place
  end
end
