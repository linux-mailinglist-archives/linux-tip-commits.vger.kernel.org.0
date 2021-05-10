Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D9DD37887F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 May 2021 13:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233089AbhEJLVk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 May 2021 07:21:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36332 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235358AbhEJLAq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 May 2021 07:00:46 -0400
Date:   Mon, 10 May 2021 10:59:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620644380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4bwcdjXJB219rw+KvEGagNYUQwkOgvF/+8UcrsV4ak=;
        b=Qqe12Ok9kWZMgZLu7JOYKCPzpAMwio8aklbXlwCDicq8YgJD+FWQa+eZ2LsE1IMJh+7SQR
        6fJnYrXbMIjSH8z5abPIOf5o4oarLuQBtcXR7UY4ogv4oLP4ZMAoKFMzpFSjPVVEH1+Dr6
        L7t+5hBDB+EYl4awsAuDPGP4Iwg+Ivk8UDMyWEuUkWk1jH4Byov44UXDtl9h8nJENd4IJE
        MlB64xuOwoZYIHPRIJaSquXj6TDji5yZbhcKSPA3nsUMMoYPu2ozvekVGzFV34dKZGL0jq
        cEy4C11KFEkRVg/hYZOGtFN+zQrBhwZTVZxkTSSrOX3d/qUMuPpF5eE8EVcUrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620644380;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F4bwcdjXJB219rw+KvEGagNYUQwkOgvF/+8UcrsV4ak=;
        b=feicRhi46syL1uCvSZ4bhzW5GQJIzo+7hlz7syMy9CW7bsmP/DsQTYwR6129+8+0HcfgxW
        qZ1tWxPy1vER1pCQ==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/boot: Modernize genimage script; hdimage+EFI support
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210510082840.628372-1-hpa@zytor.com>
References: <20210510082840.628372-1-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162064438019.29796.15433281469203591722.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     f279b49f13bd2151bbe402a1d812c1e3646c4bbb
Gitweb:        https://git.kernel.org/tip/f279b49f13bd2151bbe402a1d812c1e3646c4bbb
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Mon, 10 May 2021 01:28:40 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 10 May 2021 12:27:50 +02:00

x86/boot: Modernize genimage script; hdimage+EFI support

The image generation scripts in arch/x86/boot are pretty out of date,
except for the isoimage target. Update and clean up the
genimage.sh script, and make it support an arbitrary number of
initramfs files in the image.

Add a "hdimage" target, which can be booted by either BIOS or
EFI (if the kernel is compiled with the EFI stub.) For EFI to be able
to pass the command line to the kernel, we need the EFI shell, but the
firmware builtin EFI shell, if it even exists, is pretty much always
the last resort boot option, so search for OVMF or EDK2 and explicitly
include a copy of the EFI shell.

To make this all work, use bash features in the script.  Furthermore,
this version of the script makes use of some mtools features,
especially mpartition, that might not exist in very old version of
mtools, but given all the other dependencies on this script this
doesn't seem such a big deal.

Finally, put a volume label ("LINUX_BOOT") on all generated images.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210510082840.628372-1-hpa@zytor.com
---
 arch/x86/Makefile            |   5 +-
 arch/x86/boot/.gitignore     |   1 +-
 arch/x86/boot/Makefile       |  44 ++---
 arch/x86/boot/genimage.sh    | 303 ++++++++++++++++++++++++----------
 arch/x86/boot/mtools.conf.in |   3 +-
 5 files changed, 252 insertions(+), 104 deletions(-)

diff --git a/arch/x86/Makefile b/arch/x86/Makefile
index c77c5d8..d42764c 100644
--- a/arch/x86/Makefile
+++ b/arch/x86/Makefile
@@ -256,7 +256,7 @@ drivers-$(CONFIG_FB) += arch/x86/video/
 
 boot := arch/x86/boot
 
-BOOT_TARGETS = bzdisk fdimage fdimage144 fdimage288 isoimage
+BOOT_TARGETS = bzdisk fdimage fdimage144 fdimage288 hdimage isoimage
 
 PHONY += bzImage $(BOOT_TARGETS)
 
