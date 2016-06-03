#!/usr/bin/expect -f
# set username/password for further use
set user "username";
set password "password";
#get last argument from input command use it as login server alias in script
set server [lindex $argv 0];
spawn ssh $user@181.172.172.12
# Look for max passwod prompt
match_max 10 
# Look for password window
expect "*?assword:*" {
  # send password
	send "$password\r"
	# look for new server login window here you change the message with your terminal output message
	expect "*$user@qa-env1*" {
		send "ssh $server\r"
		expect "*yes*" {
			send "yes\r"
			expect "*?assword:*" {
				send "$password\r"
				expect "$server"
				# execute any command
				send "cd /home/mydir/admin\r"
			}
		}
	}
}
interact
