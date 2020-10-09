Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21AF328822D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731945AbgJIGf1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55376 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729655AbgJIGfO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:14 -0400
Date:   Fri, 09 Oct 2020 06:35:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=okXhnXBJRb1wg2AzU20fYnbQMnp04RNiqeARFIRh4+s=;
        b=Z0JyqoKXtSNa543Wg/j9dUBLO9I1FFzfSXDhFHeBEghUEVKo7f1wVZjmYBqGWkSu2QpX1t
        V5PkI1nICr5XXGXE+NIBz6kysmlfHH5B3Gl97q8I5dgWQ/u6RMv5tduSJqBgHvAq6NH+wr
        K6shP7Pla09uVLHz6sC+RbwBDwX9sAY8CmRKBeEnc3r/Rl5UrztXbLyMM/nxOegSFvwag0
        GaWUTCazmnRl5q2YrCGtfOK7ihj2GGE4SBX7xM7taHIh/gtLr9AjYTcH6YfMFvqqLCcHrS
        VaN4YYh7f669ksCXvcF/Zjq7eVFdorU4b4FdYTnXopL5nRZ7H/3NlTRmOtiiBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=okXhnXBJRb1wg2AzU20fYnbQMnp04RNiqeARFIRh4+s=;
        b=iS5EWXj2UPeVx+HRQ36jLoU/RvEg85UMWlUNgXcfuN5SNB0FzYgs7sHnngBsQVDDbHJppZ
        22OfUgoRaimNREAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add gdb support
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531044.7002.13060160611194042443.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     b67a91703a29b93f5b114052b0b8e0d84e717ad3
Gitweb:        https://git.kernel.org/tip/b67a91703a29b93f5b114052b0b8e0d84e717ad3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 17 Aug 2020 16:44:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:54 -07:00

torture: Add gdb support

This commit adds a "--gdb" parameter to kvm.sh, which causes
"CONFIG_DEBUG_INFO=y" to be added to the Kconfig options, "nokaslr"
to be added to the boot parameters, and "-s -S" to be added to the qemu
arguments.  Furthermore, the scripting prints messages telling the user
how to start up gdb for the run in question.

Because of the interactive nature of gdb sessions, only one "--configs"
scenario is permitted when "--gdb" is specified.  For most torture types,
this means that a "--configs" argument is required, and that argument
must specify the single scenario of interest.

