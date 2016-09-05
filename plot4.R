

setwd("/Users/Feng/Documents/AfterGraduationStudy/DataScienceSpecialization/04_ExploratoryDataAnalysis/ExploratoryDataAnalysis_HW_Project/ExploratoryDataAnalysis_W1_Project")


################ Data Manipulation ################
whole_data <- read.table(file = "household_power_consumption.txt", header = T, sep = ";", colClasses = "character")
names(whole_data)
filtered_data4 <- subset(whole_data,  Date == "1/2/2007"| Date == "2/2/2007")

for (i in 3:9) {
    filtered_data4[, i] <- as.numeric(filtered_data4[, i])
}

colSums(sapply(filtered_data4, function(x) x == "?"))
# The result shows that no missing value exists in the subset of the data.

# Generate the x axis data.
filtered_data4$Date_Time <- strptime(paste(filtered_data4$Date, filtered_data4$Time), 
                                     format = "%d/%m/%Y %H:%M:%S", tz = "")



################ Plotting ################

png(filename = "plot4.png")

par(mfrow = c(2, 2))

# Upper left plot
with(filtered_data4,
    plot(Date_Time, Global_active_power, type = "l",
         xlab = "", ylab = "Global Active Power"))

# Upper right plot
with(filtered_data4, plot(Date_Time, Voltage, type = "l", xlab = "datetime"))

# Lower left plot
with(filtered_data4, {
    #' Plot 1 line using the function plot and the other 2 lines using the function lines. 
    #' No need to set xaxt = "n" and add the tick marks and labels with function axis (as
    #' is in plot3.R) because the default annotations turn out to yield the desired results.
    plot(Date_Time, Sub_metering_1, type = "l", 
         xlab = "", ylab="Energy sub metering")
    lines(Date_Time, Sub_metering_2, col="red")
    lines(Date_Time, Sub_metering_3, col="blue")
    
    # Add the legend.
    legend("topright", lty = 1, col = c("black", "red", "blue"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           bty = "n", cex = 0.95)
})

# Lower right plot
with(filtered_data4, plot(Date_Time, Global_reactive_power, type = "l", xlab = "datetime"))


dev.off()



