class Box
    attr_accessor :length, :width, :height, :weight, :distance

    def initialize
        @@materials_cost = 0.01 #1 cent per square inch
        @@rate = 0.01 #1 cent per pound per mile
    end

    def self.rate= rate
        @@rate = rate
    end

    def self.materials_cost= cost
        @@materials_cost = cost
    end

    def package_cost
        (@length * @width * 2 + @length * @height *2 +
            @width * @height *2) * @@materials_cost + @weight *
            @distance * @@rate
    end
end