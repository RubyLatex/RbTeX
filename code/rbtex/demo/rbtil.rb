
module Rbt

    class Matrix

        def initialize(array)
            if depth(array) != 2
                raise ArgumentError, "A Matrix must be initialized with a 2D array"
            else
                @array = array
            end
        end

        def initialize(rows, cols)
            @rows = rows
            @cols = cols
            @array = Array.new(@rows, Array.new(@cols, 0))
        end

        def colSum col
            total = 0
            i = 0
            while i < @array.length
                total = total + @array[i][col]
                i = i + 1
            end
            return total
        end

        def rowSum row
            total = 0
            @array[row].each do |elem|
                total = total + elem
            end
        end

        def depth (a)
            return 0 unless a.is_a?(Array)
            return 1 + depth(a[0])
        end
    end

end
