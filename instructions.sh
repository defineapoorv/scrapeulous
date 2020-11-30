#!/bin/bash
sudo yum update -y
sudo yum install git -y
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.34.0/install.sh | bash
. ~/.nvm/nvm.sh
sudo yum install -y nodejs gcc-c++ make
nvm install node -y
npm install puppeteer
npm install se-scraper
npm install axios
npm i clipboardy
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm
sudo yum install ./google-chrome-stable_current_x86_64.rpm -y
sudo ln -s /usr/bin/google-chrome-stable /usr/bin/chromium
git clone https://github.com/defineapoorv/scrapeulous.git;
sh scrapeulous/screening.sh;
