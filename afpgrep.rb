#!/usr/bin/ruby
# coding: utf-8

# afpgrep.rb
# wavdata の条件検索し、選んだディレクトリーをafplayで再生する
require 'shellwords'
extensions = [".mp3", ".wav", ".MP3", ".WAV", ".m4a", ".flac"]

directory = '/Volumes/wavdata/cla'

if ARGV.include?("-p")
  directory = '/Volumes/wavdata/pop'
  ARGV.delete("-p")
end

dir_array = []
matched_dir_array = []
cond1 = ARGV[0]
cond2 = ARGV[1]
cond3 = ARGV[2]
composer_name_array = []

puts $0

#配下のディレクトリー名を取得
Dir.chdir(directory)
dir_array = Dir.glob('./**/')

#引数がなければ作曲家名を出力
if ARGV.size == 0
then 
  dir_array.each do |x|
    composer_name = x.split(/[_|-]/)[0]
    composer_name_array.push(composer_name)
  end
   composer_name_array.uniq.sort.each do |y|
     puts "  " + y.delete("./")
  end
     puts "条件を入力してください。"
else

#引数の条件とマッチング
dir_array.each do |x|
  if x.match(/^(?=.*#{cond1})(?=.*#{cond2})(?=.*#{cond3})/i)
    matched_dir_array.push(x)
  end
end

#該当の結果出力と番号入力
matched_dir_array.each_with_index do |x,i|
  puts i.to_s + " : " + x
end

puts "演奏したい番号を入力してください"
inputs = STDIN.gets.split(' ')
matched_dir = matched_dir_array[inputs[0].to_i]
Dir.chdir(matched_dir)
music_array = []
if inputs[1].to_i >= 1 then start_point = inputs[1].to_i - 1
else start_point = 0
end 

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
music_array.drop(start_point).each do |music|
  puts music
### 演奏開始時刻と演奏時間を表示する
  puts "  Start: " + Time.now.strftime("%Y/%m/%d %H:%M:%S") 
  music_time = `sox --i -d #{music.shellescape}`
  puts "  Duration:  " + music_time
  `afplay -q 1 #{music.shellescape}`
end  

end


# 課題
# 入力エラー処理

