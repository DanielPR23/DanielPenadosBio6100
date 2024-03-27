#More dlpyr and sql
#dpr
#20Mar2024

library(tidyverse)
install.packages("sqldf")
library(sqldf)

species_clean<-read.csv("site_by_species.csv")
var_clean<-read.csv("site_by_variables.csv")

#Take a look at the datasets. 
glimpse(species_clean)
glimpse(var_clean)


#start using 1 file 
#subsetting rodes. 
#dlyp: 
species<-filter(species_clean, Site<30)
var<-filter(var_clean, Site<30)

#sql
#Create a query first: sort of like a stateme li a regular expreesion, where youre deyemininf the data set wat funtions?actions youre doing and any conditions for it. You the applu that quere to squldf()

query="SELECT Site, Sp1, Sp2, Sp3 FROM species WHERE Site < '30'"
sqldf(query)


#subset colums we use the dplr method select funtion, and it can use either comun or name
edit_species<-species%>%
  select(Site, Sp1, Sp2, Sp3)
edit_species<-species%>%
  select(1:4)

#Query the entire table squel
query="SELECT FROM species"
sqldf(query)

#reordetin comlumns
query="SELECT Sp1, Sp2, Sp3, Sp4, Site FROM species"
sqldf(query)->reorder_species


#Pivoting tables. Longer or wider. 
#Pivot longert (gather) lengther the data, decreases the colums, and increases runs. 

species_long<-pivot_longer(edit_species, cols = c(Sp1, Sp2, Sp3), 
                           names_to = "ID")
head(species_long)

species_wide<-pivot_wider(species_long, names_from = ID)
head(species_wide)


query="SELECT SUM(Sp1+Sp2+Sp3) AS Occurence FROM species_wide GROUP BY SITE"
sqldf(query)

#Mutate in SQL 
query="ALTER TABLE species_wide  ADD new_column VARCHAR"

sqldf(query)


#File Operations 
#Joins:GAtering data into usable formats. People will often sotore data into different variables of data into different diles. As opposed to just binding thinfs, we often need to join them together. 

#Left / Right union joiins. 

#Lets start with a clean data set. 
reset the species and var variables, and filter them to a smaller size. 

edit_species<-species_clean%>%
  filter(Site<30)%>%
  select(Site, Sp1, Sp2, Sp3, Sp4, Longitude.x., Latitude.y.)
edit_var<-var_clean%>%
  filter(Site<30)%>%
  select(Site, Longitude.x., Latitude.y., 
         BIO1_Annual_mean_temperature, BIO12_Annual_precipitation)

left<-left_join(edit_species, edit_var, by = "Site")
left
ritgh<-right_join(edit_species, edit_var, by = "Site")
ritgh             

Full<-full_join(edit_species, edit_var, by = "Site")
Full

inner<-inner_join(edit_species, edit_var, by = "Site")
inner

query="SELECT BIO1_Annual_mean_temperature, BIO12_Annual_precipitation FROM edit_var LEFT JOIN edit_species ON edi_var.Site=edit"



iris1<-iris%>%
  select(Sepal.Width>2.5, Sepal.Length>6)%>%
  filter(Species, %in% c("virginica", "versicolor"))

iris1<-select(iris, Sepal.Length>6 )
