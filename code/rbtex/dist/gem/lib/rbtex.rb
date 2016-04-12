$out_file = ARGV[0]

OUT_DELIM = "\u00b6".encode('utf-8')

LOOP_START = "\#\#\#LOOP_START\#\#\#"
LOOP_END = "\#\#\#LOOP_END\#\#\#"

RBT_ENV_BEGIN = "\#\#\#RBT_ENV_BEGIN\#\#\#"
RBT_ENV_END = "\#\#\#RBT_ENV_END\#\#\#"

$pLoop = false

if $out_file
    File.new($out_file,"w").close
end

module Tex

    def Tex.print(latex, number, bundle=[])
        printToOutFile(latex, number, bundle)
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

    def Tex.n
        return "\\\\"
    end

    def Tex.logo
        return "$\\RbTeX$"
    end

    def Tex.printToOutFile(line, number, bundle)
        file = File.open($out_file, 'a')
        if bundle.length == 0
            file.puts "#{line}#{OUT_DELIM}#{number}"
        else
            case bundle[0]
            when "loop"
                $pLoop = true
                file.puts LOOP_START
            when "nloop"
                $pLoop = false
                file.puts LOOP_END
            when "rbtev"
                file.puts RBT_ENV_BEGIN
            when "nrbtev"
                file.puts RBT_ENV_END
            else
                file.puts $pLoop ? "#{line}" : "#{line}#{OUT_DELIM}#{number}"
            end
        end
        file.close
    end

    class Table

        def initialize(twodee, tabx=false)
            @array = twodee
            # @rowlines = rowlines
            @tabx = tabx
        end

        def create
            pme = "\\begin{#{@tabx ? "tabularx" : "tabular"}}#{@tabx ? "{\\textwidth}" : ""}{|"
            i = 0
            while i < @array[0].length
                pme << "#{@tabx ? "X|" : "c|"}"
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
            pme << "\\hline \\end{#{@tabx ? "tabularx" : "tabular"}}"
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
