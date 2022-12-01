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

# 用公钥加密，私钥解密
secretChar <- charToRaw(value);secret
ciphertext <- rsa_encrypt(secretChar, pubkey);ciphertext
rawChar<-rsa_decrypt(ciphertext, key);rawChar
rawToChar(rawChar)


# 用私钥加密，私钥解密
secretChar <- charToRaw(value);secret
ciphertext <- rsa_encrypt(secretChar, key);ciphertext
rawChar<-rsa_decrypt(ciphertext, write_der(key));rawChar
rawToChar(rawChar)

# 用私钥加密，公钥解密
secretChar <- charToRaw(value);secret
ciphertext <- rsa_encrypt(secretChar, key);ciphertext
rawChar<-rsa_decrypt(ciphertext, write_der(pubkey));rawChar




