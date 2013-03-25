['spec_helper', 'extractor', 'pry'].each { |x| require x }

describe Converter do

  subject(:converter) {
    Converter.new folderpath: "/temp"
  }



end