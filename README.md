# <p align="center">Automatically Log-In on a Wi-Fi network in Safe Mode with Networking</p>
## Why is there a need for something like this?
Well, apparently Microsoft never treated this as a bug. It was treated as a FAD (Functioning As Designed)... and it still is. So, basically, the problem is this. When you're in Safe Mode with Networking in Windows, the OS doesn't automatically connect you with the last Wi-Fi network you were connected to while the OS was booted in regular mode. You have to manually connect to a network. Not only that, but Windows will moan that it can't connect to that network, but in fact it's already connected to it (if you manually choose to connect to it).
## Why is manually connecting to a Wi-Fi network a problem?
Well... if you haven't done much remote support assistance, yes, you really can't see a problem with that scenario. But, for pepole that have been working remotely in IT or offering tech services, trust me, this is a problem... especially if you don't live in the same time zone as the client and there is no one in front of the PC/laptop to manually connect you to the Wi-Fi network.
## What does this batch script do?
It just makes another batch script and changes a registry value to make the script run on startup, regardless if you're in Safe Mode, Safe Mode with Networking, regular mode, whatever.
## How do I use it?
Run it once to install the "hack" (the script and the registry value change), run it again to revert everything as it was (delete the script and revert back the registry value change).
