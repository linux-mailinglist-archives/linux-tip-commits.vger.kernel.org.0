Return-Path: <linux-tip-commits+bounces-7059-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2803DC19B1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F3E18841CA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46878330D20;
	Wed, 29 Oct 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OVUW4S0X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BPwcr+wx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E37C320A0D;
	Wed, 29 Oct 2025 10:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733420; cv=none; b=apd7VIBv3LE/HvVuAcRfINCSdA4FVfKaK6Kizs8cPYaC1Z4QTXHFAw7xa8Xev1vQ4tHvLqaMy12zSfAesOhbH+zA6uyIXXpm2C54TROpxinqC8fAVF4sFd1kYOid9Fv2qBwIIw85CBPhq4CSgT2f3p1/THrJTtdEZbhsXEVat0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733420; c=relaxed/simple;
	bh=97/PVpFZJkeD02L8Tz4L48bzgho6RtI3Juyi6Ye/NdY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OsxV0TxoiEdTKUpXIBdTRQoRyBI54XnXFoqUpl8ogMc/UknIU5z8fx8hCGl5gv+lOrDEYAwWmdo4ww9QOUPhpPuw0wuTya+YX6wYh3E+l4kv4QCaOwaTC4CqdYjX/gXc8TOz5xX5Mx/QUxsLQAWzK9oJwUyD4LfVUu+A/awBykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OVUW4S0X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BPwcr+wx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzkrLfYRHFXJOAjBRn51y8RbUoYNE+8octyDiiy6Dg8=;
	b=OVUW4S0XJgJhtWVniz4CI/GkNyX9Y6S3vS0JZSIkjXx573PN36OiBm+OF0pqrBwfLsLszz
	Yga+9HMQTUhIoxM7KWxQxyRSptpT01PJEZLeg6/Xa7JweD6JMK+QmClcCEzHuVmW8MDpCV
	LJj3zwGwDcdG+ZkYtWt7jeTbYV2F4mR3tZ/1gYC2KvWIMuvc7oUGiMmPpVa/vwyo0ISY3J
	rVbIbWlrteWECHYdtE0/x0sZdSIfSDZWZvqBE8g+HJjdJeoLcuhA56MinrXoLK4rSoXvPL
	rZtgUfYABz+dpP0PSnw+VEeRzRpiUqLa9f8cf5uz3nBw7gwlBytFDwAdBYdepA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733415;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uzkrLfYRHFXJOAjBRn51y8RbUoYNE+8octyDiiy6Dg8=;
	b=BPwcr+wxR04MZXXYFysErblk27QK3YVt/UpTWWd8lsAOZGhY1H6SvM12EWVIHCX315RWDJ
	ph/Vm5O2r4aEB0Dw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Rework the TIF_NOTIFY handler
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.517640811@linutronix.de>
References: <20251027084307.517640811@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173341370.2601451.16854496026133130162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     e1a607ccd2a4ea8885cd6d9626137b21b559551f
Gitweb:        https://git.kernel.org/tip/e1a607ccd2a4ea8885cd6d9626137b21b55=
9551f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:12 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:18 +01:00

rseq: Rework the TIF_NOTIFY handler

Replace the whole logic with a new implementation, which is shared with
signal delivery and the upcoming exit fast path.

Contrary to the original implementation, this ignores invocations from
KVM/IO-uring, which invoke resume_user_mode_work() with the @regs argument
set to NULL.

The original implementation updated the CPU/Node/MM CID fields, but that
was just a side effect, which was addressing the problem that this
invocation cleared TIF_NOTIFY_RESUME, which in turn could cause an update
on return to user space to be lost.

This problem has been addressed differently, so that it's not longer
required to do that update before entering the guest.

That might be considered a user visible change, when the hosts thread TLS
memory is mapped into the guest, but as this was never intentionally
supported, this abuse of kernel internal implementation details is not
considered an ABI break.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.517640811@linutronix.de
---
 include/linux/rseq_entry.h | 29 ++++++++++++++-
 kernel/rseq.c              | 76 ++++++++++++++++---------------------
 2 files changed, 62 insertions(+), 43 deletions(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 37444e8..aa1c046 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -368,6 +368,35 @@ efault:
 	return false;
 }
