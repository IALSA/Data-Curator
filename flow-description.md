Reproducing the initial data
===
NOTE: example using MAP study data preparation. Adjust for your study. 

The data used for the analysis can be reproduced by the following steps:


0. [./scripts/data/0-import-raw.R](https://github.com/IALSA/MAP/blob/master/scripts/data/0-import-raw.R) imports two original data files: the baseline measure (`data-unshared/raw/dataset_285_basic_03-2014.csv`)  and the longitudinal observations (`data-unshared/raw/dataset_285_long_03-2014.csv`).  Files are merged and saved into an object `data-unshared/derived/ds0_raw.rds`.

1. [./scripts/data/1-apply-codebook](https://github.com/IALSA/MAP/blob/master/scripts/data/1-apply-codebook.R) attaches descriptive labels to selected variables of the `ds0_raw.rds` data file using the meta-data from the [data-unshared/raw/Codebook-IALSA-03-2014.pdf](). Saves the data into `ds0.rds`  object. 

2. [./scripts/data/2-transformations](https://github.com/IALSA/MAP/blob/master/scripts/data/2-transformations.R) transforms the `ds0.rds' object and prepares it for analysis


Download the repo and use [`./utility/reproduce.R`](https://github.com/IALSA/MAP/blob/master/utility/reproduce.R) to produce derived data.


