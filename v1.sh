Content-Type: multipart/mixed; boundary="//"
MIME-Version: 1.0

--//
Content-Type: text/cloud-config; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="cloud-config.txt"

#cloud-config
cloud_final_modules:
- [scripts-user, always]

--//
Content-Type: text/x-shellscript; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="userdata.txt"

#/bin/!bash
yum update -y 
echo "Hello World" >> /tmp/testfile2.txt
yum install git -y 
runuser -l ec2-user -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash'
runuser -l ec2-user -c 'export NVM_DIR="$HOME/.nvm"'
runuser -l ec2-user -c '. ~/.nvm/nvm.sh'
echo "Inside screen Hello World" >> /tmp/testfile2.txt
yum install -y nodejs gcc-c++ make
runuser -l ec2-user -c 'nvm install node -y'
runuser -l ec2-user -c 'npm install puppeteer'
echo "Hello World" >> /tmp/testfile3.txt
runuser -l ec2-user -c 'npm install se-scraper'
runuser -l ec2-user -c 'npm install axios'
runuser -l ec2-user -c 'npm i clipboardy'
echo "Hello World" >> /tmp/testfile4.txt
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
yum install ./google-chrome-stable_current_x86_64.rpm -y
echo "Hello World" >> /tmp/testfile5.txt
ln -s /usrgoogle-chrome-stable /usrchromium
runuser -l ec2-user -c 'git clone https://github.com/defineapoorv/scrapeulous.git'
runuser -l ec2-user -c 'screen -dmS screen1'
runuser -l ec2-user -c "screen -S screen1 -X stuff 'cd scrapeulous\nsh repeater.sh\n'"
runuser -l ec2-user -c 'screen -dmS screen2'
runuser -l ec2-user -c "screen -S screen2 -X stuff 'cd scrapeulous\nsh repeater.sh\n'"
runuser -l ec2-user -c 'screen -dmS screen3'
runuser -l ec2-user -c "screen -S screen3 -X stuff 'cd scrapeulous\nsh repeater.sh\n'"
runuser -l ec2-user -c 'screen -dmS screen4'
runuser -l ec2-user -c "screen -S screen4 -X stuff 'cd scrapeulous\nsh repeater.sh\n'"
runuser -l ec2-user -c 'screen -dmS screen5'
runuser -l ec2-user -c "screen -S screen5 -X stuff 'cd scrapeulous\nsh repeater.sh\n'"
runuser -l ec2-user -c 'screen -dmS screen6'
runuser -l ec2-user -c "screen -S screen6 -X stuff 'cd scrapeulous\nsh repeater.sh\n'"
--//

