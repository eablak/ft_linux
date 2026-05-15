# Packages

The goal of LFS is build a complete and usable foundation-level system including all the packages needed to replicate itself and providing a relatively minimal base from which to customize a more complete system based on the user's choices.

Rationale for Packages in LFS:

<table>

  <thead>
    <tr>
      <th>Package</th>
      <th>Description</th>
    </tr>
  </thead>

  <tbody>
    <tr>
      <td><b>ACL</b></td>
      <td>This package contains utilities to administer Access Control Lists, which are used to define fine-grained discretionary access rights for files and directories.</td>
    </tr>
    <tr>
      <td><b>Attr</b></td>
      <td>This package contains programs for managing extended attributes on file system objects.</td>
    </tr>
    <tr>
      <td><b>Autoconf</b></td>
      <td>This package supplies programs for producing shell scripts that can automatically configure source code from a developer's template. It is often needed to rebuild a package after the build procedure has been updated.</td>
    </tr>
    <tr>
      <td><b>Automake</b></td>
      <td>This package contains programs for generating Make files from a template. It is often needed to rebuild a package after the build procedure has been updated.</td>
    </tr>
    <tr>
      <td><b>Bash</b></td>
      <td>This package satisfies a Linux Standard Base (LSB) core requirement to provide a Bourne Shell interface to the system. It was chosen over other shell packages because of its common usage and extensive capabilities.</td>
    </tr>
    <tr>
      <td><b>Bc</b></td>
      <td>This package provides an arbitrary precision numeric processing language. It satisfies a requirement for building the Linux kernel.</td>
    </tr>
    <tr>
      <td><b>Binutils</b></td>
      <td>This package supplies a linker, an assembler, and other tools for handling object files. The programs in this package are needed to compile most of the packages in an LFS system.</td>
    </tr>
    <tr>
      <td><b>Bison</b></td>
      <td>This package contains the GNU version of yacc (Yet Another Compiler Compiler) needed to build several of the LFS programs.</td>
    </tr>
    <tr>
      <td><b>Bzip2</b></td>
      <td>This package contains programs for compressing and decompressing files. It is required to decompress many LFS packages.</td>
    </tr>
    <tr>
      <td><b>Check</b></td>
      <td>This package provides a test harness for other programs.</td>
    </tr>
    <tr>
      <td><b>Coreutils</b></td>
      <td>This package contains a number of essential programs for viewing and manipulating files and directories. These programs are needed for command line file management, and are necessary for the installation procedures of every package in LFS.</td>
    </tr>
    <tr>
      <td><b>DejaGNU</b></td>
      <td>This package supplies a framework for testing other programs.</td>
    </tr>
    <tr>
      <td><b>Diffutils</b></td>
      <td>This package contains programs that show the differences between files or directories. These programs can be used to create patches, and are also used in many packages' build procedures.</td>
    </tr>
    <tr>
      <td><b>Eudev</b></td>
      <td>The Eudev package contains programs for dynamic creation of device nodes.</td>
    </tr>
    <tr>
      <td><b>E2fsprogs</b></td>
      <td>This package supplies utilities for handling the ext2, ext3 and ext4 file systems. These are the most common thoroughly tested file systems that Linux supports.</td>
    </tr>
    <tr>
      <td><b>Expat</b></td>
      <td>This package yields a relativly small XML parsing library. Its required by the XML::Parser Perl module.</td>
    </tr>
    <tr>
      <td><b>Expect</b></td>
      <td>This package contains a program for carrying out scripted dialogues with other interactive programs. It is commonly used for testing other packages.</td>
    </tr>
    <tr>
      <td><b>File</b></td>
      <td>This package contains a utility for determing the type of a given file or files. A few packages need it in their build scripts.</td>
    </tr>
    <tr>
      <td><b>Findutils</b></td>
      <td>This package provides to find files in a file system. It is used in many packages build scripts.</td>
    </tr>
    <tr>
      <td><b>Flex</b></td>
      <td>This package contains a utility for generating programs that recognize patterns in text. It is the GNU version of the lex (lexical analyzer) program. It is required to build several LFS packages.</td>
    </tr>
    <tr>
      <td><b>Gawk</b></td>
      <td>This package supplies programs for manipulating text files. It is the GNU version of awk (Aho-Weinberg-Kernighan). It is used in many other packages build scripts.</td>
    </tr>
    <tr>
      <td><b>GCC</b></td>
      <td>This is the Gnu Complier Collection. It contains the C and C++ compliers as well as several others not build by LFS.</td>
    </tr>
    <tr>
      <td><b>GDBM</b></td>
      <td>This package contains the GNU Database Manager library. It is used by one other LFS package, Man-DB.</td>
    </tr>
    <tr>
      <td><b>Gettext</b></td>
      <td>This package provides utilities and libraries for the internatiolazition and localization of many packages.</td>
    </tr>
    <tr>
      <td><b>Glibc</b></td>
      <td>This package contains the main C library. Linux programs will not run without it.</td>
    </tr>
    <tr>
      <td><b>GMP</b></td>
      <td>This package supplies math libraries that provide useful functions for arbitrary precision arithmetic. It is needed to build GCC.</td>
    </tr>
    <tr>
      <td><b>Gperf</b></td>
      <td>This package produces a program that generates a perfect hash function from a set of keys. It is required bu Udev.</td>
    </tr>
    <tr>
      <td><b>Grep</b></td>
      <td>This package contains programs for searching through files. These programs are used by most packages build scripts.</td>
    </tr>
    <tr>
      <td><b>Groff</b></td>
      <td>This package contributes programs for processing and formatting text. One important function of these programs is to format man pages.</td>
    </tr>
    <tr>
      <td><b>GRUB</b></td>
      <td>This is the Grand Unified Boat Loader. It is the most flexible of several boot loaders available.</td>
    </tr>
    <tr>
      <td><b>Gzip</b></td>
      <td>This package contains programs for compressing and decompressing files. It is needed to decompress many packages in.</td>
    </tr>
    <tr>
      <td><b>lana-Etc</b></td>
      <td>This package provides data for network services and protocols. It is needed to enable proper networking capabilities</td>
    </tr>
    <tr>
      <td><b>Inetutils</b></td>
      <td>This package supplies programs for basic network administration.</td>
    </tr>
    <tr>
      <td><b>Intltool</b></td>
      <td>This package contributes tools for extracting translatable strings from source files.</td>
    </tr>
    <tr>
      <td><b>IProute2</b></td>
      <td>This package contains programs for basic and advanced IPv4 and IPv6 networking. It was chosen over the other common network tools package (net-tools) for its IPv6 capabilities.</td>
    </tr>
    <tr>
      <td><b>Kbd</b></td>
      <td>This package produces key-table files, keyboard utilities for non-US keyboards, and a number of console fonts.</td>
    </tr>
    <tr>
      <td><b>Kmod</b></td>
      <td>This package supplies programs needed to administer Linux kernel modules.</td>
    </tr>
    <tr>
      <td><b>Less</b></td>
      <td>This package contains a very nice text file viewer that allows scrolling up or down when viewing a file. Many packages use it for paging the output.</td>
    </tr>
    <tr>
      <td><b>Lipcap</b></td>
      <td>This package implements the userspace interfaces to the POSIX 1003.1e capabilities available in Linux kernels.</td>
    </tr>
    <tr>
      <td><b>Libpipeline</b></td>
      <td>The Libpipeline package supplies a library for manipulating pipelines of subprocesses in a flexible and convenient way. It is required by the Man-DB package.</td>
    </tr>
    <tr>
      <td><b>Libtool</b></td>
      <td>This package contains the GNU generic library support script. It wraps the complexity of using shared libraries into a consistent, portable interface. It is needed by the test suites in other LFS packages.</td>
    </tr>
    <tr>
      <td><b></b></td>
      <td></td>
    </tr>
    <tr>
      <td><b></b></td>
      <td></td>
    </tr>
  </tbody>
</table>

