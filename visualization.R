library('devtools')
library(ggmap)
library(raster)
#install.packages("raster")

devtools::install_github('dkhale/ggmap')
key = AIzaSyCctguejDFyi3L8rEbiiQpvXvnJ29SZT-I

station <- read.csv("Rag_ID_map.csv", header=TRUE)
head(station)
station <- station[c(2,8,9)]

# Dataframe for visualization
nonred <- read.csv("nonred_comm_list.csv", header = TRUE)
nonred <- nonred[c(2:9)]
nonred[,2] <- as.factor(nonred[,2])
nonred[,3] <- as.factor(nonred[,3])
nonred[,4] <- as.factor(nonred[,4])
nonred[,5] <- as.factor(nonred[,5])
nonred[,6] <- as.factor(nonred[,6])
nonred <- na.omit(nonred)

red <- read.csv("red_commlist.csv", header = TRUE)
red <- red[c(2:9)]
red[,2] <- as.factor(red[,2])
red[,3] <- as.factor(red[,3])
red[,4] <- as.factor(red[,4])
red[,5] <- as.factor(red[,5])
red[,6] <- as.factor(red[,6])
red<- na.omit(red)
head(red)
str(red)

#

station_deq <- station
colnames(station_deq) <- c("Dep", "Dep_lat", "Dep_long")
head(station_deq)

station_arr <- station
colnames(station_arr) <- c("Arr", "Arr_lat", "Arr_long")
head(station_arr)


dt_nr_ch_c<-merge(x = dt_nr_ch_c,
                  y= station_deq,
                  by = 'Dep',
                  all.x = TRUE)

dt_nr_ch_c<-merge(x = dt_nr_ch_c,
                  y= station_arr,
                  by = 'Arr',
                  all.x = TRUE)

summary(dt_nr_ch_c)
dt_nr_ch_c['scale'] <- dt_nr_ch_c['scale']*100

## 필요한 Membership만 추출하기
library(dplyr)
head(nonred)
str(nonred)

nr8 <- nonred %>% select(ID, nonred_chulgeun_Membership, lat, long) %>% filter(nonred_chulgeun_Membership == '8')
nr8 <- nr8[c(1,3,4)]
head(nr8)
str(nr8)
nr8_Dep <- nr8
nr8_Arr <- nr8
colnames(nr8_Dep) <- c("Dep", "Dep_lat", "Dep_long")
colnames(nr8_Arr) <- c("Arr", "Arr_lat", "Arr_long")

dt_nr_ch_c<-nonred_chulgeun_count
colnames(dt_nr_ch_c)<- c("Dep","Arr","Freq")
dt_nr_ch_c_8 <-merge(x=dt_nr_ch_c,
                     y = nr8_Dep,
                     by = 'Dep',
                     all.x = TRUE)
dt_nr_ch_c_8 <-merge(x=dt_nr_ch_c_8,
                     y = nr8_Arr,
                     by = 'Arr',
                     all.x = TRUE)
summary(dt_nr_ch_c_8)
dt_nr_ch_c_8<-na.omit(dt_nr_ch_c_8)
table(is.na(dt_nr_ch_c_8))정




#Visualization
register_google(key = 'AIzaSyBYGNRQm0VDE2cLO9KjwlSaTo1MxRaPTos')
geocodeQueryCheck()


boxplot(dt_nr_ch_c_8$Freq)
## Freq에 따라 aplha값 조저
alphas = c()
for(i in 1:length(dt_nr_ch_c_8$Freq)){
  if(dt_nr_ch_c_8$Freq[i] >= 1 & dt_nr_ch_c_8$Freq[i] < 50){
    alphas<-c(alphas, 0.05)}
  else if(dt_nr_ch_c_8$Freq[i] >= 50 & dt_nr_ch_c_8$Freq[i] < 150){
    alphas<-c(alphas, 0.1)}
  else if(dt_nr_ch_c_8$Freq[i] >= 150 & dt_nr_ch_c_8$Freq[i] < 400){
    alphas<-c(alphas, 0.3)}
  else{
    alphas<-c(alphas, 1)}
}
colors = c()
for(i in 1:length(dt_nr_ch_c_8$Freq)){
  if(dt_nr_ch_c_8$Freq[i] >= 1 & dt_nr_ch_c_8$Freq[i] < 50){
    colors<-c(colors, 'black')}
  else if(dt_nr_ch_c_8$Freq[i] >= 50 & dt_nr_ch_c_8$Freq[i] < 150){
    colors<-c(colors, 'Dark Orange')}
  else if(dt_nr_ch_c_8$Freq[i] >= 150 & dt_nr_ch_c_8$Freq[i] < 400){
    colors<-c(colors, 'dodger blue')}
  else{
    colors<-c(colors, 'red')}
}
seoul <- get_map("Mapo Bridge", zoom = 13, maptype = "roadmap") #seoul 지도를 가져온다.

seoul_nrc <- ggmap(seoul)+ 
  geom_point(data = nr8, aes(x=long, y=lat), color = 'Sea Green', size = 3, alpha=1)+ 
  geom_segment(data = dt_nr_ch_c_8, aes(x=Dep_long, y=Dep_lat, xend=Arr_long, yend=Arr_lat),arrow = arrow(angle=75, length = unit(0.1,'cm'), ends = "first", type = 'closed'),alpha = alphas, color=colors, size=size_m)+  
  geom_text(data = nr8, aes(x=long, y=lat, label = ID), size = 3) #Membership 번호 찍기

seoul_nrc
?geom_segment

  ##정류소 번호별 색깔부여
