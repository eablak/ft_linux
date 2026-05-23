# Building the LFS Cross Toolchain and Temporary Tools

## Chapter 6: Cross Compiling Temporary Tools

Using the utilities will be possible in the next chapter after entering the “chroot” environment. But all the packages built in the present chapter need to be built before we do that. Therefore we cannot be independent of the host system yet.

### M4-1.4.20

<p align="center">
  <img src="../readme_images/chapter6/71_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Prepare M4 for compilation:

```bash
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)
```

<p align="center">
  <img src="../readme_images/chapter6/72_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```
<p align="center">
  <img src="../readme_images/chapter6/73_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make DESTDIR=$LFS install
```

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/74_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/75_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

### Ncurses-6.5-20250809

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/76_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/77_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

Run the following commands to build the tic program on the build host:

```bash
mkdir build
pushd build
  ../configure --prefix=$LFS/tools AWK=gawk
  make -C include
  make -C progs tic
  install progs/tic $LFS/tools/bin
popd
```

<p align="center">
  <img src="../readme_images/chapter6/78_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Prepare Ncurses for compilation:

```bash
./configure --prefix=/usr                \
            --host=$LFS_TGT              \
            --build=$(./config.guess)    \
            --mandir=/usr/share/man      \
            --with-manpage-format=normal \
            --with-shared                \
            --without-normal             \
            --with-cxx-shared            \
            --without-debug              \
            --without-ada                \
            --disable-stripping          \
            AWK=gawk
```

<p align="center">
  <img src="../readme_images/chapter6/79_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter6/80_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make DESTDIR=$LFS install
ln -sv libncursesw.so $LFS/usr/lib/libncurses.so
sed -e 's/^#if.*XOPEN.*$/#if 1/' \
    -i $LFS/usr/include/curses.h
```

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/81_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/82_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>


### Bash-5.3

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/83_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/84_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

Prepare Bash for compilation:

```bash
./configure --prefix=/usr                      \
            --build=$(sh support/config.guess) \
            --host=$LFS_TGT                    \
            --without-bash-malloc
```

<p align="center">
  <img src="../readme_images/chapter6/85_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter6/86_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make DESTDIR=$LFS install
```

<p align="center">
  <img src="../readme_images/chapter6/87_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


Make a link for the programs that use sh for a shell:

```bash
ln -sv bash $LFS/bin/sh
or
ln -sfv bash $LFS/usr/bin/sh (i used this one)
```

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/88_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/89_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

### Coreutils-9.7

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/90_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/91_image.png" 
width="100%" style="; border-radius:12px;">


</td>
</tr>
</table>

Prepare Coreutils for compilation:

```bash
./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --enable-install-program=hostname \
            --enable-no-install-program=kill,uptime
```

<p align="center">
  <img src="../readme_images/chapter6/92_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter6/93_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make DESTDIR=$LFS install
```

<p align="center">
  <img src="../readme_images/chapter6/94_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Move programs to their final expected locations.

```bash
mv -v $LFS/usr/bin/chroot              $LFS/usr/sbin
mkdir -pv $LFS/usr/share/man/man8
mv -v $LFS/usr/share/man/man1/chroot.1 $LFS/usr/share/man/man8/chroot.8
sed -i 's/"1"/"8"/'                    $LFS/usr/share/man/man8/chroot.8
```


<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/95_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/96_image.png" 
width="100%" style="; border-radius:12px;">

</td>
</tr>
</table>

### Diffutils-3.12

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter6/97_image.png" 
width="100%" style="; border-radius:12px;">
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter6/98_image.png" 
width="100%" style="; border-radius:12px;">

</td>
</tr>
</table>

Prepare Diffutils for compilation:

```bash
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            gl_cv_func_strcasecmp_works=y \
            --build=$(./build-aux/config.guess)
```

Compile the package:

```bash
make
```

Install the package:

```bash
make DESTDIR=$LFS install
```

Remove directory:

```bash
cd ..
rm -rf diffutils-3.12
```

### File-5.46

```bash
tar -xvf file-5.46.tar.gz
cd file-5.46


# Run the following commands to make a temporary copy of the file command:
mkdir build
pushd build
  ../configure --disable-bzlib      \
               --disable-libseccomp \
               --disable-xzlib      \
               --disable-zlib
  make
popd


# Prepare File for compilation:
./configure --prefix=/usr --host=$LFS_TGT --build=$(./config.guess)


# Compile the package:
make FILE_COMPILE=$(pwd)/build/src/file


# Install the package:
make DESTDIR=$LFS install


# Remove the libtool archive file
rm -v $LFS/usr/lib/libmagic.la


cd ..
rm -rf file-5.46
```

### Findutils-4.10.0

