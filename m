Return-Path: <linux-tip-commits+bounces-7231-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C2FFC2FCD7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58A06189DA15
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19D8314A8B;
	Tue,  4 Nov 2025 08:17:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DVSs8DCK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JgYXbdtc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C9B6313E2F;
	Tue,  4 Nov 2025 08:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244238; cv=none; b=RG6g/c+TYOrVWg+QzoQHWoGvKoX23ZaMmpGVN6XqxHIO7o+eTD9Y3uxHJj8NTO1g/pTRNzIzx/4Dy2LLxMB0Ht8xj0MBQiSmbpno84kw7gI3ptBG/KPO0ZTMGkYCllg9Vda1OxQXFZn5dV3tYw9DpXeW0l9CZFsobRvnmEJewB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244238; c=relaxed/simple;
	bh=sTuBQprx0mvpyNiP0a1rzFqk1zOXpJqQZR5QejuCxgA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ch6pTpXbACeZ9tx5DM8pCMwDKXWqQee5o+YJqPQ4Lwv3VUxX4UcXB78uabrf5Z35NN9phMIp/lL/D6SY9L91L+3J43gSAZurhS1wh75v75+Fgr6QnMsP75MER/LqMGHS5TYU5fY6yUUivxTWlEKdFzaf1Pa2oXDsJI3xgtrFp2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DVSs8DCK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JgYXbdtc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOOq0I6lZIeZnXuwbXsKhE/QpVdTyECqtigd1vn4eUg=;
	b=DVSs8DCKe7YXlXhK2FMiu5uSPBGkjUMqEBJWkvwFp3xAS+sC0HcnqolQtUMDmU061M7ep1
	1HRCnu02SKrxG9eRJoKCbdb/k1gdg84F6M3k8zEVbDdoVP35CqNmb5FE5Pvo0RLJKN+FpF
	Z3xgOz9YjWWpzoOx0gfaPoyvsQqrs5ixyVgAZAC5CMFiz4SVmqLMuJW693rbm0FpKDH+8f
	U7lLss8EzV3D0E0uL4QiZ/O2LuqMFBkcsTnIvl8MouBONkT4f6b8VTKfcyxut4n55JL6/i
	d9/n8bZCjW0MAmrIZGlgnoe+X0JxNTr4ynNXoUdzzHTOmZeXJtZlQ8la7FAxEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244233;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOOq0I6lZIeZnXuwbXsKhE/QpVdTyECqtigd1vn4eUg=;
	b=JgYXbdtcJUMKSLr+4GF3AaqjL6Pp2smVGAMDpQSVdMbdtMJcM6WkSStTWeH/YljZp7ZQ0N
	klc5QnsRyx/WiYBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Use static branch for syscall exit debug when
 GENERIC_IRQ_ENTRY=y
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.333440475@linutronix.de>
References: <20251027084307.333440475@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176224423177.2601451.1363457328705748487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     eaa9088d568c84afd72fa32dbe01833aef861d0d
Gitweb:        https://git.kernel.org/tip/eaa9088d568c84afd72fa32dbe01833aef8=
61d0d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:05 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:33:27 +01:00

rseq: Use static branch for syscall exit debug when GENERIC_IRQ_ENTRY=3Dy

Make the syscall exit debug mechanism available via the static branch on
architectures which utilize the generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.333440475@linutronix.de
---
 include/linux/entry-common.h |  2 +-
 include/linux/rseq_entry.h   |  9 +++++++++
 kernel/rseq.c                | 10 ++++++++--
 3 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 75b194c..d967184 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -146,7 +146,7 @@ static __always_inline void syscall_exit_to_user_mode_wor=
k(struct pt_regs *regs)
 			local_irq_enable();
 	}
=20
-	rseq_syscall(regs);
+	rseq_debug_syscall_return(regs);
=20
 	/*
 	 * Do one-time syscall specific work. If these work items are
diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index 5bdcf5b..fb53a6f 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -296,9 +296,18 @@ static __always_inline void rseq_exit_to_user_mode(void)
 	ev->events =3D 0;
 }
=20
+void __rseq_debug_syscall_return(struct pt_regs *regs);
+
+static inline void rseq_debug_syscall_return(struct pt_regs *regs)
+{
+	if (static_branch_unlikely(&rseq_debug_enabled))
+		__rseq_debug_syscall_return(regs);
+}
+
 #else /* CONFIG_RSEQ */
 static inline void rseq_note_user_irq_entry(void) { }
 static inline void rseq_exit_to_user_mode(void) { }
+static inline void rseq_debug_syscall_return(struct pt_regs *regs) { }
 #endif /* !CONFIG_RSEQ */
=20
 #endif /* _LINUX_RSEQ_ENTRY_H */
diff --git a/kernel/rseq.c b/kernel/rseq.c
index abd6bfa..9763155 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -473,12 +473,11 @@ error:
 	force_sigsegv(sig);
 }
=20
-#ifdef CONFIG_DEBUG_RSEQ
 /*
  * Terminate the process if a syscall is issued within a restartable
  * sequence.
  */
-void rseq_syscall(struct pt_regs *regs)
+void __rseq_debug_syscall_return(struct pt_regs *regs)
 {
 	struct task_struct *t =3D current;
 	u64 csaddr;
@@ -496,6 +495,13 @@ void rseq_syscall(struct pt_regs *regs)
 fail:
 	force_sig(SIGSEGV);
 }
+
+#ifdef CONFIG_DEBUG_RSEQ
+/* Kept around to keep GENERIC_ENTRY=3Dn architectures supported. */
+void rseq_syscall(struct pt_regs *regs)
+{
+	__rseq_debug_syscall_return(regs);
+}
 #endif
=20
 /*

