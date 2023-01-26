# frozen_string_literal: true

require 'fileutils'

INSTALL_PATH = 'C:\\Portable Program Files'

puts 'Installing yt-dlp...'
current_path = Dir.pwd

puts "Enter install path (default #{INSTALL_PATH}): "
print '> '
selected = gets.chop
selected = selected.empty? ? INSTALL_PATH : selected
puts "Installing yt-dlp at #{selected}"

FileUtils.mkdir(selected) unless Dir.exist?(selected)
FileUtils.cd(selected)

system 'git clone https://gist.github.com/ddaaa4f6034da11babb02631d5a2e113.git yt-dlp'
FileUtils.cd('yt-dlp')
puts ''

system 'ruby ./yt-dlp-updater.rb'
puts ''

puts 'Linking...'
unless File.exist?('./youtube-dl.exe')
  FileUtils.ln_s("#{FileUtils.pwd}\\yt-dlp.exe",
                 "#{FileUtils.pwd}\\youtube-dl.exe")
end
system('pwsh -Command "[Environment]::SetEnvironmentVariable(\"Path\", ' \
       "\\\"#{FileUtils.pwd.gsub('/', '\\')};\\\" + " \
       '[Environment]::GetEnvironmentVariable(\"Path\", [EnvironmentVariableTarget]::Machine)' \
       ', [EnvironmentVariableTarget]::Machine)"')

puts 'Completed!'

FileUtils.cd(current_path)
