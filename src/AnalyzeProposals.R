AnalyzeProposals <- function(proposals) {
  # end.value is a temp variable - we'll only iterate through proposals
  # a few times so as to not kill our workstations when developing
  # end.value <- 8
  end.value <- length(proposals$Content)

  # Concatenate the raw text presented in a proposal
  for (i in 1:end.value) {
    text <- paste(proposals$Content[[i]]$body, collapse = '')
    proposals$Text[[i]] <- text
  }

  # Analyze the sentiment using the NRC datasource and syuzhet
  sentiments <- data.frame(get_nrc_sentiment(proposals$Text))
  sentiment.analysis <- sentiments %>%
    mutate(Valence = positive / negative)

  # Set common rownames, then merge based on them
  # (merge by=0 is the same as merging by rownames, and it adds the Row.names col in the process)
  rownames(sentiment.analysis) <- rownames(proposals)
  analysis <- merge(proposals, sentiment.analysis, by=0, all=TRUE)

  # We're done with the temp Row.names col and Content - delete them
  analysis[['Row.names']] <- NULL
  analysis$Content <- NULL

  # Return proposals with an analysis of their emotional valence.
  # NOTE: SOME VALUES MAY BE GENERIC. This is because we are using a placeholder iterator for development
  return(analysis)
}
