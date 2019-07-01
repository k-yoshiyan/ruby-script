#!/usr/bin/env ruby
# coding: utf-8
# 特定ユーザーのヤマレコに登録されている記録をランダムにSafariで表示する

rec_id_array = []


require 'net/http'
require 'json'

Net::HTTP.version_1_2

Host = 'api.yamareco.com'

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
       rec_id_array.push(rec["rec_id"])
      end
    end  
  end
end

recID = rec_id_array.sample

`open -a "/Applications/Safari.app" https://www.yamareco.com/modules/yamareco/detail-#{recID}.html`

#課題

