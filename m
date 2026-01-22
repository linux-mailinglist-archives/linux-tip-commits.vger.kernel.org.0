Return-Path: <linux-tip-commits+bounces-8100-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cCh9A7b6cWmvZwAAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8100-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:23:50 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C55C6531D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 11:23:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CB5FC866F21
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Jan 2026 10:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BB643E8C53;
	Thu, 22 Jan 2026 10:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qCCIsyQj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Oa0chdg6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97D89309EFA;
	Thu, 22 Jan 2026 10:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769076964; cv=none; b=M14NokoNy2NRsreD8h/gm/PcWuCIKdvkWTlHp/blxk3qLe1pJIYnIWLWGiDLnlrivqyGMbhJDcue83UL1kaMCgAIQHvKqXrvCnwcSxNmuRTh2uWv6bTt4urMiaADE6tzG8OET45hKRBuPgOAblSTbex6AX89slGCJnoF0IYQDMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769076964; c=relaxed/simple;
	bh=2K+Aqhavb3kONS2qf2IF33Op24MRBt3Fhl02zQXIfMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pfJrkNKvRdZWnJaaYw9Dry+ZdngPr3RxLNHUD4DlJ97+6/NMsp1Z6tHToWHErCjOv6Uz1L4jMpwkAUeWIYN95UMxYdEvm5yTUc6lnjhOmwFH462YZmxJgmgA8Raee5KQSsmyWkKEWxjliwUFmY396IcP4kkkk92exDXJ0QfuvP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qCCIsyQj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Oa0chdg6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 22 Jan 2026 10:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769076960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxCswASmwDOrn9nyLkP5sybzT581X0H8Bz/FLC81510=;
	b=qCCIsyQjI7MjzQaHWeEj0ZwPQVYJ54vhhPe7o7N6uqXzTscndn576t+EXVqYlNWJJAG8q3
	YpIuW3zG/HUUYv7/jtSZtrRBsqR4FgKgLgEhrLi6De6t2AhJlxt1VNHK3ZXr8XZxEW6M13
	mRw+ghEEXTmqePA72mPzoGiCng+1wiuiR3k4ypIyasL+GRNVKRbKRckR9Q/2SndCGlSq/s
	7KWBcrqu4Q5F9rUs4CUptT8XFmiBJ/3echDXr1VxLwK6HA79gX0NUfPgJybsXHyrVtd2WO
	NbJF9n9z9peKyb52Lg8e4Bpj4UGGExtRDzT4Ya62ulhwTgCgtNxA/hDrTLz8MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769076960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HxCswASmwDOrn9nyLkP5sybzT581X0H8Bz/FLC81510=;
	b=Oa0chdg64XavAN7NHNRwLnY43mQELyf7RhBJmb8x2Qvq1ln3NArcHbePPJj8T3Z5GS3lbj
	aVtI/i8elJ/V+zBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Implement rseq_grant_slice_extension()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215155709.195303303@linutronix.de>
References: <20251215155709.195303303@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176907695959.510.4469440254838529850.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,linutronix.de:email,linutronix.de:dkim,msgid.link:url,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,infradead.org:email];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-8100-lists,linux-tip-commits=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linutronix.de,none];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	RCPT_COUNT_FIVE(0.00)[5];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 6C55C6531D
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dfb630f548a7c715efb0651c6abf334dca75cd52
Gitweb:        https://git.kernel.org/tip/dfb630f548a7c715efb0651c6abf334dca7=
5cd52
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 15 Dec 2025 17:52:28 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Jan 2026 11:11:18 +01:00

rseq: Implement rseq_grant_slice_extension()

Provide the actual decision function, which decides whether a time slice
extension is granted in the exit to user mode path when NEED_RESCHED is
evaluated.

The decision is made in two stages. First an inline quick check to avoid
going into the actual decision function. This checks whether:

 #1 the functionality is enabled

 #2 the exit is a return from interrupt to user mode

 #3 any TIF bit, which causes extra work is set. That includes TIF_RSEQ,
    which means the task was already scheduled out.

The slow path, which implements the actual user space ABI, is invoked
when:

  A) #1 is true, #2 is true and #3 is false

     It checks whether user space requested a slice extension by setting
     the request bit in the rseq slice_ctrl field. If so, it grants the
     extension and stores the slice expiry time, so that the actual exit
     code can double check whether the slice is already exhausted before
     going back.

  B) #1 - #3 are true _and_ a slice extension was granted in a previous
     loop iteration

     In this case the grant is revoked.

In case that the user space access faults or invalid state is detected, the
task is terminated with SIGSEGV.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251215155709.195303303@linutronix.de
---
 include/linux/rseq_entry.h | 108 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 108 insertions(+)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index fc77b9d..cbc4a79 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -42,6 +42,7 @@ DECLARE_PER_CPU(struct rseq_stats, rseq_stats);
 #ifdef CONFIG_RSEQ
 #include <linux/jump_label.h>
 #include <linux/rseq.h>
+#include <linux/sched/signal.h>
 #include <linux/uaccess.h>
=20
 #include <linux/tracepoint-defs.h>
