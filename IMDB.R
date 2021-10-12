---
  title: "BSAN 460 R Project: IMDB - Modeling & Analysis for Faster Feedback"
author: "Group 7: Cappy Kan, Zion Taber, Samantha Gilpin, Trang Tran"
date: "DD/MM/YYYY"
output: html_document
---
# Set WD
getwd()
setwd("F:/BSAN 460-001/Project")

#import IMDB
imdb <- read.csv("IMDB Dataset.csv")
str(imdb)
summary(imdb)

# Loading Libraries and NLP Packages
library(dplyr)
library(tm)
library(textstem)
# during the course we may need to add additional packages for different analyses

# Text Pre-Processing

# bring to lower case
# remove numbers
# remove stopwords
# remove tags
# remove URLs
# remove punctuation
# remove white space
# apply stemming/ lemmatization

imdb <- imdb %>% mutate(review = tolower(review))
imdb <- imdb %>% mutate(review = gsub('[[:digit:]]','',review)) 
stopwords_regex = paste(stopwords('en'), collapse = '\\b|\\b')
imdb <- imdb %>% mutate(review = gsub(stopwords_regex,'',review)) 
imdb <- imdb %>% mutate(review = gsub('@\\w*','',review))
imdb <- imdb %>% mutate(review = gsub('http.*\\s','', review))
imdb <- imdb %>% mutate(review = gsub('[[:punct:]]','', review))
imdb <- imdb %>% mutate(review = gsub('\\s+',' ', review))
imdb <- imdb %>% mutate(imdb_lemma = lemmatize_strings(review))
imdb <- imdb %>% mutate(imdb_stem = stem_strings(review))

head(imdb)


removeHTML <- function(htmlString) {
  return(gsub("<.*?>", "", htmlString))
}

