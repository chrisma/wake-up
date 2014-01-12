# wake_up
Auto suspend and wake up script

Puts the computer on suspend and automatically wakes it up at specified time, running a custom script.
Requires *rtcwake* from util-linux package.
Must be run as root (rtcwake requires it).

### Usage
Takes a 24hour time HH:MM and (optional) script path as arguments.

Example:
    
    wake_up 9:30
    wake_up 18:45 beepbeepbeep.sh
    
### License
* GPL v2
* rooster.wav by [Mike Koenig][1] (CC BY 3.0)


  [1]: http://soundbible.com/1218-Rooster-Crow.html
