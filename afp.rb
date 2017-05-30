#!/usr/bin/ruby
# coding: utf-8

# afp.rb
# カレントディレクトリーの下のファイルをafplayで連続再生する
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


## 演奏楽曲の配列を個数分ループして処理
## dropメソッドでパラメータ分の配列要素を除去
music_array.drop(start_point).each do |music|
  puts music
  `afplay -q 1 #{music.shellescape}`
end  

# 課題
# ディレクトリー内の全ファイルの表示と再生中ファイル名を表示すること
# 演奏時間を表示すること
