# frozen_string_literal: true

puts 'Installing Better Discord...'
better_discord_releases = URI.open('https://api.github.com/repos/BetterDiscord/Installer/releases/latest').read
better_discord_assets = JSON.parse(better_discord_releases)['assets']
better_discord_assets.each do |asset|
  next if asset['content_type'] != 'application/x-ms-dos-executable'

  puts "Downloading installer (#{asset['size']} Bytes)..."
  system "curl -OL #{asset['browser_download_url']}"

  puts 'Starting installer...'
  system asset['name']
  break
end
