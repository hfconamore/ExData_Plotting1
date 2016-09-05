
setwd("/Users/Feng/Documents/AfterGraduationStudy/DataScienceSpecialization/04_ExploratoryDataAnalysis/ExploratoryDataAnalysis_HW_Project/ExploratoryDataAnalysis_W1_Project")

################ Data Manipulation ################
con <- file('household_power_consumption.txt', open = "r")
filtered_data1 <- data.frame()

#' Read the data from just those dates rather than reading in the entire dataset 
#' and subsetting to those dates.

#' If the connection is open it is read from its current position. So in every
#' iteration the read.table function would read the next one line rather than 
#' read the whole txt file all over again.
while (length(oneLine <- read.table(con, nrows = 1, sep = ";", colClasses = "character")) > 0) {
    if (oneLine[1, 1] == "1/2/2007" | oneLine[1, 1] == "2/2/2007") {
        filtered_data1 <- rbind(filtered_data1, oneLine)
    }
    #' Because read.table takes time, the loop is set to break immediately after 
    #' the data needed have all been extracted.
    if (oneLine[1, 1] == "3/2/2007") {break}
} 

close(con)

names(filtered_data1) <- unlist(strsplit(readLines("household_power_consumption.txt", n = 1), split = ";"))

for (i in 3:9) {
    filtered_data1[, i] <- as.numeric(filtered_data1[, i])
}

colSums(sapply(filtered_data1, function(x) x == "?"))
# The result shows that no missing value exists in the subset of the data.


################ Plotting ################
png(filename = "plot1.png")
hist(filtered_data1$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power") 
dev.off()


