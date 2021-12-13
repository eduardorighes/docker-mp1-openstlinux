NAME := yocto

build:
	docker build -t $(NAME) . 

