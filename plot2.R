# 
# Exploratory Data Analysis: Assignment 1
# Plot 2

# Variable specifying the location of the data file
data_location <- 'household_power_consumption.zip'

# Read in the data file; this is accomplished without unzipping the file
# to save space. Optimization guidelines provided in the earlier R
# Programming Course are observed (e.g., specify colClasses and nrows) although
# due to missing values (specified as "?" in file) all columns end up being
# character and are converted as needed below.
#
# This could have been done remotely (i.e., accessing the zip file from the
# provided URL) but I opted to do it locally instead.
#
dat <- read.table(  unz(data_location, "household_power_consumption.txt")
                    , sep=';'
                    , header=TRUE
                    , colClasses=c('character', 'character', 'character'
                                   , 'character', 'character', 'character'
                                   , 'character', 'character', 'character')
                    , nrows=2075259
                    , comment.char = "")

# Transform the Date variable into a proper date format
dat <- transform(dat, Date = as.Date(Date, format='%d/%m/%Y'))

# Subset to include only those data from the date range we require; I instead
# could have read only those lines corresponding to these dates (e.g., using
# nrows and skip in the call to read.table()) but I felt this was more
# transparent.
dat <- subset(dat, Date >= as.Date("2007-02-01", format='%Y-%m-%d') 
              & Date <= as.Date("2007-02-02", format='%Y-%m-%d'))

# Convert the variables to be plotted from character to numeric; this technically
# could have been done below within the call to hist(), but this seems cleaner
dat <- transform(dat, Global_active_power=as.numeric(Global_active_power))

# Create a Date/Time object called datetime by combining the Date and Time
# columns.
dat$datetime <- as.POSIXlt(paste(dat$Date, dat$Time, sep=' '))

# Initialize a PNG device with the height and width specified in the assignment
png(file='plot2.png', width=480, height=480)

# Output the plot
with(dat, plot(datetime
                , Global_active_power
                , type='l'
                , ylab='Global Active Power (kilowatts)'
                , xlab=''))

# Close the graphic device
dev.off()