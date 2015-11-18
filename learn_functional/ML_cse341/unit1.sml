(*funcions*)
fun pow (x:int, y:int) =
    if y = 0
    then 1
    else x * pow(x, y-1)

fun cube(x:int) =
    pow (x, 3)

val ans = cube(4)


(*pairs example*)

fun swap (pr: int*bool) =
    (#2 pr, #1 pr)

fun sum_two_pairs (pr1: int*int, pr2: int*int) =
    (#1 pr1) + (#2 pr1) + (#1 pr2) + (#2 pr2)

fun div_mod (x: int, y:int) =
    (x div y, x mod y)

fun sort_pair (pr : int*int) =
    if (#1 pr) < (#2 pr)
    then pr
    else ((#2 pr),(#1 pr))

val b = swap((3, true))
val sp = sum_two_pairs((3,4),(8,4))
val dm = div_mod(89,17)