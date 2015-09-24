PSAV v0.3
=========

## Calculate PSA Velocity
The application allows users to calculate PSA velocity using three methods from [Methods of calculating prostate-specific antigen velocity. Connolly D, et.al.](http://www.ncbi.nlm.nih.gov/pubmed/17197071)

1. Arithmetic equation of change in PSA over time (AE)  
2. Linear regression (LR)  
3. Rate of PSA change using first and last values only (FL)  


### Availability  
The source code and installation instructions for PSAV are available at https://github.com/oncogenetics/PSAV.

PSAV is made available under the MIT license.

### Required R Packages
```R
install.packages(c("shiny","ggplot2","DT","dplyr","MASS","markdown"), dependencies = TRUE)  
```

### Launch PSAV   
1. Online: https://zx8754.shinyapps.io/PSA_Velocity/
2. Locally using R console: To start PSAV, open R (RStudio recommended), copy the following code into the console and hit Return:   

```R
library(shiny)  
runGitHub("PSAV", "oncogenetics")
```

### Cite
**The IMPACT study**: **I**dentification of **M**en with a genetic predisposition to **P**rost**A**te **C**ancer: **T**argeted screening in men at higher genetic risk and controls

**Prostate-Specific Antigen Velocity as a Predictive Biomarker in a Prospective Prostate Cancer Screening Study of Men with Genetic Predisposition**

Christos Mikropoulos<sup>1+</sup>, Christina G. Selkirk<sup>3+</sup>, Sibel Saya<sup>1</sup> , Elizabeth Bancroft<sup>2</sup>, Tokhir Dadaev<sup>1</sup>, Charles Brendler<sup>3</sup>, Daniel A. Leongamornlert<sup>1</sup>, Elizabeth Page<sup>1</sup>, Natalie Taylor<sup>2</sup>, Edward Saunders<sup>1</sup>, Clara Cieza-Borrella<sup>1</sup>, Alexander Dias<sup>1</sup>, The IMPACT study collaborators, Sue Moss, Zsofia Kote-Jarai<sup>1</sup>,
Brian T. Helfand<sup>3++</sup>, Rosalind A. Eeles<sup>1,2++<sup>

1. The Institute of Cancer Research, 15 Cotswold Road, London, UK
2. The Royal Marsden NHS Foundation Trust, London, UK
3. Northshore University Health System, Evanston, Illinois, USA  
<sup>+</sup>Joint first Authors, <sup>++</sup>Joint Senior Authors


### Contact  
Questions, suggestions, and bug reports are welcome and appreciated.   
- Submit [suggestions and bug-reports](https://github.com/oncogenetics/PSAV/issues)   
- Contact email [T.Dadaev](mailto: tokhir.dadaev@icr.ac.uk)   

### To-do List
https://github.com/oncogenetics/PSAV/issues   


This application was created by [T.Dadaev](https://github.com/zx8754) and [Prof.R.Eeles team](http://www.icr.ac.uk/our-research/researchers-and-teams/professor-rosalind-eeles). 
