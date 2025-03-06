Return-Path: <linux-tip-commits+bounces-4037-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32EF1A55907
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 22:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CE218988B6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 21:44:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E90D249E5;
	Thu,  6 Mar 2025 21:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KwVhrkrc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QNFICH44"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C6232770B;
	Thu,  6 Mar 2025 21:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741297448; cv=none; b=G5E4GaHrLcrVQjfj3J/BMExOMOYss2MdLV+pM0mHsn03XfPK8ekpwVPuyTUit9vk4h8b1w1e1U2I5YzUbPchqJBX/B58530m2Z9bK+Wjp2l2aMDwGSj6VfxNkKt8TTSp/5bbrQ3Tp+If3D6Zd46PMAgj/+Ju7uNxlcWGJNJqoRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741297448; c=relaxed/simple;
	bh=vIDPFdcIQsK2yn6F8srF6rsyapyfD7uRrCI/ehlgppA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uvz7VwvgxeqZwfyREFy5CuKvLJzCqmXCO+EzIq1Clp0Bkuizlx8ciuQ4M/UflwkSfDkhPI1zxmdxfv4wZehiORL/xR3sQS/S+tobrvv3ZyqHu+4175gvWBmEvX2ntMsq3BwrloJLsrqBnfFvawi+GLoO7FQ0Up9EyweF5baZ5E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KwVhrkrc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QNFICH44; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 21:44:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741297444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBbX+unALGmbgkrG93JWzPul4iVf1dsagdd6bL2PSEA=;
	b=KwVhrkrc/KOoSfhRiOGR3cqftXyQ5YXvZnmxkVClJyphT/fguUSZebYCzzQeIoYPHQDzFY
	8nBVniK9ME++g/OX9JaH2nVljlaxS7d9bqw5RpGxvjjKW5U4zEiYeDUQSEC9pv7h2CJlIJ
	DHSQAJfVIS7Gf9vDztGYrtqy4cerQi/5w7xResyEgSlDNQPnMMgpoTF8M1TNa1jyDAyeAl
	0ZzXFluSh14nGolIhONJewu8klqTLQUXeoFTg8S1w5hfDxExmvXadubXK9PhkX8BlLtDhL
	iGrv5vZAT7BeYEWPFqdiPyma0XETlOmVpx5zASXrH63gtHnhv4btBJtoqgULpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741297444;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bBbX+unALGmbgkrG93JWzPul4iVf1dsagdd6bL2PSEA=;
	b=QNFICH442JPbOPk9FunC/NuJIuplCql2SnCKfjLC3NIp8ibsGx5dup5s5rZFZkMMFzlxQS
	5rQL8EW9EwcriZDQ==
From: "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] rseq: Fix segfault on registration when rseq_cs is non-zero
Cc: Michael Jeanson <mjeanson@efficios.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306211223.109455-1-mjeanson@efficios.com>
References: <20250306211223.109455-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174129744100.14745.4036542013398635459.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fd881d0a085fc54354414aed990ccf05f282ba53
Gitweb:        https://git.kernel.org/tip/fd881d0a085fc54354414aed990ccf05f282ba53
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Thu, 06 Mar 2025 16:12:21 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 22:26:49 +01:00

rseq: Fix segfault on registration when rseq_cs is non-zero

The rseq_cs field is documented as being set to 0 by user-space prior to
registration, however this is not currently enforced by the kernel. This
can result in a segfault on return to user-space if the value stored in
the rseq_cs field doesn't point to a valid struct rseq_cs.

The correct solution to this would be to fail the rseq registration when
the rseq_cs field is non-zero. However, some older versions of glibc
will reuse the rseq area of previous threads without clearing the
rseq_cs field and will also terminate the process if the rseq
registration fails in a secondary thread. This wasn't caught in testing
because in this case the leftover rseq_cs does point to a valid struct
rseq_cs.

What we can do is clear the rseq_cs field on registration when it's
non-zero which will prevent segfaults on registration and won't break
the glibc versions that reuse rseq areas on thread creation.

Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250306211223.109455-1-mjeanson@efficios.com
---
 kernel/rseq.c | 60 ++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index a7d8122..b7a1ec3 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -236,6 +236,29 @@ efault:
 	return -EFAULT;
 }
 
