install.packages("tidyverse")
install.packages("haven")
install.packages("lubridate")
install.packages("purrr")

library(tidyverse)
library(haven)
library(lubridate)
library(purrr)


download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
              destfile = paste0(getwd(), "household_power_consumption"))

framz <- read.delim(paste0(getwd(),"/household_power_consumption.txt"), sep = ";", )
framz <- mutate(framz, datetime = paste(Date, Time))
framz[ ,1] <- dmy(framz[ ,1])
framz <- filter(framz, Date == "2007-02-01" | Date == "2007-02-02")
framz[ ,2] <- hms(framz[ ,2])
framz[ ,10] <- dmy_hms(framz[ ,10])
framz[ ,3:9] <- as.numeric(unlist(framz[ ,3:9]))

hist(framz$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowats)")
dev.copy(png, file = "plot1.png")
dev.off()

rm(framz)