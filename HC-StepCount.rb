#!/usr/bin/ruby
# coding: utf-8

# HC-StepCount.rb
# ヘルスケアのデータから歩数を抽出し、日毎に集計する

stepcount_line = []
line_array = []
date_value_hash = {}

# xmlからStepCountのレコードを抽出
File.foreach("export.xml") do |line|
  if line.match(/StepCount/)
    stepcount_line.push(line)
  end  
end

stepcount_line.each do |x|
  # 日付
  j = x.index("startDate=")
  date = x.slice(j+11,10)
  # 歩数
  i = x.index("value")
  value = x.slice(i+6,8).delete("^0-9").to_i
  # 同一日付があれば加算してdate=>valueのハッシュに格納
  if date_value_hash.include?(date) then
    value = date_value_hash.fetch(date) + value
  end
  date_value_hash.store(date,value)

end

date_value_hash.sort.each do |z|
  puts z[0]  + "   " + z[1].to_s
end  
