Return-Path: <linux-tip-commits+bounces-6658-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FEE5B7CE94
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:13:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 345847A86D0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 06:15:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7675B1DB12E;
	Wed, 17 Sep 2025 06:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDWQ20az";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C25vMrkc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC51823DD;
	Wed, 17 Sep 2025 06:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089796; cv=none; b=EdCnREJI1DC4Fl5M+F7sHctER08baBqzPp7KVvFA/xm5dWXQer2jZ86VCyJMnugL9Z5fodT849XCWFrc4ee933+cOmVJvHETJ4aHBG/dywavvmDkrsd0ftiHh5FxPVvpuDZGy4wYJjV9lh07OvnNSA2JqKlGBkCbX7VjIKJmZJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089796; c=relaxed/simple;
	bh=vrYcYQ4zq0zlPe/TP4ubMTwRudM33CYNlQ2Yyh5Rt70=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PCZKS2okJgOK0+zfqFQKWtWrbzLrGolLoPtM9mzGtk6ZayoF535M3namfjXTUnwdqGjkvlKwpAQVd5E5dvuq6iMRyw4bLlR1rKEWfZbv0ru4mC+Vvre5sms6xrOFAq1xSinutadB4hNi3fOiUo3dr6Sj4QX31D9QEIgeU6Abcc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDWQ20az; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C25vMrkc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 06:16:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758089793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxXsopuLPuRo7OZ63A/8Wq3fGfzGpJF4hklm/gowkUQ=;
	b=cDWQ20azTOvl3DSenvfSF8H/B6OS39qS+S9GiT2rzxWtC2JEwljCfXEoxXXm3yijOr7DTi
	lPJ4Gx8figmomGcP2SYOFKE6hjDRVJMTwI+jm275u5avyu/THlpo2gJvKM8qpA+At16H4H
	Xl8EUKyigoqmQnI7brC1Q2B/6wkiuDd2gDbFnBZFvf9BAFi4h+RQgnGo1iyedPv47zjoHJ
	aaBhqnRtFiQEj11spL3svE5m/GDg03AtzebNcM6noEqLdWBq/t2OS536UgdBT22d5E856a
	BqKSOqDMy8bSFj9+Wa/DuSsg9YysjyQBbUFwkm5xF11QIsl0vQQPOi+kG+/c+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758089793;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jxXsopuLPuRo7OZ63A/8Wq3fGfzGpJF4hklm/gowkUQ=;
	b=C25vMrkcTh8TzbT8SoOl87QtMcvtszM0qmBW/CKntEP0FjvTbaT8Hnn/CZPNYnRNT1cPfC
	zCPUWORg0E8xBPAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] riscv: Use generic TIF bits
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250908212927.500173102@linutronix.de>
References: <20250908212927.500173102@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175808979084.709179.2976591843300945521.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     41e871f2b63edaf8da20907d512cd5d91ba51476
Gitweb:        https://git.kernel.org/tip/41e871f2b63edaf8da20907d512cd5d91ba=
51476
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 08 Sep 2025 23:32:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 08:14:05 +02:00

riscv: Use generic TIF bits

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by RISCV. So no further action required here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/riscv/Kconfig                   |  1 +-
 arch/riscv/include/asm/thread_info.h | 31 +++++++++++----------------
 2 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 51dcd8e..0c28061 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -161,6 +161,7 @@ config RISCV
 	select HAVE_FUNCTION_GRAPH_FREGS
 	select HAVE_FUNCTION_TRACER if !XIP_KERNEL && HAVE_DYNAMIC_FTRACE
 	select HAVE_EBPF_JIT if MMU
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST if MMU
 	select HAVE_FUNCTION_ARG_ACCESS_API
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/riscv/include/asm/thread_info.h b/arch/riscv/include/asm/th=
read_info.h
index f5916a7..a315b02 100644
--- a/arch/riscv/include/asm/thread_info.h
+++ b/arch/riscv/include/asm/thread_info.h
@@ -107,23 +107,18 @@ int arch_dup_task_struct(struct task_struct *dst, struc=
t task_struct *src);
  * - pending work-to-be-done flags are in lowest half-word
  * - other flags in upper half-word(s)
  */
-#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	1       /* Lazy rescheduling needed */
-#define TIF_NOTIFY_RESUME	2	/* callback before returning to user */
-#define TIF_SIGPENDING		3	/* signal pending */
-#define TIF_RESTORE_SIGMASK	4	/* restore signal mask in do_signal() */
-#define TIF_MEMDIE		5	/* is terminating due to OOM killer */
-#define TIF_NOTIFY_SIGNAL	9	/* signal notifications exist */
-#define TIF_UPROBE		10	/* uprobe breakpoint or singlestep */
-#define TIF_32BIT		11	/* compat-mode 32bit process */
-#define TIF_RISCV_V_DEFER_RESTORE	12 /* restore Vector before returing to us=
er */
-
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_RISCV_V_DEFER_RESTORE	(1 << TIF_RISCV_V_DEFER_RESTORE)
+
+/*
+ * Tell the generic TIF infrastructure which bits riscv supports
+ */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+#define TIF_32BIT			16	/* compat-mode 32bit process */
+#define TIF_RISCV_V_DEFER_RESTORE	17	/* restore Vector before returing to us=
er */
+
+#define _TIF_RISCV_V_DEFER_RESTORE	BIT(TIF_RISCV_V_DEFER_RESTORE)
=20
 #endif /* _ASM_RISCV_THREAD_INFO_H */

