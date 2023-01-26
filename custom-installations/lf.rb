# frozen_string_literal: true

require 'fileutils'
require 'open-uri'
require 'json'

INSTALL_PATH = 'C:\\Portable Program Files'

puts 'Installing lf...'

current_path = Dir.pwd

puts "Enter install path (default #{INSTALL_PATH}): "
print '> '
selected = gets.chop
selected = selected.empty? ? INSTALL_PATH : selected
puts "Installing lf in #{selected}"

FileUtils.mkdir(selected) unless Dir.exist?(selected)
FileUtils.cd(selected)

puts 'Cloing required scripts...'
system 'git clone https://github.com/kelvinchin12070811/lf-updater.git lf'
FileUtils.cd('lf')

puts 'Fetching latest binary info...'
response = URI.open('https://api.github.com/repos/gokcehan/lf/releases/latest').read
assets = JSON.parse(response)['assets']

LF_ASSET_NAME = 'lf-windows-amd64.zip'

assets.each do |asset|
  next if asset['name'] != LF_ASSET_NAME

  puts "Downloading binary (#{asset['size']} bytes)..."
  system "curl -OL #{asset['browser_download_url']}"
  system "pwsh -Command \"Expand-Archive \\\"#{FileUtils.pwd}/#{LF_ASSET_NAME}\\\" .\""
  FileUtils.rm(LF_ASSET_NAME)
  FileUtils.mv('lf.exe', 'lf.bin.exe')

  puts 'Linking...'
  system('pwsh -Command "[Environment]::SetEnvironmentVariable(\"Path\", ' \
       "\\\"#{FileUtils.pwd.gsub('/', '\\')};\\\" + " \
       '[Environment]::GetEnvironmentVariable(\"Path\", [EnvironmentVariableTarget]::Machine)' \
       ', [EnvironmentVariableTarget]::Machine)"')
end

FileUtils.cd(current_path)
