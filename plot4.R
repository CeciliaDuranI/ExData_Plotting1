url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile ="./electric.zip")

unzip("./electric.zip")

household <- read.csv("./household_power_consumption.txt", header = TRUE, sep = ";")


library(dplyr)
library(ggplot2)

household$Date <- as.Date(household$Date,format="%d/%m/%Y")
household_sub <- household %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

library(lubridate)

household_sub$datetime <- with(household_sub,ymd(Date)+hms(Time))

household_sub$datetime <- as.POSIXct(household_sub$datetime)

png(file="./plot4.png", width=480, height=480)

par(mfcol=c(2,2))

plot(as.POSIXct(household_sub$datetime),(as.numeric(household_sub$Global_active_power)),type = "l",ylab ="Global Active Power",xlab = " ")

plot(as.POSIXct(household_sub$datetime),(as.numeric(household_sub$Sub_metering_1)),type = "l",ylab ="Energy sub metering",xlab = " ")
lines(as.POSIXct(household_sub$datetime),(as.numeric(household_sub$Sub_metering_2)),col="red")
lines(as.POSIXct(household_sub$datetime),(as.numeric(household_sub$Sub_metering_3)),col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"), col=c("black","red", "blue"),lty=1:1,bty = "n")

plot(as.POSIXct(household_sub$datetime),(as.numeric(household_sub$Voltage)),type = "l",ylab ="Voltage",xlab = "datetime")

plot(as.POSIXct(household_sub$datetime),(as.numeric(household_sub$Global_reactive_power)),type = "l",ylab ="Global Reactive Power",xlab = "datetime") 

dev.off()