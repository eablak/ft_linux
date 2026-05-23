# Building the LFS Cross Toolchain and Temporary Tools

## Chapter 5: Compiling a Cross-Toolchain

### Binutils-2.45 - Pass 1

<p align="center">
  <img src="../readme_images/chapter5/34_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

The Binutils documentation recommends building Binutils in a dedicated build directory:

```bash
mkdir -v build
cd       build
```

<p align="center">
  <img src="../readme_images/chapter5/35_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Now prepare Binutils for compilation:

```bash
time {../configure --prefix=$LFS/tools \
             --with-sysroot=$LFS \
             --target=$LFS_TGT   \
             --disable-nls       \
             --enable-gprofng=no \
             --disable-werror    \
             --enable-new-dtags  \
             --enable-default-hash-style=gnu && make && make install; }
```

<p align="center">
  <img src="../readme_images/chapter5/36_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

We can remove the directory:

<p align="center">
  <img src="../readme_images/chapter5/37_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

So that's our first package built binutils done.

### GCC-15.2.0 - Pass 1

So once again we are going to through the motions of extracting the package of archive:

<p align="center">
  <img src="../readme_images/chapter5/38_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Rename the resulting directories so the GCC build procedures will automatically use them:

```bash
tar -xf ../mpfr-4.2.2.tar.xz
mv -v mpfr-4.2.2 mpfr
tar -xf ../gmp-6.3.0.tar.xz
mv -v gmp-6.3.0 gmp
tar -xf ../mpc-1.3.1.tar.gz
mv -v mpc-1.3.1 mpc
```

<p align="center">
  <img src="../readme_images/chapter5/39_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

```bash
case $(uname -m) in
  x86_64)
    sed -e '/m64=/s/lib64/lib/' \
        -i.orig gcc/config/i386/t-linux64
 ;;
esac
```
<p align="center">
  <img src="../readme_images/chapter5/40_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

The GCC documentation recommends building GCC in a dedicated build directory:

```bash
mkdir -v build
cd       build
```

<p align="center">
  <img src="../readme_images/chapter5/41_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Prepare GCC for compilation:

```bash
../configure                  \
    --target=$LFS_TGT         \
    --prefix=$LFS/tools       \
    --with-glibc-version=2.42 \
    --with-sysroot=$LFS       \
    --with-newlib             \
    --without-headers         \
    --enable-default-pie      \
    --enable-default-ssp      \
    --disable-nls             \
    --disable-shared          \
    --disable-multilib        \
    --disable-threads         \
    --disable-libatomic       \
    --disable-libgomp         \
    --disable-libquadmath     \
    --disable-libssp          \
    --disable-libvtv          \
    --disable-libstdcxx       \
    --enable-languages=c,c++
```

<p align="center">
  <img src="../readme_images/chapter5/42_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile GCC by running:

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter5/43_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package:

```bash
make install
```

<p align="center">
  <img src="../readme_images/chapter5/44_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

```bash
cd ..
cat gcc/limitx.h gcc/glimits.h gcc/limity.h > \
  `dirname $($LFS_TGT-gcc -print-libgcc-file-name)`/include/limits.h
```

<p align="center">
  <img src="../readme_images/chapter5/45_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

That's the end of gcc. So, delete that directory and its contents.

<p align="center">
  <img src="../readme_images/chapter5/46_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

### Linux-6.16.1 API Headers

We extract the linux package

<p align="center">
  <img src="../readme_images/chapter5/47_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Make sure there are no stale files embedded in the package:

```bash
make mrproper
```

<p align="center">
  <img src="../readme_images/chapter5/48_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Now extract the user-visible kernel headers from the source. 

```bash
make headers
find usr/include -type f ! -name '*.h' -delete
cp -rv usr/include $LFS/usr
```

<p align="center">
  <img src="../readme_images/chapter5/49_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

That's done. So again, go back to sources and delete the directory:

<p align="center">
  <img src="../readme_images/chapter5/50_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

### Glibc-2.42

<p align="center">
  <img src="../readme_images/chapter5/51_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

First, create a symbolic link for LSB compliance:

