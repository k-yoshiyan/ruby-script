#!/usr/bin/ruby
# coding: utf-8

# afprand.rb
# wavdata の下をafplayでランダム再生する
require 'shellwords'
extensions = [".mp3", ".wav", ".MP3", ".WAV", ".m4a", ".flac"]

directory = '/Volumes/wavdata'
if ARGV[0] == "-p" then directory = '/Users/koji/Music/mp3data' end
if ARGV[0] == "-pp" then directory = '/Users/koji/Music/mp3-sync' end
dir_array = []
music_array = []

Dir.chdir(directory)
dir_array = Dir.glob('./**/*')
dir_array.each do |x|
  if extensions.include?(File.extname(x))
    music_array.push(directory + x[1..300])
  end
end
puts music_array.size

loop do
## 配列からランダムに再生楽曲を選択する
music = music_array[rand(music_array.size)]

## 演奏対象ファイル名の表示と演奏
puts music
  puts "  Start: " + Time.now.strftime("%X") 
  music_time = `sox --i -d #{music.shellescape}`
  puts "  Time:  " + music_time
  `afplay -q 1 #{music.shellescape}`
puts 
end

# 課題
# wavdata か mp3data かを選択可能にする

