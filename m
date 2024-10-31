Return-Path: <linux-tip-commits+bounces-2672-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B91319B7803
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:52:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCE181C20F28
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 09:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81A3719B5B4;
	Thu, 31 Oct 2024 09:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2K7xgdU/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fkLMGuYS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76DB199FA9;
	Thu, 31 Oct 2024 09:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730368283; cv=none; b=dK1YGKLNKwMSEdclQy7K4e0AaXF2w0O5No7aVbeU0f1fc3pOXNRHfYkwjI1dpt2nVexa8EinO+d0JrGrHzv/HX/LcygpMWLiaoZnQplHl2fmT+ykFCUi7d3/XJdmqjtLMF9sDDT5dLHwYpe+aL3jXMqtqVop52zrMcB4iyKnHvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730368283; c=relaxed/simple;
	bh=fh1IOeuLRcFGo08qjSdL/HZeKGj7yXjT5Jnie3PWQI8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cq1SPz1ove7W8cyvL6CxZFXxRnZ+sQ88fs3kVxkIfI9jqV6J/Ne91GHZCzQtMC/Qf+XQ6ItuIljziFfaJqjjjII1ZchKTEvoIi/F2/aiN+gihrPNKOFANe7aUyBSmJOrAcFwCeYpo79uW0abEz5c2b0kuLlE/TTeIIepWz/kTEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2K7xgdU/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fkLMGuYS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 09:51:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730368279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMSeuzr36+tOI4/8VoYNXcZeeNYoMNp0IVbJTofxo4k=;
	b=2K7xgdU/0KzkPje3zltneh4Wo/UO87hq+CCO30YPkoLDY3D26uDz/XcbtaRHPA3kr4PyNe
	BubvlAmB/Kwaw5Lh6VaNkZJcVQ2JpsrdXbqfU8eIHxFr+wFW/cJmFrh0cg+jQrYkWTOPN4
	MiIGvRWmPgfAvbuFV9r55RGZUE8Zm/ZCaA7Uo7sIbn2cTKcCQhrRFban6KA6aN/s/hNDxS
	iLeH4YshqLojWZaEyT0JVC1rk9hLwNbM3BfH2/hT1AWk+cTOaunYaYIcOHN9JDHM5xbP0v
	SDOhJlBKYlPt9leKNOaDVF5VmMByNH9hj7A+nn8TL2IsQTjkpughJTsw9gjOSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730368279;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NMSeuzr36+tOI4/8VoYNXcZeeNYoMNp0IVbJTofxo4k=;
	b=fkLMGuYSnRAPBv5aNAnbX5cwmosPp8NcAZJoA8TRW97lpq94sLcChKtTnzKe33UPlEwVHG
	Tv4Qn+s7QbwVojBw==
From: "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clockevents: Shutdown and unregister current
 clockevents at CPUHP_AP_TICK_DYING
Cc: Frederic Weisbecker <frederic@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241029125451.54574-3-frederic@kernel.org>
References: <20241029125451.54574-3-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036827829.3137.8759719285757556850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3b1596a21fbf210f5b763fd3c0be280650475b52
Gitweb:        https://git.kernel.org/tip/3b1596a21fbf210f5b763fd3c0be280650475b52
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 29 Oct 2024 13:54:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 31 Oct 2024 10:41:42 +01:00

clockevents: Shutdown and unregister current clockevents at CPUHP_AP_TICK_DYING

The way the clockevent devices are finally stopped while a CPU is
offlining is currently chaotic. The layout being by order:

1) tick_sched_timer_dying() stops the tick and the underlying clockevent
  but only for oneshot case. The periodic tick and its related
  clockevent still runs.

2) tick_broadcast_offline() detaches and stops the per-cpu oneshot
  broadcast and append it to the released list.

3) Some individual clockevent drivers stop the clockevents (a second time if
  the tick is oneshot)

4) Once the CPU is dead, a control CPU remotely detaches and stops
  (a 3rd time if oneshot mode) the CPU clockevent and adds it to the
  released list.

5) The released list containing the broadcast device released on step 2)
   and the remotely detached clockevent from step 4) are unregistered.

These random events can be factorized if the current clockevent is
detached and stopped by the dying CPU at the generic layer, that is
from the dying CPU:

a) Stop the tick
b) Stop/detach the underlying per-cpu oneshot broadcast clockevent
c) Stop/detach the underlying clockevent
d) Release / unregister the clockevents from b) and c)
e) Release / unregister the remaining clockevents from the dying CPU.
   This part could be performed by the dying CPU

This way the drivers and the tick layer don't need to care about
clockevent operations during cpuhotplug down. This also unifies the tick
behaviour on offline CPUs between oneshot and periodic modes, avoiding
offline ticks altogether for sanity.

Adopt the simplification.

[ tglx: Remove the WARN_ON() in clockevents_register_device() as that
  	is called from an upcoming CPU before the CPU is marked online ]

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241029125451.54574-3-frederic@kernel.org

