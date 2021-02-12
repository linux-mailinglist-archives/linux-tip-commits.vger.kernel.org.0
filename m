Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7A9319E91
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231562AbhBLMiq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:46 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45388 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbhBLMhy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:54 -0500
Date:   Fri, 12 Feb 2021 12:37:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HQlMLcpeCmKZGWrEl9BdNHy4YKeOyTqVAFVMEwPZsxA=;
        b=yfzEELMrHJZ7lMm90X+CDgLKbJt18lxSiPMogEQCCQAwNOnRe2LBGYW9nqlNTduzqPbySU
        kmdqKG5FOsISF0ylRyCQCAI6lI2FlqXs7aycfkgRK0r6Q4V4FvUfaUT+lQgw4GZEykO/KI
        /yiAkt5G8MJDQtcrPcdS4C9pseysSQGHBskt4irdtnHbjCUqpBR25D+M3PzUU1ctpwZgzO
        76UsSAsyo3LAiw5wOlf2cL7fXylen0gHh3Y82f2L9djfZlh37rnSWjuBDyt1Q8FvPAaiFx
        7E7bEzSqn85hMdXgNNx3zdh2erbQmLuu45qN1CIVH1m7+8Vll2B9hK6UrGA+cg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=HQlMLcpeCmKZGWrEl9BdNHy4YKeOyTqVAFVMEwPZsxA=;
        b=9YDGUtXlEcHmWWToxu6mfXs7kGhjAWYA6eLHvWBekmYUqBAJWX2zLvblZX827RRw0/65ps
        FoyHqimb7o57uNDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Compress KASAN vmlinux files
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343112.23325.17156435790678211958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e3e1a99787fcf6297990c3b6cf53f5f6ef5aed60
Gitweb:        https://git.kernel.org/tip/e3e1a99787fcf6297990c3b6cf53f5f6ef5aed60
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 11 Dec 2020 14:03:39 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:03:46 -08:00

torture: Compress KASAN vmlinux files

The sizes of vmlinux files built with KASAN enabled can approach a full
gigabyte, which can result in disk overflow sooner rather than later.
Fortunately, the xz command compresses them by almost an order of
magnitude.  This commit therefore uses xz to compress vmlinux file built
by torture.sh with KASAN enabled.

However, xz is not the fastest thing in the world.  In fact, it is way
slower than rotating-rust mass storage.  This commit therefore also adds a
--compress-kasan-vmlinux argument to specify the degree of xz concurrency,
which defaults to using all available CPUs if there are that many files in
need of compression.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/torture.sh | 48 +++++++++++++-
 1 file changed, 46 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/torture.sh b/tools/testing/selftests/rcutorture/bin/torture.sh
index 0867f30..ad7525b 100755
--- a/tools/testing/selftests/rcutorture/bin/torture.sh
+++ b/tools/testing/selftests/rcutorture/bin/torture.sh
@@ -36,7 +36,8 @@ configs_locktorture=
 configs_scftorture=
 kcsan_kmake_args=
 
-# Default duration and apportionment.
+# Default compression, duration, and apportionment.
+compress_kasan_vmlinux="`identify_qemu_vcpus`"
 duration_base=10
 duration_rcutorture_frac=7
 duration_locktorture_frac=1
@@ -65,6 +66,7 @@ function doyesno () {
 
 usage () {
 	echo "Usage: $scriptname optional arguments:"
+	echo "       --compress-kasan-vmlinux concurrency"
 	echo "       --configs-rcutorture \"config-file list w/ repeat factor (3*TINY01)\""
 	echo "       --configs-locktorture \"config-file list w/ repeat factor (10*LOCK01)\""
 	echo "       --configs-scftorture \"config-file list w/ repeat factor (2*CFLIST)\""
@@ -87,6 +89,11 @@ usage () {
 while test $# -gt 0
 do
 	case "$1" in
+	--compress-kasan-vmlinux)
+		checkarg --compress-kasan-vmlinux "(concurrency level)" $# "$2" '^[0-9][0-9]*$' '^error'
+		compress_kasan_vmlinux=$2
+		shift
+		;;
 	--config-rcutorture|--configs-rcutorture)
 		checkarg --configs-rcutorture "(list of config files)" "$#" "$2" '^[^/]\+$' '^--'
 		configs_rcutorture="$configs_rcutorture $2"
@@ -391,8 +398,45 @@ fi
 echo Started at $startdate, ended at `date`, duration `get_starttime_duration $starttime`. | tee -a $T/log
 echo Summary: Successes: $nsuccesses Failures: $nfailures. | tee -a $T/log
 tdir="`cat $T/successes $T/failures | head -1 | awk '{ print $NF }' | sed -e 's,/[^/]\+/*$,,'`"
+if test -n "$tdir" && test $compress_kasan_vmlinux -gt 0
+then
+	# KASAN vmlinux files can approach 1GB in size, so compress them.
+	echo Looking for KASAN files to compress: `date` > "$tdir/log-xz" 2>&1
+	find "$tdir" -type d -name '*-kasan' -print > $T/xz-todo
+	ncompresses=0
+	batchno=1
+	if test -s $T/xz-todo
+	then
+		echo Size before compressing: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
+		for i in `cat $T/xz-todo`
+		do
+			echo Compressing vmlinux files in ${i}: `date` >> "$tdir/log-xz" 2>&1
+			for j in $i/*/vmlinux
+			do
+				xz "$j" >> "$tdir/log-xz" 2>&1 &
+				ncompresses=$((ncompresses+1))
+				if test $ncompresses -ge $compress_kasan_vmlinux
+				then
+					echo Waiting for batch $batchno of $ncompresses compressions `date` | tee -a "$tdir/log-xz" | tee -a $T/log
+					wait
+					ncompresses=0
+					batchno=$((batchno+1))
+				fi
+			done
+		done
+		if test $ncompresses -gt 0
+		then
+			echo Waiting for final batch $batchno of $ncompresses compressions `date` | tee -a "$tdir/log-xz" | tee -a $T/log
+		fi
+		wait
+		echo Size after compressing: `du -sh $tdir | awk '{ print $1 }'` `date` 2>&1 | tee -a "$tdir/log-xz" | tee -a $T/log
+		echo Total duration `get_starttime_duration $starttime`. | tee -a $T/log
+	else
+		echo No compression needed: `date` >> "$tdir/log-xz" 2>&1
+	fi
+fi
 if test -n "$tdir"
 then
-	cp $T/log $tdir
+	cp $T/log "$tdir"
 fi
 exit $ret
