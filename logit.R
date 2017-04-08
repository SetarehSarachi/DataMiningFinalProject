#Initial dataset is "English" articles, without NAs, and column "Author" is fixed. 
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

#Removing the crawled column
final_fake_news <- final_fake_news[,-5]

#Dealing with "bs" tags and rename those that have actual tags
final_fake_news$type <- as.character(final_fake_news$type)
final_fake_news$type[which(final_fake_news$site_url %in% "abeldanger.net")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "abovetopsecret.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "americanlookout.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "americasfreedomfighters.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "amren.com")] <- "hate"
final_fake_news$type[which(final_fake_news$site_url %in% "antiwar.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "barenakedislam.com")] <- "hate"
final_fake_news$type[which(final_fake_news$site_url %in% "beforeitsnews.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "betootaadvocate.com")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "bigbluevision.org")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "bignuggetnews.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "bipartisanreport.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "blacklistednews.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "breitbart.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "chronicle.su")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "collective-evolution.com")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "conservativedailypost.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "conservativetribune.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "dailynewsbin.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "dailystormer.com")] <- "hate"
final_fake_news$type[which(final_fake_news$site_url %in% "darkmoon.me")] <- "hate"
final_fake_news$type[which(final_fake_news$site_url %in% "dcclothesline.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "defenddemocracy.press")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "disclose.tv")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "drudgereport.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "empireherald.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "endingthefed.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "ewao.com")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "galacticconnection.com")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "geoengineeringwatch.org")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "govtslaves.info")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "gulagbound.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "hangthebankers.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "healthimpactnews.com")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "henrymakow.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "humansarefree.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "ihavethetruth.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "ijr.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "in5d.com")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "indiaarising.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "informationclearinghouse.info")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "intellihub.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "intrepidreport.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "investmentresearchdynamics.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "investmentwatchblog.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "lewrockwell.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "liberalamerica.org")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "libertyunyielding.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "ncscooper.com")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "newsbiscuit.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "occupydemocrats.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "other98.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "pakalertpress.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "realfarmacy.com")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "redflagnews.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "reductress.com")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "zerohedge.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "yournewswire.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "wundergroundmusic.com")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "worldtruth.tv")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "wikileaks.org")] <- "rumor"
final_fake_news$type[which(final_fake_news$site_url %in% "whydontyoutrythis.com")] <- "junksci"
final_fake_news$type[which(final_fake_news$site_url %in% "waterfordwhispersnews.com")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "washingtonsblog.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "veteranstoday.com")] <- "bias"
final_fake_news$type[which(final_fake_news$site_url %in% "usuncut.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "usasupreme.com")] <- "fake"
final_fake_news$type[which(final_fake_news$site_url %in% "ufoholic.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "twitchy.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "truthfrequencyradio.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "truthfeed.com")] <- "hate"
final_fake_news$type[which(final_fake_news$site_url %in% "theonion.com")] <- "satire"
final_fake_news$type[which(final_fake_news$site_url %in% "thefreethoughtproject.com")] <- "bait"
final_fake_news$type[which(final_fake_news$site_url %in% "thedailysheeple.com")] <- "conspiracy"
final_fake_news$type[which(final_fake_news$site_url %in% "thedailymash.co.uk")] <- "satire"
final_fake_news$type <- as.factor(final_fake_news$type)

#Adding Weekday as a column
library(lubridate)
substr_published <- substr(final_fake_news$published, 1, 10)
published_weekday <- weekdays(as.POSIXlt(substr_published, format="%m/%d/%Y"))
published_weekday<- as.factor(published_weekday)
final_fake_news<- cbind(final_fake_news,published_weekday)

#This part is to create the low occurrences for applying the algorithms,
sorted_author<- data.frame(sort(table(final_fake_news$author), decreasing = T))
final_author<- sorted_author[1:31,]
low_occurrence_authors <- sorted_author$Var1[32:nrow(sorted_author)]
sorted_url<-data.frame(sort(table(final_fake_news$site_url), decreasing = T))
final_site_url<- sorted_url[1:31,]
low_occurrence_site_url <- sorted_url$Var1[32:nrow(sorted_url)]
#The Algorithms are applied on temp_dataset, which is a copy of Final dataset, with a level "low_occurrence"
temp_dataset <- final_fake_news
temp_dataset$author[which(temp_dataset$author %in% low_occurrence_authors)] <- "low_occurrence"
temp_dataset$site_url[which(temp_dataset$site_url %in% low_occurrence_site_url)] <- "low_occurrence"
temp_dataset$author <- as.factor(temp_dataset$author)
temp_dataset$site_url <- as.factor(temp_dataset$site_url)


library(nnet)
temp_dataset$type <- relevel(temp_dataset$type, ref = "bs")
#Logit without "published" and "published_weekday"
logit_author_url <- multinom(type ~ author+ord_in_thread+site_url+country+domain_rank+spam_score+replies_count+participants_count+likes+comments+shares, data = temp_dataset)
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

