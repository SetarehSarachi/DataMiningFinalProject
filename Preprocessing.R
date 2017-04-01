newfake_1 <- read.csv("~/Desktop/INFSCI 2160/DataMiningFinalProject/newfake_1.csv")
non_english_articles <- newfake_1[-which(newfake_1$language == "english"),]
fake_news_dataset <- newfake_1[-which(newfake_1$language != "english"),]
fake_news_dataset <- fake_news_dataset[,-1]
sapply(fake_news_dataset, function(x) sum(is.na(x)))
temp <- fake_news_dataset
temp <- temp[,c(-1,-5,-11)]

temp$author <- as.character(temp$author)
temp$author[which(is.na(temp$author))] <- "Unspecified"
temp$author <- as.factor(temp$author)

#temp$main_img_url <- as.character(temp$main_img_url)
#temp$main_img_url[which(is.na(temp$main_img_url))] <- "Unspecified"
#temp$main_img_url <- as.factor(temp$main_img_url)

temp$domain_rank[which(is.na(temp$domain_rank))] <- 0


temp$country <- as.character(temp$country)
temp$country[which(is.na(temp$country))] <- "Unspecified"
temp$country <- as.factor(temp$country)

#Running Multinomial Logit
require(nnet)
temp$type1 <- relevel(temp$type, ref="bs")
test <- multinom(temp$type1 ~ ., data = temp)

#Running SVM 
library(e1071)
model <- svm(temp$type~., temp)
res<- predict(model,newdata = temp)

temp$author[(temp$author %in% "-NO AUTHOR-")] <- "unspecified"
temp$author[which(is.na(temp$author))] <- "Unspecified"
which(is.na(temp$author))

temp$author <- as.character(temp$author)
temp$author[which(temp$author %in% "#1 NWO Hatr")] <- "1 NWO Hatr" 

temp <- temp[-384,] #Addictinginfo.com author: <U+0628><U+0631><U+0646><U+0627
temp$author[which(temp$author %in% "Day of the Dead 2015: History, food and reflections <96> Andrea Lawson Gray")] <- "Andrea Lawson Gray"
temp$author[387] <- "Sue Penn" 
temp$author[391] <- "Koel Writing Souls"
temp$author[423] <- "Gearoid Colemain"
temp$author[1443] <- "eeea" 
temp$author[1452] <- "Rex Kwon Do" 
temp$author[1466]  <- "Dairy"
temp$author[1479]  <- "Garry Owen"
temp$author[1481]  <- "ctwatcher"
temp$author[1487]  <- "ctwatcher"
temp$author[1491]  <- "Pepe the Deplorable"
temp$author[1508]  <- "ctwatcher"
temp$author[1639] <- "Allie Stark"
temp$author[1640] <- "Joe Martino"
temp$author[1641] <- "Amanda Moteiro"
temp$author[1642] <- "Kalee Brown"
temp$author[1643] <- "Alexandria Larido"
temp$author[1645] <- "Collective Evolution"
temp$author[1646] <- "Arjun Walia"
temp$author[1647] <- "Arjun Walia"
temp$author[1648] <- "Kalee Brown"
temp$author[1649] <- "Mark Denicola"
temp <- temp[-1658,]
temp$author[1658] <- "Arjun Walia"
temp$author[1659] <- "Alexa Erickson"
temp$author[1660] <- "Mark Denicola"
temp$author[1662] <- "Joe Martino"
temp$author[1663] <- "Arjun Walia"
temp$author[1665] <- "Collective Evolution"
temp$author[1666] <- "Joe Martino"
temp$author[1667] <- "Ethan A. Huff"
temp$author[1668] <- "Jeff Roberts"
temp$author[1669] <- "wghyelim"
temp$author[1675] <- "Joe Martino"
temp$author[1676] <- "Kalee Brown"
temp$author[1677] <- "Arjun Walia"
temp$author[1678] <- "Matt"
temp$author[1680] <- "Arjun Walia"
temp$author[1684] <- "Alexa Erickson"
temp$author[1685] <- "Arjun Walia"
temp$author[1686] <- "Elyce Powers"
temp$author[1687] <- "Joe Martino"
temp$author[1688] <- "Elina St-onge"
temp$author[1689] <- "Joe Martino"
temp$author[1690] <- "Alexa Erickson"
temp$author[1691] <- "Arjun Walia"
temp$author[1693] <- "Kuebiko"
temp$author[1695] <- "Joe Martino"
temp$author[1696] <- "Collective Evolution"
temp$author[1697] <- "Carmen Di Luccio"
temp$author[1698] <- "Jenny"
temp$author[1699] <- "Christian McCrory"
temp$author[1700] <- "Alexa Erickson"
temp$author[1701] <- "Collective Evolution"
temp$author[1703] <- "Alanna Ketler"
temp$author[1705] <- "Alanna Ketler"
temp$author[1706] <-"Alexandria D."

temp$author[1703] <- "Collective Evolution"
temp$author[1719] <- "Collective Evolution"
temp$author[1725] <- "Collective Evolution"


