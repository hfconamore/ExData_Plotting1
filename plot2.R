


setwd("/Users/Feng/Documents/AfterGraduationStudy/DataScienceSpecialization/04_ExploratoryDataAnalysis/ExploratoryDataAnalysis_HW_Project/ExploratoryDataAnalysis_W1_Project")

################ Data Manipulation ################
con <- file('household_power_consumption.txt', open = "r")
filtered_lines <- vector()
i <- 1

#' Read the data from just those dates rather than reading in the entire dataset 
#' and subsetting to those dates.
# If the connection is open it is read from its current position. 
while (length(oneLine <- readLines(con, n = 1, warn = FALSE)) > 0) {
    if (grepl('^([12]/2/2007)', oneLine)) {
        filtered_lines[i] <- oneLine
        i <- i + 1
    }
} 

close(con)

# Separate each observation by ";" and create a data frame to store the data.
filtered_list <- sapply(filtered_lines, strsplit, ";")
filtered_data2 <- data.frame(matrix(unlist(filtered_list), nrow = 2880, byrow = T),
                             stringsAsFactors = FALSE)
names(filtered_data2) <- unlist(strsplit(readLines("household_power_consumption.txt", n = 1), split = ";"))

for (i in 3:9) {
    filtered_data2[, i] <- as.numeric(filtered_data2[, i])
}


colSums(sapply(filtered_data2, function(x) x == "?"))
# The result shows that no missing value exists in the subset of the data.

# Generate the x axis data.
library(lubridate)
filtered_data2$Date_Time <- dmy_hms(paste(filtered_data2$Date, filtered_data2$Time))


################ Plotting ################
png(filename = "plot2.png")

# Plot the data but hide x tick marks in the first place.
plot(filtered_data2$Date_Time, filtered_data2$Global_active_power, type = "l",
     xlab = "", xaxt="n", ylab = "Global Active Power (kilowatts)")

# Add back the customized x tick marks.
axis(side = 1, 
     at = c(min(filtered_data2$Date_Time), median(filtered_data2$Date_Time), max(filtered_data2$Date_Time)),
     labels = c("Thu", "Fri", "Sat"), tick = TRUE)

dev.off()



