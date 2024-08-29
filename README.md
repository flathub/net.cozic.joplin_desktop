## File system sync on removable-media
This flatpak only have permission to access user's home directory.  
Need to manually add permission to allow access other location. 


You can do it with [Flatseal](https://flathub.org/apps/details/com.github.tchx84.Flatseal), and configure permissions with nice gui.  
Or use terminal command:
```sh
flatpak override --filesystem=host net.cozic.joplin_desktop
```
Note: You can also use multiple `filesystem` options to set `/media`,`/run/media`,`/mnt` as you need.

## Use external editor with flatpak
There are two ways.
### xdg-open
Nothing need to be done, it's done by electron.  
Joplin will open a dialogue to select editor.  

- How to reset the xdg-open choice  
`flatpak permission-remove desktop-used-apps text/markdown net.cozic.joplin_desktop`

### flatpak-spawn
This can run command outside flatpak, which means this flatpak most likely to be unsandboxed.  
This feature is enabled for full external editor support.  
```text
Path:
/bin/flatpak-spawn
Arguments:
--host <outside command>
```

#### example
```text
Path: 
/bin/flatpak-spawn
Arguments: 
# run flatpak app
--host /bin/flatpak run --filesystem=xdg-config/joplin-desktop org.gnome.gedit

# run native app
--host /bin/gedit
```
