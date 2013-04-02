require 'sgf_data'

module ASR

  class SGFController

    attr_reader :sgf

    def initialize
    end

    def create_sgf(filepath)
      @sgf ||= SGFData.new(filepath)
    end

    def clean_sgf
      if @sgf.nil?
        raise Exceptions::NoSGFDefined
      else
        @sgf.data = @sgf.clean_data
      end
    end

  end

end