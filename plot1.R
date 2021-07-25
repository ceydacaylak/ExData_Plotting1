library(dplyr)
Sys.setlocale("LC_TIME", "English")

#read the data
data <- read.table("household_power_consumption.txt", sep = ";" , header = TRUE, na.strings="?")
head(data)
View(data)
colnames(data)

#format the date column
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data$Time <- strptime(paste(data$Date, data$Time), "%Y-%m-%d %H:%M:%S")


#filter the required range of time 
data <- data %>% 
    filter(Date >= "2007/02/01", Date <= "2007/02/02")

#first graph
data$Global_active_power <- as.numeric(data$Global_active_power)

hist(data$Global_active_power, main = "Global Active Power", 
     col = "red", xlab = "Global Active Power (kilowatts)",
     ylab = "Frequency")

dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()
