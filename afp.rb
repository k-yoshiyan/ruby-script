#!/usr/bin/ruby
# coding: utf-8

# afp.rb
# カレントディレクトリーの下のファイルをafplayで連続再生する
require 'shellwords'
path = Dir.pwd
extensions = [".mp3", ".wav", ".MP3", ".WAV", ".m4a", ".flac"]
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

## ディレクトリー内の演奏対象ファイル名の表示
music_array.sort!.each do |music|
  puts "(#{music_array.index(music)+1}) " + music
end  
puts 

## 演奏楽曲の配列を個数分ループして処理
## dropメソッドでパラメータ分の配列要素を除去
music_array.drop(start_point).each do |music|
  puts music
### 演奏開始時刻と演奏時間を表示する
  puts "  Start: " + Time.now.strftime("%X") 
  music_time = `sox --i -d #{music.shellescape}`
  puts "  Time:  " + music_time
  `afplay -q 1 #{music.shellescape}`
end  

# 課題
# マッチングを正規表現にできないか
# 曲の順番を表示する

