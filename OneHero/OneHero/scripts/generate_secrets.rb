#!/usr/bin/ruby

file_content = <<-APPSECRETS_FILE_STRING
// THIS FILE IS AUTO GENERATED & GIT IGNORED
// OneHero

struct AppSecrets {
    static let privateApiKey = "#{ENV['MARVEL_API_PRIVATE_KEY']}"
    static let publicApiKey = "#{ENV['MARVEL_API_PUBLIC_KEY']}"
}
APPSECRETS_FILE_STRING

file = File.new("../Configurations/Secrets/AppSecrets.swift", "w")
file.puts(file_content)
file.close
