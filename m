Return-Path: <linux-tip-commits+bounces-7237-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 291C0C2FD07
	for <lists+linux-tip-commits@lfdr.de>; Tue, 04 Nov 2025 09:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86ED5189CECD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Nov 2025 08:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5632B3164D9;
	Tue,  4 Nov 2025 08:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FslWahtt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r9TS5i9W"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 734813161A1;
	Tue,  4 Nov 2025 08:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762244247; cv=none; b=CYHwegE29Ax4yIvoMlBNCcXe22H1SeFxEPIit0tLRS/bKkEuqPykuADXxJdmF2shN5iOmu9QJaF6iWmGV+fGxwWS0SS3H51cu0TOJ1egrQe9hpsa56/VaBgVisrB3XRUXLl/CwRLW016GCXq9cs1YjCrWTrt+r2xaM01JeXijU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762244247; c=relaxed/simple;
	bh=2lZOfVodyxKSOVT5vvKdJMgooQjiL4AGOPc+Ukllwo8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FZVMnej8HfUFhETCCvTkUJiTd0F+6J80g+l5VPMExmM76Ft4NsUyOda9tohAz9/pQQetdBCza2UOCl4R0PHntPIFz0umMdzY1xBNYpWcm/Pk7tYorMKkAt3qGBr+PkD9WmW+tgyVmkl3Fpp3rm1hxNdr9JyiI09wiDZ1WeLbxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FslWahtt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r9TS5i9W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Nov 2025 08:17:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762244243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WVy1rWM5yScWmVRUSuMBsvYQeyBk7wIB4laYkS79do=;
	b=FslWahttwEiOnps/aXHMKHrkDA2ly3wuljeJrB8cjYXqvIUkTDj+XlbQGKvpuVk0lEo2ux
	59z+zoppFBl4dC+2enqh6VJH6mFS5En+wy52L43swTuWetcMP7Sfa3Zg8XJIdzryvTxl8Z
	6BNaub3cQ8u8bwmpxzxb9VGhjZfjLuT6R3LGy9K0lchczfSMDG/eO0+zZNwhKDXLSQtzTZ
	sKcrJco1oUOgSc5XeB2zyoV9mlUDho5lunFf+qlCbUF3nOB1Z/gk7034rJopi/5TqjxloK
	6ziOeMY8RmcuE0PsFyroAwXS13AlVJqDOKGAZDJAZHAjYVS2ZZGdy4skzLRMxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762244243;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3WVy1rWM5yScWmVRUSuMBsvYQeyBk7wIB4laYkS79do=;
	b=r9TS5i9WyfVU6GyGBa5NpG2Sb809NX2uQX6iDB0YlmJxTKOFyTdiNkufflp4hlHVkADX2L
	8f68bQ2oy5bZ5KBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] rseq: Provide tracepoint wrappers for inline code
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
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
Message-ID: <176224424192.2601451.12369988505539521387.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     dab344753e021fe84c24f9d8b0b63cb5bcf463d7
Gitweb:        https://git.kernel.org/tip/dab344753e021fe84c24f9d8b0b63cb5bcf=
463d7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 27 Oct 2025 09:44:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Nov 2025 08:32:35 +01:00

rseq: Provide tracepoint wrappers for inline code

Provide tracepoint wrappers for the upcoming RSEQ exit to user space inline
fast path, so that the header can be safely included by code which defines
actual trace points.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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

