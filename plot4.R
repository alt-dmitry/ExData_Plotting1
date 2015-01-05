
#Assuming the file is in your working directory.
#Otherwise add path to the file.
df <- read.csv("household_power_consumption.txt", sep=";")

#change data types from numeric to character
df <- transform(df, Date = as.character(Date), Time = as.character(Time))

#Concat date and time into a new column
df["DT"] <- paste(df$Date,df$Time, sep = " ")

#Create column with Date datatype
df["DateTime"] <- as.Date(df$DT, "%d/%m/%Y %H:%M:%S")

#subset data between the dates 2007-02-01 and 2007-02-02
#and clear df variable
dat <- subset(df, DateTime >= "2007-02-01" & DateTime <= "2007-02-02")
rm(df)

#Change factor to numeric datatype
for (x in seq(3,9)){
    dat[[x]] <- as.numeric(as.character(dat[[x]]))
}

#Create posixct column
dat[["DT"]] <- as.POSIXct(strptime(dat[["DT"]], '%d/%m/%Y %H:%M:%S', tz = "GMT")) 

#Draw plot4
png(file = "plot4.png")
par(mfrow=c(2,2))

plot(x=dat$DT, y=dat$Global_active_power, main = NULL, type = "l",
     ylab = "Global Active Power",col = "black", xlab = "")

plot(x=dat$DT, y=dat$Voltage, main = NULL, type = "l",
     ylab = "Voltage",col = "black", xlab = "datetime")

plot(x=dat$DT, y=dat$Sub_metering_1, main = NULL, type = "l",xlab = "",col = "black",
     ylab = "Energy sub metering")
lines(x=dat$DT, y = dat$Sub_metering_2, type = "l",col="red")
lines(x=dat$DT, y = dat$Sub_metering_3, type = "l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd = 1, bty = "n")

plot(x=dat$DT, y=dat$Global_reactive_power, main = NULL, type = "l",
     ylab = "Global_reactive_power",col = "black", xlab = "datetime")

dev.off()
#clear remaining variables
rm(dat,x)