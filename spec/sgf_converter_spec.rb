['spec_helper', 'extractor', 'pry'].each { |x| require x }

describe SGFConverter do

  subject(:converter) {
    ASR::Converter.new folderpath: "/temp"
  }



end