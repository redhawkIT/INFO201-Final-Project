# The UWSTF API follows a REST query scheme
# http://restify.com/docs/client-guide/
# Per the Open Public Meetings Act (OPMA), the organization
# is obligated to provide open data. All routes pertaining to proposal
# data are open and free to query.
GetProposals <- function() {
  # Query for all proposals before this fiscal year (when the STF changed their RFP and text format)
  # https://uwstf.org/v2/proposal/?query={'year':'<2018'}&populate=['body']
  stf.api <- 'https://uwstf.org/v2'
  model <- 'proposal'
  query <- '"year":"<2018"'
  populate <- '"body"'
  
  resource <-
    sprintf('/%s/?query={%s}&populate=[%s]', model, query, populate)
  uri <- paste0(stf.api, resource)
  
  response <- GET(uri)
  proposals <-  fromJSON(httr::content(response, 'text'))
  
  # Select legacy proposal data
  data <- flatten(proposals) %>%
    filter(published == TRUE) %>%
    filter(length(body.legacy) > 0) %>%
    select(
      # Backtick syntax allows us to select columns with whitespace/special chars
      'ID' = `_id`,
      'Title' = title,
      'Year' = year,
      'Quarter' = quarter,
      'Organization' = organization,
      'Category' = category,
      'Content' = body.legacy,
      'Status' = status,
      'Asked' = asked,
      'Received' = received,
      'Endorsements' = comments
    )
  
  # Iterate through proposals, patching holes in data
  for (i in 1:length(data$ID)) {
    # Set endorsement count
    data$Endorsements[[i]] <- length(data$Endorsements[[i]])
    # Fix n/a values in the Received field
    if (is.na(data$Received[[i]]) || data$Received[[i]] <= 0) {
      data$Received[[i]] <- 0
    }
    # Create a boolean for Approved - for exploratory analysis
    if (data$Status[[i]] == 'Funded' || data$Status[[i]] == 'Partially Funded') {
      data$Approved[[i]] <- TRUE
    } else {
      data$Approved[[i]] <- FALSE
    }
  }
  # Set rownames as UUIDS (can't be done in dplyr pipes) and delete the original col
  rownames(data) <- data$ID
  data$ID <- NULL

 return(data)
}
