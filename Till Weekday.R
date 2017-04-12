#Input raw data
fake<- read.csv("/Users/setaresarachi/Desktop/INFSCI 2160/fake.csv", header = T, fileEncoding = "UTF-8")
#copuing for analysis
original<- fake
colnames(fake)
#For adding the "Unspecified" level, we first convert to character
fake$author <- as.character(fake$author)
#Changing all the blanks to Unspecified
fake$author[which(fake$author %in% "")] <- "Unspecified"
#to understand relation between ord_in_thread and replies_count
small <- fake[,c(2,3,5,12,15)]
#here we are removing all the comments (order_in_thread != 0)
fake <- fake[which(fake$ord_in_thread == 0),]
nrow(fake) #The number of articles are now 12328
#Then we are considering articles which are english
fake <- fake[which(fake$language %in% "english"),]
nrow(fake)
#Checking for NA
sapply(fake, function(x) sum(is.na(x)))
#Checking author levels
levels<-data.frame(levels(fake$author))
#Making rownames NULL for the numbers to re-arrange on row removal
rownames(fake) <- NULL
#NEXT FOUR LINES ARE HALTED FOR NOW
#Changing "" to OtherLangAuthors
#fake$author <- as.character(fake$author)
#fake$author[which(fake$author %in% "")] <- "OtherLangAuthors"
#fake$author <- as.factor(fake$author)
#SQL
library(sqldf)
#Checking for 'comment' in thread_title to remove those rows
comments <- sqldf ("Select * FROM fake WHERE thread_title LIKE '%Comment%' ")
#removing the 'comment' rows
fake<- fake[-which(fake$uuid  %in% comments$uuid),]
#Remove all unnecessary columns
# 14 -Main_img_url, 4- pblished , 6- text, 7 - language, 12- thread_title
#fake<- fake[,-c("published","text","language","thread_title","main_img_url")]
fake<- fake[,-c(4,6,7,12,14)]
colnames(fake)

#fixing the authors
fake$author[which(fake$author %in% "Jafe Arnoldski (noreply@blogger.com)")] <- "Jafe Arnoldski"
fake$author[which(fake$author %in% "Tom Winter (noreply@blogger.com)")] <- "Tom Winter"
fake$author[which(fake$author %in% "Kristina Rus (noreply@blogger.com)")] <- "Kristina Rus"
fake$author[which(fake$author %in% "Inessa S (noreply@blogger.com)")] <- "Inessa"
fake$author[which(fake$site_url %in% "consortiumnews.com")] <- "consortiumnews"
fake$author[which(fake$author %in% "noreply@blogger.com (Alexander Light)")] <- "Alexander Light"
fake$author[which(fake$author %in% "Jörg Guido Hülsmann")] <- "Jorg guido Hulsmann"
fake$author[which(fake$author %in% "Deirdre Fulton | Common Dreams")] <- "Deirdre Fulton"
fake$author[which(fake$author %in% "Jason Ditz | Antiwar.com")] <- "Jason Ditz"
fake$author[which(fake$author %in% "Amanda Froelich | TrueActivist")] <- "Amanda Froelich"
fake$author[which(fake$author %in% "Jeremiah Jones | Counter Current News")] <- "Jeremaih Jones"
fake$author[which(fake$author %in% "Kevin Gosztola | Shadowproof")] <- "Kevin Gosztola"
fake$author[which(fake$author %in% "Andrea Germanos | Common Dreams")] <- "Andrea Germanos"
fake$author[which(fake$author %in% "ZeroHedge.com")] <- "ZeroHedge"
fake$author[which(fake$author %in% "Investigative Historian Eric Zuesse Is The Author")] <- "Eric Zuesse"
fake$author[which(fake$author %in% "André du Pôle")] <- "Andre du Pole"
fake$author[which(fake$author %in% "Arnold Monteverde (noreply@blogger.com)")] <- "Arnold Monteverde"
fake$author[which(fake$author %in% "Doc Farmer<U+2713><U+1D5B><U+1D49><U+02B3><U+1DA6><U+1DA0><U+1DA6><U+1D49><U+1D48> <U+1D48><U+1D49><U+1D56><U+02E1><U+1D52><U+02B3><U+1D43><U+1D47><U+02E1><U+1D49>")] <- "Doc Farmer"
fake$author[which(fake$author %in% "Dikran Arakelian (noreply@blogger.com)")] <- "Dikran Arakelian"
fake$author[which(fake$author %in% "tokyowashi (noreply@blogger.com)")] <- "tokyowashi"
fake$author[which(fake$author %in% "Joe from MassPrivateI")] <- "Joe"

