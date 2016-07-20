# Script to clean and join lifeexpectancy.csv, population.csv, and gdppc.csv
# Write to 'cleaned_demographics.csv'
library(readr)
library(stringr)
library(dplyr)
library(tidyr)
library(rvest)
library(lubridate)

expectancy <- read_csv("lifeexpectancy.csv")
population <- read_csv("population.csv")
gdp <- read_csv("gdppc.csv")

expectancy <- expectancy %>% 
  filter(rowSums(is.na(expectancy)) < length(expectancy) - 1) %>% 
  rename(country = `Life expectancy with projections. Yellow is IHME`) %>% 
  gather(year, lifeexpectancy, `1800.0`:`2015.0`) %>% 
  arrange(country)

population <- Filter(function(x) !all(is.na(x)), population) %>% 
  filter(rowSums(is.na(population)) < length(population) - 1) %>% 
  rename(country = `Total population`) %>% 
  gather(year, population, `1800.0`:`2015.0`) %>% 
  arrange(country)

gdp <- gdp %>% 
  filter(rowSums(is.na(gdp)) < length(gdp) - 1) %>% 
  rename(country = `GDP per capita`) %>% 
  gather(year, gdp, `1800.0`:`2015.0`) %>% 
  arrange(country)

# Region Codes
url <- "https://docs.google.com/spreadsheets/u/1/d/1OxmGUNWeADbPJkQxVPupSOK5MbAECdqThnvyPrwG5Os/pub?gid=1#"
xpath = '//table[@class="waffle"]'
region_codes <- url %>% 
  read_html() %>% 
  html_nodes(xpath = xpath) %>% 
  .[2] %>% 
  html_table(fill = TRUE) %>% 
  as.data.frame() %>% 
  slice(-1) %>% 
  select(2:3)
names(region_codes) <- c("country", "Group")

# Uncleaned data frame of country, expectancy, population, 
# gdp, region codes, decade
full <- left_join(expectancy, population) %>% 
  left_join(gdp) %>% 
  left_join(region_codes) %>% 
  filter(!is.na(Group)) %>% 
  mutate(decade = str_c(str_extract(year, "^[0-9]{3}"), "0"))

# Compute mean for each decade
means <- full %>% 
  group_by(country, decade) %>% 
  summarise(pop = mean(population, na.rm = TRUE))

# Join table of means with data frame
cleaned <- left_join(full, means) %>% 
  mutate(population = ifelse(is.na(population), pop, population)) %>% 
  select(1:6) %>% 
  mutate(year = year(years(year))) %>% 
  mutate(population = ifelse(is.nan(population), NA, population)) %>% 
  mutate(Group = factor(Group))

write.csv(cleaned, "cleaned_demographics.csv")
