Return-Path: <linux-tip-commits+bounces-7204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 024F6C2CCEA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:39:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F0C94272A6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F14431E115;
	Mon,  3 Nov 2025 14:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DrB1k/vP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sE68tiR0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C5831D758;
	Mon,  3 Nov 2025 14:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181280; cv=none; b=Im4Qu4lIxvxwJniKwBF0e/LA+WgjJKFR7RZ9t4wLlnfnec08HIsolRNnPQskKpYtdB4flrvGOBqBJlT2EpjyJowtzXl5Cj/gExVTHAaRIGeYf81jyyI8Poc9KA4QeCLk7SM3zwRpYIXGU/3LBQjfKj4rEYERU2oL71rxAi5LnYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181280; c=relaxed/simple;
	bh=uWVWlgziu72GqAF5rGRkv0xaK2LBNw6PJcdlL/ABj38=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nmgySjgfEjRqHH0N8NATxJ1RKUQct03SXIviFdnN9zLkOSmCkXQnwxrEyvL9IobQlNrKAo3ChReneSbc96/RcFDN8cWTzXvm81xg1xsgAB9Kf3+wVoDPv2ZTdq59IVN0vNiQwDAxcJSe2SiOMQn5s1J06WjMAua91coOW0IfANU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DrB1k/vP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sE68tiR0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln7NSQuzyE5FWafD8VB2Tutt8priShPaq+MakFCabOw=;
	b=DrB1k/vPGhNq6L/2axHsGu9As178yGzE60OzXR9HSjBTz7S4V/hw6Y7BX2BFxBJ8uc14X3
	V289aZBL6l2yNhkPDCBlVcQZIDdpjITRUiqm8tEiQrhqLbDd12YiKLIOYDIJWXOlP25jBd
	GTgREHj7Vj4/t+Sfa6YNmNlvYry/F6palw9mLY2UATws4t/SrQmDdlEvVp6bNNz+TAaKsh
	98Rae50OQdmVKbHwpJdecECeFt+qvYJgW2Z+GVK219xLC6gKfCPqBQsou12/hxRAcS2rQi
	qapvLpYozAQK6bWj3jc8065zSJTxitl+ztdY02YlHAbheKH3AA1o/QRlicSs/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181277;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ln7NSQuzyE5FWafD8VB2Tutt8priShPaq+MakFCabOw=;
	b=sE68tiR0vSavjyV1zxLmQhKEpHm7dvIGtNgiidyfMlcWPBjXNtthbRvcgTeeqEOd1KSb+K
	OFBXRYgBsUmq6BAw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Condense the inline stubs
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <176218127626.2601451.5169832415155712437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     a096aaa7b909f5857892e49f23505be01dc091dd
Gitweb:        https://git.kernel.org/tip/a096aaa7b909f5857892e49f23505be01dc=
091dd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:13 +01:00

rseq: Condense the inline stubs

Scrolling over tons of pointless

{
}

lines to find the actual code is annoying at best.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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

