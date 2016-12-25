library(xlsx)
#install.packages('RecordLinkage')
library(RecordLinkage)

df <- read.xlsx('/home/ankur/ankur/data_science/data/others/Assessment-1/comments-bucketing-data.xlsx',1)

train <- df[1:21070,]
train <- data.frame(lapply(train, as.character), stringsAsFactors=FALSE)
train$feat <- paste(train$Comments,train$MSC.Code,train$Calculation,train$Vehicle)

test  <-df[21071:21080,]
test <- data.frame(lapply(test, as.character), stringsAsFactors=FALSE)
test$feat <- paste(test$Comments,test$MSC.Code,test$Calculation,test$Vehicle)

#Finding the nearest neighbor
findKNN <- function(text,pattern)
{
  for(i in 1:nrow(text))
  {
    dis <- levenshteinSim(text[i,6],pattern)
    text[i,7] <- (1-dis) 
    if((1-dis) == 0)
      break;
  }
  text <- text[order(text$V7),]
  return(text$Comments.BUCKET[1])
}



for(i in 1:nrow(test))
{
  test$Comments.BUCKET[i] = findKNN(train,test$feat[i])
}

test$feat <- NULL

write.xlsx(test,file="/home/ankur/ankur/data_science/data/others/Assessment-1/test.xlsx")