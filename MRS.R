###############################################################################################
##################        Creating Metabolites Risk Score   ###################################
##################        Author: Shan He                   ###################################
##################        Date: Dec 30th 2020               ###################################
###############################################################################################

## Extract Target Population's Metabolites and Calculate Standard Deviation
# metab_total is the dataset with all target population with their corresponding metabolites measures
SDnrn_total <- apply(metab_total,2,sd) # named list
SDnrn_total <- cbind(as.character(data.frame(name=names(SDnrn_total),SD=SDnrn_total)[,1]),
                     data.frame(name=names(SDnrn_total),SD=SDnrn_total)[,2])
colnames(SDnrn_total) = c("Metabolites","SD_total")


## Extract Study Population (subset of target populaion)'s Metabolites and Calculate Standard Deviation
# metab_inca is the dataset with only study population with their corresponding metabolites measures
SDnrn_inca <- apply(metab_inca,2,sd) # named list
SDnrn_inca <- cbind(as.character(data.frame(name=names(SDnrn_inca),SD=SDnrn_inca)[,1]),
                    data.frame(name=names(SDnrn_inca),SD=SDnrn_inca)[,2])
colnames(SDnrn_inca) = c("Metabolites","SD_inca")


## Merge it with Lasso selected metabolites
coef_lasso = read.csv("~~~~")
colnames(coef_lasso) <- c("Metabolites","Weights") # lasso metabolites and beta coefficients
SD_mk_total <- merge(coef_lasso,SDnrn_total,by="Metabolites")[,3]
SD_mk_inca <- merge(coef_lasso,SDnrn_inca,by="Metabolites")[,3]


## Construct table for creating scores
score_table <- data.frame(cbind(coef_lasso[,1],
                                coef_lasso[,2],
                                SD_mk_total,
                                SD_mk_inca))
colnames(score_table) = c("Metabolites","Beta_LASSO","SD_total","SD_inca")
score_table$Beta_LASSO = as.numeric(score_table$Beta_LASSO)
score_table$SD_total = as.numeric(score_table$SD_total)
score_table$SD_inca = as.numeric(score_table$SD_inca)

## Create score variables using all lasso selected metabolites
# metab_total_rn is your study population data set
score_new = matrix(0,nrow(metab_total_rn),nrow(score_table))

for (i in 1:nrow(metab_total_rn)){
  for (a in 1:nrow(score_table)){
    ind = which(coef_lasso[a,1]==score_table$Metabolites)
    score_new[i,a] = metab_total_rn[i,which(coef_lasso[a,1]==names(metab_total_rn))]*score_table[ind,2]*(score_table[ ind,3]/score_table[ind,4])
  }
}
metab_total_rn$all_score_new = apply(score_new,1,mean)


## Create pos_score variables using lasso selected protective metabolites
lasso_result_pos = coef_lasso[which(coef_lasso$Weight<0),]
pos_score_new = matrix(0,nrow(metab_total_rn),nrow(lasso_result_pos))

for (i in 1:nrow(metab_total_rn)){
  for (a in 1:nrow(lasso_result_pos)){
    ind = which(lasso_result_pos[a,1]==score_table$Metabolites)
    pos_score_new[i,a] = metab_total_rn[i,which(lasso_result_pos[a,1]==names(metab_total_rn))]*score_table[ind,2]*(score_table[ind,3]/score_table[ind,4])
  }
}
metab_total_rn$positive_score_new = apply(pos_score_new,1,mean)


## Create neg_score variables using lasso selected harmful metabolites
lasso_result_neg = coef_lasso[which(coef_lasso$Weight>0),]
neg_score_new = matrix(0,nrow(metab_total_rn),nrow(lasso_result_neg))

for (i in 1:nrow(metab_total_rn)){
  for (a in 1:nrow(lasso_result_neg)){
    ind = which(lasso_result_neg[a,1]==score_table$Metabolites)
    neg_score_new[i,a] = metab_total_rn[i,which(lasso_result_neg[a,1]==names(metab_total_rn))]*score_table[ind,2]*(score_table[ind,3]/score_table[ind,4])
  }
}
metab_total_rn$negative_score_new = apply(neg_score_new,1,mean)
