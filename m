Return-Path: <linux-tip-commits+bounces-5094-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3804EA9641E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 11:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82DF1885A19
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Apr 2025 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018621F7910;
	Tue, 22 Apr 2025 09:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="llSP9fBL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QliPLC4J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7221F4CA9;
	Tue, 22 Apr 2025 09:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745313759; cv=none; b=kslY1mWVYYXnvQQS+MSPwgXv2zv0LgZiYplLGwtdmTKYbyGujiT5zNhWmnWQ0Grb5WB5ZkAj0QB1bZ6S0AFEZcOjDMwHXX6Ec1NLppg35cBU8BPU7EUTEiLWFPVlaZR9W4tyPbT97xvvWrMgvyoXRzO1z2W3E2/LgpKUBmRgoYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745313759; c=relaxed/simple;
	bh=p8PbsWipOnOFMylHkW2FoDRvGO1RSxcTSJU9Lf6UfvU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IEk8r/Ng29m7ybP+spBOt72idA0VhrGXPhKqF5uwqBbeT4/spz3NcEQNAk24QUiIIMmTxlPRD4FBcaL5MSoWuLjMm9SjkJWEVz+pDbIWVsanvtDFZMfTgGIIF6fjhTxJQILymW6YJenQHHI9WVl//hGVpyWVtnfZKeEuX5hLO74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=llSP9fBL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QliPLC4J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Apr 2025 09:22:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1745313756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yucr1ebv+PFQacrZkv6f49jfyjALSquPd1F1ZglJ194=;
	b=llSP9fBLNeNQpir1A4SxTrfA87Od97K8PxD4FQ2U37UHZq1k/ngofuEZ/9OtkbxbaxWKkD
	qvCWdCRCRyLzhVZvgaA/0sqad/Xu+w16zzsoSjogOITXpq/OiYoEFHIzesD7CYwdh3t+8F
	mHcSVWP1xzP52IaO++KGZ0Sz/BHRIoYuvMV0wuMvBMZnVg7Xu3zlIDYM5fufiND6p3EkMs
	xPm75EiqEYzh0Y5pp+OpLDZ0cxX1fm4Uubtc+6ulCqBz+j4F6DtFJxLVBy2/yLpWZDZirV
	p0OByF9Zqy5+F6e1ePv+BxkETJVPxAaQClp9TaTKDCg+V5jsreezCL2JPEd11w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1745313756;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yucr1ebv+PFQacrZkv6f49jfyjALSquPd1F1ZglJ194=;
	b=QliPLC4JAwPvUrgtz6qJu+GIEIXdFQrYpiDz/yU/cXfQjuVvpN6hHP72nEUOequKObf56f
	8tnfFHdipw58LtCQ==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/boot] x86/sev: Move noinstr NMI handling code into separate
 source file
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 Brian Gerst <brgerst@gmail.com>, David Woodhouse <dwmw@amazon.co.uk>,
 Dionna Amalie Glaze <dionnaglaze@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
 Kees Cook <keescook@chromium.org>, Kevin Loughlin <kevinloughlin@google.com>,
 Len Brown <len.brown@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250418141253.2601348-10-ardb+git@google.com>
References: <20250418141253.2601348-10-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174531375523.31282.7484424643732688311.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/boot branch of tip:

Commit-ID:     b66fcee1574e72663a0c6dd7112a9e22774dbe9f
Gitweb:        https://git.kernel.org/tip/b66fcee1574e72663a0c6dd7112a9e22774dbe9f
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Fri, 18 Apr 2025 16:12:56 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Apr 2025 09:12:00 +02:00

x86/sev: Move noinstr NMI handling code into separate source file

GCC may ignore the __no_sanitize_address function attribute when
inlining, resulting in KASAN instrumentation in code tagged as
'noinstr'.

Move the SEV NMI handling code, which is noinstr, into a separate source
file so KASAN can be disabled on the whole file without losing coverage
of other SEV core code, once the startup code is split off from it too.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: Dionna Amalie Glaze <dionnaglaze@google.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kees Cook <keescook@chromium.org>
Cc: Kevin Loughlin <kevinloughlin@google.com>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lore.kernel.org/r/20250418141253.2601348-10-ardb+git@google.com
---
 arch/x86/coco/sev/Makefile  |   5 +-
 arch/x86/coco/sev/core.c    |  89 +-----------------------------
 arch/x86/coco/sev/sev-nmi.c | 108 +++++++++++++++++++++++++++++++++++-
 3 files changed, 112 insertions(+), 90 deletions(-)
 create mode 100644 arch/x86/coco/sev/sev-nmi.c

diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index dcb06dc..bc4baa4 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 
-obj-y += core.o
+obj-y += core.o sev-nmi.o
 
 # jump tables are emitted using absolute references in non-PIC code
 # so they cannot be used in the early SEV startup code
@@ -20,3 +20,6 @@ KCSAN_SANITIZE		:= n
 
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlining
 UBSAN_SANITIZE		:= n
+
+# GCC may fail to respect __no_sanitize_address when inlining
+KASAN_SANITIZE_sev-nmi.o	:= n
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
index aeb7731..c7a0f3a 100644
--- a/arch/x86/coco/sev/core.c
+++ b/arch/x86/coco/sev/core.c
@@ -113,77 +113,6 @@ DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
 DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
 DEFINE_PER_CPU(u64, svsm_caa_pa);
 
