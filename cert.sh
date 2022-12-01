########################
# 用R语言配合openssl命令行生成和管理x509证书
# http://blog.fens.me/r-crypto-openssl-cert/
##########################

cd c:/work/R/encrypt/n1
openssl version

# 生成CA私钥ca.key
openssl genrsa -out ca.key 2048
cat ca.key

# 生成自签名得到根证书（ca.crt）
openssl req -new -x509 -key ca.key -out ca.crt -days 365

# 生成用户证书fens.me
openssl genrsa -out fens.me.key 2048

# 生成用户证书请求（fens.me.csr）
openssl req -new -key fens.me.key -out fens.me.csr

# 查看CSR文件中的信息
openssl req -text -noout -verify -in fens.me.csr

# 用CA根证书签名得到证书
openssl x509 -req -in fens.me.csr -CA ca.crt -CAkey ca.key -set_serial 01 -out fens.me.crt -days 365

# 查看证书中的内容
openssl x509 -in fens.me.crt -text -noout