```bash
tar -xvf findutils-4.10.0.tar.xz
cd findutils-4.10.0


# Prepare Findutils for compilation:
./configure --prefix=/usr                   \
            --localstatedir=/var/lib/locate \
            --host=$LFS_TGT                 \
            --build=$(build-aux/config.guess)


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf findutils-4.10.0
```

### Gawk-5.3.2

```bash
tar -xvf gawk-5.3.2.tar.xz
cd gawk-5.3.2

# First, ensure some unneeded files are not installed:
sed -i 's/extras//' Makefile.in


# Prepare Gawk for compilation:
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf gawk-5.3.2
```

### Grep-3.12

```bash
tar -xvf grep-3.12.tar.xz
cd grep-3.12


# Prepare Grep for compilation:
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess)


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf grep-3.12
```

### Gzip-1.14

```bash
tar -xvf gzip-1.14.tar.xz
cd gzip-1.14


# Prepare Gzip for compilation:
./configure --prefix=/usr --host=$LFS_TGT


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf gzip-1.14
```

### Make-4.4.1

```bash
tar -xvf make-4.4.1.tar.gz
cd make-4.4.1


# Prepare Make for compilation:
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf make-4.4.1
```

### Patch-2.8

```bash
tar -xvf patch-2.8.tar.xz
cd patch-2.8


# Prepare Patch for compilation:
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf patch-2.8
```

### Sed-4.9

```bash
tar -xvf sed-4.9.tar.xz
cd sed-4.9


# Prepare Sed for compilation:
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(./build-aux/config.guess)


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf sed-4.9
```


### Tar-1.35

```bash
tar -xvf tar-1.35.tar.xz
cd tar-1.35


# Prepare Tar for compilation:
./configure --prefix=/usr   \
            --host=$LFS_TGT \
            --build=$(build-aux/config.guess)

# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


cd ..
rm -rf tar-1.35
```

### Xz-5.8.1

```bash
tar -xvf xz-5.8.1.tar.xz
cd xz-5.8.1


# Prepare Xz for compilation:
./configure --prefix=/usr                     \
            --host=$LFS_TGT                   \
            --build=$(build-aux/config.guess) \
            --disable-static                  \
            --docdir=/usr/share/doc/xz-5.8.1


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


# Remove the libtool archive file:
rm -v $LFS/usr/lib/liblzma.la


cd ..
rm -rf xz-5.8.1
```

### Binutils-2.45 - Pass 2

```bash
tar -xvf binutils-2.45.tar.xz
cd binutils-2.45

# Binutils building system relies on an shipped libtool copy to link against internal static libraries, but the libiberty and zlib copies shipped in the package do not use libtool. This inconsistency may cause produced binaries mistakenly linked against libraries from the host distro. Work around this issue:

sed '6031s/$add_dir//' -i ltmain.sh


# Create a separate build directory again:
mkdir -v build
cd       build


# Prepare Binutils for compilation:
../configure                   \
    --prefix=/usr              \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --disable-nls              \
    --enable-shared            \
    --enable-gprofng=no        \
    --disable-werror           \
    --enable-64-bit-bfd        \
    --enable-new-dtags         \
    --enable-default-hash-style=gnu


# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


# Remove the libtool archive file:
rm -v $LFS/usr/lib/lib{bfd,ctf,ctf-nobfd,opcodes,sframe}.{a,la}


cd ../..
rm -rf binutils-2.45
```

### GCC-15.2.0 - Pass 2


```bash
tar -xvf gcc-15.2.0.tar.xz
cd gcc-15.2.0


# As in the first build of GCC, the GMP, MPFR, and MPC packages are required. Unpack the tarballs and move them into the required directories:
tar -xf ../mpfr-4.2.2.tar.xz
mv -v mpfr-4.2.2 mpfr
tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc


# If you are building on x86_64, change the default directory name for 64-bit libraries to “lib”:
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
  ;;
esac


# Override the build rules of the libgcc and libstdc++ headers to allow building these libraries with POSIX threads support:
sed '/thread_header =/s/@.*@/gthr-posix.h/' \
    -i libgcc/Makefile.in libstdc++-v3/include/Makefile.in


# Create a separate build directory again:
mkdir -v build
cd       build


# Prepare Xz for compilation:
../configure                   \
    --build=$(../config.guess) \
    --host=$LFS_TGT            \
    --target=$LFS_TGT          \
    --prefix=/usr              \
    --with-build-sysroot=$LFS  \
    --enable-default-pie       \
    --enable-default-ssp       \
    --disable-nls              \
    --disable-multilib         \
    --disable-libatomic        \
    --disable-libgomp          \
    --disable-libquadmath      \
    --disable-libsanitizer     \
    --disable-libssp           \
    --disable-libvtv           \
    --enable-languages=c,c++   \
    LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc



# Compile the package:
make


# Install the package:
make DESTDIR=$LFS install


# As a finishing touch, create a utility symlink.
ln -sv gcc $LFS/usr/bin/cc


cd ../..
rm -rf gcc-15.2.0
```
