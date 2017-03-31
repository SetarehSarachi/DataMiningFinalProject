newfake_1 <- read.csv("~/Desktop/INFSCI 2160/DataMiningFinalProject/newfake_1.csv")
non_english_articles <- newfake_1[-which(newfake_1$language == "english"),]
fake_news_dataset <- newfake_1[-which(newfake_1$language != "english"),]
fake_news_dataset <- fake_news_dataset[,-1]
sapply(fake_news_dataset, function(x) sum(is.na(x)))
temp <- fake_news_dataset

temp$author <- as.character(temp$author)
temp$author[which(is.na(temp$author))] <- "Unknown"
temp$author <- as.factor(temp$author)

temp$main_img_url <- as.character(temp$main_img_url)
temp$main_img_url[which(is.na(temp$main_img_url))] <- "Unknown"
temp$main_img_url <- as.factor(temp$main_img_url)

temp$domain_rank[which(is.na(temp$domain_rank))] <- 0


temp$country <- as.character(temp$country)
temp$country[which(is.na(temp$country))] <- "Unknown"
temp$country <- as.factor(temp$country)


             

