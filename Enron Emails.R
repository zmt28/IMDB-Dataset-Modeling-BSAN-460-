---
title: "BSAN 460 R Project: Detecting Fraudulent Activity with Enron Emails"
author: "Group 10: Cappy Kan, Zion Taber, Samantha Gilpin, Trang Tran "
date: "DD/MM/YYYY"
output: html_document
editor_options: 
chunk_output_type: console
---
  
Importing Data
```{r}
library(readr)
getwd()
setwd("F:/BSAN 460-001/Project")
#import (Enron) emails.csv
emails <- read.csv("emails.csv")
str(emails)
summary(emails)
```



