Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDABB35B4E3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhDKNoV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235757AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Date:   Sun, 11 Apr 2021 13:43:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XbRsNanBtjCbQJAmTYXQf0OzdxvjDk6Q9TiWqWQcRuY=;
        b=CIKl8lCvv1vnwZ6MNl+ShJnRKsC9mnSaaeAvFOYTWkHNGEOdY53PfWfmq3+m6U/phns5ZM
        VRdEl95adX97qD1XWFStX4rYaclVbdpNOhj+ueZ4cRVY3paUJmJbYeh0nqcLMAES64N0Y3
        qZYdzRRg4FZI4jhUdQ7AOpX8q4kTeGv8VwNuaPupAfbr2m67lOMC9HyiksH16ie+Rj3HPJ
        Mx67rNJ7SJ36aTeV2XFogvsn5TVxeeH4hZRgI2OwsTpgZfTuQxOw+O+GEVOFZxmubUyT9Z
        GyX5fxQr1njcNKQEJsPpVx5e8tfGxjD1EmUdcr92MSyt9LkU00qCAUf9+Yur2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148612;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=XbRsNanBtjCbQJAmTYXQf0OzdxvjDk6Q9TiWqWQcRuY=;
        b=k8UEptsdzar95PPdvJ+zpOYTUOhXJuawfgu9PmxjyIutwVGDLzyalpSSu3GwmR9/C1T0qt
        vCrFnZ5HFaODnCAg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Provide bare-metal modprobe-based advice
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861184.29796.8377741824290054165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a8dafbf3a5465bea6d9b45a4f011ba9b56d8b267
Gitweb:        https://git.kernel.org/tip/a8dafbf3a5465bea6d9b45a4f011ba9b56d8b267
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 03 Feb 2021 15:44:29 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torture: Provide bare-metal modprobe-based advice

In some environments, the torture-testing use of virtualization is
inconvenient.  In such cases, the modprobe and rmmod commands may be used
to do torture testing, but significant setup is required to build, boot,
and modprobe a kernel so as to match a given torture-test scenario.
This commit therefore creates a "bare-metal" file in each results
directory containing steps to run the corresponding scenario using the
modprobe command on bare metal.  For example, the contents of this file
after using kvm.sh to build an rcutorture TREE01 kernel, perhaps with
the --buildonly argument, is as follows:

To run this scenario on bare metal:

 1. Set your bare-metal build tree to the state shown in this file:
    /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2021.02.04-17.10.19/testid.txt
 2. Update your bare-metal build tree's .config based on this file:
    /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2021.02.04-17.10.19/TREE01/ConfigFragment
 3. Make the bare-metal kernel's build system aware of your .config updates:
    $ yes "" | make oldconfig
 4. Build your bare-metal kernel.
 5. Boot your bare-metal kernel with the following parameters:
    maxcpus=8 nr_cpus=43 rcutree.gp_preinit_delay=3 rcutree.gp_init_delay=3 rcutree.gp_cleanup_delay=3 rcu_nocbs=0-1,3-7
 6. Start the test with the following command:
    $ modprobe rcutorture nocbs_nthreads=8 nocbs_toggle=1000 fwd_progress=0 onoff_interval=1000 onoff_holdoff=30 n_barrier_cbs=4 stat_interval=15 shutdown_secs=120 test_no_idle_hz=1 verbose=1
 7. After some time, end the test with the following command:
    $ rmmod rcutorture
 8. Copy your bare-metal kernel's .config file, overwriting this file:
    /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2021.02.04-17.10.19/TREE01/.config
 9. Copy the console output from just before the modprobe to just after
    the rmmod into this file:
    /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2021.02.04-17.10.19/TREE01/console.log
10. Check for runtime errors using the following command:
   $ tools/testing/selftests/rcutorture/bin/kvm-recheck.sh /home/git/linux-rcu/tools/testing/selftests/rcutorture/res/2021.02.04-17.10.19

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 44 ++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  4 +-
 2 files changed, 42 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 9d8a82c..03c0410 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -7,15 +7,15 @@
 # Execute this in the source tree.  Do not run it as a background task
 # because qemu does not seem to like that much.
 #
-# Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args
+# Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args_in
 #
 # qemu-args defaults to "-enable-kvm -nographic", along with arguments
 #			specifying the number of CPUs and other options
 #			generated from the underlying CPU architecture.
-# boot_args defaults to value returned by the per_version_boot_params
+# boot_args_in defaults to value returned by the per_version_boot_params
 #			shell function.
 #
-# Anything you specify for either qemu-args or boot_args is appended to
+# Anything you specify for either qemu-args or boot_args_in is appended to
 # the default values.  The "-smp" value is deduced from the contents of
 # the config fragment.
 #
@@ -134,7 +134,7 @@ do
 done
 seconds=$4
 qemu_args=$5
-boot_args=$6
+boot_args_in=$6
 
 if test -z "$TORTURE_BUILDONLY"
 then
@@ -144,7 +144,7 @@ fi
 # Generate -smp qemu argument.
 qemu_args="-enable-kvm -nographic $qemu_args"
 cpu_count=`configNR_CPUS.sh $resdir/ConfigFragment`
-cpu_count=`configfrag_boot_cpus "$boot_args" "$config_template" "$cpu_count"`
+cpu_count=`configfrag_boot_cpus "$boot_args_in" "$config_template" "$cpu_count"`
 if test "$cpu_count" -gt "$TORTURE_ALLOTED_CPUS"
 then
 	echo CPU count limited from $cpu_count to $TORTURE_ALLOTED_CPUS | tee -a $resdir/Warnings
@@ -160,13 +160,45 @@ qemu_args="$qemu_args `identify_qemu_args "$QEMU" "$resdir/console.log"`"
 qemu_append="`identify_qemu_append "$QEMU"`"
 
 # Pull in Kconfig-fragment boot parameters
