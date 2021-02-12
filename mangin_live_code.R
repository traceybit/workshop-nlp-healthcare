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



