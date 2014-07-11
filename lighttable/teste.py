table = [
         [1, 3, 4],
         [5, 0, 0],
         [2, 2, 2],
        ]

print table

min = 100
max = 0

for row in table:
  for element in row:
    if min > element:
      min = element
    if max < element:
      max = element

  print min
  print max



