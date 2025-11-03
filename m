Return-Path: <linux-tip-commits+bounces-7192-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FEF0C2C9D6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:14:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B8C9420F23
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:59:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97CA3195E3;
	Mon,  3 Nov 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FOeS3PFJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T5Vqa8Im"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1B743191A1;
	Mon,  3 Nov 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181265; cv=none; b=XhKZRY6s46+IxP3/z2UWcKbTbyMeeHJcUTZw0+iV38K0dBze+TYHCUsOMvwTJDMVLb92Lv675bwqCzMPlxqDep9uHDfwhFCpVU4yu4VOuX2t4vN36xTG+Wfkx5ry263J4GZSYy9yG23/pqMrLTB/ya3GnKXgda4yeOqEMN40+oQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181265; c=relaxed/simple;
	bh=GHmQ6b+yyzrS6L/niN9oyKqO8OdyFZHhhG0F7ASMZYo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Pxfv4Hkk1lWSi5MNmQZYLrlDiag1gfeGUE0uMxUgk0WgByEWuQ0uPIH/749KUVfQEk+5QozQJojVUccQ+Y3UwY+bPGivpwwmv6YT2mTPys2c7ffqK+8xR5Iq+bwXyKx1Llg7roskqfVIxERCvepppyESHPP7Fzuxma5fQ2yuTQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOeS3PFJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T5Vqa8Im; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofXW8Mrq4E9i6Dci9QkJeLUpqoSSlvOiSmBuXo7xK38=;
	b=FOeS3PFJ9Y4GQ/+zyg7ArPlf1K2prbk4pz32a+LujGP6Fsfp3NZlnvtHZwQ/FRKkvf0m+g
	grZnhcrxMDT5BfCuyVgPFzCcOlRf5pMJAR1v8pCffVc28Ju2pltWMqZ5mfQQU4qHlfhDAB
	uKScW6FEmQU82hbY6F2KwKz2EiSjP210tUugNmXEUICcoqv85t2aUimfqQdo21VRMm4UuY
	af4JzWyNuuKCff5XEDjI5Ys8IfYpcfYJPriKKxXlL+dJeWYMfdFexVG1W/sqU9KC0Psz6P
	z2cvvEkGAEEkr0bDuFcsens5rZUvTMjrprAwB/A3d0187CB2MIXWl+nimCT0Wg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ofXW8Mrq4E9i6Dci9QkJeLUpqoSSlvOiSmBuXo7xK38=;
	b=T5Vqa8ImkLFD6MkG9WSxs16G/JUdybAbSLz22nxHYIEjuXR0biwBTq73qbh8LlgwLY/aQ9
	SlseGI6VpESHvkDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Cache CPU ID and MM CID values
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.841964081@linutronix.de>
References: <20251027084306.841964081@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218126126.2601451.8371398531889772177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     30c6409e123ce98429798c34595227dbe0496c1c
Gitweb:        https://git.kernel.org/tip/30c6409e123ce98429798c34595227dbe04=
96c1c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:16 +01:00

rseq: Cache CPU ID and MM CID values

In preparation for rewriting RSEQ exit to user space handling provide
storage to cache the CPU ID and MM CID values which were written to user
space. That prepares for a quick check, which avoids the update when
nothing changed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.841964081@linutronix.de
---
 include/linux/rseq.h        |  7 +++++--
 include/linux/rseq_types.h  | 21 +++++++++++++++++++++
 include/trace/events/rseq.h |  4 ++--
 kernel/rseq.c               |  4 ++++
 4 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/include/linux/rseq.h b/include/linux/rseq.h
index ab91b1e..d315a92 100644
--- a/include/linux/rseq.h
+++ b/include/linux/rseq.h
@@ -57,6 +57,7 @@ static inline void rseq_virt_userspace_exit(void)
 static inline void rseq_reset(struct task_struct *t)
 {
 	memset(&t->rseq, 0, sizeof(t->rseq));
+	t->rseq.ids.cpu_cid =3D ~0ULL;
 }
=20
 static inline void rseq_execve(struct task_struct *t)
@@ -70,10 +71,12 @@ static inline void rseq_execve(struct task_struct *t)
  */
 static inline void rseq_fork(struct task_struct *t, u64 clone_flags)
 {
-	if (clone_flags & CLONE_VM)
+	if (clone_flags & CLONE_VM) {
 		rseq_reset(t);
-	else
+	} else {
 		t->rseq =3D current->rseq;
+		t->rseq.ids.cpu_cid =3D ~0ULL;
+	}
 }
=20
 #else /* CONFIG_RSEQ */
diff --git a/include/linux/rseq_types.h b/include/linux/rseq_types.h
index f7a60c8..40901b0 100644
--- a/include/linux/rseq_types.h
+++ b/include/linux/rseq_types.h
@@ -31,17 +31,38 @@ struct rseq_event {
 };
=20
 /**
+ * struct rseq_ids - Cache for ids, which need to be updated
+ * @cpu_cid:	Compound of @cpu_id and @mm_cid to make the
+ *		compiler emit a single compare on 64-bit
+ * @cpu_id:	The CPU ID which was written last to user space
+ * @mm_cid:	The MM CID which was written last to user space
+ *
+ * @cpu_id and @mm_cid are updated when the data is written to user space.
+ */
+struct rseq_ids {
+	union {
+		u64		cpu_cid;
+		struct {
+			u32	cpu_id;
+			u32	mm_cid;
+		};
+	};
+};
+
+/**
  * struct rseq_data - Storage for all rseq related data
  * @usrptr:	Pointer to the registered user space RSEQ memory
  * @len:	Length of the RSEQ region
  * @sig:	Signature of critial section abort IPs
  * @event:	Storage for event management
+ * @ids:	Storage for cached CPU ID and MM CID
  */
 struct rseq_data {
 	struct rseq __user		*usrptr;
 	u32				len;
 	u32				sig;
 	struct rseq_event		event;
+	struct rseq_ids			ids;
 };
=20
 #else /* CONFIG_RSEQ */
diff --git a/include/trace/events/rseq.h b/include/trace/events/rseq.h
index 823b47d..ce85d65 100644
--- a/include/trace/events/rseq.h
+++ b/include/trace/events/rseq.h
@@ -21,9 +21,9 @@ TRACE_EVENT(rseq_update,
 	),
=20
 	TP_fast_assign(
-		__entry->cpu_id =3D raw_smp_processor_id();
+		__entry->cpu_id =3D t->rseq.ids.cpu_id;
 		__entry->node_id =3D cpu_to_node(__entry->cpu_id);
-		__entry->mm_cid =3D task_mm_cid(t);
+		__entry->mm_cid =3D t->rseq.ids.mm_cid;
 	),
=20
 	TP_printk("cpu_id=3D%d node_id=3D%d mm_cid=3D%d", __entry->cpu_id,
diff --git a/kernel/rseq.c b/kernel/rseq.c
index aae6266..ad1e7ce 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -184,6 +184,10 @@ static int rseq_update_cpu_node_id(struct task_struct *t)
 	rseq_unsafe_put_user(t, node_id, node_id, efault_end);
 	rseq_unsafe_put_user(t, mm_cid, mm_cid, efault_end);
=20
+	/* Cache the user space values */
+	t->rseq.ids.cpu_id =3D cpu_id;
+	t->rseq.ids.mm_cid =3D mm_cid;
+
 	/*
 	 * Additional feature fields added after ORIG_RSEQ_SIZE
 	 * need to be conditionally updated only if

