# The UWSTF API follows a REST query scheme
# http://restify.com/docs/client-guide/
# Per the Open Public Meetings Act (OPMA), the organization
# is obligated to provide open data. All routes pertaining to proposal
# data are open and free to query.
GetProposals <- function() {
  # Query for all proposals before this fiscal year (when the STF changed their RFP and text format)
  # https://uwstf.org/v2/proposal/?query={"year":"<2018"}&populate=["body"]
  stf.api <- "https://uwstf.org/v2"
  model <- 'proposal'
  query <- '"year":"<2018"'
  populate <- '"body"'
  
  resource <- sprintf('/%s/?query={%s}&populate=[%s]', model, query, populate)
  uri <- paste0(stf.api, resource)
  
  response <- GET(uri)
  proposals <-  fromJSON(httr::content(response, "text"))
  # rownames(proposals) <- proposals[[1]]
  
  # Select legacy proposal data
  data <- flatten(proposals) %>%
    filter(published == TRUE) %>%
    filter(length(body.legacy) > 0) %>%
    select(
      'Title' = title,
      'Year' = year,
      'Quarter' = quarter,
      'Organization' = organization,
      'Category' = category,
      'Content' = body.legacy,
      'Status' = status,
      'Asked' = asked,
      'Received' = received
    )

  return(data)
}
