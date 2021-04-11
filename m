Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 870A335B4BD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235773AbhDKNoG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33308 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235594AbhDKNn7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:59 -0400
Date:   Sun, 11 Apr 2021 13:43:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YHuwY988NHPGXD+RTXQ4F2MnfDRIrV/ONHb+NIOedM4=;
        b=CqnN2gO6xg5729e/0vdR8fyUmlASlm+6vbk4ddKQa9VMCMp+v+aAGj2OnXcZGb/fn4APWS
        BPxYqhkwdepCCCxRV8/w8DrZV3Cr448FJkrAkkxIu1Ul0dC9+vHtYji1PCRqg7To9q2vDm
        cztzEiDqHNFDNxLv9j2K+fYzRJrz42R8SfRxU86jaI/n9o//gDx/Zmzq993gvZYch0TNZ7
        VGrbEiFHFnCIF9AC42PS5yUyfKVL9S9tZ9nb4hCpqg5mOLv1//60/rlQ5JZJnBAMTLzNnc
        rNHtlihFDOL5AZSU0hHlC0rHgghXgbOGkmL8pSLNryed8WHQgLPUew6/G5QVLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148604;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YHuwY988NHPGXD+RTXQ4F2MnfDRIrV/ONHb+NIOedM4=;
        b=LwpmVm9IhPf0k5dwsiY2u1+dPBSG8WCaqNqrovnUB+760R1PZv8ADd1heAMvrdSq2KMB3f
        ciWXb9XpxeaATUBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Record jitter start/stop commands
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860382.29796.11847052121799272248.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     7831b391fbf86d19ae92e2984a9274b1d2b4eb06
Gitweb:        https://git.kernel.org/tip/7831b391fbf86d19ae92e2984a9274b1d2b4eb06
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 16 Feb 2021 15:32:23 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:16 -07:00

torture: Record jitter start/stop commands

Distributed runs of rcutorture will need to start and stop jittering on
the remote hosts, which means that the commands must be communicated to
those hosts.  The commit therefore causes kvm.sh to place these commands
in new TORTURE_JITTER_START and TORTURE_JITTER_STOP environment variables
to communicate them to the scripts that will set this up.  In addition,
this commit causes kvm-test-1-run.sh to append these commands to each
generated qemu-cmd file, which allows any remotely executing script to
extract the needed commands from this file.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh |  2 +-
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 24 ++++---
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index f3d2ded..a69f8ae 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -202,6 +202,8 @@ echo $QEMU $qemu_args -m $TORTURE_QEMU_MEM -kernel $KERNEL -append \"$qemu_appen
 echo "# TORTURE_SHUTDOWN_GRACE=$TORTURE_SHUTDOWN_GRACE" >> $resdir/qemu-cmd
 echo "# seconds=$seconds" >> $resdir/qemu-cmd
 echo "# TORTURE_KCONFIG_GDB_ARG=\"$TORTURE_KCONFIG_GDB_ARG\"" >> $resdir/qemu-cmd
+echo "# TORTURE_JITTER_START=\"$TORTURE_JITTER_START\"" >> $resdir/qemu-cmd
+echo "# TORTURE_JITTER_STOP=\"$TORTURE_JITTER_STOP\"" >> $resdir/qemu-cmd
 
 if test -n "$TORTURE_BUILDONLY"
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index d6973e4..efcbd12 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -35,6 +35,8 @@ TORTURE_KCONFIG_ARG=""
 TORTURE_KCONFIG_GDB_ARG=""
 TORTURE_BOOT_GDB_ARG=""
 TORTURE_QEMU_GDB_ARG=""
+TORTURE_JITTER_START=""
+TORTURE_JITTER_STOP=""
 TORTURE_KCONFIG_KASAN_ARG=""
 TORTURE_KCONFIG_KCSAN_ARG=""
 TORTURE_KMAKE_ARG=""
@@ -443,6 +445,16 @@ function dump(first, pastlast, batchnum)
 	print "echo ----Start batch " batchnum ": `date` | tee -a " rd "log";
 	print "needqemurun="
 	jn=1
+	njitter = 0;
+	split(jitter, ja);
+	if (ja[1] == -1 && ncpus == 0)
+		njitter = 1;
+	else if (ja[1] == -1)
+		njitter = ncpus;
+	else
+		njitter = ja[1];
+	print "TORTURE_JITTER_START=\". jitterstart.sh " njitter " " rd " " dur " " ja[2] " " ja[3] "\"; export TORTURE_JITTER_START";
+	print "TORTURE_JITTER_STOP=\". jitterstop.sh " rd " \"; export TORTURE_JITTER_STOP"
 	for (j = first; j < pastlast; j++) {
 		cpusr[jn] = cpus[j];
 		if (cfrep[cf[j]] == "") {
@@ -484,14 +496,6 @@ function dump(first, pastlast, batchnum)
 		print "\tneedqemurun=1"
 		print "fi"
 	}
-	njitter = 0;
-	split(jitter, ja);
-	if (ja[1] == -1 && ncpus == 0)
-		njitter = 1;
-	else if (ja[1] == -1)
-		njitter = ncpus;
-	else
-		njitter = ja[1];
 	if (TORTURE_BUILDONLY && njitter != 0) {
 		njitter = 0;
 		print "echo Build-only run, so suppressing jitter | tee -a " rd "log"
@@ -502,12 +506,12 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	print "\t. jitterstart.sh " njitter " " rd " " dur " " ja[2] " " ja[3]
+	print "\t$TORTURE_JITTER_START";
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
 	print "\tdone"
-	print "\t. jitterstop.sh " rd
+	print "\t$TORTURE_JITTER_STOP";
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
 	print "\twait"
