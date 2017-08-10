module Robot
  def self.main
    program = if ARGV.empty?
                $stdin.read
              else
                File.open(ARGV.first).read
              end

    Robot.new.run program
  end
end
