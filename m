Return-Path: <linux-tip-commits+bounces-7081-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id A4818C19BD8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:31:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A3BF357894
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:31:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7427F348877;
	Wed, 29 Oct 2025 10:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pGEtRNWQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cr/iiKsi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AD8346E48;
	Wed, 29 Oct 2025 10:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733445; cv=none; b=ehEKGv8iDQ3DIJpx/V9frhIa2yqL9WT+5O1UTya23E9CATLRwLi43x0TeayHsg5FhHHmVnWAFoFNRgj85DAAiza40kTWm6lZVnqVBjZICaP7BV9WNk7oWPCIzOECwx+sbOKPa0cvrSlbAqa6PM+TLGTfN8cuZK13vNUusN9HXfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733445; c=relaxed/simple;
	bh=z69L1ZkwjD2imSwb2rnUA9seq4szIYt9TSPf81UyZqc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AXwbZEtN/aALYSNrL6ck90LSKl5LKbfqxdL+YQnGhcf98qlX6hJbIDh9WIXRpP0PGG8KaxbkxLweXunHoBkmXbXYIYzDLDynAJdEGOglqq6/qfBjH9gTXAA5wVtYWbWaa+RYS7fvfA9P1YaC5H9dADgs9ckLdw2ceshlOEB65IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pGEtRNWQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cr/iiKsi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:24:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BD0jed00eRo+jx9/JaGEwEJxgGO+mqbyQwP/gU78ks=;
	b=pGEtRNWQxsTty2fTPlsCMMHqKEBiyvVQN8gCi7U3rgOOyooc0dQlLmu8sdjZwkvAgv6DGu
	s1NPWLyw/YWn3z+YkAF9qwHsiGAi11QrGh2YGv65nt07giTMFcc7xs6/KbHZV/W02Pg1/4
	8dHigh9WrVSu5FyMfj41YtPMNjZQKJqjX/dQRIdiTfCLNrDRadqaQi1FxwzSOrHaFXmjyW
	eKx4bCjQmE/qXhKpDa0uVQoz+XLrgD3rg9jbszCsXbEIHjW6J7VaojUjLBwz3+nYFF6rvl
	GSgCBUH4fadIr9Ty+tNKm4NtD44GXP+jG5TheDZewf5tRGJDEekjVLr3Z0eEKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3BD0jed00eRo+jx9/JaGEwEJxgGO+mqbyQwP/gU78ks=;
	b=cr/iiKsi1vq1vq0crX0fMLMwdXqOjdqka3xrdjtI2pyHwpKVbDYoqqoGVtU6yNieDQAFte
	47KOWXlFn/XtkBCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Move algorithm comment to top
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.149519580@linutronix.de>
References: <20251027084306.149519580@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173344067.2601451.3675867297761023558.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     83bae0cfe44a8173bbdf94fbce776bc8f8ef8dee
Gitweb:        https://git.kernel.org/tip/83bae0cfe44a8173bbdf94fbce776bc8f8e=
f8dee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:20 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:11 +01:00

rseq: Move algorithm comment to top

Move the comment which documents the RSEQ algorithm to the top of the file,
so it does not create horrible diffs later when the actual implementation
is fed into the mincer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.149519580@linutronix.de
---
 kernel/rseq.c | 119 ++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 60 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 246319d..51fafc4 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -8,6 +8,65 @@
  * Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
  */
