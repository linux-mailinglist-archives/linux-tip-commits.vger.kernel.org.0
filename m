Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D1537BA6F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhELK3r (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230429AbhELK3j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30B55C061761;
        Wed, 12 May 2021 03:28:31 -0700 (PDT)
Date:   Wed, 12 May 2021 10:28:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsqZZgvV69PndNSLGVX4JrpPPoDgX5xNdwYhxEOJtXI=;
        b=XCz4INBdA7M33eGvqPEGDbP2Gs+0W5cyiUPFPr5tCMwL2JETib1m25xblJFSJA2MQR0uAq
        YLNwTzhDNYtKg2qap4W00lHaqlm8FLgjuD95lqXuJhxDObvQMuX+WcpkC3b5syeOV2jiO/
        3QNOqTGLCVAgKFe9cgaSBOaKsiPY6glK2gC7mavTIy3zQTAfszjN5NYMU42xdk1ENjB2nG
        kdotRwHZvhR1mSHz4lWJvpphjzmLRY58d1sESw9QgwT7lI4vLLQWOBYT0jh0Ba4rlxu2uB
        W4XQx4hdJPdxA8e5UXrtGOEt+C5AgbOzERwvPlFdZDr80ddx/qovj3znJ8oFKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UsqZZgvV69PndNSLGVX4JrpPPoDgX5xNdwYhxEOJtXI=;
        b=UfopozyMsv3T+360EziQDhUH3OzoNfTJWuN+zRl/EdevuJd3Uc+H6Ssk4VrAaZlkj3ZojK
        b6t1bGyStgqSN+AQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] delayacct: Default disabled
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505111525.308018373@infradead.org>
References: <20210505111525.308018373@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530906.29796.13536747995419262567.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e4042ad492357fa995921376462b04a025dd53b6
Gitweb:        https://git.kernel.org/tip/e4042ad492357fa995921376462b04a025dd53b6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 May 2021 22:43:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:25 +02:00

delayacct: Default disabled

Assuming this stuff isn't actually used much; disable it by default
and avoid allocating and tracking the task_delay_info structure.

taskstats is changed to still report the regular sched and sched_info
and only skip the missing task_delay_info fields instead of not
reporting anything.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210505111525.308018373@infradead.org
---
 Documentation/accounting/delay-accounting.rst   |  8 +++----
 Documentation/admin-guide/kernel-parameters.txt |  2 +-
 include/linux/delayacct.h                       | 16 +++----------
 kernel/delayacct.c                              | 19 +++++++++-------
 4 files changed, 20 insertions(+), 25 deletions(-)

diff --git a/Documentation/accounting/delay-accounting.rst b/Documentation/accounting/delay-accounting.rst
index 7cc7f58..f20b282 100644
--- a/Documentation/accounting/delay-accounting.rst
+++ b/Documentation/accounting/delay-accounting.rst
@@ -69,13 +69,13 @@ Compile the kernel with::
 	CONFIG_TASK_DELAY_ACCT=y
 	CONFIG_TASKSTATS=y
 
-Delay accounting is enabled by default at boot up.
-To disable, add::
+Delay accounting is disabled by default at boot up.
+To enable, add::
 
-   nodelayacct
+   delayacct
 
 to the kernel boot options. The rest of the instructions
-below assume this has not been done.
+below assume this has been done.
 
 After the system has booted up, use a utility
 similar to  getdelays.c to access the delays
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index cb89dbd..ef5048c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -3244,7 +3244,7 @@
 
 	noclflush	[BUGS=X86] Don't use the CLFLUSH instruction
 
-	nodelayacct	[KNL] Disable per-task delay accounting
+	delayacct	[KNL] Enable per-task delay accounting
 
 	nodsp		[SH] Disable hardware DSP at boot time.
 
