
setwd("C:/work/R/encrypt")

#########################################
#创建AES块密码对象

library(digest)

#### ECB
# First in ECB mode: the repeated block is coded the same way each time
msg<- as.raw(c(1:16,1:32));msg
key <- as.raw(1:16)#;key
aes <- AES(key, mode="ECB")
a<-aes$encrypt(msg)
b<-aes$decrypt(a, raw=TRUE);b


msg<- charToRaw("ABCDj@*（;dj! 测试一下中文");msg
key <- as.raw(1:16)
aes <- AES(key, mode="ECB")
a<-aes$encrypt(msg)
b<-aes$decrypt(a, raw=TRUE);b


# PKCS5填充
pkcs5_padding<-function(text){
  bit<-8
  if(!is.raw(text)){
    text<-charToRaw(text)
  }
  b<- bit - (length(text)+bit) %% bit
  c(text,as.raw(rep(as.hexmode(b),b)))
}

# PKCS7填充
pkcs7_padding<-function(text,bit=16){
  if(bit>256 | bit<1){
    stop("bit is not in 1-256")
  }
  if(!is.raw(text)){
    text<-charToRaw(text)
  }
  b<- bit - (length(text)+bit) %% bit
  c(text,as.raw(rep(as.hexmode(b),b)))
}

# PKCS7移除
pkcs_strip<-function(rtext){
  n<-length(rtext)
  pos<-as.integer(rtext[n])
  rtext[1:c(n-pos)]
}


#plaintext<-charToRaw("ABCDEFGHIJKLMNOPQ");plaintext
plaintext<-charToRaw("ABCDj@*（;dj! 测试一下中文");plaintext
ptext<-pkcs7_padding(plaintext);ptext
aes <- AES(key, mode="ECB")
a <- aes$encrypt(ptext);a
b<-aes$decrypt(a, raw=TRUE);b
pkcs7_strip(b)
rawToChar(pkcs7_strip(b))

## CBC
# Now in CBC mode:  each encoding is different
# Need a new object for decryption in CBC mode
msg<- as.raw(c(1:16,1:32));msg
key <- as.raw(1:16)#;key
iv <- rand_bytes(16)#;iv
aes <- AES(key, mode="CBC",iv)
a<-aes$encrypt(msg)

aes2 <- AES(key, mode="CBC",iv)
b<-aes2$decrypt(a, raw=TRUE);b


# CFB
# CFB mode: IV must be the same length as the Block's block size
# Two different instances of AES are required for encryption and decryption
msg<- as.raw(c(1:16,1:32));msg
iv <- rand_bytes(16)
key <- as.raw(1:16)
aes <- AES(key, mode="CFB", iv)
aes$block_size()
code <- aes$encrypt(msg)
code


aes2 <-  AES(key, mode="CFB", iv)
aes2$block_size()
aes2$decrypt(code,raw=TRUE)


# CTR
msg<- as.raw(c(1:16,1:16));msg
key <- as.raw(1:16)
iv <- rand_bytes(16)
aes <- AES(key, mode="CTR", iv)
code<-aes$encrypt(msg)

aes2 <-  AES(key, mode="CTR", iv)
aes2$block_size()
aes2$decrypt(code,raw=TRUE)


###################################
library(openssl)

# CBC
key <- aes_keygen();key
iv <- rand_bytes(16);iv
msg<-charToRaw("ABCDj@*（;dj! 测试一下中文");msg
blob <-    aes_cbc_encrypt(msg, key, iv = iv)
message <- aes_cbc_decrypt(blob, key, iv)
out <- rawToChar(message);out


# CTR
key <- aes_keygen();key
iv <- rand_bytes(16);iv
msg<-charToRaw("ABCDj@*（;dj! 测试一下中文");msg
blob <-    aes_ctr_encrypt(msg, key, iv = iv)
message <- aes_ctr_decrypt(blob, key, iv)
out <- rawToChar(message);out

# GCM
key <- aes_keygen();key
iv <- rand_bytes(12);iv
msg<-charToRaw("ABCDj@*（;dj! 测试一下中文");msg
blob <-    aes_gcm_encrypt(msg, key, iv = iv)
message <- aes_gcm_decrypt(blob, key, iv)
out <- rawToChar(message);out


