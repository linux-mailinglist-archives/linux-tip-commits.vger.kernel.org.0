Return-Path: <linux-tip-commits+bounces-7251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 83CC3C2FD8B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DDB5189D56E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68D1324B20;
	Tue,  4 Nov 2025 08:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n5tOqwaQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Hal6UeGf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F52322A28;
	Tue,  4 Nov 2025 08:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244268; cv=none; b=gq674daQOj0vj55rraguoh/Hv5sVG2hu+UsHRanTe2OVwVjlj325bHC6E9EHK46L172iHL3j7GqZtxbQ57d93ekmEF9DmwGa4a1lfu9cozgxvAiOVzBeYhSn4mc+PPEYX7zn25A2JmB8UELvfF0g7WWvkYZLj5+P1FcNQXfq0EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244268; c=relaxed/simple;
	bh=McN2dCNUaql3SJ6Rr70flaufgMWgvueQ7+YN1vHvtgg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QRjy6xGZZDe7ToE2Hpi+SSUPrIgU8rA4fxf0zgZCuQOc8VmXhomA+tya3rUReDceA+B9RUiruKwyRyDDdDRNaGThvTKPBb32M4UH+BxhF0tj2oS2VU6b1Ln2HHzLf2CTP84pp/S/gsl2h/Ieb4CZOv9oyYT0zG/CXW5Gn4XS/1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n5tOqwaQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Hal6UeGf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntBKXQ/R500QpcAgfa1OUXvVuWemK57HI0pyUTRgucA=;
	b=n5tOqwaQ+WTCO6jyUMhT0ZUO0YGPY6UjXIirRksNlyY7I16g7y3QfiyE2+dqm9QPmF4B12
	Dkjs7yKrukzaLIkh75it6lS1LbFerETKD4+G1UK3+BJC1q89Mba6FHbGRxdfz81dTC26Tg
	juJ55BFa+bnlHjTSor4oAzH2Cph7pxV/9z8x1m0uCQyc1dVlx69RDNUBT+v+LSyeqMwmAu
	snqYHxpVf2nu0ydkjcVQC5ahF8ByYMTW72LL41117J0x1s4jMRl6SwwQdobcUkX26qCI7b
	CqQ8wjxXiDYZl7NN/Cmg8XpHdGcYygvuiVBmJFP1Pea4wn7+EWsWWJTuFwCSvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ntBKXQ/R500QpcAgfa1OUXvVuWemK57HI0pyUTRgucA=;
	b=Hal6UeGfJNtk523J+cOSXlMojujRnpw7XfhnVh4E+ZpaFeenh2ejKXcAGLK0l/cGiQOzL4
	MyP4dnw17m+oS4CA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Condense the inline stubs
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.085971048@linutronix.de>
References: <20251027084306.085971048@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224426210.2601451.9700798147582866482.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     fdc0f39d289ebcf46ef44f43460207ef24c94ed7
Gitweb:        https://git.kernel.org/tip/fdc0f39d289ebcf46ef44f43460207ef24c=
94ed7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:29:08 +01:00

rseq: Condense the inline stubs

Scrolling over tons of pointless

	{
	}

lines to find the actual code is annoying at best.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.085971048@linutronix.de
---
 include/linux/rseq.h | 47 ++++++++++---------------------------------
 1 file changed, 12 insertions(+), 35 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index 7622b73..21f875a 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -101,44 +101,21 @@ static inline void rseq_execve(struct task_struct *t)
 	t->rseq_event_mask =3D 0;
 }
=20
-#else
-
-static inline void rseq_set_notify_resume(struct task_struct *t)
-{
-}
-static inline void rseq_handle_notify_resume(struct ksignal *ksig,
-					     struct pt_regs *regs)
-{
-}
-static inline void rseq_signal_deliver(struct ksignal *ksig,
-				       struct pt_regs *regs)
-{
-}
-static inline void rseq_preempt(struct task_struct *t)
-{
-}
-static inline void rseq_migrate(struct task_struct *t)
-{
-}
-static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
-{
-}
-static inline void rseq_execve(struct task_struct *t)
-{
-}
+#else /* CONFIG_RSEQ */
+static inline void rseq_set_notify_resume(struct task_struct *t) { }
+static inline void rseq_handle_notify_resume(struct ksignal *ksig, struct pt=
_regs *regs) { }
+static inline void rseq_signal_deliver(struct ksignal *ksig, struct pt_regs =
*regs) { }
+static inline void rseq_preempt(struct task_struct *t) { }
+static inline void rseq_migrate(struct task_struct *t) { }
+static inline void rseq_fork(struct task_struct *t, u64 clone_flags) { }
+static inline void rseq_execve(struct task_struct *t) { }
 static inline void rseq_exit_to_user_mode(void) { }
-#endif
+#endif  /* !CONFIG_RSEQ */
=20
 #ifdef CONFIG_DEBUG_RSEQ
-
 void rseq_syscall(struct pt_regs *regs);
-
-#else
-
-static inline void rseq_syscall(struct pt_regs *regs)
-{
-}
-
-#endif
+#else /* CONFIG_DEBUG_RSEQ */
+static inline void rseq_syscall(struct pt_regs *regs) { }
+#endif /* !CONFIG_DEBUG_RSEQ */
=20
 #endif /* _LINUX_RSEQ_H */

