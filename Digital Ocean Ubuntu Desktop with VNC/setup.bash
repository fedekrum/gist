#!/bin/bash

# --force-yes is obsolet
# is still asking what to do with config files (has to be interactive)

# Put your VNC password here
PASS=mypass

sudo add-apt-repository -y ppa:stebbins/handbrake-releases
sudo apt --yes --force-yes -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-confold" update
sudo apt --yes --force-yes -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-confold" upgrade
sudo apt --yes --force-yes  -o Dpkg::Options::="--force-confnew" -o Dpkg::Options::="--force-confold" install ubuntu-desktop gnome-panel gnome-settings-daemon metacity nautilus gnome-terminal handbrake-cli handbrake-gtk vnc4server
sudo apt --yes --force-yes autoremove

sudo printf "$PASS\n$PASS\n\n" | vnc4passwd
vncserver :1 &
sleep 20
vncserver -kill :1

echo "#!/bin/sh" > /root/.vnc/xstartup
echo "" >> /root/.vnc/xstartup
echo "# Uncomment the following two lines for normal desktop:" >> /root/.vnc/xstartup
echo "# unset SESSION_MANAGER" >> /root/.vnc/xstartup
echo "# exec /etc/X11/xinit/xinitrc" >> /root/.vnc/xstartup
echo "" >> /root/.vnc/xstartup
echo "[ -x /etc/vnc/xstartup ] && exec /etc/vnc/xstartup" >> /root/.vnc/xstartup
echo "[ -r $HOME/.Xresources ] && xrdb $HOME/.Xresources" >> /root/.vnc/xstartup
echo "xsetroot -solid grey" >> /root/.vnc/xstartup
echo "vncconfig -iconic &" >> /root/.vnc/xstartup
echo 'x-terminal-emulator -geometry 80x24+10+10 -ls -title "$VNCDESKTOP Desktop" &' >> /root/.vnc/xstartup
echo "x-window-manager &" >> /root/.vnc/xstartup
echo "" >> /root/.vnc/xstartup
echo "gnome-panel &" >> /root/.vnc/xstartup
echo "gnome-settings-daemon &" >> /root/.vnc/xstartup
echo "metacity &" >> /root/.vnc/xstartup
echo "nautilus &" >> /root/.vnc/xstartup

(crontab -l ; echo "@reboot /usr/bin/vncserver :1 -geometry 1920x1080") | sort - | uniq - | crontab -

echo "To access VNC:"
echo "1) connect to SSH this way"
echo "   ssh -L 5901:127.0.0.1:5901 root@YOUR_IP"
echo "2) Conect via VNC client to localhost:1"
reboot
