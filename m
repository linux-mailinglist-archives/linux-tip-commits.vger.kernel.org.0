Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E61E72D8FAF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729288AbgLMTEP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:04:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727764AbgLMTBv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:51 -0500
Date:   Sun, 13 Dec 2020 19:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tDm9P/LbIofFWkfxL2Svk8ijFLazuTzsi3rIhIdZrac=;
        b=G5Ajujs3Gybhb4talnEotpZ4uKYOtEae0pPwomvnIkirhJXqVZZVRuBU94A6ZoFdOQq8LT
        JwCW/AoQkfnOL/Zhoqk9HEKm4YSCE8t+YLhb6DsyolfybL/Dw8Tw8LQzos5+QaR5e1/9CS
        tQQIqIe5wgLSj674ycCWJEhv1NMIZltInWKrQie052ZU8L+WlGodcqhIfwPdbNcyXMBm8o
        McbX12oTcXLvLX4V9AmmzgvdwJj93VE1LFF4+xgltcY40sKn9LkHq1/wQmblWFfg86fOg0
        f7CWjRe/2UXsAUtj4NwQmGh21O7i9ob0kzbXjN0xt5n/VNsqQSNbeX7GoDBK2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=tDm9P/LbIofFWkfxL2Svk8ijFLazuTzsi3rIhIdZrac=;
        b=woxEt6I9tXByPr4IpYrOCRiZmKZMb0VpXCLUQlUz/A7qJeQC1E1zwf9YkQOrLWuF4Dg4xF
        W4Z+rFsuhucj7ADQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Prevent jitter processes from delaying failed run
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606892.3364.140833623628200915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c64659ef29e3901be0900ec6fb0485fa3dbdcfd8
Gitweb:        https://git.kernel.org/tip/c64659ef29e3901be0900ec6fb0485fa3dbdcfd8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 18 Sep 2020 13:26:22 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:53 -08:00

torture: Prevent jitter processes from delaying failed run

Even when the kernel panics and qemu dies, runs with jitter enabled will
continue uselessly until the jitter.sh processes terminate.  This can
be annoying if a planned one-hour run instead dies during boot.

This commit therefore kills the jitter.sh processes when the run ends
more than one minute prior to the termination time specified by the
kvm.sh --duration argument or its default.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 14 +++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  5 ++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index d04966a..3cd03d0 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -226,6 +226,20 @@ do
 				echo "ps -fp $killpid" >> $resdir/Warnings 2>&1
 				ps -fp $killpid >> $resdir/Warnings 2>&1
 			fi
+			# Reduce probability of PID reuse by allowing a one-minute buffer
+			if test $((kruntime + 60)) -lt $seconds && test -s "$resdir/../jitter_pids"
+			then
+				awk < "$resdir/../jitter_pids" '
+				NF > 0 {
+					pidlist = pidlist " " $1;
+					n++;
+				}
+				END {
+					if (n > 0) {
+						print "kill " pidlist;
+					}
+				}' | sh
+			fi
 		else
 			echo ' ---' `date`: "Kernel done"
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6eb1d3f..5ad3882 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -459,8 +459,11 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	for (j = 0; j < njitter; j++)
+	print "\techo > " rd "jitter_pids"
+	for (j = 0; j < njitter; j++) {
 		print "\tjitter.sh " j " " dur " " ja[2] " " ja[3] "&"
+		print "\techo $! >> " rd "jitter_pids"
+	}
 	print "\twait"
 	print "\techo ---- All kernel runs complete. `date` | tee -a " rd "log";
 	print "else"
