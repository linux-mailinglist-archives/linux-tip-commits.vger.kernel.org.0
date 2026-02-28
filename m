Return-Path: <linux-tip-commits+bounces-8299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aBHtBxwMo2nY9AQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:39:08 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD9C1C4085
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 16:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id ED5AD306E052
	for <lists+linux-tip-commits@lfdr.de>; Sat, 28 Feb 2026 15:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5E4347DD6B;
	Sat, 28 Feb 2026 15:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N1sfPPOH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sf00eqLX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3460F47D93A;
	Sat, 28 Feb 2026 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772292990; cv=none; b=aom4J4EQk6njGzNkF4ViVUORTVyHkvVXCKscXB+Noih2jVagyCXeM9SeUexIC8AEhd27eFJdA84sDpWTM6+NOxUV34T7495i0J/2gBCPGcPeGBadQ1QObB48P1z0pJBq/69PlODFNIxipw1l5RlmJACSUDYUiRw28jzOgxyPvfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772292990; c=relaxed/simple;
	bh=Iqx/bHUiMC9fZQNvuLXUxFXAs6iSuwvXZ/LKNCtSwV8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aS1kMKKGv9jiunH74iNrD3XlvCMY+8VQ+wPUfViCtjdEBVPSBILhLLgRyvvzr/Gl4bMZlYxZc20FvMJnGO4VI39IPlXoyOPEzGB0jIyK6MfRtGRWn2IH/foh6uW+oqO74mcy/OhykXVcct87vzSzX2wuK92VC6E16o4KnNifHUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N1sfPPOH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sf00eqLX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 28 Feb 2026 15:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1772292987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVOjidmyHPnmMT77PTfONRfkVOC6DogunErom/ogiWM=;
	b=N1sfPPOH6MAJU0pHgu8pTuM967sgQiouUlmCPpmnG/tDvqncX6i0xq7Mtw8IRiNIUegCTZ
	BAoeHcfPkgtZtRwWJnNUXPeEld7UIcNxYCOdUx7ogLG61wMgmPeddLCyhJOM8nAgGEPlfi
	LMvHcV7rnvFNgcVfU08gjr7adVXY0Ui46ZehioqEz06Qfw6vu6sqmxKWMQtPL2TnKokd2q
	hV8CF+NcFT0D5DGzG5ebvxs9XSaOihwtvtu9bn3qiZSAL4So1G05LaLgPuwZty6+y3Imej
	D4kMybBD7ds+PpogNA+QLoqLkU7TIuoRow7cM4GV6AwwNao7RVxpDKPIfr8ZVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1772292987;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jVOjidmyHPnmMT77PTfONRfkVOC6DogunErom/ogiWM=;
	b=sf00eqLX3QRjut4XXVw/UtTYNaPAuLVzFuVHV3kvBvNEdk0gW5pQ634Niw1oavh46JVr7Z
	EtvCte7MgDm10nBw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/hrtick] entry: Prepare for deferred hrtimer rearming
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Gleixner <tglx@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260224163431.066469985@kernel.org>
References: <20260224163431.066469985@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177229298631.1647592.5011781251200490806.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8299-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url,infradead.org:email];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 2BD9C1C4085
X-Rspamd-Action: no action

The following commit has been merged into the sched/hrtick branch of tip:

Commit-ID:     0e98eb14814ef669e07ca6effaa03df2e57ef956
Gitweb:        https://git.kernel.org/tip/0e98eb14814ef669e07ca6effaa03df2e57=
ef956
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 24 Feb 2026 17:38:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 27 Feb 2026 16:40:13 +01:00

entry: Prepare for deferred hrtimer rearming

The hrtimer interrupt expires timers and at the end of the interrupt it
rearms the clockevent device for the next expiring timer.

That's obviously correct, but in the case that a expired timer sets
NEED_RESCHED the return from interrupt ends up in schedule(). If HRTICK is
enabled then schedule() will modify the hrtick timer, which causes another
reprogramming of the hardware.

That can be avoided by deferring the rearming to the return from interrupt
path and if the return results in a immediate schedule() invocation then it
can be deferred until the end of schedule(), which avoids multiple rearms
and re-evaluation of the timer wheel.

As this is only relevant for interrupt to user return split the work masks
up and hand them in as arguments from the relevant exit to user functions,
which allows the compiler to optimize the deferred handling out for the
syscall exit to user case.

