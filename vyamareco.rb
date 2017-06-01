#!/usr/bin/ruby
# coding: utf-8
# vyamareco.rb
# ヤマレコの山行記録 idを指定してfireroxでその記録を開く

if ARGV[0] then
  recid = ARGV[0].to_s 
  `open -a "/Applications/Firefox.app" https://www.yamareco.com/modules/yamareco/detail-#{recid}.html`

else
  recid = '1082994'
  `open -a "/Applications/Firefox.app" https://www.yamareco.com/modules/yamareco/userinfo-4541-data.html`

end