The usual cautions about breakpoints and timing apply, for example,
staring at your gdb prompt for too long will likely get you many
complaints, including RCU CPU stall warnings.  Omar Sandoval further
suggests using gdb's "hbreak" command instead of the "break" command on
systems supporting hardware breakpoints, and further using the "commands"
option because the resulting non-interactive breakpoints are less likely
to get you RCU CPU stall warnings.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 33 +++++--
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 21 ++++-
 2 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index e07779a..6dc2b49 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -66,6 +66,7 @@ config_override_param () {
 echo > $T/KcList
 config_override_param "$config_dir/CFcommon" KcList "`cat $config_dir/CFcommon 2> /dev/null`"
 config_override_param "$config_template" KcList "`cat $config_template 2> /dev/null`"
+config_override_param "--gdb options" KcList "$TORTURE_KCONFIG_GDB_ARG"
 config_override_param "--kasan options" KcList "$TORTURE_KCONFIG_KASAN_ARG"
 config_override_param "--kcsan options" KcList "$TORTURE_KCONFIG_KCSAN_ARG"
 config_override_param "--kconfig argument" KcList "$TORTURE_KCONFIG_ARG"
@@ -152,7 +153,11 @@ qemu_append="`identify_qemu_append "$QEMU"`"
 boot_args="`configfrag_boot_params "$boot_args" "$config_template"`"
 # Generate kernel-version-specific boot parameters
 boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
-echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" > $resdir/qemu-cmd
+if test -n "$TORTURE_BOOT_GDB_ARG"
+then
+	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
+fi
+echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
@@ -171,14 +176,26 @@ echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
 # Attempt to run qemu
 ( . $T/qemu-cmd; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
-sleep 10 # Give qemu's pid a chance to reach the file
-if test -s "$resdir/qemu_pid"
+if test -z "$TORTURE_KCONFIG_GDB_ARG"
 then
-	qemu_pid=`cat "$resdir/qemu_pid"`
-	echo Monitoring qemu job at pid $qemu_pid
-else
-	qemu_pid=""
-	echo Monitoring qemu job at yet-as-unknown pid
+	sleep 10 # Give qemu's pid a chance to reach the file
+	if test -s "$resdir/qemu_pid"
+	then
+		qemu_pid=`cat "$resdir/qemu_pid"`
+		echo Monitoring qemu job at pid $qemu_pid
+	else
+		qemu_pid=""
+		echo Monitoring qemu job at yet-as-unknown pid
+	fi
+fi
+if test -n "$TORTURE_KCONFIG_GDB_ARG"
+then
+	echo Waiting for you to attach a debug session, for example: > /dev/tty
+	echo "    gdb $base_resdir/vmlinux" > /dev/tty
+	echo 'After symbols load and the "(gdb)" prompt appears:' > /dev/tty
+	echo "    target remote :1234" > /dev/tty
+	echo "    continue" > /dev/tty
+	kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 fi
 while :
 do
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index fc15b52..c30047e 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -31,6 +31,9 @@ TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
+TORTURE_KCONFIG_GDB_ARG=""
+TORTURE_BOOT_GDB_ARG=""
+TORTURE_QEMU_GDB_ARG=""
 TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
@@ -56,6 +59,7 @@ usage () {
 	echo "       --defconfig string"
 	echo "       --dryrun sched|script"
 	echo "       --duration minutes"
+	echo "       --gdb"
 	echo "       --help"
 	echo "       --interactive"
 	echo "       --jitter N [ maxsleep (us) [ maxspin (us) ] ]"
@@ -128,6 +132,11 @@ do
 		dur=$(($2*60))
 		shift
 		;;
+	--gdb)
+		TORTURE_KCONFIG_GDB_ARG="CONFIG_DEBUG_INFO=y"; export TORTURE_KCONFIG_GDB_ARG
+		TORTURE_BOOT_GDB_ARG="nokaslr"; export TORTURE_BOOT_GDB_ARG
+		TORTURE_QEMU_GDB_ARG="-s -S"; export TORTURE_QEMU_GDB_ARG
+		;;
 	--help|-h)
 		usage
 		;;
@@ -253,6 +262,15 @@ do
 done
 touch $T/cfgcpu
 configs_derep="`echo $configs_derep | sed -e "s/\<CFLIST\>/$defaultconfigs/g"`"
+if test -n "$TORTURE_KCONFIG_GDB_ARG"
+then
+	if test "`echo $configs_derep | wc -w`" -gt 1
+	then
+		echo "The --config list is: $configs_derep."
+		echo "Only one --config permitted with --gdb, terminating."
+		exit 1
+	fi
+fi
 for CF1 in $configs_derep
 do
 	if test -f "$CONFIGFRAG/$CF1"
@@ -328,6 +346,9 @@ TORTURE_BUILDONLY="$TORTURE_BUILDONLY"; export TORTURE_BUILDONLY
 TORTURE_DEFCONFIG="$TORTURE_DEFCONFIG"; export TORTURE_DEFCONFIG
 TORTURE_INITRD="$TORTURE_INITRD"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG="$TORTURE_KCONFIG_ARG"; export TORTURE_KCONFIG_ARG
+TORTURE_KCONFIG_GDB_ARG="$TORTURE_KCONFIG_GDB_ARG"; export TORTURE_KCONFIG_GDB_ARG
+TORTURE_BOOT_GDB_ARG="$TORTURE_BOOT_GDB_ARG"; export TORTURE_BOOT_GDB_ARG
+TORTURE_QEMU_GDB_ARG="$TORTURE_QEMU_GDB_ARG"; export TORTURE_QEMU_GDB_ARG
 TORTURE_KCONFIG_KASAN_ARG="$TORTURE_KCONFIG_KASAN_ARG"; export TORTURE_KCONFIG_KASAN_ARG
 TORTURE_KCONFIG_KCSAN_ARG="$TORTURE_KCONFIG_KCSAN_ARG"; export TORTURE_KCONFIG_KCSAN_ARG
 TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
