####################################################################
#Function: generate_random_data
#Create random generate data from specified variables. 
#n_groups, n_groups, n_obs_min, n_obs_max, mean_min, mean_max, sd_min, sd_max. 
#Once stblish this data, the code will create a for loop depending on the n_groups sepecified. 
#it will loop and sample a data between max and min of obserbation, mean, and SD.
#I will generate the dataframe from the variables from before naming the group "group_[i]
#Finally, it will join the all data frames

#------------------------------------

generate_random_data <- function(n_groups=4, n_obs_min=25, n_obs_max=100, mean_min=12, mean_max=40, sd_min=2, sd_max=5) {
  # Initialize empty list to store data frames for each group
  group_data <- list()
  
  # Generate random parameters for each group
  for (i in 1:n_groups) {
    # Generate random sample size (N) for each group
    n_obs <- sample(n_obs_min:n_obs_max, 1)
    
    # Generate random mean for each group
    group_mean <- runif(1, mean_min, mean_max)
    
    # Generate random standard deviation for each group
    group_sd <- runif(1, sd_min, sd_max)
    
    # Generate random data for the group
    group_data[[i]] <- data.frame(Group = rep(paste0("Group_", i), n_obs),
                                  Value = rnorm(n_obs, mean = group_mean, sd = group_sd))
  }
  
  # Combine data frames for all groups into a single data frame
  all_data <- do.call(rbind, group_data)
  
  return(all_data)
}

random_data<-generate_random_data()
head(random_data)
##################################################
#Function Name: calculate_group_stats
#DPR
#Create summary statistic for a data frame of groups and values. (2 colums)
#The two columns will need to be named Value and Group. 
#The function input will only need to be the data frame. 
#The output is a dataframe with the summay stats for each group. 

#-------------------------------------------------------------------------

calculate_group_stats <- function(data) {
  # Calculate mean, median, and standard deviation for each group
  group_stats <- aggregate(Value ~ Group, data = data, FUN = function(x) c(mean = mean(x), median = median(x), sd = sd(x)))
  
  return(group_stats)
}

# Example usage:
group_stats <- calculate_group_stats(random_data)

# View the calculated statistics for each group
print(group_stats)


#---------------------------------------------------------------------------




