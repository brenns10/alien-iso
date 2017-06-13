#!/bin/bash
USERNAME=ripley

set -e -u

sed -i 's/#\(en_US\.UTF-8\)/\1/' /etc/locale.gen
locale-gen

ln -sf /usr/share/zoneinfo/UTC /etc/localtime

usermod -s /usr/bin/zsh root
cp -aT /etc/skel/ /root/
chmod 700 /root

groupadd -r autologin
useradd -m -G wheel -s /bin/bash $USERNAME
usermod -aG audio,autologin $USERNAME
cp -aT /etc/skel/ /home/$USERNAME/
chmod 700 /home/$USERNAME
chown -R $USERNAME:$USERNAME /home/$USERNAME

sed -i 's/#\(PermitRootLogin \).\+/\1yes/' /etc/ssh/sshd_config
sed -i "s/#Server/Server/g" /etc/pacman.d/mirrorlist
sed -i 's/#\(Storage=\)auto/\1volatile/' /etc/systemd/journald.conf

sed -i 's/#\(HandleSuspendKey=\)suspend/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleHibernateKey=\)hibernate/\1ignore/' /etc/systemd/logind.conf
sed -i 's/#\(HandleLidSwitch=\)suspend/\1ignore/' /etc/systemd/logind.conf

mv /var/local/lightdm.conf /etc/lightdm/lightdm.conf

#sounds
systemctl enable startupsound.service ambientsound.service aliensounds.service
#startup things
systemctl enable lightdm-plymouth.service getty@tty2.service
systemctl set-default graphical.target