colors <- c()
for(i in 1:length(station$ID)){
  if(station$ID[i] > 100 & station$ID[i] < 200){
    colors<-c(colors, "red")}
  else if(station$ID[i] >= 200 & station$ID[i] < 300){
    colors<-c(colors, "orange")}
  else if(station$ID[i] >= 300 & station$ID[i] < 400){
    colors<-c(colors, "yellow")}
  else if(station$ID[i] >= 400 & station$ID[i] < 500){
    colors<-c(colors, "Magenta")}
  else if(station$ID[i] >= 500 & station$ID[i] < 600){
    colors<-c(colors, "blue")}
  else if(station$ID[i] >= 600 & station$ID[i] < 700){
    colors<-c(colors, "navy")}
  else if(station$ID[i] >= 700 & station$ID[i] < 800){
    colors<-c(colors, "green yellow")}
  else if(station$ID[i] >= 800 & station$ID[i] < 900){
    colors<-c(colors, "Dark slate Gray")}
  else if(station$ID[i] >= 900 & station$ID[i] < 1000){
    colors<-c(colors, "Forest Green")}
  else if(station$ID[i] >= 1000 & station$ID[i] < 1100){
    colors<-c(colors, "Purple")}
  else if(station$ID[i] >= 1100 & station$ID[i] < 1200){
    colors<-c(colors, "Deep Pink")}
  else if(station$ID[i] >= 1200 & station$ID[i] < 1300){
    colors<-c(colors, "Maroon")}
  else if(station$ID[i] >= 1300 & station$ID[i] < 1400){
    colors<-c(colors, "Light Pink")}
  else if(station$ID[i] >= 1400 & station$ID[i] < 1500){
    colors<-c(colors, "Aquamarine")}
  else if(station$ID[i] >= 1500 & station$ID[i] < 1600){
    colors<-c(colors, "Deep Sky Blue")}
  else if(station$ID[i] >= 1600 & station$ID[i] < 1700){
    colors<-c(colors, "steel Blue")}
  else if(station$ID[i] >= 1700 & station$ID[i] < 1800){
    colors<-c(colors, "Sienna")}
  else if(station$ID[i] >= 1800 & station$ID[i] < 1900){
    colors<-c(colors, "Medium Blue")}
  else if(station$ID[i] >= 1900 & station$ID[i] < 2000){
    colors<-c(colors, "Orange Red")}
  else if(station$ID[i] >= 2000 & station$ID[i] < 2100){
    colors<-c(colors, "Wheat")}
  else if(station$ID[i] >= 2100 & station$ID[i] < 2200){
    colors<-c(colors, "Firebrick")}
  else if(station$ID[i] >= 2200 & station$ID[i] < 2300){
    colors<-c(colors, "Cyan")}
  else if(station$ID[i] >= 2300 & station$ID[i] < 2400){
    colors<-c(colors, "Light Coral")}
  else if(station$ID[i] >= 2400 & station$ID[i] < 2500){
    colors<-c(colors, "Light Coral")}
  else if(station$ID[i] >= 2500 & station$ID[i] < 2600){
    colors<-c(colors, "Cyan")}
  else if(station$ID[i] >= 2600 & station$ID[i] < 3100){
    colors<-c(colors, "Maroon")}
  else if(station$ID[i] >= 3100 & station$ID[i] < 3500){
    colors<-c(colors, "red")}
  else{
    colors<-c(colors, "blue")}
}

## 정류소 번호별 크기부여
sizes = c()
for(i in 1:length(station$ID)){
  if(station$ID[i] > 100 & station$ID[i] < 200){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 200 & station$ID[i] < 300){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 300 & station$ID[i] < 400){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 400 & station$ID[i] < 500){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 500 & station$ID[i] < 600){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 600 & station$ID[i] < 700){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 700 & station$ID[i] < 800){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 800 & station$ID[i] < 900){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 900 & station$ID[i] < 1000){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1000 & station$ID[i] < 1100){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1100 & station$ID[i] < 1200){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1200 & station$ID[i] < 1300){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1300 & station$ID[i] < 1400){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1400 & station$ID[i] < 1500){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1500 & station$ID[i] < 1600){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1600 & station$ID[i] < 1700){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1700 & station$ID[i] < 1800){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1800 & station$ID[i] < 1900){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 1900 & station$ID[i] < 2000){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 2000 & station$ID[i] < 2100){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 2100 & station$ID[i] < 2200){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 2200 & station$ID[i] < 2300){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 2300 & station$ID[i] < 2400){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 2400 & station$ID[i] < 2500){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 2500 & station$ID[i] < 2600){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 2600 & station$ID[i] < 3100){
    sizes<-c(sizes, 1)}
  else if(station$ID[i] >= 3100 & station$ID[i] < 3500){
    sizes<-c(sizes, 1)}
  else{
    sizes<-c(sizes, 1)}
}
#2400번~: (2300)번대 정류소에 추가된 정류소
#2500번~: (2200)번대 정류소에 추가된 정류소
#2600번~: (1200)번대 정류소에 추가된 정류소
#3100번~: (100)번대 정류소에 추가된 정류소
#3500번~: (500)번대 정류소에 추가된 정류소여
##이에 색상과 크기 같게 하였다. 

seoul <- get_map("seoul", zoom = 11, maptype = "roadmap")
dr_station <- ggmap(seoul)+
  geom_point(data = station, aes(x = long, y = lat), color = colors, size = sizes)+  
  geom_text(data = station, aes(x = long, y = lat, label = ID), size = 3)

dr_station
  
#geom_polygon(data = seoul2, aes(x = long, y = lat, group =group), fill = "white", color = 'black', alpha = .15)+