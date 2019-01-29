#!/bin/sh -eux

ubuntu_version="`lsb_release -r | awk '{print $2}'`";
ubuntu_major_version="`echo $ubuntu_version | awk -F. '{print $1}'`";

# Disable release-upgrades
sed -i.bak 's/^Prompt=.*$/Prompt=never/' /etc/update-manager/release-upgrades;

# Increase retries when doenloading packages
echo 'Acquire::Retries 5;' >> /etc/apt/apt.conf

# Disable periodic activities of apt
cat <<EOF >/etc/apt/apt.conf.d/10disable-periodic;
APT::Periodic::Enable "0";
EOF

# Update the package list
apt-get -y update;

# Update and upgrade
apt-get -y update
apt-get -y upgrade

# zgrandi: install Xubuntu without most extra packages
apt-get	-y install --no-install-recommends xubuntu-desktop \
	acpi-support \
	apport-gtk \
	curl \
	desktop-file-utils \
	evince \
	file-roller \
	firefox \
	fonts-liberation \
	gvfs \
	indicator-application \
	indicator-messages \
	indicator-sound \
	laptop-detect \
	libcurl3 \
	libnotify-bin \
	light-locker \
	lightdm-gtk-greeter-settings \
	menulibre \
	mousepad \
	pavucontrol \
	ristretto \
	thunar-archive-plugin \
	ttf-ubuntu-font-family \
	update-notifier \
	xfce4-datetime-plugin \
	xfce4-indicator-plugin \
	xfce4-mount-plugin \
	xfce4-power-manager \
	xfce4-quicklauncher-plugin \
	xfce4-screenshooter \
	xfce4-taskmanager \
	xfce4-terminal \
	xfce4-volumed \
	xfce4-whiskermenu-plugin;

reboot;
sleep 60;
