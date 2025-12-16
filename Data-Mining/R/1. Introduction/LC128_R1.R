# Read File dari CSV

score_data <- read.csv("Score.csv")
weight_data <- read.csv("ScoreWeight.csv")

# Join atau merging data dari kedua file .csv by CourseCode-nya

merged_data <- merge(score_data, weight_data, by = "Course.Code")

# Menghitung nilai berdasarkan bobot

merged_data$TotalScore <- with(merged_data, 
                               Assignment.x * Assignment.y + 
                                 Mid.Exam.x * Mid.Exam.y + 
                                 Final.Exam.x * Final.Exam.y)

# Menentukan grade berdasarkan total score sebelumnya

merged_data$Grade <- cut(merged_data$TotalScore, 
                         breaks = c(-Inf, 65, 70, 75, 80, 85, 90, 100),
                         labels = c("D", "C", "B-", "B", "B+", "A-", "A"))

# Membuat data

result_data <- merged_data[, c("Student.Name", "TotalScore", "Grade")]

# Save file ke .csv

write.csv(result_data, "Result.csv", row.names = FALSE)


# Karena code seharusnya sudah benar, maka hasil tersebut seharusnya juga sudah benar.

