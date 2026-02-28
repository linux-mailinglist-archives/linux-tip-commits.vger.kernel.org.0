Return-Path: <linux-tip-commits+bounces-8297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aFe3FYcMo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8297-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:40:55 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE9291C40BB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:40:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 45060318332A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAC147DD4C;
	Sat, 28 Feb 2026 15:36:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="maDJ5z3a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8baPlk7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C809C47CC81;
	Sat, 28 Feb 2026 15:36:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292987; cv=none; b=kmewgeOgy+YGhDTxjTErX+RDHznT6l8oEdQsiRrMYRcuIWn37X3hYsIcfDiSC7ASffL4aiXUH22mDIhz5U0fqJ8Aja35ZxnImDmOC1o35I8vFswTZ/B/jNni8/1xRl4J0gITjSfk9l9StT1txu7BZ6elf3q/kFBQyzaKpp7pJnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292987; c=relaxed/simple;
	bh=hfhRPHLPmBozTxjyOT0SZbnUzLHvkw+vCqpL29qb30M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ez5nYHD7MQMf4bVMw7tMZNMGU3M8oil588TH0xlDQggX/B2h1J1x+WhrrGzXRhpZ/DgMFNyshV9sMaTgq/wfSbKsTXMNldjJomLR5Ugr2Z+GUOqEn9op84rEbxC54R2+6z8zcLmZNjbHJQZuxUtZtCyz6/93iummL0arjJ423us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=maDJ5z3a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8baPlk7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292984;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOIDPmcMtFpu573IR5WMDenAhj3JuymQZlIQwVH17+w=;
	b=maDJ5z3ac5FkTWHsBDvsclsG5dPLCTJIhi5EKi3KYLSJZXmz9fXl41s3Ukx6Wj62QFP9nR
	kfoE3cSzp46sjcwiS3eDFm2NEPS3B9RbSirm9EHkd7ub+9EAh0n0mz1wLcBT+cJqaETuYV
	5HcgwVjLcgW2fDN7HETqxeg5hZk2EcZ/wJjZ+RM8AgQw6QWnTHprDKBaJyKBpKuNTi9Did
	ZD2YmkBY976BGOEzoklHApF51v7++JUrLUV5vfawxAOseb+FlXjDsisbshkbXafz2gWtix
	CNVdtaWBYhKjerw6cqCRDSKj3ngCnFZke/3yh3WUrVbMjCivIO59kdfsHWYkQg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292984;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mOIDPmcMtFpu573IR5WMDenAhj3JuymQZlIQwVH17+w=;
	b=y8baPlk7DPrUK50K9POCNSECD3iL5FskeUZ/JyQocSCDUr8ZXmSuFU8/1cGF+qfm2erch7
	2yxoyxqbqPsKJHCA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] hrtimer: Push reprogramming timers into the
 interrupt return path
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.273488269@kernel.org>
References: <20260224163431.273488269@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298305.1647592.12341379144974877623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8297-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,infradead.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: DE9291C40BB
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     15dd3a9488557d3e6ebcecacab79f4e56b69ab54
Gitweb:        https://git.kernel.org/tip/15dd3a9488557d3e6ebcecacab79f4e56b6=
9ab54
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:14 +01:00

hrtimer: Push reprogramming timers into the interrupt return path

Currently hrtimer_interrupt() runs expired timers, which can re-arm
themselves, after which it computes the next expiration time and
re-programs the hardware.

However, things like HRTICK, a highres timer driving preemption, cannot
re-arm itself at the point of running, since the next task has not been
determined yet. The schedule() in the interrupt return path will switch to
the next task, which then causes a new hrtimer to be programmed.

This then results in reprogramming the hardware at least twice, once after
running the timers, and once upon selecting the new task.

Notably, *both* events happen in the interrupt.

