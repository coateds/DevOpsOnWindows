class AccountBook
    def initialize
        @ledger = []
        @current_total = 0
    end

    def add_money amount, memo = ""
        @ledger[@ledger.count] = [amount, memo]
        @current_total += amount
    end

    def subtract_money amount, memo = ""
        @ledger[@ledger.count] = [amount, memo]
        @current_total -= amount
    end

    def printout
        tab = 0
        puts "Amount:\tMemo:\tTotal:"
        @ledger.each do |line|
            tab += line[0]
            puts "#{line[0]}\t#{line[1]}\t#{tab}"
        end
    end
end