# Building the LFS Cross Toolchain and Temporary Tools

## Entering Chroot and Building Additional Temporary Tools

This chapter shows how to build the last missing bits of the temporary system: the tools needed to build the various packages. Now that all circular dependencies have been resolved, a “chroot” environment, completely isolated from the host operating system (except for the running kernel), can be used for the build.

### Changing Ownership

To address this issue, change the ownership of the $LFS/* directories to user root by running the following command:

```bash
chown --from lfs -R root:root $LFS/{usr,var,etc,tools}
case $(uname -m) in
  x86_64) chown --from lfs -R root:root $LFS/lib64 ;;
esac
```

<p align="center">
  <img src="../readme_images/chapter7/99_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

### Preparing Virtual Kernel File Systems

Begin by creating the directories on which these virtual file systems will be mounted:

```bash
mkdir -pv $LFS/{dev,proc,sys,run}
```

<p align="center">
  <img src="../readme_images/chapter7/100_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Use the following command:

```bash
mount -v --bind /dev $LFS/dev
```

<p align="center">
  <img src="../readme_images/chapter7/101_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Mount the remaining virtual kernel file systems:

```bash
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run
```

<p align="center">
  <img src="../readme_images/chapter7/102_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Mount a tmpfs:

```bash
if [ -h $LFS/dev/shm ]; then
  install -v -d -m 1777 $LFS$(realpath /dev/shm)
else
  mount -vt tmpfs -o nosuid,nodev tmpfs $LFS/dev/shm
fi
```

<p align="center">
  <img src="../readme_images/chapter7/103_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

### Entering the Chroot Environment

Enter the chroot environment:

```bash
chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login
```

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter7/104_image.png" 
width="100%" style="; border-radius:12px;">
<p style="text-align:center;">Book</p>
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter7/105_image.png" 
width="100%" style="; border-radius:12px;">
<p style="text-align:center;">My Solution</p>


</td>
</tr>
</table>

### Creating Directories

Create some root-level directories:

```bash
mkdir -pv /{boot,home,mnt,opt,srv}
```


<p align="center">
  <img src="../readme_images/chapter7/106_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Create the required set of subdirectories:

```bash
mkdir -pv /etc/{opt,sysconfig}
mkdir -pv /lib/firmware
mkdir -pv /media/{floppy,cdrom}
mkdir -pv /usr/{,local/}{include,src}
mkdir -pv /usr/lib/locale
mkdir -pv /usr/local/{bin,lib,sbin}
mkdir -pv /usr/{,local/}share/{color,dict,doc,info,locale,man}
mkdir -pv /usr/{,local/}share/{misc,terminfo,zoneinfo}
mkdir -pv /usr/{,local/}share/man/man{1..8}
mkdir -pv /var/{cache,local,log,mail,opt,spool}
mkdir -pv /var/lib/{color,misc,locate}

ln -sfv /run /var/run
ln -sfv /run/lock /var/lock

install -dv -m 0750 /root
install -dv -m 1777 /tmp /var/tmp
```

<p align="center">
  <img src="../readme_images/chapter7/107_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


### Creating Essential Files and Symlinks

Create the following symbolic link:

```bash
ln -sv /proc/self/mounts /etc/mtab
```

<p align="center">
  <img src="../readme_images/chapter7/108_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


Create a basic /etc/hosts file:

```bash
cat > /etc/hosts << EOF
127.0.0.1  localhost $(hostname)
::1        localhost
EOF
```

<p align="center">
  <img src="../readme_images/chapter7/109_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Create the /etc/passwd file by running the following command:

```bash
cat > /etc/passwd << "EOF"
root:x:0:0:root:/root:/bin/bash
bin:x:1:1:bin:/dev/null:/usr/bin/false
daemon:x:6:6:Daemon User:/dev/null:/usr/bin/false
messagebus:x:18:18:D-Bus Message Daemon User:/run/dbus:/usr/bin/false
uuidd:x:80:80:UUID Generation Daemon User:/dev/null:/usr/bin/false
nobody:x:65534:65534:Unprivileged User:/dev/null:/usr/bin/false
EOF
```

<p align="center">
  <img src="../readme_images/chapter7/110_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


Create the /etc/group file by running the following command:

```bash
cat > /etc/group << "EOF"
root:x:0:
bin:x:1:daemon
sys:x:2:
kmem:x:3:
tape:x:4:
tty:x:5:
daemon:x:6:
floppy:x:7:
disk:x:8:
lp:x:9:
dialout:x:10:
audio:x:11:
video:x:12:
utmp:x:13:
cdrom:x:15:
adm:x:16:
messagebus:x:18:
input:x:24:
mail:x:34:
kvm:x:61:
uuidd:x:80:
wheel:x:97:
users:x:999:
nogroup:x:65534:
EOF
```

<p align="center">
  <img src="../readme_images/chapter7/111_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

We add this user here and delete this account at the end of that chapter.

```bash
echo "tester:x:101:101::/home/tester:/bin/bash" >> /etc/passwd
echo "tester:x:101:" >> /etc/group
install -o tester -d /home/tester
```

<p align="center">
  <img src="../readme_images/chapter7/112_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


To remove the “I have no name!” (I don't have "i have no name" i am already root but runned anyway):


```bash
exec /usr/bin/bash --login
```

<p align="center">
  <img src="../readme_images/chapter7/113_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


Initialize the log files and give them proper permissions:

```bash
touch /var/log/{btmp,lastlog,faillog,wtmp}
chgrp -v utmp /var/log/lastlog
chmod -v 664  /var/log/lastlog
chmod -v 600  /var/log/btmp
```

<p align="center">
  <img src="../readme_images/chapter7/114_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

### Gettext-0.26

<p align="center">
  <img src="../readme_images/chapter7/115_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Prepare Gettext for compilation:

```bash
./configure --disable-shared
```

<p align="center">
  <img src="../readme_images/chapter7/116_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter7/117_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the msgfmt, msgmerge, and xgettext programs:

```bash
cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin
```

<p align="center">
  <img src="../readme_images/chapter7/118_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

<p align="center">
  <img src="../readme_images/chapter7/119_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

### Bison-3.8.2

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter7/120_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter7/121_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

Prepare Bison for compilation:

```bash
./configure --prefix=/usr \
            --docdir=/usr/share/doc/bison-3.8.2
```

<p align="center">
  <img src="../readme_images/chapter7/122_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter7/123_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make install
```

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter7/124_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter7/125_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

### Perl-5.42.0

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter7/126_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter7/127_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

Prepare Perl for compilation:

```bash
sh Configure -des                                         \
             -D prefix=/usr                               \
             -D vendorprefix=/usr                         \
             -D useshrplib                                \
             -D privlib=/usr/lib/perl5/5.42/core_perl     \
             -D archlib=/usr/lib/perl5/5.42/core_perl     \
             -D sitelib=/usr/lib/perl5/5.42/site_perl     \
             -D sitearch=/usr/lib/perl5/5.42/site_perl    \
             -D vendorlib=/usr/lib/perl5/5.42/vendor_perl \
             -D vendorarch=/usr/lib/perl5/5.42/vendor_perl
```

<p align="center">
  <img src="../readme_images/chapter7/128_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter7/129_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make install
```

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter7/130_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter7/131_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

### Python-3.13.7

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter7/132_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter7/133_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

Prepare Python for compilation:

```bash
./configure --prefix=/usr       \
            --enable-shared     \
            --without-ensurepip \
            --without-static-libpython
```

<p align="center">
  <img src="../readme_images/chapter7/134_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter7/135_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make install
```

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter7/136_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter7/137_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

### Texinfo-7.

```bash
tar -xvf texinfo-7.2.tar.xz
cd texinfo-7.2

# Prepare Texinfo for compilation:
./configure --prefix=/usr

# Compile the package:
make

# Install the package:
make install

cd ..
rm -rf texinfo-7.2
```

### Util-linux-2.41.1

```bash
tar -xvf util-linux-2.41.1.tar.xz
cd util-linux-2.41.1

# Create this directory:
mkdir -pv /var/lib/hwclock

# Prepare Util-linux for compilation:
./configure --libdir=/usr/lib     \
            --runstatedir=/run    \
            --disable-chfn-chsh   \
            --disable-login       \
            --disable-nologin     \
            --disable-su          \
            --disable-setpriv     \
            --disable-runuser     \
            --disable-pylibmount  \
            --disable-static      \
            --disable-liblastlog2 \
            --without-python      \
            ADJTIME_PATH=/var/lib/hwclock/adjtime \
            --docdir=/usr/share/doc/util-linux-2.41.1

# Compile the package:
make

# Install the package:
make install

cd ..
rm -rf util-linux-2.41.1
```

### Cleaning up and Saving the Temporary System

```bash
# Cleaning
rm -rf /usr/share/{info,man,doc}/*
find /usr/{lib,libexec} -name \*.la -delete
rm -rf /tools

# Backup
exit

mountpoint -q $LFS/dev/shm && umount $LFS/dev/shm
umount $LFS/dev/pts
umount $LFS/{sys,proc,run,dev}

cd $LFS
tar -cJpf $HOME/lfs-temp-tools-12.4.tar.xz . # (this command will take a time)

# Run "Preparing Virtual Kernel File Systems" and "Entering the Chroot Environment" commands again
mount -v --bind /dev $LFS/dev
mount -vt devpts devpts -o gid=5,mode=0620 $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login
```

