---
title: "BSAN 460 R Project: Enron Emails - Classifying Persons of Interest (POI)"
author: "Group 7: Cappy Kan, Zion Taber, Samantha Gilpin, Trang Tran"
date: "DD/MM/YYYY"
output: html_document
---
Importing the Dataset
```{r}
library(readr)
getwd()
setwd("F:/BSAN 460-001/Project")
#import (Enron) emails.csv
emails <- read.csv("emails.csv")
str(emails)
summary(emails)
```


Loading Libraries and NLP Packages
```{r}
library(dplyr)
library(tm)
library(textstem)
# during the course we may need to add additional packages for different analyses
```


Text Pre-Processing
```{r}
# changing data types (i.e. factor --> character, factor --> numeric, etc)

# bring to lower case
emails <- emails %>% mutate(emails_lower = tolower(Content))

# remove/add stopwords
## stopwords dictionary = stopwords('en')
## add
c(stopwords('en'), "#STOPWORD(S) WE WANT TO ADD")

## remove
stopwords_regex = paste(#INSERT ## add code HERE, collapse = '\\b|\\b') # collapses the data
emails <- emails %>% mutate(emails_noStopWords = gsub(stopwords_regex,'',emails_lower))

# remove tags/usernames (if we remove usernames how/what other way will we classify persons?)
emails <- emails %>% mutate(emails_noTags = gsub('@\\w*','',emails_noStopWords))

# remove URLs
emails <- emails %>% mutate(emails_noURL = gsub('http.*\\s','',emails_noTags))

# remove punctuation
emails <- emails %>% mutate(emails_noPunctuation = gsub('[[:punct:]]','',emails_noURL))

# remove/replace certain words/Typos
## WE NEED TO LOOK AT THE DATA. HOW WOULD WE DO THIS EFFICIENTLY?


# remove white space
emails <- emails %>% mutate(emails_noSpaces = gsub('\\s+',' ',emailst_noTypos))

# apply lemmatization
emails <- emails %>% mutate(emails_Lemma = lemmatize_strings(emails_noSpaces))

# apply stemming
emails <- emails %>% mutate(emails_Stem = stem_strings(emails_noSpaces))
```


Text Pre-Processing II
```{r}
# Keep sentiment for further modeling
emails <- emails %>% select(Sentiment, emails_Lemma)

# transform data frame into corpus
emails_corpus <- Corpus(VectorSource(emails$emails_Lemma))

# Tf-Idf
emails_tfidf <- DocumentTermMatrix(emails_corpus, control = list(weighting = weightTfIdf)) #DTM(name, control parameter)
emails_tfidf

# remove sparse terms
emails_tfidf_sparse <-  removeSparseTerms(emails_tfidf, 0.99) # <-- we can change this percentage if we want 
emails_tfidf_sparse

# transform Tf-Idf into a dataframe
emails_data_frame <- as.data.frame(as.matrix(emails_tfidf_sparse))
dim(emails_data_frame)
dim(emails) 

emails_data_frame <- cbind(sentiment = emails$Sentiment, emails_data_frame) # concatenate the two columns
str(emails_data_frame) # there are 111 columns: 1 for the sentiment and 110 for terms
```



