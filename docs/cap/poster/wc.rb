\begin{rbtex}
def printWordCount
    numwords = `detex poster.tex | wc -w`
    Tex.print "This file contains #{numwords} words"
end
\end{rbtex}
