# Building the LFS System

## Installing Basic System Software

### Man-pages-6.15

```bash
tar -xvf man-pages-6.15.tar.xz
cd man-pages-6.15

rm -v man3/crypt*

make -R GIT=false prefix=/usr install

cd ..
rm -rf man-pages-6.15
```

for rest of softwares follow the lfs handbook with same structure.