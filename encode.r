##############################
# R语言中的编码和解码
# http://blog.fens.me/r-encode-decode/
##############################


setwd("C:/work/R/encrypt")

##############################
# base64
library(base64enc)
value<-"abc=!@#$%^&*()_+abc试试中文"
x <- charToRaw(value);x
y <- base64encode(x);y
z <- base64decode(y);z
a <- rawToChar(z);a


library(jsonlite)
value<-"abc=!@#$%^&*()_+abc试试中文"
a<-base64_enc(value);a
b<-rawToChar(base64_dec(a));b


#####################################
# 序列化
value<-"abc=!@#$%^&*()_+abc试试中文"
a<-serialize(value,NULL);a
b<-unserialize(a);b


dat<-mtcars[1:2,];dat
a<-serialize(dat,NULL);a
b<-unserialize(a);b


dat<-mtcars[1:2,];dat
s1 <- serializeJSON(dat);s1
s2 <- unserializeJSON(jsoncars);s2
identical(dat, s2)


#################################
# URL

url<-"http://blog.fens.me/abc=中@文&action=你 好"
a1<-URLencode(url);a1
b1<-URLdecode(a);b1

a2<-URLencode(url,reserved = TRUE);a2
b2<-URLdecode(a);b2






