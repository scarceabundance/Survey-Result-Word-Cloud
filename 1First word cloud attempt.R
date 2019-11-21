# Steps:
  # 1. Create Text Files
  # 2. Install word cloud packages
  # 3. Text Mine :)
  
  # Install
install.packages("tm")  # package for text mining
install.packages("SnowballC") # package for text stemming
install.packages("wordcloud") # word-cloud generator package
install.packages("RColorBrewer") # color palettes package
install.packages("Corpus")

# Load packages
library("tm")
library("SnowballC")
library("wordcloud")
library("RColorBrewer")
# these commands load the packages necessary to complete the word cloud
# for more info, type "?[name of package] (e.g. ?snowball)

text <- readLines(file.choose())
# make sure information rom other categories is a text file 
# Using description from OTHER non-violent crime category description 

docs <- Corpus(VectorSource(text))

inspect(docs)

toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
docs <- tm_map(docs, toSpace, "/")
docs <- tm_map(docs, toSpace, "@")
docs <- tm_map(docs, toSpace, "\\|")
docs <- tm_map(docs, toSpace, ":")
docs <- tm_map(docs, toSpace, "-")

# Convert the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Remove numbers
docs <- tm_map(docs, removeNumbers)
# Remove english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Remove your own stop word
# specify your stopwords as a character vector
docs <- tm_map(docs, removeWords, c("can", "make", "many", "know", "also", 
                                    "thought", "summit", "like", "especially", 
                                    "nothing", "think", "asked", "well", "need", 
                                    "day", "gets", "they", "get", "first", 
                                    "good", "ways", "missing", "see", "will", "already", "rate",
                                    "they", "students", "study", "departments", "one", "etc", "of", "in",
                                    "by", "" )) 
# Remove punctuat
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
#head = # of rows
head(d, 30)
docs <- tm_map(docs, removePunctuation)
# most used keyword in OTHER descripton: court, theft, mail, contempt, order, violation, probation

docs <- tm_map(docs, stripWhitespace)
# Text stemming
docs <- tm_map


set.seed(1234)
wordcloud(words = d$word, freq = d$freq, min.freq = 1,
          max.words=30, random.order=TRUE, rot.per=0.35, 
          colors="navy")
# this produces the keyword cloud 