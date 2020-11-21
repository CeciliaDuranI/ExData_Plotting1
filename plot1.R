url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

download.file(url, destfile ="./electric.zip")

unzip("./electric.zip")

household <- read.csv("./household_power_consumption.txt", header = TRUE, sep = ";")


library(dplyr)

household$Date <- as.Date(household$Date,format="%d/%m/%Y")
household_sub <- household %>%
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

png(file="./plot1.png", width=480, height=480)

hist(as.numeric(household_sub$Global_active_power),col="red",main="Global Active Power",xlab= "Global Active Power (kilowatts)",ylab="Frequency")

dev.off()