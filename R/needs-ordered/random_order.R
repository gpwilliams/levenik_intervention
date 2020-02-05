set.seed(257215813)

lists <- 1:24
order <- sample(lists)

list_order <- data.frame(
  list = lists,
  order = order
)