By pushing the hrtimer reprogram all the way into the interrupt return
path, it runs after schedule() picks the new task and the double reprogram
can be avoided.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.273488269@kernel.org
---
 include/asm-generic/thread_info_tif.h |  5 +-
 include/linux/hrtimer_rearm.h         | 72 ++++++++++++++++++++++++--
 kernel/time/Kconfig                   |  4 +-
 kernel/time/hrtimer.c                 | 38 ++++++++++++--
 4 files changed, 107 insertions(+), 12 deletions(-)

diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thre=
ad_info_tif.h
index da1610a..528e6fc 100644
--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -41,11 +41,14 @@
 #define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
=20
 #ifdef HAVE_TIF_RESTORE_SIGMASK
-# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal() */
+# define TIF_RESTORE_SIGMASK	10	// Restore signal mask in do_signal()
 # define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #endif
=20
 #define TIF_RSEQ		11	// Run RSEQ fast path
 #define _TIF_RSEQ		BIT(TIF_RSEQ)
=20
+#define TIF_HRTIMER_REARM	12       // re-arm the timer
+#define _TIF_HRTIMER_REARM	BIT(TIF_HRTIMER_REARM)
+
 #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
diff --git a/include/linux/hrtimer_rearm.h b/include/linux/hrtimer_rearm.h
index 6293076..a6f2e5d 100644
--- a/include/linux/hrtimer_rearm.h
+++ b/include/linux/hrtimer_rearm.h
@@ -3,12 +3,74 @@
 #define _LINUX_HRTIMER_REARM_H
=20
 #ifdef CONFIG_HRTIMER_REARM_DEFERRED
-static __always_inline void __hrtimer_rearm_deferred(void) { }
-static __always_inline void hrtimer_rearm_deferred(void) { }
-static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_wor=
k) { }
+#include <linux/thread_info.h>
+
+void __hrtimer_rearm_deferred(void);
+
+/*
+ * This is purely CPU local, so check the TIF bit first to avoid the overhea=
d of
+ * the atomic test_and_clear_bit() operation for the common case where the b=
it
+ * is not set.
+ */
+static __always_inline bool hrtimer_test_and_clear_rearm_deferred_tif(unsign=
ed long tif_work)
+{
+	lockdep_assert_irqs_disabled();
+
+	if (unlikely(tif_work & _TIF_HRTIMER_REARM)) {
+		clear_thread_flag(TIF_HRTIMER_REARM);
+		return true;
+	}
+	return false;
+}
+
+#define TIF_REARM_MASK	(_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY | _TIF_HR=
TIMER_REARM)
+
+/* Invoked from the exit to user before invoking exit_to_user_mode_loop() */
 static __always_inline bool
-hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long=
 tif_mask) { return false; }
-static __always_inline bool hrtimer_test_and_clear_rearm_deferred(void) { re=
turn false; }
+hrtimer_rearm_deferred_user_irq(unsigned long *tif_work, const unsigned long=
 tif_mask)
+{
+	/* Help the compiler to optimize the function out for syscall returns */
+	if (!(tif_mask & _TIF_HRTIMER_REARM))
+		return false;
+	/*
+	 * Rearm the timer if none of the resched flags is set before going into
+	 * the loop which re-enables interrupts.
+	 */
+	if (unlikely((*tif_work & TIF_REARM_MASK) =3D=3D _TIF_HRTIMER_REARM)) {
+		clear_thread_flag(TIF_HRTIMER_REARM);
+		__hrtimer_rearm_deferred();
+		/* Don't go into the loop if HRTIMER_REARM was the only flag */
+		*tif_work &=3D ~TIF_HRTIMER_REARM;
+		return !*tif_work;
+	}
+	return false;
+}
+
+/* Invoked from the time slice extension decision function */
+static __always_inline void hrtimer_rearm_deferred_tif(unsigned long tif_wor=
k)
+{
+	if (hrtimer_test_and_clear_rearm_deferred_tif(tif_work))
+		__hrtimer_rearm_deferred();
+}
+
+/*
+ * This is to be called on all irqentry_exit() paths that will enable
+ * interrupts.
+ */
+static __always_inline void hrtimer_rearm_deferred(void)
+{
+	hrtimer_rearm_deferred_tif(read_thread_flags());
+}
+
+/*
+ * Invoked from the scheduler on entry to __schedule() so it can defer
+ * rearming after the load balancing callbacks which might change hrtick.
+ */
+static __always_inline bool hrtimer_test_and_clear_rearm_deferred(void)
+{
+	return hrtimer_test_and_clear_rearm_deferred_tif(read_thread_flags());
+}
+
 #else  /* CONFIG_HRTIMER_REARM_DEFERRED */
 static __always_inline void __hrtimer_rearm_deferred(void) { }
 static __always_inline void hrtimer_rearm_deferred(void) { }
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index b95bfee..6d6aace 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -60,7 +60,9 @@ config GENERIC_CMOS_UPDATE
=20
 # Deferred rearming of the hrtimer interrupt
 config HRTIMER_REARM_DEFERRED
