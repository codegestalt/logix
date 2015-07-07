require 'cmxl'

class MyFieldParser < Cmxl::Field
  self.tag = 86
  self.parser = /(?<message>.*)/
end
