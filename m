Return-Path: <linux-tip-commits+bounces-6661-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4C4B7CFD3
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D0FA488326
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 06:17:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C3D28D830;
	Wed, 17 Sep 2025 06:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j8xZh3UQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XQkhJPyJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4222327511C;
	Wed, 17 Sep 2025 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089799; cv=none; b=Vs8ELBu9NdLJbMHOgljBkcBm97rDCI0zJcMpOpPmwNvYcYNxKrvA/i1TmXqiAG+1RLiM9jTEUxbsxespItfwiEaRHrH9wlTwdRmmdyIrEF7gq2n3sL+Heaatkps4NcQEd8XOluvqFfV1xvr63XTgzqLfrkGPq0U+vYpW5kBVVwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089799; c=relaxed/simple;
	bh=+GgylvQVEUFybHwXDbUiC51ghPsqjnRgYGA/vvObiVM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RMSJhyszV8X0M1b7ikSJY+a8kTbHvb7ylFt2mDjcO8KKjhLoyM9Hli8wDFIPj04wqbN7XRqHSofEZNFnoMsWOs2hYbXfsbO3XEko29Xh8jeRk0iPqYiZMs9cZTKRLeJrbhdrwB5iHqEJ3WGgpbSSJcCVgoMZN8DONp6PWP15l/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j8xZh3UQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XQkhJPyJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 06:16:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758089796;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3gl6lokWXgtmXAkdttI1KrsAhZUi3mb93/bTa1YZ5A=;
	b=j8xZh3UQPFRDnSk/fUz0DXrEdhlelI3IOgWCpUE3P3SyKxDbdzUJgnf+Q7vkk9ycrKHT+H
	ffViBcbGUVuKWTSLIQRuEHyQ+MQhQI/iXb4fkULcuAQ//uh+21iJYkgFcfyOVRuXXT9zx0
	HqwYiHg8r+71JDk6S74/prr3yZSV2/yDLMaadbA3UMCshbvoH5MC18TCKSVa6BxwmdLTgc
	LKSpIt43neeKzj0vAixNkgZWPo7qh1VZxL98eyZ07XXvl0ydSlarSTbjI+JXeL4ynDobMX
	ZihtSi9DidpVsHJn/fZeBHXR8S9HgDAlhEjNuLIjmB08YJTLzU/Xv1sWarKnHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758089796;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D3gl6lokWXgtmXAkdttI1KrsAhZUi3mb93/bTa1YZ5A=;
	b=XQkhJPyJVzwBQHm0ChfjeSkf8rdP4/+HigXoVoIuqlkFqvo3RcxjAOLSXs4z/y2F7clGbU
	2vQnBy8HS9YYIlAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] s390: Use generic TIF bits
Cc: Thomas Gleixner <tglx@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250908212927.373210812@linutronix.de>
References: <20250908212927.373210812@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175808979526.709179.11091367370830515282.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     06e5b72858b168fcedb0402b8dfdb896276fc08e
Gitweb:        https://git.kernel.org/tip/06e5b72858b168fcedb0402b8dfdb896276=
fc08e
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 08 Sep 2025 23:32:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 08:14:04 +02:00

s390: Use generic TIF bits

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by s390. So no further action required here.

This leaves a comment about the AUDIT/TRACE/SECCOMP bits which are handled
by SYSCALL_WORK in the generic code, so they seem redundant, but that's a
problem for the s390 wizards to think about.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                   |  1 +-
 arch/s390/include/asm/thread_info.h | 44 +++++++++++-----------------
 2 files changed, 19 insertions(+), 26 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c2..f991ab9 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -199,6 +199,7 @@ config S390
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
 	select HAVE_EBPF_JIT if HAVE_MARCH_Z196_FEATURES
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY
 	select HAVE_FTRACE_GRAPH_FUNC
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thre=
ad_info.h
index f6ed2c8..fe6da06 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -56,43 +56,35 @@ void arch_setup_new_exec(void);
=20
 /*
  * thread information flags bit numbers
+ *
+ * Tell the generic TIF infrastructure which special bits s390 supports
  */
-#define TIF_NOTIFY_RESUME	0	/* callback before returning to user */
-#define TIF_SIGPENDING		1	/* signal pending */
-#define TIF_NEED_RESCHED	2	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	3	/* lazy rescheduling needed */
-#define TIF_UPROBE		4	/* breakpointed or single-stepping */
-#define TIF_PATCH_PENDING	5	/* pending live patching update */
-#define TIF_ASCE_PRIMARY	6	/* primary asce is kernel asce */
-#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_GUARDED_STORAGE	8	/* load guarded storage control block */
-#define TIF_ISOLATE_BP_GUEST	9	/* Run KVM guests with isolated BP */
-#define TIF_PER_TRAP		10	/* Need to handle PER trap on exit to usermode */
-#define TIF_31BIT		16	/* 32bit process */
-#define TIF_MEMDIE		17	/* is terminating due to OOM killer */
-#define TIF_RESTORE_SIGMASK	18	/* restore signal mask in do_signal() */
-#define TIF_SINGLE_STEP		19	/* This task is single stepped */
-#define TIF_BLOCK_STEP		20	/* This task is block stepped */
-#define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific bits */
+#define TIF_ASCE_PRIMARY	16	/* primary asce is kernel asce */
+#define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
+#define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
+#define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
+#define TIF_31BIT		20	/* 32bit process */
+#define TIF_SINGLE_STEP		21	/* This task is single stepped */
+#define TIF_BLOCK_STEP		22	/* This task is block stepped */
+#define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
+
+/* These could move over to SYSCALL_WORK bits, no? */
 #define TIF_SYSCALL_TRACE	24	/* syscall trace active */
 #define TIF_SYSCALL_AUDIT	25	/* syscall auditing active */
 #define TIF_SECCOMP		26	/* secure computing */
 #define TIF_SYSCALL_TRACEPOINT	27	/* syscall tracepoint instrumentation */
=20
-#define _TIF_NOTIFY_RESUME	BIT(TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		BIT(TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	BIT(TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	BIT(TIF_NEED_RESCHED_LAZY)
-#define _TIF_UPROBE		BIT(TIF_UPROBE)
-#define _TIF_PATCH_PENDING	BIT(TIF_PATCH_PENDING)
 #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
-#define _TIF_NOTIFY_SIGNAL	BIT(TIF_NOTIFY_SIGNAL)
 #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
 #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
 #define _TIF_31BIT		BIT(TIF_31BIT)
-#define _TIF_MEMDIE		BIT(TIF_MEMDIE)
-#define _TIF_RESTORE_SIGMASK	BIT(TIF_RESTORE_SIGMASK)
 #define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
 #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
 #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)