```bash
case $(uname -m) in
    i?86)   ln -sfv ld-linux.so.2 $LFS/lib/ld-lsb.so.3
    ;;
    x86_64) ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64
            ln -sfv ../lib/ld-linux-x86-64.so.2 $LFS/lib64/ld-lsb-x86-64.so.3
    ;;
esac
```
<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/chapter5/52_image.png" 
width="100%" style="; border-radius:12px;">
<p style="text-align:center;">LFS command</p>
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/chapter5/53_image.png" 
width="100%" style="; border-radius:12px;">
<p style="text-align:center;">/mnt/lfs/lib64 exsist as a symlink so i recreate it and run the command</p>

</td>
</tr>
</table>

Apply the patch to make such programs store their runtime data in the FHS-compliant locations:

```bash
patch -Np1 -i ../glibc-2.42-fhs-1.patch
```

<p align="center">
  <img src="../readme_images/chapter5/54_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

The Glibc documentation recommends building Glibc in a dedicated build directory:

```bash
mkdir -v build
cd       build
```

<p align="center">
  <img src="../readme_images/chapter5/55_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Ensure that the ldconfig and sln utilities are installed into /usr/sbin:

```bash
echo "rootsbindir=/usr/sbin" > configparms
```

<p align="center">
  <img src="../readme_images/chapter5/56_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Prepare Glibc for compilation:

```bash
../configure                             \
      --prefix=/usr                      \
      --host=$LFS_TGT                    \
      --build=$(../scripts/config.guess) \
      --disable-nscd                     \
      libc_cv_slibdir=/usr/lib           \
      --enable-kernel=5.4
```

<p align="center">
  <img src="../readme_images/chapter5/57_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compile the package

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter5/58_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the package

```bash
make DESTDIR=$LFS install
```

<p align="center">
  <img src="../readme_images/chapter5/59_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

```bash
sed '/RTLDLIST=/s@/usr@@g' -i $LFS/usr/bin/ldd
echo 'int main(){}' | $LFS_TGT-gcc -x c - -v -Wl,--verbose &> dummy.log
readelf -l a.out | grep ': /lib'
```

<p align="center">
  <img src="../readme_images/chapter5/60_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Some checks

```bash
grep -E -o "$LFS/lib.*/S?crt[1in].*succeeded" dummy.log
grep -B3 "^ $LFS/usr/include" dummy.log
grep 'SEARCH.*/usr/lib' dummy.log |sed 's|; |\n|g'
grep "/lib.*/libc.so.6 " dummy.log
grep found dummy.log
```

<p align="center">
  <img src="../readme_images/chapter5/61_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Once everything is working correctly, clean up the test files:

```bash
rm -v a.out dummy.log
```

<p align="center">
  <img src="../readme_images/chapter5/62_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


<p align="center">
  <img src="../readme_images/chapter5/63_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

### Libstdc++ from GCC-15.2.0


<p align="center">
  <img src="../readme_images/chapter5/64_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Create a separate build directory for Libstdc++ and enter it:

```bash
mkdir -v build
cd       build
```

<p align="center">
  <img src="../readme_images/chapter5/65_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Compilation:

```bash
../libstdc++-v3/configure      \
    --host=$LFS_TGT            \
    --build=$(../config.guess) \
    --prefix=/usr              \
    --disable-multilib         \
    --disable-nls              \
    --disable-libstdcxx-pch    \
    --with-gxx-include-dir=/tools/$LFS_TGT/include/c++/15.2.0
```

<p align="center">
  <img src="../readme_images/chapter5/66_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

```bash
make
```

<p align="center">
  <img src="../readme_images/chapter5/67_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

Install the library:

```bash
make DESTDIR=$LFS install
```

<p align="center">
  <img src="../readme_images/chapter5/68_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>


Remove the libtool archive files because they are harmful for cross-compilation:

```bash
rm -v $LFS/usr/lib/lib{stdc++{,exp,fs},supc++}.la
```

<p align="center">
  <img src="../readme_images/chapter5/69_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>

<p align="center">
  <img src="../readme_images/chapter5/70_image.png" width="70%" style="border-radius:12px;" controls></img>
</p>
