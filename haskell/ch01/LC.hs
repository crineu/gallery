-- file: ch01/LC.hs

main = interact lineCount
    where lineCount input = show (length (lines input)) ++ "\n"
