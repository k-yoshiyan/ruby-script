# coding: utf-8
#ユーザを指定してヤマレコに登録されている記録を取得する
# -*- coding: utf-8 -*-

require 'net/http'
require 'json'

Net::HTTP.version_1_2

Host = 'www.yamareco.com'
userID = '4541' # yoshiyan
maxpage = 14

header = {"Authorization" => "OAuth xxxxx"}

(1..maxpage).each do |page|
  path = '/api/v1/getReclist/user/' + userID + '/' + page.to_s

  Net::HTTP.start(Host, 80) do |http|
    response = http.get(path, header)
    js = JSON.parse(response.body)

    js["reclist"].each do |rec|
      puts rec["start"] + ' : ' + rec["place"] + '('  + rec["rec_id"] + ')'
    end
  end
end


