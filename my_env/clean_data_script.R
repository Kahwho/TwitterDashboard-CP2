CleanTweets <- read.csv("C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/TestData.csv")

selected_columns <- c("twitterUrl", "URL", "id", "text", "retweet.text", 
                      "retweetCount", "replyCount", "likeCount", "quoteCount", 
                      "createdAt", "bookmarkCount", "isRetweet", "isQuote")

available_columns <- selected_columns[selected_columns %in% colnames(CleanTweets)]

CleanTweets <- CleanTweets[, available_columns]

write.csv(CleanTweets, "C:/Users/user/Desktop/Capstone 2/Codes for Tweets/my_env/Cleaned_Tweets_1.csv", row.names = FALSE)
