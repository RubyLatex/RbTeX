$out_file = ARGV[0]

OUT_DELIM = "\u00b6".encode('utf-8')

if $out_file
    File.new($out_file,"w").close
end

module Tex

    def Tex.print(latex, number)
        printToOutFile latex, number
    end

    def Tex.imath(math)
        return "$#{math}$"
    end

    def Tex.cmath(math)
        return "\\[#{math}\\]"
    end

    def Tex.center(latex)
        return "\\begin{center}#{latex}\\end{center}"
    end

    def Tex.printToOutFile(line, number)
        File.open($out_file, 'a') do |file|
            file.puts "#{line}#{OUT_DELIM}#{number}"
        end
    end

    class Table

        def initialize(twodee, rowlines=true)
            @array = twodee
            @rowlines = rowlines
        end

        def create
            pme = "\\begin{tabular}{|"
            i = 0
            while i < @array[0].length
                pme << "c|"
                i = i + 1
            end
            pme << "} "
            @array.each do |row|
                pme << "\\hline "
                rc = 0
                row.each do |elem|
                    pme << " #{elem} "
                    if rc < row.length - 1
                        pme << "&"
                    end
                    rc = rc + 1
                end
                pme << "\\\\ "
            end
            pme << "\\hline \\end{tabular}"
            return pme
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

    end

end
