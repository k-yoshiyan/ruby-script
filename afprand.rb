#!/usr/bin/ruby
# coding: utf-8

# afprand.rb
# wavdata の下をafplayでランダム再生する
require 'shellwords'
extensions = [".mp3", ".wav", ".MP3", ".WAV"]

directory = '/Users/koji/Music/wavdata'
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
puts "  Start: " + Time.now.strftime("%X") + "  Size: " + File.stat(music).size.div(1024).to_s + "kb"
  `afplay -q 1 #{music.shellescape}`
puts 
end

# 課題
# wavdata か mp3data かを選択可能にする

