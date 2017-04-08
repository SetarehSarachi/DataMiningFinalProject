#Input raw data
fake<- read.csv("/Users/setaresarachi/Downloads/fake.csv", header = T, fileEncoding = "UTF-8")
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

