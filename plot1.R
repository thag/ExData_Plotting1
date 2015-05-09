#Ram A May 9 2015

#Read the CSV file
DF <- read.csv("./data/household_power_consumption.txt",sep=";",header=TRUE)

#Subset the dates
DF2 <- subset(DF, as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-01") | as.Date(Date, "%d/%m/%Y") == as.Date("2007-02-02"))

#select one column and clean it up and convert
DF3 <- DF2[,"Global_active_power"]
DF3 <- gsub("?", "", DF3)   # remove ?
DF3 <- as.numeric(DF3)      # turn into numbers

#create the plot in a file device
png(file="plot1.png", width=480, height=480)
hist(DF3, col="red", xlab = "Global Active Power (kilowatts)", main="Global Active Power")
dev.off()
