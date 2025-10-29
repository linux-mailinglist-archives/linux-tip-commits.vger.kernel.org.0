Return-Path: <linux-tip-commits+bounces-7071-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DA27EC19BC0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:29:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EBD7B5074A3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:27:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D15CC331A72;
	Wed, 29 Oct 2025 10:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IrLr3R8U";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eBmDmFm0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 101CA334C1B;
	Wed, 29 Oct 2025 10:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733434; cv=none; b=KgO2fHdjdu12OAPtv4ommoNc/UgZ7oCEib5HqxTViRXUSBlMkfiB1B5DAr3XV8h32kJ1/oPhYypWTB8uZhkZ6rQwdUl+SheuYR8X6Vdi9mCBJfNPnHMjYXYzZlkX20JEsnPephP8EvtHMWWGY/B/6OGsbkWhusjfEdWjBlMVaYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733434; c=relaxed/simple;
	bh=li3vEZJfctfyVZPoA0Wg5OUh/SdCL1X/FaZt0mRGxTM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nkDOOUST7Cb33zpjbyaY9PmvUpOkOyVyGfCN78tLfJBuMM7PSos03gGZdfURe16EswTSvzrgKa2NraZ9mjvsqR0Lv56QcnwmTnuJ9Ms4T/xxZZ2PyRAriSyDxPGBJ40IS6pveBu5sVYpDsdYMNXevvm8FhXFiDmr8goIKsxAMfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IrLr3R8U; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eBmDmFm0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEJO5UluDcMoihqsffsMcElNqOCvovOQ40KtrjL4aNc=;
	b=IrLr3R8Uj0bQSVK9lzEbKyyDDbhohX4OGVutnNiUkHGGqnBunt9mbPd+cG8pOs0rHNgMrP
	Xw9opco+0QiHhADDw5udmCaP++XUmUBcU69VtjWsCXi5TX+e7jOOiPbMMJeI5sIOPsrNt/
	yvEZ4iXYGAP6e60wMFZTAaY5jSd8XyYWT2aiZW4WL+m2i9RSCvbbJHsF0qOzPyGjoF5OX5
	STo3GUr4gWE3dtajBf/OJvxL/jyV2RXKsNvDU3sjN4e6wb+91uCs2XrgTH4Gfd2Rog7GIH
	lescbcSmN/SMiviPI6wWGk9HGSDu9EJK31CYDrC1IvnGyQn4JTM5IxeJXI606A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HEJO5UluDcMoihqsffsMcElNqOCvovOQ40KtrjL4aNc=;
	b=eBmDmFm07Zif73qzYM5/n+tXmyc3j3oyRjQbZNiQm9o4qgwr24uOR+q68vMGSQoRwaWWr7
	A4zNkaMaG+Z/u+CQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched: Move MM CID related functions to sched.h
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.778457951@linutronix.de>
References: <20251027084306.778457951@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173342888.2601451.14705894087273907072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     47a507c0f0c93f6a0ae8bc4dfc049d000e9bd50a
Gitweb:        https://git.kernel.org/tip/47a507c0f0c93f6a0ae8bc4dfc049d000e9=
bd50a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:14 +01:00

sched: Move MM CID related functions to sched.h

There is nothing mm specific in that and including mm.h can cause header
recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.778457951@linutronix.de
---
 include/linux/mm.h    | 25 -------------------------
 include/linux/sched.h | 26 ++++++++++++++++++++++++++
 2 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33b..17cfbba 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2401,31 +2401,6 @@ struct zap_details {
 /* Set in unmap_vmas() to indicate a final unmap call.  Only used by hugetlb=
 */
 #define  ZAP_FLAG_UNMAP              ((__force zap_flags_t) BIT(1))
=20
-#ifdef CONFIG_SCHED_MM_CID
-void sched_mm_cid_before_execve(struct task_struct *t);
-void sched_mm_cid_after_execve(struct task_struct *t);
-void sched_mm_cid_fork(struct task_struct *t);
-void sched_mm_cid_exit_signals(struct task_struct *t);
-static inline int task_mm_cid(struct task_struct *t)
-{
-	return t->mm_cid;
-}
-#else
-static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
-static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
-static inline void sched_mm_cid_fork(struct task_struct *t) { }
-static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
-static inline int task_mm_cid(struct task_struct *t)
-{
-	/*
-	 * Use the processor id as a fall-back when the mm cid feature is
-	 * disabled. This provides functional per-cpu data structure accesses
-	 * in user-space, althrough it won't provide the memory usage benefits.
-	 */
-	return raw_smp_processor_id();
-}
-#endif
-
 #ifdef CONFIG_MMU
 extern bool can_do_mlock(void);
 #else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e64bff3..d6e59c8 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2310,6 +2310,32 @@ static __always_inline void alloc_tag_restore(struct a=
lloc_tag *tag, struct allo
 #define alloc_tag_restore(_tag, _old)		do {} while (0)
 #endif
=20
+/* Avoids recursive inclusion hell */
+#ifdef CONFIG_SCHED_MM_CID
+void sched_mm_cid_before_execve(struct task_struct *t);
+void sched_mm_cid_after_execve(struct task_struct *t);
+void sched_mm_cid_fork(struct task_struct *t);
+void sched_mm_cid_exit_signals(struct task_struct *t);
+static inline int task_mm_cid(struct task_struct *t)
+{
+	return t->mm_cid;
+}
+#else
+static inline void sched_mm_cid_before_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_after_execve(struct task_struct *t) { }
+static inline void sched_mm_cid_fork(struct task_struct *t) { }
+static inline void sched_mm_cid_exit_signals(struct task_struct *t) { }
+static inline int task_mm_cid(struct task_struct *t)
+{
+	/*
+	 * Use the processor id as a fall-back when the mm cid feature is
+	 * disabled. This provides functional per-cpu data structure accesses
+	 * in user-space, althrough it won't provide the memory usage benefits.
+	 */
+	return task_cpu(t);
+}
+#endif
+
 #ifndef MODULE
 #ifndef COMPILE_OFFSETS
=20

