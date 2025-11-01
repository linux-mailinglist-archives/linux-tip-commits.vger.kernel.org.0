Return-Path: <linux-tip-commits+bounces-7135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E28C286F2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04F223AC4B6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61CD9303A12;
	Sat,  1 Nov 2025 19:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dpEOYu7n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C/fOB5+X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43635303C81;
	Sat,  1 Nov 2025 19:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026462; cv=none; b=jjT2KWEd+fFoF2Lx7u9vUVVTX1ZBAsYq6Dpw+ridJea2LGehyUYUM4uWncnqpL/pwc0Afv9w96H22FA6nRMH+ddaUi07o5OMvslLd0i6pZjaKkWBflh0qmG2xkTGXrFjqx5VPJzAp8vpPXlsgCelOIHEnacTPNQr+OT4dsip3hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026462; c=relaxed/simple;
	bh=omGQ5SyV/Op5plqvGyWLDqH4WlmfIs6DRUmIqeIH/8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VGkmVtNAfAintHKxoIE6Msf+ArY4PZXb34gksqPTiM7OP0B2BtxLPd+Dbo77+aWe6HBl/vpqzQgpUb1m7yinSXgWy+0gTcw1k/COICBr+ErW1rtXcPtLsvzEPdyk+mSiQga1PuC4MA7Bi0Jv1nl/Qgxhk2r2SIdpE1au3mDRqis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dpEOYu7n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C/fOB5+X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMsBs6NFR0yA2TMOcUH/MSyp/awBU+ZKN5+M8KJh03w=;
	b=dpEOYu7nq69F8F9lT5M9SEwZkE+2atFVIZwPcBAEOYxXaOwnUcS3zYCqkTRDaRlbsSNR2J
	2XhGnJ+kADUHjJx6L7JtgtZJ1vp9CKCePbIy8etlvNrg6uC5HZ71SHyjDhq9ML0eQlON+n
	OdZ+MiFtJjBvdWHBk2Uf+E1sRCdBCh1HQlo8zWACWSdMwbSaPUhH3GbtATp5Bs7/9rO0Uk
	73mSeqKygzQ4Qm57QG4XevqjU3Che2K2ZTjPAmhrTJITXLkyXmSJAM77t0ZuPtE2a/x3sb
	ATXICw90wqaNcRDbsDH0F6buPgekQrslwGBtUPoCYIyP7a3gwxkbPQ0SDFunAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026457;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MMsBs6NFR0yA2TMOcUH/MSyp/awBU+ZKN5+M8KJh03w=;
	b=C/fOB5+Xoqp7SCOtsKgg8X6dYF8qvNnE8o+kAozxbm+Vu3cKiTXljXWHevrg+E9SQCN2mi
	mLqzwe9k0DD/SZDg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso: Introduce vdso/processor.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-30-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-30-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202645576.2601451.17815879922545085656.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     933190788f61ae80807baa4f76b7792b427fc319
Gitweb:        https://git.kernel.org/tip/933190788f61ae80807baa4f76b7792b427=
fc319
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:07 +01:00

sparc64: vdso: Introduce vdso/processor.h

The generic vDSO library expects a vdso/processor.h with an definition of
cpu_relax().

Split out cpu_relax() into this dedicated header.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-30-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/include/asm/processor.h      |  3 ++-
 arch/sparc/include/asm/processor_32.h   |  2 +-
 arch/sparc/include/asm/processor_64.h   | 25 +---------------
 arch/sparc/include/asm/vdso/processor.h | 41 ++++++++++++++++++++++++-
 4 files changed, 44 insertions(+), 27 deletions(-)
 create mode 100644 arch/sparc/include/asm/vdso/processor.h

diff --git a/arch/sparc/include/asm/processor.h b/arch/sparc/include/asm/proc=
essor.h
index 18295ea..e34de95 100644
--- a/arch/sparc/include/asm/processor.h
+++ b/arch/sparc/include/asm/processor.h
@@ -1,6 +1,9 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef ___ASM_SPARC_PROCESSOR_H
 #define ___ASM_SPARC_PROCESSOR_H
