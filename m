Return-Path: <linux-tip-commits+bounces-3687-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D82A46537
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 16:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 523603B5708
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 15:37:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5367421D5B1;
	Wed, 26 Feb 2025 15:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tc26uTk9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+zlWQVqG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CC21D5A8;
	Wed, 26 Feb 2025 15:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740584087; cv=none; b=cJAttJj9y92wQRH/Yzozv7aY23dYKWpgBylnvmvk4X9seApsHVljt3lLkDSgOFOEtlEpKSr/ObbVMDSZhvBWkcZhG9aD7Qqf2exWSWhXx7BFUESPc3csFVO/lD9m8mFg9dDjctVwDuknxXmYvttQs3Y5gjqRnSuq4hjlKsSwJbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740584087; c=relaxed/simple;
	bh=hmkvwcTIdYAvDNtqq/5w7MBuFB4NLwEVUX8gu5GXASc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=B43C+Zaa5QBmhH9GZP8af26AQfnna/a46DYzL6+mLSBQ5Jl/mPXqwTxM18Ln/fF8h3Wjvwu27sMz2fzUPbPy1pbKTnVNC0HTQgQutzXVGgsy6AoHaWXrBgO12EDHktrjjplve0fXcrmr5ZEM3G7tFU7X6FOIkt1n8kbVVU+P+lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tc26uTk9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+zlWQVqG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 15:34:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740584083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68nDCmc0e5uDwQm6onA+XKw91++5cI8pdO7sHEgoBJc=;
	b=tc26uTk9v65yj6NI/H5C4iUwtuKswi3jRKdeJDl1aNpqOfJxAooPlehzfJmoa61LDtcVXf
	2YRF7pnyGOD5zOxFbeX6qfZtOFC7jO4iuRmjlT7Oorzlb42ur/SserClLC9VvJPDV4j/kb
	8dWU7KCnExBPDrB5Gqe2HcwETRjWOhTs9323O/yUUSLU5yfcXb/2ZvKWx2ozlXf9lodpjn
	0G2vXnvVw4TvgYlrPpRKa92BdMj1+jm79lfd61SmRLWJS1crXeBzE6isEoBDJPPPQ1PI1o
	IJsjCTuy8g2guU77bT0ICr/PREf6vWHp1KFlqqXuq9wmgWQ5/rQwheI713cKGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740584083;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=68nDCmc0e5uDwQm6onA+XKw91++5cI8pdO7sHEgoBJc=;
	b=+zlWQVqGt3stOxe+fVfvBvX7jUBAa29v53iwBoWtyBzCTpodujmzFXsu5/EY1P9tgQuVwU
	J7HaPs9UXJ7Q/JCg==
From: "tip-bot2 for Michael Jeanson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] rseq: Update kernel fields in lockstep with
 CONFIG_DEBUG_RSEQ=y
Cc: Michael Jeanson <mjeanson@efficios.com>, Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250225202500.731245-1-mjeanson@efficios.com>
References: <20250225202500.731245-1-mjeanson@efficios.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174058407855.10177.734490277457259426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     79e10dad1ce3feac7937bedf911d92f486a9e76a
Gitweb:        https://git.kernel.org/tip/79e10dad1ce3feac7937bedf911d92f486a9e76a
Author:        Michael Jeanson <mjeanson@efficios.com>
AuthorDate:    Tue, 25 Feb 2025 15:24:46 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Feb 2025 16:20:23 +01:00

rseq: Update kernel fields in lockstep with CONFIG_DEBUG_RSEQ=y

With CONFIG_DEBUG_RSEQ=y, an in-kernel copy of the read-only fields is
kept synchronized with the user-space fields. Ensure the updates are
done in lockstep in case we error out on a write to user-space.

Fixes: 7d5265ffcd8b ("rseq: Validate read-only fields under DEBUG_RSEQ config")
Signed-off-by: Michael Jeanson <mjeanson@efficios.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://lore.kernel.org/r/20250225202500.731245-1-mjeanson@efficios.com
---
 kernel/rseq.c | 80 +++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/kernel/rseq.c b/kernel/rseq.c
