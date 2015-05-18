f <- file(description="stdin")
input <- try(read.csv(f,sep=",",header=F,stringsAsFactors=F,na.strings = "\\N"),silent =T)
if (attr(input,"class") != "try-error"){
  bloco.chave <- unique(input[,1])
  for (i in bloco.chave){
    id.bloco <- which(input[,1]==i)
    matrix.input <-  as.matrix(input[id.bloco,4:ncol(input)]) 
    rownames(matrix.input) <- input[id.bloco,3]
    distance <- dist(matrix.input)
    distance <- data.frame(t(combn(rownames(matrix.input),2)), as.numeric(distance))
    bloco.chave.cond <- unlist(strsplit(i,"-"))
    if(bloco.chave.cond[1]==bloco.chave.cond[2]){
      write.table(distance,stdout(),row.names=F,col.names=F,quote=F,sep=",",na ="")
    }else{
      bloco.1 <-input[ (input[,1]==i) & (input[,2]==bloco.chave.cond[1]),3] 
      bloco.2 <-input[(input[,1]==i) & (input[,2]==bloco.chave.cond[2]),3]
      comb.user <- expand.grid(bloco.1,bloco.2)
      distance.final <-distance[ ((distance[,1] %in% comb.user[,1]) & (distance[,2] %in% comb.user[,2])) | 
                                   ((distance[,1] %in% comb.user[,2]) & (distance[,2] %in% comb.user[,1])),]
      write.table(distance.final,stdout(),row.names=F,col.names=F,quote=F,sep=",",na ="")
    }
  }
}

