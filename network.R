library("RSNNS")
data <- read.table('/Users/xufly/Project/RProject/YearPredictionMSD.txt',header=FALSE,sep=",",fileEncoding = 'UTF-8')
#将数据顺序打乱
data = data[sample(1:nrow(data),length(1:nrow(data))),1:ncol(data)]
#训练数据
train=data[,2:91]
#将数据进行格式转换
labels = decodeClassLabels(data[,1])
#从中划分出70%训练样本和30%检验样本
split = splitForTrainingAndTest(train, labels, ratio=0.3)
#数据标准化 
split = normTrainingAndTestSet(split)
#size:hidden layers单元数目,由Komogorov定理确定
# maxit:最大迭代次数，
# learnFunc:这里指明使用BP
# learnFuncParams：BP的两个参数，一个学习率，一个误差值
model = mlp(split$inputsTrain,
            split$targetsTrain,
            size=181,maxit=100, 
            learnFunc = "Std_Backpropagation",
            learnFuncParams = c(0.2, 0),
            inputsTest=split$inputsTest,
            targetsTest=split$targetsTest)
#预测
predictions = predict(model,split$inputsTest)
#混淆矩阵
confusionMatrix(split$targetsTest,predictions)
 