Add the rearm checks to the approritate places in the exit to user loop and
the interrupt return to kernel path, so that the rearming is always
guaranteed.

In the return to user space path this is handled in the same way as
TIF_RSEQ to avoid extra instructions in the fast path, which are truly
hurtful for device interrupt heavy work loads as the extra instructions and
conditionals while benign at first sight accumulate quickly into measurable
regressions. The return from syscall path is completely unaffected due to
the above mentioned split so syscall heavy workloads wont have any extra
burden.

For now this is just placing empty stubs at the right places which are all
optimized out by the compiler until the actual functionality is in place.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20260224163431.066469985@kernel.org
---
 include/linux/irq-entry-common.h | 25 +++++++++++++++++++------
 include/linux/rseq_entry.h       | 16 +++++++++++++---
 kernel/entry/common.c            |  4 +++-
 3 files changed, 35 insertions(+), 10 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index d26d1b1..b976946 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -3,6 +3,7 @@
 #define __LINUX_IRQENTRYCOMMON_H
=20
 #include <linux/context_tracking.h>
+#include <linux/hrtimer_rearm.h>
 #include <linux/kmsan.h>
 #include <linux/rseq_entry.h>
 #include <linux/static_call_types.h>
@@ -33,6 +34,14 @@
 	 _TIF_PATCH_PENDING | _TIF_NOTIFY_SIGNAL | _TIF_RSEQ |		\
 	 ARCH_EXIT_TO_USER_MODE_WORK)
=20
+#ifdef CONFIG_HRTIMER_REARM_DEFERRED
+# define EXIT_TO_USER_MODE_WORK_SYSCALL	(EXIT_TO_USER_MODE_WORK)
+# define EXIT_TO_USER_MODE_WORK_IRQ	(EXIT_TO_USER_MODE_WORK | _TIF_HRTIMER_R=
EARM)
+#else
+# define EXIT_TO_USER_MODE_WORK_SYSCALL	(EXIT_TO_USER_MODE_WORK)
+# define EXIT_TO_USER_MODE_WORK_IRQ	(EXIT_TO_USER_MODE_WORK)
+#endif
+
 /**
  * arch_enter_from_user_mode - Architecture specific sanity check for user m=
ode regs
  * @regs:	Pointer to currents pt_regs
@@ -203,6 +212,7 @@ unsigned long exit_to_user_mode_loop(struct pt_regs *regs=
, unsigned long ti_work
 /**
  * __exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
  * @regs:	Pointer to pt_regs on entry stack
+ * @work_mask:	Which TIF bits need to be evaluated
  *
  * 1) check that interrupts are disabled
  * 2) call tick_nohz_user_enter_prepare()
@@ -212,7 +222,8 @@ unsigned long exit_to_user_mode_loop(struct pt_regs *regs=
, unsigned long ti_work
  *
  * Don't invoke directly, use the syscall/irqentry_ prefixed variants below
  */
-static __always_inline void __exit_to_user_mode_prepare(struct pt_regs *regs)
+static __always_inline void __exit_to_user_mode_prepare(struct pt_regs *regs,
+							const unsigned long work_mask)
 {
 	unsigned long ti_work;
=20
@@ -222,8 +233,10 @@ static __always_inline void __exit_to_user_mode_prepare(=
struct pt_regs *regs)
 	tick_nohz_user_enter_prepare();
=20
 	ti_work =3D read_thread_flags();
-	if (unlikely(ti_work & EXIT_TO_USER_MODE_WORK))
-		ti_work =3D exit_to_user_mode_loop(regs, ti_work);
+	if (unlikely(ti_work & work_mask)) {
+		if (!hrtimer_rearm_deferred_user_irq(&ti_work, work_mask))
+			ti_work =3D exit_to_user_mode_loop(regs, ti_work);
+	}
=20
 	arch_exit_to_user_mode_prepare(regs, ti_work);
 }
@@ -239,7 +252,7 @@ static __always_inline void __exit_to_user_mode_validate(=
void)
 /* Temporary workaround to keep ARM64 alive */
 static __always_inline void exit_to_user_mode_prepare_legacy(struct pt_regs =
*regs)
 {
-	__exit_to_user_mode_prepare(regs);
+	__exit_to_user_mode_prepare(regs, EXIT_TO_USER_MODE_WORK);
 	rseq_exit_to_user_mode_legacy();
 	__exit_to_user_mode_validate();
 }
