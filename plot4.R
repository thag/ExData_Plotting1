#Ram A May 9 2015

#Read the CSV file
DF <- read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE)

#Subset the dates
DF2 <- subset(DF, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-02"))

#create the file device and structure
png(file="plot4.png", width=480, height=480)
par(mfrow = c(2,2), mar=c(4,4,2,1), oma=c(0,0,3,0)) #one row, two column

#Global_active_power - plot1.R
    DF3 <- DF2[, c("Date","Time","Global_active_power")]
    DF3$Global_active_power <- as.numeric(levels(DF3$Global_active_power))[DF3$Global_active_power]      # turn into numbers
    DF3 <- subset(DF3, Global_active_power != "?")
    ok <- complete.cases(DF3$Global_active_power)
    DF3 <- DF3[ok,]
    DF3$DateTime <- paste(DF3$Date, DF3$Time)
    DF3 <- DF3[,c("DateTime","Global_active_power")]
    DF3$DateTime <- strptime(DF3$DateTime, "%d/%m/%Y %H:%M:%S")
    #write the plot
    with(DF3, plot(DateTime, Global_active_power, type = "l" ,xlab="", ylab = "Global Active Power"))


#Voltage
    DF3 <- DF2[, c("Date","Time","Voltage")]
    DF3$Voltage <- as.numeric(levels(DF3$Voltage))[DF3$Voltage]      # turn into numbers
    DF3 <- subset(DF3, Voltage != "?")
    ok <- complete.cases(DF3$Voltage)
    DF3 <- DF3[ok,]
    DF3$DateTime <- paste(DF3$Date, DF3$Time)
    DF3 <- DF3[,c("DateTime","Voltage")]
    DF3$DateTime <- strptime(DF3$DateTime, "%d/%m/%Y %H:%M:%S")
    #write the plot
    with(DF3, plot(DateTime, Voltage, type = "l", xlab="datetime"))


#Energy - plot3.R
    DF3 <- DF2[, c("Date","Time","Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
    DF3$Sub_metering_1 <- as.numeric(levels(DF3$Sub_metering_1))[DF3$Sub_metering_1]      # turn into numbers
    DF3 <- subset(DF3, Sub_metering_1 != "?")
    ok <- complete.cases(DF3$Sub_metering_1)
    DF3 <- DF3[ok,]
    DF3$Sub_metering_2 <- as.numeric(levels(DF3$Sub_metering_2))[DF3$Sub_metering_2]      # turn into numbers
    DF3 <- subset(DF3, Sub_metering_2 != "?")
    ok <- complete.cases(DF3$Sub_metering_2)
    DF3 <- DF3[ok,]
    
    DF3$DateTime <- paste(DF3$Date, DF3$Time)
    DF3 <- DF3[,c("DateTime","Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
    DF3$DateTime <- strptime(DF3$DateTime, "%d/%m/%Y %H:%M:%S")
    
    #Write the plot
    with(DF3,plot(DateTime, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering"))
    with(DF3,lines(DateTime, Sub_metering_2, type = "l", col="red"))
    with(DF3,lines(DateTime, Sub_metering_3, type = "l" , col="blue"))
    legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

#Global Reactive Power
    DF3 <- DF2[, c("Date","Time","Global_reactive_power")]
    DF3$Global_reactive_power <- as.numeric(levels(DF3$Global_reactive_power))[DF3$Global_reactive_power]      # turn into numbers
    DF3 <- subset(DF3, Global_reactive_power != "?")
    ok <- complete.cases(DF3$Global_reactive_power)
    DF3 <- DF3[ok,]
    DF3$DateTime <- paste(DF3$Date, DF3$Time)
    DF3 <- DF3[,c("DateTime","Global_reactive_power")]
    DF3$DateTime <- strptime(DF3$DateTime, "%d/%m/%Y %H:%M:%S")
    #write the plot
    with(DF3, plot(DateTime, Global_reactive_power, type = "l", xlab="datetime"))

dev.off()
