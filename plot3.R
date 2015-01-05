
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

#Draw plot3
png(file = "plot3.png")
plot(x=dat$DT, y=dat$Sub_metering_1, main = NULL, type = "l",xlab = "",col = "black",
     ylab = "Energy sub metering")
lines(x=dat$DT, y = dat$Sub_metering_2, type = "l",col="red")
lines(x=dat$DT, y = dat$Sub_metering_3, type = "l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"), lwd = 1)
dev.off()
#clear remaining variables
rm(dat,x)