# coding: utf-8
# ヤマレコAPI getReclist, getUserInfo
# ユーザを指定してヤマレコに登録されている記録を取得する

require 'net/http'
require 'json'

Net::HTTP.version_1_2

Host = 'www.yamareco.com'

if ARGV[0] != nil then userID = ARGV[0].to_s
  else userID = "4541"  # yoshiyan
end

maxpage = 40

# 当該ユーザの山行記録の入山日、場所、記録のIDを表示
(1..maxpage).each do |page|
  path = '/api/v1/getReclist/user/' + userID + '/' + page.to_s

  Net::HTTP.start(Host, 80) do |http|
    response = http.get(path)
    js = JSON.parse(response.body)
    if js["err"] == 1 then break
    else
      js["reclist"].each do |rec|
      puts rec["start"] + ' : ' + rec["place"] + '('  + rec["rec_id"] + ')' + ' [' + rec["cheer"].to_s + ']'
      end
    end  
  end
end

# ユーザ名とユーザIDを表示
path = '/api/v1/getUserInfo/' + userID
  Net::HTTP.start(Host, 80) do |http|
    response = http.get(path)
    js = JSON.parse(response.body)
    puts js["userinfo"]["uname"] + ' [' + js["userinfo"]["uid"].to_s + ']'
end

#課題
#user名からuserIDを入手する