#fixing types
fake$type <- as.character(fake$type)
fake$type[which(fake$site_url %in% "abeldanger.net")] <- "conspiracy"
fake$type[which(fake$site_url %in% "abovetopsecret.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "americanlookout.com")] <- "bias"
fake$type[which(fake$site_url %in% "americasfreedomfighters.com")] <- "bias"
fake$type[which(fake$site_url %in% "amren.com")] <- "hate"
fake$type[which(fake$site_url %in% "antiwar.com")] <- "bias"
fake$type[which(fake$site_url %in% "barenakedislam.com")] <- "hate"
fake$type[which(fake$site_url %in% "beforeitsnews.com")] <- "fake"
fake$type[which(fake$site_url %in% "betootaadvocate.com")] <- "satire"
fake$type[which(fake$site_url %in% "bigbluevision.org")] <- "bait"
fake$type[which(fake$site_url %in% "bignuggetnews.com")] <- "bias"
fake$type[which(fake$site_url %in% "bipartisanreport.com")] <- "bait"
fake$type[which(fake$site_url %in% "blacklistednews.com")] <- "bait"
fake$type[which(fake$site_url %in% "breitbart.com")] <- "bait"
fake$type[which(fake$site_url %in% "chronicle.su")] <- "satire"
fake$type[which(fake$site_url %in% "collective-evolution.com")] <- "junksci"
fake$type[which(fake$site_url %in% "conservativedailypost.com")] <- "fake"
fake$type[which(fake$site_url %in% "conservativetribune.com")] <- "bias"
fake$type[which(fake$site_url %in% "dailynewsbin.com")] <- "bias"
fake$type[which(fake$site_url %in% "dailystormer.com")] <- "hate"
fake$type[which(fake$site_url %in% "darkmoon.me")] <- "hate"
fake$type[which(fake$site_url %in% "dcclothesline.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "defenddemocracy.press")] <- "bias"
fake$type[which(fake$site_url %in% "disclose.tv")] <- "satire"
fake$type[which(fake$site_url %in% "drudgereport.com")] <- "bias"
fake$type[which(fake$site_url %in% "empireherald.com")] <- "fake"
fake$type[which(fake$site_url %in% "endingthefed.com")] <- "bias"
fake$type[which(fake$site_url %in% "ewao.com")] <- "junksci"
fake$type[which(fake$site_url %in% "galacticconnection.com")] <- "junksci"
fake$type[which(fake$site_url %in% "geoengineeringwatch.org")] <- "junksci"
fake$type[which(fake$site_url %in% "govtslaves.info")] <- "conspiracy"
fake$type[which(fake$site_url %in% "gulagbound.com")] <- "bias"
fake$type[which(fake$site_url %in% "hangthebankers.com")] <- "bias"
fake$type[which(fake$site_url %in% "healthimpactnews.com")] <- "junksci"
fake$type[which(fake$site_url %in% "henrymakow.com")] <- "fake"
fake$type[which(fake$site_url %in% "humansarefree.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "ihavethetruth.com")] <- "bias"
fake$type[which(fake$site_url %in% "ijr.com")] <- "bias"
fake$type[which(fake$site_url %in% "in5d.com")] <- "junksci"
fake$type[which(fake$site_url %in% "indiaarising.com")] <- "bait"
fake$type[which(fake$site_url %in% "informationclearinghouse.info")] <- "conspiracy"
fake$type[which(fake$site_url %in% "intellihub.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "intrepidreport.com")] <- "bias"
fake$type[which(fake$site_url %in% "investmentresearchdynamics.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "investmentwatchblog.com")] <- "bias"
fake$type[which(fake$site_url %in% "lewrockwell.com")] <- "bias"
fake$type[which(fake$site_url %in% "liberalamerica.org")] <- "bait"
fake$type[which(fake$site_url %in% "libertyunyielding.com")] <- "bias"
fake$type[which(fake$site_url %in% "ncscooper.com")] <- "satire"
fake$type[which(fake$site_url %in% "newsbiscuit.com")] <- "fake"
fake$type[which(fake$site_url %in% "occupydemocrats.com")] <- "bait"
fake$type[which(fake$site_url %in% "other98.com")] <- "fake"
fake$type[which(fake$site_url %in% "pakalertpress.com")] <- "fake"
fake$type[which(fake$site_url %in% "realfarmacy.com")] <- "junksci"
fake$type[which(fake$site_url %in% "redflagnews.com")] <- "bias"
fake$type[which(fake$site_url %in% "reductress.com")] <- "satire"
fake$type[which(fake$site_url %in% "zerohedge.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "yournewswire.com")] <- "bait"
fake$type[which(fake$site_url %in% "wundergroundmusic.com")] <- "satire"
fake$type[which(fake$site_url %in% "worldtruth.tv")] <- "conspiracy"
fake$type[which(fake$site_url %in% "wikileaks.org")] <- "rumor"
fake$type[which(fake$site_url %in% "whydontyoutrythis.com")] <- "junksci"
fake$type[which(fake$site_url %in% "waterfordwhispersnews.com")] <- "satire"
fake$type[which(fake$site_url %in% "washingtonsblog.com")] <- "bias"
fake$type[which(fake$site_url %in% "veteranstoday.com")] <- "bias"
fake$type[which(fake$site_url %in% "usuncut.com")] <- "bait"
fake$type[which(fake$site_url %in% "usasupreme.com")] <- "fake"
fake$type[which(fake$site_url %in% "ufoholic.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "twitchy.com")] <- "bait"
fake$type[which(fake$site_url %in% "truthfrequencyradio.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "truthfeed.com")] <- "hate"
fake$type[which(fake$site_url %in% "theonion.com")] <- "satire"
fake$type[which(fake$site_url %in% "thefreethoughtproject.com")] <- "bait"
fake$type[which(fake$site_url %in% "thedailysheeple.com")] <- "conspiracy"
fake$type[which(fake$site_url %in% "thedailymash.co.uk")] <- "satire"
fake$type <- as.factor(fake$type)

processed_fake$author[which(processed_fake$author %in% "Doc Farmer✓\u1d5b\u1d49ʳ\u1da6\u1da0\u1da6\u1d49\u1d48 \u1d48\u1d49\u1d56ˡ\u1d52ʳ\u1d43\u1d47ˡ\u1d49")] <- "DocFarmer"

processed_fake$author[which(processed_fake$author %in% "LinTaylor ✓vitrified")] <- "LinTaylor"

processed_fake$author[which(processed_fake$author %in% "MarciaTheMurkyMuse\U0001f320 Variegated")] <- "MarciaTheMurkyMuse"

processed_fake$author[which(processed_fake$author %in% "Michelle ✓classified")] <- "Michelle"

processed_fake$author[which(processed_fake$author %in% "overboosted ✓\u1d30\u1d31\u1d3e\u1d38\u1d3c\u1d3f\u1d2c\u1d2e\u1d38\u1d31")] <- "overboosted"

write.csv(fake, "/Users/setaresarachi/Desktop/fake.csv")
#Adding Weekday as a column
library(lubridate)
substr_published <- substr(fake$crawled, 1, 10)
crawled_weekday <- weekdays(as.POSIXlt(substr_published, format="%Y-%m-/%d"))
crawled_weekday<- as.factor(crawled_weekday)
fake<- cbind(fake,crawled_weekday)