---
 include/linux/tick.h        |  2 --
 kernel/cpu.c                |  2 --
 kernel/time/clockevents.c   | 30 +++++++++++-------------------
 kernel/time/tick-internal.h |  3 +--
 4 files changed, 12 insertions(+), 25 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 7274463..b0c74bf 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -20,12 +20,10 @@ extern void __init tick_init(void);
 extern void tick_suspend_local(void);
 /* Should be core only, but XEN resume magic and ARM BL switcher require it */
 extern void tick_resume_local(void);
-extern void tick_cleanup_dead_cpu(int cpu);
 #else /* CONFIG_GENERIC_CLOCKEVENTS */
 static inline void tick_init(void) { }
 static inline void tick_suspend_local(void) { }
 static inline void tick_resume_local(void) { }
-static inline void tick_cleanup_dead_cpu(int cpu) { }
 #endif /* !CONFIG_GENERIC_CLOCKEVENTS */
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS) && defined(CONFIG_HOTPLUG_CPU)
diff --git a/kernel/cpu.c b/kernel/cpu.c
index d293d52..895f328 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -1338,8 +1338,6 @@ static int takedown_cpu(unsigned int cpu)
 
 	cpuhp_bp_sync_dead(cpu);
 
-	tick_cleanup_dead_cpu(cpu);
-
 	/*
 	 * Callbacks must be re-integrated right away to the RCU state machine.
 	 * Otherwise an RCU callback could block a further teardown function
diff --git a/kernel/time/clockevents.c b/kernel/time/clockevents.c
index 4af2799..f3e831f 100644
--- a/kernel/time/clockevents.c
+++ b/kernel/time/clockevents.c
@@ -618,39 +618,30 @@ void clockevents_resume(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
-# ifdef CONFIG_GENERIC_CLOCKEVENTS_BROADCAST
 /**
- * tick_offline_cpu - Take CPU out of the broadcast mechanism
+ * tick_offline_cpu - Shutdown all clock events related
+ *                    to this CPU and take it out of the
+ *                    broadcast mechanism.
  * @cpu:	The outgoing CPU
  *
- * Called on the outgoing CPU after it took itself offline.
+ * Called by the dying CPU during teardown.
  */
 void tick_offline_cpu(unsigned int cpu)
 {
-	raw_spin_lock(&clockevents_lock);
-	tick_broadcast_offline(cpu);
-	raw_spin_unlock(&clockevents_lock);
-}
-# endif
-
-/**
- * tick_cleanup_dead_cpu - Cleanup the tick and clockevents of a dead cpu
- * @cpu:	The dead CPU
- */
-void tick_cleanup_dead_cpu(int cpu)
-{
 	struct clock_event_device *dev, *tmp;
-	unsigned long flags;
 
-	raw_spin_lock_irqsave(&clockevents_lock, flags);
+	raw_spin_lock(&clockevents_lock);
 
+	tick_broadcast_offline(cpu);
 	tick_shutdown(cpu);
+
 	/*
 	 * Unregister the clock event devices which were
-	 * released from the users in the notify chain.
+	 * released above.
 	 */
 	list_for_each_entry_safe(dev, tmp, &clockevents_released, list)
 		list_del(&dev->list);
+
 	/*
 	 * Now check whether the CPU has left unused per cpu devices
 	 */
@@ -662,7 +653,8 @@ void tick_cleanup_dead_cpu(int cpu)
 			list_del(&dev->list);
 		}
 	}
-	raw_spin_unlock_irqrestore(&clockevents_lock, flags);
+
+	raw_spin_unlock(&clockevents_lock);
 }
 #endif
 
diff --git a/kernel/time/tick-internal.h b/kernel/time/tick-internal.h
index 5f2105e..faac36d 100644
--- a/kernel/time/tick-internal.h
+++ b/kernel/time/tick-internal.h
@@ -25,6 +25,7 @@ extern int tick_do_timer_cpu __read_mostly;
 extern void tick_setup_periodic(struct clock_event_device *dev, int broadcast);
 extern void tick_handle_periodic(struct clock_event_device *dev);
 extern void tick_check_new_device(struct clock_event_device *dev);
+extern void tick_offline_cpu(unsigned int cpu);
 extern void tick_shutdown(unsigned int cpu);
 extern void tick_suspend(void);
 extern void tick_resume(void);
@@ -142,10 +143,8 @@ static inline bool tick_broadcast_oneshot_available(void) { return tick_oneshot_
 #endif /* !(BROADCAST && ONESHOT) */
 
 #if defined(CONFIG_GENERIC_CLOCKEVENTS_BROADCAST) && defined(CONFIG_HOTPLUG_CPU)
-extern void tick_offline_cpu(unsigned int cpu);
 extern void tick_broadcast_offline(unsigned int cpu);
 #else
-static inline void tick_offline_cpu(unsigned int cpu) { }
 static inline void tick_broadcast_offline(unsigned int cpu) { }
 #endif
 

