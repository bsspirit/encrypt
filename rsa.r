##############################
# R语言进行非对称加密RSA
# http://blog.fens.me/r-crypto-openssl-rsa/
##############################


setwd("C:/work/R/encrypt")

value<-"abc=!@#$%^&*()_+abc试试中文"


##############
library(openssl)
openssl_config()
fips_mode()


###########################################
# RSA
key <- rsa_keygen();key
str(key)
pubkey <- key$pubkey;pubkey
pubkey$data
str(pubkey)

###########################################
# 加密解密

# 用公钥加密，私钥解密
secretChar <- charToRaw(value);secretChar
ciphertext <- rsa_encrypt(secretChar, pubkey);ciphertext
rawChar<-rsa_decrypt(ciphertext, key);rawChar
rawToChar(rawChar)


# 用私钥加密，私钥解密
secretChar <- charToRaw(value);secretChar
ciphertext <- rsa_encrypt(secretChar, key);ciphertext
rawChar<-rsa_decrypt(ciphertext, write_der(key));rawChar
rawToChar(rawChar)

# 用私钥加密，公钥解密
secretChar <- charToRaw(value);secretChar
ciphertext <- rsa_encrypt(secretChar, key);ciphertext
rawChar<-rsa_decrypt(ciphertext, write_der(pubkey));rawChar

#########################
# 数字签名

# 用私钥签名
myfile <- system.file("DESCRIPTION")
sig <- signature_create(myfile, key = key);sig

# 公钥验证
signature_verify(myfile, sig, pubkey = pubkey)

# Sign raw data
data <- serialize(iris, NULL)
sig <- signature_create(data, sha256, key = key);sig
signature_verify(data, sig, sha256, pubkey = pubkey)

# Sign a hash
md <- md5(data);md
sig <- signature_create(md, hash = NULL, key = key)
signature_verify(md, sig, hash = NULL, pubkey = pubkey)


# ECDSA example
data <- serialize(iris, NULL)
key <- ec_keygen()
pubkey <- key$pubkey
sig <- signature_create(data, sha256, key = key)
signature_verify(data, sig, sha256, pubkey = pubkey)

params <- ecdsa_parse(sig);params
out <- ecdsa_write(params$r, params$s);out
identical(sig, out)





