# Install library ggplot2 (cukup advance, agar grafik lebih bagus dan lengkap)

if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)

# Read data dulu

anime_data <- read.csv("anime.csv")

# Saya memilih beberapa tipe informasi yang berbeda
# dengan grafik yang sesuai untuk menampilkan informasi tersebut

# 1. Grafik Distribusi Skor Anime

ggplot(anime_data, aes(x = score)) +
  geom_histogram(binwidth = 0.5, fill = "skyblue", color = "black") +
  labs(title = "Distribusi Skor Anime", x = "Score", y = "Jumlah Anime")

# 2. Grafik Jumlah Aniime berdasarkan jenisnya

ggplot(anime_data, aes(x = type, fill = type)) +
  geom_bar() +
  labs(title = "Jumlah Anime Berdasarkan Jenis", x = "Type", y = "Jumlah Anime") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

# 3. Grafik popularitas anime berdasarkan tahun rilis

ggplot(anime_data, aes(x = aired_from_year, y = popularity)) +
  geom_point(alpha = 0.5, color = "darkgreen") +
  labs(title = "Popularitas Anime Berdasarkan Tahun Rilis", x = "Tahun Rilis", y = "Popularitas") +
  scale_x_continuous(breaks = seq(min(anime_data$aired_from_year, na.rm = TRUE), 
                                  max(anime_data$aired_from_year, na.rm = TRUE), by = 5))

# 4. Grafik rata-rata skor anime berdasarkan genre

library(tidyr)
anime_genre <- separate_rows(anime_data, genre, sep = ", ")

# Rata-rata skor per genre

avg_score_per_genre <- aggregate(score ~ genre, data = anime_genre, FUN = mean, na.rm = TRUE)

# Visualisasi rata-rata skor per genre

ggplot(avg_score_per_genre, aes(x = reorder(genre, -score), y = score)) +
  geom_bar(stat = "identity", fill = "coral") +
  labs(title = "Rata-rata Skor Berdasarkan Genre", x = "Genre", y = "Rata-rata Skor") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))


# Jadi berdasarkan keempat grafik dan keempat jenis informasi yang ditampilkan tersebut
# Seharusnya sudah menjawab Soal "Data Visualization" dengan benar.

