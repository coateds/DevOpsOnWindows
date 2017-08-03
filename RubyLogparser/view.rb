class BasicView
    def clear_display
        print "\e[2J"
    end

    def clear_and_cursor
        print "\e[2J\e[1;1H"
    end

    def set_cursor
        print "e\[#{row};#{column}H"
    end

    # require 'io/console' has to go somewhere
    # G in the last line here will move the cursor X columns
    def center text
        columns = $stdin.winsize[1]
        text_length = text.length
        column_location = columns / 2 - text_length / 2
        "\e[#{column_location}G#{text}"
    end

    def red text
        "\e[31;40m#{text}\e[0m"
    end
end

# All subsequent classes inherit from the BasicView class ( < BasicView)

class FileDialogView < BasicView
    def display
        puts red(center("Select an Apache log file."))
    end

    def quittable?
        true
    end
end


class LogListView < BasicView

end


class SortFilterView < BasicView

end