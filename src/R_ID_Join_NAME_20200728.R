# ---Taiwain geocode
library(readxl)
City_Geocode <- read_excel("data/Taiwan_Geocode.xlsx")
colnames(City_Geocode)
Town_Geocode <- read_excel("data/Taiwan_Geocode.xlsx",
                           sheet = "鄉鎮")
colnames(Town_Geocode)
library(data.table)
Town_Geocode.dt<- data.table(Town_Geocode)
City_id.dt<-Town_Geocode.dt[,c("Taiwan_Geocode_106_鄉鎮代碼", "Taiwan_Geocode_106_縣市名")]
colnames(City_id.dt) <- c("TownID","CityNAME")
Town_XY <- read_excel("data/TOWN_XY.xlsx",
                           sheet = "工作表1")
result_op.dt <- merge(Town_XY,City_id.dt,all=TRUE)
colnames(result_op.dt)
result_op.dt<-result_op.dt[,c("TownID", "CityNAME","TownName","Long","Lat")]
write.csv(result_op.dt,paste0("./data/TOWN_XY_0728","_Big5",".csv"),row.names = FALSE)
