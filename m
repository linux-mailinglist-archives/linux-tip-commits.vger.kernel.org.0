Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 014A82D9007
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733206AbgLMTCJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46692 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgLMTBx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:53 -0500
Date:   Sun, 13 Dec 2020 19:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ftTr3TNEWJdfORyOB822tHqVVeFsEjLlGq5Grmh5LlU=;
        b=jhxVsH/T/tHCA6uhsUqAQQsdarXME30gNWjsGdYZ9aIR6GSFpWXbON+OAx7Q/Ooo9nG1/J
        KVmAUyHBgR5AYw/ppZQwHDZa4ZXTP69aKlN5ZfeKnU+ax2VElx+Tr5pOW1zL/eBcCr/sIt
        0ekRKAjAjBKqpMLW2FkZbYtEo0aFgqOhnp6Uo3z6ezIK7xdguY/n7W1Mogfuyc0BVmXmDm
        SjXnYn8JjVW0BOii3Lszg3QB9tGZrXMxkq7SvjdM1ZBgrF/01zZwHYxHFX7+0+FQBGhcP0
        uCr40K/VvOultU1+YsFCKGzYsR2kZpzrORlKeuaud4OGxXG2ZY4JL+6c9O1I/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886070;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ftTr3TNEWJdfORyOB822tHqVVeFsEjLlGq5Grmh5LlU=;
        b=NICWH7YYXYNivu4azfl0Fs4IWtM45XBkWMBb5e5Fp9fYyd2g+GN4mzqvNLC8hSG9OUlPYU
        5yep9HTBZtNH0lBA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuscale: Add RCU Tasks Trace
Cc:     Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607035.3364.6062393813117335533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     899f317e4886f916ed21027177177c11b577cea1
Gitweb:        https://git.kernel.org/tip/899f317e4886f916ed21027177177c11b577cea1
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 09 Sep 2020 12:27:03 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:50 -08:00

rcuscale: Add RCU Tasks Trace

This commit adds the ability to test performance and scalability of RCU
Tasks Trace updaters.

Reported-by: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcuscale.c                                            | 32 +++++++++++++++++++++++++++++++-
 tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon     |  3 +++
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01      | 15 +++++++++++++++
 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot |  1 +
 4 files changed, 50 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
 create mode 100644 tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot

diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 2819b95..c42f240 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -38,6 +38,7 @@
 #include <asm/byteorder.h>
 #include <linux/torture.h>
 #include <linux/vmalloc.h>
+#include <linux/rcupdate_trace.h>
 
 #include "rcu.h"
 
@@ -294,6 +295,35 @@ static struct rcu_scale_ops tasks_ops = {
 	.name		= "tasks"
 };
 
+/*
+ * Definitions for RCU-tasks-trace scalability testing.
+ */
+
+static int tasks_trace_scale_read_lock(void)
+{
+	rcu_read_lock_trace();
+	return 0;
+}
+
+static void tasks_trace_scale_read_unlock(int idx)
+{
+	rcu_read_unlock_trace();
+}
+
+static struct rcu_scale_ops tasks_tracing_ops = {
+	.ptype		= RCU_TASKS_FLAVOR,
+	.init		= rcu_sync_scale_init,
+	.readlock	= tasks_trace_scale_read_lock,
+	.readunlock	= tasks_trace_scale_read_unlock,
+	.get_gp_seq	= rcu_no_completed,
+	.gp_diff	= rcu_seq_diff,
+	.async		= call_rcu_tasks_trace,
+	.gp_barrier	= rcu_barrier_tasks_trace,
+	.sync		= synchronize_rcu_tasks_trace,
+	.exp_sync	= synchronize_rcu_tasks_trace,
+	.name		= "tasks-tracing"
+};
+
 static unsigned long rcuscale_seq_diff(unsigned long new, unsigned long old)
 {
 	if (!cur_ops->gp_diff)
@@ -754,7 +784,7 @@ rcu_scale_init(void)
 	long i;
 	int firsterr = 0;
 	static struct rcu_scale_ops *scale_ops[] = {
-		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops,
+		&rcu_ops, &srcu_ops, &srcud_ops, &tasks_ops, &tasks_tracing_ops
 	};
 
 	if (!torture_init_begin(scale_type, verbose))
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
index 87caa0e..90942bb 100644
--- a/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/CFcommon
@@ -1,2 +1,5 @@
 CONFIG_RCU_SCALE_TEST=y
 CONFIG_PRINTK_TIME=y
+CONFIG_TASKS_RCU_GENERIC=y
+CONFIG_TASKS_RCU=y
+CONFIG_TASKS_TRACE_RCU=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01 b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
new file mode 100644
index 0000000..e6baa2f
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01
@@ -0,0 +1,15 @@
+CONFIG_SMP=y
+CONFIG_PREEMPT_NONE=y
+CONFIG_PREEMPT_VOLUNTARY=n
+CONFIG_PREEMPT=n
+CONFIG_HZ_PERIODIC=n
+CONFIG_NO_HZ_IDLE=y
+CONFIG_NO_HZ_FULL=n
+CONFIG_RCU_FAST_NO_HZ=n
+CONFIG_RCU_NOCB_CPU=n
+CONFIG_DEBUG_LOCK_ALLOC=n
+CONFIG_PROVE_LOCKING=n
+CONFIG_RCU_BOOST=n
+CONFIG_DEBUG_OBJECTS_RCU_HEAD=n
+CONFIG_RCU_EXPERT=y
+CONFIG_RCU_TRACE=y
diff --git a/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
new file mode 100644
index 0000000..af0aff1
--- /dev/null
+++ b/tools/testing/selftests/rcutorture/configs/rcuscale/TRACE01.boot
@@ -0,0 +1 @@
+rcuscale.scale_type=tasks-tracing
