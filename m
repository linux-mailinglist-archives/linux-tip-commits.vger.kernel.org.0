Return-Path: <linux-tip-commits+bounces-7190-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A4BC2C87A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:00:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 85E283491F7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C313318142;
	Mon,  3 Nov 2025 14:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k4bBZ8mm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RxgC9zhh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E1F3176EF;
	Mon,  3 Nov 2025 14:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181263; cv=none; b=EFQcVj3JA+8cqx8oMMMIg/LNu9c69MhKYewLmM5vpa94Khd/QTOFhGFnX5oSo36FxeAwqRFfMGYL0wgjoVSvtcdCxgU018v4oBJoZU77ko0bEJ6scGH2KypZ5s2ncyI2vHfYkcmr56f4kqAXL+IShXKhTljOO99i0xOH86BxgyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181263; c=relaxed/simple;
	bh=y0NTlenhg1thH3fnsuj27XOKHTa/bih1CNQvuw3HdcM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bOQW1lMdzgY4TJOGMJRAvBvHQNPo3I7zaaP2qqLlTVZ/sdhtRI89OjxCsDPxprMDf7nMaAgsvuTknXUdsKWjmFQs1RmMOB//X12sOj1Xn0fK9d08+HMPtCKtpzRK7OvGwJn2pZQ/g/yea+yfWv3fiG63/9uuAzoZTB1FtaoQOw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k4bBZ8mm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RxgC9zhh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHMS4X8mvTnVDFDjdlq4ZobTF7tCPbMFDBRNAELnmGI=;
	b=k4bBZ8mmcU9/z/cVFlodIAOXf3KByO6SaP4jFl33RdKFW7RI/PKK+6jnaTgbcFaxS+Y0Lo
	FnrinMkHz9MRkIfQNun0zAw9u5FtSnDfIdSF5fSdUFalq71JhseUPq0rFZ0tjR6ZFnhSla
	XuAVZniRpwNh9f35vQ29sUpWU5lokx30Z9n2BB6/cgseHNMrttxQrsA52ssGrm8zO0GXGw
	tdHuInUfw4HdvdURWaOmyMgo3N/ZMS4jCNFin3+QKVpuOXO63WWm42cxDxEBYMkTS/oDly
	wUD+y2/T8uZ8yYAQSja+Um8D8u31UrcDzbgQ8KCwCMSrpSHbrh+A3QgvOmyfGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181260;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KHMS4X8mvTnVDFDjdlq4ZobTF7tCPbMFDBRNAELnmGI=;
	b=RxgC9zhh5bRz7581xNoFDKD8mlhpdriTrTKyyC8HDZJnbYollzz+5PponFm8Znte3r7FUz
	EdUKwPRIdV1GUpCg==
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
Message-ID: <176218125876.2601451.8547138671361167367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     19eaf4863bb5f11740e4ce264683d33e9f651ae3
Gitweb:        https://git.kernel.org/tip/19eaf4863bb5f11740e4ce264683d33e9f6=
51ae3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:17 +01:00

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