@@ -109,10 +110,116 @@ static __always_inline void rseq_slice_clear_grant(str=
uct task_struct *t)
 	t->rseq.slice.state.granted =3D false;
 }
=20
+static __always_inline bool rseq_grant_slice_extension(bool work_pending)
+{
+	struct task_struct *curr =3D current;
+	struct rseq_slice_ctrl usr_ctrl;
+	union rseq_slice_state state;
+	struct rseq __user *rseq;
+
+	if (!rseq_slice_extension_enabled())
+		return false;
+
+	/* If not enabled or not a return from interrupt, nothing to do. */
+	state =3D curr->rseq.slice.state;
+	state.enabled &=3D curr->rseq.event.user_irq;
+	if (likely(!state.state))
+		return false;
+
+	rseq =3D curr->rseq.usrptr;
+	scoped_user_rw_access(rseq, efault) {
+
+		/*
+		 * Quick check conditions where a grant is not possible or
+		 * needs to be revoked.
+		 *
+		 *  1) Any TIF bit which needs to do extra work aside of
+		 *     rescheduling prevents a grant.
+		 *
+		 *  2) A previous rescheduling request resulted in a slice
+		 *     extension grant.
+		 */
+		if (unlikely(work_pending || state.granted)) {
+			/* Clear user control unconditionally. No point for checking */
+			unsafe_put_user(0U, &rseq->slice_ctrl.all, efault);
+			rseq_slice_clear_grant(curr);
+			return false;
+		}
+
+		unsafe_get_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
+		if (likely(!(usr_ctrl.request)))
+			return false;
+
+		/* Grant the slice extention */
+		usr_ctrl.request =3D 0;
+		usr_ctrl.granted =3D 1;
+		unsafe_put_user(usr_ctrl.all, &rseq->slice_ctrl.all, efault);
+	}
+
+	rseq_stat_inc(rseq_stats.s_granted);
+
+	curr->rseq.slice.state.granted =3D true;
+	/* Store expiry time for arming the timer on the way out */
+	curr->rseq.slice.expires =3D data_race(rseq_slice_ext_nsecs) + ktime_get_mo=
no_fast_ns();
+	/*
+	 * This is racy against a remote CPU setting TIF_NEED_RESCHED in
+	 * several ways:
+	 *
+	 * 1)
+	 *	CPU0			CPU1
+	 *	clear_tsk()
+	 *				set_tsk()
+	 *	clear_preempt()
+	 *				Raise scheduler IPI on CPU0
+	 *	--> IPI
+	 *	    fold_need_resched() -> Folds correctly
+	 * 2)
+	 *	CPU0			CPU1
+	 *				set_tsk()
+	 *	clear_tsk()
+	 *	clear_preempt()
+	 *				Raise scheduler IPI on CPU0
+	 *	--> IPI
+	 *	    fold_need_resched() <- NOOP as TIF_NEED_RESCHED is false
+	 *
+	 * #1 is not any different from a regular remote reschedule as it
+	 *    sets the previously not set bit and then raises the IPI which
+	 *    folds it into the preempt counter
+	 *
+	 * #2 is obviously incorrect from a scheduler POV, but it's not
+	 *    differently incorrect than the code below clearing the
+	 *    reschedule request with the safety net of the timer.
+	 *
+	 * The important part is that the clearing is protected against the
+	 * scheduler IPI and also against any other interrupt which might
+	 * end up waking up a task and setting the bits in the middle of
+	 * the operation:
+	 *
+	 *	clear_tsk()
+	 *	---> Interrupt
+	 *		wakeup_on_this_cpu()
+	 *		set_tsk()
+	 *		set_preempt()
+	 *	clear_preempt()
+	 *
+	 * which would be inconsistent state.
+	 */
+	scoped_guard(irq) {
+		clear_tsk_need_resched(curr);
+		clear_preempt_need_resched();
+	}
+	return true;
+
+efault:
+	force_sig(SIGSEGV);
+	return false;
+}
+
 #else /* CONFIG_RSEQ_SLICE_EXTENSION */
 static inline bool rseq_slice_extension_enabled(void) { return false; }
 static inline bool rseq_arm_slice_extension_timer(void) { return false; }
 static inline void rseq_slice_clear_grant(struct task_struct *t) { }
+static inline bool rseq_grant_slice_extension(bool work_pending) { return fa=
lse; }
 #endif /* !CONFIG_RSEQ_SLICE_EXTENSION */
=20
 bool rseq_debug_update_user_cs(struct task_struct *t, struct pt_regs *regs, =
unsigned long csaddr);
@@ -671,6 +778,7 @@ static inline void rseq_syscall_exit_to_user_mode(void) {=
 }
 static inline void rseq_irqentry_exit_to_user_mode(void) { }
 static inline void rseq_exit_to_user_mode_legacy(void) { }
 static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
+static inline bool rseq_grant_slice_extension(bool work_pending) { return fa=
lse; }
 #endif /* !CONFIG_RSEQ */
=20
 #endif /* _LINUX_RSEQ_ENTRY_H */

