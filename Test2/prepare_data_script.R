library(dplyr)
library(tidytext)
library(textdata)
library(tm)
library(SentimentAnalysis)

CleanTweets <- read.csv("C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test2/Cleaned_Tweets_1.csv")

CleanTweets$text <- as.character(CleanTweets$text)

calculate_sentiment <- function(text) {
  sentiment <- analyzeSentiment(text)
  return(sentiment$SentimentGI)
}

CleanTweets$sentiment <- sapply(CleanTweets$text, calculate_sentiment)

CleanTweets$word_count <- sapply(strsplit(CleanTweets$text, "\s+"), length)

tweet_tokens <- CleanTweets %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  ungroup()

write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test2/Augmented_Cleaned_Tweets.csv", row.names = FALSE)

write.csv(tweet_tokens, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test2/Tweet_Tokens.csv", row.names = FALSE)
