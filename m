Return-Path: <linux-tip-commits+bounces-5498-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CF87AB01D4
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:54:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6101F3ADDF9
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 197FB286D50;
	Thu,  8 May 2025 17:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MypKunLF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CGULwLKz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234F11F5F6;
	Thu,  8 May 2025 17:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746726872; cv=none; b=D9DsRvfsD87NBQvzaudPjvwifpBudvKeMznN9MwVJ6X7C9Ahjg05Dr2c0nR0qmXQUEbYUxzQRRpNBRSWk5/SQ22Iiwrs0QzpdXMqHT92hyhFCKHDWaaqlVcyn5olpcCgd0Xy8pDXPwpPjnflvChBGpqYeHsmlGn70ynsyFwzF1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746726872; c=relaxed/simple;
	bh=B6Fl8YlVm9xie72qhFzxyqEG8MvzE4xMGY5wFFPZnps=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MnQK31y46XGFo2n5QGA+rgpU5chiNQUreP26ddQukatg+goz6FBt8zs743RZ+ryOKhFQ4q91OfWVatzJqyTfEOKuxPeSePJNtIzYKb+jPZiEV0mkrMKqK2fofOeleirrROolpnxHtrZa+/vKGx13IIEWyaTDnRLQVxrgjqTn8Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MypKunLF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CGULwLKz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746726868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M//LZcvHRTaZFvF+pGB9F7G4laCnkslQDqrtHYlxv64=;
	b=MypKunLFAqkWwKokrPzdLnIcmuDAX4au2Lc+8JIbgTTs4lse0uV88Zw7YykULv5np+u+zu
	HXcfzhrv9AQuoGa+zsrAqPYFpZas2bq/Rr92NgNR75qE8djm5jMuOiLGfZZsUm17r4IcOp
	XDaCM//s0GbxerltUlk5RUisMvA3RJzY5F4zHY62Ti2rLebZPX3M/yrDVVNMP9fOadTWlN
	NjpRoMSww4yokJnGb+dFi/RlcP0dN8vqi/bd2DyHyr/3yxO7JdUtXFWBCiOTiybtpZ/qk0
	DuiJ7mdZvJsolLKHWVClepfIf9MRSt6JMqQOacICywfOLoZcFUCS5j7deySmcQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746726868;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M//LZcvHRTaZFvF+pGB9F7G4laCnkslQDqrtHYlxv64=;
	b=CGULwLKzBV2nDJRYS+iba8m3qtm9J9WfyX9sqYvJ3Sqm4z40O8gjW7/MBCWsXW/rg2Eq3y
	sIkj5XM8tEkVinDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] treewide, timers: Rename
 try_to_del_timer_sync() as timer_delete_sync_try()
Cc: Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250507175338.672442-9-mingo@kernel.org>
References: <20250507175338.672442-9-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672686752.406.8724205711474645838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     367ed4e35734d6e7bce1dbca426a5bf150d76905
Gitweb:        https://git.kernel.org/tip/367ed4e35734d6e7bce1dbca426a5bf150d76905
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 07 May 2025 19:53:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 May 2025 19:49:33 +02:00

treewide, timers: Rename try_to_del_timer_sync() as timer_delete_sync_try()

Move this API to the canonical timer_*() namespace.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250507175338.672442-9-mingo@kernel.org

---
 arch/x86/kernel/apic/vector.c           |  2 +-
 drivers/char/random.c                   |  4 ++--
 drivers/irqchip/irq-riscv-imsic-state.c |  2 +-
 include/linux/timer.h                   |  2 +-
 kernel/time/timer.c                     |  6 +++---
 net/bridge/br_multicast.c               | 16 ++++++++--------
 sound/pci/ctxfi/cttimer.c               |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index fee42a7..93069b1 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -864,7 +864,7 @@ void lapic_offline(void)
 	__vector_cleanup(cl, false);
 
 	irq_matrix_offline(vector_matrix);