@@ -253,7 +266,7 @@ static __always_inline void exit_to_user_mode_prepare_leg=
acy(struct pt_regs *reg
  */
 static __always_inline void syscall_exit_to_user_mode_prepare(struct pt_regs=
 *regs)
 {
-	__exit_to_user_mode_prepare(regs);
+	__exit_to_user_mode_prepare(regs, EXIT_TO_USER_MODE_WORK_SYSCALL);
 	rseq_syscall_exit_to_user_mode();
 	__exit_to_user_mode_validate();
 }
@@ -267,7 +280,7 @@ static __always_inline void syscall_exit_to_user_mode_pre=
pare(struct pt_regs *re
  */
 static __always_inline void irqentry_exit_to_user_mode_prepare(struct pt_reg=
s *regs)
 {
-	__exit_to_user_mode_prepare(regs);
+	__exit_to_user_mode_prepare(regs, EXIT_TO_USER_MODE_WORK_IRQ);
 	rseq_irqentry_exit_to_user_mode();
 	__exit_to_user_mode_validate();
 }
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index cbc4a79..17956e1 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -40,6 +40,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
 #endif /* !CONFIG_RSEQ_STATS */
=20
 #ifdef CONFIG_RSEQ
+#include <linux/hrtimer_rearm.h>
 #include <linux/jump_label.h>
 #include <linux/rseq.h>
 #include <linux/sched/signal.h>
@@ -110,7 +111,7 @@ static __always_inline void rseq_slice_clear_grant(struct=
 task_struct *t)
 	t->rseq.slice.state.granted =3D false;
 }
=20
-static __always_inline bool rseq_grant_slice_extension(bool work_pending)
+static __always_inline bool __rseq_grant_slice_extension(bool work_pending)
 {
 	struct task_struct *curr =3D current;
 	struct rseq_slice_ctrl usr_ctrl;
@@ -215,11 +216,20 @@ efault:
 	return false;
 }
=20
+static __always_inline bool rseq_grant_slice_extension(unsigned long ti_work=
, unsigned long mask)
+{
+	if (unlikely(__rseq_grant_slice_extension(ti_work & mask))) {
+		hrtimer_rearm_deferred_tif(ti_work);
+		return true;
+	}
+	return false;
+}
+
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
 static inline bool rseq_slice_extension_enabled(void) { return false; }
 static inline bool rseq_arm_slice_extension_timer(void) { return false; }
 static inline void rseq_slice_clear_grant(struct task_struct *t) { }
-static inline bool rseq_grant_slice_extension(bool work_pending) { return fa=
lse; }
+static inline bool rseq_grant_slice_extension(unsigned long ti_work, unsigne=
d long mask) { return false; }
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
=20
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
@@ -778,7 +788,7 @@ static inline void rseq_syscall_exit_to_user_mode(void) {=
 }
 static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_exit_to_user_mode_legacy(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
-static inline bool rseq_grant_slice_extension(bool work_pending) { return fa=
lse; }
+static inline bool rseq_grant_slice_extension(unsigned long ti_work, unsigne=
d long mask) { return false; }
 #endif /* !CONFIG_RSEQ */
=20
 #endif /* _LINUX_RSEQ_ENTRY_H */
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 9ef63e4..9e1a6af 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -50,7 +50,7 @@ static __always_inline unsigned long __exit_to_user_mode_lo=
op(struct pt_regs *re
 		local_irq_enable_exit_to_user(ti_work);
=20
 		if (ti_work & (_TIF_NEED_RESCHED | _TIF_NEED_RESCHED_LAZY)) {
-			if (!rseq_grant_slice_extension(ti_work & TIF_SLICE_EXT_DENY))
+			if (!rseq_grant_slice_extension(ti_work, TIF_SLICE_EXT_DENY))
 				schedule();
 		}
=20
@@ -225,6 +225,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry=
_state_t state)
 		 */
 		if (state.exit_rcu) {
 			instrumentation_begin();
+			hrtimer_rearm_deferred();
 			/* Tell the tracer that IRET will enable interrupts */
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare();
@@ -238,6 +239,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry=
_state_t state)
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			irqentry_exit_cond_resched();
=20
+		hrtimer_rearm_deferred();
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();

