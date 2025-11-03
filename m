Return-Path: <linux-tip-commits+bounces-7184-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF3FC2C8CE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CD2C1889B6A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97874316189;
	Mon,  3 Nov 2025 14:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1SFk7eo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IdrVw5B2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD81F315D57;
	Mon,  3 Nov 2025 14:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181255; cv=none; b=tQ8Bj6nBWV12y8+1lPTQhdaVUy9G+q97f3kpYBNYc/zkqiEqONwA4UKt4vwWla/d3qiMNObR3/zAY2OWznbK3weAjiKfXGVl/GJvRDYPf3xitshVtnlKl2RlM0CdvMG6qlI78juesaucrXPlmuVCAGbMBIFlo/vgFTGzeIjunuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181255; c=relaxed/simple;
	bh=p1L6QOy2wyUr6qlqQEn1s4aTfdpG7cNlqMAysVPzOyQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vz/+9SJA8IIWoU+/tslirYyxsYZgcWGFG6Ok+jcl7DtDJ5HhEpaNRms8JKK+0UArEEwL/T7UHVXctzFW9qgu7IloS3PHfdrgLcjgRK7aHxZVYfuhJkf11ohYLxzZK0CnDbApHna7FwiXkBbfAqk1mZq4y80OYwCOJjiXcG/RxYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1SFk7eo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IdrVw5B2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XTX2KGV22GqrSv3EwsD/dxOPLaSlG7jp/P59jWnoZQ=;
	b=h1SFk7eonun9PlOS2DrPKHHlSKYzR3RDtnztW3MYrcPevnb0fGaixFdoPPspIIIgYcORC1
	NZpKV/1jWS7qvkA63a2xTwDMLdBgzDQQhblhB/eud2HbjIafRWkhpoSjpKX7dAFEN2w1oV
	zi9dVUgrF1V+fYze4uErl7M3/YEX0PohWbZ+p6/xODCC/CaLhdKgtKjPt5AzjTKDgrLFEd
	9qGCxS5wXhG30irT+2YmdbY/bNG7ZkjKfXb8Qp4S8BjSyxYB67MGWIxm8VcutN/Jxs2yQb
	Psg0Fd3FjlKnN1OjBf532CKgN7A+AO50TyyZ97QE6+2GHzO4UtbMZLLl1oqi0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5XTX2KGV22GqrSv3EwsD/dxOPLaSlG7jp/P59jWnoZQ=;
	b=IdrVw5B2RiH4Ial0NnZzFkp2ntKY/uUvS9bC1zprxGi57yGKY/twsdUL0b2XLXy8e0sAab
	BJ91TJgq8sPidoAg==
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
Message-ID: <176218125092.2601451.7793996735627821488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     457dc0a3ef5b3cd51c1497638feccb4db5e7943c
Gitweb:        https://git.kernel.org/tip/457dc0a3ef5b3cd51c1497638feccb4db5e=
7943c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:19 +01:00

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

