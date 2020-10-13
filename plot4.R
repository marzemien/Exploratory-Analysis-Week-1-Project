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

par(mfrow = c(2, 2))
with(framz, plot(x = datetime, y = Global_active_power, type = "l", ylab = "Global active power"))
with(framz, plot(x = datetime, y = Voltage, type = "l"))
with(framz, 
     plot(x = datetime, y = Sub_metering_1, type = "l", ylab = "Energy sub metering"))
with(framz, 
     lines(datetime, Sub_metering_2, col = "red"))
with(framz, 
     lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", pch = 1, col = c("black", "red", "blue"), 
       legend = c("Sub metering 1", "Sub metering 2", "Sub metering 3"),
       cex = 0.75)
with(framz, plot(x = datetime, y = Global_reactive_power, type = "l", ylab = "Global reactive power"))
dev.copy(png, file = "plot4.png")
dev.off()

rm(framz)