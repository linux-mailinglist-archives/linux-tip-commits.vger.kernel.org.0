Return-Path: <linux-tip-commits+bounces-6662-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A3EB7CF33
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 14:14:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82E9F1BC6C65
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Sep 2025 06:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E3529D28A;
	Wed, 17 Sep 2025 06:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BtjIU2vq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j6lPGGPT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EEF62882B7;
	Wed, 17 Sep 2025 06:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758089801; cv=none; b=g7SrtlWxBkFARhTdySRiQIy0xByFSqVZjGwosmftPrxMfqczrkIGZMs71sIdgJvqqBAUUtqdY1oPqNkV0MQNrol35l7zEECONHOfG/9cju596WjicDCFN6lIl93O39i/WY53fs6rXrKgB78UeHX7ngelnAkuhikIDqaqo3KD07w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758089801; c=relaxed/simple;
	bh=798Vu/mtTeycYOKC4+LGS21gyzI/wAQtLHupIGlqlCM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k06TO48JEfDLJiNX65bBL5EUZHp7LTJM//O4J+qGrRPk1aAbL2jtB7b59IOC8JylXXIGbJudPFy46FViK3d+9uLArj64kbHI2POLW0nEzSqWCUybF1ULjJuMOjXvs42fialryvDm1Y8uOahGot+qCejMmT75wI2iPHEa4ZHIRqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BtjIU2vq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j6lPGGPT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Sep 2025 06:16:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758089797;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJpezMhgZ+3AsMdv9EcUHMw0prJID0porSNB9Vw0F94=;
	b=BtjIU2vqLJ2JZAtjRtAeO46bHIUCb1KQLMyBDc53vBHf6Kk+IHWQVLwTwXMixQMFQzaGiO
	PYUvlE39EdQCIdHaz749VwFuaMqsV+ueKhfZHslxSQhULNMxaQte5F3BA54W6iYs/ZNPyn
	UoYjhspUSSQhQ0q1A/8dUBOOMj+EzDKSzp/Z5TmtRgd66lRfJbJECAxHbkWpZngjUtI5rA
	sbCGIR/qy00Ir0vIpU8gRH0WA3xUdXgBaB7hFw4uHoJwvWR3NhBgsKzbJSUs1FVFkxN7xX
	LV48U9ucoDK23zjLunF3ImFYGZNKq2CwEiWv8ChvZW58uCahnf7TteLy3iEr1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758089797;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BJpezMhgZ+3AsMdv9EcUHMw0prJID0porSNB9Vw0F94=;
	b=j6lPGGPTAtWQeWs5DL62xvWgrJSebIZmW2EhnSTO44iRfdiRXGs5WMDK/gI1EU3rSelhMA
	7CfTyKtvXOBFeBAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/core] x86: Use generic TIF bits
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250908212927.310372324@linutronix.de>
References: <20250908212927.310372324@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175808979651.709179.1294444679276195862.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/core branch of tip:

Commit-ID:     da3f033a9fbfdb88826c1b0486fe1522fe4f94aa
Gitweb:        https://git.kernel.org/tip/da3f033a9fbfdb88826c1b0486fe1522fe4=
f94aa
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 08 Sep 2025 23:32:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Sep 2025 08:14:04 +02:00

x86: Use generic TIF bits

No point in defining generic items and the upcoming RSEQ optimizations are
only available with this _and_ the generic entry infrastructure, which is
already used by x86. So no further action required here.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 arch/x86/Kconfig                   |  1 +-
 arch/x86/include/asm/thread_info.h | 76 +++++++++++------------------
 2 files changed, 32 insertions(+), 45 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 52c8910..70b94e0 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -239,6 +239,7 @@ config X86
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
 	select HAVE_EISA			if X86_32
 	select HAVE_EXIT_THREAD
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FENTRY			if X86_64 || DYNAMIC_FTRACE
 	select HAVE_FTRACE_GRAPH_FUNC		if HAVE_FUNCTION_GRAPH_TRACER
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread=
_info.h
index 9282465..e71e0e8 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -80,56 +80,42 @@ struct thread_info {
 #endif
=20
 /*
- * thread information flags
- * - these are process state flags that various assembly files
- *   may need to access
+ * Tell the generic TIF infrastructure which bits x86 supports
  */
-#define TIF_NOTIFY_RESUME	1	/* callback before returning to user */
-#define TIF_SIGPENDING		2	/* signal pending */
-#define TIF_NEED_RESCHED	3	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	4	/* Lazy rescheduling needed */
-#define TIF_SINGLESTEP		5	/* reenable singlestep on user return*/
-#define TIF_SSBD		6	/* Speculative store bypass disable */
-#define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
-#define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
-#define TIF_UPROBE		12	/* breakpointed or singlestepping */
-#define TIF_PATCH_PENDING	13	/* pending live patching update */
-#define TIF_NEED_FPU_LOAD	14	/* load FPU on return to userspace */
-#define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
-#define TIF_NOTSC		16	/* TSC is not accessible in userland */
-#define TIF_NOTIFY_SIGNAL	17	/* signal notifications exist */
-#define TIF_MEMDIE		20	/* is terminating due to OOM killer */
-#define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_POLLING_NRFLAG
+#define HAVE_TIF_SINGLESTEP
+
+#include <asm-generic/thread_info_tif.h>
+
+/* Architecture specific TIF space starts at 16 */
+#define TIF_SSBD		16	/* Speculative store bypass disable */
+#define TIF_SPEC_IB		17	/* Indirect branch speculation mitigation */
+#define TIF_SPEC_L1D_FLUSH	18	/* Flush L1D on mm switches (processes) */
+#define TIF_NEED_FPU_LOAD	19	/* load FPU on return to userspace */
+#define TIF_NOCPUID		20	/* CPUID is not accessible in userland */
+#define TIF_NOTSC		21	/* TSC is not accessible in userland */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context =
switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
-#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
+#define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
-#define TIF_ADDR32		29	/* 32-bit address space on 64 bits */
-
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
-#define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
-#define _TIF_SSBD		(1 << TIF_SSBD)
-#define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
-#define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
-#define _TIF_NEED_FPU_LOAD	(1 << TIF_NEED_FPU_LOAD)
-#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
-#define _TIF_NOTSC		(1 << TIF_NOTSC)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
-#define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
-#define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
-#define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
-#define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
-#define _TIF_ADDR32		(1 << TIF_ADDR32)
+#define TIF_ADDR32		28	/* 32-bit address space on 64 bits */
+
+#define _TIF_SSBD		BIT(TIF_SSBD)
+#define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
+#define _TIF_SPEC_L1D_FLUSH	BIT(TIF_SPEC_L1D_FLUSH)
+#define _TIF_NEED_FPU_LOAD	BIT(TIF_NEED_FPU_LOAD)
+#define _TIF_NOCPUID		BIT(TIF_NOCPUID)
+#define _TIF_NOTSC		BIT(TIF_NOTSC)
+#define _TIF_IO_BITMAP		BIT(TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	BIT(TIF_SPEC_FORCE_UPDATE)
+#define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
+#define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
+#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
+#define _TIF_LAZY_MMU_UPDATES	BIT(TIF_LAZY_MMU_UPDATES)
+#define _TIF_ADDR32		BIT(TIF_ADDR32)
=20
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW_BASE					\

