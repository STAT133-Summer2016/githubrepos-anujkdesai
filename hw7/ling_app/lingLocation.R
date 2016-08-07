library(ggplot2)
library(readr)
library(stringr)
library(tidyr)
library(dplyr)
library(scales)
library(plyr)

lingLocation <- read_delim("data/lingLocation.txt", delim = " ")
usa <- map_data("usa")

answer121 <- all.ans[[121]] %>% 
  mutate(answer = c("V462", "V463", "V464", "V465", "V466", "V467", "V468"))

answer120 <- all.ans[[120]] %>% 
  mutate(answer = c("V456", "V457", "V458", "V459", "V460", "V461"))

lingLocation121 <- lingLocation %>% 
  filter(Longitude > -125) %>% 
  gather(answer, n, V4:V471) %>% 
  filter(answer == "V462" | answer == "V463" | answer == "V464" | answer == "V465"
         | answer == "V466" | answer == "V467" | answer == "V468") %>% 
  inner_join(answer121) %>% 
  distinct(Latitude, Longitude, .keep_all = TRUE)

lingLocation120 <- lingLocation %>% 
  filter(Longitude > -125) %>% 
  gather(answer, n, V4:V471) %>% 
  filter(answer == "V456" | answer == "V457" | answer == "V458" | answer == "V459" |
           answer == "V460" | answer == "V461") %>% 
  inner_join(answer120) %>% 
  distinct(Latitude, Longitude, .keep_all = TRUE)

p <- ggplot() +
  geom_polygon(data = usa, aes(x = long, y = lat, group = group)) +
  geom_point(data = lingLocation121, 
             aes(x = Longitude, y = Latitude, color = ans)) +
  scale_color_discrete(label = wrap_format(20)) +
  coord_fixed(1.3) +
  theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.title = element_blank(),
    panel.background = element_blank()
  ) +
  labs(title = quest.use[[2]][67])

ggplot() +
  geom_polygon(data = usa, aes(x = long, y = lat, group = group)) +
  geom_point(data = lingLocation120, 
             aes(x = Longitude, y = Latitude, color = ans)) +
  scale_color_discrete(label = wrap_format(20)) +
  coord_fixed(1.3) +
  theme(
    axis.text = element_blank(),
    axis.line = element_blank(),
    axis.ticks = element_blank(),
    panel.border = element_blank(),
    panel.grid = element_blank(),
    axis.title = element_blank(),
    panel.background = element_blank()
  ) +
  labs(title = quest.use[[2]][66])