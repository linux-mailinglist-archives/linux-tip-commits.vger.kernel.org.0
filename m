Return-Path: <linux-tip-commits+bounces-6467-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 506FAB439DA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 13:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C49AC5A31BA
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:23:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA530101B;
	Thu,  4 Sep 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ui0FLSM0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KEKVDNag"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 091952EE260;
	Thu,  4 Sep 2025 11:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756984861; cv=none; b=NqlqR4d8CRk3SdgcchFSoyfYOHrBVW28BxX0tN4rPkwUZLjQf7fjc3GzzQYcajtF3+3Hp6Ao1JkJ1LlwZ1bIYNTtoZfAtTxeJ0raH4V0/fBvw5IvK6fGGHgHg6wFyoyuLyPKac5b/JSQszprlNC2ALxXxWc3hnaoQV/cEDoTqo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756984861; c=relaxed/simple;
	bh=ddRZNDSz83lOxAnDFNuhGalsBkB3oddmXur82NPmrSM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VMpGlv5oEw1A/bPPbbyBKQ0HVh9bywq8q5Wqp5EGHoSkAz0Cxs0xHC1v8QWHh827JjRiKeFRKI4cDZdeL+b4T1BHOjhdyL/l13lnRlaJkjq+TJkIB66GoSyYEsJ2w0OodAwxV+9n5RLRHe9kj/VYoaJzBdEuoXdCrk9lA132VLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ui0FLSM0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KEKVDNag; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 11:20:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756984857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfzm9iGez9c0qEkilCdDtmokO6QhfaFVd3HI0yrmWNU=;
	b=Ui0FLSM0k77AKcQ1FjGPIXMK9wfN4SVak+hXEj2iOYkETrXVbcD6718NlcP6ga6p7JrDiv
	DsFTj5cxhNqwvlCSAK+fjopfi6eYLATmWL7gXF9jWcIxdHoFifWTx+PDhufKhynomimNKr
	FiWyFO9up3YDXzcMWEaTKX84t8gD55ww4nA/ahAEYflYvNXjDUVpe/2eSOz+sZ2T9bqMBv
	Gfl2n2p9uKZZDZIzsCBWjp5VY92LORpi4C0V6L+gcNuFdZOxocEz7sizmyWYO3yLlhIdsI
	b6nI82bni05eDnMidUvOc+ALIgeMl5pPIALZ3+AkYUZHR33bqAW+IrASfwEFLA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756984857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qfzm9iGez9c0qEkilCdDtmokO6QhfaFVd3HI0yrmWNU=;
	b=KEKVDNagEtohCT48zWIXenB71n/kiih8hfSzJxCKhl73Fy2tPgWUApNBE/pBALz1TWlgBz
	fs2ujemxoUwoExAg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move __sev_[get|put]_ghcb() into separate
 noinstr object
Cc: Ard Biesheuvel <ardb@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250828102202.1849035-37-ardb+git@google.com>
References: <20250828102202.1849035-37-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175698485592.1920.6333896615534687362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     d4077e6ad35121b97f3233da5d60763de3d23df9
Gitweb:        https://git.kernel.org/tip/d4077e6ad35121b97f3233da5d60763de3d=
23df9
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 28 Aug 2025 12:22:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 03 Sep 2025 17:59:46 +02:00

x86/sev: Move __sev_[get|put]_ghcb() into separate noinstr object

Rename sev-nmi.c to noinstr.c, and move the get/put GHCB routines into it too,
which are also annotated as 'noinstr' and suffer from the same problem as the
NMI code, i.e., that GCC may ignore the __no_sanitize_address__ function
attribute implied by 'noinstr' and insert KASAN instrumentation anyway.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250828102202.1849035-37-ardb+git@google.com
---
 arch/x86/boot/startup/sev-startup.c |  74 +-----------
 arch/x86/coco/sev/Makefile          |   8 +-
 arch/x86/coco/sev/noinstr.c         | 182 +++++++++++++++++++++++++++-
 arch/x86/coco/sev/sev-nmi.c         | 108 +----------------
 4 files changed, 186 insertions(+), 186 deletions(-)
 create mode 100644 arch/x86/coco/sev/noinstr.c
 delete mode 100644 arch/x86/coco/sev/sev-nmi.c

