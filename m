Return-Path: <linux-tip-commits+bounces-7064-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C1FC19B7E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:28:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5C51A4FE192
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7679332EDC;
	Wed, 29 Oct 2025 10:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pi5qm4JB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="737rAmJQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8253321AC;
	Wed, 29 Oct 2025 10:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733426; cv=none; b=A0iWiM9Qf0iruXSTV2KMaCyipVky8EIWouL3P0gA+JnfWX5ObEwv4Lqk68tpVfwXfVi9Y9iuF+VjMizUVm7vzUMNqK3YMQ/P5y3Q6VyvCiZZC4MMjzlOxR0dAr0DTYPkEasm9MdsS1bHxT4JnPu9zAUWDr7tA+QtKiMVjYWGwaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733426; c=relaxed/simple;
	bh=Qb50ush5KJO2skG/ruJpbzG1YuC6Pc9NDuGut/KjixA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=coId16jDBk6REAl2JolTHT4jHOTp3fvi+oJOiTGSOirS8QUOhG4jZ0aH7o+yUs51uYsK+BnP6a6PWA1PtluN27xhB+KqvRln5uQCa3ulTl6rWPtc4jaHC+iwgKYkHYBi+M2ZLU1A8OnCFzbX0aNa5xSWGPQ1Ht46d7wLJVexWE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pi5qm4JB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=737rAmJQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBt2u1GYIDPUo0Icz8MTORSWFU2C7wDz+ikvKhFO/NI=;
	b=Pi5qm4JBVr41VYYtZjIXjzllm4fdSRUDnmDgzDG3HnfVAVHxXZ6CYkf7ZnmtGRBaKPeiah
	+MIJqMm+8GJR/iykaUgyiiy17zZH8LJOhm+ksCKekJmcsBnZ+qLym7HBFi2ZbMuRO+5Re8
	kifYHgFQo75+HH0i3nvDSjsiyrcsvKb+UUAsI7L9VQ81r9EwddS9oqyw/ODnoueAicDXbb
	FmNqDDqrUnZTDC7wXvMrMhU4/21jZgBjOWBiS81EBjF7R7C3F8CHZwJ6E7Uc3DE1W3ZoCJ
	u+PDV8PG65uGR7LFM4K/03pxJP6BCyb2qLYg8HeZ0zp/eVn6O1t4l5pVtIZnFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yBt2u1GYIDPUo0Icz8MTORSWFU2C7wDz+ikvKhFO/NI=;
	b=737rAmJQFbSda0g9lHq+sbTQiorDv1QtlxbdSPLrA+lLIqhp0fsWK30EPoWraHenoTjozH
	RGo9hIwEbxQUqBBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Replace the original debug implementation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084307.212510692@linutronix.de>
References: <20251027084307.212510692@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173342018.2601451.14872624720520370697.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     9674b4c51f437c35b7a0a385faf6c9bdebc1d3ab
Gitweb:        https://git.kernel.org/tip/9674b4c51f437c35b7a0a385faf6c9bdebc=
1d3ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:45:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:17 +01:00

rseq: Replace the original debug implementation

Just utilize the new infrastructure and put the original one to rest.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084307.212510692@linutronix.de
---
 kernel/rseq.c | 81 +++++++-------------------------------------------
 1 file changed, 12 insertions(+), 69 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 12a9b6a..07d9fa7 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -475,84 +475,27 @@ error:
=20
 #ifdef CONFIG_DEBUG_RSEQ
 /*
- * Unsigned comparison will be true when ip >=3D start_ip, and when
- * ip < start_ip + post_commit_offset.
- */
-static bool in_rseq_cs(unsigned long ip, struct rseq_cs *rseq_cs)
-{
-	return ip - rseq_cs->start_ip < rseq_cs->post_commit_offset;
-}
-
-/*
- * If the rseq_cs field of 'struct rseq' contains a valid pointer to
- * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
- */
-static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
-{
-	struct rseq __user *urseq =3D t->rseq.usrptr;
-	struct rseq_cs __user *urseq_cs;
-	u32 __user *usig;
-	u64 ptr;
-	u32 sig;
-	int ret;
-
-	if (get_user(ptr, &rseq->rseq_cs))
-		return -EFAULT;
-
-	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
-	if (!ptr) {
-		memset(rseq_cs, 0, sizeof(*rseq_cs));
-		return 0;
-	}
-	/* Check that the pointer value fits in the user-space process space. */
-	if (ptr >=3D TASK_SIZE)
-		return -EINVAL;
-	urseq_cs =3D (struct rseq_cs __user *)(unsigned long)ptr;
-	if (copy_from_user(rseq_cs, urseq_cs, sizeof(*rseq_cs)))
-		return -EFAULT;
-
-	if (rseq_cs->start_ip >=3D TASK_SIZE ||
-	    rseq_cs->start_ip + rseq_cs->post_commit_offset >=3D TASK_SIZE ||
-	    rseq_cs->abort_ip >=3D TASK_SIZE ||
-	    rseq_cs->version > 0)
-		return -EINVAL;
-	/* Check for overflow. */
-	if (rseq_cs->start_ip + rseq_cs->post_commit_offset < rseq_cs->start_ip)
-		return -EINVAL;
-	/* Ensure that abort_ip is not in the critical section. */
-	if (rseq_cs->abort_ip - rseq_cs->start_ip < rseq_cs->post_commit_offset)
-		return -EINVAL;
-
-	usig =3D (u32 __user *)(unsigned long)(rseq_cs->abort_ip - sizeof(u32));
-	ret =3D get_user(sig, usig);
-	if (ret)
-		return ret;
-
-	if (current->rseq.sig !=3D sig) {
-		printk_ratelimited(KERN_WARNING
-			"Possible attack attempt. Unexpected rseq signature 0x%x, expecting 0x%x =
(pid=3D%d, addr=3D%p).\n",
-			sig, current->rseq.sig, current->pid, usig);
-		return -EINVAL;
-	}
-	return 0;
-}
-
-/*
  * Terminate the process if a syscall is issued within a restartable
  * sequence.
  */
 void rseq_syscall(struct pt_regs *regs)
 {
-	unsigned long ip =3D instruction_pointer(regs);
 	struct task_struct *t =3D current;
-	struct rseq_cs rseq_cs;
+	u64 csaddr;
=20
-	if (!t->rseq.usrptr)
+	if (!t->rseq.event.has_rseq)
 		return;
-	if (rseq_get_rseq_cs(t, &rseq_cs) || in_rseq_cs(ip, &rseq_cs))
-		force_sig(SIGSEGV);
+	if (!get_user(csaddr, &t->rseq.usrptr->rseq_cs))
+		goto fail;
+	if (likely(!csaddr))
+		return;
+	if (unlikely(csaddr >=3D TASK_SIZE))
+		goto fail;
+	if (rseq_debug_update_user_cs(t, regs, csaddr))
+		return;
+fail:
+	force_sig(SIGSEGV);
 }
-
 #endif
=20
 /*

