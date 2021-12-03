#List of Pairs as Appearing in Data
unique(cwbcor$variables) #361 is correct!, but only need 171
rhocwb<-NULL
rhocwb<-tibble(variables=unique(cwbcor$variables), 
               rho=numeric(361),
               rlb=numeric(361),
               rub=numeric(361))
rhocwb<-rhocwb[c(-1,-21,-41,-61,-81,-101,-121, -141,
                 -161,-181,-201,-221,-241,-261,-281,
                 -301,-321,-341,-361),]
#Loop for all meta-analyses
i<-1
for (i in 1:361) {
  data<-filter(cwbcor,variables==as.character(rhocwb[i,1]))
  dat<-escalc(measure="ZCOR", ri=ri, ni=ni, data=data, slab=study)
  res <- rma(yi, vi, data=dat)
  stats<-predict(res,digits=3,transf=transf.ztor)
  rhocwb$rho[i]<-stats[[1]]
  rhocwb$rlb[i]<-stats[[3]]
  rhocwb$rub[i]<-stats[[4]]
}
