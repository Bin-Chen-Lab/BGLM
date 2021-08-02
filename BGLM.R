library(foreach)
library(dplyr)

compute.distance.between.eCDF <- function(x,y) {
    (ks.test(x,y)$statistic) 
}


BGLM.mapping <- function(local.code.data, loinc.code.data){
    
    dist.matrix <- foreach(x = local.code.data,.combine='rbind') %do% {
        dist.vec <- foreach(o = loinc.code.data,.combine='c') %do% {
            compute.distance.between.eCDF(x,o)
        }
        scale(dist.vec) %>% c
    }
    rownames(dist.matrix) <- names(local.code.data)
    colnames(dist.matrix) <- names(loinc.code.data)  
  
    
    min.dist.code        <- apply(dist.matrix,1, function(x) names(loinc.code.data)[which(x == min(x))[1]]  )
    mapping.df            <- data.frame(query = rownames(dist.matrix), match = min.dist.code)
    mapping.df$query      <- as.character(mapping.df$query)
    mapping.df$match      <- as.character(mapping.df$match)
    
    
    ss <- mapping.df$match %>% as.character()
    tt <- mapping.df$query %>% as.character()
    v <- foreach(i = 1:length(tt),.combine='c') %do% {
        dist.matrix[tt[i], ss[i]]
    }
    mapping.df$Z.score <- v
    
    list(Z.score.matrix = dist.matrix, loinc.code.mapping = mapping.df)
    
}





