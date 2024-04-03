#Homowerk10_ For loops and randomization tests
#DPR 
#3Arp2024

#Using a for loop, write a function to calculate the number of zeroes in a numeric vector. Before entering the loop, set up a counter variable counter <- 0. Inside the loop, add 1 to counter each time you have a zero in the vector. Finally, use return(counter) for the output.

x <- c(1, 0, 5, 0, 0, 8, 9, 0, 3, 0)

# Initialize a counter
counter <- 0

# Loop through each element of the vector
for (i in x) {
  if (i == 0) {
    counter <- counter + 1  # Increment counter if element is 0
  }
}

# Print the count
print(count)

#Use subsetting instead of a loop to rewrite the function as a single line of code.


# Count occurrences of 0 using subsetting
print(sum(x == 0))



matrix_function <- function(rows, cols) {
  x<-matrix(rep(0, rows*cols), nrow = rows, ncol = cols)  # Create a matrix of zeros with specified dimensions
  for (i in 1:nrow(x)) {
    for (j in 1:ncol(x)) {
      x[i, j] <- i * j  # Assign product of row number and column number to each element
    }
  }
  
  return(x)
  
}

rows <- 3
cols <- 4
result_matrix <- matrix_function(rows, cols)
print(result_matrix)


#Reshufle data function------------------

shuffle_data <- function(data) {
  data$value <- sample(data$value)
  return(data)
}

reshuffle_my_data<-shuffle_data(my_data)

# Sample dataframe
df <- data.frame(
  group = c("A", "A", "B", "B", "C", "C"),
  value = c(10, 15, 20, 25, 30, 35)
)

# Calculate the mean of 'value' for each 'group'
mean_df <- aggregate(value ~ group, data = df, FUN = mean)

# Print the resulting dataframe
print(mean_df)



shuffle_response <- function(data) {
  data$value <- sample(data$value) 
  mean_df <- aggregate(value ~ group, data = data, FUN = mean)
  return(mean_df$value)  # Return the vector of group means
}




