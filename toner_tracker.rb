# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'

# list of webs
webs = [
  '/mnt/c/prueba-web/test-web/prueba.html',
  '/mnt/c/prueba-web/test-web/prueba1.html',
  '/mnt/c/prueba-web/test-web/prueba2.html',
  '/mnt/c/prueba-web/test-web/prueba3.html'
]

webs.each_with_index do |web, index|
  # puts "Analizando pagina web #{index + 1}: #{web}"
  printer_name = File.basename(web, '.html')
  html = open(web)
  doc = Nokogiri::HTML(html)
  toner = doc.at_css('li#TonerSupplies div span.dataText:first-child').text
  drum = doc.at_css('li#PCDrumStatus div.progress-slider span.dataText').text
  fuser = doc.at_css('li#FuserSuppliesStatus div.progress-slider span.dataText').text

  puts "Datos para: #{index + 1} - #{printer_name}:"
  puts "El % de toner es: #{toner}"
  puts "El % de drum es: #{drum}"
  puts "El % de kit de mantenimiento es: #{fuser}"
end
