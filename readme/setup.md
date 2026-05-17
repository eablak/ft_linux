This documentation created accordingly [Linux From Scratch Handbook.](https://www.linuxfromscratch.org/lfs/view/stable/index.html) You can check that one to learn detailly.

# Preparing for the Build

## Chapter 2: Preparing the Host System

In ft_linux project our goal is to have our own LFS system. To be able create that one i prefer to use virtual machine. So in my virtualbox i set up ubuntu 22. I will use this ubuntu 22 for my host machine anymore.

This new host machine needed for building LFS! In this host machine, will create partition itself, create a file system on it and mount it. All this steps will explained step by step in a continuous sections..


### Host System Requirements:

Firstly we have to be sure our host has enough requirements. To check my host system requirements i run the [version-check.sh](https://www.linuxfromscratch.org/lfs/view/stable/chapter02/hostreqs.html) file and then update necessary packages which are giving error.

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/00_image.png" 
width="100%" style="; border-radius:12px;">
<p style="text-align:center;">Before</p>
</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/01_image.png" 
width="100%" style="; border-radius:12px;">
<p style="text-align:center;">After</p>


</td>
</tr>
</table>

### Creating a New Partition:

We have to create our partitions for lfs. <i>"You must use at least 3 different partitions: root, /boot and a swap partition."</i>  So to create partitions lets check what is our current distro (left image).

We have one combined virtual disk which is sda. I prefer to shrink it to two part one is sda one is sdb. I will use sdb for lfs and create new partitions that disk.

The reason for why i prefer this one because my host ubuntu is located on sda and i want to keep it safe. So i created sdb disk which is showing on right image in table.

You can check from [here](/readme/utils/shrink_disk.md) to how i did this shrink disk process.

<table align="center">
<tr>
<td width="50%" align="center" style="text-align:center;">
<img 
src="../readme_images/02_image.png" 
width="100%" style="; border-radius:12px;">
<p style="text-align:center;">Before</p>

</td>
<td width="50%" align="center" style="text-align:center;">

<img 
src="../readme_images/08_image.png" 
width="100%" style="; border-radius:12px;">

<p style="text-align:center;">After</p>

</td>
</tr>
</table>

Now continue for <b>create partitons.</b>