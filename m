Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF4FA35B4DC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235853AbhDKNoQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33036 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235735AbhDKNoF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:05 -0400
Date:   Sun, 11 Apr 2021 13:43:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vAy56XGBgcYn2Yc1bUV08E2742RQczGVc+glkEBgR+4=;
        b=CRr4SAYE/eADmmppOSa2R9Abc3J7If3sH0jKuRT3FDzAciJ5WzHptPDbAT15cxElthJkvy
        2YtYvlOdOp8PaAdeWPxprGcZ30xsl0tXzSSUlv7DH73fjR/tntzCgGmlMbbqfdT9VbkfhS
        kL3nLyibTeYmTwGtaKX7Hxh4fKeO6WKQCbZ8FUhGUi8R016ICjR7SFJlkbxgBaW1zjke15
        rmuIGVNAY0Lkuy99oAlJTXtcvDEgGXArU9O9AywMottlSWOU2MlK2viCw2bwqKBq72Lo7m
        QIK5xeeKfLDfn2oWLXTBwhHDrBPiZk0rd+uTU1TQIzxXPnTkh/xWQEv4mYoObQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148610;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vAy56XGBgcYn2Yc1bUV08E2742RQczGVc+glkEBgR+4=;
        b=3rst5D+YVR9O6+d1OiEF5sdT2IRzc1VKg1OHfIxg15GeTqElEBCf4mKTAj6FE+VqfNhzMA
        DCvxvwomsAJzcSDg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Use "jittering" file to control jitter.sh execution
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860959.29796.12396234323610597872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     37812c9429722824859788cf754dd3e33f546908
Gitweb:        https://git.kernel.org/tip/37812c9429722824859788cf754dd3e33f546908
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 11 Feb 2021 10:39:28 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torture: Use "jittering" file to control jitter.sh execution

Currently, jitter.sh execution is controlled by a time limit and by the
"kill" command.  The former allowed jitter.sh to run uselessly past
the end of a set of runs that panicked during boot, and the latter is
vulnerable to PID reuse.  This commit therefore introduces a "jittering"
file in the date-stamp directory within "res" that must be present for
the jitter.sh scripts to continue executing.  The time limit is still
in place in order to avoid disturbing runs featuring large trace dumps,
but the removal of the "jittering" file handles the panic-during-boot
scenario without relying on PIDs.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/jitter.sh | 10 ++++++----
 tools/testing/selftests/rcutorture/bin/kvm.sh    |  5 ++++-
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/jitter.sh b/tools/testing/selftests/rcutorture/bin/jitter.sh
index 188b864..ed0ea86 100755
--- a/tools/testing/selftests/rcutorture/bin/jitter.sh
+++ b/tools/testing/selftests/rcutorture/bin/jitter.sh
@@ -5,10 +5,11 @@
 # of this script is to inflict random OS jitter on a concurrently running
 # test.
 #
-# Usage: jitter.sh me duration [ sleepmax [ spinmax ] ]
+# Usage: jitter.sh me duration jittering-path [ sleepmax [ spinmax ] ]
 #
 # me: Random-number-generator seed salt.
 # duration: Time to run in seconds.
+# jittering-path: Path to file whose removal will stop this script.
 # sleepmax: Maximum microseconds to sleep, defaults to one second.
 # spinmax: Maximum microseconds to spin, defaults to one millisecond.
 #
@@ -18,8 +19,9 @@
 
 me=$(($1 * 1000))
 duration=$2
-sleepmax=${3-1000000}
-spinmax=${4-1000}
+jittering=$3
+sleepmax=${4-1000000}
+spinmax=${5-1000}
 
 n=1
 
@@ -47,7 +49,7 @@ do
 	fi
 
 	# Check for stop request.
-	if test -f "$TORTURE_STOPFILE"
+	if ! test -f "$jittering"
 	then
 		exit 1;
 	fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 1f5f872..48da4cd 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -503,14 +503,17 @@ function dump(first, pastlast, batchnum)
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
 	print "\techo > " rd "jitter_pids"
+	print "\ttouch " rd "jittering"
 	for (j = 0; j < njitter; j++) {
-		print "\tjitter.sh " j " " dur " " ja[2] " " ja[3] "&"
+		print "\tjitter.sh " j " " dur " " rd "jittering " ja[2] " " ja[3] "&"
 		print "\techo $! >> " rd "jitter_pids"
 	}
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
 	print "\tdone"
+	print "\trm -f " rd "jittering"
+	print "\twait"
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
 	print "\twait"
