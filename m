Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2340735B4E6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235904AbhDKNoX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235772AbhDKNoG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A2C3C06138B;
        Sun, 11 Apr 2021 06:43:49 -0700 (PDT)
Date:   Sun, 11 Apr 2021 13:43:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=viipn2e0lkS2GmFL23zdyo0tpQc+sarX1+ppdNnGmBQ=;
        b=RqoWmKpDvtzpRM+Mf4keOSZDrYOnRnOEZw8lal6XRSlG04mQWLe9/+70E2hNVeGZnDGJvh
        K6CX/hmNHHIMm0tuCGjA/em4RRo2haCmdrQtYyXPJz2CbnbvU1s3spn+jJc6pwfHf5IS6S
        WfLGcXoRUZFoMJmKWpxsr4rSnNLtxBKp1oJmbUdLvk/1gGgviQKp6xqVVB+/Pk/zFEJ082
        H0NeJjn9joaorbSQZwgARV0AlGLNjc8bSJ3ZsDMYrKJEusBnD6qr4GCMyxHmzEp53G1zJ2
        EBWQKKmbqeM1UK0VKnjGlhlVwYfXH4AbXU70wmxriEm4in3fC9T3kVYhUL8q5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148609;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=viipn2e0lkS2GmFL23zdyo0tpQc+sarX1+ppdNnGmBQ=;
        b=KztePGRpgeoQc2mVi89zMXCoMg8Xu80QtPbETr4Jt2mhV0biEaHQYY/iK9bl6/hPstD47w
        +yO7Rhgn+g0kGJCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Eliminate jitter_pids file
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860919.29796.12443077248137197494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1f922db8eef015f261480347aaf79fa9a25728f2
Gitweb:        https://git.kernel.org/tip/1f922db8eef015f261480347aaf79fa9a25728f2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 11 Feb 2021 10:56:42 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:23:01 -08:00

torture: Eliminate jitter_pids file

Now that there is a reliable way to convince the jitter.sh scripts to
stop, the jitter_pids file is not needed, nor is the code that kills all
the PIDs contained in this file.  This commit therefore eliminates this
file and the code using it.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh | 14 +-------
 tools/testing/selftests/rcutorture/bin/kvm.sh            |  5 +---
 2 files changed, 1 insertion(+), 18 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
index fed6f10..eb5346b 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-test-1-run.sh
@@ -270,20 +270,6 @@ do
 				echo "ps -fp $killpid" >> $resdir/Warnings 2>&1
 				ps -fp $killpid >> $resdir/Warnings 2>&1
 			fi
-			# Reduce probability of PID reuse by allowing a one-minute buffer
-			if test $((kruntime + 60)) -lt $seconds && test -s "$resdir/../jitter_pids"
-			then
-				awk < "$resdir/../jitter_pids" '
-				NF > 0 {
-					pidlist = pidlist " " $1;
-					n++;
-				}
-				END {
-					if (n > 0) {
-						print "kill " pidlist;
-					}
-				}' | sh
-			fi
 		else
 			echo ' ---' `date`: "Kernel done"
 		fi
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 48da4cd..de93802 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -502,12 +502,9 @@ function dump(first, pastlast, batchnum)
 	print "if test -n \"$needqemurun\""
 	print "then"
 	print "\techo ---- Starting kernels. `date` | tee -a " rd "log";
-	print "\techo > " rd "jitter_pids"
 	print "\ttouch " rd "jittering"
-	for (j = 0; j < njitter; j++) {
+	for (j = 0; j < njitter; j++)
 		print "\tjitter.sh " j " " dur " " rd "jittering " ja[2] " " ja[3] "&"
-		print "\techo $! >> " rd "jitter_pids"
-	}
 	print "\twhile ls $runfiles > /dev/null 2>&1"
 	print "\tdo"
 	print "\t\t:"
