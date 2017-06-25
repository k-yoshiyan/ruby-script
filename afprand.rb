#!/usr/bin/ruby
# coding: utf-8

# afp.rb
# カレントディレクトリーの下のファイルをafplayでランダム再生する
require 'shellwords'
path = Dir.pwd
extensions = [".mp3", ".wav", ".MP3", ".WAV"]
music_array = []

## パラメーターで開始位置を与えられた場合に変数にセット
if ARGV[0] then start_point = ARGV[0].to_i - 1  else start_point = 0 end

## ディレクトリーの内容オブジェクト数分ループして処理をし、演奏楽曲ファイル名の配列を作る
Dir.foreach(path) do |x|
### mp3, wavのファイル名のみを選択する　
  if extensions.include?(File.extname(x))
    music_array.push(x)
  end
end

loop do
## 配列からランダムに再生楽曲を選択する
music = music_array[rand(music_array.size)]

## 演奏対象ファイル名の表示と演奏
puts "(#{music_array.index(music)+1}) " + music
puts 
puts "  Start: " + Time.now.strftime("%X") + "  Size: " + File.stat(music).size.div(1024).to_s + "kb"
  `afplay -q 1 #{music.shellescape}`

end

# 課題
# 特定ディレクトリーの下の楽曲をすべて配列にいれてランダム演奏する

