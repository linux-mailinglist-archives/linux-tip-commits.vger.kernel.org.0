Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC2F37BA70
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230503AbhELK3s (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230428AbhELK3j (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:39 -0400
Date:   Wed, 12 May 2021 10:28:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dFrpruQBtZTtww53DzNxGZKV1fvvuV4CSh0TZuxxZ0=;
        b=SQVmo4LvzFAiFMj0xzoQsrN8NLlhmqz9DpEyf5Lw7vn0tzRvnakEc15x9KyHWi99NGRv2x
        Zc9AFpzchXHGDlD2ivin4gH2j2s0Rc4dT2HuxKovlKcZaAvqJsUHZYvCDnQBE7dKKxIkYh
        LOpVCM5kVTlG5WiGzx6xkTPAbk9a73CRvLIzqJOf4QU5GNCFeFOHhj73HamM5Vo7N4LWXc
        RT41UUFqyf7BYlk/rrFvScdmtbOxQQsfmqNsLwlNFtChX/OD7enPnp3Lw9+4s68UtBntra
        w0Dqif8teEkphGfMt6UIreOrFtZqmXmJOsc+2MN1qGEYsxpUtt/gsOuZ9Ljvdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0dFrpruQBtZTtww53DzNxGZKV1fvvuV4CSh0TZuxxZ0=;
        b=xQcrIp/1c6TYlYj1ojbY1AypjIoZlyCQYqfWQHr3XxXSVabe+uru5mE2a1j3p4IpOLfoOP
        SfKYacJ1BycbuUCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify sched_info_on()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505111525.121458839@infradead.org>
References: <20210505111525.121458839@infradead.org>
MIME-Version: 1.0
Message-ID: <162081531041.29796.6076928259537596264.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c5895d3f06cbb80ccb311f1dcb37074651030cb6
Gitweb:        https://git.kernel.org/tip/c5895d3f06cbb80ccb311f1dcb37074651030cb6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 May 2021 22:43:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:24 +02:00

sched: Simplify sched_info_on()

The situation around sched_info is somewhat complicated, it is used by
sched_stats and delayacct and, indirectly, kvm.

If SCHEDSTATS=Y (but disabled by default) sched_info_on() is
unconditionally true -- this is the case for all distro kernel configs
I checked.

If for some reason SCHEDSTATS=N, but TASK_DELAY_ACCT=Y, then
sched_info_on() can return false when delayacct is disabled,
presumably because there would be no other users left; except kvm is.

Instead of complicating matters further by accurately accounting
sched_stat and kvm state, simply unconditionally enable when
SCHED_INFO=Y, matching the common distro case.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20210505111525.121458839@infradead.org
---
 include/linux/sched/stat.h | 10 ++--------
 kernel/delayacct.c         |  1 +-
 kernel/sched/stats.h       | 37 ++++++++++---------------------------
 3 files changed, 12 insertions(+), 36 deletions(-)

diff --git a/include/linux/sched/stat.h b/include/linux/sched/stat.h
index 5682864..939c3ec 100644
--- a/include/linux/sched/stat.h
+++ b/include/linux/sched/stat.h
@@ -3,6 +3,7 @@
 #define _LINUX_SCHED_STAT_H
 
 #include <linux/percpu.h>
+#include <linux/kconfig.h>
 
 /*
  * Various counters maintained by the scheduler and fork(),
@@ -23,14 +24,7 @@ extern unsigned long nr_iowait_cpu(int cpu);
 
 static inline int sched_info_on(void)
 {
-#ifdef CONFIG_SCHEDSTATS
-	return 1;
-#elif defined(CONFIG_TASK_DELAY_ACCT)
-	extern int delayacct_on;
-	return delayacct_on;
-#else
-	return 0;
-#endif
+	return IS_ENABLED(CONFIG_SCHED_INFO);
 }
 
 #ifdef CONFIG_SCHEDSTATS
diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 3fe7cd5..3a0b910 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -15,7 +15,6 @@
 #include <linux/module.h>
 
 int delayacct_on __read_mostly = 1;	/* Delay accounting turned on/off */
-EXPORT_SYMBOL_GPL(delayacct_on);
 struct kmem_cache *delayacct_cache;
 
 static int __init delayacct_setup_disable(char *str)
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index ee7da12..33ffd41 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -150,11 +150,6 @@ static inline void psi_sched_switch(struct task_struct *prev,
 #endif /* CONFIG_PSI */
 
 #ifdef CONFIG_SCHED_INFO
-static inline void sched_info_reset_dequeued(struct task_struct *t)
-{
-	t->sched_info.last_queued = 0;
-}
-
 /*
  * We are interested in knowing how long it was from the *first* time a
  * task was queued to the time that it finally hit a CPU, we call this routine
@@ -163,13 +158,12 @@ static inline void sched_info_reset_dequeued(struct task_struct *t)
  */
 static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 {
-	unsigned long long now = rq_clock(rq), delta = 0;
+	unsigned long long delta = 0;
 
-	if (sched_info_on()) {
-		if (t->sched_info.last_queued)
-			delta = now - t->sched_info.last_queued;
+	if (t->sched_info.last_queued) {
+		delta = rq_clock(rq) - t->sched_info.last_queued;
+		t->sched_info.last_queued = 0;
 	}
-	sched_info_reset_dequeued(t);
 	t->sched_info.run_delay += delta;
 
 	rq_sched_info_dequeue(rq, delta);
@@ -184,9 +178,10 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 {
 	unsigned long long now = rq_clock(rq), delta = 0;
 
-	if (t->sched_info.last_queued)
+	if (t->sched_info.last_queued) {
 		delta = now - t->sched_info.last_queued;
-	sched_info_reset_dequeued(t);
+		t->sched_info.last_queued = 0;
+	}
 	t->sched_info.run_delay += delta;
 	t->sched_info.last_arrival = now;
 	t->sched_info.pcount++;
@@ -201,10 +196,8 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
  */
 static inline void sched_info_enqueue(struct rq *rq, struct task_struct *t)
 {
-	if (sched_info_on()) {
-		if (!t->sched_info.last_queued)
-			t->sched_info.last_queued = rq_clock(rq);
-	}
+	if (!t->sched_info.last_queued)
+		t->sched_info.last_queued = rq_clock(rq);
 }
 
 /*
@@ -231,7 +224,7 @@ static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
  * the idle task.)  We are only called when prev != next.
  */
 static inline void
-__sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *next)
+sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *next)
 {
 	/*
 	 * prev now departs the CPU.  It's not interesting to record
@@ -245,18 +238,8 @@ __sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct 
 		sched_info_arrive(rq, next);
 }
 
-static inline void
-sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *next)
-{
-	if (sched_info_on())
-		__sched_info_switch(rq, prev, next);
-}
-
 #else /* !CONFIG_SCHED_INFO: */
 # define sched_info_enqueue(rq, t)	do { } while (0)
-# define sched_info_reset_dequeued(t)	do { } while (0)
 # define sched_info_dequeue(rq, t)	do { } while (0)
-# define sched_info_depart(rq, t)	do { } while (0)
-# define sched_info_arrive(rq, next)	do { } while (0)
 # define sched_info_switch(rq, t, next)	do { } while (0)
 #endif /* CONFIG_SCHED_INFO */
