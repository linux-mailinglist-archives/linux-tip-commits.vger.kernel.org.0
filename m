Return-Path: <linux-tip-commits+bounces-7193-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 467A2C2C8BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 891F23B18DF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 14:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5247531986C;
	Mon,  3 Nov 2025 14:47:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SOyIVG42";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wel1L5OB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB653191D6;
	Mon,  3 Nov 2025 14:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181267; cv=none; b=jxK3/1JAeZlywzWvmRf+ySUHdBYJNCIyAar3Okiaj65N/sHSz+rW/poiQsy6qwRZnumwxNZXOeBHsR50UjXQ33jxJnRy4RCx6b1hhpd0tXcqER8yZRAlr3HodY3x2jo7KbudI96YRWsNM0DE5gHI15J9yK5F4DuDfSKS75rGH+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181267; c=relaxed/simple;
	bh=oC7Fp7LoQuGiTv8/QFd9ACOaCd1Bh78rAtgdIqPABqo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FDbyrDVneItLUOuhbElzChLNYM15VHyDQOFkuG+V5cs3tZxofZZ5GWd7xod1MykqZaResS3PPLxfiSCYoBZx2cchVPo/KL6K/c2sxLTIH3E7lPlSB8tmDhfsPqxgsVSZVkgkW1ul4io+sbQvhUnbHPWC0kAoToS127+GiAD3vJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SOyIVG42; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wel1L5OB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181263;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkxczoTfpVjSW9u+qagoVCbdsJhpq5VVAjMdZ+m/aPA=;
	b=SOyIVG42tFjo7MjkdPIAbo8MkPovYwH1DizOlksPYTwC858jxYoKFYSFrsqfsDB4U0R7k8
	+bk4vwC9+qwzGv3VqO+oNiU9Vxz9Z3heHcBKnFFRoXWmlMCqpqPNQjwlKQSooaoJYt0qlZ
	bzwlJDO+OnGtUk8Mde45ggaWM7EA619Y1pa8RVL4qkl9ZwXHHD0gFa3Cr5snnWSKMcKiFd
	Molr6DuKb+vELbijvCsWD7oFvVrFGnP7cah1PIGaWXwbMqWGxceZed4fw51cEBW9CGt3bv
	m8smO5CGSizzYpJr/mi9dUKWjuoKemPJy2NHTL33ZVXl26+QrffR8040yqcr3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fkxczoTfpVjSW9u+qagoVCbdsJhpq5VVAjMdZ+m/aPA=;
	b=Wel1L5OBFIMUlEJzRhqKGGgnePLo+ttC7IRjmBQBgQ58tgojvnzkPd7uYkLtG8KfTeqtQi
	XfhdMyGdaMdHigBQ==
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
Message-ID: <176218126253.2601451.14235050332662027568.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     73b4efcabadc3278686af88b792bee8355f3f09e
Gitweb:        https://git.kernel.org/tip/73b4efcabadc3278686af88b792bee8355f=
3f09e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:16 +01:00

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
index 1562776..24a9da7 100644
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

