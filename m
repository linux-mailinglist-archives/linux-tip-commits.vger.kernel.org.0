Return-Path: <linux-tip-commits+bounces-2086-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FA9F958B08
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 17:21:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 97F651F218E8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 15:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01FD192B9F;
	Tue, 20 Aug 2024 15:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c2AMJYjF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7+cGnqFt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A731922F7;
	Tue, 20 Aug 2024 15:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167271; cv=none; b=MTXmCIlsUw+MSjsn27ImEY7fIszYOPZPDAeV3HI6G8w38D/ABAccduMipZ7H5r0dQcrIizdthoT/3apGuOR8jNE4XPbIq2eec6tR4kPrC4polLKEYkn7/xlxeyZyP6EVDdqIjxlReTuaMNtUmfbwyhMHC+ETDyur+2ko4ySTaCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167271; c=relaxed/simple;
	bh=K0dUhnmPckqH0ZVq6ac8/tglgu6e/Wue1RHL8APmN9g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u1mJwLK5AdbHTR5oiXsrnaAqBOhEPZ1yPHcLXGPTHA1AYeYd99254bpOoaA2s9C6ZXJiNlBvMtFWfWZYjNPbk8jVFw8AsATgst1ZCc68vvFRo/Hr1W3HQUS6IZFF2JF2uk60gsldlHeJVk2evrddC6ypzhTTJDYJm/XvZIao6Hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c2AMJYjF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7+cGnqFt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 15:21:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724167268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5jt4R2ZPZVcQOH9EE+rY3Vy0DokdZ00BfCACZFEEMI=;
	b=c2AMJYjFl89aIlo1qp2Qf7NPf4LTD3DxIJHkAELOm8DhnS+5C07FrOYTK54BYPTzXx5Em9
	brDqEZmATpKEjjqrCPBzSfNodGDBm6Qdw3I+k4yF1RdTDag1GsOJi8KJ5REYWxH+I27p7J
	k+nOR9SH0kla/tmtYOWxN1f7aakHPX+AYTtUJY0ZG7Py+RI2oFVWWJBzFQ5TiftE2u5dB/
	GEnGEcHmg1wmmIvW8s/m/XXcAkzpT/CmVpqNeJ7RhaPuJwgmQsK1QvlUTn7RKg8YJ+2Tcv
	9h+606c3GiYMg9OQvJ6hdRm2Afyhq4seyZURa8x8FBoM45MRhxPnET3vOUkUkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724167268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z5jt4R2ZPZVcQOH9EE+rY3Vy0DokdZ00BfCACZFEEMI=;
	b=7+cGnqFtHtF/16KJuksQKGCvPg1El96IBnOZFBGlyYP6IVfk2qq5zJ4uDz7vRqUqBYIibL
	yAGC0SqH8GAWMnBw==
From: "tip-bot2 for Caleb Sander Mateos" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Remove unused 'action' parameter from action
 callback
Cc: Caleb Sander Mateos <csander@purestorage.com>,
 Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240815171549.3260003-1-csander@purestorage.com>
References: <20240815171549.3260003-1-csander@purestorage.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172416726767.2215.4629047475825330120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e68ac2b488495fa4d127d6105ce633849859957a
Gitweb:        https://git.kernel.org/tip/e68ac2b488495fa4d127d6105ce633849859957a
Author:        Caleb Sander Mateos <csander@purestorage.com>
AuthorDate:    Thu, 15 Aug 2024 11:15:40 -06:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2024 17:13:40 +02:00

softirq: Remove unused 'action' parameter from action callback

When soft interrupt actions are called, they are passed a pointer to the
struct softirq action which contains the action's function pointer.

This pointer isn't useful, as the action callback already knows what
function it is. And since each callback handles a specific soft interrupt,
the callback also knows which soft interrupt number is running.

No soft interrupt action callback actually uses this parameter, so remove
it from the function pointer signature. This clarifies that soft interrupt
actions are global routines and makes it slightly cheaper to call them.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Link: https://lore.kernel.org/all/20240815171549.3260003-1-csander@purestorage.com
---
 block/blk-mq.c            |  2 +-
 include/linux/interrupt.h |  4 ++--
 kernel/rcu/tiny.c         |  2 +-
 kernel/rcu/tree.c         |  2 +-
 kernel/sched/fair.c       |  2 +-
 kernel/softirq.c          | 15 +++++++--------
 kernel/time/hrtimer.c     |  2 +-
 kernel/time/timer.c       |  2 +-
 lib/irq_poll.c            |  2 +-
 net/core/dev.c            |  4 ++--
 10 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index e3c3c0c..aa28157 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1128,7 +1128,7 @@ static void blk_complete_reqs(struct llist_head *list)
 		rq->q->mq_ops->complete(rq);
 }
 
-static __latent_entropy void blk_done_softirq(struct softirq_action *h)
+static __latent_entropy void blk_done_softirq(void)
 {
 	blk_complete_reqs(this_cpu_ptr(&blk_cpu_done));
 }
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3f30c88..694de61 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -594,7 +594,7 @@ extern const char * const softirq_to_name[NR_SOFTIRQS];
 
 struct softirq_action
 {
-	void	(*action)(struct softirq_action *);
+	void	(*action)(void);
 };
 
 asmlinkage void do_softirq(void);
@@ -609,7 +609,7 @@ static inline void do_softirq_post_smp_call_flush(unsigned int unused)
 }
 #endif
 
