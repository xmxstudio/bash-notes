notes () {
# this is one of my first shell scripts. It's messy. it's ugly. 
# there's a lot of code that can be optimized and stripped out. 
# there are better ways of doing this. So please do it and post changes.
# cant believe i acutally finished something. What a strange fucking feeling.

#foreground
DEFAULT=39
	BLACK=30
	RED=31
	GREEN=32
	YELLOW=33
	BLUE=34
	MAGENTA=35
	CYAN=36
	LIGHTGRAY=37
	DARKGRAY=90
	LIGHTRED=91
	LIGHTGREEN=92
	LIGHTYELLOW=93
	LIGHTBLUE=94
	LIGHTMAGENTA=95
	LIGHTCYAN=96
	WHITE=97
#background
default=49
	black=40
	red=41
	green=42
	yellow=43 #acutally ORANGE!
	blue=44
	magenta=45
	cyan=46
	lightgray=47
	darkgray=100
	lightred=101
	lightgreen=102
	lightyellow=103
	lightblue=104
	lightmagenta=105
	lightcyan=106
	white=107
	
editor=nano #vim vi whatever pico doesnt matter
notesroot=/home/xmetrix/.notes/ #must end with trailing slash
backupDestination=/home/xmetrix/.notes/ #must end with trailing slash
backupFilename="notesbackup.tar.gz"
version=1.0
siteurl=http://notes.xmxstudio.com
#TODO: figure out this clipboard command bullshit
	case $1 in
		('test')
			xtest=();
			xtest+=("pewp");
			xtest+=("and");
			xtest+=("eat");
			xtest+=("pee");
			echo $xtest;
		;;
		('about')
		banner "NOTES" ${WHITE} ${blue}
			echo "\n"
			banner "😎 xmetrix@gmail.com" ${YELLOW} ${default}
			banner "🌎 $siteurl" ${lightgray} ${default}
			echo "If you'd like to revise, optimize, or otherwise contribute to this script, please feel free to DO IT. JUST DO IT! \n\nIf there are features you'd like to request, simply go to the above url and post the feature request on the feature request page"
			;;
		('tacos')	 echo "🕵 tacos in disguise!";;
		('credits')			banner NOTES ${WHITE} ${blue}
			lightteal_defaultbg "Thanks to many viewers at livecoding tv. will do some cool stuff with this later. perhaps animated credit list.\n"	;;
		('help')
			banner "NOTES v$version" ${WHITE} ${blue}
			echo " "
			echo -e "usage:  \e[96mnotes \e[33m<options>"
			echo " "
			listHelpItem "about" "author email, website url, and information about this script"
			listHelpItem "add [\"notename\"]" "creates a new note for the current directory"
			listHelpItem "all" "lists all note s system wide"
			listHelpItem "all clip" "copies the contents of the note (system wide) to your clipboard"
			listHelpItem "all del [#]" "deletes a note from anywhere by index number"
			listHelpItem "all edit [#]" "reads a note from anywhere by index number"
			#listHelpItem "all move [#] [newpath]" "moves a note to the new path, direct or relative" #### NOT DONE YET
			listHelpItem "all read [#]" "reads a note from anywhere by index number"
			listHelpItem "all rename [#] [newname]" "renames a note" 
			listHelpItem "backup" "tar's the .notes folder"
			listHelpItem "count" "get a small report of the number of notes and folders"
			listHelpItem "clip" "copies the contents of the note to your clipboard"
			listHelpItem "credits" "take a guess"
			listHelpItem "dirs" "get a small report of the number and names of directories that have notes"
			listHelpItem "del [#]" "deletes note by index number"
			listHelpItem "edit [#]" "edits a note passed in by index number"
			listHelpItem "find [query]" "searches all notes for matching text in both note name and contents"  
			listHelpItem "hash" "get a hash of current pwd"
			listHelpItem "lc" "get current list of notes with line count"
			#listHelpItem "move [#] [newpath]" "moves a note to the new path, direct or relative" #### NOT DONE YET
			listHelpItem "read [#]" "reads a note passed in by index number"
			listHelpItem "rename [#] [newname]" "renames a note"  
			

			listHelpItem "wc" "get current list of notes with lines/words/character count"
			echo " \n"
			echo "examples:\n"
			echo -e "   \e[96mnotes add mynote hello world"
			echo -e "   \e[90mcreates a note called mynote with the content \"hello world\"\n"222
			echo -e "   \e[96mnotes all"
			echo -e "   \e[90mdisplays all notes\n"
			echo -e "   \e[96mnotes all del 5"
			echo -e "   \e[90mdeletes the 5th item listed in the notes all result list\n"
			
			red_defaultbg "Known issues:\n"		
			echo -e "  \e[90mYou may not create a note with certain characters in the filename, such as \e[96mnotes add mynote! hello world.\e[90m as this will result in an error due to restricted filename characters \e[39m"
			echo -e "  \e[90mThe clip command defaults to xclip and may fail if you do not have xclip installed. you can type \e[96mwhich xclip\e[90m to see if you have it installed\e[39m"
		


			echo "";;
		('home')
		cd $notesroot
		;;
		('add')
		# ***************************************************************************** ADD
		if [ -z $2 ]
			then
					banner NOTES ${WHITE} ${blue}
					banner "must supply a note name" ${RED} ${default}
			return
		fi

		 	folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			if [ -f $notesroot$folderHash/$2 ]
			then
					banner NOTES ${WHITE} ${blue}
					banner "❗Note already exists - $2" ${RED} ${default}
				else
					if [ -d "$notesroot$folderHash/" ]
					then
						#do nothing
					else
						mkdir "$notesroot$folderHash/"
						echo $PWD > "$notesroot$folderHash/.parentpath"
					fi
				if [ $# -gt 2 ]; then	
					sp=${#2}
					((sp+=5))
					args=$*
					length=${#args}
					len=$((length-sp))
					note=${args:$sp:$len}
					echo $note>$notesroot$folderHash/$2
				else
					$editor "$notesroot$folderHash/$2"
					wait
				
				fi
				fs=$(stat -c%s "$notesroot$folderHash/$2")
				if [ $fs -ge 1 ] || 0
				then
					banner NOTES ${WHITE} ${blue}
					banner "⌗$fh ➜ 📁$PWD " ${LIGHTCYAN} ${default}
					lightteal_defaultbg "$2 - successfully created"
				else
					banner NOTES ${WHITE} ${blue}
					banner "⌗$fh ➜ 📁$PWD " ${LIGHTCYAN} ${default}
					red_defaultbg "$2 - not created"
				fi
				
			fi;;
		('clip')
		# ************************************************************************** CLIP 
			let i=0
			let found=0
			folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			for entry in "$notesroot$folderHash/"*
			do
				if [ -f "$entry" ]
				then
					((i++))
					if [[ $i = $2 ]]
					then
						banner "NOTES" ${WHITE} ${blue} 
						fh=${folderHash:0:7}
						lines=$(wc -l $entry | awk '{print $1}')
						[[ $lines -gt 1 ]] && verbage="$lines lines from" || verbage="$lines line from"
						teal_defaultbg "📋 Copied $verbage ➜ $(basename $entry)\n"
						#todo: fix this below
						#$clipboardCommand $entry
						xclip -selection c -i $entry
						((found++))
					fi
				fi
			done

			if [[ $found -eq 0 ]]
				then
					banner "NOTES" ${WHITE} ${blue} 
					banner "NOTE NOT FOUND" ${RED} ${default}
			fi;;
		('del')
		# **************************************************************************   DEL
		let i=0

				
			folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			numfiles=("$notesroot$folderHash/"*) 
			numfiles=${#numfiles[@]} 
			for entry in "$notesroot/$folderHash/"*
			do
				if [ -f "$entry" ]
				then
					((i++))
					if [[ $i = $2 ]]
					then
						banner NOTES ${WHITE} ${blue}
						banner "⌗ ${folderHash:0:7} ➜ 📁$(pwd) "  ${LIGHTCYAN} ${default}
						red_defaultbg "DELETED $(basename $entry)\n"
						rm "$entry"
						if [[ $numfiles = 1 ]]
						then
							echo -e "❗ Deleting empty notes folder ➜ \e[90m$notesroot$folderHash\e[49m/\n"
							rm -rf $notesroot$folderHash/
						fi
						return
					fi
				fi
			done
			banner NOTES ${WHITE} ${blue}
			red_defaultbg "Note not found - nothing deleted\n"			;;
		('read')	# ************************************************************************** READ 
			let i=0
			let found=0
			folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			for entry in "$notesroot$folderHash/"*
			do
				if [ -f "$entry" ]
				then
					((i++))
					if [[ $i = $2 ]]
					then
						banner "NOTES" ${WHITE} ${blue} 
						fh=${folderHash:0:7}
						teal_defaultbg "📚 Reading $(basename $entry) ⟺ $fh ➜ $pp"
						notecontent=$(cat $entry)
						echo -e "\e[90m\e[49m$notecontent\e[32m\n"
						((found++))
					fi
				fi
			done

			if [[ $found -eq 0 ]]
				then
					banner "NOTES" ${WHITE} ${blue} 
					banner "NOTE NOT FOUND" ${RED} ${default}
			fi;;
		('edit')
		# **************************************************************************** EDIT
		 let i=0
			folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			filearray=("$notesroot$folderHash/"*)
			let fc=${#filearray[@]}
			for entry in "$notesroot$folderHash/"*
			do
				if [ -f "$entry" ]
				then
					((i++))
					if [[ $i = $2 ]]
					then
						banner "NOTES" ${WHITE} ${blue} 
						fh=${folderHash:0:7}
						pp="blank"
						teal_defaultbg "📚 Editing $(basename $entry) ⟺ $fh ➜ $pp"
						lightteal_defaultbg 
						nano $entry
						return
					fi

				if [[ $i == $fc ]];
					then
						banner "NOTES" ${WHITE} ${blue} 
						banner "NOTE NOT FOUND\n" ${RED} ${default}
					fi

				fi
			done;;

		('rename')
			# **************************************************************************** RENAME
			nn=$3
			if [[ ${#nn} == 0 ]]
			then
				banner NOTES ${WHITE} ${blue}
				banner "Can not rename - new name not specififed" ${RED} ${default}
				return
			fi

		let i=0
			let found=0
			folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			
			for entry in "$notesroot$folderHash/"*
			do
				if [ -f "$entry" ]
				then
					((i++))
					bn=$(basename $entry)
					if [[ $bn == $3 ]]
						then
							banner NOTES ${WHITE} ${blue}
							banner "Can not rename - file already exists" ${RED} ${default}
						return
					fi

					if [[ $i == $2 ]]
					then
						banner "NOTES" ${WHITE} ${blue} 
						fh=${folderHash:0:7}
						teal_defaultbg "Renaming $(basename $entry) ➜ $3"
						mv $entry $notesroot$folderHash/$3
						wait
						modDate=$(stat -c %y $notesroot$folderHash/$3 | awk '{print $1}') 
						echo $modDate
						#echo -e "\e[90m\e[49m$notecontent\e[32m\n"
						((found++))
					fi
				fi
			done

			if [[ $found -eq 0 ]]
				then
					banner "NOTES" ${WHITE} ${blue} 
					banner "NOTE NOT FOUND" ${RED} ${default}
			fi
			;;

			('find')
				#*******************************************************************  SEARCH

				if [ -z $2 ]
					then
					banner NOTES ${WHITE} ${blue};
					banner " You must supply a search query\n" ${RED} ${default};
					return;
				fi



				banner "NOTES" ${WHITE} ${blue}

				dirsfound=();
				contentsfound=();
				notenamesfound=();
				totalfound=0;

				for entry in $notesroot*
					do
						if [ -d "$entry" ]
						then
							############## check to see if we have a directory name match
							pp=$( cat $entry/.parentpath ) 
							if [[ $pp == *$2* ]]
								then
								highlighted="${pp/$2/\e[92m\e[49m$2\e[39m}"
								dirsfound+=("$highlighted\n"); 
								((totalfound++));
							fi
					
							############## check each folder of notes for a match on note filename and note contents
							for note in $entry/*
							do
								((i++))
								# ######### note filename
									if [[ $note == *$2* ]]
										then
										base=$(basename $note);
										li="\e[92m\e[49m𝌆$base\e[39m ➜ 📁$pp\e[39m";
										notenamesfound+=("$li\n");
										((totalfound++));
									fi

									contents=$(cat $note --number | grep $2);
									if [[ $contents  == *$2* ]]
									then
									 	bn=$(basename $note);
									 	lineinfo=$(cat $note --number | grep $2 | awk '{print "\tline number" $0}');

									 	li="${lineinfo/$2/\e[92m\e[49m$2\e[39m}"
									 	
										
									 	contentsfound+=("\e[39m\e[49m$bn ➜ 📁$pp\e[39m\n$li\n");
									# 	#echo aaa $contentsfound FFFF
									 	((totalfound++));
									fi
							done
						fi
				done 
				if [[ $i -eq 0 ]]
				then
					banner "📁/* ALL NOTES" ${LIGHTCYAN} ${default}
					banner "NO NOTES FOUND\n" ${RED} ${default}
				fi
				
				if [[ ${#dirsfound} -ge 1 ]]
				then
					echo "\n\n";
					banner "\e[92m\e[49m📁 Directory matches\e[39m" ${WHITE} ${default}
					echo $dirsfound;
				fi
				
				if [[ ${#notenamesfound} -ge 1 ]]
				then
					banner "\e[92m\e[49m📁 Note fileame matches\e[39m" ${WHITE} ${default}
					echo $notenamesfound;
				fi


				if [[ ${#contentsfound} -ge 1 ]]
				then
					banner "\e[92m\e[49m📁 Content matches\e[39m" ${WHITE} ${default}
					echo $contentsfound;
				fi
					

				
					
					if [[ $totalfound ==  0 ]]
					then
					banner "NO NOTES FOUND\n" ${RED} ${default}
				fi
				#end search
			;;	


	# ('move')
	# 	# **************************************************************************** MOVE
	# 	# NO FILENAME RENAMING!! that is exactly what RENAME is for.
	# 	# this is going to prove to be the most time consuming one. gotta split the new path and see if the folder needs to be created.
	# 	#TODO:  make it take either indirect or direct path 
	# 	#for now we're just going to do DIRECT PATH ONLY 
	# 	makedir=false
	# 	srcHash=$( echo $PWD  | awk '{print $1}' | md5sum | awk '{print $1}')
	# 	src=$notesroot$srcHash$2
	# 	dest=$3
	# 	firstchar=${dest:0:1}
	# 	if [[ ${#dest} == 0 ]] then
	# 		banner NOTES ${WHITE} ${blue}
	# 		banner "Can not move - no target folder specified" ${RED} ${default}
	# 		return
	# 	fi #quit if no dest specified
	# 	if [[ $firstchar != "/" ]]
	# 		then
	# 			banner NOTES ${WHITE} ${blue}
	# 	 		banner "Can not move - please specify target folder (e.g., /var/www/html)" ${RED} ${default}
	# 	fi
	# 	rp=$(realpath $dest)
	# 	folderHash=$(  echo $rp  | awk '{print $1}' | md5sum | awk '{print $1}')

	# 	if [[  ! -d $dest ]]; then
	# 		echo "invalid directory"
	# 		return 
	# 	fi


	# 	let i=0
	# 	let found=0
	# 	for entry in "$notesroot$srcHash/"*
	# 		do
	# 	 		if [ -f "$entry" ]
	# 	 		then
	# 	 			((i++))
	# 	 			if [[ $i == $2 ]]; then


	# 					if [[ -d $notesroot$folderHash ]]
	# 						then
	# 						#check for existing file
	# 					else
	# 						#create notes folder for target directory
	# 						mkdir $notesroot$folderHash
	# 						wait
	# 						#add parentpath file
	# 						echo $rp > $notesroot$folderHash/.parentpath
	# 						wait
	# 						#move source note to new note folder
	# 						mv $notesroot$srcHash/$note  $notesroot$folderHash/$note
	# 						wait
	# 						banner "NOTES" ${WHITE} ${blue} 
	# 						note=$(basename $entry)
	# 		 			 	teal_defaultbg "Moved $note ➜ $3\n"
	# 		 			 	wait
	# 		 			 	modDate=$(stat -c %y  $notesroot$folderHash/$note | awk '{print $1}') 
	# 		 			 	echo $modDate
	# 					fi

		 				
	# 	 				((found++))
	# 	 			fi
	# 	 		fi
	# 	 	done

	# 	 	if [[ $found -eq 0 ]]
	# 	 		then
	# 	 			banner "NOTES" ${WHITE} ${blue} 
	# 	 			banner "NOTE NOT FOUND" ${RED} ${default}
	# 	 	fi
	# 	;;


		('all') 
		   let i=0
		   let found=0
			case $2 in
				('rename')
				# ************************************************************************* ALL RENAME

				
				# bd=$3
				# [[ ${bd:0:1} == "/" ]] && dest=$3 || dest=$PWD/$3
				# echo $dest


				nn=$4 #newname
				firstchar=${nn:0:1}
				if [[ $firstchar == "." ]] || [[ $firstchar == "/" ]]  #make sure its not trying to move to another path
					then
					banner NOTES ${WHITE} ${blue}
					banner "Can not rename - invalid path in new name" ${RED} ${default}
					return
				fi

				if [[ ${#nn} == 0 ]] 
				then
					banner NOTES ${WHITE} ${blue}
					banner "Can not rename - new name not specififed" ${RED} ${default}
					return
				fi



				for entry in $notesroot*
				do
					if [ -d "$entry" ]
					then
						ent=$entry 
						pp=$( cat $entry/.parentpath ) 
						for note in $entry/*
						do
							((i++))
							bn=$(basename $note)
							if [[ $bn == $4 ]]
								then
									banner NOTES ${WHITE} ${blue}
									banner "Can not rename - file already exists" ${RED} ${default}
								return
							fi
							if [[ $i = $3 ]]
							then
								banner "NOTES" ${WHITE} ${blue} 
								fh=${folderHash:0:7}
								mv  $note $notesroot$folderHash/$4
								wait
								modDate=$(stat -c %y $notesroot$folderHash/$4 | awk '{print $1}') 
								if [[ ${#modDate} -gt 1 ]]
									then
									teal_defaultbg "Renamed $(basename $note) ➜ $4\n"
								else
									echo "FAILED!"
								fi
							
								((found++))
							fi
						done
					fi
					done 
					if [[ $found -eq 0 ]]
					then
						banner "NOTE NOT FOUND" ${RED} ${default}
					fi
				;;




				('read')
				#	********************************************************************* ALL READ

					banner "NOTES" ${WHITE} ${blue} 
					for entry in $notesroot*
					do
						if [ -d "$entry" ]
						then
							ent=$entry 
							pp=$( cat $entry/.parentpath ) 
							for note in $entry/*
							do
								((i++))
								if [[ $i = $3 ]]
								then
									folderHash=$(echo $pp | awk '{print $1}' | md5sum | awk '{print $1}') 
									fh=${folderHash:0:7}
									teal_defaultbg "📚 Reading $(basename $note) ⟺ $fh ➜ $pp"
									notecontent=$(cat $note)
									echo -e "\e[90m\e[49m$notecontent\e[32m\n"
									((found++))
								fi
							done
						fi
					done 
					if [[ $found -eq 0 ]]
					then
						banner "NOTE NOT FOUND" ${RED} ${default}
					fi;;
				('del')
				#	********************************************************************** ALL DEL
				let found=0
				for entry in "$notesroot"*
					do
						if [ -d "$entry" ]
						then
							ent=$entry 
							pp=$( cat $entry/.parentpath ) 
							for note in $entry/*
							do
								((i++))
							if [[ $i = $3 ]]
							then
								numfiles=("$entry/"*) 
								numfiles=${#numfiles[@]} 
								banner NOTES ${WHITE} ${blue}
								folderHash=$(echo $pp | awk '{print $1}' | md5sum | awk '{print $1}') 
								banner "⌗ ${folderHash:0:7} ➜ 📁$pp "  ${LIGHTCYAN} ${default}
								red_defaultbg "DELETED $(basename $note)\n"
 								rm $note
 								((found++))
								if [[ $numfiles -eq 1 ]]
								then
								   rm -rf $entry/
								fi
								#return
							fi
							done
						fi
					done 
					if [ $found -eq 0 ]
						then
						banner NOTES ${WHITE} ${blue}
						red_defaultbg "Not not found - nothing deleted\n"
					else
						###MIGHT DELETE THIS
						### SHOW LIST OF ALL FILES INCASE THE PERSON MIGHT TRY DELETING OVER AND OVER NOT REALIZING THEY"RE IN THE WRONG FOLDER
						let i=0
						banner "NOTES" ${WHITE} ${blue}
						for entry in $notesroot*
							do
								if [ -d "$entry" ]
								then
									pp=$( cat $entry/.parentpath ) 
									folderHash=$(echo $pp | awk '{print $1}' | md5sum | awk '{print $1}') 
									fh=${folderHash:0:7}
									lightteal_defaultbg "⌗$fh ➜ 📁$pp "
									#banner "⌗$fh ➜ 📁$pp" ${LIGHTCYAN} ${default}
									for note in $entry/*
									do
										((i++))
										paddedIndex=$(seq -f "%02g" $i $i) 
										modDate=$(stat -c %y $entry | awk '{print $1}') 
										partial=$(head -n 1 $note)
										listItem $paddedIndex $modDate ${note##*/} $partial
									done
									echo " "
								fi
						done 
						if [[ $i -eq 0 ]]
						then
							banner "📁/* ALL NOTES" ${LIGHTCYAN} ${default}
							banner "NO NOTES FOUND\n" ${RED} ${default}
						fi

					fi
;;
				('edit')
				#******************************************************************* ALL EDIT 
					let found=0
					for entry in "$notesroot"*
					do
						if [ -d "$entry" ]
						then
							ent=$entry 
							pp=$( cat $entry/.parentpath ) 
							for note in $entry/*
							do
								((i++))
							# done
							if [[ $i == $3 ]]
							then
								((found++))
								banner "NOTES" ${WHITE} ${blue} 
					 			teal_defaultbg "📚 Editing $(basename $note) ⟺ $fh ➜ $pp\n"
								$editor $note
							fi
						done
						fi
					done 
					if [[ $found -eq 0 ]]
					then
						banner "NOTES" ${WHITE} ${blue} 
						banner "NOTE NOT FOUND" ${RED} ${default}
					fi;;
				('clip')
				#	********************************************************************* ALL CLIP
					banner "NOTES" ${WHITE} ${blue} 
					for entry in $notesroot*
					do
						if [ -d "$entry" ]
						then
							ent=$entry 
							pp=$( cat $entry/.parentpath ) 
							for note in $entry/*
							do
								((i++))
								if [[ $i = $3 ]]
								then
									folderHash=$(echo $pp | awk '{print $1}' | md5sum | awk '{print $1}') 
									fh=${folderHash:0:7}
									lines=$(wc -l $note | awk '{print $1}')
									[[ $lines -gt 1 ]] && verbage="$lines lines from" || verbage="$lines line from"
									teal_defaultbg "📋 Copied $verbage ➜ $(basename $note)\n"
									#todo: fix this below
									#$clipboardCommand $entry
									xclip -selection c -i $note
									((found++))
								fi
							done
						fi
					done 
					if [[ $found -eq 0 ]]
					then
						banner "NOTE NOT FOUND" ${RED} ${default}
					fi;;

				



				('lc')
				#*******************************************************************  ALL  LINECOUNT
				 banner "NOTES" ${WHITE} ${blue}
					for entry in $notesroot*
						do
							if [ -d "$entry" ]
							then
								pp=$( cat $entry/.parentpath ) 
								folderHash=$(echo $pp | awk '{print $1}' | md5sum | awk '{print $1}') 
								fh=${folderHash:0:7}
								lightteal_defaultbg "⌗$fh ➜ 📁$pp "
								#banner "⌗$fh ➜ 📁$pp" ${LIGHTCYAN} ${default}
								for note in $entry/*
								do
									((i++))
									paddedIndex=$(seq -f "%02g" $i $i) 
									modDate=$(stat -c %y $entry | awk '{print $1}') 
									partial=$(head -n 1 $note)
									linecount=$(wc -l $note | awk '{print $1}')
									listItem $paddedIndex $modDate ${note##*/} "$linecount - $partial"
								done
								echo " "
							fi
					done 
					if [[ $i -eq 0 ]]
					then
						banner "📁/* ALL NOTES" ${LIGHTCYAN} ${default}
						banner "NO NOTES FOUND\n" ${RED} ${default}
					fi;;	
					('wc')
				#*******************************************************************  ALL  LINECOUNT
				 banner "NOTES" ${WHITE} ${blue}
					for entry in $notesroot*
						do
							if [ -d "$entry" ]
							then
								pp=$( cat $entry/.parentpath ) 
								folderHash=$(echo $pp | awk '{print $1}' | md5sum | awk '{print $1}') 
								fh=${folderHash:0:7}
								lightteal_defaultbg "⌗$fh ➜ 📁$pp "
								#banner "⌗$fh ➜ 📁$pp" ${LIGHTCYAN} ${default}
								for note in $entry/*
								do
									((i++))
									paddedIndex=$(seq -f "%02g" $i $i) 
									modDate=$(stat -c %y $entry | awk '{print $1}') 
									partial=$(head -n 1 $note)
									linecount=$(wc $note | awk '{print "l:"$1" w: "$2" c:"$3}')
									listItem $paddedIndex $modDate ${note##*/} "$linecount - $partial"
								done
								echo " "
							fi
					done 
					if [[ $i -eq 0 ]]
					then
						banner "📁/* ALL NOTES" ${LIGHTCYAN} ${default}
						banner "NO NOTES FOUND\n" ${RED} ${default}
					fi;;	
				(*)
				#******************************************************************* NOTES ALL 
				 banner "NOTES" ${WHITE} ${blue}
					for entry in $notesroot*
						do
							if [ -d "$entry" ]
							then
								pp=$( cat $entry/.parentpath ) 
								folderHash=$(echo $pp | awk '{print $1}' | md5sum | awk '{print $1}') 
								fh=${folderHash:0:7}
								lightteal_defaultbg "⌗$fh ➜ 📁$pp "
								#banner "⌗$fh ➜ 📁$pp" ${LIGHTCYAN} ${default}
								for note in $entry/*
								do
									((i++))
									paddedIndex=$(seq -f "%02g" $i $i) 
									modDate=$(stat -c %y $entry | awk '{print $1}') 
									partial=$(head -n 1 $note)
									listItem $paddedIndex $modDate ${note##*/} $partial
								done
								echo " "
							fi
					done 
					if [[ $i -eq 0 ]]
					then
						banner "📁/* ALL NOTES" ${LIGHTCYAN} ${default}
						banner "NO NOTES FOUND\n" ${RED} ${default}
					fi;;
			esac ;;
		('dirs')
		# ****************************************************************************** DIRS
		let dcount=0
		noteDirs=""
		for entry in $notesroot*
		do
			if [ -d $entry ]
			then
				pp=$( cat $entry/.parentpath ) 
				noteDirs="$noteDirs\n$pp"
				((dcount++))
			fi
		done 
		banner "NOTES" ${WHITE} ${blue}

		if [[ $dcount -eq 0 ]]
		then
			banner "Directory count: 0" ${RED} ${default}
		else
			[[ $dcount -eq 1 ]] && verbage="directory" || verbage="directories"
			teal_defaultbg "Directory count: $dcount\n$noteDirs\n"
		fi	;;
		('count')	# ************************************************************************ COUNT
		let count=0
		let dircount=0
		for entry in $notesroot*
		do
			if [ -d "$entry" ]
			then
				((dircount++))
				ent=$entry 
				pp=$( cat $entry/.parentpath ) 
				for note in $entry/*
				do
					((count++))
				done
			fi
		done 
		if [[ $count -eq 0 ]]
		then
			banner "NOTES" ${WHITE} ${blue}
			banner "Note count: 0" ${RED} ${default}
		else
			banner "NOTES" ${WHITE} ${blue}
			[[ $dircount -eq 1 ]] && verbage="directory" || verbage="directories"
			teal_defaultbg "You have $count notes stored in $dircount $verbage\n"
		fi;;
		('backup')
		# ************************************************************************ BACKUP
					tar -zcf $backupDestination$backupFilename $notesroot/*
					wait
					banner "NOTES" ${WHITE} ${blue}
					lightteal_defaultbg "Backup completed\n"
					lightteal_defaultbg "$backupDestination$backupFilename created"
					lightteal_defaultbg "filesize: $(stat -c%s $backupDestination$backupFilename) bytes"  ;;
		('hash')		# ************************************************************************ HASH
		 folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			banner NOTES ${WHITE} ${blue}
			lightteal_defaultbg "$PWD = $folderHash\n";;
	
		('lc')
			 folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			if [ -d $notesroot$folderHash/ ]
			then
				banner "NOTES" ${WHITE} ${blue}
				banner "⌗ ${folderHash:0:7} ➜ 📁$(pwd) "  ${LIGHTCYAN} ${default}
				let i=0
				for entry in $notesroot$folderHash/*
				do
					if [ -f "$entry" ]
					then
						((i++))
						paddedIndex=$(seq -f "%02g" $i $i) 
						fn=$(basename $entry) 
						modDate=$(stat -c %y $entry | awk '{print $1}') 
						partial=$(head -n 1 $entry)
						linecount=$(wc -l $entry | awk '{print $1}')
						listItem $paddedIndex $modDate $fn "$linecount - $partial"
					fi
				done
				echo " " 
			else
				banner NOTES ${WHITE} ${blue}
				banner "📁$(pwd) "  ${LIGHTCYAN} ${default}
				banner "NO NOTES FOUND" ${RED} ${black}
			fi	;;
			('wc')
			 folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			if [ -d $notesroot$folderHash/ ]
			then
				banner "NOTES" ${WHITE} ${blue}
				banner "⌗ ${folderHash:0:7} ➜ 📁$(pwd) "  ${LIGHTCYAN} ${default}
				let i=0
				for entry in $notesroot$folderHash/*
				do
					if [ -f "$entry" ]
					then
						((i++))
						paddedIndex=$(seq -f "%02g" $i $i) 
						fn=$(basename $entry) 
						modDate=$(stat -c %y $entry | awk '{print $1}') 
						partial=$(head -n 1 $entry)
						linecount=$(wc $entry | awk '{print "l:"$1" w:"$2" c:"$3}')
						listItem $paddedIndex $modDate $fn "$linecount - $partial"
					fi
				done
				echo " " 
			else
				banner NOTES ${WHITE} ${blue}
				banner "📁$(pwd) "  ${LIGHTCYAN} ${default}
				banner "NO NOTES FOUND" ${RED} ${black}
			fi	;;

		(*) # ************************************************************************ NOTES
		 folderHash=$(echo $PWD | awk '{print $1}' | md5sum | awk '{print $1}') 
			if [ -d $notesroot$folderHash/ ]
			then
				banner "NOTES" ${WHITE} ${blue}
				banner "⌗ ${folderHash:0:7} ➜ 📁$(pwd) "  ${LIGHTCYAN} ${default}
				let i=0
				for entry in $notesroot$folderHash/*
				do
					if [ -f "$entry" ]
					then
						((i++))
						paddedIndex=$(seq -f "%02g" $i $i) 
						fn=$(basename $entry) 
						modDate=$(stat -c %y $entry | awk '{print $1}') 
						partial=$(head -n 1 $entry)
						listItem $paddedIndex $modDate $fn $partial
					fi
				done
				echo " " 
			else
				banner NOTES ${WHITE} ${blue}
				banner "📁$(pwd) "  ${LIGHTCYAN} ${default}
				banner "NO NOTES FOUND" ${RED} ${black}
			fi	;;
	esac
}
function banner(){
	bt=$1
	bw=${#bt}
	first=$(printf "%*s"  $(( (bw + $(tput cols)) / 2 )) "$1")
	last=$(printf "%*s"  $(( (bw + $(tput cols)) / 2 )) " ")
	both=$first$last
	stripped=${both:0:$(tput cols)}
	echo -e "\e[$2m\e[$3m"$stripped"\e[39m\e[49m"
}
function listItem(){#1 = index, 2=date, 3=note name, 4=firstline
	index=$1
	datemodified=$2
	note=$3
	firstline=$4
	strLength=$((13+${#index}+${#datemodified}+${#note}+${#firstline}))
	consolewidth=$(tput cols)

	if [[ strLength -gt consolewidth ]]
		then
		toremove=$((consolewidth-strLength))
		#echo $toremove " chars to cut off"
		firstline=${firstline:0:$toremove}...
	fi
	echo -e "\e[49m\e[33m$index\e[39m - \e[37m$datemodified\e[39m - \e[94m$note\e[33m\e[90m - $firstline\e[39m\e[49m"
	#vb6 days of cleanup! PRE GC!
	unset index
	unset datemodified
	unset note
	unset firstline
	unset strLength
}
function listHelpItem(){#1 = command, 2=description 
	cmd=$1
	desc=$2
	strLength=$((3+${#cmd}+${#desc}))
	consolewidth=$(tput cols)
	
	
	if [[ strLength -gt consolewidth ]] && [[ consolewidth -gt 60 ]]
		then
		toremove=$((consolewidth-strLength))
		firstline=${firstline:0:$toremove}...
	fi
	echo -e "\e[49m\e[33m$cmd\e[39m - \e[37m$desc\e[39m\e[49m"}
function red_whitebg(){echo -e "\e[107m\e[31m$1\e[32m\e[49m"}
function red_defaultbg(){echo -e "\e[49m\e[31m$1\e[32m\e[49m"}
function teal_whitebg(){echo -e "\e[107m\e[36m$1\e[32m\e[49m"}
function teal_blackbg(){echo -e "\e[40m\e[36m$1\e[32m\e[49m"}
function teal_defaultbg(){echo -e "\e[49m\e[36m$1\e[32m\e[49m"}
function lightteal_defaultbg(){	echo -e "\e[49m\e[96m$1\e[32m\e[49m"}