diff --git a/arch/x86/boot/startup/sev-startup.c b/arch/x86/boot/startup/sev-=
startup.c
index 138b26f..9f4b4ca 100644
--- a/arch/x86/boot/startup/sev-startup.c
+++ b/arch/x86/boot/startup/sev-startup.c
@@ -41,83 +41,9 @@
 #include <asm/cpuid/api.h>
 #include <asm/cmdline.h>
=20
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data =3D this_cpu_read(runtime_data);
-	ghcb =3D &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active)) {
-			/*
-			 * Backup-GHCB is also already in use. There is no way
-			 * to continue here so just kill the machine. To make
-			 * panic() work, mark GHCBs inactive so that messages
-			 * can be printed out.
-			 */
-			data->ghcb_active        =3D false;
-			data->backup_ghcb_active =3D false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already i=
n use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active =3D true;
-
-		state->ghcb =3D &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb =3D *ghcb;
-	} else {
-		state->ghcb =3D NULL;
-		data->ghcb_active =3D true;
-	}
-
-	return ghcb;
-}
-
 /* Include code shared with pre-decompression boot stage */
 #include "sev-shared.c"
=20
-noinstr void __sev_put_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data =3D this_cpu_read(runtime_data);
-	ghcb =3D &data->ghcb_page;
-
-	if (state->ghcb) {
-		/* Restore GHCB from Backup */
-		*ghcb =3D *state->ghcb;
-		data->backup_ghcb_active =3D false;
-		state->ghcb =3D NULL;
-	} else {
-		/*
-		 * Invalidate the GHCB so a VMGEXIT instruction issued
-		 * from userspace won't appear to be valid.
-		 */
-		vc_ghcb_invalidate(ghcb);
-		data->ghcb_active =3D false;
-	}
-}
-
 void __head
 early_set_pages_state(unsigned long vaddr, unsigned long paddr,
 		      unsigned long npages, const struct psc_desc *desc)
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
index 342d79f..3b8ae21 100644
--- a/arch/x86/coco/sev/Makefile
+++ b/arch/x86/coco/sev/Makefile
@@ -1,10 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
=20
-obj-y +=3D core.o sev-nmi.o vc-handle.o
+obj-y +=3D core.o noinstr.o vc-handle.o
=20
 # Clang 14 and older may fail to respect __no_sanitize_undefined when inlini=
ng
-UBSAN_SANITIZE_sev-nmi.o	:=3D n
+UBSAN_SANITIZE_noinstr.o	:=3D n
=20
 # GCC may fail to respect __no_sanitize_address or __no_kcsan when inlining