-	WARN_ON_ONCE(try_to_del_timer_sync(&cl->timer) < 0);
+	WARN_ON_ONCE(timer_delete_sync_try(&cl->timer) < 0);
 	WARN_ON_ONCE(!hlist_empty(&cl->head));
 
 	unlock_vector_lock();
diff --git a/drivers/char/random.c b/drivers/char/random.c
index 38f2fab..4ea4dcc 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -1311,9 +1311,9 @@ static void __cold try_to_generate_entropy(void)
 	while (!crng_ready() && !signal_pending(current)) {
 		/*
 		 * Check !timer_pending() and then ensure that any previous callback has finished
-		 * executing by checking try_to_del_timer_sync(), before queueing the next one.
+		 * executing by checking timer_delete_sync_try(), before queueing the next one.
 		 */
-		if (!timer_pending(&stack->timer) && try_to_del_timer_sync(&stack->timer) >= 0) {
+		if (!timer_pending(&stack->timer) && timer_delete_sync_try(&stack->timer) >= 0) {
 			struct cpumask timer_cpus;
 			unsigned int num_cpus;
 
diff --git a/drivers/irqchip/irq-riscv-imsic-state.c b/drivers/irqchip/irq-riscv-imsic-state.c
index bdf5cd2..c39e573 100644
--- a/drivers/irqchip/irq-riscv-imsic-state.c
+++ b/drivers/irqchip/irq-riscv-imsic-state.c
@@ -564,7 +564,7 @@ void imsic_state_offline(void)
 	struct imsic_local_priv *lpriv = this_cpu_ptr(imsic->lpriv);
 
 	raw_spin_lock_irqsave(&lpriv->lock, flags);
-	WARN_ON_ONCE(try_to_del_timer_sync(&lpriv->timer) < 0);
+	WARN_ON_ONCE(timer_delete_sync_try(&lpriv->timer) < 0);
 	raw_spin_unlock_irqrestore(&lpriv->lock, flags);
 #endif
 }
diff --git a/include/linux/timer.h b/include/linux/timer.h
index 153d07d..5b6ff90 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -162,7 +162,7 @@ extern void add_timer(struct timer_list *timer);
 extern void add_timer_local(struct timer_list *timer);
 extern void add_timer_global(struct timer_list *timer);
 
-extern int try_to_del_timer_sync(struct timer_list *timer);
+extern int timer_delete_sync_try(struct timer_list *timer);
 extern int timer_delete_sync(struct timer_list *timer);
 extern int timer_delete(struct timer_list *timer);
 extern int timer_shutdown_sync(struct timer_list *timer);
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index 012b919..836ba00 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1511,7 +1511,7 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool shutdown)
 }
 
 /**
- * try_to_del_timer_sync - Try to deactivate a timer
+ * timer_delete_sync_try - Try to deactivate a timer
  * @timer:	Timer to deactivate
  *
  * This function tries to deactivate a timer. On success the timer is not
@@ -1526,11 +1526,11 @@ static int __try_to_del_timer_sync(struct timer_list *timer, bool shutdown)
  * * %1  - The timer was pending and deactivated
  * * %-1 - The timer callback function is running on a different CPU
  */
-int try_to_del_timer_sync(struct timer_list *timer)
+int timer_delete_sync_try(struct timer_list *timer)
 {
 	return __try_to_del_timer_sync(timer, false);
 }
-EXPORT_SYMBOL(try_to_del_timer_sync);
+EXPORT_SYMBOL(timer_delete_sync_try);
 
 #ifdef CONFIG_PREEMPT_RT
 static __init void timer_base_init_expiry_lock(struct timer_base *base)
