require 'zip/zip'

class Unzipper

  def initialize(file)
    @file = file
  end

  def file
    @file
  end

  def unzip(destination)
    Zip::ZipFile.open(@file) do |zip_file|
      zip_file.each do |f|
        f_path = File.join(destination, f.name)
        FileUtils.mkdir_p(File.dirname(f_path))
        zip_file.extract(f, f_path) unless File.exists?(f_path)
      end
    end
  end

end

test = Unzipper.new("kabradarf-2012-9.zip")
puts test.file

test.unzip("/test")