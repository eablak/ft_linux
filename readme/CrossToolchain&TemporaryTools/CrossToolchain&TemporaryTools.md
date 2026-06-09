# Building the LFS Cross Toolchain and Temporary Tools

Last session is "Building the LFS System" where we will compile all required packages, system configurations, install the kernel etc..

But to be able to do that we need to prepare infrastructure <i>(build enviroment)</i> first because in our current status for /mnt/lfs is just a mounted filesystem. So we can not compile any program in there. Therfore, our aim for this session create a temporary build
enviroment for "Building the LFS System".

We will create this enviroment with:
- Compiling a Cross-Toolchain
- Cross Compiling Temporary Tools
- Entering Chroot and Building Additional Temporary Tools

once these steps are completed, we will have isolated building LFS enviroment on the host system.

## Chapter 5: Compiling a Cross-Toolchain

A [toolchain](https://en.wikipedia.org/wiki/Toolchain) is a set of software development tools used simultaneously to complete complex software development tasks or to deliver a software product. Each tool in the chain is itself a piece of software that serves a different function and is optimized to work together with other tools in the chain.

Follow the [book](https://www.linuxfromscratch.org/lfs/view/stable/chapter05/chapter05.html) and [tutorial](https://www.youtube.com/watch?v=PZRI9sYOBJQ&list=PLyc5xVO2uDsD1rWqX90pmzUZEdRWnM8QU&index=6) to complete this chapter.

## Chapter 6: Cross Compiling Temporary Tools

In this chapter, we will compile some basic Linux commands and utilities. Our purpose is prepare a temporary userland enviroment for real (final) LFS. Because while we build real LFS we need this commands 
so we need to build before we do that.

Follow the [book](https://www.linuxfromscratch.org/lfs/view/stable/chapter06/chapter06.html) and [tutorial](https://www.youtube.com/watch?v=h_5jPeSsMn8&list=PLyc5xVO2uDsD1rWqX90pmzUZEdRWnM8QU&index=6) to complete this chapter.

## Chapter 7: Entering Chroot and Building Additional Temporary Tools

In this chapter, the goal is finalize temporary LFS sytem and with this one we can start the build real LFS system. With using chroot command we will work inside our isolated LFs enviroment instead of host operating system. Within this enviroment we will create necessary directories, files and build last temporary tools. After this chapter complete, we will be ready to start building real LFS system.

Follow the [book](https://www.linuxfromscratch.org/lfs/view/stable/chapter07/chapter07.html) and [tutorial](https://www.youtube.com/watch?v=RWZ6R7gwOHk&list=PLyc5xVO2uDsD1rWqX90pmzUZEdRWnM8QU&index=7) to compete this chapter.

<i>Note: If you reboot after this chapter do the mounting processes from previous chapters and also mounting process in this chapter which is virtual kernel file systems commands also run change root command and then continue for chapter 8. Necessary commands explained in previous reamde file on [Building LFS in Stages](../PreparingForTheBuild/PreparingForTheBuild.md) title.</i>