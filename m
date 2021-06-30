Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0BF53B8408
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235690AbhF3NwF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbhF3Nuq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 460B2C0617A6;
        Wed, 30 Jun 2021 06:47:50 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wfJT7g11Hmr+pD+ygw0q5lZchqeca81wWgseu7+ab+A=;
        b=vTkV/KP9SpOM//dLrsOGzv5eOlxJDBMEEenXNCX7gHMEgXcESvXQct6/DfYGbJwbLuSW/W
        /zkr2SqYKp1ZYvKSqU4KdeTdKapPf1NsxOQFz1e9BXerA03dvRDk/FYgYAFLCTJObkgTFV
        i8NRPzy5nngBQwUQH8IwBlpcViw+H0lidZiaK9fQx329JGpIY+DS4NHa9ErtLSZKoFPCCw
        aSFnXMsXppIoJV5oUVYQa9mINw2chTFqN0nW2fvF+lGJpSc8pvzf+BGiHUK4+WZrKSwY0J
        KYJROji6wRV0EBAshF7ySAI+m8V8U+FTF6pMFGdBNbcZwGs3VfOq65/vbtH80g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060868;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wfJT7g11Hmr+pD+ygw0q5lZchqeca81wWgseu7+ab+A=;
        b=ago5Io1VgagOhY6bqbzXNGttfFoCoWytW6YevsTA2QjyPo6yt7ZkoPanM9tMGW2I+qZ5s4
        W8WgNd3eFLptcmCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Add kvm-remote.sh script for distributed
 rcutorture test runs
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506086817.395.15176985063908256662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0092eae4cb4e4a34b728efcf9d5857ab0ac2e6f6
Gitweb:        https://git.kernel.org/tip/0092eae4cb4e4a34b728efcf9d5857ab0ac2e6f6
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 05 Mar 2021 13:59:54 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:05 -07:00

torture: Add kvm-remote.sh script for distributed rcutorture test runs

This commit adds a kvm-remote.sh script that prepares a tarball that
is then downloaded to the remote system(s) and executed.  The user is
responsible for having set up the remote systems to run qemu, but all the
kernel builds are done on the system running the kvm-remote.sh script.
The user is also responsible for setting up the remote systems so that
ssh can be run non-interactively, given that ssh is used to poll the
remote systems in order to detect completion of each batch.

