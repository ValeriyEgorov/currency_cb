#  подключаем необходимые библиотеки
require 'net/http'
require 'uri'
require 'rexml/document'

# encoding: UTF-8
if Gem.win_platform?
  Encoding.default_external = Encoding.find(Encoding.locale_charmap)
  Encoding.default_internal = __ENCODING__

  [STDIN, STDOUT].each do |io|
    io.set_encoding(Encoding.default_external, Encoding.default_internal)
  end
end

code = [933, 840, 978]

uri = URI.parse("http://www.cbr.ru/scripts/XML_daily.asp")
response = Net::HTTP.get_response(uri)

doc = REXML::Document.new(response.body)

doc.elements.each("ValCurs/Valute") do |element|
  if code.include?(element.elements["NumCode"].text.to_i)
  puts "#{element.elements["Name"].text}: #{element.elements["Value"].text}"
  end
end