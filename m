Return-Path: <linux-tip-commits+bounces-7061-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB71C19BF5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:32:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 774F2562D8E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:25:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 097AF2FFDF3;
	Wed, 29 Oct 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WSGcQdND";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z++6zyAV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42191330317;
	Wed, 29 Oct 2025 10:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733423; cv=none; b=BsKtiIleHPNXwOg59vAZlBAv2R5RGBogTjVcTvPfa4E49/GtT0F1gXN16V6592sBFF3TFqONQPnuULYUQ2zdEcwadPuE0aJzRxNt1qwxLHpoJ/W8EJl06kfTiQZFt1Ouwap9SE95PLbyrkg7Z/JpJ9p/UeJIIpkJ3+BlVMHseB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733423; c=relaxed/simple;
	bh=ySdimN+QkzL18rGoyml6zeGufdwfHDxQgcpKZwQ0gDc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GkHsj49AfYq5w7V3d606jKUt/bUMHGsOwDwNY2IE3FiHC7r4++R9oMLYauJyKhvCDuqeE2WqSZ3kLX5SlEBMAsKdHuYd0m5hM8UFMbJ+BYu5drJCzdR4Gt8q3KX5+fPHN5a+JEopxBzq6GaDZHZXNnb5w4inHKyZ2xHWEiMLRaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WSGcQdND; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z++6zyAV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pC1X/B1pNmEbeP1AK2hapn4kJzgWQN8MeMXjzYeh3Q=;
	b=WSGcQdNDa1/lllu4erd7+5SAfT62ouPsZEap/GXdw/Jcoeq5FrR3KGrqIihGVFdkfgPffr
	cEkxRlzIhFb/xGW4mVwR8fpYrxUgpT7AqQH7rO4fOChDwFbwbHRox2AowgljJvGmIFLWiT
	mQIbGMdQIggtt29j+oYFgAz6pvY2eHRUZfujS+B8o7mKDOg52ON01c+mUA9xnSxn+UbCsz
	DSMTGwWzZJwhvdGvWreojLTHYKYkkqngLvfEEl5QE59Xkp8kdTsSVcs+A6XVy/j4NlZ+Cx
	SxYkVOYnoGAf7+zjbBjkWn7c8faPJOJ5Cqwy98oOA1HGeLlyrIoVpX1lppoyaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733419;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/pC1X/B1pNmEbeP1AK2hapn4kJzgWQN8MeMXjzYeh3Q=;
	b=z++6zyAViq292ACpQXo0dN13pTxdzOVgGJYiWdafUWWDaaZdhq0M1Q9RUF3n/rISUaK327
	271tBQHiOG6v7tDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Use static branch for syscall exit debug when
 GENERIC_IRQ_ENTRY=y
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
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
Message-ID: <176173341760.2601451.1484495948667542485.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     785637e834310e88ce00cb9eed2ba7ba03ea561d
Gitweb:        https://git.kernel.org/tip/785637e834310e88ce00cb9eed2ba7ba03e=
a561d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:17 +01:00

rseq: Use static branch for syscall exit debug when GENERIC_IRQ_ENTRY=3Dy

Make the syscall exit debug mechanism available via the static branch on
architectures which utilize the generic entry code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
index 07d9fa7..5f21270 100644
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

