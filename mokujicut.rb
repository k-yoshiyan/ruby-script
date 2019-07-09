# coding: utf-8
# mokujicut.rb
# MS-Wordで作成された文書の目次からページを削除する

Encoding.default_external = 'UTF-8'

File.open("mokuji.txt", encording: "utf-8") do |f|
  f.each_line do |line|
    cols = line.chomp.split(/\t/)
    puts cols[0].to_s + "     " + cols[1].to_s
  end
end
