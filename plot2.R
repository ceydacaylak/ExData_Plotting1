library(dplyr)
Sys.setlocale("LC_TIME", "English")

#read the data
data <- read.table("household_power_consumption.txt", sep = ";" , header = TRUE, na.strings="?")
head(data)
View(data)
colnames(data)

#format the date column
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')

data <- data %>% 
    filter(Date >= "2007/02/01", Date <= "2007/02/02")

datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)


plot(data$Global_active_power~data$Datetime, type = "l", 
     xlab = "",
     ylab = "Global Active Power (kilowatts)")

dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()
