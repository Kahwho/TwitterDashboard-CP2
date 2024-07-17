# Read the CSV file
CleanTweets <- read.csv("C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/TestData.csv")

# Define the columns to be selected
selected_columns <- c("twitterUrl", "URL", "id", "text", "retweet.text", 
                      "retweetCount", "replyCount", "likeCount", "quoteCount", 
                      "createdAt", "bookmarkCount", "isRetweet", "isQuote")

# Check which of the selected columns are present in the data
available_columns <- selected_columns[selected_columns %in% colnames(CleanTweets)]

# Select the available columns
CleanTweets <- CleanTweets[, available_columns]

# Save the cleaned data to a new CSV file
write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/Cleaned_Tweets_1.csv", row.names = FALSE)

# Save this R script
writeLines(c(
  'CleanTweets <- read.csv("C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/TestData.csv")',
  '',
  'selected_columns <- c("twitterUrl", "URL", "id", "text", "retweet.text", ',
  '                      "retweetCount", "replyCount", "likeCount", "quoteCount", ',
  '                      "createdAt", "bookmarkCount", "isRetweet", "isQuote")',
  '',
  'available_columns <- selected_columns[selected_columns %in% colnames(CleanTweets)]',
  '',
  'CleanTweets <- CleanTweets[, available_columns]',
  '',
  'write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/Cleaned_Tweets_1.csv", row.names = FALSE)'
), con = "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/Test3/clean_data_script.R")
