Instructions <- function() {
  return(tags$section(
    tags$p(
      paste('Add instructions here when the summary is completed.',
            sep = '')
    ),
    tags$div(tags$h3('Valence Filter'),
             tags$p(paste('...',
                          sep = ''))),
    tags$div(tags$h3('Categories'),
             tags$p(paste('...',
                          sep = ''))),
    tags$div(tags$h3('Departments'),
             tags$p(paste('...',
                          sep = ''))),
    tags$div(tags$h3('Year Selection'),
             tags$p(paste('...',
                          sep = '')))
  ))
}
