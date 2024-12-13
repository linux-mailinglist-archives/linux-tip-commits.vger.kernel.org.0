Return-Path: <linux-tip-commits+bounces-3055-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C8529F0BE4
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 13:06:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2823188AA6A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Dec 2024 12:06:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4B781DF74C;
	Fri, 13 Dec 2024 12:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pWuM8N2n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fw67M0DN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CA501DF26E;
	Fri, 13 Dec 2024 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734091566; cv=none; b=IqKdwWn1Glk0vTWqqmz89bP4s3BvlWDJxtd7qUavemLWvmpRqkjIBTLirauRzrtnjJzqQQWedH+bD+SscotBnB9XgdkA6RnuzymqEcCnaFu2ik87sHIxyfHBIl1w2Iu5PdrNYA4Vu9OcBD55vSC9qwNlq8loh6BmoVdk9nws8Gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734091566; c=relaxed/simple;
	bh=P3iIA3c/cfrtd1ujJO2f7u3hFiP3w/LrP/66A9f8yvE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=CAqiID9LaplMBYPehgn38hk2SKa8RJS8evhufKB1wosoQSDeOhyde4+5Z+8B6sPIMVldaO5zwpJYQJFwe5dw83TDQAYQLbKANDqFFkZUobrss3HnML+/hJOVIv2ULHQYWUKrAaMaIUAVwsmMaiWMzPJbNt5oAf8zQm2Qin5sl7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pWuM8N2n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fw67M0DN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Dec 2024 12:05:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734091560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4crqebXAYF6SNRL66OjyqG3hO2jYjbJaeb+VpLLSTVc=;
	b=pWuM8N2nJBcLUyxHTTL/Ta40A/9jjxnE7wYydYVxDzGCmWY3Vj3e9R782F6KCD/Th3op95
	3rzPeybZ+cljxrPl+MMkEL6sbAwSKsQyDRa4/DOksBto08LKfYf7+dWYdQadNvkgosOB9L
	BNLnkW0gnP0XgV2SlKTVt1lUqDLemb9BmlU8y5wJwbhnOorGvE8XyE3PIAL19cdgMoPG1r
	mlbrV7bDTV6+2FKSN5wdB3vewm5+DcKDrjEBsjB2oZFXx55HshntbfU220GC0ZALf/YvoZ
	Jz42bepGh1qrOHkj2oVxTMmTw0Ptg2G6V77wS5hxTNb3q4nYHtyvoxWFXwdJ3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734091560;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4crqebXAYF6SNRL66OjyqG3hO2jYjbJaeb+VpLLSTVc=;
	b=fw67M0DNLA4Jlfl/c/rJ0XEd82Cj6lsbi5EqkExr7PfU/3sV4Vxg1JYZBkkxmj9+p+VOOW
	/v0y7YaJjrC2jPCA==
From: "tip-bot2 for Mathieu Desnoyers" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] rseq: Validate read-only fields under DEBUG_RSEQ config
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173409155946.412.11130114879533345524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7d5265ffcd8b41da5e09066360540d6e0716e9cd
Gitweb:        https://git.kernel.org/tip/7d5265ffcd8b41da5e09066360540d6e0716e9cd
Author:        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
AuthorDate:    Tue, 12 Nov 2024 10:28:26 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Dec 2024 15:07:06 +01:00

rseq: Validate read-only fields under DEBUG_RSEQ config

The rseq uapi requires cooperation between users of the rseq fields
to ensure that all libraries and applications using rseq within a
process do not interfere with each other.

This is especially important for fields which are meant to be read-only
from user-space, as documented in uapi/linux/rseq.h:

  - cpu_id_start,
  - cpu_id,
  - node_id,
  - mm_cid.

Storing to those fields from a user-space library prevents any sharing
of the rseq ABI with other libraries and applications, as other users
are not aware that the content of those fields has been altered by a
third-party library.