-boot_args="`configfrag_boot_params "$boot_args" "$config_template"`"
+boot_args="`configfrag_boot_params "$boot_args_in" "$config_template"`"
 # Generate kernel-version-specific boot parameters
 boot_args="`per_version_boot_params "$boot_args" $resdir/.config $seconds`"
 if test -n "$TORTURE_BOOT_GDB_ARG"
 then
 	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
 fi
+
+# Give bare-metal advice
+modprobe_args="`echo $boot_args | tr -s ' ' '\012' | grep "^$TORTURE_MOD\." | sed -e "s/$TORTURE_MOD\.//g"`"
+kboot_args="`echo $boot_args | tr -s ' ' '\012' | grep -v "^$TORTURE_MOD\."`"
+testid_txt="`dirname $resdir`/testid.txt"
+touch $resdir/bare-metal
+echo To run this scenario on bare metal: >> $resdir/bare-metal
+echo >> $resdir/bare-metal
+echo " 1." Set your bare-metal build tree to the state shown in this file: >> $resdir/bare-metal
+echo "   " $testid_txt >> $resdir/bare-metal
+echo " 2." Update your bare-metal build tree"'"s .config based on this file: >> $resdir/bare-metal
+echo "   " $resdir/ConfigFragment >> $resdir/bare-metal
+echo " 3." Make the bare-metal kernel"'"s build system aware of your .config updates: >> $resdir/bare-metal
+echo "   " $ 'yes "" | make oldconfig' >> $resdir/bare-metal
+echo " 4." Build your bare-metal kernel. >> $resdir/bare-metal
+echo " 5." Boot your bare-metal kernel with the following parameters: >> $resdir/bare-metal
+echo "   " $kboot_args >> $resdir/bare-metal
+echo " 6." Start the test with the following command: >> $resdir/bare-metal
+echo "   " $ modprobe $TORTURE_MOD $modprobe_args >> $resdir/bare-metal
+echo " 7." After some time, end the test with the following command: >> $resdir/bare-metal
+echo "   " $ rmmod $TORTURE_MOD >> $resdir/bare-metal
+echo " 8." Copy your bare-metal kernel"'"s .config file, overwriting this file: >> $resdir/bare-metal
+echo "   " $resdir/.config >> $resdir/bare-metal
+echo " 9." Copy the console output from just before the modprobe to just after >> $resdir/bare-metal
+echo "   " the rmmod into this file: >> $resdir/bare-metal
+echo "   " $resdir/console.log >> $resdir/bare-metal
+echo "10." Check for runtime errors using the following command: >> $resdir/bare-metal
+echo "   " $ tools/testing/selftests/rcutorture/bin/kvm-recheck.sh `dirname $resdir` >> $resdir/bare-metal
+echo >> $resdir/bare-metal
+echo Some of the above steps may be skipped if you build your bare-metal >> $resdir/bare-metal
+echo kernel here: `head -n 1 $testid_txt | sed -e 's/^Build directory: //'`  >> $resdir/bare-metal
+
 echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
 echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
 echo "# seconds=$seconds" >> $resdir/qemu-cmd
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 8d3c99b..35a2132 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -29,6 +29,7 @@ PATH=${KVM}/bin:$PATH; export PATH
 TORTURE_ALLOTED_CPUS="`identify_qemu_vcpus`"
 TORTURE_DEFCONFIG=defconfig
 TORTURE_BOOT_IMAGE=""
+TORTURE_BUILDONLY=
 TORTURE_INITRD="$KVM/initrd"; export TORTURE_INITRD
 TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
@@ -40,6 +41,7 @@ TORTURE_KMAKE_ARG=""
 TORTURE_QEMU_MEM=512
 TORTURE_SHUTDOWN_GRACE=180
 TORTURE_SUITE=rcu
+TORTURE_MOD=rcutorture
 TORTURE_TRUST_MAKE=""
 resdir=""
 configs=""
@@ -215,6 +217,7 @@ do
 	--torture)
 		checkarg --torture "(suite name)" "$#" "$2" '^\(lock\|rcu\|rcuscale\|refscale\|scf\)$' '^--'
 		TORTURE_SUITE=$2
+		TORTURE_MOD="`echo $TORTURE_SUITE | sed -e 's/^\(lock\|rcu\|scf\)$/\1torture/'`"
 		shift
 		if test "$TORTURE_SUITE" = rcuscale || test "$TORTURE_SUITE" = refscale
 		then
@@ -381,6 +384,7 @@ TORTURE_QEMU_GDB_ARG="$TORTURE_QEMU_GDB_ARG"; export TORTURE_QEMU_GDB_ARG
 TORTURE_KCONFIG_KASAN_ARG="$TORTURE_KCONFIG_KASAN_ARG"; export TORTURE_KCONFIG_KASAN_ARG
 TORTURE_KCONFIG_KCSAN_ARG="$TORTURE_KCONFIG_KCSAN_ARG"; export TORTURE_KCONFIG_KCSAN_ARG
 TORTURE_KMAKE_ARG="$TORTURE_KMAKE_ARG"; export TORTURE_KMAKE_ARG
+TORTURE_MOD="$TORTURE_MOD"; export TORTURE_MOD
 TORTURE_QEMU_CMD="$TORTURE_QEMU_CMD"; export TORTURE_QEMU_CMD
 TORTURE_QEMU_INTERACTIVE="$TORTURE_QEMU_INTERACTIVE"; export TORTURE_QEMU_INTERACTIVE
 TORTURE_QEMU_MAC="$TORTURE_QEMU_MAC"; export TORTURE_QEMU_MAC