-KASAN_SANITIZE_sev-nmi.o	:=3D n
-KCSAN_SANITIZE_sev-nmi.o	:=3D n
+KASAN_SANITIZE_noinstr.o	:=3D n
+KCSAN_SANITIZE_noinstr.o	:=3D n
diff --git a/arch/x86/coco/sev/noinstr.c b/arch/x86/coco/sev/noinstr.c
new file mode 100644
index 0000000..b527eaf
--- /dev/null
+++ b/arch/x86/coco/sev/noinstr.c
@@ -0,0 +1,182 @@
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
+	unsigned long sp =3D regs->sp;
+
+	/* User-mode RSP is not trusted */
+	if (user_mode(regs))
+		return false;
+
+	/* SYSCALL gap still has user-mode RSP */
+	if (ip_within_syscall_gap(regs))
+		return false;
+
+	return ((sp >=3D __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_=
va(VC)));
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
+	new_ist =3D old_ist =3D __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC=
]);
+
+	/*
+	 * If NMI happened while on the #VC IST stack, set the new IST
+	 * value below regs->sp, so that the interrupted stack frame is
+	 * not overwritten by subsequent #VC exceptions.
+	 */
+	if (on_vc_stack(regs))
+		new_ist =3D regs->sp;
+
+	/*
+	 * Reserve additional 8 bytes and store old IST value so this
+	 * adjustment can be unrolled in __sev_es_ist_exit().
+	 */
+	new_ist -=3D sizeof(old_ist);
+	*(unsigned long *)new_ist =3D old_ist;
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
+	ist =3D __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
+
+	if (WARN_ON(ist =3D=3D __this_cpu_ist_top_va(VC)))
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
+	ghcb =3D __sev_get_ghcb(&state);
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
+
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data =3D this_cpu_read(runtime_data);
+	ghcb =3D &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active)) {
+			/*
+			 * Backup-GHCB is also already in use. There is no way
+			 * to continue here so just kill the machine. To make
+			 * panic() work, mark GHCBs inactive so that messages
+			 * can be printed out.
+			 */
+			data->ghcb_active        =3D false;
+			data->backup_ghcb_active =3D false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already i=
n use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active =3D true;
+
+		state->ghcb =3D &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb =3D *ghcb;
+	} else {
+		state->ghcb =3D NULL;
+		data->ghcb_active =3D true;
+	}
+
+	return ghcb;
+}
+
+noinstr void __sev_put_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data =3D this_cpu_read(runtime_data);
+	ghcb =3D &data->ghcb_page;
+
+	if (state->ghcb) {
+		/* Restore GHCB from Backup */
+		*ghcb =3D *state->ghcb;
+		data->backup_ghcb_active =3D false;
+		state->ghcb =3D NULL;
+	} else {
+		/*
+		 * Invalidate the GHCB so a VMGEXIT instruction issued
+		 * from userspace won't appear to be valid.
+		 */
+		vc_ghcb_invalidate(ghcb);
+		data->ghcb_active =3D false;
+	}
+}
diff --git a/arch/x86/coco/sev/sev-nmi.c b/arch/x86/coco/sev/sev-nmi.c
deleted file mode 100644
index d8dfadd..0000000
--- a/arch/x86/coco/sev/sev-nmi.c
+++ /dev/null
@@ -1,108 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * AMD Memory Encryption Support
- *
- * Copyright (C) 2019 SUSE
- *
- * Author: Joerg Roedel <jroedel@suse.de>
- */
-
-#define pr_fmt(fmt)	"SEV: " fmt
-
-#include <linux/bug.h>
-#include <linux/kernel.h>
-
-#include <asm/cpu_entry_area.h>
-#include <asm/msr.h>
-#include <asm/ptrace.h>
-#include <asm/sev.h>
-#include <asm/sev-internal.h>
-
-static __always_inline bool on_vc_stack(struct pt_regs *regs)
-{
-	unsigned long sp =3D regs->sp;
-
-	/* User-mode RSP is not trusted */
-	if (user_mode(regs))
-		return false;
-
-	/* SYSCALL gap still has user-mode RSP */
-	if (ip_within_syscall_gap(regs))
-		return false;
-
-	return ((sp >=3D __this_cpu_ist_bottom_va(VC)) && (sp < __this_cpu_ist_top_=
va(VC)));
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
-	new_ist =3D old_ist =3D __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC=
]);
-
-	/*
-	 * If NMI happened while on the #VC IST stack, set the new IST
-	 * value below regs->sp, so that the interrupted stack frame is
-	 * not overwritten by subsequent #VC exceptions.
-	 */
-	if (on_vc_stack(regs))
-		new_ist =3D regs->sp;
-
-	/*
-	 * Reserve additional 8 bytes and store old IST value so this
-	 * adjustment can be unrolled in __sev_es_ist_exit().
-	 */
-	new_ist -=3D sizeof(old_ist);
-	*(unsigned long *)new_ist =3D old_ist;
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
-	ist =3D __this_cpu_read(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC]);
-
-	if (WARN_ON(ist =3D=3D __this_cpu_ist_top_va(VC)))
-		return;
-
-	/* Read back old IST entry and write it to the TSS */
-	this_cpu_write(cpu_tss_rw.x86_tss.ist[IST_INDEX_VC], *(unsigned long *)ist);
-}
-
-void noinstr __sev_es_nmi_complete(void)
-{
-	struct ghcb_state state;
-	struct ghcb *ghcb;
-
-	ghcb =3D __sev_get_ghcb(&state);
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

