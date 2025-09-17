Return-Path: <linux-tip-commits+bounces-6659-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46F4DB7D0B8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 85D0F176E34
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 06:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D9D26FDA4;
	Wed, 17 Sep 2025 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g9r9EyFE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oJpZqAhl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF8721A9FB8;
	Wed, 17 Sep 2025 06:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089797; cv=none; b=CQsTUPOP49rbLzoBuREVD5NpH/ffYwU+zA2R1Gt32WablEHZrLmhtMoGplIt9M3kLk0H4jZ0Nx78L2jyaArKciUC3zrxNFp36A+Pn84u/yzzzauAYzoIbzDcqDlJzal4wqKPRl0H9jKbqu2yCdwHAJX8CndKZdofYBuCl4bGpv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089797; c=relaxed/simple;
	bh=ufEh0Q/hks8lx9NbYOZXoStuFyAY5S9b7BcCk3vz0nY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tmYEF6djVg4OP5NvgA0bvxm8pUPKgAmurmEI2Uj+PhBI0fg+X74pVw6hKN5jHTiNaI6ESxMQVhANGaS3g6OaqJOTw3l9gzeF79Ow06o4DxsjnMxX5C/qW0XWTUfZ/AE7IvijP3i42whGHBY0AYyIcgfyvR6y106auy4cQVC6C8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g9r9EyFE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oJpZqAhl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 06:16:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758089794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbpmHroj796ra1bwV+1loD6gFnpCqN6tyUOrbFg4gwY=;
	b=g9r9EyFEk9mkFBQL5YAhgQE+IA38Q1HAC2AN/8kYDcTRsgl4plN1AxI7tORcS3O+6PJVPo
	cTRlsm1Td22/f3K9uBKkCxTaRQkX4yUzASt9tckwBCL+LPeD8qgoYyotzde0DOmFcHZQ4X
	BF11FJW2a3/nBqQndfdkE80Z7XrtNUtTNqJZiAxO52wEzfbCkDAsL3l8LYH3VXyG+YcOb5
	R192MXaqZ6yiYgd5UDtD1TMXTN1zaL3wAVExvYOyi4DkHaO9eE5rQcPKuXBx8bU1mUPdy2
	g4021lk7oZJF3d/okULZrEXYGiXmT78MFMICNQnIFYBm/OlHrdl9LpxY2i07XA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758089794;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EbpmHroj796ra1bwV+1loD6gFnpCqN6tyUOrbFg4gwY=;
	b=oJpZqAhl24N++8p9dPsXJeWPK8bcGOwKxSNSzKZpJd+tPwyeZpE6UrACh4kKpjxlUvwmtI
	nUJHX/WxxilFUlBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] loongarch: Use generic TIF bits
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250908212927.437140156@linutronix.de>
References: <20250908212927.437140156@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175808979275.709179.2781693240712312608.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     f9629891d407e455dc1334e1594108c73074fe8b
Gitweb:        https://git.kernel.org/tip/f9629891d407e455dc1334e1594108c7307=
4fe8b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 08 Sep 2025 23:32:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 08:14:04 +02:00

