library(googlesheets)
library(dplyr)
library(ggplot2)
library(ggthemes)
library(scales)
library(extrafont)

# Clear plot window
while (dev.cur()>1) dev.off()

# This is the key for the relevant Google Sheets
starSheet <- gs_key("1s0Eyl4VLgc0dFrBsJFnrq8o_ghwFk6OchLI7GRsKfuo")

# Load and cleanse the Google Sheets
flutter <- starSheet %>% gs_read(ws = "Flutter", range = "A1:B20")
flutter$Date <- as.Date(flutter$Date, format = "%m/%d/%Y")
flutter$project <- "Flutter"
colnames(flutter) <- c("date", "stars", "project")

# Now plot
ggplot(flutter, aes(date, stars)) +
  geom_line(aes(color = project)) +
  labs(title = "GitHub stars by date",
       caption = "Source: http://timqian.com/star-history/") + 
  scale_fill_fivethirtyeight() + 
  scale_x_date(date_breaks = "3 months",
               date_minor_breaks = "1 month",
               labels = date_format("%b %y")) + 
  scale_y_continuous(label = comma) +
  coord_cartesian(xlim = c(as.Date("2016/01/01"), as.Date("2018/06/17"))) + 
  theme_fivethirtyeight() + 
  theme(legend.position = "none", 
        plot.title = element_text(margin=margin(0,0,20,0)),
        plot.caption = element_text(size=9, margin=margin(20,0,0,0)),
        text=element_text(family="Open Sans"))