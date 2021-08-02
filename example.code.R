source('BGLM.R')


# Suppose I have two local codes "code1" and "code2" that are needed to be mapped.
# Here I just use some random data to show how BGLM works, please replace with your EHR data in real applications. 
# local.code.data is a R list and each entry of it is a vector containing the observed lab-test values in patients. 
# DO NOT forget assigning names to each entry!!!
local.code.data <- list(
  code1 = rnorm(1000),
  code2 = rnorm(1000)
)

# 'MIMICIII.RData' stores a R list called "MIMICIII.loinc.code.data", which is used to construct eCDFs of LOINC codes.
# Each entry of MIMICIII.loinc.code.data is a vector that contains 1,000 oberseved values of the lab-test refered by the LOINC-code 
# In real applications, you can use it, or replace with your own data.
load('MIMICIII.RData')



# BGLM.rs is a list, the 'loinc.code.mapping' slot stores the mapping results
# Each row of BGLM.rs$loinc.code.mapping corresponds to a local code, the three columns are:
# query: the local code
# match: the mapped LOINC code
# Z.score: Z.score of the distance
BGLM.rs <- BGLM.mapping(local.code.data = local.code.data, loinc.code.data = MIMICIII.loinc.code.data)
View(BGLM.rs$loinc.code.mapping)

# If you want to access the full Z-score matrix, 'Z.score.matrix' slot contains that information
View(BGLM.rs$Z.score.matrix)




