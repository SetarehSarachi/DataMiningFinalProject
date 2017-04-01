final_fake_news <- read.csv("~/Desktop/INFSCI 2160/DataMiningFinalProject/final_fake_news1.csv")
final_fake_news <- final_fake_news[,-1]
final_fake_news$X <- as.numeric(final_fake_news$X)
final_fake_news$ord_in_thread <- as.numeric(final_fake_news$ord_in_thread)
final_fake_news$domain_rank <- as.numeric(final_fake_news$domain_rank)
final_fake_news$replies_count <- as.numeric(final_fake_news$replies_count)
final_fake_news$participants_count<- as.numeric(final_fake_news$participants_count)
final_fake_news$likes <- as.numeric(final_fake_news$likes)
final_fake_news$comments <- as.numeric(final_fake_news$comments)
final_fake_news$shares <- as.numeric(final_fake_news$shares)
#Factor to character
final_fake_news$published <- as.character(final_fake_news$published)
final_fake_news$crawled <- as.character(final_fake_news$crawled)
final_fake_news$author <- as.character(final_fake_news$author)
final_fake_news$site_url <- as.character(final_fake_news$site_url)

sorted_author<- data.frame(sort(table(final_fake_news$author), decreasing = T))
final_author<- sorted_author[1:31,]
low_occurence_authors <- sorted_author$Var1[32:nrow(sorted_author)]
sorted_url<-data.frame(sort(table(final_fake_news$site_url), decreasing = T))
final_site_url<- sorted_url[1:31,]
low_occurence_site_url <- sorted_url$Var1[32:nrow(sorted_url)]
replace <- final_fake_news
replace$author[which(replace$author %in% low_occurence_authors)] <- "low_occurance"
replace$site_url[which(replace$site_url %in% low_occurence_site_url)] <- "low_occurance"
replace$author <- as.factor(replace$author)
replace$site_url <- as.factor(replace$site_url)


library(nnet)
replace$type <- relevel(replace$type, ref = "bs")
#Logit without "crawled at" and "published on"
logit_author_url <- multinom(type ~ author+ord_in_thread+site_url+country+domain_rank+spam_score+replies_count+participants_count+likes+comments+shares, data = replace)
logit <- logit_author_url
summary(logit)
# weights:  760 (658 variable)
#initial  value 25787.154558 
#iter  10 value 15065.231222
#iter  20 value 10003.001691
#iter  30 value 8105.653239
#iter  40 value 5955.889346
#iter  50 value 4571.390269
#iter  60 value 3668.138248
#iter  70 value 3459.270621
#iter  80 value 3327.979786
#iter  90 value 3271.318128
#iter 100 value 3252.407129
#final  value 3252.407129 
#stopped after 100 iterations
#Residual Deviance: 6504.814 
#AIC: 7792.814 

