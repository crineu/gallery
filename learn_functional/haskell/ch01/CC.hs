-- file: ch01/CC.hs

main = interact characterCount
    where characterCount input = show (length (characters input)) ++ "\n"
