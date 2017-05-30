#!/usr/bin/ruby
# coding: utf-8

# afp.rb
# カレントディレクトリーの下のファイルをafplayで連続再生する
require 'shellwords'
path = Dir.pwd
extensions = [".mp3", ".wav", ".MP3", ".WAV"]
music_array = []

## ディレクトリーの内容オブジェクト数分ループして処理をし、演奏楽曲ファイル名の配列を作る
Dir.foreach(path) do |x|
### mp3, wavのファイル名のみを選択する　
  if extensions.include?(File.extname(x))
    music_array.push(x)
  end
end

## 演奏楽曲の配列を個数分ループして処理
music_array.each do |music|
  puts music
  `afplay -q 1 #{music.shellescape}`
end  

# 課題
# 外部割り込みで次の楽曲を演奏できるようにすること
# 演奏時間を表示すること
