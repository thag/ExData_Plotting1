#Ram A May 9 2015

#Read the CSV file
DF <- read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE)

#Subset the dates
DF2 <- subset(DF, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-02"))

#select colums, conversions and cleaning
DF3 <- DF2[, c("Date","Time","Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
DF3$Sub_metering_1 <- as.numeric(levels(DF3$Sub_metering_1))[DF3$Sub_metering_1]      # turn into numbers
DF3 <- subset(DF3, Sub_metering_1 != "?")
ok <- complete.cases(DF3$Sub_metering_1)
DF3 <- DF3[ok,]
DF3$Sub_metering_2 <- as.numeric(levels(DF3$Sub_metering_2))[DF3$Sub_metering_2]      # turn into numbers
DF3 <- subset(DF3, Sub_metering_2 != "?")
ok <- complete.cases(DF3$Sub_metering_2)
DF3 <- DF3[ok,]

#merge date and time colums, and convert it to a POSIX format
DF3$DateTime <- paste(DF3$Date, DF3$Time)
DF3 <- DF3[,c("DateTime","Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]
DF3$DateTime <- strptime(DF3$DateTime, "%d/%m/%Y %H:%M:%S")

#create the plot in a file device
png(file="plot3.png", width=480, height=480)

with(DF3,plot(DateTime, Sub_metering_1, type = "l", xlab="", ylab="Energy sub metering"))
with(DF3,lines(DateTime, Sub_metering_2, type = "l", col="red"))
with(DF3,lines(DateTime, Sub_metering_3, type = "l" , col="blue"))
legend("topright",legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

dev.off()



#-------------
#Ignore the below section
#References
#http://www.r-bloggers.com/adding-a-legend-to-a-plot/