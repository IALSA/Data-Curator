
The repo that curates a longitudinal study has the following structure:

#### folder structure

```
./data-unshared/ 		    
./data-unshared/raw/                  
./data-unshared/derived/  
```
Raw and derived data objects. 


```
./libs/  
./libs/css/            
./libs/images/   
./libs/.../  
```
Support files such libraries, images, and documents used throughout the repository.  


```
./sandbox/   
./sandbox/.../   
```
Dynamic reports in crafting. Each report (family of reports) gets a subfolder. 


```
./scripts/   
./scripts/data/   
./scripts/examples/   
./scripts/examples/manipulation/  
./scripts/examples/analysis/   
./scripts/graphs/   
./scripts/sandbox/
./scripts/users/   
./scripts/.../   
```
Scripts, templates, and snippets of R code clustered into subfolders according the to context and purpose of their usage. 


```
./utility/  
```
Help configuring the local machine, install packages, and reproducing the project. 


## Files in the root
```
./.gitignore                   # controls what is shared/uploaded
./flow-description.md          # how to reproduce data preparation
./README.md                    # index page
./repo-file.md                 # site map
```