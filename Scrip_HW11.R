#Homework 11. Batch Processing. 
#DPR. 
#10Apr2024
##############################
library(stringr)




####################

directory_path <- "/Users/danielpr23/Desktop/Computational Biology/DanielPenadosBio6100/NEON_count-landbird"
#Gather the names of the folder, and store them in a new vector 
source_folders <- list.dirs(directory_path, full.names = FALSE, recursive = FALSE)

# Define the folders where you want to search for the file
folders <- list.dirs(directory_path, full.names = FALSE, recursive = FALSE)


# Define the regular expression pattern to match the file
file_pattern <- "NEON.D01.BART.DP1.10003.001.brd_countdata..*\\.csv"  # Adjust the pattern as needed

# Define the destination folder where you want to store the found files
destination_folder <- "new_folder"

# Create the destination folder if it doesn't exist
if (!file.exists(destination_folder)) {
  dir.create(destination_folder)
}

# Loop through each folder
for (i in folders) {
  # List files in the current folder matching the pattern
  matching_files <- list.files(path = i, pattern = file_pattern, full.names = TRUE)
  
  # Check if any files match the pattern
  if (length(matching_files) > 0) {
    # Copy each matching file to the destination folder
    for (j in matching_files) {
      file.copy(j, file.path(destination_folder, basename(j)))
    }
  } else {
    cat("No files matching the pattern", file_pattern, "found in", folder, "\n")
  }
}
#-----------------------------------------------------
 #############################
 
 # Set the WD werre the file are. 
 directory <- "/Users/danielpr23/Desktop/Computational Biology/DanielPenadosBio6100/NEON_count-landbird/new_folder"
 
 # Create a list with the files in the working Directory
 files <- list.files(directory, pattern = "NEON.D01.BART.DP1.10003.001.brd_countdata..*\\.csv$", full.names = TRUE)
 
 # Create new variables and to store our data in the loop. 
 abundance <- 0
 richness <- c()
 
 # begin the loop. Looking to i in files. 
 for (i in files) {
   # I was not able to extract just the year from the file name, this was the closet i got. Deleting all not numeric values
   #year <- gsub("\\D", "", basename(file))
   data <- read.csv(i)
   # First in loop, eliminate row with NA values in the columns scientificName
   data <- data[complete.cases(data$scientificName), ]
   # Abundance is just the number of rows in the file
   abundance <- abundance + nrow(data)
   # Richness is the number of unique values in the scientificName colum
   richness <- c(richness, unique(data$scientificName))
   # Print results. 
   cat("File:", basename(i), "\n")
   cat("Abundance:", nrow(data), "\n")
   cat("Richness:", length(unique(data$scientificName)), "\n")
   cat("\n")
 }
 
 
 #-----------------------
 
 ################################################
 
 # Initialize an empty data frame to store results
 
 # Set the WD werre the file are. 
 directory <- "/Users/danielpr23/Desktop/Computational Biology/DanielPenadosBio6100/NEON_count-landbird/new_folder"
 
 # Create a list with the files in the working Directory
 files <- list.files(directory, pattern = "NEON.D01.BART.DP1.10003.001.brd_countdata..*\\.csv$", full.names = TRUE)
 
 results_df <- data.frame(File = character(),
                          Abundance = numeric(),
                          Richness = numeric(),
                          stringsAsFactors = FALSE)
 
 # Loop through each CSV file
 for (file in files) {
   # Extract the year from the file name
   year <- as.numeric(gsub("\\D", "", basename(file)))
   
   # Read the CSV file
   data <- read.csv(file)
   
   # Eliminate rows with NA values in the "scientificName" column
   data <- data[complete.cases(data$scientificName), ]
   
   # Calculate abundance (number of rows)
   abundance <- nrow(data)
   
   # Calculate richness (number of unique scientific names)
   richness <- length(unique(data$scientificName))
   
   # Add the results to the data frame
   results_df <- rbind(results_df, data.frame(File = basename(file),
                                              Abundance = abundance,
                                              Richness = richness))
 }
 
 # Print the results data frame
 print(results_df)
 