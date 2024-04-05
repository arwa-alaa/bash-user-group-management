#!/bin/bash

####################			<<<<< Add Function >>>>>			####################

function add_user {

#take input from user
username=$(whiptail --title "Add User" --inputbox "Enter the username:" 10 40 3>&1 1>&2 2>&3 )

if [ $? -eq 0 ]; then

#check if user exist
id $username >/dev/null 2>&1
if [ $? -eq 0 ]; then
whiptail --title "Add User" --msgbox "The user is already exist." 10 40
else
#add user
useradd $username
whiptail --title "Add User" --msgbox "The user was added successfully." 10 40
fi

else
whiptail --title "ERROR" --msgbox "ERROR in add user function." 10 40
fi
}

####################			<<<<< Modify Function >>>>>			############################################### 

function modify_user {

#take input from user
oldusername=$(whiptail --title "Modify User" --inputbox "Enter the old username:" 10 40 3>&1 1>&2 2>&3 )
if [ $? -eq 0 ]; then

#check if user exist
id $oldusername >/dev/null 2>&1
if [ $? -eq 0 ]; then

newusername=$(whiptail --title "Modify User" --inputbox "Enter the new username:" 10 40 3>&1 1>&2 2>&3 )

#modify username
usermod -l $newusername $oldusername
whiptail --title "Modify User" --msgbox "The username was modified." 10 40 
else
whiptail --title "Modify User" --msgbox "The user doesn't exist." 10 40
fi
else

whiptail --title "ERROR" --msgbox "ERROR in modify user function." 10 40
fi
}

####################			<<<<< Enable Function >>>>>			############################################### 


function enable_lock {

#take input from user
username=$(whiptail --title "Enable Lock" --inputbox "Enter the username:" 10 40 3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then

#check if user exit
id $username >/dev/null 2>&1
if [ $? -eq 0 ]; then

#lock account
usermod -L $username
whiptail --title "Enable Lock" --msgbox "The account was locked." 10 40 
else
whiptail --title "Enable Lock" --msgbox "The user doesn't exist." 10 40
fi
else
whiptail --title "ERROR" --msgbox "ERROR in enable user function." 10 40
fi
}

####################			<<<<< Disable Function >>>>>			############################################### 

function disable_lock {

#take input from user
username=$(whiptail --title "Disable Lock" --inputbox "Enter the username:" 10 40 3>&1_1>&2 2>&3)

if [ $? -eq 0 ]; then

#check if user exit
id $username >/dev/null 2>&1
if [ $? -eq 0 ]; then

#unlock account
usermod -U $username
whiptail --title "Disable Lock" --msgbox "The account was unlocked." 10 40 
else
whiptail --title "Disable Lock" --msgbox "The user doesn't exist." 10 40
fi
else
whiptail --title "ERROR" --msgbox "ERROR in disable user function." 10 40 
fi
}

####################			<<<<< Expiry Function >>>>>			############################################### 

function expiry_user {

#take input from user
username=$(whiptail --title "Expiry User" --inputbox "Enter the username:" 10 40 3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then

#check if user exit
id $username >/dev/null 2>&1
if [ $? -eq 0 ]; then

#expire account
chage -E 2024-06-20 $username
whiptail --title "Expiry User" --msgbox "This user's account will be expired after 7 days." 10 40
else
whiptail --title "Expiry User" --msgbox "The user doesn't exist." 10 40
fi
else
whiptail --title "ERROR" --msgbox "ERROR in expiry user function." 10 40
fi
}

####################			<<<<< List Function >>>>>			############################################### 

function list_users {
whiptail --title "List UsersName" --msgbox "$(awk 'BEGIN {FS=":"}{print$1}' /etc/passwd)" 30 50
}

####################			<<<<< Details Function >>>>>			############################################### 

function show_details {

#take input from user
username=$(whiptail --title "Details User" --inputbox "Enter the username:" 10 40 3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then

#check if user exit
id $username >/dev/null 2>&1

if [ $? -eq 0 ]; then
#display details
whiptail --title "Details User" --msgbox "$(chage -l $username)" 20 65 
else
whiptail --title "Details User" --msgbox "The user doesn't exist." 10 40
fi
else
whiptail --title "ERROR" --msgbox "ERROR in show details function." 10 40
fi
}

####################			<<<<< Add Group Function >>>>>			############################################### 

function add_group {

#take input from user
groupname=$(whiptail --title "Add Group" --inputbox "Enter the group name:" 10 40 3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then
#check if group exist
getent group $groupname >/dev/null 2>&1

if [ $? -eq 0 ]; then
whiptail --title "Add Group" --msgbox "The group is already exist." 10 40

else
#add group
groupadd $groupname
whiptail --title "Add Group" --msgbox "The group was added successfully." 10 40
fi

else
whiptail --title "ERROR" --msgbox "ERROR in add group function." 10 40
fi
}

####################			<<<<< Delete Group Function >>>>>			############################################### 

function delete_group {

#take input from user
groupname=$(whiptail --title "Delete Group" --inputbox "Enter the group name:" 10 40 3>&1 1>&2 2>&3)

if [ $? -eq 0 ]; then
#check if group exist
getent group $groupname >/dev/null 2>&1

if [ $? -eq 0 ]; then
#delete group
groupdel $groupname
whiptail --title "Delete Group" --msgbox "The group name was deleted." 10 40 

else
whiptail --title "Delete Group" --msgbox "The group doesn't exist." 10 40
fi
else
whiptail --title "ERROR" --msgbox "ERROR in delete group function." 10 40 
fi
}

####################			<<<<< List Groups Function >>>>>			############################################### 

function list_groups {
whiptail --title "List Groups Name" --msgbox "$(awk 'BEGIN {FS=":"}{print$1}' /etc/group)" 30 60
}

####################			<<<<< Menu >>>>>			####################

while true; do

choice=$(whiptail --title "Menu example" --menu "Choose an option" 25 78 16 \
"Add User" "Add a user to the system." \
"Modify User" "Modify an existing user." \
"Enable Lock" "Enable a suspended user account." \
"Disable Lock" "Disable a suspend user account." \
"Expiry User" "Expiry date for user account." \
"List Users" "List all users on the system." \
"Show Details" "Show details about a user." \
"Add Group" "Add a group to the system." \
"Delete Group" "Delete a group and its list of members." \
"List Groups" "List all groups on the system." \
"Close" "Close the main menu." 3>&1 1>&2 2>&3)


if [ $? -eq 0 ]; then
case $choice in
"Add User") add_user ;;
"Modify User") modify_user ;;
"Enable Lock") enable_lock ;;
"Disable Lock") disable_lock ;;
"Expiry User") expiry_user ;;
"List Users") list_users ;;
"Show Details") show_details ;;
"Add Group") add_group ;;
"Delete Group") delete_group ;;
"List Groups") list_groups ;;
"Close") whiptail --msgbox "Closing the menu. Goodbye!" 10 40
break ;;

*) whiptail --title "ERROR" --msgbox "Invalid Choice." 10 40 ;;
esac

fi
done
