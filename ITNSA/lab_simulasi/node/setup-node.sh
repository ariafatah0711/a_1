#!/bin/bash

# Set root password using expect
expect << EOF
spawn passwd root
expect "New password:"
send "123\r"
expect "Retype new password:"
send "123\r"
expect eof
EOF