@@ -314,8 +314,9 @@ define archhelp
   echo  '  fdimage		- Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
   echo  '  fdimage144		- Create 1.4MB boot floppy image (arch/x86/boot/fdimage)'
   echo  '  fdimage288		- Create 2.8MB boot floppy image (arch/x86/boot/fdimage)'
+  echo  '  hdimage		- Create a BIOS/EFI hard disk image (arch/x86/boot/hdimage)'
   echo  '  isoimage		- Create a boot CD-ROM image (arch/x86/boot/image.iso)'
-  echo  '			  bzdisk/fdimage*/isoimage also accept:'
+  echo  '			  bzdisk/fdimage*/hdimage/isoimage also accept:'
   echo  '			  FDARGS="..."  arguments for the booted kernel'
   echo  '                  	  FDINITRD=file initrd for the booted kernel'
   echo  ''
diff --git a/arch/x86/boot/.gitignore b/arch/x86/boot/.gitignore
index 9cc7f13..1189be0 100644
--- a/arch/x86/boot/.gitignore
+++ b/arch/x86/boot/.gitignore
@@ -11,3 +11,4 @@ setup.elf
 fdimage
 mtools.conf
 image.iso
+hdimage
diff --git a/arch/x86/boot/Makefile b/arch/x86/boot/Makefile
index fe60520..dfbc26a 100644
--- a/arch/x86/boot/Makefile
+++ b/arch/x86/boot/Makefile
@@ -29,7 +29,7 @@ KCOV_INSTRUMENT		:= n
 SVGA_MODE	:= -DSVGA_MODE=NORMAL_VGA
 
 targets		:= vmlinux.bin setup.bin setup.elf bzImage
-targets		+= fdimage fdimage144 fdimage288 image.iso mtools.conf
+targets		+= fdimage fdimage144 fdimage288 image.iso hdimage
 subdir-		:= compressed
 
 setup-y		+= a20.o bioscall.o cmdline.o copy.o cpu.o cpuflags.o cpucheck.o
@@ -115,47 +115,49 @@ $(obj)/compressed/vmlinux: FORCE
 	$(Q)$(MAKE) $(build)=$(obj)/compressed $@
 
 # Set this if you want to pass append arguments to the
-# bzdisk/fdimage/isoimage kernel
+# bzdisk/fdimage/hdimage/isoimage kernel
 FDARGS =
-# Set this if you want an initrd included with the
-# bzdisk/fdimage/isoimage kernel
+# Set this if you want one or more initrds included in the image
 FDINITRD =
 
-image_cmdline = default linux $(FDARGS) $(if $(FDINITRD),initrd=initrd.img,)
+imgdeps = $(obj)/bzImage $(obj)/mtools.conf $(src)/genimage.sh
 
 $(obj)/mtools.conf: $(src)/mtools.conf.in
 	sed -e 's|@OBJ@|$(obj)|g' < $< > $@
 
+targets += mtools.conf
+
+# genimage.sh requires bash, but it also has a bunch of other
+# external dependencies.
 quiet_cmd_genimage = GENIMAGE $3
-cmd_genimage = sh $(srctree)/$(src)/genimage.sh $2 $3 $(obj)/bzImage \
-			$(obj)/mtools.conf '$(image_cmdline)' $(FDINITRD)
+cmd_genimage = $(BASH) $(srctree)/$(src)/genimage.sh $2 $3 $(obj)/bzImage \
+		$(obj)/mtools.conf '$(FDARGS)' $(FDINITRD)
 
-PHONY += bzdisk fdimage fdimage144 fdimage288 isoimage bzlilo install
+PHONY += bzdisk fdimage fdimage144 fdimage288 hdimage isoimage install
 
 # This requires write access to /dev/fd0
-bzdisk: $(obj)/bzImage $(obj)/mtools.conf
+# All images require syslinux to be installed; hdimage also requires
+# EDK2/OVMF if the kernel is compiled with the EFI stub.
+bzdisk: $(imgdeps)
 	$(call cmd,genimage,bzdisk,/dev/fd0)
 
