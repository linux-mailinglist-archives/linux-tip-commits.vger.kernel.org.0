Return-Path: <linux-tip-commits+bounces-7229-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DCD9BC2FCCB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:18:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 25EB4189D9D3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E11A3126A5;
	Tue,  4 Nov 2025 08:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n3DMVMB8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="092ShYbq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC77311C09;
	Tue,  4 Nov 2025 08:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244234; cv=none; b=UkFsGld/4Po6WP6fFY3We8JqTs4oJNUbmKUiiqlr2sEM7+FGtlI8Lu+/vddBva46zbjyv3YIS6TnO+mD7Qq/wzHWP51I3mlNx719NA1Ygky2bC/kad3SbUqkLtvqhQhEkoo2knU1ZKt0LqvqoPQG3a/2iYzTB+LMlMgtLdS9CH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244234; c=relaxed/simple;
	bh=X7sDuz3ISeh2MhYFhGGfPkQJSOQYICibtgN6KV70nHI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O2pFe4z64Kx/57dibexocNEcuisf1JHwFyNqr7mTjzVY/1VsYQrTy1eoZC5f3Ug1m6p2hrYwtIiNN2m7HUiXt4GNac5QZ7OFtTZwf8b816CiS9xDqSvUsIkb5r+yyKNTXLjHNtDafjnZqZFCfOILVm1Jm7ZHnKv6xlq6hi3acMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n3DMVMB8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=092ShYbq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhwyM2vHZukDnZT+GEwxaHr/XreWhPgCixo02kbHQig=;
	b=n3DMVMB8im04z6H00uHQ4z3llVLzD8itlEb6cq6XLt2T7KZnY1z3m4JQ36l9dd0FR9accX
	RWeMcSI5sXiSvD2vKvgtCmWnPUW/pHNHWSyldGq4NSm+d+ky11B1871gRZUkeB4ebu+KSO
	6qdgnk4dVR6rJgbond4tcRV6IFXMMeLdg42v6DcoTSSzsovHqg9HF4mevHY3UcI2Ja8RyR
	PSh1A1EDYrTAiSWSCTCD3vWcj+3trYknXpm/ZtBSkZUcBVatP9kQ1QbkRiiHfXrXoazeDD
	hEMSsafONJEk/o4J1ULyMcN78rv4x+3/4hXBH60xGNzanen1VFbGQQ9hXOJlsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhwyM2vHZukDnZT+GEwxaHr/XreWhPgCixo02kbHQig=;
	b=092ShYbqqi/O3CFdI5ZBL06VsBcIU6d2frilv658aabiGYOveGtIkxjqn5ZjIaP8r8aiFM
	+IAqOFRcEn/KLnCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Separate the signal delivery path
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.455429038@linutronix.de>
References: <20251027084307.455429038@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224422846.2601451.4229883174306540906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     9f6ffd4cebda86841700775de3213f22bb0ea22d
Gitweb:        https://git.kernel.org/tip/9f6ffd4cebda86841700775de3213f22bb0=
ea22d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:33:47 +01:00

rseq: Separate the signal delivery path

Completely separate the signal delivery path from the notify handler as
they have different semantics versus the event handling.

The signal delivery only needs to ensure that the interrupted user context
was not in a critical section or the section is aborted before it switches
to the signal frame context. The signal frame context does not have the
original instruction pointer anymore, so that can't be handled on exit to
user space.

No point in updating the CPU/CID ids as they might change again before the
task returns to user space for real.

The fast path optimization, which checks for the 'entry from user via
interrupt' condition is only available for architectures which use the
generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.455429038@linutronix.de
---
 include/linux/rseq.h | 21 ++++++++++++++++-----
 kernel/rseq.c        | 30 ++++++++++++++++++++++--------
 2 files changed, 38 insertions(+), 13 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 92f9cd4..f5a4318 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -7,22 +7,33 @@
=20
 #include <uapi/linux/rseq.h>
=20
-void __rseq_handle_notify_resume(struct ksignal *sig, struct pt_regs *regs);
+void __rseq_handle_notify_resume(struct pt_regs *regs);
=20
 static inline void rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	if (current->rseq.event.has_rseq)
-		__rseq_handle_notify_resume(NULL, regs);
+		__rseq_handle_notify_resume(regs);
 }
=20
+void __rseq_signal_deliver(int sig, struct pt_regs *regs);
+
+/*
+ * Invoked from signal delivery to fixup based on the register context before
+ * switching to the signal delivery context.
+ */
 static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs)
 {
-	if (current->rseq.event.has_rseq) {
-		current->rseq.event.sched_switch =3D true;
-		__rseq_handle_notify_resume(ksig, regs);
+	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY)) {
+		/* '&' is intentional to spare one conditional branch */
+		if (current->rseq.event.has_rseq & current->rseq.event.user_irq)
+			__rseq_signal_deliver(ksig->sig, regs);
+	} else {
+		if (current->rseq.event.has_rseq)
+			__rseq_signal_deliver(ksig->sig, regs);
 	}
 }
=20
+/* Raised from context switch and exevce to force evaluation on exit to user=
 */
 static inline void rseq_sched_switch_event(struct task_struct *t)
 {
 	if (t->rseq.event.has_rseq) {
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 1e4f1d2..13faadc 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -250,13 +250,12 @@ efault:
  * respect to other threads scheduled on the same CPU, and with respect
  * to signal handlers.
  */
-void __rseq_handle_notify_resume(struct ksignal *ksig, struct pt_regs *regs)
+void __rseq_handle_notify_resume(struct pt_regs *regs)
 {
 	struct task_struct *t =3D current;
 	struct rseq_ids ids;
 	u32 node_id;
 	bool event;
-	int sig;
=20
 	/*
 	 * If invoked from hypervisors before entering the guest via
@@ -275,10 +274,7 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, s=
truct pt_regs *regs)
 	if (unlikely(t->flags & PF_EXITING))
 		return;
=20
-	if (ksig)
-		rseq_stat_inc(rseq_stats.signal);
-	else
-		rseq_stat_inc(rseq_stats.slowpath);
+	rseq_stat_inc(rseq_stats.slowpath);
=20
 	/*
 	 * Read and clear the event pending bit first. If the task
@@ -317,8 +313,26 @@ void __rseq_handle_notify_resume(struct ksignal *ksig, s=
truct pt_regs *regs)
 	return;
=20
 error:
-	sig =3D ksig ? ksig->sig : 0;
-	force_sigsegv(sig);
+	force_sig(SIGSEGV);
+}
+
+void __rseq_signal_deliver(int sig, struct pt_regs *regs)
+{
+	rseq_stat_inc(rseq_stats.signal);
+	/*
+	 * Don't update IDs, they are handled on exit to user if
+	 * necessary. The important thing is to abort a critical section of
+	 * the interrupted context as after this point the instruction
+	 * pointer in @regs points to the signal handler.
+	 */
+	if (unlikely(!rseq_handle_cs(current, regs))) {
+		/*
+		 * Clear the errors just in case this might survive
+		 * magically, but leave the rest intact.
+		 */
+		current->rseq.event.error =3D 0;
+		force_sigsegv(sig);
+	}
 }
=20
 /*

