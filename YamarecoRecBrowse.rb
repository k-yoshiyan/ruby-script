#!/usr/bin/env ruby
# coding: utf-8
# レコードIDを指定してヤマレコに登録されている記録をFirefoxで表示する

if ARGV[0] != nil then recID = ARGV[0].to_s 
  else recID = "1315300"
end

`open -a "/Applications/Firefox.app" https://www.yamareco.com/modules/yamareco/detail-#{recID}.html`

#課題
# 標準入力からレコードIDを渡したい
