# UW Student Technology - Funding Statistics

Every student at the University of Washington pays a mandatory $38 quarterly fee to fund student technology projects. This funding is managed by a student organization chartered by the State of Washington Legislature and the UW Board of Regents known as the Student Technology Committee. The Committee issues a request for proposals (RFP) annually for departments to come and pitch technology projects that directly benefit the student body. This process is entirely transparent, as the Committee is bound by the Open Public Meetings Act (RCW 42.30) to disclose data on all proposals, including exact minutes from all Committee meetings and deliberations.

## Project Overview

This project leverages information provided by the UW Student Technology Committee API about campus technology projects to determine the following:

- *For students*, where are their funds going? Is there bias in the way their funds are used to support projects?
- *For departments*, what elements of a proposal contribute to its success? Could you build rapport with the commitee and ask for more money year-to-year? Is seeking endorsements worthwhile?
- *For researchers*, what are the modulating factors that determine the success of a proposal? Could the degree to which emotions are woven into a project's narrative be a determining factor in committee decisions?

We are able to provide data to answer these questions by drawing raw proposal data directly from the Student Technology Committee API, quantifying the financial aspects and endorsements for proposals, and performing linguistic analysis of the raw proposal text.

## Interface

This web application provides several different visualizations, each allowing users to analyze the data with exacting details. The sidebar contains filters for the core dataset, allowing you to filter by:

- *Valence* - How positive or negative the proposal's project plan is, determined via linguistic analysis of the proposal's diction.
- *Categories* - Filtering by the kind of proposal (collaborative projects, computer labs, etc)
- *Year* - What fiscal year the proposal falls under. The committee leadership changes completely year-to-year, so this can make a huge difference.

### Graphical analysis

#### Bar Graph

Visualizes the emotional profile of a proposal's content via a count of the emotionally charged words in said content. For example, a large amount of proposals use diction that is heavily associated with the concept of "Trust", suggesting that proposal authors have a large degree of faith in the committee.

#### Scatterplot

Visualizes the valence (positivity) of a proposal's content vs the amount of money the proposal received as an award. Filtering this by category will show that various categories have differing degrees of general valence present in the content of an average proposal.

### Tabular Analysis

Provides a rich, searchable table that summarizes all the proposals matching filter conditions and providing high level data such as the associated organizations, total request and award, and overall valence.

### Summary Table

#### Category Summary

Summarizes metrics of proposals by category, including the average amount authors in a category request and receive, including the median award.

#### Valence Summary

Summarizes proposals in terms of their emotional valence in ranges with a step value of 5. This correlates emotional valence vs the average request and award values, suggesting little to no relationship between the emotional spectrum of a proposal vs the actual funding it receives.

#### Endorsement Summary

Summarizes the relationship between the amount of community endorsements a proposal receives (step value of 5) and the amount of funding it actually receives in relation to the original ask. The data here suggests a positive relationship between community endorsement of a proposal and the likelihood of it being approved by the committee.

## Implementation Details

This was developed with R, using ggplot2 for data visualizations and shiny as a web server. We used shinyapp.io as our hosting source. Unfortunately, we are experiencing difficulties resolving HTTPS connections when the shinyapp.io domain sends queries to the UWSTF api. After pulling the logs we were able to verify that this is an issue with the shinyapp.io SaaS and not the API itself (logs and further details included w/ the canvas submission).

## Sources
- Linguistic Analysis: [NRC Dataset](https://cran.r-project.org/web/packages/syuzhet/syuzhet.pdf) (provided with the R package "syuzhet")
Open Public Meetings Act: [RCW 42.30](http://apps.leg.wa.gov/RCW/default.aspx?cite=42.30)
Data Source (Student Fees): [UW Office of Planning and Budgeting](http://opb.washington.edu/sites/default/files/opb/Tuition/2016-17%20Tuition%20&%20Fee%20History.pdf)
Data Source (Projects and Expenditures): [UW Student Technology Fee API](https://uwstf.org/api)
