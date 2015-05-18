args <- commandArgs(TRUE)
blocos <- as.numeric(args[1])

f <- file(description="stdin")
input <- read.csv(f,sep=",",header=F,stringsAsFactors=F,na.strings = "\\N")

comb.blocos <- expand.grid(1:blocos,1:blocos)
comb.blocos <- comb.blocos[comb.blocos[,1]<=comb.blocos[,2],]

input$chave.bloco <- input[,1] %% blocos +1

for (i in 1:nrow(comb.blocos)){
  if(comb.blocos[i,1]==comb.blocos[i,2]){
    id <- which(input$chave.bloco==comb.blocos[i,1])
    write.table(cbind(paste0(comb.blocos[i,1],"-",comb.blocos[i,2]),input$chave.bloco[id],input[id,1:(ncol(input)-1)]),stdout(),row.names=F,col.names=F,quote=F,sep=",",na ="")
  }else{
    id <- which( (input$chave.bloco==comb.blocos[i,1]) | (input$chave.bloco==comb.blocos[i,2])  )
    write.table(cbind(paste0(comb.blocos[i,1],"-",comb.blocos[i,2]),input$chave.bloco[id],input[id,1:(ncol(input)-1)]),stdout(),row.names=F,col.names=F,quote=F,sep=",",na ="")
  }
}


