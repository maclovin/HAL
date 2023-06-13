all: install_golang \
	install_nodejs \
	install_amass \
	install_exploitdb \
	install_clairvoyance \
	install_ngrok \
	install_msf \
	install_xsstrike \
	install_seclists \
	install_ffuf

.PHONY: all

install_golang:
	sudo wget https://go.dev/dl/go1.20.1.linux-amd64.tar.gz
	sudo tar -C /usr/local -xzf go1.20.1.linux-amd64.tar.gz
	/usr/local/go/bin/go version
	sudo rm -rf go1.20.1.linux-amd64.tar.gz
	sudo ln -sf /usr/local/go/bin/go /usr/bin/go

install_nodejs:
	curl -s https://deb.nodesource.com/setup_16.x | sudo bash
	sudo apt-get update -y
	sudo apt-get install nodejs -y
	node -v

install_amass:
	sudo wget https://github.com/owasp-amass/amass/releases/download/v3.23.2/amass_Linux_i386.zip
	sudo 7z x ./amass_Linux_i386.zip
	sudo chmod 0665 ./amass_Linux_i386
	sudo mv ./amass_Linux_i386 /usr/local/
	sudo ln -sf /usr/local/amass_Linux_i386/amass /usr/local/bin/amass
	sudo rm -rf amass_Linux_i386
	amass

install_exploitdb:
	sudo git clone https://gitlab.com/exploit-database/exploitdb.git /usr/local/exploitdb
	sudo ln -sf /usr/local/exploitdb/searchsploit /usr/bin/searchsploit
	sudo cp -n /usr/local/exploitdb/.searchsploit_rc ~/

install_clairvoyance:
	sudo pip install clairvoyance
	clairvoyance -h

install_ngrok:
	sudo wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-linux-amd64.tgz
	sudo tar -C /usr/local/bin/ -xzf ngrok-v3-stable-linux-amd64.tgz
	ngrok -h 
	sudo rm -rf ngrok-v3-stable-linux-amd64.tgz

install_msf:
	sudo wget https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb && \
	sudo mv ./msfupdate.erb ./msfinstall
	sudo chmod 755 ./msfinstall && \
  	sudo ./msfinstall
	sudo rm -rf ./msfinstall

install_xsstrike:
	sudo git clone https://github.com/s0md3v/XSStrike.git
	sudo mv ./XSStrike /usr/local/
	sudo chmod +x /usr/local/XSStrike/xsstrike.py
	sudo pip install -r /usr/local/XSStrike/requirements.txt
	sudo ln -sf /usr/local/XSStrike/xsstrike.py /usr/local/bin/xsstrike
	sudo rm -rf ./XSStrike

install_seclists:
	sudo git clone https://github.com/danielmiessler/SecLists.git 
	sudo mv ./SecLists /opt/seclists

install_ffuf:
	sudo git clone https://github.com/ffuf/ffuf;
	cd ffuf && sudo go get && sudo go build
	sudo mv ./ffuf /usr/local/ffuf
	sudo ln -sf /usr/local/ffuf/ffuf /usr/bin/ffuf

install_awscli:
	sudo curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
	sudo ./aws/install
	sudo rm -rf ./aws

install_s3scanner:
	pip3 install s3scanner
	python3 -m S3Scanner