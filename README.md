# <p align="center">Automatically Log-In on a Wi-Fi network in Safe Mode with Networking</p>
## Why is there a need for something like this?
Well, apparently Microsoft never treated this as a bug. It was treated as a FAD (Functioning As Designed)... and it still is. So, basically, the problem is this. When you're in Safe Mode with Networking in Windows, the OS doesn't automatically connect you with the last Wi-Fi network you were connected to while the OS was booted in regular mode. You have to manually connect to a network. Not only that, but Windows will moan that it can't connect to that network, but in fact it's already connected to it (if you manually choose to connect to it).
## Why is manually connecting to a Wi-Fi network a problem?
Well... if you haven't done much remote support assistance, yes, you really can't see a problem with that scenario. But, for people that have been working remotely in IT or offering tech services, trust me, this is a problem... especially if you don't live in the same time zone as the client and there is no one in front of the PC/laptop to manually connect you to the Wi-Fi network.

There are a lot of people out there that offer remote IT assistance/services and in many cases, like cleaning malware or viruses, you have to do (almost) everything while in Safe Mode... well, Safe Mode with Networking if you're working remotely. This is not a problem if the PC/laptop is using using a wired internet connection (LAN), but portable devices, such as laptops, are more and more common office tools and some small businessess, don't even bother wiring their office with a LAN network. They just buy those Wi-Fi USB dongles, some Wi-Fi router with 3 or 4 antennnas and poof, problem solved.

Not to mention troubleshooting hardware or driver problems. I can't change the hardware remotely, but you can at least pinpoint the problem if you can run the PC/laptop in Safe Mode.
## What does this batch script do?
It just makes another batch script and changes a registry value to make the script run on startup, regardless if you're in Safe Mode, Safe Mode with Networking, regular mode, whatever.
## How do I use it?
Run it once to install the "hack" (the script and the registry value change), run it again to revert everything as it was (delete the script and revert back the registry value change). 
