class Coveralls
  # Method to require all ruby classes when calculating code coverage.
  # Call this to not leave untested files out of the code coverage percentages.
  def self.require_all_ruby_files(target_dirs=["/lib", "/app"])
    Array(target_dirs).collect do |target_dir|
      dir = "#{RAILS_ROOT}#{target_dir}/**/*.rb"
      Dir.glob(dir).each do |ruby_file|
        obj = ruby_file.split("#{target_dir}/",2).last.split(".rb").first 
        obj = obj.split("/",2).last if target_dir == "/app"
        begin
          # trigger the normal Rails mechanism to require files
          obj.classify.constantize
        rescue NameError, LoadError
          require obj
        end
      end
    end

  end

end
