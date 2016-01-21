#NOTES.SH

----
A simple (albiet crappy code) command line note system. Simply copy the script into any folder or use the default .notes in your home dir ~/.notes 

Then edit notes.sh and change notesroot and backupDestination and backupFilename.

it's rather ghetto and crappy code but it works so who cares right?

So how it works basically when you type notes to execute it, it gets the current path you're executing it from and then performs an md5sum on that pwd. This gives you a unique "fingerprint" for that pwd. It then creates that hashed folder in the notes folder (e.g., ~/.notes/68792176e75c5fb1b7828287af6a26f9 and creates a file called .parentpath and echo's $PWD into that folder so you know which folder that hash belongs to.  Then any time you want to pull up a note for that directory you simply type notes and it displays them if you got them. or you can add a note like so
```
you@yourpc:~$ notes add mynote this is my first note!
```
it automatically adds the note text into the file mynote in the folder that it just created.

well pretty self explanitory so check the help
```
you@yourpc:~$ notes help
```

----
#known issues
-crappy code
-sloppy code
-echo errors on tiny consoles (RESIZE IT YOU JERK!)
-crappy code again
