class LogFile
    attr_accessor :file_name, :file_path, :log_entries, :directory, :directory, :directory_index, :log_entry_index, :list_start

    def initialize
        cd "/"
    end

    def cd path
        if Dir.exist?(path)
            @file_path = path
            @directory = Dir.new(@file_path)
            @directory_index = 0
            @list_start = 0
            true
        else
            false
        end
    end
end


class LogEntry

end