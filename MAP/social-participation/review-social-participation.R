# knitr::stitch_rmd(script="./reports/review-variables/map/review-variables-map.R", output="./reports/review-variables/map/review-variables-map.md")
#These first few lines run only when the file is run in RStudio, !!NOT when an Rmd/Rnw file calls it!!
rm(list=ls(all=TRUE))  #Clear the variables from previous runs.
cat("\f") # clear console 

# ---- load-packages -----------------------------------------------------------
# Attach these packages so their functions don't need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
library(magrittr) # enables piping : %>% 

# ---- load-sources ------------------------------------------------------------
# Call `base::source()` on any repo file that defines functions needed below.  Ideally, no real operations are performed.
source("./scripts/functions-common.R") # used in multiple reports
source("./scripts/graphs/graphs-presets.R") # fonts, colors, themes 
source("./scripts/graphs/graphs-general.R")
source("./scripts/graphs/graphs-specific.R")
# Verify these packages are available on the machine, but their functions need to be qualified: http://r-pkgs.had.co.nz/namespace.html#search-path
requireNamespace("ggplot2") # graphing
# requireNamespace("readr") # data input
requireNamespace("tidyr") # data manipulation
requireNamespace("dplyr") # Avoid attaching dplyr, b/c its function names conflict with a lot of packages (esp base, stats, and plyr).
requireNamespace("testit")# For asserting conditions meet expected patterns.
# requireNamespace("car") # For it's `recode()` function.

# ---- declare-globals ---------------------------------------------------------

# ---- load-data ---------------------------------------------------------------
# load the product of 0-ellis-island.R,  a list object containing data and metadata
# data_path_input  <- "../MAP/data-unshared/derived/ds0.rds" # original 
dto <- readRDS("./data-unshared/derived/dto.rds") # local copy
# each element this list is another list:
names(dto)
# 3rd element - data set with unit data. Inspect the names of variables:
names(dto[["unitData"]])
# 4th element - dataset with augmented names and labels of the unit data
knitr::kable(head(dto[["metaData"]]))
# assing aliases
ds0 <- dto[["unitData"]]
ds <- ds0 # to leave a clean copy of the ds, before any manipulation takes place

# ---- meta-table --------------------------------------------------------
dto[["metaData"]] %>%  
  dplyr::select(-url,-notes) %>% 
  DT::datatable(
    class   = 'cell-border stripe',
    caption = "This is a dynamic table of the metadata file. Edit at `./data/meta/map/meta-data-map.csv",
    filter  = "top",
    options = list(pageLength = 6, autoWidth = TRUE)
  )


# ---- inspect-data -------------------------------------------------------------

# ---- tweak-data --------------------------------------------------------------

# ---- basic-table --------------------------------------------------------------


# ---- basic-graphs --------------------------------------------------------------
# this is how we can interact with the `dto` to call and graph data and metadata
dto[["metaData"]] %>% 
  dplyr::filter(type=="demographic") %>% 
  dplyr::select(name,name_new,label)

dto[["unitData"]]%>%
  histogram_continuous("age_death", bin_width=1)

dto[["unitData"]] %>%
  histogram_discrete("msex")


set.seed(1)
ids <- sample(ds$id,100)
d <- dto[["unitData"]] %>% dplyr::filter(id %in% ids)
g <- basic_line(d, "cogn_global", "fu_year", "salmon", .9, .1, T)
g

raw_smooth_lines_v2(d, "social_isolation")



# ---- attrition-pattern -------------------------------------------------------
# dto[["metaData"]] %>% dplyr::filter(name=="fu_year")
ds %>% 
  dplyr::group_by_("fu_year") %>%
  dplyr::summarize(sample_size=n())



# ---- define-utility-functions -----------------

print_label <- function(dto,varname){
  label <- dto$metaData %>% 
    dplyr::filter(name_new == varname) %>% 
    dplyr::select(label) %>% 
    as.character()
  return(label)
}
# print_label(dto,"soc_net")

print_variable <- function(dto,varname,sample_size=100, seed=1){
  set.seed(seed)
  ids <- sample(dto$unitData$id,100)
  d <- dto[["unitData"]] %>% dplyr::filter(id %in% ids)
  link <- dto$metaData %>% 
    dplyr::filter(name_new == varname) %>% 
    dplyr::select(url) %>% 
    as.character()
  # link <- paste0("(link)[",link,"]")
  # broswer()
  cat("\n##",varname,"\n")
  dto %>% print_label(varname) %>% print()
  cat("\n")
  cat("\nRandom sample of n =",sample_size," from total of N =",length(unique(dto$unitData$id))," respondents\n")
  cat("\n")
  raw_smooth_lines_v2(d, varname) 
  cat("\n")
  cat("\nLink to the online documentation: ",link) 
  cat("\n")
}

# print_variable(dto,"cogact_old")
# ----- print-variables -----------------------
for(vars in c("cogact_old","socact_old","soc_net","social_isolation")){
  print_variable(dto,vars)
}



# ---- reproduce ---------------------------------------
rmarkdown::render(
  input = "./reports/social-participation/social-participation.Rmd" ,
  output_format="html_document", clean=TRUE
)