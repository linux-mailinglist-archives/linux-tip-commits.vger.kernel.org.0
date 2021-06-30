Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 360073B83C2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235715AbhF3Nur (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235384AbhF3NuR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD1C0611C3;
        Wed, 30 Jun 2021 06:47:41 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1scK2Gmr5Gu/AIH4H4xrN0riJIAIBp33NXynxUMC3KY=;
        b=Wlc3LXPmMrWK7j9+UdCN/RNDdJ3XW60uO82d4IbV3wy+1g8H1H+0gtrMJFQgcwc2nPnEks
        jqB7+qdHmlzrwce7uvfPmM0AvjmejFXMhmkuObUd3WcLXKmKgC6ouSo8245it4/4qHvMgJ
        7lSyMGj6anN7Z5mACstKdKvRt0FIqzRN/DIQUOajfU1G3sHis4LvLdvORwnv13tnVkXVZ5
        7FwF3k2643A4T65kU7LifLnzee58apCNS2O20joE6G8ma5fwQ74IR9cXFRMkddG8MUJS4D
        QMgNIL+WP5lyOwXEK+Ih772mcA6PjaJCj+7UonDdUoq38lcFh5TuYLkGqfymJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060860;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1scK2Gmr5Gu/AIH4H4xrN0riJIAIBp33NXynxUMC3KY=;
        b=H3DdQrPmquYL1e4vN6Ci7Ro1OKGt1r2E9iFzzMscEiVWDXgJqcPA6g2IUMldzpdv7tpDW2
        NH20RO6SYMT5EUBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm-remote.sh account for network
 failure in pathname checks
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085954.395.6839937823458187961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     c43d3b0083b4f2e9b14174a5857ab06cbca986df
Gitweb:        https://git.kernel.org/tip/c43d3b0083b4f2e9b14174a5857ab06cbca986df
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 27 Apr 2021 09:56:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:05:07 -07:00

torture: Make kvm-remote.sh account for network failure in pathname checks

In a long-duration kvm-remote.sh run, almost all of the remote accesses will
be simple file-existence checks.  These are thus the most likely to be caught
out by network failures, which do happen from time to time.

This commit therefore takes a first step towards tolerating temporary
network outages by making the file-existence checks repeat in the face of
such an outage.  They also print a message every minute during a outage,
allowing the user to take appropriate action.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-remote.sh | 26 ++++++++++-
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
index f08d415..20e848d 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-remote.sh
@@ -159,6 +159,28 @@ do
 	fi
 done
 
+# Function to check for presence of a file on the specified system.
+# Complain if the system cannot be reached, and retry after a wait.
+# Currently just waits forever if a machine disappears.
+#
+# Usage: checkremotefile system pathname
+checkremotefile () {
+	local ret
+	local sleeptime=60
+
+	while :
+	do
+		ssh $1 "test -f \"$2\""
+		ret=$?
+		if test "$ret" -ne 255
+		then
+			return $ret
+		fi
+		echo " ---" ssh failure to $1 checking for file $2, retry after $sleeptime seconds. `date`
+		sleep $sleeptime
+	done
+}
+
 # Function to start batches on idle remote $systems
 #
 # Usage: startbatches curbatch nbatches
@@ -178,7 +200,7 @@ startbatches () {
 			echo $((nbatches + 1))
 			return 0
 		fi
-		if ssh "$i" "test -f \"$resdir/$ds/remote.run\"" 1>&2
+		if checkremotefile "$i" "$resdir/$ds/remote.run" 1>&2
 		then
 			continue # System still running last test, skip.
 		fi
@@ -216,7 +238,7 @@ echo All batches started. `date`
 # Wait for all remaining scenarios to complete and collect results.
 for i in $systems
 do
-	while ssh "$i" "test -f \"$resdir/$ds/remote.run\""
+	while checkremotefile "$i" "$resdir/$ds/remote.run"
 	do
 		sleep 30
 	done