=20
+/*
+ * Restartable sequences are a lightweight interface that allows
+ * user-level code to be executed atomically relative to scheduler
+ * preemption and signal delivery. Typically used for implementing
+ * per-cpu operations.
+ *
+ * It allows user-space to perform update operations on per-cpu data
+ * without requiring heavy-weight atomic operations.
+ *
+ * Detailed algorithm of rseq user-space assembly sequences:
+ *
+ *                     init(rseq_cs)
+ *                     cpu =3D TLS->rseq::cpu_id_start
+ *   [1]               TLS->rseq::rseq_cs =3D rseq_cs
+ *   [start_ip]        ----------------------------
+ *   [2]               if (cpu !=3D TLS->rseq::cpu_id)
+ *                             goto abort_ip;
+ *   [3]               <last_instruction_in_cs>
+ *   [post_commit_ip]  ----------------------------
+ *
+ *   The address of jump target abort_ip must be outside the critical
+ *   region, i.e.:
+ *
+ *     [abort_ip] < [start_ip]  || [abort_ip] >=3D [post_commit_ip]
+ *
+ *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
+ *   userspace that can handle being interrupted between any of those
+ *   instructions, and then resumed to the abort_ip.
+ *
+ *   1.  Userspace stores the address of the struct rseq_cs assembly
+ *       block descriptor into the rseq_cs field of the registered
+ *       struct rseq TLS area. This update is performed through a single
+ *       store within the inline assembly instruction sequence.
+ *       [start_ip]
+ *
+ *   2.  Userspace tests to check whether the current cpu_id field match
+ *       the cpu number loaded before start_ip, branching to abort_ip
+ *       in case of a mismatch.
+ *
+ *       If the sequence is preempted or interrupted by a signal
+ *       at or after start_ip and before post_commit_ip, then the kernel
+ *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
+ *       ip to abort_ip before returning to user-space, so the preempted
+ *       execution resumes at abort_ip.
+ *
+ *   3.  Userspace critical section final instruction before
+ *       post_commit_ip is the commit. The critical section is
+ *       self-terminating.
+ *       [post_commit_ip]
+ *
+ *   4.  <success>
+ *
+ *   On failure at [2], or if interrupted by preempt or signal delivery
+ *   between [1] and [3]:
+ *
+ *       [abort_ip]
+ *   F1. <failure>
+ */
+
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
@@ -98,66 +157,6 @@ static int rseq_validate_ro_fields(struct task_struct *t)
 	unsafe_put_user(value, &t->rseq->field, error_label)
 #endif
=20
-/*
- *
- * Restartable sequences are a lightweight interface that allows
- * user-level code to be executed atomically relative to scheduler
- * preemption and signal delivery. Typically used for implementing
- * per-cpu operations.
- *
- * It allows user-space to perform update operations on per-cpu data
- * without requiring heavy-weight atomic operations.
- *
- * Detailed algorithm of rseq user-space assembly sequences:
- *
- *                     init(rseq_cs)
- *                     cpu =3D TLS->rseq::cpu_id_start
- *   [1]               TLS->rseq::rseq_cs =3D rseq_cs
- *   [start_ip]        ----------------------------
- *   [2]               if (cpu !=3D TLS->rseq::cpu_id)
- *                             goto abort_ip;
- *   [3]               <last_instruction_in_cs>
- *   [post_commit_ip]  ----------------------------
- *
- *   The address of jump target abort_ip must be outside the critical
- *   region, i.e.:
- *
- *     [abort_ip] < [start_ip]  || [abort_ip] >=3D [post_commit_ip]
- *
- *   Steps [2]-[3] (inclusive) need to be a sequence of instructions in
- *   userspace that can handle being interrupted between any of those
- *   instructions, and then resumed to the abort_ip.
- *
- *   1.  Userspace stores the address of the struct rseq_cs assembly
- *       block descriptor into the rseq_cs field of the registered
- *       struct rseq TLS area. This update is performed through a single
- *       store within the inline assembly instruction sequence.
- *       [start_ip]
- *
- *   2.  Userspace tests to check whether the current cpu_id field match
- *       the cpu number loaded before start_ip, branching to abort_ip
- *       in case of a mismatch.
- *
- *       If the sequence is preempted or interrupted by a signal
- *       at or after start_ip and before post_commit_ip, then the kernel
- *       clears TLS->__rseq_abi::rseq_cs, and sets the user-space return
- *       ip to abort_ip before returning to user-space, so the preempted
- *       execution resumes at abort_ip.
- *
- *   3.  Userspace critical section final instruction before
- *       post_commit_ip is the commit. The critical section is
- *       self-terminating.
- *       [post_commit_ip]
- *
- *   4.  <success>
- *
- *   On failure at [2], or if interrupted by preempt or signal delivery
- *   between [1] and [3]:
- *
- *       [abort_ip]
- *   F1. <failure>
- */
-
 static int rseq_update_cpu_node_id(struct task_struct *t)
 {
 	struct rseq __user *rseq =3D t->rseq;

