#!/bin/bash

running=true

while [ "$running" = true ]; do

echo "---------------------------------------"
echo "1) Check installed dependencies"
echo "2) Install Terraform"
echo "3) Quit"
echo "---------------------------------------"


read -r -p "Welcome to the Terraform and ansible initaliser, what would you like to do? " input


case $input in

1)
echo "Installing dependencies..."
;;

2)
echo "Installing Terraform bootstrap..."
;;

3)
running=false
echo "Quitting..."
;;

*)
echo "Invalid choice"

esac

done