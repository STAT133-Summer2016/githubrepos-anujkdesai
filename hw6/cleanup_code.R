# Script for cleaning style in dirty_code.R
# Write to 'mpg2-clean.csv'
library(dplyr)
library(rvest)
library(stringr)

mpg <- read.csv("mpg2.csv.bz2", stringsAsFactors = FALSE, strip.white = TRUE)
# Table scrape for car manafacturer country names
url <- "https://en.wikipedia.org/wiki/Automotive_industry"
xpath = '//table[@class="wikitable sortable"]'
manafacturer <- url %>% 
  read_html() %>% 
  html_nodes(xpath = xpath) %>% 
  .[2] %>% 
  html_table(fill = TRUE) %>% 
  as.data.frame() %>% 
  select(make = Make, country = Parent.Country)

mpg <- left_join(mpg, manafacturer) %>% 
  filter(!is.na(country) & !is.na(guzzler) & year >= 2000) %>% 
  select(-trans_dscr, -eng_dscr) %>% 
  mutate(vclass = str_replace_all(vclass, "Midsize-", ""),
         vclass = str_replace_all(vclass, " [0-9]WD", ""),
         guzzler = guzzler == "G")

write.csv(mpg, "mpg2-clean.csv")