See the script's header comment for usage information.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 227 ++++++++++-
 1 file changed, 227 insertions(+)
 create mode 100755 tools/testing/selftests/rcutorture/bin/kvm-remote.sh

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
new file mode 100755
index 0000000..c4859fc
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -0,0 +1,227 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0+
+#
+# Run a series of tests on remote systems under KVM.
+#
+# Usage: kvm-remote.sh "systems" [ <kvm.sh args> ]
+#	 kvm-remote.sh "systems" /path/to/old/run [ <kvm-again.sh args> ]
+#
+# Copyright (C) 2021 Facebook, Inc.
+#
+# Authors: Paul E. McKenney <paulmck@kernel.org>
+
+scriptname=$0
+args="$*"
+
+if ! test -d tools/testing/selftests/rcutorture/bin
+then
+	echo $scriptname must be run from top-level directory of kernel source tree.
+	exit 1
+fi
+
+KVM="`pwd`/tools/testing/selftests/rcutorture"; export KVM
+PATH=${KVM}/bin:$PATH; export PATH
+. functions.sh
+
+starttime="`get_starttime`"
+
+systems="$1"
+if test -z "$systems"
+then
+	echo $scriptname: Empty list of systems will go nowhere good, giving up.
+	exit 1
+fi
+shift
+
+# Pathnames:
+# T:	  /tmp/kvm-remote.sh.$$
+# resdir: /tmp/kvm-remote.sh.$$/res
+# rundir: /tmp/kvm-remote.sh.$$/res/$ds ("-remote" suffix)
+# oldrun: `pwd`/tools/testing/.../res/$otherds
+#
+# Pathname segments:
+# TD:	  kvm-remote.sh.$$
+# ds:	  yyyy.mm.dd-hh.mm.ss-remote
+
+TD=kvm-remote.sh.$$
+T=${TMPDIR-/tmp}/$TD
+trap 'rm -rf $T' 0
+mkdir $T
+
+resdir="$T/res"
+ds=`date +%Y.%m.%d-%H.%M.%S`-remote
+rundir=$resdir/$ds
+echo Results directory: $rundir
+echo $scriptname $args
+if echo $1 | grep -q '^--'
+then
+	# Fresh build.  Create a datestamp unless the caller supplied one.
+	datestamp="`echo "$@" | awk -v ds="$ds" '{
+		for (i = 1; i < NF; i++) {
+			if ($i == "--datestamp") {
+				ds = "";
+				break;
+			}
+		}
+		if (ds != "")
+			print "--datestamp " ds;
+	}'`"
+	kvm.sh "$@" $datestamp --buildonly > $T/kvm.sh.out 2>&1
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo $scriptname: kvm.sh failed exit code $?
+		cat $T/kvm.sh.out
+		exit 2
+	fi
+	oldrun="`grep -m 1 "^Results directory: " $T/kvm.sh.out | awk '{ print $3 }'`"
+	touch "$oldrun/remote-log"
+	echo $scriptname $args >> "$oldrun/remote-log"
+	echo | tee -a "$oldrun/remote-log"
+	echo " ----" kvm.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
+	cat $T/kvm.sh.out | tee -a "$oldrun/remote-log"
+	# We are going to run this, so remove the buildonly files.
+	rm -f "$oldrun"/*/buildonly
+	kvm-again.sh $oldrun --dryrun --remote --rundir "$rundir" > $T/kvm-again.sh.out 2>&1
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo $scriptname: kvm-again.sh failed exit code $? | tee -a "$oldrun/remote-log"
+		cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
+		exit 2
+	fi
+else
+	# Re-use old run.
+	oldrun="$1"
+	if ! echo $oldrun | grep -q '^/'
+	then
+		oldrun="`pwd`/$oldrun"
+	fi
+	shift
+	touch "$oldrun/remote-log"
+	echo $scriptname $args >> "$oldrun/remote-log"
+	kvm-again.sh "$oldrun" "$@" --dryrun --remote --rundir "$rundir" > $T/kvm-again.sh.out 2>&1
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo $scriptname: kvm-again.sh failed exit code $? | tee -a "$oldrun/remote-log"
+		cat $T/kvm-again.sh.out | tee -a "$oldrun/remote-log"
+		exit 2
+	fi
+	cp -a "$rundir" "$KVM/res/"
+	oldrun="$KVM/res/$ds"
+fi
+echo | tee -a "$oldrun/remote-log"
+echo " ----" kvm-again.sh output: "(`date`)" | tee -a "$oldrun/remote-log"
+cat $T/kvm-again.sh.out
+echo | tee -a "$oldrun/remote-log"
+echo Remote run directory: $rundir | tee -a "$oldrun/remote-log"
+echo Local build-side run directory: $oldrun | tee -a "$oldrun/remote-log"
+
+# Create the kvm-remote-N.sh scripts in the bin directory.
+awk < "$rundir"/scenarios -v dest="$T/bin" -v rundir="$rundir" '
+{
+	n = $1;
+	sub(/\./, "", n);
+	fn = dest "/kvm-remote-" n ".sh"
+	scenarios = "";
+	for (i = 2; i <= NF; i++)
+		scenarios = scenarios " " $i;
+	print "kvm-test-1-run-batch.sh" scenarios > fn;
+	print "rm " rundir "/remote.run" >> fn;
+}'
+chmod +x $T/bin/kvm-remote-*.sh
+( cd "`dirname $T`"; tar -chzf $T/binres.tgz "$TD/bin" "$TD/res" )
+
+# Check first to avoid the need for cleanup for system-name typos
+for i in $systems
+do
+	ncpus="`ssh $i lscpu | grep '^CPU(' | awk '{ print $2 }'`"
+	echo $i: $ncpus CPUs " " `date` | tee -a "$oldrun/remote-log"
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo System $i unreachable, giving up. | tee -a "$oldrun/remote-log"
+		exit 4 | tee -a "$oldrun/remote-log"
+	fi
+done
+
+# Download and expand the tarball on all systems.
+for i in $systems
+do
+	echo Downloading tarball to $i `date` | tee -a "$oldrun/remote-log"
+	cat $T/binres.tgz | ssh $i "cd /tmp; tar -xzf -"
+	ret=$?
+	if test "$ret" -ne 0
+	then
+		echo Unable to download $T/binres.tgz to system $i, giving up. | tee -a "$oldrun/remote-log"
+		exit 10 | tee -a "$oldrun/remote-log"
+	fi
+done
+
+# Function to start batches on idle remote $systems
+#
+# Usage: startbatches curbatch nbatches
+#
+# Batches are numbered starting at 1.  Returns the next batch to start.
+# Be careful to redirect all debug output to FD 2 (stderr).
+startbatches () {
+	local curbatch="$1"
+	local nbatches="$2"
+	local ret
+
+	# Each pass through the following loop examines one system.
+	for i in $systems
+	do
+		if test "$curbatch" -gt "$nbatches"
+		then
+			echo $((nbatches + 1))
+			return 0
+		fi
+		if ssh "$i" "test -f \"$resdir/$ds/remote.run\"" 1>&2
+		then
+			continue # System still running last test, skip.
+		fi
+		ssh "$i" "cd \"$resdir/$ds\"; touch remote.run; PATH=\"$T/bin:$PATH\" nohup kvm-remote-$curbatch.sh > kvm-remote-$curbatch.sh.out 2>&1 &" 1>&2
+		ret=$?
+		if test "$ret" -ne 0
+		then
+			echo ssh $i failed: exitcode $ret 1>&2
+			exit 11
+		fi
+		echo " ----" System $i Batch `head -n $curbatch < "$rundir"/scenarios | tail -1` `date` 1>&2
+		curbatch=$((curbatch + 1))
+	done
+	echo $curbatch
+}
+
+# Launch all the scenarios.
+nbatches="`wc -l "$rundir"/scenarios | awk '{ print $1 }'`"
+curbatch=1
+while test "$curbatch" -le "$nbatches"
+do
+	startbatches $curbatch $nbatches > $T/curbatch 2> $T/startbatches.stderr
+	curbatch="`cat $T/curbatch`"
+	if test -s "$T/startbatches.stderr"
+	then
+		cat "$T/startbatches.stderr" | tee -a "$oldrun/remote-log"
+	fi
+	if test "$curbatch" -le "$nbatches"
+	then
+		sleep 30
+	fi
+done
+echo All batches started. `date`
+
+# Wait for all remaining scenarios to complete and collect results.
+for i in $systems
+do
+	while ssh "$i" "test -f \"$resdir/$ds/remote.run\""
+	do
+		sleep 30
+	done
+	( cd "$oldrun"; ssh $i "cd $rundir; tar -czf - kvm-remote-*.sh.out */console.log */kvm-test-1-run*.sh.out */qemu_pid */qemu-retval; rm -rf $T > /dev/null 2>&1" | tar -xzf - )
+done
+
+( kvm-end-run-stats.sh "$oldrun" "$starttime"; echo $? > $T/exitcode ) | tee -a "$oldrun/remote-log"
+exit "`cat $T/exitcode`"
