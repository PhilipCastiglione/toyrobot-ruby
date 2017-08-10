module Robot
  module Parser
    def self.parse(text)
      text.split("\n").each do |line|
        tokens = line.split
        command = tokens.first.downcase.to_sym rescue nil

        if command == :place
          args = self.parse_arg_for_place(tokens[1])
          yield [command] + args unless args.nil?
        elsif %i[move left right report].include? command
          yield [command]
        end
      end
    end

    private

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
  end
end
