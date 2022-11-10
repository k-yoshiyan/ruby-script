# coding: utf-8

(1..254).each do |addr|
  res = `ping -c 1 -W 500 192.168.1.#{addr}`
  puts res
end
