module Robot

  def self.main
    if ARGV.empty?
      program = $stdin.read
    else
      program = File.open(ARGV.first).read
    end

    Robot.new.run program
  end

end

