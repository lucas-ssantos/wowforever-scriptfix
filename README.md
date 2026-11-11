# wowforever-scriptfix
A script and desktop entry to launch the script to fix mouse on Niri

# Problem
I had a problem where when I hold the mouse button to look around and such it would appear my default linux mause and thout it would work, it would be dragging
on the screen to the center and sometimes this might cause my cam in game to go wild and even turn my cam oposite to the direction I'm going (leading to face enemies I didn't want fight)
or see the sky...

# Warnings
1) I use Debian, your steam directory might be different!

2) You need Proton-GE 11-12 (or change it the script to use yours)

3) I've installed and played by Faugus Launcher, your game directory might be different!

# How to use the files
 1) Put the script on 
 ```~/Scripts/battlenet.sh```

2) Edit the directories with "<user>" yo your linux user name
 
3) Create a synbolic link to local/bin and make it executable with 
 ```ln -s ~/Scripts/battlenet.sh ~/.local/bin/battlenet.sh && chmod +x ~/.local/bin/battlenet.sh```

4) Update your desktop entrys   with
```update-desktop-database ~/.local/share/applications```
