#####################
###   NUMBERS   #####
#####################
ZERO = lambda { |p| lambda { |x|           x      } }
ONE  = lambda { |p| lambda { |x|         p[x]     } }
TWO  = lambda { |p| lambda { |x|       p[p[x]]    } }
THREE= lambda { |p| lambda { |x|     p[p[p[x]]]   } }
FIVE = lambda { |p| lambda { |x| p[p[p[p[p[x]]]]] } }

# FIFTEEN = lambda { |p| lambda { |x| p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]] } }
# HUNDRED = lambda { |p| lambda { |x| p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[p[x]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]]] } }

FOUR    = lambda { |x| TWO[TWO[x]] }
TEN     = lambda { |x| FIVE[TWO[x]] }
FIFTEEN = lambda { |x| FIVE[THREE[x]] }
HUNDRED = lambda { |x| TEN[TEN[x]] }

#####################
###   BOOLEANS   ####
#####################
TRUE_  = lambda { |x| lambda { |y| x } }
FALSE_ = lambda { |x| lambda { |y| y } }

IF = lambda { |b| b }

#####################
###  PREDICATES  ####
#####################
IS_ZERO = lambda { |n|
    n[lambda { |x| FALSE_ }][TRUE_]
}

#####################
# NUMERIC OPERATIONS#
#####################
INCREMENT = lambda { |n|
    lambda { |p|
        lambda { |x|
            p[n[p][x]]
        }
    }
}

DECREMENT = lambda { |n|
    lambda { |f|
        lambda { |x|
            n[lambda { |g| lambda { |h| h[g[f]] } }][lambda { |y| x }][lambda { |y| y }]
        }
    }
}

ADD      = lambda { |m| lambda { |n| n[INCREMENT][m] } }
SUBTRACT = lambda { |m| lambda { |n| n[DECREMENT][m] } }
MULTIPLY = lambda { |m| lambda { |n| n[ADD[m]][ZERO] } }
POWER    = lambda { |m| lambda { |n| n[MULTIPLY[m]][ONE] } }

IS_LESS_OR_EQUAL = lambda { |m|
    lambda { |n|
        IS_ZERO[SUBTRACT[m][n]]
    }
}

Z = lambda { |f|
    lambda { |x|
        f[lambda { |y| x[x][y] }]
    }[
        lambda { |x|
            f[lambda { |y| x[x][y] }]
        }
    ]
}

MOD = Z[lambda { |f| lambda { |m| lambda { |n|
    IF[IS_LESS_OR_EQUAL[n][m]][lambda { |x|
        f[SUBTRACT[m][n]][n][x]
    }
    ][
        m
    ]
} } }]

#####################
###    LISTS      ###
#####################
PAIR  = lambda { |x| lambda { |y| lambda { |f| f[x][y] } } }
LEFT  = lambda { |p| p[lambda { |x| lambda { |y| x } } ] }
RIGHT = lambda { |p| p[lambda { |x| lambda { |y| y } } ] }

EMPTY    = PAIR[TRUE_][TRUE_]
UNSHIFT  = lambda { |l| lambda { |x|
        PAIR[FALSE_][PAIR[x][l]]
    } }
IS_EMPTY = LEFT
FIRST    = lambda { |l| LEFT[RIGHT[l]] }
REST     = lambda { |l| RIGHT[RIGHT[l]] }

RANGE = Z[
    lambda { |f|
        lambda { |m| lambda { |n|
            IF[IS_LESS_OR_EQUAL[m][n]][
                lambda { |x|
                    UNSHIFT[f[INCREMENT[m]][n]][m][x]
                }
            ][
                EMPTY
            ]
        } }
    }
]

FOLD = Z[
    lambda { |f|
        lambda { |l| lambda { |x| lambda { |g|
            IF[IS_EMPTY[l]][
                x
            ][
                lambda { |y|
                    g[f[REST[l]][x][g]][FIRST[l]][y]
                }
            ]
        } } }
    }
]

MAP = lambda { |k| lambda { |f|
    FOLD[k][EMPTY][
        lambda { |l| lambda { |x|
            UNSHIFT[l][f[x]]
        } }
    ]
} }

#####################
###   STRINGS     ###
#####################
B   = TEN
F   = INCREMENT[B]
I   = INCREMENT[F]
U   = INCREMENT[I]
ZED = INCREMENT[U]

FIZZ     = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][I]][F]
BUZZ     = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[EMPTY][ZED]][ZED]][U]][B]
FIZZBUZZ = UNSHIFT[UNSHIFT[UNSHIFT[UNSHIFT[BUZZ][ZED]][ZED]][I]][F]

DIV = Z[
    lambda { |f| lambda { |m| lambda { |n|
        IF[IS_LESS_OR_EQUAL[n][m]][
            lambda { |x|
                INCREMENT[f[SUBTRACT[m][n]][n]][x]
            }
        ][
            ZERO
        ]
    } } }
]

PUSH = lambda { |l| lambda { |x|
      FOLD[l][UNSHIFT[EMPTY][x]][UNSHIFT]
} }

TO_DIGITS = Z[
    lambda { |f| lambda { |n| PUSH[
        IF[IS_LESS_OR_EQUAL[n][DECREMENT[TEN]]][
            EMPTY
        ][
            lambda { |x| f[DIV[n][TEN]][x] }
        ]
    ][MOD[n][TEN]] } }
]

###############################################################
###                      VICTORY!!!! (??)                   ###
###############################################################
MAP[RANGE[ONE][HUNDRED]][lambda { |n|
    IF[ IS_ZERO[MOD[n][FIFTEEN]] ][
        FIZZBUZZ
    ][IF[ IS_ZERO[MOD[n][THREE]] ][
        FIZZ
    ][IF[ IS_ZERO[MOD[n][FIVE]] ][
        BUZZ
    ][
        TO_DIGITS[n]
    ]]]
}]
