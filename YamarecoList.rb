# coding: utf-8
# ヤマレコAPI getReclist
# ユーザを指定してヤマレコに登録されている記録を取得する
# パラメータで -b があればfirefoxで開く、なければ標準出力に出す。

require 'net/http'
require 'json'

Net::HTTP.version_1_2

Host = 'www.yamareco.com'

userID = "4541"
if ARGV[0] == "-b" && ARGV[1] != nil then userID = ARGV[1].to_s end
if ARGV[1] == "-b" then userID = ARGV[0].to_s end
if ARGV[1] == nil then userID = ARGV[0].to_s end

maxpage = 40

if ARGV.include?("-b")
  then `open -a "/Applications/Firefox.app" https://www.yamareco.com/modules/yamareco/userinfo-#{userID}-data.html`
  
  else  
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

end

#課題 
#user名からuserIDを入手する