+
+#include <asm/vdso/processor.h>
+
 #if defined(__sparc__) && defined(__arch64__)
 #include <asm/processor_64.h>
 #else
diff --git a/arch/sparc/include/asm/processor_32.h b/arch/sparc/include/asm/p=
rocessor_32.h
index ba8b70f..a074d31 100644
--- a/arch/sparc/include/asm/processor_32.h
+++ b/arch/sparc/include/asm/processor_32.h
@@ -91,8 +91,6 @@ unsigned long __get_wchan(struct task_struct *);
 extern struct task_struct *last_task_used_math;
 int do_mathemu(struct pt_regs *regs, struct task_struct *fpt);
=20
-#define cpu_relax()	barrier()
-
 extern void (*sparc_idle)(void);
=20
 #endif
diff --git a/arch/sparc/include/asm/processor_64.h b/arch/sparc/include/asm/p=
rocessor_64.h
index 3218594..4850704 100644
--- a/arch/sparc/include/asm/processor_64.h
+++ b/arch/sparc/include/asm/processor_64.h
@@ -182,31 +182,6 @@ unsigned long __get_wchan(struct task_struct *task);
 #define KSTK_EIP(tsk)  (task_pt_regs(tsk)->tpc)
 #define KSTK_ESP(tsk)  (task_pt_regs(tsk)->u_regs[UREG_FP])
=20
-/* Please see the commentary in asm/backoff.h for a description of
- * what these instructions are doing and how they have been chosen.
- * To make a long story short, we are trying to yield the current cpu
- * strand during busy loops.
- */
-#ifdef	BUILD_VDSO
-#define	cpu_relax()	asm volatile("\n99:\n\t"			\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     ::: "memory")
-#else /* ! BUILD_VDSO */
-#define cpu_relax()	asm volatile("\n99:\n\t"			\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     "rd	%%ccr, %%g0\n\t"	\
-				     ".section	.pause_3insn_patch,\"ax\"\n\t"\
-				     ".word	99b\n\t"		\
-				     "wr	%%g0, 128, %%asr27\n\t"	\
-				     "nop\n\t"				\
-				     "nop\n\t"				\
-				     ".previous"			\
-				     ::: "memory")
-#endif
-
 /* Prefetch support.  This is tuned for UltraSPARC-III and later.
  * UltraSPARC-I will treat these as nops, and UltraSPARC-II has
  * a shallower prefetch queue than later chips.
diff --git a/arch/sparc/include/asm/vdso/processor.h b/arch/sparc/include/asm=
/vdso/processor.h
new file mode 100644
index 0000000..f7a9adc
--- /dev/null
+++ b/arch/sparc/include/asm/vdso/processor.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_SPARC_VDSO_PROCESSOR_H
+#define _ASM_SPARC_VDSO_PROCESSOR_H
+
+#include <linux/compiler.h>
+
+#if defined(__arch64__)
+
+/* Please see the commentary in asm/backoff.h for a description of
+ * what these instructions are doing and how they have been chosen.
+ * To make a long story short, we are trying to yield the current cpu
+ * strand during busy loops.
+ */
+#ifdef	BUILD_VDSO
+#define	cpu_relax()	asm volatile("\n99:\n\t"			\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     ::: "memory")
+#else /* ! BUILD_VDSO */
+#define cpu_relax()	asm volatile("\n99:\n\t"			\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     "rd	%%ccr, %%g0\n\t"	\
+				     ".section	.pause_3insn_patch,\"ax\"\n\t"\
+				     ".word	99b\n\t"		\
+				     "wr	%%g0, 128, %%asr27\n\t"	\
+				     "nop\n\t"				\
+				     "nop\n\t"				\
+				     ".previous"			\
+				     ::: "memory")
+#endif /* BUILD_VDSO */
+
+#else /* ! __arch64__ */
+
+#define cpu_relax()	barrier()
+
+#endif /* __arch64__ */
+
+#endif /* _ASM_SPARC_VDSO_PROCESSOR_H */

