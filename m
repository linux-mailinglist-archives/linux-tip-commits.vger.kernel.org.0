Return-Path: <linux-tip-commits+bounces-7056-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F949C19B6C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 977E156143E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAFDD32E68C;
	Wed, 29 Oct 2025 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lCYQFY1r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tuJdgzpc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5153126C7;
	Wed, 29 Oct 2025 10:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733415; cv=none; b=pApMffM8ZDdgW+rMJexwjYDZpA1Ug+N+MRMD1SkcrwbfaOBlURpC0HN66NdjptTMzmaWQ56hlxKLPeIC77IFse8JhwixCNPCSGZqeySfAhy869XraNL51hqBMmzEDYGfbl956xNMHarKFN74OmN/75Wo6ZkddQkELO+QC+2m0NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733415; c=relaxed/simple;
	bh=DrnOjqW5EVAdrRpv0EmVaF95t/Y6+vLGYgLOnF5oFr8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hzlrbVB67jvnntmO+NsNMhDjrcDXPRSkGu9HZnYQ8nYK/7ipcoCSS/Z/4T06fyBzXGurLhgAbsu80n2wXbGgJUY/mNHzWpz68uH9ox/o6D4iTOeIN1KfhJwHzM7trKhx1VtlEVqqHVbPKfklJqSFes9mKUpbcFpI9lDicVG8neg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lCYQFY1r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tuJdgzpc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kapVO53RYgn03fBLXrLb2fj+YFdvHk2QCwxAWFxDb6I=;
	b=lCYQFY1r+rJPslNpjZSvA3nh8/kVsGCE2uWMeGdd8wamaXTdgULzy/G+9pwWPD8sNqg3HJ
	Qq0hS9fJ9084sRHVdnXrrVWUSIlYLHUrIiYy1F5HTDZ2Af7/sfKc/cinQFuDO9HYGP1WNk
	nkXfiMgSXfXOD0VRWzpyMUW2SYRkuaAdpapCxCEz2KIbdjTQB6vQqFZZOkoznJoeG75bc4
	D/zvu4QiQXcFQrXUed3jIjDANVLuTKoc7eGrH3zwzoB1AfX559NuxUqRWneoKucgbb/4kp
	c3fGw3+D7LuKSt6DO+JsjSJXLAYotJrkWQtXedE7fGI/dcXBp/78dxvchg2OZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733411;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kapVO53RYgn03fBLXrLb2fj+YFdvHk2QCwxAWFxDb6I=;
	b=tuJdgzpc9znKsewHefnw/4UhnHAVJ4oBWC9+bdHnf3NurGl4tPlS3a6F7ygnCcMEnMgbCZ
	cjTjCWfJNo/PhoCg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Switch to fast path processing on exit to user
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.701201365@linutronix.de>
References: <20251027084307.701201365@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173341000.2601451.9508732031659738662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     84eeeb00203526c29135d5352833d01e53fc1e16
Gitweb:        https://git.kernel.org/tip/84eeeb00203526c29135d5352833d01e53f=
c1e16
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:19 +01:00

rseq: Switch to fast path processing on exit to user

Now that all bits and pieces are in place, hook the RSEQ handling fast path
function into exit_to_user_mode_prepare() after the TIF work bits have been
handled. If case of fast path failure, TIF_NOTIFY_RESUME has been raised
and the caller needs to take another turn through the TIF handling slow
path.

This only works for architectures which use the generic entry code.
Architectures who still have their own incomplete hacks are not supported
and won't be.

This results in the following improvements:

  Kernel build	       Before		  After		      Reduction

  exit to user         80692981		  80514451
  signal checks:          32581		       121	       99%
  slowpath runs:        1201408   1.49%	       198 0.00%      100%
  fastpath runs:           	  	    675941 0.84%       N/A
  id updates:           1233989   1.53%	     50541 0.06%       96%
  cs checks:            1125366   1.39%	         0 0.00%      100%
    cs cleared:         1125366      100%	 0            100%
    cs fixup:                 0        0%	 0

  RSEQ selftests      Before		  After		      Reduction

  exit to user:       386281778		  387373750
  signal checks:       35661203		          0           100%
  slowpath runs:      140542396 36.38%	        100  0.00%    100%
  fastpath runs:           	  	    9509789  2.51%     N/A
  id updates:         176203599 45.62%	    9087994  2.35%     95%
  cs checks:          175587856 45.46%	    4728394  1.22%     98%
    cs cleared:       172359544   98.16%    1319307   27.90%   99%
    cs fixup:           3228312    1.84%    3409087   72.10%

The 'cs cleared' and 'cs fixup' percentages are not relative to the exit to
user invocations, they are relative to the actual 'cs check' invocations.

While some of this could have been avoided in the original code, like the
obvious clearing of CS when it's already clear, the main problem of going
through TIF_NOTIFY_RESUME cannot be solved. In some workloads the RSEQ
notify handler is invoked more than once before going out to user
space. Doing this once when everything has stabilized is the only solution
to avoid this.

The initial attempt to completely decouple it from the TIF work turned out
to be suboptimal for workloads, which do a lot of quick and short system
calls. Even if the fast path decision is only 4 instructions (including a
conditional branch), this adds up quickly and becomes measurable when the
rate for actually having to handle rseq is in the low single digit
percentage range of user/kernel transitions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.701201365@linutronix.de
---
 include/linux/irq-entry-common.h |  7 ++-----
 include/linux/resume_user_mode.h |  2 +-
 include/linux/rseq.h             | 18 ++++++++++++------
 init/Kconfig                     |  2 +-
 kernel/entry/common.c            | 26 +++++++++++++++++++-------
 kernel/rseq.c                    |  8 ++++++--
 6 files changed, 41 insertions(+), 22 deletions(-)

diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-commo=
n.h
index cb31fb8..8f5ceea 100644
--- a/include/linux/irq-entry-common.h
+++ b/include/linux/irq-entry-common.h
@@ -197,11 +197,8 @@ static __always_inline void arch_exit_to_user_mode(void)=
 { }
  */
 void arch_do_signal_or_restart(struct pt_regs *regs);
=20
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- */
-unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-				     unsigned long ti_work);
+/* Handle pending TIF work */
+unsigned long exit_to_user_mode_loop(struct pt_regs *regs, unsigned long ti_=
work);
=20
 /**
  * exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
diff --git a/include/linux/resume_user_mode.h b/include/linux/resume_user_mod=
e.h
index dd3bf7d..bf92227 100644
--- a/include/linux/resume_user_mode.h
+++ b/include/linux/resume_user_mode.h
@@ -59,7 +59,7 @@ static inline void resume_user_mode_work(struct pt_regs *re=
gs)
 	mem_cgroup_handle_over_high(GFP_KERNEL);
 	blkcg_maybe_throttle_current();
=20
-	rseq_handle_notify_resume(regs);
+	rseq_handle_slowpath(regs);
 }
=20
 #endif /* LINUX_RESUME_USER_MODE_H */
diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 684b5bd..ded4baa 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,13 +7,19 @@
=20
 #include <uapi/linux/rseq.h>
=20
-void __rseq_handle_notify_resume(struct pt_regs *regs);
+void __rseq_handle_slowpath(struct pt_regs *regs);
=20
-static inline void rseq_handle_notify_resume(struct pt_regs *regs)
+/* Invoked from resume_user_mode_work() */
+static inline void rseq_handle_slowpath(struct pt_regs *regs)
 {
-	/* '&' is intentional to spare one conditional branch */
-	if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
-		__rseq_handle_notify_resume(regs);
+	if (IS_ENABLED(CONFIG_GENERIC_ENTRY)) {
+		if (current->rseq.event.slowpath)
+			__rseq_handle_slowpath(regs);
+	} else {
+		/* '&' is intentional to spare one conditional branch */
+		if (current->rseq.event.sched_switch & current->rseq.event.has_rseq)
+			__rseq_handle_slowpath(regs);
+	}
 }
=20
 void __rseq_signal_deliver(int sig, struct pt_regs *regs);
@@ -152,7 +158,7 @@ static inline void rseq_fork(struct task_struct *t, u64 c=
lone_flags)
 }
=20
 #else /* CONFIG_RSEQ */
-static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt=
_regs *regs) { }
+static inline void rseq_handle_slowpath(struct pt_regs *regs) { }
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
 static inline void rseq_sched_switch_event(struct task_struct *t) { }
 static inline void rseq_sched_set_task_cpu(struct task_struct *t, unsigned i=
nt cpu) { }
diff --git a/init/Kconfig b/init/Kconfig
index bde40ab..d1c606e 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1941,7 +1941,7 @@ config RSEQ_DEBUG_DEFAULT_ENABLE
 config DEBUG_RSEQ
 	default n
 	bool "Enable debugging of rseq() system call" if EXPERT
-	depends on RSEQ && DEBUG_KERNEL
+	depends on RSEQ && DEBUG_KERNEL && !GENERIC_ENTRY
 	select RSEQ_DEBUG_DEFAULT_ENABLE
 	help
 	  Enable extra debugging checks for the rseq system call.
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 70a16db..523a3e7 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -11,13 +11,8 @@
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs) { }
=20
-/**
- * exit_to_user_mode_loop - do any pending work before leaving to user space
- * @regs:	Pointer to pt_regs on entry stack
- * @ti_work:	TIF work flags as read by the caller
- */
-__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
-						     unsigned long ti_work)
+static __always_inline unsigned long __exit_to_user_mode_loop(struct pt_regs=
 *regs,
+							      unsigned long ti_work)
 {
 	/*
 	 * Before returning to user space ensure that all pending work
@@ -62,6 +57,23 @@ __always_inline unsigned long exit_to_user_mode_loop(struc=
t pt_regs *regs,
 	return ti_work;
 }
=20
+/**
+ * exit_to_user_mode_loop - do any pending work before leaving to user space
+ * @regs:	Pointer to pt_regs on entry stack
+ * @ti_work:	TIF work flags as read by the caller
+ */
+__always_inline unsigned long exit_to_user_mode_loop(struct pt_regs *regs,
+						     unsigned long ti_work)
+{
+	for (;;) {
+		ti_work =3D __exit_to_user_mode_loop(regs, ti_work);
+
+		if (likely(!rseq_exit_to_user_mode_restart(regs)))
+			return ti_work;
+		ti_work =3D read_thread_flags();
+	}
+}
+
 noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 {
 	irqentry_state_t ret =3D {
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9633b08..cbb2ff7 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -237,7 +237,11 @@ efault:
=20
 static void rseq_slowpath_update_usr(struct pt_regs *regs)
 {
-	/* Preserve rseq state and user_irq state for exit to user */
+	/*
+	 * Preserve rseq state and user_irq state. The generic entry code
+	 * clears user_irq on the way out, the non-generic entry
+	 * architectures are not having user_irq.
+	 */
 	const struct rseq_event evt_mask =3D { .has_rseq =3D true, .user_irq =3D tr=
ue, };
 	struct task_struct *t =3D current;
 	struct rseq_ids ids;
@@ -289,7 +293,7 @@ static void rseq_slowpath_update_usr(struct pt_regs *regs)
 	}
 }
=20
-void __rseq_handle_notify_resume(struct pt_regs *regs)
+void __rseq_handle_slowpath(struct pt_regs *regs)
 {
 	/*
 	 * If invoked from hypervisors before entering the guest via

