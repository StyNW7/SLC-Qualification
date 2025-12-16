# Install Library

if (!require(arules)) install.packages("arules")
if (!require(arulesViz)) install.packages("arulesViz")
if (!require(dplyr)) install.packages("dplyr")

library(arules)
library(arulesViz)
library(dplyr)



# Membaca data dari CSV
header <- read.csv("Header.csv", stringsAsFactors = FALSE)
detail <- read.csv("Detail.csv", stringsAsFactors = FALSE)
items <- read.csv("items.csv", stringsAsFactors = FALSE)


# Cleaning data dulu (jika semisal ada NA langsung hapus row)


header_clean = na.omit(header)
detail_clean = na.omit(detail)
item_clean = na.omit(items)


# Joining atau merging data


# Penggabungan Detail.csv dengan Item.csv

detail_with_names <- merge(detail_clean, item_clean, by.x = "item_id", by.y = "id")

# Penggabungan data sebelumnya dengan Header.csv

transactions <- merge(detail_with_names, header_clean, by.x = "transaction_id", by.y = "header_id")





# Menggabungkan item berdasarkan transaction_id

transaction_list <- transactions %>%
  group_by(transaction_id) %>%
  summarize(items = paste(name, collapse = ","))


# Simpan data dalam format yang nantinya digunakan oleh algoritma apriori

write.csv(transaction_list, "transactions.csv", row.names = FALSE)
transactions_data <- read.transactions("transactions.csv", format = "basket", sep = ",")



# Apriori dan Association Rules


frequent_items <- apriori(transactions_data, parameter = list(supp = 0.05, target = "frequent itemsets"))

rules <- apriori(transactions_data, parameter = list(supp = 0.05, conf = 0.5, target = "rules"))



# Printing hasil

inspect(frequent_items)

inspect(rules)


