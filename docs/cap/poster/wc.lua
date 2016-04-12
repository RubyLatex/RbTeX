\begin{luacode}
function printWordCount()
    local exitcode = os.execute("detex ".."\jobname".." | wc -w > count.txt")
    if exitcode == 0 then
        local file = io.open("count.txt")
        if file ~= nil then
            tex.print(""..file:read())
            os.remove("count.txt")
            -- Now we have to read from the file :(
        end
    end
end
\end{luacode}
