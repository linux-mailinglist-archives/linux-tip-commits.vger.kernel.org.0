Return-Path: <linux-tip-commits+bounces-7067-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 57E80C19B69
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 11:28:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E05571AA6130
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:27:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A14AD3346A2;
	Wed, 29 Oct 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qoe6nvDj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wRR5rZ5x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 545AE2FF677;
	Wed, 29 Oct 2025 10:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761733430; cv=none; b=Zf+QjGsIj+DfbyBCLDr1qy6JWkdE0I0PG1LngK5IGyh0r3sisuJNGReV1v/HnpuS7a8adet0O1v/7v9Lzgc6mhuQa0wR7WmLple+CCSfnoYNbIDmyBEYB6DczkvgGLGk91YzlRWEo2/RXCWVF9/26PqGps4O+X9YpPA08CAYDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761733430; c=relaxed/simple;
	bh=FjnPdGyW6DJNUP1Lq2fI2U4EnO9DGVSFRNiWOgJ8cFc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=suDSGoUVUMM65/CbCMeY8YEEgh9Fj3afq7suXknsc4JYc5ZsPvby4cf3xJH6kt6c59CK5KVN3k8GJUSZjDPPnamykLuPqiugZubDzvicVeqW6KALiBYubgjevYp+9pEYpwnQxE2jAQr8O2A85R8m2sA4rQBT5cEsSRb+oTC7ybk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qoe6nvDj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wRR5rZ5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 10:23:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761733426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syItnJw5bcrzqsF/2tphTj0WLYZrrDFSCQUQNDcSteQ=;
	b=Qoe6nvDjFH0LaxVQvyPiVMzIE/3iRuPhqTOC2xUii73xEBzRLWfdY4uKF8i5uaOoV6tP+1
	YgbLdJtgR0Yr86vLbt8dOMmMl7RbYhJ0xxdkQFygxMVh3rHNG9Js/i72YVWjJI8YKtx/q+
	iZqO8VEqnZrXEQM8wsLZn+wPprgKx51XI8sGp02aHzk+wYSEwFQdWu5LCIjOIS5xnkVyph
	AUUsluPTTtBxTt+YxEykQWgyRJqflZFLQqFR8WFrPjmVV38HOYp++GSTB9B6CTghsP9pfE
	uV+QWNhzQGmHaBFbZaQr2z/YJtvHcmuxTtJfMIXVe7kNdRvY3mD9CPgNfgAW8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761733426;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=syItnJw5bcrzqsF/2tphTj0WLYZrrDFSCQUQNDcSteQ=;
	b=wRR5rZ5xRgITjQse54Gw45BEbB5IJq1aVv0EdXHI/2UzQGVsOHSIKkfJkKGHSeJ1UL8shx
	CVGcr0mQRkZVpaDw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Provide tracepoint wrappers for inline code
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251027084306.967114316@linutronix.de>
References: <20251027084306.967114316@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173342531.2601451.8411023741711391878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2be690996a88b79741a7b00ba434576ca36d1912
Gitweb:        https://git.kernel.org/tip/2be690996a88b79741a7b00ba434576ca36=
d1912
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 11:07:15 +01:00

rseq: Provide tracepoint wrappers for inline code

Provide tracepoint wrappers for the upcoming RSEQ exit to user space inline
fast path, so that the header can be safely included by code which defines
actual trace points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251027084306.967114316@linutronix.de
---
 include/linux/rseq_entry.h | 28 ++++++++++++++++++++++++++++
 kernel/rseq.c              | 19 ++++++++++++++++++-
 2 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index ce30e87..5be507a 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -5,6 +5,34 @@
 #ifdef CONFIG_RSEQ
 #include <linux/rseq.h>
=20
+#include <linux/tracepoint-defs.h>
+
+#ifdef CONFIG_TRACEPOINTS
+DECLARE_TRACEPOINT(rseq_update);
+DECLARE_TRACEPOINT(rseq_ip_fixup);
+void __rseq_trace_update(struct task_struct *t);
+void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
+			   unsigned long offset, unsigned long abort_ip);
+
+static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids =
*ids)
+{
+	if (tracepoint_enabled(rseq_update) && ids)
+		__rseq_trace_update(t);
+}
+
+static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start=
_ip,
+				       unsigned long offset, unsigned long abort_ip)
+{
+	if (tracepoint_enabled(rseq_ip_fixup))
+		__rseq_trace_ip_fixup(ip, start_ip, offset, abort_ip);
+}
+
+#else /* CONFIG_TRACEPOINT */
+static inline void rseq_trace_update(struct task_struct *t, struct rseq_ids =
*ids) { }
+static inline void rseq_trace_ip_fixup(unsigned long ip, unsigned long start=
_ip,
+				       unsigned long offset, unsigned long abort_ip) { }
+#endif /* !CONFIG_TRACEPOINT */
+
 static __always_inline void rseq_note_user_irq_entry(void)
 {
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_ENTRY))
diff --git a/kernel/rseq.c b/kernel/rseq.c
index ad1e7ce..f49d311 100644
--- a/kernel/rseq.c
+++ b/kernel/rseq.c
@@ -70,7 +70,7 @@
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 #include <linux/syscalls.h>
-#include <linux/rseq.h>
+#include <linux/rseq_entry.h>
 #include <linux/types.h>
 #include <linux/ratelimit.h>
 #include <asm/ptrace.h>
@@ -91,6 +91,23 @@
 				  RSEQ_CS_FLAG_NO_RESTART_ON_SIGNAL | \
 				  RSEQ_CS_FLAG_NO_RESTART_ON_MIGRATE)
=20
+#ifdef CONFIG_TRACEPOINTS
+/*
+ * Out of line, so the actual update functions can be in a header to be
+ * inlined into the exit to user code.
+ */
+void __rseq_trace_update(struct task_struct *t)
+{
+	trace_rseq_update(t);
+}
+
+void __rseq_trace_ip_fixup(unsigned long ip, unsigned long start_ip,
+			   unsigned long offset, unsigned long abort_ip)
+{
+	trace_rseq_ip_fixup(ip, start_ip, offset, abort_ip);
+}
+#endif /* CONFIG_TRACEPOINTS */
+
 #ifdef CONFIG_DEBUG_RSEQ
 static struct rseq *rseq_kernel_fields(struct task_struct *t)
 {

