# QEMU for ARM
[12-qemu_for_arm](./12-qemu_for_arm)

### the code
no `.asm` code to explain; will, instead explain the flags in the `qemu-system-arm` command
* `kernel` --> specify the location/path of the kernel to use
* `cpu` --> specify what CPU to use (recall, this is an emulator; the _emu_ in _qemu_ )
* `m` --> specify how much (virtual) RAM, in megabytes to allocate
* `M` --> specify what _emulated machine type_ to use
* `serial` --> allow operations using standard I/O
* `append` --> specify where _root_ (aka admin) will be located, the file system type and default permissions
* `hda` --> specify the location of the image (`.img` or `.iso`) to use
* `nic` --> forward a port from the _emulated_ system to the _emulator_ system so the emulated system can be accessed using SSH
* `no-reboot` --> tell the system not to reboot; boot as is instead

### notes
* idea is to see how to set up a linux  environment to program using ARM
* said environment is [Raspbian](http://www.raspbian.org/); Raspberry Pi plus Debian (Debian is a combination of two names; funny world)
* a R-Pi runs on an ARM processor; goes without saying that it is compatible with the ARM  variant of assembly language
* download the latest version of raspbian; [raspbian buster](https://downloads.raspberrypi.org/raspbian/images/raspbian-2020-02-14/) is used here
* kernel to use is [qemu-5.4.51-buster](https://github.com/dhruvvyas90/qemu-rpi-kernel/blob/master/kernel-qemu-5.4.51-buster); download it too
* there are two files in the root of the project folder so far:
    1. 2020-02-13-raspbian-buster.zip
    2. kernel-qemu-5.4.51-buster
* unzip the `.zip` file; expect the file `2020-02-13-raspbian-buster.img` to be added after the unzip  operation is successful
* run the following command:

~~~bash
sudo apt-get install qemu-system
~~~

* run the `qemu-system-arm` command in [12-qemu_for_arm](./12-qemu_for_arm)
* all set; R-Pi should be running
* start a terminal window inside the _emulated_ device/machine/system and type the following command

~~~bash
sudo service ssh start
~~~

* in the _emulator_ device, start a terminal window and ssh into the _emulated_ device viz:

~~~bash
ssh pi@127.0.0.1 -p 5022
~~~

type `yes` when prompted about ECDSA. default password is `raspberry`. congratulations, you  have _ssh_'d into the emulated device
