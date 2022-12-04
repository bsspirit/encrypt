##############################
# 用R语言实现RSA+AES混合加密
# http://blog.fens.me/r-crypto-aes-rsa/
##############################


setwd("C:/work/R/encrypt")

library(openssl)



aes<-aes_keygen(length = 16);aes
str(aes)

rsa<-rsa_keygen(bits = 2048);rsa
str(rsa)
rsa$pubkey


dsa<-dsa_keygen(bits = 1024);dsa
str(dsa)
dsa$pubkey

ec<-ec_keygen(curve = c("P-256"));ec
str(ec)
ec$pubkey

ec<-ec_keygen(curve = c("P-384"));ec
str(ec)
ec$pubkey

ec<-ec_keygen(curve = c("P-521"));ec
str(ec)

x25519<-x25519_keygen();x25519
str(x25519)
x25519$pubkey

ed25519<-ed25519_keygen();ed25519
str(ed25519)
ed25519$pubkey


########################################
# RSA+AES混合加密

#1. B系统
# RSA私钥
rsa_key <- rsa_keygen();rsa_key
# RSA公钥
rsa_pubkey <- rsa_key$pubkey


#2.A系统
# RSA公钥
rsa_pubkey

# AES秘钥
aes_key <- aes_keygen();aes_key
aes_key_mi <- rsa_encrypt(aes_key, rsa_pubkey)

#3. B系统
aes_key_mi
aes_key2<-rsa_decrypt(aes_key_mi,rsa_key);aes_key2

#4. A系统
# 原始数据
dat<-iris[1:3,];dat
dat_serial <- serialize(dat, NULL);dat_serial
dat_mi <- aes_cbc_encrypt(x_serial, key = aes_key)

#5. B系统
dat_mi
dat_serial2<-aes_cbc_decrypt(dat_mi,aes_key2);x_serial2
dat2<-unserialize(x_serial2);dat2