-# These require being root or having syslinux 2.02 or higher installed
-fdimage fdimage144: $(obj)/bzImage $(obj)/mtools.conf
+fdimage fdimage144: $(imgdeps)
 	$(call cmd,genimage,fdimage144,$(obj)/fdimage)
 	@$(kecho) 'Kernel: $(obj)/fdimage is ready'
 
-fdimage288: $(obj)/bzImage $(obj)/mtools.conf
+fdimage288: $(imgdeps)
 	$(call cmd,genimage,fdimage288,$(obj)/fdimage)
 	@$(kecho) 'Kernel: $(obj)/fdimage is ready'
 
-isoimage: $(obj)/bzImage
+hdimage: $(imgdeps)
+	$(call cmd,genimage,hdimage,$(obj)/hdimage)
+	@$(kecho) 'Kernel: $(obj)/hdimage is ready'
+
+isoimage: $(imgdeps)
 	$(call cmd,genimage,isoimage,$(obj)/image.iso)
 	@$(kecho) 'Kernel: $(obj)/image.iso is ready'
 
-bzlilo:
-	if [ -f $(INSTALL_PATH)/vmlinuz ]; then mv $(INSTALL_PATH)/vmlinuz $(INSTALL_PATH)/vmlinuz.old; fi
-	if [ -f $(INSTALL_PATH)/System.map ]; then mv $(INSTALL_PATH)/System.map $(INSTALL_PATH)/System.old; fi
-	cat $(obj)/bzImage > $(INSTALL_PATH)/vmlinuz
-	cp System.map $(INSTALL_PATH)/
-	if [ -x /sbin/lilo ]; then /sbin/lilo; else /etc/lilo/install; fi
-
 install:
-	sh $(srctree)/$(src)/install.sh $(KERNELRELEASE) $(obj)/bzImage \
+	$(CONFIG_SHELL) $(srctree)/$(src)/install.sh \
+		$(KERNELRELEASE) $(obj)/bzImage \
 		System.map "$(INSTALL_PATH)"
diff --git a/arch/x86/boot/genimage.sh b/arch/x86/boot/genimage.sh
index 6a10d52..0673fdf 100644
--- a/arch/x86/boot/genimage.sh
+++ b/arch/x86/boot/genimage.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/bin/bash
 #
 # This file is subject to the terms and conditions of the GNU General Public
 # License.  See the file "COPYING" in the main directory of this archive
@@ -8,15 +8,24 @@
 #
 # Adapted from code in arch/x86/boot/Makefile by H. Peter Anvin and others
 #
-# "make fdimage/fdimage144/fdimage288/isoimage" script for x86 architecture
+# "make fdimage/fdimage144/fdimage288/hdimage/isoimage"
+# script for x86 architecture
 #
 # Arguments:
-#   $1 - fdimage format
-#   $2 - target image file
-#   $3 - kernel bzImage file
-#   $4 - mtool configuration file
-#   $5 - kernel cmdline
-#   $6 - inird image file
+#   $1  - fdimage format
+#   $2  - target image file
+#   $3  - kernel bzImage file
+#   $4  - mtools configuration file
+#   $5  - kernel cmdline
+#   $6+ - initrd image file(s)
+#
+# This script requires:
+#   bash
+#   syslinux
+#   mtools (for fdimage* and hdimage)
+#   edk2/OVMF (for hdimage)
+#
+# Otherwise try to stick to POSIX shell commands...
 #
 
 # Use "make V=1" to debug this script
@@ -26,105 +35,237 @@ case "${KBUILD_VERBOSE}" in
         ;;
 esac
 
