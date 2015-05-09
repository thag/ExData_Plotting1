#Ram A May 9 2015

#Read the CSV file
DF <- read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE)

#Subset the dates
DF2 <- subset(DF, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-02"))

#select three columns
DF3 <- DF2[, c("Date","Time","Global_active_power")]

#convert factor to numeric and clean it up
DF3$Global_active_power <- as.numeric(levels(DF3$Global_active_power))[DF3$Global_active_power]      # turn into numbers
DF3 <- subset(DF3, Global_active_power != "?")
ok <- complete.cases(DF3$Global_active_power)
DF3 <- DF3[ok,]

#merge date and time colums, and convert it to a POSIX format
DF3$DateTime <- paste(DF3$Date, DF3$Time)
DF3 <- DF3[,c("DateTime","Global_active_power")]
DF3$DateTime <- strptime(DF3$DateTime, "%d/%m/%Y %H:%M:%S")

#create the plot in a file device
png(file="plot2.png", width=480, height=480)
with(DF3, plot(DateTime, Global_active_power, type = "l" ,xlab="Day", ylab = "Global Active Power (kilowatts)"))
dev.off()



#-------------
#Ignore the below section
#References
#http://www.biostat.jhsph.edu/~rpeng/UCLAWorkshop/cheatsheet.pdf
#http://stat.ethz.ch/R-manual/R-patched/library/base/html/strptime.html
#?as.Date
#da <- "01/02/2007"
#weekdays(as.Date(da, "%d/%m/%Y"))
#as.Date(da , "%d/%m/%Y") == as.Date("2007-02-01")
#head(DF)
#names(DF)
#DF4 <- DF3[1:5,]
#DF4
#plot(Global_active_power ~ Date, DF4, type="l")
#lines(DF4$Global_active_power, type="l")

## read in date/time info in format 'm/d/y h:m:s'
#dates <- c("02/27/92", "02/27/92", "01/14/92", "02/28/92", "02/01/92")
#times <- c("23:03:20", "22:29:56", "01:03:30", "18:21:03", "16:56:26")
#x <- paste(dates, times)
#strptime(x, "%m/%d/%y %H:%M:%S")