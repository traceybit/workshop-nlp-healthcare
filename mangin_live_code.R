## Tracey Mangin
## workshop

## install libraries
install.packages(c("tm", "Matrix"))

## load libraries
library(tidyverse)
library(tm)
library(Matrix)

## documentation
data <- read.csv(url("https://ucdavisdatalab.github.io/workshop-nlp-healthcare/abstracts.csv"), stringsAsFactors=FALSE, encoding = "utf-8")

## inspect
str(data)

## what's interesting?
t <- data$text[1]

## we want to normalize the text, which means clean it up to make it easier to analyze.
## e.g., might want to convert to lower case... might want to get rid of punctuation
## seeing numbers, strange characters, etc.

## preprocessing
## --------------------------------

## How can we 'fix' these problemsn in R (after looking at the data)?

## corpus object
corpus <- Corpus(VectorSource(data$text))
inspect(corpus)

## corpus allows us to apply preprocessing

## lower
corpus <- tm_map(corpus, tolower)
## warning: document after having been operated on could be empty (and dropped from corpus)

## punctuation
corpus <- tm_map(corpus, removePunctuation, ucp = TRUE) ## ucp == TRUE provides additional characters

##  numbers 
corpus <- tm_map(corpus, removeNumbers)

## stopwords (e.g., and, the, is, a)
corpus <- tm_map(corpus, removeWords, stopwords("en"))


## represent the words as numbers
## -------------------------------------------------

## Bag of Words - for each word, how many times did it appear?
## -----------------------------------------

dtm <- DocumentTermMatrix(corpus)
dtm

inspect(dtm)

## Sparse Matrices
## document lengths; word counts
dtm.mat <- as.matrix(dtm)
document_length<- rowSums(dtm.mat)
document_length
head(sort(document_length, decreasing = TRUE), n = 10)
word_counts <- colSums(dtm.mat)
sorted <- sort(word_counts, decreasing = TRUE)
head(sorted)

## Term Frequency Inverse Document Frequency
## -------------------------------------------
## TF-IDF formula:
## tfidft(t,d,D) = tf(t,d) * idf(t,D)

## weighted dtm
tfidf_dtm <- weightTfIdf(dtm, normalize = TRUE)

## inspect
inspect(tfidf_dtm)

## compare most important terms for a given abstract
tf <- dtm.mat[10,]
most_important_tf = head(sort(tf, decreasing = TRUE), n = 10)

tfidf_dtm.mat <- as.matrix(tfidf_dtm)
tfidf <- tfidf_dtm.mat[10,]
most_important_tfidf <- head(sort(tfidf, decreasing = TRUE, n = 10))
most_important_tfidf


