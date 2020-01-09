setClass("myDate")

setAs("character","myDate", function(from) as.Date(from, format="%d/%m/%Y") )

my_data <- read.table("data/household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('myDate','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

my_data <- subset(my_data, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

my_data <- my_data[complete.cases(my_data),]

hist(my_data$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")

my_data <- cbind(my_data, paste(my_data$Date, my_data$Time))

names(my_data)[10] <- "dateTime"

my_data$dateTime <- as.POSIXct(my_data$dateTime)

## Create Plot 4
par(mfcol=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(my_data, {
    plot(Global_active_power~dateTime, type="l", 
         ylab="Global Active Power", xlab="")
    plot(Sub_metering_1~dateTime, type="l",  
         ylab="Energy sub metering", xlab="")
    lines(Sub_metering_2~dateTime,col='Red')
    lines(Sub_metering_3~dateTime,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    plot(Voltage~dateTime, type="l", 
         ylab="Voltage", xlab="datetime")
    plot(Global_reactive_power~dateTime, type="l", 
         ylab="Global_reactive_power",xlab="datetime")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()