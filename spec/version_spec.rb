# Find the newest version number heading in the changelog
# and return the version number string.
def changelog_version(filename = 'CHANGELOG.md')
  File.open('CHANGELOG.md') do |changelog|
    changelog.each_line do |line|
      if heading = /^## ([0-9.]+)/.match(line)
        return heading.captures.first
      end
    end
  end
  nil
end

RSpec.describe Robot::VERSION do
  it 'matches the changelog version' do
    expect(Robot::VERSION).to eq changelog_version
  end
end
