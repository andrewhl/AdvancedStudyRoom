['zip/zip', 'fileutils'].each { |x| require x }

module ASR

  class SGFExtractor

    attr_reader :source_path, :target_path

    def initialize(args)
      @source_path = args[:source_path]
      @target_path = args[:target_path]
    end

    def extract_games
      Zip::ZipFile.open(source_path) do |zip_file|
        zip_file.each do |f|
          next if not File.basename(f.to_s).scan(/^\w+-\d+\.sgf|^\w+\.sgf/).empty?

          f_path = File.join(target_path, f.to_s)
          FileUtils.mkdir_p(File.dirname(f_path))
          zip_file.extract(f, f_path) unless File.exists?(f_path)
        end
      end

      Dir::glob(File.join(target_path, '**/*.sgf'))
    end

    def self.extract(zip_path, target)
      extractor = SGFExtractor.new(source_path: zip_path, target_path: target)
      extractor.extract_games
    end

  end
end
