module Buildo
  module Helpers
    def empty_directory_with_keep_file(destination)
      empty_directory(destination, {})
      keep_file(destination)
    end

    def keep_file(destination)
      create_file(File.join(destination, '.keep'))
    end

    def configure_environment(rails_env, config)
      inject_into_file(
        "config/environments/#{rails_env}.rb",
        "\n  #{config}",
        before: "\nend"
      )
    end

    def replace_in_file(relative_path, find, replace)
      path = File.join(destination_root, relative_path)
      contents = IO.read(path)
      unless contents.gsub!(find, replace)
        raise "#{find.inspect} not found in #{relative_path}"
      end
      File.open(path, "w") { |file| file.write(contents) }
    end
  end
end
