# coding: utf-8
# ヤマレコで作成した登山計画の工程から場所と所要時間を切り出す

puts "ヤマレコで作成した登山計画を入力してください"
plan = gets
#plan = "08:40 西丹沢自然教室 - 09:20 703m地点 - 10:40 善六ノタワ - 11:40 畦ヶ丸 - 12:25 大滝峠上 - 13:05 一軒屋避難小屋 - 14:05 大滝橋 - 14:35 中川"

def hhmm_to_min(hhmm)
  min = hhmm.split(":")[0].to_i * 60 + hhmm.split(":")[1].to_i
  return min
end

def min_to_hhmm(min)
  hhmm =  sprintf("%02d",min.divmod(60)[0]) + ":" + sprintf("%02d",min.divmod(60)[1])
  return hhmm 
end

plan_arr = []

## [[時刻,場所],[時刻,場所]]の配列に入れ直す
plan.split("-").each do |x|
  plan_arr.push(x.split(nil))
end

puts 
puts "<<場所>>"

## 場所の表示
(0..plan_arr.size-1).each do |i|
  puts plan_arr[i][1]
end

puts 
puts "<<所要時間>>"

## 経過所要時間の表示
(0..plan_arr.size-2).each do |i|
  duration = hhmm_to_min(plan_arr[i+1][0]) - hhmm_to_min(plan_arr[i][0])
  puts min_to_hhmm(duration)
end

