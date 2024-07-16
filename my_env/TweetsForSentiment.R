# Load necessary libraries
library(dplyr)
library(tidytext)
library(textdata)
library(tm)
library(SentimentAnalysis)

# Read the cleaned CSV file
CleanTweets <- read.csv("C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Cleaned_Tweets_1.csv")

# Ensure the text column is character type
CleanTweets$text <- as.character(CleanTweets$text)

# Function to calculate sentiment score
calculate_sentiment <- function(text) {
  sentiment <- analyzeSentiment(text)
  return(sentiment$SentimentGI)
}

# Calculate sentiment score for each tweet
CleanTweets$sentiment <- sapply(CleanTweets$text, calculate_sentiment)

# Calculate word count for each tweet
CleanTweets$word_count <- sapply(strsplit(CleanTweets$text, "\\s+"), length)

# Prepare data for word cloud
# Create a tokenized version of the text column
tweet_tokens <- CleanTweets %>%
  unnest_tokens(word, text) %>%
  count(word, sort = TRUE) %>%
  ungroup()

# Save the augmented data to a new CSV file
write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Augmented_Cleaned_Tweets.csv", row.names = FALSE)

# Save the tokenized words for word cloud to a new CSV file
write.csv(tweet_tokens, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Tweet_Tokens.csv", row.names = FALSE)

# Save this R script
writeLines(c(
  'library(dplyr)',
  'library(tidytext)',
  'library(textdata)',
  'library(tm)',
  'library(SentimentAnalysis)',
  '',
  'CleanTweets <- read.csv("C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Cleaned_Tweets_1.csv")',
  '',
  'CleanTweets$text <- as.character(CleanTweets$text)',
  '',
  'calculate_sentiment <- function(text) {',
  '  sentiment <- analyzeSentiment(text)',
  '  return(sentiment$SentimentGI)',
  '}',
  '', 
  'CleanTweets$sentiment <- sapply(CleanTweets$text, calculate_sentiment)',
  '',
  'CleanTweets$word_count <- sapply(strsplit(CleanTweets$text, "\\s+"), length)',
  '',
  'tweet_tokens <- CleanTweets %>%',
  '  unnest_tokens(word, text) %>%',
  '  count(word, sort = TRUE) %>%',
  '  ungroup()',
  '',
  'write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Augmented_Cleaned_Tweets.csv", row.names = FALSE)',
  '',
  'write.csv(tweet_tokens, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Tweet_Tokens.csv", row.names = FALSE)'
), con = "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/prepare_data_script.R")
