library(dplyr)
library(tidytext)
library(textdata)
library(tm)
library(SentimentAnalysis)
library(stringr)

CleanTweets <- read.csv("C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/Cleaned_Tweets_1.csv")

CleanTweets$text <- as.character(CleanTweets$text)

calculate_sentiment <- function(text) {
  sentiment <- analyzeSentiment(text)
  return(sentiment$SentimentGI)
}

CleanTweets$sentiment <- sapply(CleanTweets$text, calculate_sentiment)

CleanTweets$word_count <- sapply(strsplit(CleanTweets$text, "\s+"), length)

custom_stop_words <- tibble(word = c("https", "tco", "gpt", "cdt", "jun"))

tweet_tokens <- CleanTweets %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_to_lower(word)) %>%
  mutate(word = str_replace_all(word, "[^a-zA-Z0-9]", "")) %>%
  filter(nchar(word) > 2) %>%
  anti_join(stop_words, by = "word") %>%
  anti_join(custom_stop_words, by = "word") %>%
  count(word, sort = TRUE) %>%
  ungroup()

CleanTweets_long <- CleanTweets %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_to_lower(word)) %>%
  mutate(word = str_replace_all(word, "[^a-zA-Z0-9]", "")) %>%
  filter(nchar(word) > 2) %>%
  anti_join(stop_words, by = "word") %>%
  anti_join(custom_stop_words, by = "word")

write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/Augmented_Cleaned_Tweets.csv", row.names = FALSE)

write.csv(tweet_tokens, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/Tweet_Tokens_Cleaned.csv", row.names = FALSE)

write.csv(CleanTweets_long, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/Cleaned_Tweets_Long.csv", row.names = FALSE)
