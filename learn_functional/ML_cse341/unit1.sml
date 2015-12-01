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

(* Lists *)
fun sum_list (xs: int list) =
    if null xs
    then 0
    else hd(xs) + sum_list(tl xs)

val sum = sum_list ([4, 1, 2, 3])

fun append (xs : int list, ys : int list) =
    if null xs
    then ys
    else (hd xs) :: append(tl xs, ys)

val penca = append([1, 2, 3], [10, 11, 12])

fun firsts (xs : (int * int) list) =
    if null xs
    then []
    else (#1 (hd xs))::(firsts(tl xs))

val bozo = firsts([(1,2), (3,4)])
