class LogParserController

    def initialize
        @log_file = LogFile.new
        @current_view = FileDialogView.new
        # @current_view.clear_display
        # @current_view.set_cursor
        # @current_view.clear_and_cursor
        @current_view.display @log_file
    end

    
    def run
        # while true do
        #     @current_view.display
        #     break
        # end

        while user_input = $stdin.getch do
            # process the input
            begin
                while next_chars = $stdin.read_nonblock(10) do
                    user_input = "#{user_input}#{next_chars}"
                end
            rescue IO::WaitReadable
                # No code here, error just means we got all of the data
            end

            if @current_view.quittable? && user_input == 'q'
                break
            else
                parse_input user_input
            end
        end
    end

    def parse_input user_input
        case user_input
            when "\n"
                puts "[enter] was pressed"
            when "\e[A"
                # puts "[up] was pressed"
                case @current_view.class.to_s
                    when "FileDialogView"
                        file_dialog_move -1
                end
            when "\e[B"
                # puts "[down] was pressed"
                case @current_view.class.to_s
                    when "FileDialogView"
                        file_dialog_move 1                
                end
            when "\e[C"
                puts "[right] was pressed"
            when "\e[D"
                puts "[left] was pressed"
            else
                puts user_input
        end
    end

    def file_dialog_move increment
        @log_file.directory_index += increment
        if @log_file.directory_index < @log_file.list_start
            @log_file.list_start = @log_file.directory_index - $stdin.winsize[0] + 3
        elsif @log_file.directory_index > @log_file.list_start + $stdin.winsize[0] - 3
            @log_file.list_start = @log_file.directory_index
        end
        @current_view.update @log_file
    end
end