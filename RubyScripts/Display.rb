    def clear_display
        print "\e[2J"
    end

    def clear_and_cursor
        print "\e[2J\e[1;1H"
    end

    def set_cursor row = 1, column = 1
        # puts "#{row} and  #{column}"
        print "\033[#{row};#{column}H"
        # puts row.to_s + ", " + column.to_s
        # print "\033[2;2f"
        # tput cup row,column
    end

    # clear_display
    set_cursor 5, 5