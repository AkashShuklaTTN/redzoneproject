vpc_cdr = "10.0.0.0/16"
public1_cdr = "10.0.1.0/24"
public2_cdr = "10.0.2.0/24"
private_cdr = "10.0.3.0/24"
ami-ins = "ami-04505e74c0741db8d"
ins-type = "t2.micro"
desired-cap = 2
max-count = 2
min-count = 2
min-healthy = 60 
db-ami = "ami-04505e74c0741db8d"
db-instance = "t2.micro"
db-privateip = "10.0.3.5"
mon-ami = "ami-04505e74c0741db8d"
mon-instance = "t2.micro"
mon-privateip = "10.0.3.2"
ip-test = "122.161.81.30/32"