index 442aba2..3d136c4 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -78,24 +78,24 @@ efault:
 	return -EFAULT;
 }
 
-static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
-			       u32 node_id, u32 mm_cid)
-{
-	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
-	rseq_kernel_fields(t)->cpu_id = cpu_id;
-	rseq_kernel_fields(t)->node_id = node_id;
-	rseq_kernel_fields(t)->mm_cid = mm_cid;
-}
+/*
+ * Update an rseq field and its in-kernel copy in lock-step to keep a coherent
+ * state.
+ */
+#define rseq_unsafe_put_user(t, value, field, error_label)		\
+	do {								\
+		unsafe_put_user(value, &t->rseq->field, error_label);	\
+		rseq_kernel_fields(t)->field = value;			\
+	} while (0)
+
 #else
 static int rseq_validate_ro_fields(struct task_struct *t)
 {
 	return 0;
 }
 
-static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
-			       u32 node_id, u32 mm_cid)
-{
-}
+#define rseq_unsafe_put_user(t, value, field, error_label)		\
+	unsafe_put_user(value, &t->rseq->field, error_label)
 #endif
 
 /*
@@ -173,17 +173,18 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
-	unsafe_put_user(cpu_id, &rseq->cpu_id_start, efault_end);
-	unsafe_put_user(cpu_id, &rseq->cpu_id, efault_end);
-	unsafe_put_user(node_id, &rseq->node_id, efault_end);
-	unsafe_put_user(mm_cid, &rseq->mm_cid, efault_end);
+
+	rseq_unsafe_put_user(t, cpu_id, cpu_id_start, efault_end);
+	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
+	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
+	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
 	user_write_access_end();
-	rseq_set_ro_fields(t, cpu_id, cpu_id, node_id, mm_cid);
 	trace_rseq_update(t);
 	return 0;
 
@@ -195,6 +196,7 @@ efault:
 
 static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 {
+	struct rseq __user *rseq = t->rseq;
 	u32 cpu_id_start = 0, cpu_id = RSEQ_CPU_ID_UNINITIALIZED, node_id = 0,
 	    mm_cid = 0;
 
@@ -202,38 +204,36 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 * Validate read-only rseq fields.
 	 */
 	if (rseq_validate_ro_fields(t))
-		return -EFAULT;
-	/*
-	 * Reset cpu_id_start to its initial state (0).
-	 */
-	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
-		return -EFAULT;
-	/*
-	 * Reset cpu_id to RSEQ_CPU_ID_UNINITIALIZED, so any user coming
-	 * in after unregistration can figure out that rseq needs to be
-	 * registered again.
-	 */
-	if (put_user(cpu_id, &t->rseq->cpu_id))
-		return -EFAULT;
-	/*
-	 * Reset node_id to its initial state (0).
-	 */
-	if (put_user(node_id, &t->rseq->node_id))
-		return -EFAULT;
+		goto efault;
+
+	if (!user_write_access_begin(rseq, t->rseq_len))
+		goto efault;
+
 	/*
-	 * Reset mm_cid to its initial state (0).
+	 * Reset all fields to their initial state.
+	 *
+	 * All fields have an initial state of 0 except cpu_id which is set to
+	 * RSEQ_CPU_ID_UNINITIALIZED, so that any user coming in after
+	 * unregistration can figure out that rseq needs to be registered
+	 * again.
 	 */
-	if (put_user(mm_cid, &t->rseq->mm_cid))
-		return -EFAULT;
-
-	rseq_set_ro_fields(t, cpu_id_start, cpu_id, node_id, mm_cid);
+	rseq_unsafe_put_user(t, cpu_id_start, cpu_id_start, efault_end);
+	rseq_unsafe_put_user(t, cpu_id, cpu_id, efault_end);
+	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
+	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
 
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
+	user_write_access_end();
 	return 0;
+
+efault_end:
+	user_write_access_end();
+efault:
+	return -EFAULT;
 }
 
 static int rseq_get_rseq_cs(struct task_struct *t, struct rseq_cs *rseq_cs)

