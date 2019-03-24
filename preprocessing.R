library(plyr)
library(reshape2)

nonred_chulgeun_raw <- read.csv('nonred_chulgeun_dep.csv')

nonred_chulgeun <- cbind(nonred_chulgeun_raw$DepartureID, nonred_chulgeun_raw$ArrivalID)
nonred_chulgeun <- as.data.frame(nonred_chulgeun)
colnames(nonred_chulgeun) <- c("Departure", "Arrival") 
head(nonred_chulgeun)
nonred_chulgeun_count <- count(nonred_chulgeun)
head(nonred_chulgeun_count)


nonred_chulgeun_mat <- acast(nonred_chulgeun_count, Departure ~ Arrival)
#write.csv(nonred_chulgeun_mat, 'nonred_chulgeun_mat.csv', row.names=TRUE)
write.table(nonred_chulgeun_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/nonred_chulgeun_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

# csv파일에서 1행을 한칸 오른쪽으로 복붙후 쓰세용

nonred_toegeun_raw <- read.csv('nonred_toegeun_dep.csv')
nonred_bam_raw <- read.csv('nonred_bam_dep.csv')
nonred_nat_raw <- read.csv('nonred_nat_dep.csv')
nonred_simya_raw <- read.csv('nonred_simya_dep.csv')

nonred_toegeun <- cbind(nonred_toegeun_raw$DepartureID, nonred_toegeun_raw$ArrivalID)
nonred_toegeun <- as.data.frame(nonred_toegeun)
colnames(nonred_toegeun) <- c("Departure", "Arrival") 
nonred_toegeun_count <- count(nonred_toegeun)

nonred_bam <- cbind(nonred_bam_raw$DepartureID, nonred_bam_raw$ArrivalID)
nonred_bam <- as.data.frame(nonred_bam)
colnames(nonred_bam) <- c("Departure", "Arrival") 
nonred_bam_count <- count(nonred_bam)

nonred_nat <- cbind(nonred_nat_raw$DepartureID, nonred_nat_raw$ArrivalID)
nonred_nat <- as.data.frame(nonred_nat)
colnames(nonred_nat) <- c("Departure", "Arrival") 
nonred_nat_count <- count(nonred_nat)

nonred_simya <- cbind(nonred_simya_raw$DepartureID, nonred_simya_raw$ArrivalID)
nonred_simya <- as.data.frame(nonred_simya)
colnames(nonred_simya) <- c("Departure", "Arrival") 
nonred_simya_count <- count(nonred_simya)

nonred_toegeun_mat <- acast(nonred_toegeun_count, Departure ~ Arrival)
write.table(nonred_toegeun_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/nonred_toegeun_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

nonred_bam_mat <- acast(nonred_bam_count, Departure ~ Arrival)
write.table(nonred_bam_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/nonred_bam_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

nonred_nat_mat <- acast(nonred_nat_count, Departure ~ Arrival)
write.table(nonred_nat_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/nonred_nat_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

nonred_simya_mat <- acast(nonred_simya_count, Departure ~ Arrival)
write.table(nonred_simya_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/nonred_simya_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

#########

red_chulgeun_raw <- read.csv('C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_chulgeun_dep.csv')

red_chulgeun <- cbind(red_chulgeun_raw$DepartureID, red_chulgeun_raw$ArrivalID)
red_chulgeun <- as.data.frame(red_chulgeun)
colnames(red_chulgeun) <- c("Departure", "Arrival") 
head(red_chulgeun)
red_chulgeun_count <- count(red_chulgeun)
head(red_chulgeun_count)


red_chulgeun_mat <- acast(red_chulgeun_count, Departure ~ Arrival)
#write.csv(red_chulgeun_mat, 'red_chulgeun_mat.csv', row.names=TRUE)
write.table(red_chulgeun_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_chulgeun_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

red_toegeun_raw <- read.csv('C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_toegeun_dep.csv')
red_bam_raw <- read.csv('C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_bam_dep.csv')
red_nat_raw <- read.csv('C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_nat_dep.csv')
red_simya_raw <- read.csv('C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_simya_dep.csv')

red_toegeun <- cbind(red_toegeun_raw$DepartureID, red_toegeun_raw$ArrivalID)
red_toegeun <- as.data.frame(red_toegeun)
colnames(red_toegeun) <- c("Departure", "Arrival") 
red_toegeun_count <- count(red_toegeun)

red_bam <- cbind(red_bam_raw$DepartureID, red_bam_raw$ArrivalID)
red_bam <- as.data.frame(red_bam)
colnames(red_bam) <- c("Departure", "Arrival") 
red_bam_count <- count(red_bam)

red_nat <- cbind(red_nat_raw$DepartureID, red_nat_raw$ArrivalID)
red_nat <- as.data.frame(red_nat)
colnames(red_nat) <- c("Departure", "Arrival") 
red_nat_count <- count(red_nat)

red_simya <- cbind(red_simya_raw$DepartureID, red_simya_raw$ArrivalID)
red_simya <- as.data.frame(red_simya)
colnames(red_simya) <- c("Departure", "Arrival") 
red_simya_count <- count(red_simya)

red_toegeun_mat <- acast(red_toegeun_count, Departure ~ Arrival)
write.table(red_toegeun_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_toegeun_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

red_bam_mat <- acast(red_bam_count, Departure ~ Arrival)
write.table(red_bam_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_bam_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

red_nat_mat <- acast(red_nat_count, Departure ~ Arrival)
write.table(red_nat_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_nat_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

red_simya_mat <- acast(red_simya_count, Departure ~ Arrival)
write.table(red_simya_mat, "C:/Users/student/OneDrive/dr/dh_remove_centers/drr_with_timeAndRed_category/red_simya_mat.csv", 
            sep = ",", 
            row.names = TRUE,
            quote = FALSE,
            append = FALSE,
            na = '0') 

