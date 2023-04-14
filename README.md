## Installed software

* **Window Manager** • [Hyprland](https://hyprland.org/)
* **Shell** • [Oh My Zsh](https://ohmyz.sh/) w/ [Starship Prompt](https://starship.rs/)
* **Terminal** • [kitty](https://sw.kovidgoyal.net/kitty/)
* **Panel** • [Waybar](https://aur.archlinux.org/packages/waybar-hyprland-git) (Patched waybar following Hyprland FAQ)
* **Notification Daemon** • [Dunst](https://github.com/dunst-project/dunst)
* **Launcher** • [wofi](https://hg.sr.ht/~scoopta/wofi)
* **File Manager** • [Ranger](https://github.com/ranger/ranger)
* **IDE** • [NvChad-V2](https://github.com/NvChad/NvChad)

#### Themes
* **GTK** • GTK
* **Icon** • Icon theme
* **Cursor** • Cursor theme

#### Oh-My-Zsh Extensions
* [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
* [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
* [zsh-nvm](https://github.com/lukechilds/zsh-nvm)

## Screenshots
![Screenshot](assets/screenshot.png)

## Setup

### Install yay

```sh
sudo pacman -S base-devel
```

```sh
mkdir $HOME/git
cd $HOME/git
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
```
### Install needed dependencies

```sh
yay -S hyprland-git dunst hyprpaper-git waybar-hyprland-git \
qt5-wayland qt6-wayland 
```

#### Extras

```sh
# themes
yay -S catppuccin-gtk-theme-mocha nwg-look 

# apps
yay -S cava ranger zsh starship neovim

# graphical file manager (optional)
yay -S thunar thunar archive-plugin file-roller
```

### Clone this repo

```sh
git clone https://github.com/lachie-underhill/dotfiles $HOME/dotfiles
cd $HOME/dotfiles
```

#### Using Stow

[GNU Stow](https://www.gnu.org/software/stow/) (or just stow) is a symbolink link manager and is used to manage all of my dotfiles.

You'll notice that all of the config is stored in folders pertaining to the software that the config is for. For example, all the config required for dunst is in a folder named `dunst`.

You can then use stow to create symlinks in the required config location for those apps to pick them up.


```sh
stow hyprland nvim waybar
```

*Note: You will need to delete the existing files/directories if they already exist*

If you're interested in learning more about how this method works, I'd highly recommend checking out [this article](https://alexpearce.me/2016/02/managing-dotfiles-with-stow/) by Alex Pearce.


## Credits

[/r/unixporn](https://reddit.com/r/unixporn) for endless inspo

---

<details>
<summary><b>Detailed Breakdown of my Arch Install</b></summary>

#### Disclaimer

If you're not me, you probably don't need to be reading this. I mainly just wanted to have this process documented so I don't have to keep rediscovering solutions to problems I've already solved.

If you aren't me and you're just curious, keep reading! Don't expect this to make much sense or even be up to date though. You can think of this as a highly opinionated version of the [Arch Installation Guide](https://wiki.archlinux.org/title/installation_guide).

### Pre-Requisites

1. Have an Arch ISO on a USB (w/ [Ventoy](https://www.ventoy.net/en/index.html) or [RUFUS](https://rufus.ie/))
2. Boot into said USB
3. Connect to the internet ([iwctl docs](https://wiki.archlinux.org/title/Iwd#iwctl) for Wi-Fi)

### Disk Partitioning

It is assumed you already have an empty drive, or a drive with unallocated space to be used for this installation.

All instructions will be assuming an install on `/dev/sda`. Modify where required if using a different disk.

Using whatever paritioning tool you like (fdisk, gdisk etc.), you will need two partitions:

1. EFI partition on the boot drive (will already exist if dual-booting with Windows)
	* Will most likely be `/dev/sda1`
	* 100MB is fine, but if it's feasible, create with 512MB
	* Fat32 format (`mkfs.fat -F 32 /dev/sda1`)
2. Root partition
	* EXT4 format (`mkfs.ext4 /dev/sda2`)

You can create an additional Home Partition (`ext4`) to use for your `/home` directory if you like. I'm sure there's a good reason to do this, but I haven't ever felt the need.

### Optimise mirrorlist

Pacman uses something called the mirrorlist, which defines where to pull packages from when downloading. The default mirrorlist will most likely be quite slow, sometimes to the point of downloads timing out. We can use a tool called `reflector` to optimise this mirrorlist to ensure fast downloads.

```sh
pacman -Syy
pacman -S reflector
cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak

reflector -c "Australia" -l 10 --save /etc/pacman.d/mirrorlist
```

### Install Arch Linux

Now on to the fun part - actually installing Arch.

#### Mount partitions

```sh
mount /dev/sda2 /mnt
mount /dev/sda1 /mnt/boot/efi

# optional - if using Home Partition
mount /dev/sda3 /mnt/home
```

#### Pacstrap

Add whatever packages you want to add to your actual Arch installation.

```sh
pacstrap /mnt base linux linux-firmware linux-headers vim git networkmanager
```

#### Generate fstab

We've manually mounted our partitions, but when we reboot these mounts will disappear. Using `genfstab`, we can tell the system to mount these partitions every time.

```sh
genfstab -U /mnt >> /mnt/etc/fstab
```

#### Arch chroot

For the rest of this installation, we'll chroot into our actual install.

```sh
arch-chroot /mnt
```

#### Set Timezone

```sh
# Set timezone
ln -sf /usr/share/zoneinfo/Australia/Brisbane /etc/localtime

# Generate /etc/adjtime
hwclock --systohc
```

#### Localisation

Edit `/etc/locale.gen` and uncomment your locale (eg. `en_AU.UTF-8`), then generate locales.

```sh
locale-gen
echo LANG=en_AU.UTF-8 > /etc/locale.conf
export LANG=en_AU.UTF-8
```

#### Network Configuration

```sh
echo myhostname > /etc/hostname
touch /etc/hosts
```

Edit `/etc/hosts` file to include the following (replace myhostname with the hostname you chose earlier).

```sh
127.0.0.1 localhost
::1		  localhost
127.0.0.1 myhostname
```

```sh
systemctl enable NetworkManager.service
```

#### User Config

```sh
# Set root password
passwd

# Add sudo group
pacman -S sudo
groupadd sudo

# Create user
useradd -m username
passwd username

# Add user to groups
usermod -aG wheel,sudo username
```

Modify visudo file using `visudo` command and uncomment/add the following lines:
```sh
%wheel ALL=(ALL:ALL) ALL
%sudo ALL=(ALL:ALL) NOPASSWD: ALL
```
#### Install Bootloader

It's recommended to install grub now, even if you want to use [REFInd](https://www.rodsbooks.com/refind/) later. REFInd really doesn't like being installed when using the live disk, because the `refind-install` script isn't that smart (or I'm not smart enough to use it properly).

If you missed the step before, make sure the EFI partition is mounted at `/boot/efi`.

```sh
pacman -S grub efibootmgr
grub-install --target=x86_64-efi --bootloader-id=GRUB --efi-directory=/boot/efi
grub-mkconfig -o /boot/grub/grub.cfg
```

#### Reboot

```sh
# Exit chroot environment
exit

# Unmount all partitions
umount -R /mnt

reboot
```

Remove your installation media, and make sure you boot into your new install.

It's recommended to verify you can boot into both Arch and Windows at this point.

#### Install yay
[See above](#install-yay)

#### NVIDIA (optional)

You obviously only need to do this if you have an NVIDIA GPU.

```sh
# Use nvidia-open-dkms if using supported GPU:
# https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
pacman -S nvidia-dkms
```

In `/etc/mkinitcpio.conf`, add `nvidia nvidia_modeset nvidia_uvm nvidia_drm` to your `MODULES`

```sh
mkinitcpio --config /etc/mkinitcpio.conf --generate /boot/initramfs-custom.img
echo options nvidia-drm modeset=1 > /etc/modprobe.d/nvidia.conf
```

##### Create pacman hook

To avoid the possibility of forgetting to update initramfs after an NVIDIA driver upgrade, add the following to `/etc/pacman.d/hooks/nvidia.hook`:

```sh
[Trigger]
Operation=Install
Operation=Upgrade
Operation=Remove
Type=Package
Target=nvidia-dkms # or nvidia-open-dkms if installed above
Target=linux

[Action]
Description=Update NVIDIA module in initcpio
Depends=mkinitcpio
When=PostTransaction
NeedsTargets
Exec=/bin/sh -c 'while read -r trg; do case $trg in linux) exit 0; esac; done; /usr/bin/mkinitcpio -P'
```

</details>
