Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B69B335B4B9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235747AbhDKNoE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:04 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33034 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235516AbhDKNn6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:43:58 -0400
Date:   Sun, 11 Apr 2021 13:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X5g5Dym0RsSIFlfDfunq4gEApXv7YA/yvocuuoBPEZw=;
        b=pVXUkP4bIpK8Ua6J7I5YDixd25abpsNpSPNR0Br7AX2HksMgitJK0y3nOleYBw0dxO5zXk
        mtPIMzdL4ik/N3HA/1n0lJbySlPKgPFKqMErw1633IpEiBJluXGGdLgLw1Cb8QVGEG3L7P
        vwONjleX6bDTlm727sgj5oB9s4anhkX7+leDTmPyiB5Ci3gjECHJvgCpsmD6ImwcvYan05
        lJh6NYHrsLFNydUbqEgEAM5UYffcB1tlHnyTx4pbw283xBP3BEsfveczMyKk0yol1iG5GX
        5b2EG6lrLCKR1noxutzve0kCjlxglLqwCrMkil+FbIAn+dIHbxx7KJj5mEDkgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=X5g5Dym0RsSIFlfDfunq4gEApXv7YA/yvocuuoBPEZw=;
        b=/WutXhgcwSQz+MmTeo5H1ojQScQmbM28o23Zf5j5oVuwBzKNqnV0gsN3oqiX00C/ZeO2o/
        BK8FpX1IAeVGKwAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Make kvm-transform.sh update jitter commands
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814860037.29796.12364340946888061757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     018629e909ffcabfc657388094371f20ba90649f
Gitweb:        https://git.kernel.org/tip/018629e909ffcabfc657388094371f20ba90649f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 22 Feb 2021 14:58:41 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 22 Mar 2021 08:29:20 -07:00

torture: Make kvm-transform.sh update jitter commands

When rerunning an old run using kvm-again.sh, the jitter commands
will re-use the original "res" directory.  This works, but is clearly
an accident waiting to happen.  And this accident will happen with
remote runs, where the original directory lives on some other system.
This commit therefore updates the qemu-cmd commands to use the new res
directory created for this specific run.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/kvm-again.sh     |  3 +-
 tools/testing/selftests/rcutorture/bin/kvm-transform.sh | 23 ++++++--
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/rcutorture/bin/kvm-again.sh b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
index e7e5458..3fb57ce 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-again.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-again.sh
@@ -153,7 +153,8 @@ do
 	cp "$i" $T
 	qemu_cmd_dir="`dirname "$i"`"
 	kernel_dir="`echo $qemu_cmd_dir | sed -e 's/\.[0-9]\+$//'`"
-	kvm-transform.sh $kernel_dir/bzImage $qemu_cmd_dir/console.log $dur < $T/qemu-cmd > $i
+	jitter_dir="`dirname "$kernel_dir"`"
+	kvm-transform.sh "$kernel_dir/bzImage" "$qemu_cmd_dir/console.log" "$jitter_dir" $dur < $T/qemu-cmd > $i
 	if test -n "$dur"
 	then
 		echo "# seconds=$dur" >> $i
diff --git a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
index 162dddb..e9dcbce 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm-transform.sh
@@ -3,7 +3,7 @@
 #
 # Transform a qemu-cmd file to allow reuse.
 #
-# Usage: kvm-transform.sh bzImage console.log [ seconds ] < qemu-cmd-in > qemu-cmd-out
+# Usage: kvm-transform.sh bzImage console.log jitter_dir [ seconds ] < qemu-cmd-in > qemu-cmd-out
 #
 #	bzImage: Kernel and initrd from the same prior kvm.sh run.
 #	console.log: File into which to place console output.
@@ -29,14 +29,31 @@ then
 	echo "Need console log file name."
 	exit 1
 fi
-seconds=$3
+jitter_dir="$3"
+if test -z "$jitter_dir" || ! test -d "$jitter_dir"
+then
+	echo "Need valid jitter directory: '$jitter_dir'"
+	exit 1
+fi
+seconds="$4"
 if test -n "$seconds" && echo $seconds | grep -q '[^0-9]'
 then
 	echo "Invalid duration, should be numeric in seconds: '$seconds'"
 	exit 1
 fi
 
-awk -v image="$image" -v consolelog="$consolelog" -v seconds="$seconds" '
+awk -v image="$image" -v consolelog="$consolelog" -v jitter_dir="$jitter_dir" \
+    -v seconds="$seconds" '
+/^# TORTURE_JITTER_START=/ {
+	print "# TORTURE_JITTER_START=\". jitterstart.sh " $4 " " jitter_dir " " $6 " " $7;
+	next;
+}
+
+/^# TORTURE_JITTER_STOP=/ {
+	print "# TORTURE_JITTER_STOP=\". jitterstop.sh " " " jitter_dir " " $5;
+	next;
+}
+
 /^#/ {
 	print $0;
 	next;