This is unfortunately the current behavior of tcmalloc: it purposefully
overlaps part of a cached value with the cpu_id_start upper bits to get
notified about preemption, because the kernel clears those upper bits
before returning to user-space. This behavior does not conform to the
rseq uapi header ABI.

This prevents tcmalloc from using rseq when rseq is registered by the
GNU C library 2.35+. It requires tcmalloc users to disable glibc rseq
registration with a glibc tunable, which is a sad state of affairs.

Considering that tcmalloc and the GNU C library are the two first
upstream projects using rseq, and that they are already incompatible due
to use of this hack, adding kernel-level validation of all read-only
fields content is necessary to ensure future users of rseq abide by the
rseq ABI requirements.

Validate that user-space does not corrupt the read-only fields and
conform to the rseq uapi header ABI when the kernel is built with
CONFIG_DEBUG_RSEQ=y. This is done by storing a copy of the read-only
fields in the task_struct, and validating the prior values present in
user-space before updating them. If the values do not match, print
a warning on the console (printk_ratelimited()).

This is a first step to identify misuses of the rseq ABI by printing
a warning on the console. After a giving some time to userspace to
correct its use of rseq, the plan is to eventually terminate offending
processes with SIGSEGV.

This change is expected to produce warnings for the upstream tcmalloc
implementation, but tcmalloc developers mentioned they were open to
adapt their implementation to kernel-level change.

Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/google/tcmalloc/issues/144
---
 include/linux/sched.h |  9 ++++-
 kernel/rseq.c         | 98 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 107 insertions(+)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bff..b5916be 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1367,6 +1367,15 @@ struct task_struct {
 	 * with respect to preemption.
 	 */
 	unsigned long rseq_event_mask;
+# ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * This is a place holder to save a copy of the rseq fields for
+	 * validation of read-only fields. The struct rseq has a
+	 * variable-length array at the end, so it cannot be used
+	 * directly. Reserve a size large enough for the known fields.
+	 */
+	char				rseq_fields[sizeof(struct rseq)];
+# endif
 #endif
 
 #ifdef CONFIG_SCHED_MM_CID
diff --git a/kernel/rseq.c b/kernel/rseq.c
index 9de6e35..e04bb30 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -13,6 +13,7 @@
 #include <linux/syscalls.h>
 #include <linux/rseq.h>
 #include <linux/types.h>
+#include <linux/ratelimit.h>
 #include <asm/ptrace.h>
 
 #define CREATE_TRACE_POINTS
@@ -25,6 +26,78 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
 
+#ifdef CONFIG_DEBUG_RSEQ
+static struct rseq *rseq_kernel_fields(struct task_struct *t)
+{
+	return (struct rseq *) t->rseq_fields;
+}
+
+static int rseq_validate_ro_fields(struct task_struct *t)
+{
+	static DEFINE_RATELIMIT_STATE(_rs,
+				      DEFAULT_RATELIMIT_INTERVAL,
+				      DEFAULT_RATELIMIT_BURST);
+	u32 cpu_id_start, cpu_id, node_id, mm_cid;
+	struct rseq __user *rseq = t->rseq;
+
+	/*
+	 * Validate fields which are required to be read-only by
+	 * user-space.
+	 */
+	if (!user_read_access_begin(rseq, t->rseq_len))
+		goto efault;
+	unsafe_get_user(cpu_id_start, &rseq->cpu_id_start, efault_end);
+	unsafe_get_user(cpu_id, &rseq->cpu_id, efault_end);
+	unsafe_get_user(node_id, &rseq->node_id, efault_end);
+	unsafe_get_user(mm_cid, &rseq->mm_cid, efault_end);
+	user_read_access_end();
+
+	if ((cpu_id_start != rseq_kernel_fields(t)->cpu_id_start ||
+	    cpu_id != rseq_kernel_fields(t)->cpu_id ||
+	    node_id != rseq_kernel_fields(t)->node_id ||
+	    mm_cid != rseq_kernel_fields(t)->mm_cid) && __ratelimit(&_rs)) {
+
+		pr_warn("Detected rseq corruption for pid: %d, name: %s\n"
+			"\tcpu_id_start: %u ?= %u\n"
+			"\tcpu_id:       %u ?= %u\n"
+			"\tnode_id:      %u ?= %u\n"
+			"\tmm_cid:       %u ?= %u\n",
+			t->pid, t->comm,
+			cpu_id_start, rseq_kernel_fields(t)->cpu_id_start,
+			cpu_id, rseq_kernel_fields(t)->cpu_id,
+			node_id, rseq_kernel_fields(t)->node_id,
+			mm_cid, rseq_kernel_fields(t)->mm_cid);
+	}
+
+	/* For now, only print a console warning on mismatch. */
+	return 0;
+
+efault_end:
+	user_read_access_end();
+efault:
+	return -EFAULT;
+}
+
+static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
+			       u32 node_id, u32 mm_cid)
+{
+	rseq_kernel_fields(t)->cpu_id_start = cpu_id;
+	rseq_kernel_fields(t)->cpu_id = cpu_id;
+	rseq_kernel_fields(t)->node_id = node_id;
+	rseq_kernel_fields(t)->mm_cid = mm_cid;
+}
+#else
+static int rseq_validate_ro_fields(struct task_struct *t)
+{
+	return 0;
+}
+
+static void rseq_set_ro_fields(struct task_struct *t, u32 cpu_id_start, u32 cpu_id,
+			       u32 node_id, u32 mm_cid)
+{
+}
+#endif
+
 /*
  *
  * Restartable sequences are a lightweight interface that allows
@@ -92,6 +165,11 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	u32 node_id = cpu_to_node(cpu_id);
 	u32 mm_cid = task_mm_cid(t);
 
+	/*
+	 * Validate read-only rseq fields.
+	 */
+	if (rseq_validate_ro_fields(t))
+		goto efault;
 	WARN_ON_ONCE((int) mm_cid < 0);
 	if (!user_write_access_begin(rseq, t->rseq_len))
 		goto efault;
