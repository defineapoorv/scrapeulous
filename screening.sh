screen -dmS screen1
screen -S screen1 -X stuff 'cd scrapeulous\nsh repeater.sh\n'
screen -dmS screen2
screen -S screen2 -X stuff 'cd scrapeulous\nsh repeater.sh\n'
screen -dmS screen3
screen -S screen3 -X stuff 'cd scrapeulous\nsh repeater.sh\n'
screen -dmS screen4
screen -S screen4 -X stuff 'cd scrapeulous\nsh repeater.sh\n'
screen -dmS screen5
screen -S screen5 -X stuff 'cd scrapeulous\nsh repeater.sh\n'
screen -dmS screen6
screen -S screen6 -X stuff 'cd scrapeulous\nsh repeater.sh\n'

