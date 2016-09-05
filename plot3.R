

setwd("/Users/Feng/Documents/AfterGraduationStudy/DataScienceSpecialization/04_ExploratoryDataAnalysis/ExploratoryDataAnalysis_HW_Project/ExploratoryDataAnalysis_W1_Project")


################ Data Manipulation ################
whole_data <- read.table(file = "household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
names(whole_data)
filtered_data3 <- subset(whole_data,  Date == "1/2/2007"| Date == "2/2/2007")

for (i in 3:9) {
    filtered_data3[, i] <- as.numeric(filtered_data3[, i])
}

colSums(sapply(filtered_data3, function(x) x == "?"))
# The result shows that no missing value exists in the subset of the data.

# Generate the x axis data.
library(lubridate)
filtered_data3$Date_Time <- dmy_hms(paste(filtered_data3$Date, filtered_data3$Time))


################ Plotting ################
png(filename = "plot3.png")

with(filtered_data3, {
     # Create a blank plot and then fill in the 3 lines.
     plot(Date_Time, Sub_metering_1, type = "n",
          xlab = "", xaxt = "n", ylab = "Energy sub metering")
     lines(Date_Time, Sub_metering_1, col = "black")
     lines(Date_Time, Sub_metering_2, col = "red")
     lines(Date_Time, Sub_metering_3, col = "blue")
     
     # Try adding customized axis annotation.
     axis(side = 1, at = c(min(Date_Time), median(Date_Time), max(Date_Time)),
          labels = c("Thu", "Fri", "Sat"), tick = TRUE)
     legend("topright", lty = 1, col = c("black", "red", "blue"), 
            legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
})

dev.off()






