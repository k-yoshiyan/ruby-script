# coding: utf-8
# ヤマレコAPI getReclist, getUserInfo
# ユーザを指定してヤマレコに登録されている記録を取得する
# 与えられたパラメータに従ってリストを検索し、ブラウザで表示する。

require 'net/http'
require 'json'

Net::HTTP.version_1_2

Host = 'api.yamareco.com'

userID = "4541"  # yoshiyan
maxpage = 40
matched_contents = []
cond1 = ARGV[0]

# 当該ユーザの山行記録の入山日、場所、記録のIDを表示
(1..maxpage).each do |page|
  path = '/api/v1/getReclist/user/' + userID + '/' + page.to_s

  Net::HTTP.start(Host, 80) do |http|
    response = http.get(path)
    js = JSON.parse(response.body)
    if js["err"] == 1 then break
    else
      js["reclist"].each do |rec|
      rec_content= rec["start"] + ' : ' + rec["place"] + '('  + rec["rec_id"] + ')' + ' [' + rec["cheer"].to_s + ']'
      if rec_content.match(/#{cond1}/)
      then
        array1 = []
        array1.push(rec_content)
        array1.push(rec["page_url"])
        matched_contents.push(array1)
      end
      end
    end  
  end
end

#該当の結果出力と番号入力
matched_contents.each_with_index do |x,i|
  puts i.to_s + " : " + x[0]
end

#該当の番号のレコをブラウザで表示
puts "表示したい番号を入力してください"
input = STDIN.gets.to_i
`open -a "/Applications/Firefox.app" "#{matched_contents[input][1]}"`


#課題
#検索条件の複数化
#検索の正規表現
#ユーザーIDの指定