-verify () {
-	if [ ! -f "$1" ]; then
-		echo ""                                                   1>&2
-		echo " *** Missing file: $1"                              1>&2
-		echo ""                                                   1>&2
-		exit 1
+# Exit the top-level shell with an error
+topshell=$$
+trap 'exit 1' USR1
+die() {
+	echo ""        1>&2
+	echo " *** $*" 1>&2
+	echo ""        1>&2
+	kill -USR1 $topshell
+}
+
+# Verify the existence and readability of a file
+verify() {
+	if [ ! -f "$1" -o ! -r "$1" ]; then
+		die "Missing file: $1"
 	fi
 }
 
+diskfmt="$1"
+FIMAGE="$2"
+FBZIMAGE="$3"
+MTOOLSRC="$4"
+KCMDLINE="$5"
+shift 5				# Remaining arguments = initrd files
+
+export MTOOLSRC
 
-export MTOOLSRC=$4
-FIMAGE=$2
-FBZIMAGE=$3
-KCMDLINE=$5
-FDINITRD=$6
+# common options for dd
+dd='dd iflag=fullblock'
 
 # Make sure the files actually exist
 verify "$FBZIMAGE"
 
-genbzdisk() {
-	verify "$MTOOLSRC"
-	mformat a:
-	syslinux $FIMAGE
-	echo "$KCMDLINE" | mcopy - a:syslinux.cfg
-	if [ -f "$FDINITRD" ] ; then
-		mcopy "$FDINITRD" a:initrd.img
+declare -a FDINITRDS
+irdpfx=' initrd='
+initrdopts_syslinux=''
+initrdopts_efi=''
+for f in "$@"; do
+	if [ -f "$f" -a -r "$f" ]; then
+	    FDINITRDS=("${FDINITRDS[@]}" "$f")
+	    fname="$(basename "$f")"
+	    initrdopts_syslinux="${initrdopts_syslinux}${irdpfx}${fname}"
+	    irdpfx=,
+	    initrdopts_efi="${initrdopts_efi} initrd=${fname}"
 	fi
-	mcopy $FBZIMAGE a:linux
+done
+
+# Read a $3-byte littleendian unsigned value at offset $2 from file $1
+le() {
+	local n=0
+	local m=1
+	for b in $(od -A n -v -j $2 -N $3 -t u1 "$1"); do
+		n=$((n + b*m))
+		m=$((m * 256))
+	done
+	echo $n
 }
 
-genfdimage144() {
-	verify "$MTOOLSRC"
-	dd if=/dev/zero of=$FIMAGE bs=1024 count=1440 2> /dev/null
-	mformat v:
-	syslinux $FIMAGE
-	echo "$KCMDLINE" | mcopy - v:syslinux.cfg
-	if [ -f "$FDINITRD" ] ; then
-		mcopy "$FDINITRD" v:initrd.img
-	fi
-	mcopy $FBZIMAGE v:linux
+# Get the EFI architecture name such that boot{name}.efi is the default
+# boot file name. Returns false with no output if the file is not an
+# EFI image or otherwise unknown.
+efiarch() {
+	[ -f "$1" ] || return
+	[ $(le "$1" 0 2) -eq 23117 ] || return		# MZ magic
+	peoffs=$(le "$1" 60 4)				# PE header offset
+	[ $peoffs -ge 64 ] || return
+	[ $(le "$1" $peoffs 4) -eq 17744 ] || return	# PE magic
+	case $(le "$1" $((peoffs+4+20)) 2) in		# PE type
+		267)	;;				# PE32
+		523)	;;				# PE32+
+		*) return 1 ;;				# Invalid
+	esac
+	[ $(le "$1" $((peoffs+4+20+68)) 2) -eq 10 ] || return # EFI app
+	case $(le "$1" $((peoffs+4)) 2) in		# Machine type
+		 332)	echo i386	;;
+		 450)	echo arm	;;
+		 512)	echo ia64	;;
+		20530)	echo riscv32	;;
+		20580)	echo riscv64	;;
+		20776)	echo riscv128	;;
+		34404)	echo x64	;;
+		43620)	echo aa64	;;
+	esac
 }
 
