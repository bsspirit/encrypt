################################
# 用R语言配合openssl命令行生成和管理x509证书
# http://blog.fens.me/r-crypto-openssl-cert/
#################################




setwd("C:/work/R/encrypt")

#电子签名，生成证书

library(openssl)

setwd("C:/work/R/encrypt/n1")
ca.txt<-readLines("./ca.key");ca.txt
cakey<-read_key("./ca.key");cakey
str(cakey)
ca.ssh<-write_ssh(cakey);ca.ssh
ca.der<-write_der(cakey);ca.der
ca.pkcs1<-write_pkcs1(cakey);ca.pkcs1
ca.pem<-write_pem(cakey);ca.pem
identical(paste0(ca.txt,"\n",collapse = ""),ca.pem)
identical(paste0(ca.txt,"\n",collapse = ""),ca.pkcs1)


cakey_pub<-read_pubkey("./ca.key");cakey_pub # public
write_pem(cakey_pub)

write_pkcs1(cakey_pub,"./ca_pub.key")
read_pubkey("./ca_pub.key")


file<-"ca.crt"
cacrt<-read_cert(file, der = is.raw(file))
cacrt
read_cert_bundle(file)
cacrt.pem<-write_pem(cacrt);cacrt.pem
cacrt.pkcs1<-write_pkcs1(cacrt);cacrt.pkcs1


cacrt.txt<-readLines(file);cacrt.txt
identical(paste0(cacrt.txt,"\n",collapse = ""),cacrt.pem)


write_pem(cacrt,"cacrt.crt.bak")
read_cert("cacrt.crt.bak")


fenskey<-read_key("./fens.me.key");fenskey # private
fenskey_pub<-read_pubkey("./fens.me.key");fenskey_pub # public

file<-"fens.me.csr"
readLines(file)
cacsr<-read_cert(file, der = is.raw(file))
read_cert_bundle(file)
fens.me.csr_bak<-read_pem(file)
#write_pem(fens.me.csr_bak$`CERTIFICATE REQUEST`,"fens.me.csr.bak")


file<-"fens.me.crt"
readLines(file)
readLines(file)
fenscrt<-read_cert(file, der = is.raw(file))
fenscrt
fenscrt_tree<-read_cert_bundle(file)
read_pem(file)


####################
#  Download and verify an SSL certrificate:

cert <- download_ssl_cert("www.r-project.org")
cert
cert_data<-cert[[1]]
cert_data$signature
cert_data$pubkey
cert_data$pubkey$data
cert_data$pubkey$ssh
cert_data$pubkey$fingerprint
write_der(cert_data$pubkey)

cert_data$alt_names
str(cert_data)
cert_verify(cert, ca_bundle())
write_pem(cert_data)
head(ca_bundle())