-static __always_inline bool on_vc_stack(struct pt_regs *regs)
-{
-	unsigned long sp = regs->sp;
-
-	/* User-mode RSP is not trusted */
-	if (user_mode(regs))
-		return false;
-
-	/* SYSCALL gap still has user-mode RSP */
-	if (ip_within_syscall_gap(regs))
-		return false;
-
-	return ((sp >= __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
-}
-
-/*
- * This function handles the case when an NMI is raised in the #VC
- * exception handler entry code, before the #VC handler has switched off
- * its IST stack. In this case, the IST entry for #VC must be adjusted,
- * so that any nested #VC exception will not overwrite the stack
- * contents of the interrupted #VC handler.
- *
- * The IST entry is adjusted unconditionally so that it can be also be
- * unconditionally adjusted back in __sev_es_ist_exit(). Otherwise a
- * nested sev_es_ist_exit() call may adjust back the IST entry too
- * early.
- *
- * The __sev_es_ist_enter() and __sev_es_ist_exit() functions always run
- * on the NMI IST stack, as they are only called from NMI handling code
- * right now.
- */
-void noinstr __sev_es_ist_enter(struct pt_regs *regs)
-{
-	unsigned long old_ist, new_ist;
-
-	/* Read old IST entry */
-	new_ist = old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
-
-	/*
-	 * If NMI happened while on the #VC IST stack, set the new IST
-	 * value below regs->sp, so that the interrupted stack frame is
-	 * not overwritten by subsequent #VC exceptions.
-	 */
-	if (on_vc_stack(regs))
-		new_ist = regs->sp;
-
-	/*
-	 * Reserve additional 8 bytes and store old IST value so this
-	 * adjustment can be unrolled in __sev_es_ist_exit().
-	 */
-	new_ist -= sizeof(old_ist);
-	*(unsigned long *)new_ist = old_ist;
-
-	/* Set new IST entry */
-	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
-}
-
-void noinstr __sev_es_ist_exit(void)
-{
-	unsigned long ist;
-
-	/* Read IST entry */
-	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
-
-	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
-		return;
-
-	/* Read back old IST entry and write it to the TSS */
-	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
-}
-
 /*
  * Nothing shall interrupt this code path while holding the per-CPU
  * GHCB. The backup GHCB is only for NMIs interrupting this path.
@@ -608,24 +537,6 @@ int svsm_perform_call_protocol(struct svsm_call *call)
 	return ret;
 }
 
-void noinstr __sev_es_nmi_complete(void)
-{
-	struct ghcb_state state;
-	struct ghcb *ghcb;
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
-	ghcb_set_sw_exit_info_1(ghcb, 0);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
-	VMGEXIT();
-
-	__sev_put_ghcb(&state);
-}
-
 static u64 __init get_snp_jump_table_addr(void)
 {
 	struct snp_secrets_page *secrets;
diff --git a/arch/x86/coco/sev/sev-nmi.c b/arch/x86/coco/sev/sev-nmi.c
new file mode 100644
index 0000000..d8dfadd
--- /dev/null
+++ b/arch/x86/coco/sev/sev-nmi.c
@@ -0,0 +1,108 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2019 SUSE
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+#define pr_fmt(fmt)	"SEV: " fmt
+
+#include <linux/bug.h>
+#include <linux/kernel.h>
+
+#include <asm/cpu_entry_area.h>
+#include <asm/msr.h>
+#include <asm/ptrace.h>
+#include <asm/sev.h>
+#include <asm/sev-internal.h>
+
+static __always_inline bool on_vc_stack(struct pt_regs *regs)
+{
+	unsigned long sp = regs->sp;
+
+	/* User-mode RSP is not trusted */
+	if (user_mode(regs))
+		return false;
+
+	/* SYSCALL gap still has user-mode RSP */
+	if (ip_within_syscall_gap(regs))
+		return false;
+
+	return ((sp >= __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_va(VC)));
+}
+
+/*
+ * This function handles the case when an NMI is raised in the #VC
+ * exception handler entry code, before the #VC handler has switched off
+ * its IST stack. In this case, the IST entry for #VC must be adjusted,
+ * so that any nested #VC exception will not overwrite the stack
+ * contents of the interrupted #VC handler.
+ *
+ * The IST entry is adjusted unconditionally so that it can be also be
+ * unconditionally adjusted back in __sev_es_ist_exit(). Otherwise a
+ * nested sev_es_ist_exit() call may adjust back the IST entry too
+ * early.
+ *
+ * The __sev_es_ist_enter() and __sev_es_ist_exit() functions always run
+ * on the NMI IST stack, as they are only called from NMI handling code
+ * right now.
+ */
+void noinstr __sev_es_ist_enter(struct pt_regs *regs)
+{
+	unsigned long old_ist, new_ist;
+
+	/* Read old IST entry */
+	new_ist = old_ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+
+	/*
+	 * If NMI happened while on the #VC IST stack, set the new IST
+	 * value below regs->sp, so that the interrupted stack frame is
+	 * not overwritten by subsequent #VC exceptions.
+	 */
+	if (on_vc_stack(regs))
+		new_ist = regs->sp;
+
+	/*
+	 * Reserve additional 8 bytes and store old IST value so this
+	 * adjustment can be unrolled in __sev_es_ist_exit().
+	 */
+	new_ist -= sizeof(old_ist);
+	*(unsigned long *)new_ist = old_ist;
+
+	/* Set new IST entry */
+	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], new_ist);
+}
+
+void noinstr __sev_es_ist_exit(void)
+{
+	unsigned long ist;
+
+	/* Read IST entry */
+	ist = __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+
+	if (WARN_ON(ist == __this_cpu_ist_top_va(VC)))
+		return;
+
+	/* Read back old IST entry and write it to the TSS */
+	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
+}
+
+void noinstr __sev_es_nmi_complete(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
+	VMGEXIT();
+
+	__sev_put_ghcb(&state);
+}

