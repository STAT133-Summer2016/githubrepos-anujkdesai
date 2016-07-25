scored <- c(14, 14, 9, 14, 28, 13, 13, 24, 17, 6, 24, 0, 24, 13, 26, 14)
against <- c(19, 30, 16, 38, 31, 24, 23, 30, 41, 13, 20, 52, 13, 31, 24, 47)

# How many points did the raiders score in game 7?
scored[7]
# What was the score of the first 5 games?
scored[c(1, 2, 3, 4, 5)]
# What were the scores of the even games? Try to do this problem without typing in c(2,4,…)
scored[c(FALSE, TRUE)]
# What was the score of the last game? Try to do this problem without typing in the number of the last game.
scored[length(scored)]
# Select the scores higher than 14.
scored[scored > 14]
# Select the scores equal to 14.
scored[scored == 14]
# Select the scores equal to 13 or 14.
scored[scored == 13 | scored == 14]
# Select the scores between between 7 and 21 points.
scored[scored >= 7 & scored <= 21]
# Sort the scores in decreasing order.
sort(scored, decreasing = TRUE)
# What was the highest score achieved?
max(scored)
# What was the lowest score achieved?
min(scored)
# What was the average score?
mean(scored)
# Use the summary() function to give some summary statistics.
summary(scored)
# In how many games did the Raiders score over 20 points?
length(scored[scored > 20])
# PART 2
# What was the sum of the scores in game 7?
scored[7] + against[7]
# What was the sum of the scores in the last 5 games?
sum_scored <- scored[c(length(scored) - 4, length(scored) - 3, length(scored) - 2, length(scored) - 1, length(scored))]
sum_against <- against[c(length(against) - 4, length(against) - 3, length(against) - 2, length(against) - 1, length(against))]
sum_scored + sum_against
# What was the difference in scores in the odd games?
scored[c(TRUE, FALSE)] - against[c(TRUE, FALSE)]
# Which games did the Raiders win?
scored - against > 0
# Were there any ties?
scored - against == 0