Return-Path: <linux-tip-commits+bounces-7240-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF7D0C2FD2B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:21:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57E0D3B0B6E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797BD31A81C;
	Tue,  4 Nov 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6OIcjgO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6GH/5Q1C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93B363195F1;
	Tue,  4 Nov 2025 08:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244251; cv=none; b=WLCqLSajSmKZlAe0zPwPpgfSR2utkaWqN4jnsvcp3yDapdLHXKZeAZAIl91NHy77ZMVY9iXktYMI1TSaSEcq5fBNXUsPk8FyE/ZIg+oEMMapCYI+FEPJEjlNJuF1duJlWA078XmYYMV/VMSC42kwE5IZiGclT9rGMuR3hN/3aLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244251; c=relaxed/simple;
	bh=USPqYNALTpZFEacDbFVhmTgaTCsCvgxxrPF3MTvFOMY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fvut5dEdOdtvyNZQ0+irryJ2RSq4Wb08Mron8TdkpNl4D+7oWLTy0iMF1uAXSkRzSlFdoBh86bN2Fq2nQQyPZ0nEwWsOOlnHjCIBqeArOiOPO+7fpPUXnPoj7cr1xnxfxPSLkqkI9zJTMiMqMuWmgBz9RYQK5noUcH0hDUEL7go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6OIcjgO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6GH/5Q1C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lyWRjpU7edhQ8hE//F2kXx9GzI3adwIlHn6o2bqXNlI=;
	b=F6OIcjgOiSav50eWyAg3fJmeOXDbUYAqoze1kdmp88boiAwqOy4/fDvVdt6RL+Nvyxu0fY
	ykyK/KK6NOVwNUe1D2le0Zr4Ky1ziKzSKZ9NYgGuOAfHHFTE5t5PNywH9Myk4ZH8ma9/Yu
	UY+xu08EprW4fKShcU9Su4tT+nnTgLkWRr5XIGjJw0fJhPA3d7CkO15iENCQkh8EBkoBpp
	wgRgNCGppP2SPQhVBPdRxCNrnqawkfslA0MLLQZ3uS/cykt3+9tA8JI0KzZNnRh0vpkldu
	gqHhf9Si5rLPjRugcVnh+cekiFjm8ojpHK0IKiZBRrXtzPhEOinepp5sGaSK+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lyWRjpU7edhQ8hE//F2kXx9GzI3adwIlHn6o2bqXNlI=;
	b=6GH/5Q1CI4151xyD+ZXT+/C0u762kQH+S4ZqmCZtjzgAvb8lmU5KAoek0bBAyyjPLHFS+X
	5dxMdmN4jC8t4dAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] sched: Move MM CID related functions to sched.h
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <176224424617.2601451.10995252995741689765.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     4fc9225d19ad6289c03340a520d35e3a6d1aebed
Gitweb:        https://git.kernel.org/tip/4fc9225d19ad6289c03340a520d35e3a6d1=
aebed
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:32:04 +01:00

sched: Move MM CID related functions to sched.h

There is nothing mm specific in that and including mm.h can cause header
recursion hell.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

