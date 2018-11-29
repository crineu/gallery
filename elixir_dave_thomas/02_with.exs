content = "Anything here, will be ignored by the inner scope function"

# ntp:x:87:87:Network Time Protocol:/var/lib/ntp:/bin/false
ntp_user = with {:ok, file}   = File.open("passwd.sample"),
                content       = IO.read(file, :all),
                :ok           = File.close(file),
                [_, uid, gid] = Regex.run(~r/ntp:.*?:(\d+):(\d+)/, content)
           do
                "Group #{gid}, User: #{uid}"
           end

IO.puts ntp_user
IO.puts content

# PATTERN MATCHING
# =  : if nothing is found, throws a (MatchError)
# <- : if it fails, returns the value that failed

# with [a, _] <- [1, 2, 3], do: a       # MatchError
# with [a, _] <- [1, 2, 3], do: a       # [1,2,3]
# with [a, _] <- nil, do: a       # nil

nil_if_not_found = with {:ok, file}   = File.open("passwd.sample"),
                        content       = IO.read(file, :all),
                        :ok           = File.close(file),
                        [_, uid, gid] <- Regex.run(~r/xxxx:.*?:(\d+):(\d+)/, content)
                   do
                        "Group #{gid}, User: #{uid}"
                   end

IO.puts inspect(nil_if_not_found)


# Shorter way of writing a with

values = [3, 7, 19]
mean = with count = Enum.count(values),
            sum   = Enum.sum(values),
       do:  sum/count

IO.puts mean
