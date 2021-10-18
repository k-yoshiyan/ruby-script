#!/usr/bin/ruby
# coding: utf-8

# afpgrep.rb
# wavdata の条件検索し、選んだディレクトリーをafplayで再生する
require 'shellwords'
extensions = [".mp3", ".wav", ".MP3", ".WAV", ".m4a", ".flac"]

directory = '/Volumes/wavdata/cla'
#directory = '/Users/koji'
dir_array = []
matched_dir_array = []
cond1 = ARGV[0]

Dir.chdir(directory)
dir_array = Dir.glob('./**/')
dir_array.each do |x|
  if x.match(/#{cond1}/)
    matched_dir_array.push(x)
  end
end

#該当の結果出力と番号入力
matched_dir_array.each_with_index do |x,i|
  puts i.to_s + " : " + x
end

puts "演奏したい番号を入力してください"
input = STDIN.gets.to_i
matched_dir = matched_dir_array[input]
Dir.chdir(matched_dir)
music_array = []
start_point = 0

## ディレクトリーの内容オブジェクト数分ループして処理をし、演奏楽曲ファイル名の配列を作る
path = Dir.pwd
puts path
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
music_array.droph(start_point).each do |music|
  puts music
### 演奏開始時刻と演奏時間を表示する
  puts "  Start: " + Time.now.strftime("%Y/%m/%d %H:%M:%S") 
  music_time = `sox --i -d #{music.shellescape}`
  puts "  Duration:  " + music_time
  `afplay -q 1 #{music.shellescape}`
end  

# 課題
# matching 0の処理
# 大文字小文字を意識しない正規表現



