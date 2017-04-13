library(tm)
library(wordcloud)
library(memoise)

# The list of valid title
books <<- list("Bait" = "bait",
                "Bias" = "bias",
               "BullShit" = "bs",
               "Conspiracy" = "conspiracy",
               "Fake" = "fake",
               "Hate" = "hate",
               "JunkScience" = "junksci",
               "Satire" = "satire",
               "State" = "state")

# Using "memoise" to automatically cache the results
getTermMatrix <- memoise(function(title) {
  # Careful not to let just any name slip in here; a
  # malicious user could manipulate this value.
  if (!(title %in% books))
    stop("Unknown")
  
  text <- readLines(sprintf("./%s.txt.gz", title),
                    encoding="UTF-8")
  
 
  #Create Corpus
  myCorpus = Corpus(VectorSource(text))
  #Pre-Process
  myCorpus = tm_map(myCorpus, content_transformer(tolower))
  myCorpus = tm_map(myCorpus, removePunctuation)
  myCorpus = tm_map(myCorpus, removeNumbers)
  myCorpus <- tm_map(myCorpus, function(x) removeWords(x, stopwords("english")))
  myCorpus <- tm_map(myCorpus, stemDocument, language = "english") ## stemming
  myCorpus <- tm_map(myCorpus, stripWhitespace)
  
  myDTM = TermDocumentMatrix(myCorpus,
                             control = list(minWordLength = 1))
  
  m = as.matrix(myDTM)
  
  sort(rowSums(m), decreasing = TRUE)
})