+/*
+ * Get the user-space pointer value stored in the 'rseq_cs' field.
+ */
+static int rseq_get_rseq_cs_ptr_val(struct rseq __user *rseq, u64 *rseq_cs)
+{
+	if (!rseq_cs)
+		return -EFAULT;
+
+#ifdef CONFIG_64BIT
+	if (get_user(*rseq_cs, &rseq->rseq_cs))
+		return -EFAULT;
+#else
+	if (copy_from_user(rseq_cs, &rseq->rseq_cs, sizeof(*rseq_cs)))
+		return -EFAULT;
+#endif
+
+	return 0;
+}
+
+/*
+ * If the rseq_cs field of 'struct rseq' contains a valid pointer to
+ * user-space, copy 'struct rseq_cs' from user-space and validate its fields.
+ */
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 {
 	struct rseq_cs __user *urseq_cs;
@@ -244,17 +267,16 @@ static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)
 	u32 sig;
 	int ret;
 
-#ifdef CONFIG_64BIT
-	if (get_user(ptr, &t->rseq->rseq_cs))
-		return -EFAULT;
-#else
-	if (copy_from_user(&ptr, &t->rseq->rseq_cs, sizeof(ptr)))
-		return -EFAULT;
-#endif
+	ret = rseq_get_rseq_cs_ptr_val(t->rseq, &ptr);
+	if (ret)
+		return ret;
+
+	/* If the rseq_cs pointer is NULL, return a cleared struct rseq_cs. */
 	if (!ptr) {
 		memset(rseq_cs, 0, sizeof(*rseq_cs));
 		return 0;
 	}
+	/* Check that the pointer value fits in the user-space process space. */
 	if (ptr >= TASK_SIZE)
 		return -EINVAL;
 	urseq_cs = (struct rseq_cs __user *)(unsigned long)ptr;
@@ -330,7 +352,7 @@ static int rseq_need_restart(struct task_struct *t, u32 cs_flags)
 	return !!event_mask;
 }
 
-static int clear_rseq_cs(struct task_struct *t)
+static int clear_rseq_cs(struct rseq __user *rseq)
 {
 	/*
 	 * The rseq_cs field is set to NULL on preemption or signal
@@ -341,9 +363,9 @@ static int clear_rseq_cs(struct task_struct *t)
 	 * Set rseq_cs to NULL.
 	 */
 #ifdef CONFIG_64BIT
-	return put_user(0UL, &t->rseq->rseq_cs);
+	return put_user(0UL, &rseq->rseq_cs);
 #else
-	if (clear_user(&t->rseq->rseq_cs, sizeof(t->rseq->rseq_cs)))
+	if (clear_user(&rseq->rseq_cs, sizeof(rseq->rseq_cs)))
 		return -EFAULT;
 	return 0;
 #endif
@@ -375,11 +397,11 @@ static int rseq_ip_fixup(struct pt_regs *regs)
 	 * Clear the rseq_cs pointer and return.
 	 */
 	if (!in_rseq_cs(ip, &rseq_cs))
-		return clear_rseq_cs(t);
+		return clear_rseq_cs(t->rseq);
 	ret = rseq_need_restart(t, rseq_cs.flags);
 	if (ret <= 0)
 		return ret;
-	ret = clear_rseq_cs(t);
+	ret = clear_rseq_cs(t->rseq);
 	if (ret)
 		return ret;
 	trace_rseq_ip_fixup(ip, rseq_cs.start_ip, rseq_cs.post_commit_offset,
@@ -453,6 +475,7 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		int, flags, u32, sig)
 {
 	int ret;
+	u64 rseq_cs;
 
 	if (flags & RSEQ_FLAG_UNREGISTER) {
 		if (flags & ~RSEQ_FLAG_UNREGISTER)
@@ -507,6 +530,19 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 		return -EINVAL;
 	if (!access_ok(rseq, rseq_len))
 		return -EFAULT;
+
+	/*
+	 * If the rseq_cs pointer is non-NULL on registration, clear it to
+	 * avoid a potential segfault on return to user-space. The proper thing
+	 * to do would have been to fail the registration but this would break
+	 * older libcs that reuse the rseq area for new threads without
+	 * clearing the fields.
+	 */
+	if (rseq_get_rseq_cs_ptr_val(rseq, &rseq_cs))
+	        return -EFAULT;
+	if (rseq_cs && clear_rseq_cs(rseq))
+		return -EFAULT;
+
 #ifdef CONFIG_DEBUG_RSEQ
 	/*
 	 * Initialize the in-kernel rseq fields copy for validation of

