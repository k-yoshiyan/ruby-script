# coding: utf-8
# ヤマレコAPI getReclist
# ユーザを指定してヤマレコに登録されている記録を取得する

require 'net/http'
require 'json'

Net::HTTP.version_1_2

Host = 'www.yamareco.com'
if ARGV[0] then userID = ARGV[0].to_s else userID= '4541' end
maxpage = 20

(1..maxpage).each do |page|
  path = '/api/v1/getReclist/user/' + userID + '/' + page.to_s

  Net::HTTP.start(Host, 80) do |http|
    response = http.get(path)
    js = JSON.parse(response.body)
    if js["err"] == 1 then break
    else
      js["reclist"].each do |rec|
      puts rec["start"] + ' : ' + rec["place"] + '('  + rec["rec_id"] + ')'
      end
    end  
  end
end

#課題
#　デフォルトをなしにして公開



