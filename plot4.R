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

#define the graph area first, then put all the graphs together
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(Global_active_power ~ Datetime, type = "l",
         xlab = "", ylab= "Global Active Power")
    plot(Voltage ~ Datetime, type = "l",
         xlab = "", ylab = "Voltage")
    plot(data$Sub_metering_1~data$Datetime, type = "l", 
         xlab = "",
         ylab = "Energy Sub Meetering")
    lines(data$Sub_metering_2~data$Datetime,col='Red')
    lines(data$Sub_metering_3~data$Datetime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, cex = 0.75,
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Global_reactive_power ~ Datetime, type = "l",
         xlab = "", ylab = "Global_reactive_power")
})


dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
