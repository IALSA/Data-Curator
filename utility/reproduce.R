# knitr::stitch_rmd(script="./utility/reproduce.R", output="./utility/reproduce.md")
# template gives an example of MAP study data preparation. adjust as needed.

# Reproducible Research ---------------------------------------------------
#' When executed by R, this file will manipulate the original data sources (ie, ZZZZ)
#' to produce a groomed dataset suitable for analysis and graphing.
# see original at https://github.com/wibeasley/RAnalysisSkeleton/blob/master/utility/reproduce.R


# Clear memory from previous runs -----------------------------------------
base::rm(list=base::ls(all=TRUE))

# Check Working Directory -------------------------------------------------
#' Verify the working directory has been set correctly.  Much of the code assumes the working directory is the repository's root directory.
#' In the following line, rename `RAnalysisSkeleton` to your repository.
if( base::basename(base::getwd()) != "MAP" ) {
  base::stop("The working directory should be set to the root of the package/repository.  ",
       "It's currently set to `", base::getwd(), "`.")
}

# Install the necessary packages ------------------------------------------
path_install_packages <- "./utility/install-packages.R"
if( !file.exists(path_install_packages)) {
  base::stop("The file `", path_install_packages, "` was not found.  Make sure the working directory is set to the root of the repository.")
}
base::source(path_install_packages, local=new.env())

base::rm(path_install_packages)

# Load the necessary packages ---------------------------------------------
base::requireNamespace("base", quietly=T)
base::requireNamespace("knitr", quietly=T)
base::requireNamespace("markdown", quietly=T)
base::requireNamespace("testit", quietly=T)

######################################################################################################

# Declare the paths of the necessary files --------------------------------
#' The raw/input data files:
pathBaseline <- "./data-unshared/raw/dataset_285_basic_03-2014.csv"
pathLongitudinal <- "./data-unshared/raw/dataset_285_long_03-2014.csv"

#' Code Files:
pathImportRaw <- "./scripts/data/0-import-raw.R"
pathApplyCodebook <- "./scripts/data/1-apply-codebook.R"



# Verify the necessary path can be found ----------------------------------
#' The raw/input data files:
testit::assert("The baseline measure file should exist.", base::file.exists(pathBaseline))
testit::assert("The longitudinal measures file should exist.", base::file.exists(pathLongitudinal))

#' Code Files:
testit::assert("The file that imports raw data  should exist.", base::file.exists(pathImportRaw))
testit::assert("The file that applies codebook should exist.", base::file.exists(pathApplyCodebook))



# Run the files that manipulate and analyze -------------------------------
#' Execute code import raw data
base::source(pathImportRaw, local=base::new.env())

#' Assert that the intermediate files exist 
testit::assert("The raw import should exist.", base::file.exists("./data-unshared/derived/ds0_raw.rds"))

#' Execute code that applies codebook information to the raw import.
base::source(pathApplyCodebook, local=base::new.env())

#' Verify that the resultant datasets are present.
testit::assert("The RDS for processed import should exist.", base::file.exists("./data-unshared/derived/ds0.rds"))
testit::assert("The CSV for processed import should exist.", base::file.exists("./data-unshared/derived/ds0.csv"))
testit::assert("The DAT for processed import should exist.", base::file.exists("./data-unshared/derived/ds0.dat"))
testit::assert("The TXT with names for processed import should exist.", base::file.exists("./data-unshared/derived/ds0_varnames.txt"))


