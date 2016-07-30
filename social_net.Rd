#实验：社交数据可视化
library("maps")
library("sp")
library("geosphere")
xlim<-c(-171.738281,-56.601563)
ylim<-c(12.039321,71.856229) 
map("world",col="#f2f2f2",fill=TRUE,bg="white",lwd=0.05,xlim=xlim,ylim=ylim)
lat_ca<-39.164141
lon_ca<- -121.64062
lat_me<- 45.213
lon_me<- -68.906250
inter<- gcIntermediate(c(lon_ca,lat_ca),c(lon_me,lat_me),n=50,addStartEnd=TRUE)
lines(inter)
#继续画弧线
lat_tx<- 29.954935
lon_tx<- -98.701172
inter2<- gcIntermediate(c(lon_ca,lat_ca),c(lon_tx,lat_tx),n=50,addStartEnd=TRUE)
lines(inter2,col="red")
#装载数据
airports<-read.csv("http://datasets.flowingdata.com/tuts/maparcs/airports.csv",header=T)#直接从网上拉数据
flights<-read.csv("http://datasets.flowingdata.com/tuts/maparcs/flights.csv",header=T,as.is=T)
#画出多重联系
pdf("Figure.pdf")
map("world",col="#f2f2f2",fill=TRUE,bg="white",lwd=0.05,xlim=xlim,ylim=ylim)
fsub<-flights[flights$airline=="AA",]
for(j in 1:length(fsub$airline)){
	air1<-airports[airports$iata==fsub[j,]$airport1,]
	air2<-airports[airports$iata==fsub[j,]$airport2,]
	inter<-			gcIntermediate(c(air1[1,]$long,air1[1,]$lat),c(air2[1,]$long,air2[1,]$lat),n=100,addStartEnd=T)
	lines(inter,col="black",lwd=0.8)
}
dev.off()

#彩色世界地图
map("world",fill=TRUE,col=rainbow(200),ylim=c(-60,90),mar=c(0,0,0,0))
install.packages("mapdata")
library(mapdata)
map("china",col="red4",ylim=c(18,54),panel.first=grid())