=20
+/*
+ * Update user space with new IDs and conditionally check whether the task
+ * is in a critical section.
+ */
+static rseq_inline bool rseq_update_usr(struct task_struct *t, struct pt_reg=
s *regs,
+					struct rseq_ids *ids, u32 node_id)
+{
+	u64 csaddr;
+
+	if (!rseq_set_ids_get_csaddr(t, ids, node_id, &csaddr))
+		return false;
+
+	/*
+	 * On architectures which utilize the generic entry code this
+	 * allows to skip the critical section when the entry was not from
+	 * a user space interrupt, unless debug mode is enabled.
+	 */
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		if (!static_branch_unlikely(&rseq_debug_enabled)) {
+			if (likely(!t->rseq.event.user_irq))
+				return true;
+		}
+	}
+	if (likely(!csaddr))
+		return true;
+	/* Sigh, this really needs to do work */
+	return rseq_update_user_cs(t, regs, csaddr);
+}
+
 static __always_inline void rseq_exit_to_user_mode(void)
 {
 	struct rseq_event *ev =3D &current->rseq.event;
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 4d7ba22..cbb1ab4 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -82,12 +82,6 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/rseq.h>
=20
-#ifdef CONFIG_MEMBARRIER
-# define RSEQ_EVENT_GUARD	irq
-#else
-# define RSEQ_EVENT_GUARD	preempt
-#endif
-
 DEFINE_STATIC_KEY_MAYBE(CONFIG_RSEQ_DEBUG_DEFAULT_ENABLE, rseq_debug_enabled=
);
=20
 static inline void rseq_control_debug(bool on)
@@ -239,38 +233,15 @@ efault:
 	return false;
 }
=20
-/*
- * This resume handler must always be executed between any of:
- * - preemption,
- * - signal delivery,
- * and return to user-space.
- *
- * This is how we can ensure that the entire rseq critical section
- * will issue the commit instruction only if executed atomically with
- * respect to other threads scheduled on the same CPU, and with respect
- * to signal handlers.
- */
-void __rseq_handle_notify_resume(struct pt_regs *regs)
+static void rseq_slowpath_update_usr(struct pt_regs *regs)
 {
+	/* Preserve rseq state and user_irq state for exit to user */
+	const struct rseq_event evt_mask =3D { .has_rseq =3D true, .user_irq =3D tr=
ue, };
 	struct task_struct *t =3D current;
 	struct rseq_ids ids;
 	u32 node_id;
 	bool event;
=20
-	/*
-	 * If invoked from hypervisors before entering the guest via
-	 * resume_user_mode_work(), then @regs is a NULL pointer.
-	 *
-	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
-	 * it before returning from the ioctl() to user space when
-	 * rseq_event.sched_switch is set.
-	 *
-	 * So it's safe to ignore here instead of pointlessly updating it
-	 * in the vcpu_run() loop.
-	 */
-	if (!regs)
-		return;
-
 	if (unlikely(t->flags & PF_EXITING))
 		return;
=20
@@ -294,26 +265,45 @@ void __rseq_handle_notify_resume(struct pt_regs *regs)
 	 * with the result handed in to allow the detection of
 	 * inconsistencies.
 	 */
-	scoped_guard(RSEQ_EVENT_GUARD) {
+	scoped_guard(irq) {
 		event =3D t->rseq.event.sched_switch;
-		t->rseq.event.sched_switch =3D false;
+		t->rseq.event.all &=3D evt_mask.all;
 		ids.cpu_id =3D task_cpu(t);
 		ids.mm_cid =3D task_mm_cid(t);
 	}
=20
-	if (!IS_ENABLED(CONFIG_DEBUG_RSEQ) && !event)
+	if (!event)
 		return;
=20
-	if (!rseq_handle_cs(t, regs))
-		goto error;
-
 	node_id =3D cpu_to_node(ids.cpu_id);
-	if (!rseq_set_ids(t, &ids, node_id))
-		goto error;
-	return;
=20
-error:
-	force_sig(SIGSEGV);
+	if (unlikely(!rseq_update_usr(t, regs, &ids, node_id))) {
+		/*
+		 * Clear the errors just in case this might survive magically, but
+		 * leave the rest intact.
+		 */
+		t->rseq.event.error =3D 0;
+		force_sig(SIGSEGV);
+	}
+}
+
+void __rseq_handle_notify_resume(struct pt_regs *regs)
+{
+	/*
+	 * If invoked from hypervisors before entering the guest via
+	 * resume_user_mode_work(), then @regs is a NULL pointer.
+	 *
+	 * resume_user_mode_work() clears TIF_NOTIFY_RESUME and re-raises
+	 * it before returning from the ioctl() to user space when
+	 * rseq_event.sched_switch is set.
+	 *
+	 * So it's safe to ignore here instead of pointlessly updating it
+	 * in the vcpu_run() loop.
+	 */
+	if (!regs)
+		return;
+
+	rseq_slowpath_update_usr(regs);
 }
=20
 void __rseq_signal_deliver(int sig, struct pt_regs *regs)

