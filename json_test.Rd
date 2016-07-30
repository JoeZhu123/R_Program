install.packages("RJSONIO")
library("RJSONIO")
#解析JSON
fromJSON()
#生成JSon,数据框生成
name=c(1:5)
value=c(6:10)
da=data.frame(name,value)
da
cat(toJSON(da))
#键值对JSON生成
dad=as.matrix(da)
dad
cat(toJSON(dad))
#生成JSON文件
s=toJSON(dad)
writeLines(s,"fin.json")
#列表转JSON
a=c(1,1)
a1=c(2,2)
a2=c(3,3)
dd=list(a,a1,a2)
cat(toJSON(dd))
#矩阵转列表，每行当做一个list的元组
origin.matrix=dd
rn<-nrow(origin.matrix);#矩阵行数
cn<-ncol(origin.matrix);#矩阵列数
m<-1;#设置最后输出文件的第一行行号
result.list<-list();#设置最后输出文件的列表格式名
for(i in 1:rn){
	result.list[[m]]<-origin.matrix[[i,1]];
	result.list[[m]][2]<-origin.matrix[[i,2]];
	result.list[[m]][3]<-origin.matrix[[i,2]];
	m<-m+1;
}
cat(toJSON(result.list))
#矩阵列表，输出坐标和值
origin.matrix=d
library(stringr);



