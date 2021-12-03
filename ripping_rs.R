#Loop through 25 studies

cwbcor<-tibble(study = character(), variables = character(), ni = numeric(), ri = numeric())
i<-k<-j<-1
for (k in 1:25) {
  data<-read_csv(paste("Data with 19/",studies[k],".csv",sep=""))
  nis<-as.numeric(nrow(na.omit(data)))
  pcors<-cor_auto(data, missing="pairwise") #Could turn this to detectordinal=F
  for (i in 1:19) {
    for (j in 1:19) {
      cwbcor<-add_row(cwbcor,
                      study = studies[k],
                      variables = paste(colnames(pcors)[j],rownames(pcors)[i], sep="-"),
                      ni = nis,
                      ri = pcors[i,j]
      )
    }
  }
}