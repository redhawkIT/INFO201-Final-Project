# end.value is a temp variable - we'll only iterate through proposals
# a few times so as to not kill our workstations when developing
# end.value <- length(proposals$content)
end.value <- 8

AnalyzeProposals <- function(proposals) {
  # Concatenate the raw text presented in a proposal
  for (i in 1:end.value) {
    text <- paste(proposals$Content[[i]]$body, collapse = '')
    proposals$Text[[i]] <- text
  }
  # Analyze the sentiment using the NRC datasource and syuzhet
  sentiments <- get_nrc_sentiment(proposals$Text)
  sentiment.data <- data.frame(sentiments)
  sentiment.analysis <- sentiment.data %>%
    mutate(Valence = positive / negative) %>%
    merge(proposals)
  return(sentiment.analysis)
}
