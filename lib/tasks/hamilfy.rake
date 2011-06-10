require 'haml/html'
namespace :hamlfy do
  desc "Convert erb to Haml"
  task :convert => :environment do
    Dir["#{Rails.root}/app/views/**/*.erb"].each do |file_name|
      puts "Converting: #{file_name}"
      haml_file_name = file_name.gsub(/erb$/, "haml")
      if !File.exists?(haml_file_name)
        erb_string = File.open(file_name).read
        haml_string = Haml::HTML.new(erb_string, :erb => true).to_haml
        File.new(haml_file_name, 'w') do |f|
          f.write(haml_string)
        end
      end
      File.delete(file_name)
    end
  end
end
