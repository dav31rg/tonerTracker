# frozen_string_literal: true

require 'nokogiri'
require 'open-uri'
require 'csv'
require 'date'

# list of webs
printer_webs = [
  '/mnt/c/prueba-web/test-web/prueba.html',
  '/mnt/c/prueba-web/test-web/prueba1.html',
  '/mnt/c/prueba-web/test-web/prueba2.html',
  '/mnt/c/prueba-web/test-web/prueba3.html'
]

# CSV archive
csv_archive = 'data.csv'
today = Date.today

printer_webs.each do |printer_web|
  printer_name = File.basename(printer_web, '.html')

  begin
    html = open(printer_web)
    doc = Nokogiri::HTML(html)
    toner = doc.at_css('li#TonerSupplies div span.dataText:first-child').text
    drum = doc.at_css('li#PCDrumStatus div.progress-slider span.dataText').text
    fuser = doc.at_css('li#FuserSuppliesStatus div.progress-slider span.dataText').text
    new_data = [today, printer_name, toner, drum, fuser]
  rescue OpenURI::HTTPError
    new_data = [today, printer_name, 'no available', 'no available', 'no available']
  end

  CSV.open(csv_archive, 'a') do |csv|
    csv << new_data
  end

  puts new_data.inspect
end
