##############################
# R语言创建哈希摘要digest
# http://blog.fens.me/r-crypto-hash-digest/
##############################


setwd("C:/work/R/encrypt")

######################################
library(digest)
value<-"abc=!@#$%^&*()_+abc试试中文"
# md5
md5<-getVDigest()
md5(value)
d1<-digest(value, algo="md5", serialize=TRUE);d1
d2<-digest(value, algo="md5", serialize=FALSE);d2

# sha1
digest(value, algo="sha1")
sha1_digest(value)
sha1(value,algo = "sha1") # digest <= 0.6.14

mysha1<-getVDigest("sha1")
mysha1(value)

# 加密算法
digest(value, algo="sha256")
digest(value, algo="sha512")
digest(value, algo="crc32")
digest(value, algo="xxhash32")
digest(value, algo="xxhash64")
digest(value, algo="murmur32")
digest(value, algo="spookyhash")
digest(value, algo="blake3")

########################
#计算基于哈希的消息身份验证码
hmac('fens.me', value, "md5")
hmac('fens.me', value, "sha1")



###
library(tools)
path<-paste0(.libPaths()[1],"/digest");path
dir(path)
file_md5<-paste0(path,"/MD5");file_md5
readLines(file_md5)
md5sum(paste0(path,"/DESCRIPTION"))
checkMD5sums("digest",path)



########################
#创建AES块密码对象
msg <- as.raw(c(1:16, 1:16))
key <- as.raw(1:16)
aes <- AES(key, mode="ECB")
aes$encrypt(msg)
aes$decrypt(aes$encrypt(msg), raw=TRUE)


