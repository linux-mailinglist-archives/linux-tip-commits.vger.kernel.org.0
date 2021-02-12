Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9B319EFC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbhBLMpB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:45:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbhBLMnO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:43:14 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2F6C06178B;
        Fri, 12 Feb 2021 04:42:33 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J87AAOtPriO9t+L4rb+dmbUgY7jmq6298hfOYkmL6jg=;
        b=pWlPojICHoPY/vEVhxjlsM+wL2BLwEbXQ4VL2UKmYWrDhYwzcaGDqrIpzIjoqW0eK+hrkC
        f2eSFuxu/px9V/Gi3Pxs7aJKNojzfxKVgk1OMS1lMB1HEZJLEvbifV8uq2j4Mnezv4trOG
        1AgjM0UrVh0aRLo4o3dwRI3BQ/qzBa0KYquyUX9OVUhB6+3MQfCQdDWUjTHPW59DQnfs1j
        Lxz2TptQKD8gUIXtrkVd2zFoMF3rJclC0UcQd5qku26sFdJj6lVKJaKzhgy7j3Qmq4oNs8
        Kb7wHG1ImSVJqACYxrAO7NVr3uySAzW0JTlv2Xax3DEvbs3FU9LKMuxu2dSifQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133447;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J87AAOtPriO9t+L4rb+dmbUgY7jmq6298hfOYkmL6jg=;
        b=zZwzKkko7ZMaImNPon4PKuQYQj7h31KSpAE2UQqfxIpnLsQ8zv8KKHFKlggDcDUsCVzvOs
        jp8S/wsG+2jLvZCA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Print run duration at end of kvm.sh execution
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344692.23325.15899028955138327348.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0bcca18348cfde8e59b77cdf6f3e278289a16e67
Gitweb:        https://git.kernel.org/tip/0bcca18348cfde8e59b77cdf6f3e278289a16e67
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 22 Nov 2020 09:55:34 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:01:21 -08:00

torture: Print run duration at end of kvm.sh execution

Yes, you can mentally subtract the timestamps, but this commit makes
the computer do this work.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/testing/selftests/rcutorture/bin/functions.sh | 33 ++++++++++++-
 tools/testing/selftests/rcutorture/bin/kvm.sh       |  6 ++-
 2 files changed, 39 insertions(+)

diff --git a/tools/testing/selftests/rcutorture/bin/functions.sh b/tools/testing/selftests/rcutorture/bin/functions.sh
index fef8b4b..97c3a17 100644
--- a/tools/testing/selftests/rcutorture/bin/functions.sh
+++ b/tools/testing/selftests/rcutorture/bin/functions.sh
@@ -108,6 +108,39 @@ configfrag_hotplug_cpu () {
 	grep -q '^CONFIG_HOTPLUG_CPU=y$' "$1"
 }
 
+# get_starttime
+#
+# Returns a cookie identifying the current time.
+get_starttime () {
+	awk 'BEGIN { print systime() }' < /dev/null
+}
+
+# get_starttime_duration starttime
+#
+# Given the return value from get_starttime, compute a human-readable
+# string denoting the time since get_starttime.
+get_starttime_duration () {
+	awk -v starttime=$1 '
+	BEGIN {
+		ts = systime() - starttime; 
+		tm = int(ts / 60);
+		th = int(ts / 3600);
+		td = int(ts / 86400);
+		d = td;
+		h = th - td * 24;
+		m = tm - th * 60;
+		s = ts - tm * 60;
+		if (d >= 1)
+			printf "%dd %d:%02d:%02d\n", d, h, m, s
+		else if (h >= 1)
+			printf "%d:%02d:%02d\n", h, m, s
+		else if (m >= 1)
+			printf "%d:%02d.0\n", m, s
+		else
+			print s " seconds"
+	}' < /dev/null
+}
+
 # identify_boot_image qemu-cmd
 #
 # Returns the relative path to the kernel build image.  This will be
diff --git a/tools/testing/selftests/rcutorture/bin/kvm.sh b/tools/testing/selftests/rcutorture/bin/kvm.sh
index 6fd7ef7..6f21268 100755
--- a/tools/testing/selftests/rcutorture/bin/kvm.sh
+++ b/tools/testing/selftests/rcutorture/bin/kvm.sh
@@ -47,6 +47,9 @@ cpus=0
 ds=`date +%Y.%m.%d-%H.%M.%S`
 jitter="-1"
 
+startdate="`date`"
+starttime="`get_starttime`"
+
 usage () {
 	echo "Usage: $scriptname optional arguments:"
 	echo "       --allcpus"
@@ -548,6 +551,9 @@ then
 else
 	# Not a dryrun, so run the script.
 	sh $T/script
+	ret=$?
+	echo " --- Done at `date` (`get_starttime_duration $starttime`)"
+	exit $ret
 fi
 
 # Tracing: trace_event=rcu:rcu_grace_period,rcu:rcu_future_grace_period,rcu:rcu_grace_period_init,rcu:rcu_nocb_wake,rcu:rcu_preempt_task,rcu:rcu_unlock_preempted_task,rcu:rcu_quiescent_state_report,rcu:rcu_fqs,rcu:rcu_callback,rcu:rcu_kfree_callback,rcu:rcu_batch_start,rcu:rcu_invoke_callback,rcu:rcu_invoke_kfree_callback,rcu:rcu_batch_end,rcu:rcu_torture_read,rcu:rcu_barrier