loongarch: Use generic TIF bits

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by loongarch. So no further action required here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/loongarch/Kconfig                   |  1 +-
 arch/loongarch/include/asm/thread_info.h | 76 ++++++++++-------------
 2 files changed, 35 insertions(+), 42 deletions(-)

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38..2e90d86 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -140,6 +140,7 @@ config LOONGARCH
 	select HAVE_EBPF_JIT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS if !ARCH_STRICT_ALIGN
 	select HAVE_EXIT_THREAD
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FUNCTION_ARG_ACCESS_API
diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/includ=
e/asm/thread_info.h
index 9dfa2ef..def7cb1 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -65,50 +65,42 @@ register unsigned long current_stack_pointer __asm__("$sp=
");
  *   access
  * - pending work-to-be-done flags are in LSW
  * - other flags in MSW
+ *
+ * Tell the generic TIF infrastructure which special bits loongarch supports
  */
-#define TIF_NEED_RESCHED	0	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	1	/* lazy rescheduling necessary */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
-#define TIF_NOTIFY_SIGNAL	4	/* signal notifications exist */
-#define TIF_RESTORE_SIGMASK	5	/* restore signal mask in do_signal() */
-#define TIF_NOHZ		6	/* in adaptive nohz mode */
-#define TIF_UPROBE		7	/* breakpointed or singlestepping */
-#define TIF_USEDFPU		8	/* FPU was used by this task this quantum (SMP) */
-#define TIF_USEDSIMD		9	/* SIMD has been used this quantum */
-#define TIF_MEMDIE		10	/* is terminating due to OOM killer */
-#define TIF_FIXADE		11	/* Fix address errors in software */
-#define TIF_LOGADE		12	/* Log address errors to syslog */
-#define TIF_32BIT_REGS		13	/* 32-bit general purpose registers */
-#define TIF_32BIT_ADDR		14	/* 32-bit address space */
-#define TIF_LOAD_WATCH		15	/* If set, load watch registers */
-#define TIF_SINGLESTEP		16	/* Single Step */
-#define TIF_LSX_CTX_LIVE	17	/* LSX context must be preserved */
-#define TIF_LASX_CTX_LIVE	18	/* LASX context must be preserved */
-#define TIF_USEDLBT		19	/* LBT was used by this task this quantum (SMP) */
-#define TIF_LBT_CTX_LIVE	20	/* LBT context must be preserved */
-#define TIF_PATCH_PENDING	21	/* pending live patching update */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific bits */
+#define TIF_NOHZ		16	/* in adaptive nohz mode */
+#define TIF_USEDFPU		17	/* FPU was used by this task this quantum (SMP) */
+#define TIF_USEDSIMD		18	/* SIMD has been used this quantum */
+#define TIF_FIXADE		10	/* Fix address errors in software */
+#define TIF_LOGADE		20	/* Log address errors to syslog */
+#define TIF_32BIT_REGS		21	/* 32-bit general purpose registers */
+#define TIF_32BIT_ADDR		22	/* 32-bit address space */
+#define TIF_LOAD_WATCH		23	/* If set, load watch registers */
+#define TIF_SINGLESTEP		24	/* Single Step */
+#define TIF_LSX_CTX_LIVE	25	/* LSX context must be preserved */
+#define TIF_LASX_CTX_LIVE	26	/* LASX context must be preserved */
+#define TIF_USEDLBT		27	/* LBT was used by this task this quantum (SMP) */
+#define TIF_LBT_CTX_LIVE	28	/* LBT context must be preserved */
=20
-#define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1<<TIF_NEED_RESCHED_LAZY)
-#define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
-#define _TIF_NOTIFY_RESUME	(1<<TIF_NOTIFY_RESUME)
-#define _TIF_NOTIFY_SIGNAL	(1<<TIF_NOTIFY_SIGNAL)
-#define _TIF_NOHZ		(1<<TIF_NOHZ)
-#define _TIF_UPROBE		(1<<TIF_UPROBE)
-#define _TIF_USEDFPU		(1<<TIF_USEDFPU)
-#define _TIF_USEDSIMD		(1<<TIF_USEDSIMD)
-#define _TIF_FIXADE		(1<<TIF_FIXADE)
-#define _TIF_LOGADE		(1<<TIF_LOGADE)
-#define _TIF_32BIT_REGS		(1<<TIF_32BIT_REGS)
-#define _TIF_32BIT_ADDR		(1<<TIF_32BIT_ADDR)
-#define _TIF_LOAD_WATCH		(1<<TIF_LOAD_WATCH)
-#define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
-#define _TIF_LSX_CTX_LIVE	(1<<TIF_LSX_CTX_LIVE)
-#define _TIF_LASX_CTX_LIVE	(1<<TIF_LASX_CTX_LIVE)
-#define _TIF_USEDLBT		(1<<TIF_USEDLBT)
-#define _TIF_LBT_CTX_LIVE	(1<<TIF_LBT_CTX_LIVE)
-#define _TIF_PATCH_PENDING	(1<<TIF_PATCH_PENDING)
+#define _TIF_NOHZ		BIT(TIF_NOHZ)
+#define _TIF_USEDFPU		BIT(TIF_USEDFPU)
+#define _TIF_USEDSIMD		BIT(TIF_USEDSIMD)
+#define _TIF_FIXADE		BIT(TIF_FIXADE)
+#define _TIF_LOGADE		BIT(TIF_LOGADE)
+#define _TIF_32BIT_REGS		BIT(TIF_32BIT_REGS)
+#define _TIF_32BIT_ADDR		BIT(TIF_32BIT_ADDR)
+#define _TIF_LOAD_WATCH		BIT(TIF_LOAD_WATCH)
+#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
+#define _TIF_LSX_CTX_LIVE	BIT(TIF_LSX_CTX_LIVE)
+#define _TIF_LASX_CTX_LIVE	BIT(TIF_LASX_CTX_LIVE)
+#define _TIF_USEDLBT		BIT(TIF_USEDLBT)
+#define _TIF_LBT_CTX_LIVE	BIT(TIF_LBT_CTX_LIVE)
=20
 #endif /* __KERNEL__ */
 #endif /* _ASM_THREAD_INFO_H */

