#!/usr/bin/ruby
# coding: utf-8

# afp.rb
# カレントディレクトリーの下のファイルをafplayで連続再生する
require 'shellwords'
path = Dir.pwd
music_array = []

# ディレクトリーの内容オブジェクト数分ループして処理をし、演奏楽曲の配列を作る
Dir.foreach(path) do |x|
 music_array.push(x)
end

# 演奏楽曲の配列を個数分ループして処理
music_array.each do |music|
  puts music
  `afplay -q 1 #{music.shellescape}`
end  

# 課題
# 音楽ファイルのみを実行対象とすること
# 外部割り込みで次の楽曲を演奏できるようにすること
