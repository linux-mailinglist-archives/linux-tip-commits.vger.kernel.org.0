Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16DF635B4DD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235863AbhDKNoS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbhDKNoF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:05 -0400
Date:   Sun, 11 Apr 2021 13:43:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8E1e7NZHBJpXQrloVJp0d4xAsNp1LKYwASp8Koq8+wM=;
        b=1IQRi8SKbCg4e4fkyZVdXW1zWO/m98iQzYlUR5Nt+/kimmRFaFNlgXKUZr9Spkgh0DpvVl
        BHUl5brNv3+oytMKpxwQFb9Tnz3ptG7mzQc5EbEHf0NWhww1fOsu70ARUWS/hmcrMH5vpC
        9yC+lRaWHZp2nsD3qJY5l8TZuIxYUXCRX/NhUk0nrQ98x3sqeof75W0IH6X9AZdUgq87IB
        F3h88UtBChBgBoZq/M2o+1y8y5lsg3iioKsmpA4jqe+QLUBqm7Z7avIxWjIhn6zM69aIjT
        dEgfMt67FYr7NqhQQwjI83ZOwE2rlVaULPJ1+kmXfIhiTsfe5z6g/r92vPoIpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148611;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8E1e7NZHBJpXQrloVJp0d4xAsNp1LKYwASp8Koq8+wM=;
        b=JMFFqYuzQHQpAGQuDG760nXUgbtYKKBs68y0qi4BTWEOotbRxbpsDemistrgFP4r8/sSfK
        tj7zuMrSGEgUjKCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Move build/run synchronization files into
 scenario directories
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861033.29796.80719225134099027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3c43ce53fdb39921f4ee71c65dc100296e15640f
Gitweb:        https://git.kernel.org/tip/3c43ce53fdb39921f4ee71c65dc100296e15640f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 10 Feb 2021 15:15:13 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torture: Move build/run synchronization files into scenario directories

Currently the bN.ready and bN.wait files are placed in the
rcutorture directory, which really is not at all a good place
for run-specific files.  This commit therefore renames these
files to build.ready and build.wait and then moves them into the
scenario directories within the "res" directory, for example, into
tools/testing/selftests/rcutorture/res/2021.02.10-15.08.23/TINY01.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 25 +++----
 tools/testing/selftests/rcutorture/bin/kvm.sh            | 10 +--
 2 files changed, 16 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index 03c0410..91578d3 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -7,7 +7,7 @@
 # Execute this in the source tree.  Do not run it as a background task
 # because qemu does not seem to like that much.
 #
-# Usage: kvm-test-1-run.sh config builddir resdir seconds qemu-args boot_args_in
+# Usage: kvm-test-1-run.sh config resdir seconds qemu-args boot_args_in
 #
 # qemu-args defaults to "-enable-kvm -nographic", along with arguments
 #			specifying the number of CPUs and other options
@@ -35,8 +35,7 @@ mkdir $T
 config_template=${1}
 config_dir=`echo $config_template | sed -e 's,/[^/]*$,,'`
 title=`echo $config_template | sed -e 's/^.*\///'`
-builddir=${2}
-resdir=${3}
+resdir=${2}
 if test -z "$resdir" -o ! -d "$resdir" -o ! -w "$resdir"
 then
 	echo "kvm-test-1-run.sh :$resdir: Not a writable directory, cannot store results into it"
@@ -89,9 +88,9 @@ then
 	ln -s $base_resdir/Make*.out $resdir  # for kvm-recheck.sh
 	ln -s $base_resdir/.config $resdir  # for kvm-recheck.sh
 	echo Initial build failed, not running KVM, see $resdir.
-	if test -f $builddir.wait
+	if test -f $resdir/build.wait
 	then
-		mv $builddir.wait $builddir.ready
+		mv $resdir/build.wait $resdir/build.ready
 	fi
 	exit 1
 elif kvm-build.sh $T/KcList $resdir
@@ -118,23 +117,23 @@ else
 	# Build failed.
 	cp .config $resdir || :
 	echo Build failed, not running KVM, see $resdir.
-	if test -f $builddir.wait
+	if test -f $resdir/build.wait
 	then
-		mv $builddir.wait $builddir.ready
+		mv $resdir/build.wait $resdir/build.ready
 	fi
 	exit 1
 fi
-if test -f $builddir.wait
+if test -f $resdir/build.wait
 then
-	mv $builddir.wait $builddir.ready
+	mv $resdir/build.wait $resdir/build.ready
 fi
-while test -f $builddir.ready
+while test -f $resdir/build.ready
 do
 	sleep 1
 done
-seconds=$4
-qemu_args=$5
-boot_args_in=$6
+seconds=$3
+qemu_args=$4
+boot_args_in=$5
 
 if test -z "$TORTURE_BUILDONLY"
 then
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 1de198d..7944510 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -444,7 +444,6 @@ function dump(first, pastlast, batchnum)
 	print "needqemurun="
 	jn=1
 	for (j = first; j < pastlast; j++) {
-		builddir=KVM "/b" j - first + 1
 		cpusr[jn] = cpus[j];
 		if (cfrep[cf[j]] == "") {
 			cfr[jn] = cf[j];
@@ -453,15 +452,15 @@ function dump(first, pastlast, batchnum)
 			cfrep[cf[j]]++;
 			cfr[jn] = cf[j] "." cfrep[cf[j]];
 		}
+		builddir=rd cfr[jn] "/build";
 		if (cpusr[jn] > ncpus && ncpus != 0)
 			ovf = "-ovf";
 		else
 			ovf = "";
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Starting build. `date` | tee -a " rd "log";
-		print "rm -f " builddir ".*";
-		print "touch " builddir ".wait";
 		print "mkdir " rd cfr[jn] " || :";
-		print "kvm-test-1-run.sh " CONFIGDIR cf[j], builddir, rd cfr[jn], dur " \"" TORTURE_QEMU_ARG "\" \"" TORTURE_BOOTARGS "\" > " rd cfr[jn]  "/kvm-test-1-run.sh.out 2>&1 &"
+		print "touch " builddir ".wait";
+		print "kvm-test-1-run.sh " CONFIGDIR cf[j], rd cfr[jn], dur " \"" TORTURE_QEMU_ARG "\" \"" TORTURE_BOOTARGS "\" > " rd cfr[jn]  "/kvm-test-1-run.sh.out 2>&1 &"
 		print "echo ", cfr[jn], cpusr[jn] ovf ": Waiting for build to complete. `date` | tee -a " rd "log";
 		print "while test -f " builddir ".wait"
 		print "do"
@@ -471,7 +470,7 @@ function dump(first, pastlast, batchnum)
 		jn++;
 	}
 	for (j = 1; j < jn; j++) {
-		builddir=KVM "/b" j
+		builddir=rd cfr[j] "/build";
 		print "rm -f " builddir ".ready"
 		print "if test -f \"" rd cfr[j] "/builtkernel\""
 		print "then"
@@ -509,7 +508,6 @@ function dump(first, pastlast, batchnum)
 	print "\techo ---- No kernel runs. `date` | tee -a " rd "log";
 	print "fi"
 	for (j = 1; j < jn; j++) {
-		builddir=KVM "/b" j
 		print "echo ----", cfr[j], cpusr[j] ovf ": Build/run results: | tee -a " rd "log";
 		print "cat " rd cfr[j]  "/kvm-test-1-run.sh.out | tee -a " rd "log";
 	}