diff --git a/net/bridge/br_multicast.c b/net/bridge/br_multicast.c
index dcbf058..dc331b5 100644
--- a/net/bridge/br_multicast.c
+++ b/net/bridge/br_multicast.c
@@ -2061,7 +2061,7 @@ static void br_multicast_enable(struct bridge_mcast_own_query *query)
 {
 	query->startup_sent = 0;
 
-	if (try_to_del_timer_sync(&query->timer) >= 0 ||
+	if (timer_delete_sync_try(&query->timer) >= 0 ||
 	    timer_delete(&query->timer))
 		mod_timer(&query->timer, jiffies);
 }
@@ -3480,7 +3480,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 	if (mp->host_joined &&
 	    (timer_pending(&mp->timer) ?
 	     time_after(mp->timer.expires, now + max_delay) :
-	     try_to_del_timer_sync(&mp->timer) >= 0))
+	     timer_delete_sync_try(&mp->timer) >= 0))
 		mod_timer(&mp->timer, now + max_delay);
 
 	for (pp = &mp->ports;
@@ -3488,7 +3488,7 @@ static void br_ip4_multicast_query(struct net_bridge_mcast *brmctx,
 	     pp = &p->next) {
 		if (timer_pending(&p->timer) ?
 		    time_after(p->timer.expires, now + max_delay) :
-		    try_to_del_timer_sync(&p->timer) >= 0 &&
+		    timer_delete_sync_try(&p->timer) >= 0 &&
 		    (brmctx->multicast_igmp_version == 2 ||
 		     p->filter_mode == MCAST_EXCLUDE))
 			mod_timer(&p->timer, now + max_delay);
@@ -3569,7 +3569,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 	if (mp->host_joined &&
 	    (timer_pending(&mp->timer) ?
 	     time_after(mp->timer.expires, now + max_delay) :
-	     try_to_del_timer_sync(&mp->timer) >= 0))
+	     timer_delete_sync_try(&mp->timer) >= 0))
 		mod_timer(&mp->timer, now + max_delay);
 
 	for (pp = &mp->ports;
@@ -3577,7 +3577,7 @@ static int br_ip6_multicast_query(struct net_bridge_mcast *brmctx,
 	     pp = &p->next) {
 		if (timer_pending(&p->timer) ?
 		    time_after(p->timer.expires, now + max_delay) :
-		    try_to_del_timer_sync(&p->timer) >= 0 &&
+		    timer_delete_sync_try(&p->timer) >= 0 &&
 		    (brmctx->multicast_mld_version == 1 ||
 		     p->filter_mode == MCAST_EXCLUDE))
 			mod_timer(&p->timer, now + max_delay);
@@ -3649,7 +3649,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 			if (!hlist_unhashed(&p->mglist) &&
 			    (timer_pending(&p->timer) ?
 			     time_after(p->timer.expires, time) :
-			     try_to_del_timer_sync(&p->timer) >= 0)) {
+			     timer_delete_sync_try(&p->timer) >= 0)) {
 				mod_timer(&p->timer, time);
 			}
 
@@ -3665,7 +3665,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 		if (mp->host_joined &&
 		    (timer_pending(&mp->timer) ?
 		     time_after(mp->timer.expires, time) :
-		     try_to_del_timer_sync(&mp->timer) >= 0)) {
+		     timer_delete_sync_try(&mp->timer) >= 0)) {
 			mod_timer(&mp->timer, time);
 		}
 
@@ -3681,7 +3681,7 @@ br_multicast_leave_group(struct net_bridge_mcast *brmctx,
 		if (!hlist_unhashed(&p->mglist) &&
 		    (timer_pending(&p->timer) ?
 		     time_after(p->timer.expires, time) :
-		     try_to_del_timer_sync(&p->timer) >= 0)) {
+		     timer_delete_sync_try(&p->timer) >= 0)) {
 			mod_timer(&p->timer, time);
 		}
 
diff --git a/sound/pci/ctxfi/cttimer.c b/sound/pci/ctxfi/cttimer.c
index 89e47fa..aa17964 100644
--- a/sound/pci/ctxfi/cttimer.c
+++ b/sound/pci/ctxfi/cttimer.c
@@ -119,7 +119,7 @@ static void ct_systimer_stop(struct ct_timer_instance *ti)
 static void ct_systimer_prepare(struct ct_timer_instance *ti)
 {
 	ct_systimer_stop(ti);
-	try_to_del_timer_sync(&ti->timer);
+	timer_delete_sync_try(&ti->timer);
 }
 
 #define ct_systimer_free	ct_systimer_prepare

