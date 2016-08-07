library(readr)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rvest)
library(stringr)

lingData <- read_delim("data/lingData.txt", delim = " ")
load("data/question_data.RData")

# State Abbreviations
url <- "http://www.50states.com/abbreviations.htm"
xpath = '//table[@class="spaced stripedRows"]'
abbreviations <- url %>% 
  read_html() %>% 
  html_nodes(xpath = xpath) %>% 
  html_table(fill = TRUE) %>% 
  as.data.frame() %>% 
  select(region = 1, STATE = 2) %>% 
  mutate(region = str_to_lower(region))

# States lat/long data for geom_polygon()
usa <- map_data("state") %>% 
  select(-subregion)

# answers data frame
# convert letter choice to number to join with lingData
answer <- data.frame(do.call('rbind', all.ans)) %>% 
  mutate(ans.let = as.integer(ans.let))

# Gather question columns into one long column "question"
# Join with answers data based on question number and answer choice
lingData <- lingData %>% 
  gather(question, answer, Q050:Q121) %>% 
  select(-ZIP, -CITY, -ID) %>% 
  mutate(qnum = as.numeric(str_extract_all(question, "[0-1]?[0-9]{2}"))) %>% 
  rename(ans.let = answer) %>% 
  inner_join(answer)

# Final cleaned data frame joined with states data
# group by STATE & question to create counts of each answer by state
# join with abbreviations data to remove rows not in the US
# filter to include only the most common answer by state
# filter out rows that are not part of contiguous United States
# join with states data for lat and long coordinates of each state
# join with quest.use to convert qnum to actual survey question
# join with answer data frame to retrieve most common answer choice
lingData_cleaned <- lingData %>% 
  group_by(STATE, qnum) %>% 
  count(ans.let) %>% 
  inner_join(abbreviations) %>% 
  filter(STATE != "HI" & STATE != "AK") %>% 
  filter(n == max(n)) %>% 
  inner_join(usa) %>% 
  ungroup() %>% 
  right_join(quest.use) %>% 
  select(-STATE) %>% 
  inner_join(answer)

# Write to csv file
write_csv(lingData_cleaned, "data/lingData_cleaned.csv")