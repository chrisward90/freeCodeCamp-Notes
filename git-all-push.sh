# !/bin/bash
# Show status of git and prompt User for commit message to commit all the new changes to git and push to github
# Also create conditionals to check for lack of message and also if User wishes to cancel commit after seeing status.

echo ""

git status

echo ""
echo "Enter 'n' to cancel. Enter 'spec' to specify file, otherwise all files."
echo ""
read -p 'commit -m ' varCommit

# Check that a commit message exists
if [[ -z "$varCommit" ]]; then
	echo ""
	echo "Please put in a commit message."
	exit

# For adding specific files to be committed and pushed
elif [[ "$varCommit" == "spec" ]] || [[ "$varCommit" == "'spec'" ]]; then
	read -p 'Specify file to add commit and push: ' specificFile
	# Check that filename entered
	if [[ -z "$specificFile" ]]; then
		echo "No file choice made"
		exit
	else
		echo ""
		echo "Add "$specificFile"? y/n"
		read -p 'Choice ' choice
		echo ""
		if [[ "$choice" == "y" ]] || [[ "$choice" == "'y'" ]]; then
			git add "$choice"
			read -p 'Commit -m ' specificCommit
			if [[ -z "$specificCommit" ]]; then
				echo "No commit message given"
				exit
			# Reset HEAD if choice 'n'
			elif [[ "$specificCommit" == "n" ]] || [[ "$specificCommit" == "'n'" ]]; then
				echo "You have canceled the script"
				git reset HEAD "$specificFile"
				exit
			else
				git commit -m "$specificCommit"
				echo "Committed "$specificFile""
			fi
		else
			echo "Try again"
			exit
		fi
	fi

elif [[ "$varCommit" == "n" ]] || [[ "$varCommit" == "'n'" ]]; then
	echo ""
	echo "You canceled the script."
	exit

# Condition to add commit and push all unstaged files
else
	git add .
	git commit -m "$varCommit"
fi

git push

echo ""
git status
echo ""

echo "------------------------------Script Complete------------------------------"
echo ""
if [[ "$varCommit" == "spec" ]] || [[ "$varCommit" == "'spec'" ]]; then
	echo "commit -m: "$specificCommit""
else
	echo "commit -m: "$varCommit""
fi
echo ""
echo "Pushed to github"

# Exit script
exit