@@ -105,6 +183,7 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	 * t->rseq_len != ORIG_RSEQ_SIZE.
 	 */
 	user_write_access_end();
+	rseq_set_ro_fields(t, cpu_id, cpu_id, node_id, mm_cid);
 	trace_rseq_update(t);
 	return 0;
 
@@ -120,6 +199,11 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	    mm_cid = 0;
 
 	/*
+	 * Validate read-only rseq fields.
+	 */
+	if (!rseq_validate_ro_fields(t))
+		return -EFAULT;
+	/*
 	 * Reset cpu_id_start to its initial state (0).
 	 */
 	if (put_user(cpu_id_start, &t->rseq->cpu_id_start))
@@ -141,6 +225,9 @@ static int rseq_reset_rseq_cpu_node_id(struct task_struct *t)
 	 */
 	if (put_user(mm_cid, &t->rseq->mm_cid))
 		return -EFAULT;
+
+	rseq_set_ro_fields(t, cpu_id_start, cpu_id, node_id, mm_cid);
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally reset only if
@@ -423,6 +510,17 @@ SYSCALL_DEFINE4(rseq, struct rseq __user *, rseq, u32, rseq_len,
 	current->rseq = rseq;
 	current->rseq_len = rseq_len;
 	current->rseq_sig = sig;
+#ifdef CONFIG_DEBUG_RSEQ
+	/*
+	 * Initialize the in-kernel rseq fields copy for validation of
+	 * read-only fields.
+	 */
+	if (get_user(rseq_kernel_fields(current)->cpu_id_start, &rseq->cpu_id_start) ||
+	    get_user(rseq_kernel_fields(current)->cpu_id, &rseq->cpu_id) ||
+	    get_user(rseq_kernel_fields(current)->node_id, &rseq->node_id) ||
+	    get_user(rseq_kernel_fields(current)->mm_cid, &rseq->mm_cid))
+		return -EFAULT;
+#endif
 	/*
 	 * If rseq was previously inactive, and has just been
 	 * registered, ensure the cpu_id_start and cpu_id fields