-       def_bool n
+       def_bool y
+       depends on GENERIC_ENTRY && HAVE_GENERIC_TIF_BITS
+       depends on HIGH_RES_TIMERS && SCHED_HRTICK
=20
 # Select to handle posix CPU timers from task_work
 # and not from the timer interrupt context
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 6f05d25..2e5f0e2 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1939,10 +1939,9 @@ static __latent_entropy void hrtimer_run_softirq(void)
  * Very similar to hrtimer_force_reprogram(), except it deals with
  * deferred_rearm and hang_detected.
  */
-static void hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now)
+static void hrtimer_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now,
+			  ktime_t expires_next, bool deferred)
 {
-	ktime_t expires_next =3D hrtimer_update_next_event(cpu_base);
-
 	cpu_base->expires_next =3D expires_next;
 	cpu_base->deferred_rearm =3D false;
=20
@@ -1954,9 +1953,37 @@ static void hrtimer_rearm(struct hrtimer_cpu_base *cpu=
_base, ktime_t now)
 		expires_next =3D ktime_add_ns(now, 100 * NSEC_PER_MSEC);
 		cpu_base->hang_detected =3D false;
 	}
-	hrtimer_rearm_event(expires_next, false);
+	hrtimer_rearm_event(expires_next, deferred);
+}
+
+#ifdef CONFIG_HRTIMER_REARM_DEFERRED
+void __hrtimer_rearm_deferred(void)
+{
+	struct hrtimer_cpu_base *cpu_base =3D this_cpu_ptr(&hrtimer_bases);
+	ktime_t now, expires_next;
+
+	if (!cpu_base->deferred_rearm)
+		return;
+
+	guard(raw_spinlock)(&cpu_base->lock);
+	now =3D hrtimer_update_base(cpu_base);
+	expires_next =3D hrtimer_update_next_event(cpu_base);
+	hrtimer_rearm(cpu_base, now, expires_next, true);
 }
=20
+static __always_inline void
+hrtimer_interrupt_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now, ktim=
e_t expires_next)
+{
+	set_thread_flag(TIF_HRTIMER_REARM);
+}
+#else  /* CONFIG_HRTIMER_REARM_DEFERRED */
+static __always_inline void
+hrtimer_interrupt_rearm(struct hrtimer_cpu_base *cpu_base, ktime_t now, ktim=
e_t expires_next)
+{
+	hrtimer_rearm(cpu_base, now, expires_next, false);
+}
+#endif  /* !CONFIG_HRTIMER_REARM_DEFERRED */
+
 /*
  * High resolution timer interrupt
  * Called with interrupts disabled
@@ -2014,9 +2041,10 @@ retry:
 		cpu_base->hang_detected =3D true;
 	}
=20
-	hrtimer_rearm(cpu_base, now);
+	hrtimer_interrupt_rearm(cpu_base, now, expires_next);
 	raw_spin_unlock_irqrestore(&cpu_base->lock, flags);
 }
+
 #endif /* !CONFIG_HIGH_RES_TIMERS */
=20
 /*