diff --git a/include/linux/delayacct.h b/include/linux/delayacct.h
index 57fefa5..225c8e0 100644
--- a/include/linux/delayacct.h
+++ b/include/linux/delayacct.h
@@ -61,7 +61,7 @@ struct task_delay_info {
 #include <linux/jump_label.h>
 
 #ifdef CONFIG_TASK_DELAY_ACCT
-DECLARE_STATIC_KEY_TRUE(delayacct_key);
+DECLARE_STATIC_KEY_FALSE(delayacct_key);
 extern int delayacct_on;	/* Delay accounting turned on/off */
 extern struct kmem_cache *delayacct_cache;
 extern void delayacct_init(void);
@@ -69,7 +69,7 @@ extern void __delayacct_tsk_init(struct task_struct *);
 extern void __delayacct_tsk_exit(struct task_struct *);
 extern void __delayacct_blkio_start(void);
 extern void __delayacct_blkio_end(struct task_struct *);
-extern int __delayacct_add_tsk(struct taskstats *, struct task_struct *);
+extern int delayacct_add_tsk(struct taskstats *, struct task_struct *);
 extern __u64 __delayacct_blkio_ticks(struct task_struct *);
 extern void __delayacct_freepages_start(void);
 extern void __delayacct_freepages_end(void);
@@ -116,7 +116,7 @@ static inline void delayacct_tsk_free(struct task_struct *tsk)
 
 static inline void delayacct_blkio_start(void)
 {
-	if (!static_branch_likely(&delayacct_key))
+	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	delayacct_set_flag(current, DELAYACCT_PF_BLKIO);
@@ -126,7 +126,7 @@ static inline void delayacct_blkio_start(void)
 
 static inline void delayacct_blkio_end(struct task_struct *p)
 {
-	if (!static_branch_likely(&delayacct_key))
+	if (!static_branch_unlikely(&delayacct_key))
 		return;
 
 	if (p->delays)
@@ -134,14 +134,6 @@ static inline void delayacct_blkio_end(struct task_struct *p)
 	delayacct_clear_flag(p, DELAYACCT_PF_BLKIO);
 }
 
-static inline int delayacct_add_tsk(struct taskstats *d,
-					struct task_struct *tsk)
-{
-	if (!delayacct_on || !tsk->delays)
-		return 0;
-	return __delayacct_add_tsk(d, tsk);
-}
-
 static inline __u64 delayacct_blkio_ticks(struct task_struct *tsk)
 {
 	if (tsk->delays)
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 63012fd..3f08690 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -14,23 +14,23 @@
 #include <linux/delayacct.h>
 #include <linux/module.h>
 
-DEFINE_STATIC_KEY_TRUE(delayacct_key);
-int delayacct_on __read_mostly = 1;	/* Delay accounting turned on/off */
+DEFINE_STATIC_KEY_FALSE(delayacct_key);
+int delayacct_on __read_mostly;	/* Delay accounting turned on/off */
 struct kmem_cache *delayacct_cache;
 
-static int __init delayacct_setup_disable(char *str)
+static int __init delayacct_setup_enable(char *str)
 {
-	delayacct_on = 0;
+	delayacct_on = 1;
 	return 1;
 }
-__setup("nodelayacct", delayacct_setup_disable);
+__setup("delayacct", delayacct_setup_enable);
 
 void delayacct_init(void)
 {
 	delayacct_cache = KMEM_CACHE(task_delay_info, SLAB_PANIC|SLAB_ACCOUNT);
 	delayacct_tsk_init(&init_task);
-	if (!delayacct_on)
-		static_branch_disable(&delayacct_key);
+	if (delayacct_on)
+		static_branch_enable(&delayacct_key);
 }
 
 void __delayacct_tsk_init(struct task_struct *tsk)
@@ -83,7 +83,7 @@ void __delayacct_blkio_end(struct task_struct *p)
 	delayacct_end(&delays->lock, &delays->blkio_start, total, count);
 }
 
-int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
+int delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 {
 	u64 utime, stime, stimescaled, utimescaled;
 	unsigned long long t2, t3;
@@ -118,6 +118,9 @@ int __delayacct_add_tsk(struct taskstats *d, struct task_struct *tsk)
 	d->cpu_run_virtual_total =
 		(tmp < (s64)d->cpu_run_virtual_total) ?	0 : tmp;
 
+	if (!tsk->delays)
+		return 0;
+
 	/* zero XXX_total, non-zero XXX_count implies XXX stat overflowed */
 
 	raw_spin_lock_irqsave(&tsk->delays->lock, flags);
