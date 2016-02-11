require 'logix'
require 'pry'

client = Logix::Client.new(password: ENV['LOGIX_PASSWORD'], endpoint: ENV["LOGIX_FQDN"], certificate: File.read(File.expand_path(ENV["LOGIX_CERTIFICATE"])) , private_key: File.read(File.expand_path(ENV["LOGIX_PRIVATE_KEY"])))
client.login!

response = client.mt940_download(data_type: 'oldMT940', start_date: Date.new(2016,2,1), end_date: Date.today)

binding.pry
