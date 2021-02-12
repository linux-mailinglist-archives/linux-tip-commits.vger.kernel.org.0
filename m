Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF319319F01
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbhBLMpS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45894 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231907AbhBLMnQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:16 -0500
Date:   Fri, 12 Feb 2021 12:37:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QsQuMuTVYzLZPwIlJOUyMeJETLD68NwEBcImHP9EuVE=;
        b=LLrV6libDXkcUqFLfctVVE8wsDGwtkDhX4Tnhxt0ZU06v6tAbJmI/dzrvWQOQHaZkcgERI
        z9vO5f9USvX9gNGl5As6riEdFc+ctkKvhcmfis92riTNFKCaPwFHpDaPk7YCPdgg7nnLhW
        pWZ9nIkunYwXm3Zt94qJPVnvM/ul70ivRTnpz9IzKaONuPM2we6IJJHtuzgfBa6UzW4yoX
        WOhJbpgz+9num71YeyNs0liPGJQtWo0QbreVvV5b2MkmEnmcKNgvv+rlXZ7nT2LJ1+BL6V
        Tzuc7pM7HPC2pL/zPPGyeFXqvYlU07eXikTeVMD95yjh+iWSqZ3+++c3Un3Wvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133448;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=QsQuMuTVYzLZPwIlJOUyMeJETLD68NwEBcImHP9EuVE=;
        b=Q4EcnUazbGuwuWbf4w98FFW42XZR8Ev+kmrhS+R3FfIg21sEudKoeSU3yTjsuIPeBxwqoY
        x1C3DzbI7+suGsBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Prepare for splitting qemu execution from
 kvm-test-1-run.sh
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344820.23325.15981808874188955972.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     315957cad445aa80e567983a43d9bb2a24a8534d
Gitweb:        https://git.kernel.org/tip/315957cad445aa80e567983a43d9bb2a24a8534d
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 16:28:18 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:19 -08:00

torture: Prepare for splitting qemu execution from kvm-test-1-run.sh

Distributed execution of rcutorture is eased if the qemu execution can
be split from the building of the kernel, as this allows target systems
to be used that are not set up to build kernels.  It also avoids issues
with toolchain version skew across the cluster, aside of course from
qemu and KVM version skew.

This commit therefore records needed data as comments in the qemu-cmd file
and moves recording of the starting time to just before qemu is launched.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 3cd03d0..4bc0e62 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -125,7 +125,6 @@ seconds=$4
 qemu_args=$5
 boot_args=$6
 
-kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 if test -z "$TORTURE_BUILDONLY"
 then
 	echo ' ---' `date`: Starting kernel
@@ -158,6 +157,8 @@ then
 	boot_args="$boot_args $TORTURE_BOOT_GDB_ARG"
 fi
 echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_append $boot_args\" $TORTURE_QEMU_GDB_ARG > $resdir/qemu-cmd
+echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
+echo "# seconds=$seconds" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
@@ -174,6 +175,7 @@ echo 'echo $! > $resdir/qemu_pid' >> $T/qemu-cmd
 echo "NOTE: $QEMU either did not run or was interactive" > $resdir/console.log
 
 # Attempt to run qemu
+kstarttime=`gawk 'BEGIN { print systime() }' < /dev/null`
 ( . $T/qemu-cmd; wait `cat  $resdir/qemu_pid`; echo $? > $resdir/qemu-retval ) &
 commandcompleted=0
 if test -z "$TORTURE_KCONFIG_GDB_ARG"