-extern void open_softirq(int nr, void (*action)(struct softirq_action *));
+extern void open_softirq(int nr, void (*action)(void));
 extern void softirq_init(void);
 extern void __raise_softirq_irqoff(unsigned int nr);
 
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index 4402d6f..b3b3ce3 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -105,7 +105,7 @@ static inline bool rcu_reclaim_tiny(struct rcu_head *head)
 }
 
 /* Invoke the RCU callbacks whose grace period has elapsed.  */
-static __latent_entropy void rcu_process_callbacks(struct softirq_action *unused)
+static __latent_entropy void rcu_process_callbacks(void)
 {
 	struct rcu_head *next, *list;
 	unsigned long flags;
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e641cc6..93bd665 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2855,7 +2855,7 @@ static __latent_entropy void rcu_core(void)
 		queue_work_on(rdp->cpu, rcu_gp_wq, &rdp->strict_work);
 }
 
-static void rcu_core_si(struct softirq_action *h)
+static void rcu_core_si(void)
 {
 	rcu_core();
 }
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9057584..8dc9385 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12483,7 +12483,7 @@ out:
  * - indirectly from a remote scheduler_tick() for NOHZ idle balancing
  *   through the SMP cross-call nohz_csd_func()
  */
-static __latent_entropy void sched_balance_softirq(struct softirq_action *h)
+static __latent_entropy void sched_balance_softirq(void)
 {
 	struct rq *this_rq = this_rq();
 	enum cpu_idle_type idle = this_rq->idle_balance;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 0258201..d082e78 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -551,7 +551,7 @@ restart:
 		kstat_incr_softirqs_this_cpu(vec_nr);
 
 		trace_softirq_entry(vec_nr);
-		h->action(h);
+		h->action();
 		trace_softirq_exit(vec_nr);
 		if (unlikely(prev_count != preempt_count())) {
 			pr_err("huh, entered softirq %u %s %p with preempt_count %08x, exited with %08x?\n",
@@ -700,7 +700,7 @@ void __raise_softirq_irqoff(unsigned int nr)
 	or_softirq_pending(1UL << nr);
 }
 
-void open_softirq(int nr, void (*action)(struct softirq_action *))
+void open_softirq(int nr, void (*action)(void))
 {
 	softirq_vec[nr].action = action;
 }
@@ -760,8 +760,7 @@ static bool tasklet_clear_sched(struct tasklet_struct *t)
 	return false;
 }
 
-static void tasklet_action_common(struct softirq_action *a,
-				  struct tasklet_head *tl_head,
+static void tasklet_action_common(struct tasklet_head *tl_head,
 				  unsigned int softirq_nr)
 {
 	struct tasklet_struct *list;
@@ -805,16 +804,16 @@ static void tasklet_action_common(struct softirq_action *a,
 	}
 }
 
-static __latent_entropy void tasklet_action(struct softirq_action *a)
+static __latent_entropy void tasklet_action(void)
 {
 	workqueue_softirq_action(false);
-	tasklet_action_common(a, this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
+	tasklet_action_common(this_cpu_ptr(&tasklet_vec), TASKLET_SOFTIRQ);
 }
 
-static __latent_entropy void tasklet_hi_action(struct softirq_action *a)
+static __latent_entropy void tasklet_hi_action(void)
 {
 	workqueue_softirq_action(true);
-	tasklet_action_common(a, this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
+	tasklet_action_common(this_cpu_ptr(&tasklet_hi_vec), HI_SOFTIRQ);
 }
 
 void tasklet_setup(struct tasklet_struct *t,
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index b8ee320..836157e 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1757,7 +1757,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_base *cpu_base, ktime_t now,
 	}
 }
 
-static __latent_entropy void hrtimer_run_softirq(struct softirq_action *h)
+static __latent_entropy void hrtimer_run_softirq(void)
 {
 	struct hrtimer_cpu_base *cpu_base = this_cpu_ptr(&hrtimer_bases);
 	unsigned long flags;
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 64b0d8a..760bbeb 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -2440,7 +2440,7 @@ static void run_timer_base(int index)
 /*
  * This function runs timers and the timer-tq in bottom half context.
  */
-static __latent_entropy void run_timer_softirq(struct softirq_action *h)
+static __latent_entropy void run_timer_softirq(void)
 {
 	run_timer_base(BASE_LOCAL);
 	if (IS_ENABLED(CONFIG_NO_HZ_COMMON)) {
diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 2d5329a..08b242b 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -75,7 +75,7 @@ void irq_poll_complete(struct irq_poll *iop)
 }
 EXPORT_SYMBOL(irq_poll_complete);
 
-static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
+static void __latent_entropy irq_poll_softirq(void)
 {
 	struct list_head *list = this_cpu_ptr(&blk_cpu_iopoll);
 	int rearm = 0, budget = irq_poll_budget;
diff --git a/net/core/dev.c b/net/core/dev.c
index 6ea1d20..e24a3bc 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -5247,7 +5247,7 @@ int netif_rx(struct sk_buff *skb)
 }
 EXPORT_SYMBOL(netif_rx);
 
-static __latent_entropy void net_tx_action(struct softirq_action *h)
+static __latent_entropy void net_tx_action(void)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 
@@ -6920,7 +6920,7 @@ static int napi_threaded_poll(void *data)
 	return 0;
 }
 
-static __latent_entropy void net_rx_action(struct softirq_action *h)
+static __latent_entropy void net_rx_action(void)
 {
 	struct softnet_data *sd = this_cpu_ptr(&softnet_data);
 	unsigned long time_limit = jiffies +

