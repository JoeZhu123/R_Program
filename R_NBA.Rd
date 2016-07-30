library(xlsx)
nba=read.xlsx("nba2013.xlsx",sheetIndex=1,header=T)
names(nba)	#列名
n=dim(nba);n	#481*32
str(nba)		#查看数据集内部结构
nba$allstar<-as.factor(nba$allstar)
nba1<-nba[,c(2,3,8,11,14,24,25,26,29,32)]	  #根据实际挑取某些变量
#names(nba1)

##下面：为分类变量pos(球员司职)创建指示变量并构造新的数据集
m1=rep(1,n[1])	#创建481个1
m0=rep(0,n[1])	
table(nba1$pos)		#分类有：C(中锋)、PF(大前锋)、PG(控卫)、SF(小前)、SG(分卫)、F(实际不存在)
nba1$posC=ifelse(nba1$pos=="C",m1,m0)	#条件成立为v1，否则为v0
nba1$posPF=ifelse(nba1$pos=="PF",m1,m0)
nba1$posPG=ifelse(nba1$pos=="PG",m1,m0)
nba1$posSF=ifelse(nba1$pos=="SF",m1,m0)
nba1$posSG=ifelse(nba1$pos=="SG",m1,m0)
#names(nba1)
nba2<-nba1[,-1]		#删去原pos变量
#str(nba2)

##下面：用全部数据进行logistic拟合
glm_model=glm(allstar~.,family=binomial,nba2)
summary(glm_model)
##结果不是很好，下面：根据AIC指标，逐步回归进行变量筛选
step(glm_model) 	#结果公式：allstar~age+fg+x3p+ast+blk+pts
names(nba2)
nba3<-nba2[,c(1,2,3,5,7,8,9)]	#根据上面结果选取最终变量

##构造训练集