-genfdimage288() {
-	verify "$MTOOLSRC"
-	dd if=/dev/zero of=$FIMAGE bs=1024 count=2880 2> /dev/null
-	mformat w:
-	syslinux $FIMAGE
-	echo "$KCMDLINE" | mcopy - W:syslinux.cfg
-	if [ -f "$FDINITRD" ] ; then
-		mcopy "$FDINITRD" w:initrd.img
-	fi
-	mcopy $FBZIMAGE w:linux
+# Get the combined sizes in bytes of the files given, counting sparse
+# files as full length, and padding each file to a 4K block size
+filesizes() {
+	local t=0
+	local s
+	for s in $(ls -lnL "$@" 2>/dev/null | awk '/^-/{ print $5; }'); do
+		t=$((t + ((s+4095)/4096)*4096))
+	done
+	echo $t
 }
 
-geniso() {
-	tmp_dir=`dirname $FIMAGE`/isoimage
-	rm -rf $tmp_dir
-	mkdir $tmp_dir
-	for i in lib lib64 share ; do
-		for j in syslinux ISOLINUX ; do
-			if [ -f /usr/$i/$j/isolinux.bin ] ; then
-				isolinux=/usr/$i/$j/isolinux.bin
-			fi
+# Expand directory names which should be in /usr/share into a list
+# of possible alternatives
+sharedirs() {
+	local dir file
+	for dir in /usr/share /usr/lib64 /usr/lib; do
+		for file; do
+			echo "$dir/$file"
+			echo "$dir/${file^^}"
 		done
-		for j in syslinux syslinux/modules/bios ; do
-			if [ -f /usr/$i/$j/ldlinux.c32 ]; then
-				ldlinux=/usr/$i/$j/ldlinux.c32
-			fi
+	done
+}
+efidirs() {
+	local dir file
+	for dir in /usr/share /boot /usr/lib64 /usr/lib; do
+		for file; do
+			echo "$dir/$file"
+			echo "$dir/${file^^}"
 		done
-		if [ -n "$isolinux" -a -n "$ldlinux" ] ; then
-			break
+	done
+}
+
+findsyslinux() {
+	local f="$(find -L $(sharedirs syslinux isolinux) \
+		    -name "$1" -readable -type f -print -quit 2>/dev/null)"
+	if [ ! -f "$f" ]; then
+		die "Need a $1 file, please install syslinux/isolinux."
+	fi
+	echo "$f"
+	return 0
+}
+
+findovmf() {
+	local arch="$1"
+	shift
+	local -a names=(-false)
+	local name f
+	for name; do
+		names=("${names[@]}" -or -iname "$name")
+	done
+	for f in $(find -L $(efidirs edk2 ovmf) \
+			\( "${names[@]}" \) -readable -type f \
+			-print 2>/dev/null); do
+		if [ "$(efiarch "$f")" = "$arch" ]; then
+			echo "$f"
+			return 0
 		fi
 	done
-	if [ -z "$isolinux" ] ; then
-		echo 'Need an isolinux.bin file, please install syslinux/isolinux.'
-		exit 1
+	die "Need a $1 file for $arch, please install EDK2/OVMF."
+}
+
+do_mcopy() {
+	if [ ${#FDINITRDS[@]} -gt 0 ]; then
+		mcopy "${FDINITRDS[@]}" "$1"
+	fi
+	if [ -n "$efishell" ]; then
+		mmd "$1"EFI "$1"EFI/Boot
+		mcopy "$efishell" "$1"EFI/Boot/boot${kefiarch}.efi
 	fi
-	if [ -z "$ldlinux" ] ; then
-		echo 'Need an ldlinux.c32 file, please install syslinux/isolinux.'
-		exit 1
+	if [ -n "$kefiarch" ]; then
+		echo linux "$KCMDLINE$initrdopts_efi" | \
+			mcopy - "$1"startup.nsh
 	fi
-	cp $isolinux $tmp_dir
-	cp $ldlinux $tmp_dir
-	cp $FBZIMAGE $tmp_dir/linux
-	echo "$KCMDLINE" > $tmp_dir/isolinux.cfg
-	if [ -f "$FDINITRD" ] ; then
-		cp "$FDINITRD" $tmp_dir/initrd.img
+	echo default linux "$KCMDLINE$initrdopts_syslinux" | \
+		mcopy - "$1"syslinux.cfg
+	mcopy "$FBZIMAGE" "$1"linux
+}
+
+genbzdisk() {
+	verify "$MTOOLSRC"
+	mformat -v 'LINUX_BOOT' a:
+	syslinux "$FIMAGE"
+	do_mcopy a:
+}
+
+genfdimage144() {
+	verify "$MTOOLSRC"
+	$dd if=/dev/zero of="$FIMAGE" bs=1024 count=1440 2>/dev/null
+	mformat -v 'LINUX_BOOT' v:
+	syslinux "$FIMAGE"
+	do_mcopy v:
+}
+
+genfdimage288() {
+	verify "$MTOOLSRC"
+	$dd if=/dev/zero of="$FIMAGE" bs=1024 count=2880 2>/dev/null
+	mformat -v 'LINUX_BOOT' w:
+	syslinux "$FIMAGE"
+	do_mcopy w:
+}
+
+genhdimage() {
+	verify "$MTOOLSRC"
+	mbr="$(findsyslinux mbr.bin)"
+	kefiarch="$(efiarch "$FBZIMAGE")"
+	if [ -n "$kefiarch" ]; then
+		# The efishell provides command line handling
+		efishell="$(findovmf $kefiarch shell.efi shell${kefiarch}.efi)"
+		ptype='-T 0xef'	# EFI system partition, no GPT
 	fi
-	genisoimage -J -r -input-charset=utf-8 -quiet -o $FIMAGE \
-		-b isolinux.bin -c boot.cat -no-emul-boot -boot-load-size 4 \
-		-boot-info-table $tmp_dir
-	isohybrid $FIMAGE 2>/dev/null || true
-	rm -rf $tmp_dir
+	sizes=$(filesizes "$FBZIMAGE" "${FDINITRDS[@]}" "$efishell")
+	# Allow 1% + 1 MiB for filesystem and partition table overhead,
+	# syslinux, and config files
+	megs=$(((sizes + sizes/100 + 2*1024*1024 - 1)/(1024*1024)))
+	$dd if=/dev/zero of="$FIMAGE" bs=$((1024*1024)) count=$megs 2>/dev/null
+	mpartition -I -c -s 32 -h 64 -t $megs $ptype -b 512 -a h:
+	$dd if="$mbr" of="$FIMAGE" bs=440 count=1 conv=notrunc 2>/dev/null
+	mformat -v 'LINUX_BOOT' -s 32 -h 64 -t $megs h:
+	syslinux --offset $((512*512)) "$FIMAGE"
+	do_mcopy h:
+}
+
+geniso() {
+	tmp_dir="$(dirname "$FIMAGE")/isoimage"
+	rm -rf "$tmp_dir"
+	mkdir "$tmp_dir"
+	isolinux=$(findsyslinux isolinux.bin)
+	ldlinux=$(findsyslinux  ldlinux.c32)
+	cp "$isolinux" "$ldlinux" "$tmp_dir"
+	cp "$FBZIMAGE" "$tmp_dir"/linux
+	echo default linux "$KCMDLINE" > "$tmp_dir"/isolinux.cfg
+	cp "${FDINITRDS[@]}" "$tmp_dir"/
+	genisoimage -J -r -appid 'LINUX_BOOT' -input-charset=utf-8 \
+		    -quiet -o "$FIMAGE" -b isolinux.bin \
+		    -c boot.cat -no-emul-boot -boot-load-size 4 \
+		    -boot-info-table "$tmp_dir"
+	isohybrid "$FIMAGE" 2>/dev/null || true
+	rm -rf "$tmp_dir"
 }
 
-case $1 in
+rm -f "$FIMAGE"
+
+case "$diskfmt" in
 	bzdisk)     genbzdisk;;
 	fdimage144) genfdimage144;;
 	fdimage288) genfdimage288;;
+	hdimage)    genhdimage;;
 	isoimage)   geniso;;
-	*)          echo 'Unknown image format'; exit 1;
+	*)          die "Unknown image format: $diskfmt";;
 esac
diff --git a/arch/x86/boot/mtools.conf.in b/arch/x86/boot/mtools.conf.in
index efd6d24..9e2662d 100644
--- a/arch/x86/boot/mtools.conf.in
+++ b/arch/x86/boot/mtools.conf.in
@@ -14,4 +14,7 @@ drive v:
 drive w:
   file="@OBJ@/fdimage" cylinders=80 heads=2 sectors=36 filter
 
+# Hard disk
+drive h:
+  file="@OBJ@/hdimage" partition=1 mformat_only
 
