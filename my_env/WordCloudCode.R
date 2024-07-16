# Load necessary libraries
library(dplyr)
library(tidytext)
library(textdata)
library(tm)
library(SentimentAnalysis)
library(stringr)

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

# Custom list of words to remove (e.g., URL fragments, specific terms)
custom_stop_words <- tibble(word = c("https", "tco", "gpt", "cdt", "jun"))

# Prepare data for word cloud
# Create a tokenized version of the text column
tweet_tokens <- CleanTweets %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_to_lower(word)) %>%
  mutate(word = str_replace_all(word, "[^a-zA-Z0-9]", "")) %>%
  filter(nchar(word) > 2) %>%
  anti_join(stop_words, by = "word") %>%
  anti_join(custom_stop_words, by = "word") %>%
  count(word, sort = TRUE) %>%
  ungroup()

# Merge tokenized words back with the original data
CleanTweets_long <- CleanTweets %>%
  unnest_tokens(word, text) %>%
  mutate(word = str_to_lower(word)) %>%
  mutate(word = str_replace_all(word, "[^a-zA-Z0-9]", "")) %>%
  filter(nchar(word) > 2) %>%
  anti_join(stop_words, by = "word") %>%
  anti_join(custom_stop_words, by = "word")

# Save the augmented data to a new CSV file
write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Augmented_Cleaned_Tweets.csv", row.names = FALSE)

# Save the tokenized and cleaned words for word cloud to a new CSV file
write.csv(tweet_tokens, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Tweet_Tokens_Cleaned.csv", row.names = FALSE)

# Save the long format data to a new CSV file
write.csv(CleanTweets_long, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Cleaned_Tweets_Long.csv", row.names = FALSE)

# Save this R script
writeLines(c(
  'library(dplyr)',
  'library(tidytext)',
  'library(textdata)',
  'library(tm)',
  'library(SentimentAnalysis)',
  'library(stringr)',
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
  'custom_stop_words <- tibble(word = c("https", "tco", "gpt", "cdt", "jun"))',
  '',
  'tweet_tokens <- CleanTweets %>%',
  '  unnest_tokens(word, text) %>%',
  '  mutate(word = str_to_lower(word)) %>%',
  '  mutate(word = str_replace_all(word, "[^a-zA-Z0-9]", "")) %>%',
  '  filter(nchar(word) > 2) %>%',
  '  anti_join(stop_words, by = "word") %>%',
  '  anti_join(custom_stop_words, by = "word") %>%',
  '  count(word, sort = TRUE) %>%',
  '  ungroup()',
  '',
  'CleanTweets_long <- CleanTweets %>%',
  '  unnest_tokens(word, text) %>%',
  '  mutate(word = str_to_lower(word)) %>%',
  '  mutate(word = str_replace_all(word, "[^a-zA-Z0-9]", "")) %>%',
  '  filter(nchar(word) > 2) %>%',
  '  anti_join(stop_words, by = "word") %>%',
  '  anti_join(custom_stop_words, by = "word")',
  '',
  'write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Augmented_Cleaned_Tweets.csv", row.names = FALSE)',
  '',
  'write.csv(tweet_tokens, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Tweet_Tokens_Cleaned.csv", row.names = FALSE)',
  '',
  'write.csv(CleanTweets_long, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Cleaned_Tweets_Long.csv", row.names = FALSE)'
), con = "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/prepare_data_script.R")
