Return-Path: <linux-tip-commits+bounces-1480-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 331DB9122DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 12:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A1EB1C21791
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 10:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E81084D04;
	Fri, 21 Jun 2024 10:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YKMkDr4L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o53/TqzF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF479171E4F;
	Fri, 21 Jun 2024 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718967455; cv=none; b=AL/MwgU5WDc/7is5MMhSda4AwR96XWAF7GBhX/Ky9hoBwvqyblocpcVlFuMRwxDJz6ski7SENG3VMCyVJRI0OWAH4t3XbjEJsUlrFca9OX/HQJ7o9EM0gOwMRODi/C+eR0a5TgbFSBcx7JboRhwPHbRob4gN47ctnRiKF9+jC8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718967455; c=relaxed/simple;
	bh=gj2mwHjjTIHHRDZ2Pp9VIM9EuKIzjovYTISSx5Rs/kE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RqAQraGbZ3xnAoDfcLZubt7OZ+x67mwcT0z+BhEBjhzE7xfPOHoiknpTR7w5wAIT9uP1Gs7Z7226AA1yMCCseXWTElY0DBoNQ6yjiVZaieo5vUj5hCQerHiTBcBr7zZdtJPHg+Hh4EW7xWVMU2WOx+I9bHaDEa4Yg3vXUJkY13c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YKMkDr4L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o53/TqzF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 10:57:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718967445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwfP3D08Q8RhrSJ+Ftq8gsONBuH3+UtDyf9bnU3TX1w=;
	b=YKMkDr4L+Fn/00d8bCHp9GKvBiMlZwAZh6xJON+h0sV5zUAeiEJcQDj5SKoHBP0CmGBFrS
	UhZQ2sJBJMhvSY9YuBKYtLOxqIwpios8tGssusKC9UGxFCEO0c1suKerv6q0ZTMw4axOZC
	kIysCDM7Xw42180PyT/Y12b2YSseNajPBMES5k6ewxHAp8YvdQdC8t4EB9O8m2V0C42Z4f
	Ynv3ffP3JUxfmCAoAPJs4aZKiGGT8GpPOJRnSbr9RRDUdSstJueBQcapyFylfUfD8HzLR0
	zT8II+jK4H+V+Oq43cryiql0FewA4avC+4EOVmjsORtocg0zqAA52UmYaPbU4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718967445;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mwfP3D08Q8RhrSJ+Ftq8gsONBuH3+UtDyf9bnU3TX1w=;
	b=o53/TqzFH/eiJ4I0dBowMkzvkFfk+Ax2HKrU/rZDXpxLQuGFTLWnwqrNAMG1p69wxalB3I
	5kfH9wLjOwmjazBA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/sev: Move SEV compilation units
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Nikunj A Dadhania <nikunj@amd.com>,
 Ashish Kalra <ashish.kalra@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240619093014.17962-1-bp@kernel.org>
References: <20240619093014.17962-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171896744436.10875.6147227014711967467.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     06685975c2090e180851a0ff175c140188b6b54a
Gitweb:        https://git.kernel.org/tip/06685975c2090e180851a0ff175c140188b6b54a
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Wed, 19 Jun 2024 11:03:16 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Jun 2024 12:31:59 +02:00

x86/sev: Move SEV compilation units

A long time ago we said that we're going to move the coco stuff where it
belongs

  https://lore.kernel.org/all/Yg5nh1RknPRwIrb8@zn.tnic

and not keep it in arch/x86/kernel. TDX did that and SEV can't find time
to do so. So lemme do it. If people have trouble converting their
ongoing featuritis patches, ask me for a sed script.

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Ashish Kalra <ashish.kalra@amd.com>
Link: https://lore.kernel.org/r/20240619093014.17962-1-bp@kernel.org
---
 arch/x86/boot/compressed/sev.c |    2 +-
 arch/x86/coco/Makefile         |    1 +-
 arch/x86/coco/sev/Makefile     |    3 +-
 arch/x86/coco/sev/core.c       | 2606 +++++++++++++++++++++++++++++++-
 arch/x86/coco/sev/shared.c     | 1717 ++++++++++++++++++++-
 arch/x86/kernel/Makefile       |    2 +-
 arch/x86/kernel/sev-shared.c   | 1717 +--------------------
 arch/x86/kernel/sev.c          | 2606 +-------------------------------
 8 files changed, 4328 insertions(+), 4326 deletions(-)
 create mode 100644 arch/x86/coco/sev/Makefile
 create mode 100644 arch/x86/coco/sev/core.c
 create mode 100644 arch/x86/coco/sev/shared.c
 delete mode 100644 arch/x86/kernel/sev-shared.c
 delete mode 100644 arch/x86/kernel/sev.c

diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
index 6970572..cd44e12 100644
--- a/arch/x86/boot/compressed/sev.c
+++ b/arch/x86/boot/compressed/sev.c
@@ -127,7 +127,7 @@ static bool fault_in_kernel_space(unsigned long address)
 #include "../../lib/insn.c"
 
 /* Include code for early handlers */
-#include "../../kernel/sev-shared.c"
+#include "../../coco/sev/shared.c"
 
 static struct svsm_ca *svsm_get_caa(void)
 {
diff --git a/arch/x86/coco/Makefile b/arch/x86/coco/Makefile
index c816acf..eabdc74 100644
--- a/arch/x86/coco/Makefile
+++ b/arch/x86/coco/Makefile
@@ -6,3 +6,4 @@ CFLAGS_core.o		+= -fno-stack-protector
 obj-y += core.o
 
 obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx/
+obj-$(CONFIG_AMD_MEM_ENCRYPT)   += sev/
diff --git a/arch/x86/coco/sev/Makefile b/arch/x86/coco/sev/Makefile
new file mode 100644
index 0000000..b89ba3f
--- /dev/null
+++ b/arch/x86/coco/sev/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-y += core.o
diff --git a/arch/x86/coco/sev/core.c b/arch/x86/coco/sev/core.c
new file mode 100644
index 0000000..082d61d
--- /dev/null
+++ b/arch/x86/coco/sev/core.c
@@ -0,0 +1,2606 @@
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
+#include <linux/sched/debug.h>	/* For show_regs() */
+#include <linux/percpu-defs.h>
+#include <linux/cc_platform.h>
+#include <linux/printk.h>
+#include <linux/mm_types.h>
+#include <linux/set_memory.h>
+#include <linux/memblock.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/cpumask.h>
+#include <linux/efi.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/psp-sev.h>
+#include <linux/dmi.h>
+#include <uapi/linux/sev-guest.h>
+
+#include <asm/init.h>
+#include <asm/cpu_entry_area.h>
+#include <asm/stacktrace.h>
+#include <asm/sev.h>
+#include <asm/insn-eval.h>
+#include <asm/fpu/xcr.h>
+#include <asm/processor.h>
+#include <asm/realmode.h>
+#include <asm/setup.h>
+#include <asm/traps.h>
+#include <asm/svm.h>
+#include <asm/smp.h>
+#include <asm/cpu.h>
+#include <asm/apic.h>
+#include <asm/cpuid.h>
+#include <asm/cmdline.h>
+
+#define DR7_RESET_VALUE        0x400
+
+/* AP INIT values as documented in the APM2  section "Processor Initialization State" */
+#define AP_INIT_CS_LIMIT		0xffff
+#define AP_INIT_DS_LIMIT		0xffff
+#define AP_INIT_LDTR_LIMIT		0xffff
+#define AP_INIT_GDTR_LIMIT		0xffff
+#define AP_INIT_IDTR_LIMIT		0xffff
+#define AP_INIT_TR_LIMIT		0xffff
+#define AP_INIT_RFLAGS_DEFAULT		0x2
+#define AP_INIT_DR6_DEFAULT		0xffff0ff0
+#define AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
+#define AP_INIT_XCR0_DEFAULT		0x1
+#define AP_INIT_X87_FTW_DEFAULT		0x5555
+#define AP_INIT_X87_FCW_DEFAULT		0x0040
+#define AP_INIT_CR0_DEFAULT		0x60000010
+#define AP_INIT_MXCSR_DEFAULT		0x1f80
+
+static const char * const sev_status_feat_names[] = {
+	[MSR_AMD64_SEV_ENABLED_BIT]		= "SEV",
+	[MSR_AMD64_SEV_ES_ENABLED_BIT]		= "SEV-ES",
+	[MSR_AMD64_SEV_SNP_ENABLED_BIT]		= "SEV-SNP",
+	[MSR_AMD64_SNP_VTOM_BIT]		= "vTom",
+	[MSR_AMD64_SNP_REFLECT_VC_BIT]		= "ReflectVC",
+	[MSR_AMD64_SNP_RESTRICTED_INJ_BIT]	= "RI",
+	[MSR_AMD64_SNP_ALT_INJ_BIT]		= "AI",
+	[MSR_AMD64_SNP_DEBUG_SWAP_BIT]		= "DebugSwap",
+	[MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT]	= "NoHostIBS",
+	[MSR_AMD64_SNP_BTB_ISOLATION_BIT]	= "BTBIsol",
+	[MSR_AMD64_SNP_VMPL_SSS_BIT]		= "VmplSSS",
+	[MSR_AMD64_SNP_SECURE_TSC_BIT]		= "SecureTSC",
+	[MSR_AMD64_SNP_VMGEXIT_PARAM_BIT]	= "VMGExitParam",
+	[MSR_AMD64_SNP_IBS_VIRT_BIT]		= "IBSVirt",
+	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
+	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
+};
+
+/* For early boot hypervisor communication in SEV-ES enabled guests */
+static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+
+/*
+ * Needs to be in the .data section because we need it NULL before bss is
+ * cleared
+ */
+static struct ghcb *boot_ghcb __section(".data");
+
+/* Bitmap of SEV features supported by the hypervisor */
+static u64 sev_hv_features __ro_after_init;
+
+/* #VC handler runtime per-CPU data */
+struct sev_es_runtime_data {
+	struct ghcb ghcb_page;
+
+	/*
+	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
+	 * It is needed when an NMI happens while the #VC handler uses the real
+	 * GHCB, and the NMI handler itself is causing another #VC exception. In
+	 * that case the GHCB content of the first handler needs to be backed up
+	 * and restored.
+	 */
+	struct ghcb backup_ghcb;
+
+	/*
+	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
+	 * There is no need for it to be atomic, because nothing is written to
+	 * the GHCB between the read and the write of ghcb_active. So it is safe
+	 * to use it when a nested #VC exception happens before the write.
+	 *
+	 * This is necessary for example in the #VC->NMI->#VC case when the NMI
+	 * happens while the first #VC handler uses the GHCB. When the NMI code
+	 * raises a second #VC handler it might overwrite the contents of the
+	 * GHCB written by the first handler. To avoid this the content of the
+	 * GHCB is saved and restored when the GHCB is detected to be in use
+	 * already.
+	 */
+	bool ghcb_active;
+	bool backup_ghcb_active;
+
+	/*
+	 * Cached DR7 value - write it on DR7 writes and return it on reads.
+	 * That value will never make it to the real hardware DR7 as debugging
+	 * is currently unsupported in SEV-ES guests.
+	 */
+	unsigned long dr7;
+};
+
+struct ghcb_state {
+	struct ghcb *ghcb;
+};
+
+/* For early boot SVSM communication */
+static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
+
+static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
+static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
+static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
+static DEFINE_PER_CPU(u64, svsm_caa_pa);
+
+struct sev_config {
+	__u64 debug		: 1,
+
+	      /*
+	       * Indicates when the per-CPU GHCB has been created and registered
+	       * and thus can be used by the BSP instead of the early boot GHCB.
+	       *
+	       * For APs, the per-CPU GHCB is created before they are started
+	       * and registered upon startup, so this flag can be used globally
+	       * for the BSP and APs.
+	       */
+	      ghcbs_initialized	: 1,
+
+	      /*
+	       * Indicates when the per-CPU SVSM CA is to be used instead of the
+	       * boot SVSM CA.
+	       *
+	       * For APs, the per-CPU SVSM CA is created as part of the AP
+	       * bringup, so this flag can be used globally for the BSP and APs.
+	       */
+	      use_cas		: 1,
+
+	      __reserved	: 62;
+};
+
+static struct sev_config sev_cfg __read_mostly;
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
+/*
+ * Nothing shall interrupt this code path while holding the per-CPU
+ * GHCB. The backup GHCB is only for NMIs interrupting this path.
+ *
+ * Callers must disable local interrupts around it.
+ */
+static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
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
+			data->ghcb_active        = false;
+			data->backup_ghcb_active = false;
+
+			instrumentation_begin();
+			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+			instrumentation_end();
+		}
+
+		/* Mark backup_ghcb active before writing to it */
+		data->backup_ghcb_active = true;
+
+		state->ghcb = &data->backup_ghcb;
+
+		/* Backup GHCB content */
+		*state->ghcb = *ghcb;
+	} else {
+		state->ghcb = NULL;
+		data->ghcb_active = true;
+	}
+
+	return ghcb;
+}
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
+}
+
+static __always_inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = (u32)(val);
+	high = (u32)(val >> 32);
+
+	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
+}
+
+static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
+				unsigned char *buffer)
+{
+	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+}
+
+static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	int insn_bytes;
+
+	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
+	if (insn_bytes == 0) {
+		/* Nothing could be copied */
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	} else if (insn_bytes == -EINVAL) {
+		/* Effective RIP could not be calculated */
+		ctxt->fi.vector     = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		ctxt->fi.cr2        = 0;
+		return ES_EXCEPTION;
+	}
+
+	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
+		return ES_DECODE_FAILED;
+
+	if (ctxt->insn.immediate.got)
+		return ES_OK;
+	else
+		return ES_DECODE_FAILED;
+}
+
+static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	int res, ret;
+
+	res = vc_fetch_insn_kernel(ctxt, buffer);
+	if (res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
+
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
+	else
+		return ES_OK;
+}
+
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	if (user_mode(ctxt->regs))
+		return __vc_decode_user_insn(ctxt);
+	else
+		return __vc_decode_kern_insn(ctxt);
+}
+
+static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
+				   char *dst, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
+
+	/*
+	 * This function uses __put_user() independent of whether kernel or user
+	 * memory is accessed. This works fine because __put_user() does no
+	 * sanity checks of the pointer being accessed. All that it does is
+	 * to report when the access failed.
+	 *
+	 * Also, this function runs in atomic context, so __put_user() is not
+	 * allowed to sleep. The page-fault handler detects that it is running
+	 * in atomic context and will not try to take mmap_sem and handle the
+	 * fault, so additional pagefault_enable()/disable() calls are not
+	 * needed.
+	 *
+	 * The access can't be done via copy_to_user() here because
+	 * vc_write_mem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the #VC handler by
+	 * splitting the move up into a read and a write and taking a nested #VC
+	 * exception on whatever of them is the MMIO access. Using string
+	 * instructions here would cause infinite nesting.
+	 */
+	switch (size) {
+	case 1: {
+		u8 d1;
+		u8 __user *target = (u8 __user *)dst;
+
+		memcpy(&d1, buf, 1);
+		if (__put_user(d1, target))
+			goto fault;
+		break;
+	}
+	case 2: {
+		u16 d2;
+		u16 __user *target = (u16 __user *)dst;
+
+		memcpy(&d2, buf, 2);
+		if (__put_user(d2, target))
+			goto fault;
+		break;
+	}
+	case 4: {
+		u32 d4;
+		u32 __user *target = (u32 __user *)dst;
+
+		memcpy(&d4, buf, 4);
+		if (__put_user(d4, target))
+			goto fault;
+		break;
+	}
+	case 8: {
+		u64 d8;
+		u64 __user *target = (u64 __user *)dst;
+
+		memcpy(&d8, buf, 8);
+		if (__put_user(d8, target))
+			goto fault;
+		break;
+	}
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)dst;
+
+	return ES_EXCEPTION;
+}
+
+static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
+				  char *src, char *buf, size_t size)
+{
+	unsigned long error_code = X86_PF_PROT;
+
+	/*
+	 * This function uses __get_user() independent of whether kernel or user
+	 * memory is accessed. This works fine because __get_user() does no
+	 * sanity checks of the pointer being accessed. All that it does is
+	 * to report when the access failed.
+	 *
+	 * Also, this function runs in atomic context, so __get_user() is not
+	 * allowed to sleep. The page-fault handler detects that it is running
+	 * in atomic context and will not try to take mmap_sem and handle the
+	 * fault, so additional pagefault_enable()/disable() calls are not
+	 * needed.
+	 *
+	 * The access can't be done via copy_from_user() here because
+	 * vc_read_mem() must not use string instructions to access unsafe
+	 * memory. The reason is that MOVS is emulated by the #VC handler by
+	 * splitting the move up into a read and a write and taking a nested #VC
+	 * exception on whatever of them is the MMIO access. Using string
+	 * instructions here would cause infinite nesting.
+	 */
+	switch (size) {
+	case 1: {
+		u8 d1;
+		u8 __user *s = (u8 __user *)src;
+
+		if (__get_user(d1, s))
+			goto fault;
+		memcpy(buf, &d1, 1);
+		break;
+	}
+	case 2: {
+		u16 d2;
+		u16 __user *s = (u16 __user *)src;
+
+		if (__get_user(d2, s))
+			goto fault;
+		memcpy(buf, &d2, 2);
+		break;
+	}
+	case 4: {
+		u32 d4;
+		u32 __user *s = (u32 __user *)src;
+
+		if (__get_user(d4, s))
+			goto fault;
+		memcpy(buf, &d4, 4);
+		break;
+	}
+	case 8: {
+		u64 d8;
+		u64 __user *s = (u64 __user *)src;
+		if (__get_user(d8, s))
+			goto fault;
+		memcpy(buf, &d8, 8);
+		break;
+	}
+	default:
+		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
+		return ES_UNSUPPORTED;
+	}
+
+	return ES_OK;
+
+fault:
+	if (user_mode(ctxt->regs))
+		error_code |= X86_PF_USER;
+
+	ctxt->fi.vector = X86_TRAP_PF;
+	ctxt->fi.error_code = error_code;
+	ctxt->fi.cr2 = (unsigned long)src;
+
+	return ES_EXCEPTION;
+}
+
+static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+					   unsigned long vaddr, phys_addr_t *paddr)
+{
+	unsigned long va = (unsigned long)vaddr;
+	unsigned int level;
+	phys_addr_t pa;
+	pgd_t *pgd;
+	pte_t *pte;
+
+	pgd = __va(read_cr3_pa());
+	pgd = &pgd[pgd_index(va)];
+	pte = lookup_address_in_pgd(pgd, va, &level);
+	if (!pte) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.cr2        = vaddr;
+		ctxt->fi.error_code = 0;
+
+		if (user_mode(ctxt->regs))
+			ctxt->fi.error_code |= X86_PF_USER;
+
+		return ES_EXCEPTION;
+	}
+
+	if (WARN_ON_ONCE(pte_val(*pte) & _PAGE_ENC))
+		/* Emulated MMIO to/from encrypted memory not supported */
+		return ES_UNSUPPORTED;
+
+	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
+	pa |= va & ~page_level_mask(level);
+
+	*paddr = pa;
+
+	return ES_OK;
+}
+
+static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
+{
+	BUG_ON(size > 4);
+
+	if (user_mode(ctxt->regs)) {
+		struct thread_struct *t = &current->thread;
+		struct io_bitmap *iobm = t->io_bitmap;
+		size_t idx;
+
+		if (!iobm)
+			goto fault;
+
+		for (idx = port; idx < port + size; ++idx) {
+			if (test_bit(idx, iobm->bitmap))
+				goto fault;
+		}
+	}
+
+	return ES_OK;
+
+fault:
+	ctxt->fi.vector = X86_TRAP_GP;
+	ctxt->fi.error_code = 0;
+
+	return ES_EXCEPTION;
+}
+
+static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
+{
+	long error_code = ctxt->fi.error_code;
+	int trapnr = ctxt->fi.vector;
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+
+	switch (trapnr) {
+	case X86_TRAP_GP:
+		exc_general_protection(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_UD:
+		exc_invalid_op(ctxt->regs);
+		break;
+	case X86_TRAP_PF:
+		write_cr2(ctxt->fi.cr2);
+		exc_page_fault(ctxt->regs, error_code);
+		break;
+	case X86_TRAP_AC:
+		exc_alignment_check(ctxt->regs, error_code);
+		break;
+	default:
+		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
+		BUG();
+	}
+}
+
+/* Include code shared with pre-decompression boot stage */
+#include "shared.c"
+
+static inline struct svsm_ca *svsm_get_caa(void)
+{
+	/*
+	 * Use rIP-relative references when called early in the boot. If
+	 * ->use_cas is set, then it is late in the boot and no need
+	 * to worry about rIP-relative references.
+	 */
+	if (RIP_REL_REF(sev_cfg).use_cas)
+		return this_cpu_read(svsm_caa);
+	else
+		return RIP_REL_REF(boot_svsm_caa);
+}
+
+static u64 svsm_get_caa_pa(void)
+{
+	/*
+	 * Use rIP-relative references when called early in the boot. If
+	 * ->use_cas is set, then it is late in the boot and no need
+	 * to worry about rIP-relative references.
+	 */
+	if (RIP_REL_REF(sev_cfg).use_cas)
+		return this_cpu_read(svsm_caa_pa);
+	else
+		return RIP_REL_REF(boot_svsm_caa_pa);
+}
+
+static noinstr void __sev_put_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	WARN_ON(!irqs_disabled());
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (state->ghcb) {
+		/* Restore GHCB from Backup */
+		*ghcb = *state->ghcb;
+		data->backup_ghcb_active = false;
+		state->ghcb = NULL;
+	} else {
+		/*
+		 * Invalidate the GHCB so a VMGEXIT instruction issued
+		 * from userspace won't appear to be valid.
+		 */
+		vc_ghcb_invalidate(ghcb);
+		data->ghcb_active = false;
+	}
+}
+
+static int svsm_perform_call_protocol(struct svsm_call *call)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	/*
+	 * Use rip-relative references when called early in the boot. If
+	 * ghcbs_initialized is set, then it is late in the boot and no need
+	 * to worry about rip-relative references in called functions.
+	 */
+	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else if (RIP_REL_REF(boot_ghcb))
+		ghcb = RIP_REL_REF(boot_ghcb);
+	else
+		ghcb = NULL;
+
+	do {
+		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
+			   : svsm_perform_msr_protocol(call);
+	} while (ret == -EAGAIN);
+
+	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	native_local_irq_restore(flags);
+
+	return ret;
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
+
+static u64 __init get_secrets_page(void)
+{
+	u64 pa_data = boot_params.cc_blob_address;
+	struct cc_blob_sev_info info;
+	void *map;
+
+	/*
+	 * The CC blob contains the address of the secrets page, check if the
+	 * blob is present.
+	 */
+	if (!pa_data)
+		return 0;
+
+	map = early_memremap(pa_data, sizeof(info));
+	if (!map) {
+		pr_err("Unable to locate SNP secrets page: failed to map the Confidential Computing blob.\n");
+		return 0;
+	}
+	memcpy(&info, map, sizeof(info));
+	early_memunmap(map, sizeof(info));
+
+	/* smoke-test the secrets page passed */
+	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
+		return 0;
+
+	return info.secrets_phys;
+}
+
+static u64 __init get_snp_jump_table_addr(void)
+{
+	struct snp_secrets_page *secrets;
+	void __iomem *mem;
+	u64 pa, addr;
+
+	pa = get_secrets_page();
+	if (!pa)
+		return 0;
+
+	mem = ioremap_encrypted(pa, PAGE_SIZE);
+	if (!mem) {
+		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
+		return 0;
+	}
+
+	secrets = (__force struct snp_secrets_page *)mem;
+
+	addr = secrets->os_area.ap_jump_table_pa;
+	iounmap(mem);
+
+	return addr;
+}
+
+static u64 __init get_jump_table_addr(void)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	u64 ret = 0;
+
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return get_snp_jump_table_addr();
+
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_JUMP_TABLE);
+	ghcb_set_sw_exit_info_1(ghcb, SVM_VMGEXIT_GET_AP_JUMP_TABLE);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (ghcb_sw_exit_info_1_is_valid(ghcb) &&
+	    ghcb_sw_exit_info_2_is_valid(ghcb))
+		ret = ghcb->save.sw_exit_info_2;
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+static void __head
+early_set_pages_state(unsigned long vaddr, unsigned long paddr,
+		      unsigned long npages, enum psc_op op)
+{
+	unsigned long paddr_end;
+	u64 val;
+
+	vaddr = vaddr & PAGE_MASK;
+
+	paddr = paddr & PAGE_MASK;
+	paddr_end = paddr + (npages << PAGE_SHIFT);
+
+	while (paddr < paddr_end) {
+		/* Page validation must be rescinded before changing to shared */
+		if (op == SNP_PAGE_STATE_SHARED)
+			pvalidate_4k_page(vaddr, paddr, false);
+
+		/*
+		 * Use the MSR protocol because this function can be called before
+		 * the GHCB is established.
+		 */
+		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
+		VMGEXIT();
+
+		val = sev_es_rd_ghcb_msr();
+
+		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
+			 "Wrong PSC response code: 0x%x\n",
+			 (unsigned int)GHCB_RESP_CODE(val)))
+			goto e_term;
+
+		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
+			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
+			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
+			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
+			goto e_term;
+
+		/* Page validation must be performed after changing to private */
+		if (op == SNP_PAGE_STATE_PRIVATE)
+			pvalidate_4k_page(vaddr, paddr, true);
+
+		vaddr += PAGE_SIZE;
+		paddr += PAGE_SIZE;
+	}
+
+	return;
+
+e_term:
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+}
+
+void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
+					 unsigned long npages)
+{
+	/*
+	 * This can be invoked in early boot while running identity mapped, so
+	 * use an open coded check for SNP instead of using cc_platform_has().
+	 * This eliminates worries about jump tables or checking boot_cpu_data
+	 * in the cc_platform_has() function.
+	 */
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+		return;
+
+	 /*
+	  * Ask the hypervisor to mark the memory pages as private in the RMP
+	  * table.
+	  */
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
+}
+
+void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
+					unsigned long npages)
+{
+	/*
+	 * This can be invoked in early boot while running identity mapped, so
+	 * use an open coded check for SNP instead of using cc_platform_has().
+	 * This eliminates worries about jump tables or checking boot_cpu_data
+	 * in the cc_platform_has() function.
+	 */
+	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
+		return;
+
+	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
+	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
+				       unsigned long vaddr_end, int op)
+{
+	struct ghcb_state state;
+	bool use_large_entry;
+	struct psc_hdr *hdr;
+	struct psc_entry *e;
+	unsigned long flags;
+	unsigned long pfn;
+	struct ghcb *ghcb;
+	int i;
+
+	hdr = &data->hdr;
+	e = data->entries;
+
+	memset(data, 0, sizeof(*data));
+	i = 0;
+
+	while (vaddr < vaddr_end && i < ARRAY_SIZE(data->entries)) {
+		hdr->end_entry = i;
+
+		if (is_vmalloc_addr((void *)vaddr)) {
+			pfn = vmalloc_to_pfn((void *)vaddr);
+			use_large_entry = false;
+		} else {
+			pfn = __pa(vaddr) >> PAGE_SHIFT;
+			use_large_entry = true;
+		}
+
+		e->gfn = pfn;
+		e->operation = op;
+
+		if (use_large_entry && IS_ALIGNED(vaddr, PMD_SIZE) &&
+		    (vaddr_end - vaddr) >= PMD_SIZE) {
+			e->pagesize = RMP_PG_SIZE_2M;
+			vaddr += PMD_SIZE;
+		} else {
+			e->pagesize = RMP_PG_SIZE_4K;
+			vaddr += PAGE_SIZE;
+		}
+
+		e++;
+		i++;
+	}
+
+	/* Page validation must be rescinded before changing to shared */
+	if (op == SNP_PAGE_STATE_SHARED)
+		pvalidate_pages(data);
+
+	local_irq_save(flags);
+
+	if (sev_cfg.ghcbs_initialized)
+		ghcb = __sev_get_ghcb(&state);
+	else
+		ghcb = boot_ghcb;
+
+	/* Invoke the hypervisor to perform the page state changes */
+	if (!ghcb || vmgexit_psc(ghcb, data))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
+
+	if (sev_cfg.ghcbs_initialized)
+		__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Page validation must be performed after changing to private */
+	if (op == SNP_PAGE_STATE_PRIVATE)
+		pvalidate_pages(data);
+
+	return vaddr;
+}
+
+static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
+{
+	struct snp_psc_desc desc;
+	unsigned long vaddr_end;
+
+	/* Use the MSR protocol when a GHCB is not available. */
+	if (!boot_ghcb)
+		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
+
+	vaddr = vaddr & PAGE_MASK;
+	vaddr_end = vaddr + (npages << PAGE_SHIFT);
+
+	while (vaddr < vaddr_end)
+		vaddr = __set_pages_state(&desc, vaddr, vaddr_end, op);
+}
+
+void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
+}
+
+void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+}
+
+void snp_accept_memory(phys_addr_t start, phys_addr_t end)
+{
+	unsigned long vaddr, npages;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	vaddr = (unsigned long)__va(start);
+	npages = (end - start) >> PAGE_SHIFT;
+
+	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
+}
+
+static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
+{
+	int ret;
+
+	if (snp_vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
+
+		local_irq_save(flags);
+
+		call.caa = this_cpu_read(svsm_caa);
+		call.rcx = __pa(va);
+
+		if (make_vmsa) {
+			/* Protocol 0, Call ID 2 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
+			call.rdx = __pa(caa);
+			call.r8  = apic_id;
+		} else {
+			/* Protocol 0, Call ID 3 */
+			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
+		}
+
+		ret = svsm_perform_call_protocol(&call);
+
+		local_irq_restore(flags);
+	} else {
+		/*
+		 * If the kernel runs at VMPL0, it can change the VMSA
+		 * bit for a page using the RMPADJUST instruction.
+		 * However, for the instruction to succeed it must
+		 * target the permissions of a lesser privileged (higher
+		 * numbered) VMPL level, so use VMPL1.
+		 */
+		u64 attrs = 1;
+
+		if (make_vmsa)
+			attrs |= RMPADJUST_VMSA_PAGE_BIT;
+
+		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
+	}
+
+	return ret;
+}
+
+#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
+#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
+#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
+
+#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
+#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
+
+static void *snp_alloc_vmsa_page(int cpu)
+{
+	struct page *p;
+
+	/*
+	 * Allocate VMSA page to work around the SNP erratum where the CPU will
+	 * incorrectly signal an RMP violation #PF if a large page (2MB or 1GB)
+	 * collides with the RMP entry of VMSA page. The recommended workaround
+	 * is to not use a large page.
+	 *
+	 * Allocate an 8k page which is also 8k-aligned.
+	 */
+	p = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
+	if (!p)
+		return NULL;
+
+	split_page(p, 1);
+
+	/* Free the first 4k. This page may be 2M/1G aligned and cannot be used. */
+	__free_page(p);
+
+	return page_address(p + 1);
+}
+
+static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
+{
+	int err;
+
+	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
+	if (err)
+		pr_err("clear VMSA page failed (%u), leaking page\n", err);
+	else
+		free_page((unsigned long)vmsa);
+}
+
+static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
+{
+	struct sev_es_save_area *cur_vmsa, *vmsa;
+	struct ghcb_state state;
+	struct svsm_ca *caa;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	u8 sipi_vector;
+	int cpu, ret;
+	u64 cr4;
+
+	/*
+	 * The hypervisor SNP feature support check has happened earlier, just check
+	 * the AP_CREATION one here.
+	 */
+	if (!(sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION))
+		return -EOPNOTSUPP;
+
+	/*
+	 * Verify the desired start IP against the known trampoline start IP
+	 * to catch any future new trampolines that may be introduced that
+	 * would require a new protected guest entry point.
+	 */
+	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
+		      "Unsupported SNP start_ip: %lx\n", start_ip))
+		return -EINVAL;
+
+	/* Override start_ip with known protected guest start IP */
+	start_ip = real_mode_header->sev_es_trampoline_start;
+
+	/* Find the logical CPU for the APIC ID */
+	for_each_present_cpu(cpu) {
+		if (arch_match_cpu_phys_id(cpu, apic_id))
+			break;
+	}
+	if (cpu >= nr_cpu_ids)
+		return -EINVAL;
+
+	cur_vmsa = per_cpu(sev_vmsa, cpu);
+
+	/*
+	 * A new VMSA is created each time because there is no guarantee that
+	 * the current VMSA is the kernels or that the vCPU is not running. If
+	 * an attempt was done to use the current VMSA with a running vCPU, a
+	 * #VMEXIT of that vCPU would wipe out all of the settings being done
+	 * here.
+	 */
+	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page(cpu);
+	if (!vmsa)
+		return -ENOMEM;
+
+	/* If an SVSM is present, the SVSM per-CPU CAA will be !NULL */
+	caa = per_cpu(svsm_caa, cpu);
+
+	/* CR4 should maintain the MCE value */
+	cr4 = native_read_cr4() & X86_CR4_MCE;
+
+	/* Set the CS value based on the start_ip converted to a SIPI vector */
+	sipi_vector		= (start_ip >> 12);
+	vmsa->cs.base		= sipi_vector << 12;
+	vmsa->cs.limit		= AP_INIT_CS_LIMIT;
+	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
+	vmsa->cs.selector	= sipi_vector << 8;
+
+	/* Set the RIP value based on start_ip */
+	vmsa->rip		= start_ip & 0xfff;
+
+	/* Set AP INIT defaults as documented in the APM */
+	vmsa->ds.limit		= AP_INIT_DS_LIMIT;
+	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
+	vmsa->es		= vmsa->ds;
+	vmsa->fs		= vmsa->ds;
+	vmsa->gs		= vmsa->ds;
+	vmsa->ss		= vmsa->ds;
+
+	vmsa->gdtr.limit	= AP_INIT_GDTR_LIMIT;
+	vmsa->ldtr.limit	= AP_INIT_LDTR_LIMIT;
+	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
+	vmsa->idtr.limit	= AP_INIT_IDTR_LIMIT;
+	vmsa->tr.limit		= AP_INIT_TR_LIMIT;
+	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
+
+	vmsa->cr4		= cr4;
+	vmsa->cr0		= AP_INIT_CR0_DEFAULT;
+	vmsa->dr7		= DR7_RESET_VALUE;
+	vmsa->dr6		= AP_INIT_DR6_DEFAULT;
+	vmsa->rflags		= AP_INIT_RFLAGS_DEFAULT;
+	vmsa->g_pat		= AP_INIT_GPAT_DEFAULT;
+	vmsa->xcr0		= AP_INIT_XCR0_DEFAULT;
+	vmsa->mxcsr		= AP_INIT_MXCSR_DEFAULT;
+	vmsa->x87_ftw		= AP_INIT_X87_FTW_DEFAULT;
+	vmsa->x87_fcw		= AP_INIT_X87_FCW_DEFAULT;
+
+	/* SVME must be set. */
+	vmsa->efer		= EFER_SVME;
+
+	/*
+	 * Set the SNP-specific fields for this VMSA:
+	 *   VMPL level
+	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
+	 */
+	vmsa->vmpl		= snp_vmpl;
+	vmsa->sev_features	= sev_status >> 2;
+
+	/* Switch the page over to a VMSA page now that it is initialized */
+	ret = snp_set_vmsa(vmsa, caa, apic_id, true);
+	if (ret) {
+		pr_err("set VMSA page failed (%u)\n", ret);
+		free_page((unsigned long)vmsa);
+
+		return -EINVAL;
+	}
+
+	/* Issue VMGEXIT AP Creation NAE event */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_rax(ghcb, vmsa->sev_features);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
+	ghcb_set_sw_exit_info_1(ghcb,
+				((u64)apic_id << 32)	|
+				((u64)snp_vmpl << 16)	|
+				SVM_VMGEXIT_AP_CREATE);
+	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
+	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
+		pr_err("SNP AP Creation error\n");
+		ret = -EINVAL;
+	}
+
+	__sev_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	/* Perform cleanup if there was an error */
+	if (ret) {
+		snp_cleanup_vmsa(vmsa, apic_id);
+		vmsa = NULL;
+	}
+
+	/* Free up any previous VMSA page */
+	if (cur_vmsa)
+		snp_cleanup_vmsa(cur_vmsa, apic_id);
+
+	/* Record the current VMSA page */
+	per_cpu(sev_vmsa, cpu) = vmsa;
+
+	return ret;
+}
+
+void __init snp_set_wakeup_secondary_cpu(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return;
+
+	/*
+	 * Always set this override if SNP is enabled. This makes it the
+	 * required method to start APs under SNP. If the hypervisor does
+	 * not support AP creation, then no APs will be started.
+	 */
+	apic_update_callback(wakeup_secondary_cpu, wakeup_cpu_via_vmgexit);
+}
+
+int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
+{
+	u16 startup_cs, startup_ip;
+	phys_addr_t jump_table_pa;
+	u64 jump_table_addr;
+	u16 __iomem *jump_table;
+
+	jump_table_addr = get_jump_table_addr();
+
+	/* On UP guests there is no jump table so this is not a failure */
+	if (!jump_table_addr)
+		return 0;
+
+	/* Check if AP Jump Table is page-aligned */
+	if (jump_table_addr & ~PAGE_MASK)
+		return -EINVAL;
+
+	jump_table_pa = jump_table_addr & PAGE_MASK;
+
+	startup_cs = (u16)(rmh->trampoline_start >> 4);
+	startup_ip = (u16)(rmh->sev_es_trampoline_start -
+			   rmh->trampoline_start);
+
+	jump_table = ioremap_encrypted(jump_table_pa, PAGE_SIZE);
+	if (!jump_table)
+		return -EIO;
+
+	writew(startup_ip, &jump_table[0]);
+	writew(startup_cs, &jump_table[1]);
+
+	iounmap(jump_table);
+
+	return 0;
+}
+
+/*
+ * This is needed by the OVMF UEFI firmware which will use whatever it finds in
+ * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
+ * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
+ */
+int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
+{
+	struct sev_es_runtime_data *data;
+	unsigned long address, pflags;
+	int cpu;
+	u64 pfn;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return 0;
+
+	pflags = _PAGE_NX | _PAGE_RW;
+
+	for_each_possible_cpu(cpu) {
+		data = per_cpu(runtime_data, cpu);
+
+		address = __pa(&data->ghcb_page);
+		pfn = address >> PAGE_SHIFT;
+
+		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
+			return 1;
+	}
+
+	return 0;
+}
+
+static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	enum es_result ret;
+	u64 exit_info_1;
+
+	/* Is it a WRMSR? */
+	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
+
+	if (regs->cx == MSR_SVSM_CAA) {
+		/* Writes to the SVSM CAA msr are ignored */
+		if (exit_info_1)
+			return ES_OK;
+
+		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
+		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
+
+		return ES_OK;
+	}
+
+	ghcb_set_rcx(ghcb, regs->cx);
+	if (exit_info_1) {
+		ghcb_set_rax(ghcb, regs->ax);
+		ghcb_set_rdx(ghcb, regs->dx);
+	}
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
+
+	if ((ret == ES_OK) && (!exit_info_1)) {
+		regs->ax = ghcb->save.rax;
+		regs->dx = ghcb->save.rdx;
+	}
+
+	return ret;
+}
+
+static void snp_register_per_cpu_ghcb(void)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	snp_register_ghcb_early(__pa(ghcb));
+}
+
+void setup_ghcb(void)
+{
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return;
+
+	/*
+	 * Check whether the runtime #VC exception handler is active. It uses
+	 * the per-CPU GHCB page which is set up by sev_es_init_vc_handling().
+	 *
+	 * If SNP is active, register the per-CPU GHCB page so that the runtime
+	 * exception handler can use it.
+	 */
+	if (initial_vc_handler == (unsigned long)kernel_exc_vmm_communication) {
+		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+			snp_register_per_cpu_ghcb();
+
+		sev_cfg.ghcbs_initialized = true;
+
+		return;
+	}
+
+	/*
+	 * Make sure the hypervisor talks a supported protocol.
+	 * This gets called only in the BSP boot phase.
+	 */
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
+	/*
+	 * Clear the boot_ghcb. The first exception comes in before the bss
+	 * section is cleared.
+	 */
+	memset(&boot_ghcb_page, 0, PAGE_SIZE);
+
+	/* Alright - Make the boot-ghcb public */
+	boot_ghcb = &boot_ghcb_page;
+
+	/* SNP guest requires that GHCB GPA must be registered. */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		snp_register_ghcb_early(__pa(&boot_ghcb_page));
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void sev_es_ap_hlt_loop(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = __sev_get_ghcb(&state);
+
+	while (true) {
+		vc_ghcb_invalidate(ghcb);
+		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_HLT_LOOP);
+		ghcb_set_sw_exit_info_1(ghcb, 0);
+		ghcb_set_sw_exit_info_2(ghcb, 0);
+
+		sev_es_wr_ghcb_msr(__pa(ghcb));
+		VMGEXIT();
+
+		/* Wakeup signal? */
+		if (ghcb_sw_exit_info_2_is_valid(ghcb) &&
+		    ghcb->save.sw_exit_info_2)
+			break;
+	}
+
+	__sev_put_ghcb(&state);
+}
+
+/*
+ * Play_dead handler when running under SEV-ES. This is needed because
+ * the hypervisor can't deliver an SIPI request to restart the AP.
+ * Instead the kernel has to issue a VMGEXIT to halt the VCPU until the
+ * hypervisor wakes it up again.
+ */
+static void sev_es_play_dead(void)
+{
+	play_dead_common();
+
+	/* IRQs now disabled */
+
+	sev_es_ap_hlt_loop();
+
+	/*
+	 * If we get here, the VCPU was woken up again. Jump to CPU
+	 * startup code to get it back online.
+	 */
+	soft_restart_cpu();
+}
+#else  /* CONFIG_HOTPLUG_CPU */
+#define sev_es_play_dead	native_play_dead
+#endif /* CONFIG_HOTPLUG_CPU */
+
+#ifdef CONFIG_SMP
+static void __init sev_es_setup_play_dead(void)
+{
+	smp_ops.play_dead = sev_es_play_dead;
+}
+#else
+static inline void sev_es_setup_play_dead(void) { }
+#endif
+
+static void __init alloc_runtime_data(int cpu)
+{
+	struct sev_es_runtime_data *data;
+
+	data = memblock_alloc_node(sizeof(*data), PAGE_SIZE, cpu_to_node(cpu));
+	if (!data)
+		panic("Can't allocate SEV-ES runtime data");
+
+	per_cpu(runtime_data, cpu) = data;
+
+	if (snp_vmpl) {
+		struct svsm_ca *caa;
+
+		/* Allocate the SVSM CA page if an SVSM is present */
+		caa = memblock_alloc(sizeof(*caa), PAGE_SIZE);
+		if (!caa)
+			panic("Can't allocate SVSM CA page\n");
+
+		per_cpu(svsm_caa, cpu) = caa;
+		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
+	}
+}
+
+static void __init init_ghcb(int cpu)
+{
+	struct sev_es_runtime_data *data;
+	int err;
+
+	data = per_cpu(runtime_data, cpu);
+
+	err = early_set_memory_decrypted((unsigned long)&data->ghcb_page,
+					 sizeof(data->ghcb_page));
+	if (err)
+		panic("Can't map GHCBs unencrypted");
+
+	memset(&data->ghcb_page, 0, sizeof(data->ghcb_page));
+
+	data->ghcb_active = false;
+	data->backup_ghcb_active = false;
+}
+
+void __init sev_es_init_vc_handling(void)
+{
+	int cpu;
+
+	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
+
+	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
+		return;
+
+	if (!sev_es_check_cpu_features())
+		panic("SEV-ES CPU Features missing");
+
+	/*
+	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
+	 * features.
+	 */
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
+		sev_hv_features = get_hv_features();
+
+		if (!(sev_hv_features & GHCB_HV_FT_SNP))
+			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+	}
+
+	/* Initialize per-cpu GHCB pages */
+	for_each_possible_cpu(cpu) {
+		alloc_runtime_data(cpu);
+		init_ghcb(cpu);
+	}
+
+	/* If running under an SVSM, switch to the per-cpu CA */
+	if (snp_vmpl) {
+		struct svsm_call call = {};
+		unsigned long flags;
+		int ret;
+
+		local_irq_save(flags);
+
+		/*
+		 * SVSM_CORE_REMAP_CA call:
+		 *   RAX = 0 (Protocol=0, CallID=0)
+		 *   RCX = New CA GPA
+		 */
+		call.caa = svsm_get_caa();
+		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+		call.rcx = this_cpu_read(svsm_caa_pa);
+		ret = svsm_perform_call_protocol(&call);
+		if (ret)
+			panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n",
+			      ret, call.rax_out);
+
+		sev_cfg.use_cas = true;
+
+		local_irq_restore(flags);
+	}
+
+	sev_es_setup_play_dead();
+
+	/* Secondary CPUs use the runtime #VC handler */
+	initial_vc_handler = (unsigned long)kernel_exc_vmm_communication;
+}
+
+static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
+{
+	int trapnr = ctxt->fi.vector;
+
+	if (trapnr == X86_TRAP_PF)
+		native_write_cr2(ctxt->fi.cr2);
+
+	ctxt->regs->orig_ax = ctxt->fi.error_code;
+	do_early_exception(ctxt->regs, trapnr);
+}
+
+static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
+{
+	long *reg_array;
+	int offset;
+
+	reg_array = (long *)ctxt->regs;
+	offset    = insn_get_modrm_rm_off(&ctxt->insn, ctxt->regs);
+
+	if (offset < 0)
+		return NULL;
+
+	offset /= sizeof(long);
+
+	return reg_array + offset;
+}
+static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 unsigned int bytes, bool read)
+{
+	u64 exit_code, exit_info_1, exit_info_2;
+	unsigned long ghcb_pa = __pa(ghcb);
+	enum es_result res;
+	phys_addr_t paddr;
+	void __user *ref;
+
+	ref = insn_get_addr_ref(&ctxt->insn, ctxt->regs);
+	if (ref == (void __user *)-1L)
+		return ES_UNSUPPORTED;
+
+	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
+
+	res = vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr);
+	if (res != ES_OK) {
+		if (res == ES_EXCEPTION && !read)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return res;
+	}
+
+	exit_info_1 = paddr;
+	/* Can never be greater than 8 */
+	exit_info_2 = bytes;
+
+	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
+
+	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
+}
+
+/*
+ * The MOVS instruction has two memory operands, which raises the
+ * problem that it is not known whether the access to the source or the
+ * destination caused the #VC exception (and hence whether an MMIO read
+ * or write operation needs to be emulated).
+ *
+ * Instead of playing games with walking page-tables and trying to guess
+ * whether the source or destination is an MMIO range, split the move
+ * into two operations, a read and a write with only one memory operand.
+ * This will cause a nested #VC exception on the MMIO address which can
+ * then be handled.
+ *
+ * This implementation has the benefit that it also supports MOVS where
+ * source _and_ destination are MMIO regions.
+ *
+ * It will slow MOVS on MMIO down a lot, but in SEV-ES guests it is a
+ * rare operation. If it turns out to be a performance problem the split
+ * operations can be moved to memcpy_fromio() and memcpy_toio().
+ */
+static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
+					  unsigned int bytes)
+{
+	unsigned long ds_base, es_base;
+	unsigned char *src, *dst;
+	unsigned char buffer[8];
+	enum es_result ret;
+	bool rep;
+	int off;
+
+	ds_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_DS);
+	es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
+
+	if (ds_base == -1L || es_base == -1L) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
+
+	src = ds_base + (unsigned char *)ctxt->regs->si;
+	dst = es_base + (unsigned char *)ctxt->regs->di;
+
+	ret = vc_read_mem(ctxt, src, buffer, bytes);
+	if (ret != ES_OK)
+		return ret;
+
+	ret = vc_write_mem(ctxt, dst, buffer, bytes);
+	if (ret != ES_OK)
+		return ret;
+
+	if (ctxt->regs->flags & X86_EFLAGS_DF)
+		off = -bytes;
+	else
+		off =  bytes;
+
+	ctxt->regs->si += off;
+	ctxt->regs->di += off;
+
+	rep = insn_has_rep_prefix(&ctxt->insn);
+	if (rep)
+		ctxt->regs->cx -= 1;
+
+	if (!rep || ctxt->regs->cx == 0)
+		return ES_OK;
+	else
+		return ES_RETRY;
+}
+
+static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct insn *insn = &ctxt->insn;
+	enum insn_mmio_type mmio;
+	unsigned int bytes = 0;
+	enum es_result ret;
+	u8 sign_byte;
+	long *reg_data;
+
+	mmio = insn_decode_mmio(insn, &bytes);
+	if (mmio == INSN_MMIO_DECODE_FAILED)
+		return ES_DECODE_FAILED;
+
+	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
+		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+	}
+
+	if (user_mode(ctxt->regs))
+		return ES_UNSUPPORTED;
+
+	switch (mmio) {
+	case INSN_MMIO_WRITE:
+		memcpy(ghcb->shared_buffer, reg_data, bytes);
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+	case INSN_MMIO_WRITE_IMM:
+		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+	case INSN_MMIO_READ:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Zero-extend for 32-bit operation */
+		if (bytes == 4)
+			*reg_data = 0;
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_ZERO_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Zero extend based on operand size */
+		memset(reg_data, 0, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_READ_SIGN_EXTEND:
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		if (bytes == 1) {
+			u8 *val = (u8 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x80) ? 0xff : 0x00;
+		} else {
+			u16 *val = (u16 *)ghcb->shared_buffer;
+
+			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
+		}
+
+		/* Sign extend based on operand size */
+		memset(reg_data, sign_byte, insn->opnd_bytes);
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+	case INSN_MMIO_MOVS:
+		ret = vc_handle_mmio_movs(ctxt, bytes);
+		break;
+	default:
+		ret = ES_UNSUPPORTED;
+		break;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long val, *reg = vc_insn_get_rm(ctxt);
+	enum es_result ret;
+
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	val = *reg;
+
+	/* Upper 32 bits must be written as zeroes */
+	if (val >> 32) {
+		ctxt->fi.vector = X86_TRAP_GP;
+		ctxt->fi.error_code = 0;
+		return ES_EXCEPTION;
+	}
+
+	/* Clear out other reserved bits and set bit 10 */
+	val = (val & 0xffff23ffL) | BIT(10);
+
+	/* Early non-zero writes to DR7 are not supported */
+	if (!data && (val & ~DR7_RESET_VALUE))
+		return ES_UNSUPPORTED;
+
+	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
+	ghcb_set_rax(ghcb, val);
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (data)
+		data->dr7 = val;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
+					 struct es_em_ctxt *ctxt)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	long *reg = vc_insn_get_rm(ctxt);
+
+	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
+		return ES_VMM_ERROR;
+
+	if (!reg)
+		return ES_DECODE_FAILED;
+
+	if (data)
+		*reg = data->dr7;
+	else
+		*reg = DR7_RESET_VALUE;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
+				       struct es_em_ctxt *ctxt)
+{
+	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
+}
+
+static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	enum es_result ret;
+
+	ghcb_set_rcx(ghcb, ctxt->regs->cx);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+	ctxt->regs->dx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_monitor(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	/*
+	 * Treat it as a NOP and do not leak a physical address to the
+	 * hypervisor.
+	 */
+	return ES_OK;
+}
+
+static enum es_result vc_handle_mwait(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	/* Treat the same as MONITOR/MONITORX */
+	return ES_OK;
+}
+
+static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	enum es_result ret;
+
+	ghcb_set_rax(ghcb, ctxt->regs->ax);
+	ghcb_set_cpl(ghcb, user_mode(ctxt->regs) ? 3 : 0);
+
+	if (x86_platform.hyper.sev_es_hcall_prepare)
+		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!ghcb_rax_is_valid(ghcb))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+
+	/*
+	 * Call sev_es_hcall_finish() after regs->ax is already set.
+	 * This allows the hypervisor handler to overwrite it again if
+	 * necessary.
+	 */
+	if (x86_platform.hyper.sev_es_hcall_finish &&
+	    !x86_platform.hyper.sev_es_hcall_finish(ghcb, ctxt->regs))
+		return ES_VMM_ERROR;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_trap_ac(struct ghcb *ghcb,
+					struct es_em_ctxt *ctxt)
+{
+	/*
+	 * Calling ecx_alignment_check() directly does not work, because it
+	 * enables IRQs and the GHCB is active. Forward the exception and call
+	 * it later from vc_forward_exception().
+	 */
+	ctxt->fi.vector = X86_TRAP_AC;
+	ctxt->fi.error_code = 0;
+	return ES_EXCEPTION;
+}
+
+static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
+					 struct ghcb *ghcb,
+					 unsigned long exit_code)
+{
+	enum es_result result = vc_check_opcode_bytes(ctxt, exit_code);
+
+	if (result != ES_OK)
+		return result;
+
+	switch (exit_code) {
+	case SVM_EXIT_READ_DR7:
+		result = vc_handle_dr7_read(ghcb, ctxt);
+		break;
+	case SVM_EXIT_WRITE_DR7:
+		result = vc_handle_dr7_write(ghcb, ctxt);
+		break;
+	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
+		result = vc_handle_trap_ac(ghcb, ctxt);
+		break;
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+		result = vc_handle_rdtsc(ghcb, ctxt, exit_code);
+		break;
+	case SVM_EXIT_RDPMC:
+		result = vc_handle_rdpmc(ghcb, ctxt);
+		break;
+	case SVM_EXIT_INVD:
+		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
+		result = ES_UNSUPPORTED;
+		break;
+	case SVM_EXIT_CPUID:
+		result = vc_handle_cpuid(ghcb, ctxt);
+		break;
+	case SVM_EXIT_IOIO:
+		result = vc_handle_ioio(ghcb, ctxt);
+		break;
+	case SVM_EXIT_MSR:
+		result = vc_handle_msr(ghcb, ctxt);
+		break;
+	case SVM_EXIT_VMMCALL:
+		result = vc_handle_vmmcall(ghcb, ctxt);
+		break;
+	case SVM_EXIT_WBINVD:
+		result = vc_handle_wbinvd(ghcb, ctxt);
+		break;
+	case SVM_EXIT_MONITOR:
+		result = vc_handle_monitor(ghcb, ctxt);
+		break;
+	case SVM_EXIT_MWAIT:
+		result = vc_handle_mwait(ghcb, ctxt);
+		break;
+	case SVM_EXIT_NPF:
+		result = vc_handle_mmio(ghcb, ctxt);
+		break;
+	default:
+		/*
+		 * Unexpected #VC exception
+		 */
+		result = ES_UNSUPPORTED;
+	}
+
+	return result;
+}
+
+static __always_inline bool is_vc2_stack(unsigned long sp)
+{
+	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
+}
+
+static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
+{
+	unsigned long sp, prev_sp;
+
+	sp      = (unsigned long)regs;
+	prev_sp = regs->sp;
+
+	/*
+	 * If the code was already executing on the VC2 stack when the #VC
+	 * happened, let it proceed to the normal handling routine. This way the
+	 * code executing on the VC2 stack can cause #VC exceptions to get handled.
+	 */
+	return is_vc2_stack(sp) && !is_vc2_stack(prev_sp);
+}
+
+static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_code)
+{
+	struct ghcb_state state;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+	struct ghcb *ghcb;
+	bool ret = true;
+
+	ghcb = __sev_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	result = vc_init_em_ctxt(&ctxt, regs, error_code);
+
+	if (result == ES_OK)
+		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
+
+	__sev_put_ghcb(&state);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		vc_finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		pr_err_ratelimited("Unsupported exit-code 0x%02lx in #VC exception (IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		ret = false;
+		break;
+	case ES_VMM_ERROR:
+		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		ret = false;
+		break;
+	case ES_DECODE_FAILED:
+		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		ret = false;
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		break;
+	case ES_RETRY:
+		/* Nothing to do */
+		break;
+	default:
+		pr_emerg("Unknown result in %s():%d\n", __func__, result);
+		/*
+		 * Emulating the instruction which caused the #VC exception
+		 * failed - can't continue so print debug information
+		 */
+		BUG();
+	}
+
+	return ret;
+}
+
+static __always_inline bool vc_is_db(unsigned long error_code)
+{
+	return error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB;
+}
+
+/*
+ * Runtime #VC exception handler when raised from kernel mode. Runs in NMI mode
+ * and will panic when an error happens.
+ */
+DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
+{
+	irqentry_state_t irq_state;
+
+	/*
+	 * With the current implementation it is always possible to switch to a
+	 * safe stack because #VC exceptions only happen at known places, like
+	 * intercepted instructions or accesses to MMIO areas/IO ports. They can
+	 * also happen with code instrumentation when the hypervisor intercepts
+	 * #DB, but the critical paths are forbidden to be instrumented, so #DB
+	 * exceptions currently also only happen in safe places.
+	 *
+	 * But keep this here in case the noinstr annotations are violated due
+	 * to bug elsewhere.
+	 */
+	if (unlikely(vc_from_invalid_context(regs))) {
+		instrumentation_begin();
+		panic("Can't handle #VC exception from unsupported context\n");
+		instrumentation_end();
+	}
+
+	/*
+	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
+	 */
+	if (vc_is_db(error_code)) {
+		exc_debug(regs);
+		return;
+	}
+
+	irq_state = irqentry_nmi_enter(regs);
+
+	instrumentation_begin();
+
+	if (!vc_raw_handle_exception(regs, error_code)) {
+		/* Show some debug info */
+		show_regs(regs);
+
+		/* Ask hypervisor to sev_es_terminate */
+		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+
+		/* If that fails and we get here - just panic */
+		panic("Returned from Terminate-Request to Hypervisor\n");
+	}
+
+	instrumentation_end();
+	irqentry_nmi_exit(regs, irq_state);
+}
+
+/*
+ * Runtime #VC exception handler when raised from user mode. Runs in IRQ mode
+ * and will kill the current task with SIGBUS when an error happens.
+ */
+DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
+{
+	/*
+	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
+	 */
+	if (vc_is_db(error_code)) {
+		noist_exc_debug(regs);
+		return;
+	}
+
+	irqentry_enter_from_user_mode(regs);
+	instrumentation_begin();
+
+	if (!vc_raw_handle_exception(regs, error_code)) {
+		/*
+		 * Do not kill the machine if user-space triggered the
+		 * exception. Send SIGBUS instead and let user-space deal with
+		 * it.
+		 */
+		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
+	}
+
+	instrumentation_end();
+	irqentry_exit_to_user_mode(regs);
+}
+
+bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
+{
+	unsigned long exit_code = regs->orig_ax;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	vc_ghcb_invalidate(boot_ghcb);
+
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	if (result == ES_OK)
+		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		vc_finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		early_printk("PANIC: Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_VMM_ERROR:
+		early_printk("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_DECODE_FAILED:
+		early_printk("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				exit_code, regs->ip);
+		goto fail;
+	case ES_EXCEPTION:
+		vc_early_forward_exception(&ctxt);
+		break;
+	case ES_RETRY:
+		/* Nothing to do */
+		break;
+	default:
+		BUG();
+	}
+
+	return true;
+
+fail:
+	show_regs(regs);
+
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+}
+
+/*
+ * Initial set up of SNP relies on information provided by the
+ * Confidential Computing blob, which can be passed to the kernel
+ * in the following ways, depending on how it is booted:
+ *
+ * - when booted via the boot/decompress kernel:
+ *   - via boot_params
+ *
+ * - when booted directly by firmware/bootloader (e.g. CONFIG_PVH):
+ *   - via a setup_data entry, as defined by the Linux Boot Protocol
+ *
+ * Scan for the blob in that order.
+ */
+static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	/* Boot kernel would have passed the CC blob via boot_params. */
+	if (bp->cc_blob_address) {
+		cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
+		goto found_cc_info;
+	}
+
+	/*
+	 * If kernel was booted directly, without the use of the
+	 * boot/decompression kernel, the CC blob may have been passed via
+	 * setup_data instead.
+	 */
+	cc_info = find_cc_blob_setup_data(bp);
+	if (!cc_info)
+		return NULL;
+
+found_cc_info:
+	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
+		snp_abort();
+
+	return cc_info;
+}
+
+static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
+{
+	struct svsm_call call = {};
+	int ret;
+	u64 pa;
+
+	/*
+	 * Record the SVSM Calling Area address (CAA) if the guest is not
+	 * running at VMPL0. The CA will be used to communicate with the
+	 * SVSM to perform the SVSM services.
+	 */
+	if (!svsm_setup_ca(cc_info))
+		return;
+
+	/*
+	 * It is very early in the boot and the kernel is running identity
+	 * mapped but without having adjusted the pagetables to where the
+	 * kernel was loaded (physbase), so the get the CA address using
+	 * RIP-relative addressing.
+	 */
+	pa = (u64)&RIP_REL_REF(boot_svsm_ca_page);
+
+	/*
+	 * Switch over to the boot SVSM CA while the current CA is still
+	 * addressable. There is no GHCB at this point so use the MSR protocol.
+	 *
+	 * SVSM_CORE_REMAP_CA call:
+	 *   RAX = 0 (Protocol=0, CallID=0)
+	 *   RCX = New CA GPA
+	 */
+	call.caa = svsm_get_caa();
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
+	call.rcx = pa;
+	ret = svsm_perform_call_protocol(&call);
+	if (ret)
+		panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n", ret, call.rax_out);
+
+	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
+	RIP_REL_REF(boot_svsm_caa_pa) = pa;
+}
+
+bool __head snp_init(struct boot_params *bp)
+{
+	struct cc_blob_sev_info *cc_info;
+
+	if (!bp)
+		return false;
+
+	cc_info = find_cc_blob(bp);
+	if (!cc_info)
+		return false;
+
+	setup_cpuid_table(cc_info);
+
+	svsm_setup(cc_info);
+
+	/*
+	 * The CC blob will be used later to access the secrets page. Cache
+	 * it here like the boot kernel does.
+	 */
+	bp->cc_blob_address = (u32)(unsigned long)cc_info;
+
+	return true;
+}
+
+void __head __noreturn snp_abort(void)
+{
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
+}
+
+/*
+ * SEV-SNP guests should only execute dmi_setup() if EFI_CONFIG_TABLES are
+ * enabled, as the alternative (fallback) logic for DMI probing in the legacy
+ * ROM region can cause a crash since this region is not pre-validated.
+ */
+void __init snp_dmi_setup(void)
+{
+	if (efi_enabled(EFI_CONFIG_TABLES))
+		dmi_setup();
+}
+
+static void dump_cpuid_table(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	int i = 0;
+
+	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
+		cpuid_table->count, cpuid_table->__reserved1, cpuid_table->__reserved2);
+
+	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		pr_info("index=%3d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
+			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
+			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
+	}
+}
+
+/*
+ * It is useful from an auditing/testing perspective to provide an easy way
+ * for the guest owner to know that the CPUID table has been initialized as
+ * expected, but that initialization happens too early in boot to print any
+ * sort of indicator, and there's not really any other good place to do it,
+ * so do it here.
+ *
+ * If running as an SNP guest, report the current VM privilege level (VMPL).
+ */
+static int __init report_snp_info(void)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+
+	if (cpuid_table->count) {
+		pr_info("Using SNP CPUID table, %d entries present.\n",
+			cpuid_table->count);
+
+		if (sev_cfg.debug)
+			dump_cpuid_table();
+	}
+
+	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		pr_info("SNP running at VMPL%u.\n", snp_vmpl);
+
+	return 0;
+}
+arch_initcall(report_snp_info);
+
+static int __init init_sev_config(char *str)
+{
+	char *s;
+
+	while ((s = strsep(&str, ","))) {
+		if (!strcmp(s, "debug")) {
+			sev_cfg.debug = true;
+			continue;
+		}
+
+		pr_info("SEV command-line option '%s' was not recognized\n", s);
+	}
+
+	return 1;
+}
+__setup("sev=", init_sev_config);
+
+static void update_attest_input(struct svsm_call *call, struct svsm_attest_call *input)
+{
+	/* If (new) lengths have been returned, propagate them up */
+	if (call->rcx_out != call->rcx)
+		input->manifest_buf.len = call->rcx_out;
+
+	if (call->rdx_out != call->rdx)
+		input->certificates_buf.len = call->rdx_out;
+
+	if (call->r8_out != call->r8)
+		input->report_buf.len = call->r8_out;
+}
+
+int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
+			      struct svsm_attest_call *input)
+{
+	struct svsm_attest_call *ac;
+	unsigned long flags;
+	u64 attest_call_pa;
+	int ret;
+
+	if (!snp_vmpl)
+		return -EINVAL;
+
+	local_irq_save(flags);
+
+	call->caa = svsm_get_caa();
+
+	ac = (struct svsm_attest_call *)call->caa->svsm_buffer;
+	attest_call_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	*ac = *input;
+
+	/*
+	 * Set input registers for the request and set RDX and R8 to known
+	 * values in order to detect length values being returned in them.
+	 */
+	call->rax = call_id;
+	call->rcx = attest_call_pa;
+	call->rdx = -1;
+	call->r8 = -1;
+	ret = svsm_perform_call_protocol(call);
+	update_attest_input(call, input);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
+
+int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
+{
+	struct ghcb_state state;
+	struct es_em_ctxt ctxt;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	int ret;
+
+	rio->exitinfo2 = SEV_RET_NO_FW_CALL;
+
+	/*
+	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
+	 * a per-CPU GHCB.
+	 */
+	local_irq_save(flags);
+
+	ghcb = __sev_get_ghcb(&state);
+	if (!ghcb) {
+		ret = -EIO;
+		goto e_restore_irq;
+	}
+
+	vc_ghcb_invalidate(ghcb);
+
+	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
+		ghcb_set_rax(ghcb, input->data_gpa);
+		ghcb_set_rbx(ghcb, input->data_npages);
+	}
+
+	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
+	if (ret)
+		goto e_put;
+
+	rio->exitinfo2 = ghcb->save.sw_exit_info_2;
+	switch (rio->exitinfo2) {
+	case 0:
+		break;
+
+	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_BUSY):
+		ret = -EAGAIN;
+		break;
+
+	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
+		/* Number of expected pages are returned in RBX */
+		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
+			input->data_npages = ghcb_get_rbx(ghcb);
+			ret = -ENOSPC;
+			break;
+		}
+		fallthrough;
+	default:
+		ret = -EIO;
+		break;
+	}
+
+e_put:
+	__sev_put_ghcb(&state);
+e_restore_irq:
+	local_irq_restore(flags);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(snp_issue_guest_request);
+
+static struct platform_device sev_guest_device = {
+	.name		= "sev-guest",
+	.id		= -1,
+};
+
+static int __init snp_init_platform_device(void)
+{
+	struct sev_guest_platform_data data;
+	u64 gpa;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	gpa = get_secrets_page();
+	if (!gpa)
+		return -ENODEV;
+
+	data.secrets_gpa = gpa;
+	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
+		return -ENODEV;
+
+	if (platform_device_register(&sev_guest_device))
+		return -ENODEV;
+
+	pr_info("SNP guest platform device initialized.\n");
+	return 0;
+}
+device_initcall(snp_init_platform_device);
+
+void sev_show_status(void)
+{
+	int i;
+
+	pr_info("Status: ");
+	for (i = 0; i < MSR_AMD64_SNP_RESV_BIT; i++) {
+		if (sev_status & BIT_ULL(i)) {
+			if (!sev_status_feat_names[i])
+				continue;
+
+			pr_cont("%s ", sev_status_feat_names[i]);
+		}
+	}
+	pr_cont("\n");
+}
+
+void __init snp_update_svsm_ca(void)
+{
+	if (!snp_vmpl)
+		return;
+
+	/* Update the CAA to a proper kernel address */
+	boot_svsm_caa = &boot_svsm_ca_page;
+}
+
+#ifdef CONFIG_SYSFS
+static ssize_t vmpl_show(struct kobject *kobj,
+			 struct kobj_attribute *attr, char *buf)
+{
+	return sysfs_emit(buf, "%d\n", snp_vmpl);
+}
+
+static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
+
+static struct attribute *vmpl_attrs[] = {
+	&vmpl_attr.attr,
+	NULL
+};
+
+static struct attribute_group sev_attr_group = {
+	.attrs = vmpl_attrs,
+};
+
+static int __init sev_sysfs_init(void)
+{
+	struct kobject *sev_kobj;
+	struct device *dev_root;
+	int ret;
+
+	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
+		return -ENODEV;
+
+	dev_root = bus_get_dev_root(&cpu_subsys);
+	if (!dev_root)
+		return -ENODEV;
+
+	sev_kobj = kobject_create_and_add("sev", &dev_root->kobj);
+	put_device(dev_root);
+
+	if (!sev_kobj)
+		return -ENOMEM;
+
+	ret = sysfs_create_group(sev_kobj, &sev_attr_group);
+	if (ret)
+		kobject_put(sev_kobj);
+
+	return ret;
+}
+arch_initcall(sev_sysfs_init);
+#endif // CONFIG_SYSFS
diff --git a/arch/x86/coco/sev/shared.c b/arch/x86/coco/sev/shared.c
new file mode 100644
index 0000000..71de531
--- /dev/null
+++ b/arch/x86/coco/sev/shared.c
@@ -0,0 +1,1717 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Encrypted Register State Support
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ *
+ * This file is not compiled stand-alone. It contains code shared
+ * between the pre-decompression boot code and the running Linux kernel
+ * and is included directly into both code-bases.
+ */
+
+#include <asm/setup_data.h>
+
+#ifndef __BOOT_COMPRESSED
+#define error(v)			pr_err(v)
+#define has_cpuflag(f)			boot_cpu_has(f)
+#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
+#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
+#else
+#undef WARN
+#define WARN(condition, format...) (!!(condition))
+#define sev_printk(fmt, ...)
+#define sev_printk_rtl(fmt, ...)
+#undef vc_forward_exception
+#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
+#endif
+
+/*
+ * SVSM related information:
+ *   When running under an SVSM, the VMPL that Linux is executing at must be
+ *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
+ *
+ *   During boot, the page tables are set up as identity mapped and later
+ *   changed to use kernel virtual addresses. Maintain separate virtual and
+ *   physical addresses for the CAA to allow SVSM functions to be used during
+ *   early boot, both with identity mapped virtual addresses and proper kernel
+ *   virtual addresses.
+ */
+u8 snp_vmpl __ro_after_init;
+EXPORT_SYMBOL_GPL(snp_vmpl);
+static struct svsm_ca *boot_svsm_caa __ro_after_init;
+static u64 boot_svsm_caa_pa __ro_after_init;
+
+static struct svsm_ca *svsm_get_caa(void);
+static u64 svsm_get_caa_pa(void);
+static int svsm_perform_call_protocol(struct svsm_call *call);
+
+/* I/O parameters for CPUID-related helpers */
+struct cpuid_leaf {
+	u32 fn;
+	u32 subfn;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+};
+
+/*
+ * Individual entries of the SNP CPUID table, as defined by the SNP
+ * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
+ */
+struct snp_cpuid_fn {
+	u32 eax_in;
+	u32 ecx_in;
+	u64 xcr0_in;
+	u64 xss_in;
+	u32 eax;
+	u32 ebx;
+	u32 ecx;
+	u32 edx;
+	u64 __reserved;
+} __packed;
+
+/*
+ * SNP CPUID table, as defined by the SNP Firmware ABI, Revision 0.9,
+ * Section 8.14.2.6. Also noted there is the SNP firmware-enforced limit
+ * of 64 entries per CPUID table.
+ */
+#define SNP_CPUID_COUNT_MAX 64
+
+struct snp_cpuid_table {
+	u32 count;
+	u32 __reserved1;
+	u64 __reserved2;
+	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
+} __packed;
+
+/*
+ * Since feature negotiation related variables are set early in the boot
+ * process they must reside in the .data section so as not to be zeroed
+ * out when the .bss section is later cleared.
+ *
+ * GHCB protocol version negotiated with the hypervisor.
+ */
+static u16 ghcb_version __ro_after_init;
+
+/* Copy of the SNP firmware's CPUID page. */
+static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
+
+/*
+ * These will be initialized based on CPUID table so that non-present
+ * all-zero leaves (for sparse tables) can be differentiated from
+ * invalid/out-of-range leaves. This is needed since all-zero leaves
+ * still need to be post-processed.
+ */
+static u32 cpuid_std_range_max __ro_after_init;
+static u32 cpuid_hyp_range_max __ro_after_init;
+static u32 cpuid_ext_range_max __ro_after_init;
+
+static bool __init sev_es_check_cpu_features(void)
+{
+	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
+		error("RDRAND instruction not supported - no trusted source of randomness available\n");
+		return false;
+	}
+
+	return true;
+}
+
+static void __head __noreturn
+sev_es_terminate(unsigned int set, unsigned int reason)
+{
+	u64 val = GHCB_MSR_TERM_REQ;
+
+	/* Tell the hypervisor what went wrong. */
+	val |= GHCB_SEV_TERM_REASON(set, reason);
+
+	/* Request Guest Termination from Hypervisor */
+	sev_es_wr_ghcb_msr(val);
+	VMGEXIT();
+
+	while (true)
+		asm volatile("hlt\n" : : : "memory");
+}
+
+/*
+ * The hypervisor features are available from GHCB version 2 onward.
+ */
+static u64 get_hv_features(void)
+{
+	u64 val;
+
+	if (ghcb_version < 2)
+		return 0;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
+		return 0;
+
+	return GHCB_MSR_HV_FT_RESP_VAL(val);
+}
+
+static void snp_register_ghcb_early(unsigned long paddr)
+{
+	unsigned long pfn = paddr >> PAGE_SHIFT;
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
+	VMGEXIT();
+
+	val = sev_es_rd_ghcb_msr();
+
+	/* If the response GPA is not ours then abort the guest */
+	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
+	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
+}
+
+static bool sev_es_negotiate_protocol(void)
+{
+	u64 val;
+
+	/* Do the GHCB protocol version negotiation */
+	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+
+	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
+		return false;
+
+	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
+	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
+		return false;
+
+	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
+
+	return true;
+}
+
+static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
+{
+	ghcb->save.sw_exit_code = 0;
+	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
+}
+
+static bool vc_decoding_needed(unsigned long exit_code)
+{
+	/* Exceptions don't require to decode the instruction */
+	return !(exit_code >= SVM_EXIT_EXCP_BASE &&
+		 exit_code <= SVM_EXIT_LAST_EXCP);
+}
+
+static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
+				      struct pt_regs *regs,
+				      unsigned long exit_code)
+{
+	enum es_result ret = ES_OK;
+
+	memset(ctxt, 0, sizeof(*ctxt));
+	ctxt->regs = regs;
+
+	if (vc_decoding_needed(exit_code))
+		ret = vc_decode_insn(ctxt);
+
+	return ret;
+}
+
+static void vc_finish_insn(struct es_em_ctxt *ctxt)
+{
+	ctxt->regs->ip += ctxt->insn.length;
+}
+
+static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	u32 ret;
+
+	ret = ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0);
+	if (!ret)
+		return ES_OK;
+
+	if (ret == 1) {
+		u64 info = ghcb->save.sw_exit_info_2;
+		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
+
+		/* Check if exception information from hypervisor is sane. */
+		if ((info & SVM_EVTINJ_VALID) &&
+		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
+		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
+			ctxt->fi.vector = v;
+
+			if (info & SVM_EVTINJ_VALID_ERR)
+				ctxt->fi.error_code = info >> 32;
+
+			return ES_EXCEPTION;
+		}
+	}
+
+	return ES_VMM_ERROR;
+}
+
+static inline int svsm_process_result_codes(struct svsm_call *call)
+{
+	switch (call->rax_out) {
+	case SVSM_SUCCESS:
+		return 0;
+	case SVSM_ERR_INCOMPLETE:
+	case SVSM_ERR_BUSY:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+/*
+ * Issue a VMGEXIT to call the SVSM:
+ *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
+ *   - Set the CA call pending field to 1
+ *   - Issue VMGEXIT
+ *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
+ *   - Perform atomic exchange of the CA call pending field
+ *
+ *   - See the "Secure VM Service Module for SEV-SNP Guests" specification for
+ *     details on the calling convention.
+ *     - The calling convention loosely follows the Microsoft X64 calling
+ *       convention by putting arguments in RCX, RDX, R8 and R9.
+ *     - RAX specifies the SVSM protocol/callid as input and the return code
+ *       as output.
+ */
+static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pending)
+{
+	register unsigned long rax asm("rax") = call->rax;
+	register unsigned long rcx asm("rcx") = call->rcx;
+	register unsigned long rdx asm("rdx") = call->rdx;
+	register unsigned long r8  asm("r8")  = call->r8;
+	register unsigned long r9  asm("r9")  = call->r9;
+
+	call->caa->call_pending = 1;
+
+	asm volatile("rep; vmmcall\n\t"
+		     : "+r" (rax), "+r" (rcx), "+r" (rdx), "+r" (r8), "+r" (r9)
+		     : : "memory");
+
+	*pending = xchg(&call->caa->call_pending, *pending);
+
+	call->rax_out = rax;
+	call->rcx_out = rcx;
+	call->rdx_out = rdx;
+	call->r8_out  = r8;
+	call->r9_out  = r9;
+}
+
+static int svsm_perform_msr_protocol(struct svsm_call *call)
+{
+	u8 pending = 0;
+	u64 val, resp;
+
+	/*
+	 * When using the MSR protocol, be sure to save and restore
+	 * the current MSR value.
+	 */
+	val = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
+
+	svsm_issue_call(call, &pending);
+
+	resp = sev_es_rd_ghcb_msr();
+
+	sev_es_wr_ghcb_msr(val);
+
+	if (pending)
+		return -EINVAL;
+
+	if (GHCB_RESP_CODE(resp) != GHCB_MSR_VMPL_RESP)
+		return -EINVAL;
+
+	if (GHCB_MSR_VMPL_RESP_VAL(resp))
+		return -EINVAL;
+
+	return svsm_process_result_codes(call);
+}
+
+static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
+{
+	struct es_em_ctxt ctxt;
+	u8 pending = 0;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/*
+	 * Fill in protocol and format specifiers. This can be called very early
+	 * in the boot, so use rip-relative references as needed.
+	 */
+	ghcb->protocol_version = RIP_REL_REF(ghcb_version);
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+
+	svsm_issue_call(call, &pending);
+
+	if (pending)
+		return -EINVAL;
+
+	switch (verify_exception_info(ghcb, &ctxt)) {
+	case ES_OK:
+		break;
+	case ES_EXCEPTION:
+		vc_forward_exception(&ctxt);
+		fallthrough;
+	default:
+		return -EINVAL;
+	}
+
+	return svsm_process_result_codes(call);
+}
+
+static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt,
+					  u64 exit_code, u64 exit_info_1,
+					  u64 exit_info_2)
+{
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = ghcb_version;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	return verify_exception_info(ghcb, ctxt);
+}
+
+static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
+{
+	u64 val;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, reg_idx));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
+		return -EIO;
+
+	*reg = (val >> 32);
+
+	return 0;
+}
+
+static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
+{
+	int ret;
+
+	/*
+	 * MSR protocol does not support fetching non-zero subfunctions, but is
+	 * sufficient to handle current early-boot cases. Should that change,
+	 * make sure to report an error rather than ignoring the index and
+	 * grabbing random values. If this issue arises in the future, handling
+	 * can be added here to use GHCB-page protocol for cases that occur late
+	 * enough in boot that GHCB page is available.
+	 */
+	if (cpuid_function_is_indexed(leaf->fn) && leaf->subfn)
+		return -EINVAL;
+
+	ret =         __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EAX, &leaf->eax);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EBX, &leaf->ebx);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_ECX, &leaf->ecx);
+	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EDX, &leaf->edx);
+
+	return ret;
+}
+
+static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	u32 cr4 = native_read_cr4();
+	int ret;
+
+	ghcb_set_rax(ghcb, leaf->fn);
+	ghcb_set_rcx(ghcb, leaf->subfn);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #UD - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	leaf->eax = ghcb->save.rax;
+	leaf->ebx = ghcb->save.rbx;
+	leaf->ecx = ghcb->save.rcx;
+	leaf->edx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
+		    : __sev_cpuid_hv_msr(leaf);
+}
+
+/*
+ * This may be called early while still running on the initial identity
+ * mapping. Use RIP-relative addressing to obtain the correct address
+ * while running with the initial identity mapping as well as the
+ * switch-over to kernel virtual addresses later.
+ */
+static const struct snp_cpuid_table *snp_cpuid_get_table(void)
+{
+	return &RIP_REL_REF(cpuid_table_copy);
+}
+
+/*
+ * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
+ * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions 0
+ * and 1 based on the corresponding features enabled by a particular
+ * combination of XCR0 and XSS registers so that a guest can look up the
+ * version corresponding to the features currently enabled in its XCR0/XSS
+ * registers. The only values that differ between these versions/table
+ * entries is the enabled XSAVE area size advertised via EBX.
+ *
+ * While hypervisors may choose to make use of this support, it is more
+ * robust/secure for a guest to simply find the entry corresponding to the
+ * base/legacy XSAVE area size (XCR0=1 or XCR0=3), and then calculate the
+ * XSAVE area size using subfunctions 2 through 64, as documented in APM
+ * Volume 3, Rev 3.31, Appendix E.3.8, which is what is done here.
+ *
+ * Since base/legacy XSAVE area size is documented as 0x240, use that value
+ * directly rather than relying on the base size in the CPUID table.
+ *
+ * Return: XSAVE area size on success, 0 otherwise.
+ */
+static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	u64 xfeatures_found = 0;
+	u32 xsave_size = 0x240;
+	int i;
+
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
+
+		if (!(e->eax_in == 0xD && e->ecx_in > 1 && e->ecx_in < 64))
+			continue;
+		if (!(xfeatures_en & (BIT_ULL(e->ecx_in))))
+			continue;
+		if (xfeatures_found & (BIT_ULL(e->ecx_in)))
+			continue;
+
+		xfeatures_found |= (BIT_ULL(e->ecx_in));
+
+		if (compacted)
+			xsave_size += e->eax;
+		else
+			xsave_size = max(xsave_size, e->eax + e->ebx);
+	}
+
+	/*
+	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
+	 * entries in the CPUID table were not present. This is not a valid
+	 * state to be in.
+	 */
+	if (xfeatures_found != (xfeatures_en & GENMASK_ULL(63, 2)))
+		return 0;
+
+	return xsave_size;
+}
+
+static bool __head
+snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+	int i;
+
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
+
+		if (e->eax_in != leaf->fn)
+			continue;
+
+		if (cpuid_function_is_indexed(leaf->fn) && e->ecx_in != leaf->subfn)
+			continue;
+
+		/*
+		 * For 0xD subfunctions 0 and 1, only use the entry corresponding
+		 * to the base/legacy XSAVE area size (XCR0=1 or XCR0=3, XSS=0).
+		 * See the comments above snp_cpuid_calc_xsave_size() for more
+		 * details.
+		 */
+		if (e->eax_in == 0xD && (e->ecx_in == 0 || e->ecx_in == 1))
+			if (!(e->xcr0_in == 1 || e->xcr0_in == 3) || e->xss_in)
+				continue;
+
+		leaf->eax = e->eax;
+		leaf->ebx = e->ebx;
+		leaf->ecx = e->ecx;
+		leaf->edx = e->edx;
+
+		return true;
+	}
+
+	return false;
+}
+
+static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	if (sev_cpuid_hv(ghcb, ctxt, leaf))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
+}
+
+static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
+				 struct cpuid_leaf *leaf)
+{
+	struct cpuid_leaf leaf_hv = *leaf;
+
+	switch (leaf->fn) {
+	case 0x1:
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+
+		/* initial APIC ID */
+		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
+		/* APIC enabled bit */
+		leaf->edx = (leaf_hv.edx & BIT(9)) | (leaf->edx & ~BIT(9));
+
+		/* OSXSAVE enabled bit */
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			leaf->ecx |= BIT(27);
+		break;
+	case 0x7:
+		/* OSPKE enabled bit */
+		leaf->ecx &= ~BIT(4);
+		if (native_read_cr4() & X86_CR4_PKE)
+			leaf->ecx |= BIT(4);
+		break;
+	case 0xB:
+		leaf_hv.subfn = 0;
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+
+		/* extended APIC ID */
+		leaf->edx = leaf_hv.edx;
+		break;
+	case 0xD: {
+		bool compacted = false;
+		u64 xcr0 = 1, xss = 0;
+		u32 xsave_size;
+
+		if (leaf->subfn != 0 && leaf->subfn != 1)
+			return 0;
+
+		if (native_read_cr4() & X86_CR4_OSXSAVE)
+			xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
+		if (leaf->subfn == 1) {
+			/* Get XSS value if XSAVES is enabled. */
+			if (leaf->eax & BIT(3)) {
+				unsigned long lo, hi;
+
+				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
+						     : "c" (MSR_IA32_XSS));
+				xss = (hi << 32) | lo;
+			}
+
+			/*
+			 * The PPR and APM aren't clear on what size should be
+			 * encoded in 0xD:0x1:EBX when compaction is not enabled
+			 * by either XSAVEC (feature bit 1) or XSAVES (feature
+			 * bit 3) since SNP-capable hardware has these feature
+			 * bits fixed as 1. KVM sets it to 0 in this case, but
+			 * to avoid this becoming an issue it's safer to simply
+			 * treat this as unsupported for SNP guests.
+			 */
+			if (!(leaf->eax & (BIT(1) | BIT(3))))
+				return -EINVAL;
+
+			compacted = true;
+		}
+
+		xsave_size = snp_cpuid_calc_xsave_size(xcr0 | xss, compacted);
+		if (!xsave_size)
+			return -EINVAL;
+
+		leaf->ebx = xsave_size;
+		}
+		break;
+	case 0x8000001E:
+		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
+
+		/* extended APIC ID */
+		leaf->eax = leaf_hv.eax;
+		/* compute ID */
+		leaf->ebx = (leaf->ebx & GENMASK(31, 8)) | (leaf_hv.ebx & GENMASK(7, 0));
+		/* node ID */
+		leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_hv.ecx & GENMASK(7, 0));
+		break;
+	default:
+		/* No fix-ups needed, use values as-is. */
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
+ * should be treated as fatal by caller.
+ */
+static int __head
+snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
+{
+	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
+
+	if (!cpuid_table->count)
+		return -EOPNOTSUPP;
+
+	if (!snp_cpuid_get_validated_func(leaf)) {
+		/*
+		 * Some hypervisors will avoid keeping track of CPUID entries
+		 * where all values are zero, since they can be handled the
+		 * same as out-of-range values (all-zero). This is useful here
+		 * as well as it allows virtually all guest configurations to
+		 * work using a single SNP CPUID table.
+		 *
+		 * To allow for this, there is a need to distinguish between
+		 * out-of-range entries and in-range zero entries, since the
+		 * CPUID table entries are only a template that may need to be
+		 * augmented with additional values for things like
+		 * CPU-specific information during post-processing. So if it's
+		 * not in the table, set the values to zero. Then, if they are
+		 * within a valid CPUID range, proceed with post-processing
+		 * using zeros as the initial values. Otherwise, skip
+		 * post-processing and just return zeros immediately.
+		 */
+		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
+
+		/* Skip post-processing for out-of-range zero leafs. */
+		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
+		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
+		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
+			return 0;
+	}
+
+	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
+}
+
+/*
+ * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
+ * page yet, so it only supports the MSR based communication with the
+ * hypervisor and only the CPUID exit-code.
+ */
+void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+{
+	unsigned int subfn = lower_bits(regs->cx, 32);
+	unsigned int fn = lower_bits(regs->ax, 32);
+	u16 opcode = *(unsigned short *)regs->ip;
+	struct cpuid_leaf leaf;
+	int ret;
+
+	/* Only CPUID is supported via MSR protocol */
+	if (exit_code != SVM_EXIT_CPUID)
+		goto fail;
+
+	/* Is it really a CPUID insn? */
+	if (opcode != 0xa20f)
+		goto fail;
+
+	leaf.fn = fn;
+	leaf.subfn = subfn;
+
+	ret = snp_cpuid(NULL, NULL, &leaf);
+	if (!ret)
+		goto cpuid_done;
+
+	if (ret != -EOPNOTSUPP)
+		goto fail;
+
+	if (__sev_cpuid_hv_msr(&leaf))
+		goto fail;
+
+cpuid_done:
+	regs->ax = leaf.eax;
+	regs->bx = leaf.ebx;
+	regs->cx = leaf.ecx;
+	regs->dx = leaf.edx;
+
+	/*
+	 * This is a VC handler and the #VC is only raised when SEV-ES is
+	 * active, which means SEV must be active too. Do sanity checks on the
+	 * CPUID results to make sure the hypervisor does not trick the kernel
+	 * into the no-sev path. This could map sensitive data unencrypted and
+	 * make it accessible to the hypervisor.
+	 *
+	 * In particular, check for:
+	 *	- Availability of CPUID leaf 0x8000001f
+	 *	- SEV CPUID bit.
+	 *
+	 * The hypervisor might still report the wrong C-bit position, but this
+	 * can't be checked here.
+	 */
+
+	if (fn == 0x80000000 && (regs->ax < 0x8000001f))
+		/* SEV leaf check */
+		goto fail;
+	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
+		/* SEV bit */
+		goto fail;
+
+	/* Skip over the CPUID two-byte opcode */
+	regs->ip += 2;
+
+	return;
+
+fail:
+	/* Terminate the guest */
+	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
+}
+
+static enum es_result vc_insn_string_check(struct es_em_ctxt *ctxt,
+					   unsigned long address,
+					   bool write)
+{
+	if (user_mode(ctxt->regs) && fault_in_kernel_space(address)) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_USER;
+		ctxt->fi.cr2        = address;
+		if (write)
+			ctxt->fi.error_code |= X86_PF_WRITE;
+
+		return ES_EXCEPTION;
+	}
+
+	return ES_OK;
+}
+
+static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
+					  void *src, char *buf,
+					  unsigned int data_size,
+					  unsigned int count,
+					  bool backwards)
+{
+	int i, b = backwards ? -1 : 1;
+	unsigned long address = (unsigned long)src;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, false);
+	if (ret != ES_OK)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		void *s = src + (i * data_size * b);
+		char *d = buf + (i * data_size);
+
+		ret = vc_read_mem(ctxt, s, d, data_size);
+		if (ret != ES_OK)
+			break;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
+					   void *dst, char *buf,
+					   unsigned int data_size,
+					   unsigned int count,
+					   bool backwards)
+{
+	int i, s = backwards ? -1 : 1;
+	unsigned long address = (unsigned long)dst;
+	enum es_result ret;
+
+	ret = vc_insn_string_check(ctxt, address, true);
+	if (ret != ES_OK)
+		return ret;
+
+	for (i = 0; i < count; i++) {
+		void *d = dst + (i * data_size * s);
+		char *b = buf + (i * data_size);
+
+		ret = vc_write_mem(ctxt, d, b, data_size);
+		if (ret != ES_OK)
+			break;
+	}
+
+	return ret;
+}
+
+#define IOIO_TYPE_STR  BIT(2)
+#define IOIO_TYPE_IN   1
+#define IOIO_TYPE_INS  (IOIO_TYPE_IN | IOIO_TYPE_STR)
+#define IOIO_TYPE_OUT  0
+#define IOIO_TYPE_OUTS (IOIO_TYPE_OUT | IOIO_TYPE_STR)
+
+#define IOIO_REP       BIT(3)
+
+#define IOIO_ADDR_64   BIT(9)
+#define IOIO_ADDR_32   BIT(8)
+#define IOIO_ADDR_16   BIT(7)
+
+#define IOIO_DATA_32   BIT(6)
+#define IOIO_DATA_16   BIT(5)
+#define IOIO_DATA_8    BIT(4)
+
+#define IOIO_SEG_ES    (0 << 10)
+#define IOIO_SEG_DS    (3 << 10)
+
+static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
+{
+	struct insn *insn = &ctxt->insn;
+	size_t size;
+	u64 port;
+
+	*exitinfo = 0;
+
+	switch (insn->opcode.bytes[0]) {
+	/* INS opcodes */
+	case 0x6c:
+	case 0x6d:
+		*exitinfo |= IOIO_TYPE_INS;
+		*exitinfo |= IOIO_SEG_ES;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	/* OUTS opcodes */
+	case 0x6e:
+	case 0x6f:
+		*exitinfo |= IOIO_TYPE_OUTS;
+		*exitinfo |= IOIO_SEG_DS;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	/* IN immediate opcodes */
+	case 0xe4:
+	case 0xe5:
+		*exitinfo |= IOIO_TYPE_IN;
+		port	   = (u8)insn->immediate.value & 0xffff;
+		break;
+
+	/* OUT immediate opcodes */
+	case 0xe6:
+	case 0xe7:
+		*exitinfo |= IOIO_TYPE_OUT;
+		port	   = (u8)insn->immediate.value & 0xffff;
+		break;
+
+	/* IN register opcodes */
+	case 0xec:
+	case 0xed:
+		*exitinfo |= IOIO_TYPE_IN;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	/* OUT register opcodes */
+	case 0xee:
+	case 0xef:
+		*exitinfo |= IOIO_TYPE_OUT;
+		port	   = ctxt->regs->dx & 0xffff;
+		break;
+
+	default:
+		return ES_DECODE_FAILED;
+	}
+
+	*exitinfo |= port << 16;
+
+	switch (insn->opcode.bytes[0]) {
+	case 0x6c:
+	case 0x6e:
+	case 0xe4:
+	case 0xe6:
+	case 0xec:
+	case 0xee:
+		/* Single byte opcodes */
+		*exitinfo |= IOIO_DATA_8;
+		size       = 1;
+		break;
+	default:
+		/* Length determined by instruction parsing */
+		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
+						     : IOIO_DATA_32;
+		size       = (insn->opnd_bytes == 2) ? 2 : 4;
+	}
+
+	switch (insn->addr_bytes) {
+	case 2:
+		*exitinfo |= IOIO_ADDR_16;
+		break;
+	case 4:
+		*exitinfo |= IOIO_ADDR_32;
+		break;
+	case 8:
+		*exitinfo |= IOIO_ADDR_64;
+		break;
+	}
+
+	if (insn_has_rep_prefix(insn))
+		*exitinfo |= IOIO_REP;
+
+	return vc_ioio_check(ctxt, (u16)port, size);
+}
+
+static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u64 exit_info_1, exit_info_2;
+	enum es_result ret;
+
+	ret = vc_ioio_exitinfo(ctxt, &exit_info_1);
+	if (ret != ES_OK)
+		return ret;
+
+	if (exit_info_1 & IOIO_TYPE_STR) {
+
+		/* (REP) INS/OUTS */
+
+		bool df = ((regs->flags & X86_EFLAGS_DF) == X86_EFLAGS_DF);
+		unsigned int io_bytes, exit_bytes;
+		unsigned int ghcb_count, op_count;
+		unsigned long es_base;
+		u64 sw_scratch;
+
+		/*
+		 * For the string variants with rep prefix the amount of in/out
+		 * operations per #VC exception is limited so that the kernel
+		 * has a chance to take interrupts and re-schedule while the
+		 * instruction is emulated.
+		 */
+		io_bytes   = (exit_info_1 >> 4) & 0x7;
+		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
+
+		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
+		exit_info_2 = min(op_count, ghcb_count);
+		exit_bytes  = exit_info_2 * io_bytes;
+
+		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
+
+		/* Read bytes of OUTS into the shared buffer */
+		if (!(exit_info_1 & IOIO_TYPE_IN)) {
+			ret = vc_insn_string_read(ctxt,
+					       (void *)(es_base + regs->si),
+					       ghcb->shared_buffer, io_bytes,
+					       exit_info_2, df);
+			if (ret)
+				return ret;
+		}
+
+		/*
+		 * Issue an VMGEXIT to the HV to consume the bytes from the
+		 * shared buffer or to have it write them into the shared buffer
+		 * depending on the instruction: OUTS or INS.
+		 */
+		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
+		ghcb_set_sw_scratch(ghcb, sw_scratch);
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
+					  exit_info_1, exit_info_2);
+		if (ret != ES_OK)
+			return ret;
+
+		/* Read bytes from shared buffer into the guest's destination. */
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			ret = vc_insn_string_write(ctxt,
+						   (void *)(es_base + regs->di),
+						   ghcb->shared_buffer, io_bytes,
+						   exit_info_2, df);
+			if (ret)
+				return ret;
+
+			if (df)
+				regs->di -= exit_bytes;
+			else
+				regs->di += exit_bytes;
+		} else {
+			if (df)
+				regs->si -= exit_bytes;
+			else
+				regs->si += exit_bytes;
+		}
+
+		if (exit_info_1 & IOIO_REP)
+			regs->cx -= exit_info_2;
+
+		ret = regs->cx ? ES_RETRY : ES_OK;
+
+	} else {
+
+		/* IN/OUT into/from rAX */
+
+		int bits = (exit_info_1 & 0x70) >> 1;
+		u64 rax = 0;
+
+		if (!(exit_info_1 & IOIO_TYPE_IN))
+			rax = lower_bits(regs->ax, bits);
+
+		ghcb_set_rax(ghcb, rax);
+
+		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
+		if (ret != ES_OK)
+			return ret;
+
+		if (exit_info_1 & IOIO_TYPE_IN) {
+			if (!ghcb_rax_is_valid(ghcb))
+				return ES_VMM_ERROR;
+			regs->ax = lower_bits(ghcb->save.rax, bits);
+		}
+	}
+
+	return ret;
+}
+
+static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	struct cpuid_leaf leaf;
+	int ret;
+
+	leaf.fn = regs->ax;
+	leaf.subfn = regs->cx;
+	ret = snp_cpuid(ghcb, ctxt, &leaf);
+	if (!ret) {
+		regs->ax = leaf.eax;
+		regs->bx = leaf.ebx;
+		regs->cx = leaf.ecx;
+		regs->dx = leaf.edx;
+	}
+
+	return ret;
+}
+
+static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u32 cr4 = native_read_cr4();
+	enum es_result ret;
+	int snp_cpuid_ret;
+
+	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
+	if (!snp_cpuid_ret)
+		return ES_OK;
+	if (snp_cpuid_ret != -EOPNOTSUPP)
+		return ES_VMM_ERROR;
+
+	ghcb_set_rax(ghcb, regs->ax);
+	ghcb_set_rcx(ghcb, regs->cx);
+
+	if (cr4 & X86_CR4_OSXSAVE)
+		/* Safe to read xcr0 */
+		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
+	else
+		/* xgetbv will cause #GP - use reset value for xcr0 */
+		ghcb_set_xcr0(ghcb, 1);
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) &&
+	      ghcb_rbx_is_valid(ghcb) &&
+	      ghcb_rcx_is_valid(ghcb) &&
+	      ghcb_rdx_is_valid(ghcb)))
+		return ES_VMM_ERROR;
+
+	regs->ax = ghcb->save.rax;
+	regs->bx = ghcb->save.rbx;
+	regs->cx = ghcb->save.rcx;
+	regs->dx = ghcb->save.rdx;
+
+	return ES_OK;
+}
+
+static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt,
+				      unsigned long exit_code)
+{
+	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
+	enum es_result ret;
+
+	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
+	if (ret != ES_OK)
+		return ret;
+
+	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb) &&
+	     (!rdtscp || ghcb_rcx_is_valid(ghcb))))
+		return ES_VMM_ERROR;
+
+	ctxt->regs->ax = ghcb->save.rax;
+	ctxt->regs->dx = ghcb->save.rdx;
+	if (rdtscp)
+		ctxt->regs->cx = ghcb->save.rcx;
+
+	return ES_OK;
+}
+
+struct cc_setup_data {
+	struct setup_data header;
+	u32 cc_blob_address;
+};
+
+/*
+ * Search for a Confidential Computing blob passed in as a setup_data entry
+ * via the Linux Boot Protocol.
+ */
+static __head
+struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
+{
+	struct cc_setup_data *sd = NULL;
+	struct setup_data *hdr;
+
+	hdr = (struct setup_data *)bp->hdr.setup_data;
+
+	while (hdr) {
+		if (hdr->type == SETUP_CC_BLOB) {
+			sd = (struct cc_setup_data *)hdr;
+			return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
+		}
+		hdr = (struct setup_data *)hdr->next;
+	}
+
+	return NULL;
+}
+
+/*
+ * Initialize the kernel's copy of the SNP CPUID table, and set up the
+ * pointer that will be used to access it.
+ *
+ * Maintaining a direct mapping of the SNP CPUID table used by firmware would
+ * be possible as an alternative, but the approach is brittle since the
+ * mapping needs to be updated in sync with all the changes to virtual memory
+ * layout and related mapping facilities throughout the boot process.
+ */
+static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
+{
+	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
+	int i;
+
+	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table_fw = (const struct snp_cpuid_table *)cc_info->cpuid_phys;
+	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
+
+	cpuid_table = snp_cpuid_get_table();
+	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
+
+	/* Initialize CPUID ranges for range-checking. */
+	for (i = 0; i < cpuid_table->count; i++) {
+		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		if (fn->eax_in == 0x0)
+			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
+		else if (fn->eax_in == 0x40000000)
+			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
+		else if (fn->eax_in == 0x80000000)
+			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
+	}
+}
+
+static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_size,
+				    int ret, u64 svsm_ret)
+{
+	WARN(1, "PVALIDATE failure: pfn: 0x%llx, action: %u, size: %u, ret: %d, svsm_ret: 0x%llx\n",
+	     pfn, action, page_size, ret, svsm_ret);
+
+	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
+}
+
+static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svsm_ret)
+{
+	unsigned int page_size;
+	bool action;
+	u64 pfn;
+
+	pfn = pc->entry[pc->cur_index].pfn;
+	action = pc->entry[pc->cur_index].action;
+	page_size = pc->entry[pc->cur_index].page_size;
+
+	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
+}
+
+static void svsm_pval_4k_page(unsigned long paddr, bool validate)
+{
+	struct svsm_pvalidate_call *pc;
+	struct svsm_call call = {};
+	unsigned long flags;
+	u64 pc_pa;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	call.caa = svsm_get_caa();
+
+	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	pc->num_entries = 1;
+	pc->cur_index   = 0;
+	pc->entry[0].page_size = RMP_PG_SIZE_4K;
+	pc->entry[0].action    = validate;
+	pc->entry[0].ignore_cf = 0;
+	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pc_pa;
+
+	ret = svsm_perform_call_protocol(&call);
+	if (ret)
+		svsm_pval_terminate(pc, ret, call.rax_out);
+
+	native_local_irq_restore(flags);
+}
+
+static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
+{
+	int ret;
+
+	/*
+	 * This can be called very early during boot, so use rIP-relative
+	 * references as needed.
+	 */
+	if (RIP_REL_REF(snp_vmpl)) {
+		svsm_pval_4k_page(paddr, validate);
+	} else {
+		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+		if (ret)
+			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
+	}
+}
+
+static void pval_pages(struct snp_psc_desc *desc)
+{
+	struct psc_entry *e;
+	unsigned long vaddr;
+	unsigned int size;
+	unsigned int i;
+	bool validate;
+	u64 pfn;
+	int rc;
+
+	for (i = 0; i <= desc->hdr.end_entry; i++) {
+		e = &desc->entries[i];
+
+		pfn = e->gfn;
+		vaddr = (unsigned long)pfn_to_kaddr(pfn);
+		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
+
+		rc = pvalidate(vaddr, size, validate);
+		if (!rc)
+			continue;
+
+		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
+			unsigned long vaddr_end = vaddr + PMD_SIZE;
+
+			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE, pfn++) {
+				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
+				if (rc)
+					__pval_terminate(pfn, validate, RMP_PG_SIZE_4K, rc, 0);
+			}
+		} else {
+			__pval_terminate(pfn, validate, size, rc, 0);
+		}
+	}
+}
+
+static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
+					struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+
+	/* Nothing in the CA yet */
+	pc->num_entries = 0;
+	pc->cur_index   = 0;
+
+	pe = &pc->entry[0];
+
+	while (pfn < pfn_end) {
+		pe->page_size = RMP_PG_SIZE_4K;
+		pe->action    = action;
+		pe->ignore_cf = 0;
+		pe->pfn       = pfn;
+
+		pe++;
+		pfn++;
+
+		pc->num_entries++;
+		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	return pfn;
+}
+
+static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int desc_entry,
+				       struct svsm_pvalidate_call *pc)
+{
+	struct svsm_pvalidate_entry *pe;
+	struct psc_entry *e;
+
+	/* Nothing in the CA yet */
+	pc->num_entries = 0;
+	pc->cur_index   = 0;
+
+	pe = &pc->entry[0];
+	e  = &desc->entries[desc_entry];
+
+	while (desc_entry <= desc->hdr.end_entry) {
+		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
+		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
+		pe->ignore_cf = 0;
+		pe->pfn       = e->gfn;
+
+		pe++;
+		e++;
+
+		desc_entry++;
+		pc->num_entries++;
+		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
+			break;
+	}
+
+	return desc_entry;
+}
+
+static void svsm_pval_pages(struct snp_psc_desc *desc)
+{
+	struct svsm_pvalidate_entry pv_4k[VMGEXIT_PSC_MAX_ENTRY];
+	unsigned int i, pv_4k_count = 0;
+	struct svsm_pvalidate_call *pc;
+	struct svsm_call call = {};
+	unsigned long flags;
+	bool action;
+	u64 pc_pa;
+	int ret;
+
+	/*
+	 * This can be called very early in the boot, use native functions in
+	 * order to avoid paravirt issues.
+	 */
+	flags = native_local_irq_save();
+
+	/*
+	 * The SVSM calling area (CA) can support processing 510 entries at a
+	 * time. Loop through the Page State Change descriptor until the CA is
+	 * full or the last entry in the descriptor is reached, at which time
+	 * the SVSM is invoked. This repeats until all entries in the descriptor
+	 * are processed.
+	 */
+	call.caa = svsm_get_caa();
+
+	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
+	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
+
+	/* Protocol 0, Call ID 1 */
+	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
+	call.rcx = pc_pa;
+
+	for (i = 0; i <= desc->hdr.end_entry;) {
+		i = svsm_build_ca_from_psc_desc(desc, i, pc);
+
+		do {
+			ret = svsm_perform_call_protocol(&call);
+			if (!ret)
+				continue;
+
+			/*
+			 * Check if the entry failed because of an RMP mismatch (a
+			 * PVALIDATE at 2M was requested, but the page is mapped in
+			 * the RMP as 4K).
+			 */
+
+			if (call.rax_out == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
+			    pc->entry[pc->cur_index].page_size == RMP_PG_SIZE_2M) {
+				/* Save this entry for post-processing at 4K */
+				pv_4k[pv_4k_count++] = pc->entry[pc->cur_index];
+
+				/* Skip to the next one unless at the end of the list */
+				pc->cur_index++;
+				if (pc->cur_index < pc->num_entries)
+					ret = -EAGAIN;
+				else
+					ret = 0;
+			}
+		} while (ret == -EAGAIN);
+
+		if (ret)
+			svsm_pval_terminate(pc, ret, call.rax_out);
+	}
+
+	/* Process any entries that failed to be validated at 2M and validate them at 4K */
+	for (i = 0; i < pv_4k_count; i++) {
+		u64 pfn, pfn_end;
+
+		action  = pv_4k[i].action;
+		pfn     = pv_4k[i].pfn;
+		pfn_end = pfn + 512;
+
+		while (pfn < pfn_end) {
+			pfn = svsm_build_ca_from_pfn_range(pfn, pfn_end, action, pc);
+
+			ret = svsm_perform_call_protocol(&call);
+			if (ret)
+				svsm_pval_terminate(pc, ret, call.rax_out);
+		}
+	}
+
+	native_local_irq_restore(flags);
+}
+
+static void pvalidate_pages(struct snp_psc_desc *desc)
+{
+	if (snp_vmpl)
+		svsm_pval_pages(desc);
+	else
+		pval_pages(desc);
+}
+
+static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
+{
+	int cur_entry, end_entry, ret = 0;
+	struct snp_psc_desc *data;
+	struct es_em_ctxt ctxt;
+
+	vc_ghcb_invalidate(ghcb);
+
+	/* Copy the input desc into GHCB shared buffer */
+	data = (struct snp_psc_desc *)ghcb->shared_buffer;
+	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
+
+	/*
+	 * As per the GHCB specification, the hypervisor can resume the guest
+	 * before processing all the entries. Check whether all the entries
+	 * are processed. If not, then keep retrying. Note, the hypervisor
+	 * will update the data memory directly to indicate the status, so
+	 * reference the data->hdr everywhere.
+	 *
+	 * The strategy here is to wait for the hypervisor to change the page
+	 * state in the RMP table before guest accesses the memory pages. If the
+	 * page state change was not successful, then later memory access will
+	 * result in a crash.
+	 */
+	cur_entry = data->hdr.cur_entry;
+	end_entry = data->hdr.end_entry;
+
+	while (data->hdr.cur_entry <= data->hdr.end_entry) {
+		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
+
+		/* This will advance the shared buffer data points to. */
+		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
+
+		/*
+		 * Page State Change VMGEXIT can pass error code through
+		 * exit_info_2.
+		 */
+		if (WARN(ret || ghcb->save.sw_exit_info_2,
+			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
+			 ret, ghcb->save.sw_exit_info_2)) {
+			ret = 1;
+			goto out;
+		}
+
+		/* Verify that reserved bit is not set */
+		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
+			ret = 1;
+			goto out;
+		}
+
+		/*
+		 * Sanity check that entry processing is not going backwards.
+		 * This will happen only if hypervisor is tricking us.
+		 */
+		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
+"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
+			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
+			ret = 1;
+			goto out;
+		}
+	}
+
+out:
+	return ret;
+}
+
+static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
+					    unsigned long exit_code)
+{
+	unsigned int opcode = (unsigned int)ctxt->insn.opcode.value;
+	u8 modrm = ctxt->insn.modrm.value;
+
+	switch (exit_code) {
+
+	case SVM_EXIT_IOIO:
+	case SVM_EXIT_NPF:
+		/* handled separately */
+		return ES_OK;
+
+	case SVM_EXIT_CPUID:
+		if (opcode == 0xa20f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_INVD:
+		if (opcode == 0x080f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MONITOR:
+		/* MONITOR and MONITORX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc8 || modrm == 0xfa))
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MWAIT:
+		/* MWAIT and MWAITX instructions generate the same error code */
+		if (opcode == 0x010f && (modrm == 0xc9 || modrm == 0xfb))
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_MSR:
+		/* RDMSR */
+		if (opcode == 0x320f ||
+		/* WRMSR */
+		    opcode == 0x300f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDPMC:
+		if (opcode == 0x330f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSC:
+		if (opcode == 0x310f)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_RDTSCP:
+		if (opcode == 0x010f && modrm == 0xf9)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_READ_DR7:
+		if (opcode == 0x210f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_VMMCALL:
+		if (opcode == 0x010f && modrm == 0xd9)
+			return ES_OK;
+
+		break;
+
+	case SVM_EXIT_WRITE_DR7:
+		if (opcode == 0x230f &&
+		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
+			return ES_OK;
+		break;
+
+	case SVM_EXIT_WBINVD:
+		if (opcode == 0x90f)
+			return ES_OK;
+		break;
+
+	default:
+		break;
+	}
+
+	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%lx, rIP: 0x%lx\n",
+		   opcode, exit_code, ctxt->regs->ip);
+
+	return ES_UNSUPPORTED;
+}
+
+/*
+ * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
+ * services needed when not running in VMPL0.
+ */
+static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
+{
+	struct snp_secrets_page *secrets_page;
+	struct snp_cpuid_table *cpuid_table;
+	unsigned int i;
+	u64 caa;
+
+	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
+
+	/*
+	 * Check if running at VMPL0.
+	 *
+	 * Use RMPADJUST (see the rmpadjust() function for a description of what
+	 * the instruction does) to update the VMPL1 permissions of a page. If
+	 * the guest is running at VMPL0, this will succeed and implies there is
+	 * no SVSM. If the guest is running at any other VMPL, this will fail.
+	 * Linux SNP guests only ever run at a single VMPL level so permission mask
+	 * changes of a lesser-privileged VMPL are a don't-care.
+	 *
+	 * Use a rip-relative reference to obtain the proper address, since this
+	 * routine is running identity mapped when called, both by the decompressor
+	 * code and the early kernel code.
+	 */
+	if (!rmpadjust((unsigned long)&RIP_REL_REF(boot_ghcb_page), RMP_PG_SIZE_4K, 1))
+		return false;
+
+	/*
+	 * Not running at VMPL0, ensure everything has been properly supplied
+	 * for running under an SVSM.
+	 */
+	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
+
+	secrets_page = (struct snp_secrets_page *)cc_info->secrets_phys;
+	if (!secrets_page->svsm_size)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
+
+	if (!secrets_page->svsm_guest_vmpl)
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
+
+	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
+
+	caa = secrets_page->svsm_caa;
+
+	/*
+	 * An open-coded PAGE_ALIGNED() in order to avoid including
+	 * kernel-proper headers into the decompressor.
+	 */
+	if (caa & (PAGE_SIZE - 1))
+		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
+
+	/*
+	 * The CA is identity mapped when this routine is called, both by the
+	 * decompressor code and the early kernel code.
+	 */
+	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
+	RIP_REL_REF(boot_svsm_caa_pa) = caa;
+
+	/* Advertise the SVSM presence via CPUID. */
+	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
+	for (i = 0; i < cpuid_table->count; i++) {
+		struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
+
+		if (fn->eax_in == 0x8000001f)
+			fn->eax |= BIT(28);
+	}
+
+	return true;
+}
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 20a0dd5..b22ceb9 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -142,8 +142,6 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
-
 obj-$(CONFIG_CFI_CLANG)			+= cfi.o
 
 obj-$(CONFIG_CALL_THUNKS)		+= callthunks.o
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
deleted file mode 100644
index 71de531..0000000
--- a/arch/x86/kernel/sev-shared.c
+++ /dev/null
@@ -1,1717 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * AMD Encrypted Register State Support
- *
- * Author: Joerg Roedel <jroedel@suse.de>
- *
- * This file is not compiled stand-alone. It contains code shared
- * between the pre-decompression boot code and the running Linux kernel
- * and is included directly into both code-bases.
- */
-
-#include <asm/setup_data.h>
-
-#ifndef __BOOT_COMPRESSED
-#define error(v)			pr_err(v)
-#define has_cpuflag(f)			boot_cpu_has(f)
-#define sev_printk(fmt, ...)		printk(fmt, ##__VA_ARGS__)
-#define sev_printk_rtl(fmt, ...)	printk_ratelimited(fmt, ##__VA_ARGS__)
-#else
-#undef WARN
-#define WARN(condition, format...) (!!(condition))
-#define sev_printk(fmt, ...)
-#define sev_printk_rtl(fmt, ...)
-#undef vc_forward_exception
-#define vc_forward_exception(c)		panic("SNP: Hypervisor requested exception\n")
-#endif
-
-/*
- * SVSM related information:
- *   When running under an SVSM, the VMPL that Linux is executing at must be
- *   non-zero. The VMPL is therefore used to indicate the presence of an SVSM.
- *
- *   During boot, the page tables are set up as identity mapped and later
- *   changed to use kernel virtual addresses. Maintain separate virtual and
- *   physical addresses for the CAA to allow SVSM functions to be used during
- *   early boot, both with identity mapped virtual addresses and proper kernel
- *   virtual addresses.
- */
-u8 snp_vmpl __ro_after_init;
-EXPORT_SYMBOL_GPL(snp_vmpl);
-static struct svsm_ca *boot_svsm_caa __ro_after_init;
-static u64 boot_svsm_caa_pa __ro_after_init;
-
-static struct svsm_ca *svsm_get_caa(void);
-static u64 svsm_get_caa_pa(void);
-static int svsm_perform_call_protocol(struct svsm_call *call);
-
-/* I/O parameters for CPUID-related helpers */
-struct cpuid_leaf {
-	u32 fn;
-	u32 subfn;
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-};
-
-/*
- * Individual entries of the SNP CPUID table, as defined by the SNP
- * Firmware ABI, Revision 0.9, Section 7.1, Table 14.
- */
-struct snp_cpuid_fn {
-	u32 eax_in;
-	u32 ecx_in;
-	u64 xcr0_in;
-	u64 xss_in;
-	u32 eax;
-	u32 ebx;
-	u32 ecx;
-	u32 edx;
-	u64 __reserved;
-} __packed;
-
-/*
- * SNP CPUID table, as defined by the SNP Firmware ABI, Revision 0.9,
- * Section 8.14.2.6. Also noted there is the SNP firmware-enforced limit
- * of 64 entries per CPUID table.
- */
-#define SNP_CPUID_COUNT_MAX 64
-
-struct snp_cpuid_table {
-	u32 count;
-	u32 __reserved1;
-	u64 __reserved2;
-	struct snp_cpuid_fn fn[SNP_CPUID_COUNT_MAX];
-} __packed;
-
-/*
- * Since feature negotiation related variables are set early in the boot
- * process they must reside in the .data section so as not to be zeroed
- * out when the .bss section is later cleared.
- *
- * GHCB protocol version negotiated with the hypervisor.
- */
-static u16 ghcb_version __ro_after_init;
-
-/* Copy of the SNP firmware's CPUID page. */
-static struct snp_cpuid_table cpuid_table_copy __ro_after_init;
-
-/*
- * These will be initialized based on CPUID table so that non-present
- * all-zero leaves (for sparse tables) can be differentiated from
- * invalid/out-of-range leaves. This is needed since all-zero leaves
- * still need to be post-processed.
- */
-static u32 cpuid_std_range_max __ro_after_init;
-static u32 cpuid_hyp_range_max __ro_after_init;
-static u32 cpuid_ext_range_max __ro_after_init;
-
-static bool __init sev_es_check_cpu_features(void)
-{
-	if (!has_cpuflag(X86_FEATURE_RDRAND)) {
-		error("RDRAND instruction not supported - no trusted source of randomness available\n");
-		return false;
-	}
-
-	return true;
-}
-
-static void __head __noreturn
-sev_es_terminate(unsigned int set, unsigned int reason)
-{
-	u64 val = GHCB_MSR_TERM_REQ;
-
-	/* Tell the hypervisor what went wrong. */
-	val |= GHCB_SEV_TERM_REASON(set, reason);
-
-	/* Request Guest Termination from Hypervisor */
-	sev_es_wr_ghcb_msr(val);
-	VMGEXIT();
-
-	while (true)
-		asm volatile("hlt\n" : : : "memory");
-}
-
-/*
- * The hypervisor features are available from GHCB version 2 onward.
- */
-static u64 get_hv_features(void)
-{
-	u64 val;
-
-	if (ghcb_version < 2)
-		return 0;
-
-	sev_es_wr_ghcb_msr(GHCB_MSR_HV_FT_REQ);
-	VMGEXIT();
-
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_HV_FT_RESP)
-		return 0;
-
-	return GHCB_MSR_HV_FT_RESP_VAL(val);
-}
-
-static void snp_register_ghcb_early(unsigned long paddr)
-{
-	unsigned long pfn = paddr >> PAGE_SHIFT;
-	u64 val;
-
-	sev_es_wr_ghcb_msr(GHCB_MSR_REG_GPA_REQ_VAL(pfn));
-	VMGEXIT();
-
-	val = sev_es_rd_ghcb_msr();
-
-	/* If the response GPA is not ours then abort the guest */
-	if ((GHCB_RESP_CODE(val) != GHCB_MSR_REG_GPA_RESP) ||
-	    (GHCB_MSR_REG_GPA_RESP_VAL(val) != pfn))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_REGISTER);
-}
-
-static bool sev_es_negotiate_protocol(void)
-{
-	u64 val;
-
-	/* Do the GHCB protocol version negotiation */
-	sev_es_wr_ghcb_msr(GHCB_MSR_SEV_INFO_REQ);
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-
-	if (GHCB_MSR_INFO(val) != GHCB_MSR_SEV_INFO_RESP)
-		return false;
-
-	if (GHCB_MSR_PROTO_MAX(val) < GHCB_PROTOCOL_MIN ||
-	    GHCB_MSR_PROTO_MIN(val) > GHCB_PROTOCOL_MAX)
-		return false;
-
-	ghcb_version = min_t(size_t, GHCB_MSR_PROTO_MAX(val), GHCB_PROTOCOL_MAX);
-
-	return true;
-}
-
-static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
-{
-	ghcb->save.sw_exit_code = 0;
-	__builtin_memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
-}
-
-static bool vc_decoding_needed(unsigned long exit_code)
-{
-	/* Exceptions don't require to decode the instruction */
-	return !(exit_code >= SVM_EXIT_EXCP_BASE &&
-		 exit_code <= SVM_EXIT_LAST_EXCP);
-}
-
-static enum es_result vc_init_em_ctxt(struct es_em_ctxt *ctxt,
-				      struct pt_regs *regs,
-				      unsigned long exit_code)
-{
-	enum es_result ret = ES_OK;
-
-	memset(ctxt, 0, sizeof(*ctxt));
-	ctxt->regs = regs;
-
-	if (vc_decoding_needed(exit_code))
-		ret = vc_decode_insn(ctxt);
-
-	return ret;
-}
-
-static void vc_finish_insn(struct es_em_ctxt *ctxt)
-{
-	ctxt->regs->ip += ctxt->insn.length;
-}
-
-static enum es_result verify_exception_info(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	u32 ret;
-
-	ret = ghcb->save.sw_exit_info_1 & GENMASK_ULL(31, 0);
-	if (!ret)
-		return ES_OK;
-
-	if (ret == 1) {
-		u64 info = ghcb->save.sw_exit_info_2;
-		unsigned long v = info & SVM_EVTINJ_VEC_MASK;
-
-		/* Check if exception information from hypervisor is sane. */
-		if ((info & SVM_EVTINJ_VALID) &&
-		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
-		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
-			ctxt->fi.vector = v;
-
-			if (info & SVM_EVTINJ_VALID_ERR)
-				ctxt->fi.error_code = info >> 32;
-
-			return ES_EXCEPTION;
-		}
-	}
-
-	return ES_VMM_ERROR;
-}
-
-static inline int svsm_process_result_codes(struct svsm_call *call)
-{
-	switch (call->rax_out) {
-	case SVSM_SUCCESS:
-		return 0;
-	case SVSM_ERR_INCOMPLETE:
-	case SVSM_ERR_BUSY:
-		return -EAGAIN;
-	default:
-		return -EINVAL;
-	}
-}
-
-/*
- * Issue a VMGEXIT to call the SVSM:
- *   - Load the SVSM register state (RAX, RCX, RDX, R8 and R9)
- *   - Set the CA call pending field to 1
- *   - Issue VMGEXIT
- *   - Save the SVSM return register state (RAX, RCX, RDX, R8 and R9)
- *   - Perform atomic exchange of the CA call pending field
- *
- *   - See the "Secure VM Service Module for SEV-SNP Guests" specification for
- *     details on the calling convention.
- *     - The calling convention loosely follows the Microsoft X64 calling
- *       convention by putting arguments in RCX, RDX, R8 and R9.
- *     - RAX specifies the SVSM protocol/callid as input and the return code
- *       as output.
- */
-static __always_inline void svsm_issue_call(struct svsm_call *call, u8 *pending)
-{
-	register unsigned long rax asm("rax") = call->rax;
-	register unsigned long rcx asm("rcx") = call->rcx;
-	register unsigned long rdx asm("rdx") = call->rdx;
-	register unsigned long r8  asm("r8")  = call->r8;
-	register unsigned long r9  asm("r9")  = call->r9;
-
-	call->caa->call_pending = 1;
-
-	asm volatile("rep; vmmcall\n\t"
-		     : "+r" (rax), "+r" (rcx), "+r" (rdx), "+r" (r8), "+r" (r9)
-		     : : "memory");
-
-	*pending = xchg(&call->caa->call_pending, *pending);
-
-	call->rax_out = rax;
-	call->rcx_out = rcx;
-	call->rdx_out = rdx;
-	call->r8_out  = r8;
-	call->r9_out  = r9;
-}
-
-static int svsm_perform_msr_protocol(struct svsm_call *call)
-{
-	u8 pending = 0;
-	u64 val, resp;
-
-	/*
-	 * When using the MSR protocol, be sure to save and restore
-	 * the current MSR value.
-	 */
-	val = sev_es_rd_ghcb_msr();
-
-	sev_es_wr_ghcb_msr(GHCB_MSR_VMPL_REQ_LEVEL(0));
-
-	svsm_issue_call(call, &pending);
-
-	resp = sev_es_rd_ghcb_msr();
-
-	sev_es_wr_ghcb_msr(val);
-
-	if (pending)
-		return -EINVAL;
-
-	if (GHCB_RESP_CODE(resp) != GHCB_MSR_VMPL_RESP)
-		return -EINVAL;
-
-	if (GHCB_MSR_VMPL_RESP_VAL(resp))
-		return -EINVAL;
-
-	return svsm_process_result_codes(call);
-}
-
-static int svsm_perform_ghcb_protocol(struct ghcb *ghcb, struct svsm_call *call)
-{
-	struct es_em_ctxt ctxt;
-	u8 pending = 0;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/*
-	 * Fill in protocol and format specifiers. This can be called very early
-	 * in the boot, so use rip-relative references as needed.
-	 */
-	ghcb->protocol_version = RIP_REL_REF(ghcb_version);
-	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_SNP_RUN_VMPL);
-	ghcb_set_sw_exit_info_1(ghcb, 0);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-
-	svsm_issue_call(call, &pending);
-
-	if (pending)
-		return -EINVAL;
-
-	switch (verify_exception_info(ghcb, &ctxt)) {
-	case ES_OK:
-		break;
-	case ES_EXCEPTION:
-		vc_forward_exception(&ctxt);
-		fallthrough;
-	default:
-		return -EINVAL;
-	}
-
-	return svsm_process_result_codes(call);
-}
-
-static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2)
-{
-	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = ghcb_version;
-	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, exit_code);
-	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
-	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	return verify_exception_info(ghcb, ctxt);
-}
-
-static int __sev_cpuid_hv(u32 fn, int reg_idx, u32 *reg)
-{
-	u64 val;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, reg_idx));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_RESP_CODE(val) != GHCB_MSR_CPUID_RESP)
-		return -EIO;
-
-	*reg = (val >> 32);
-
-	return 0;
-}
-
-static int __sev_cpuid_hv_msr(struct cpuid_leaf *leaf)
-{
-	int ret;
-
-	/*
-	 * MSR protocol does not support fetching non-zero subfunctions, but is
-	 * sufficient to handle current early-boot cases. Should that change,
-	 * make sure to report an error rather than ignoring the index and
-	 * grabbing random values. If this issue arises in the future, handling
-	 * can be added here to use GHCB-page protocol for cases that occur late
-	 * enough in boot that GHCB page is available.
-	 */
-	if (cpuid_function_is_indexed(leaf->fn) && leaf->subfn)
-		return -EINVAL;
-
-	ret =         __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EAX, &leaf->eax);
-	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EBX, &leaf->ebx);
-	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_ECX, &leaf->ecx);
-	ret = ret ? : __sev_cpuid_hv(leaf->fn, GHCB_CPUID_REQ_EDX, &leaf->edx);
-
-	return ret;
-}
-
-static int __sev_cpuid_hv_ghcb(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
-{
-	u32 cr4 = native_read_cr4();
-	int ret;
-
-	ghcb_set_rax(ghcb, leaf->fn);
-	ghcb_set_rcx(ghcb, leaf->subfn);
-
-	if (cr4 & X86_CR4_OSXSAVE)
-		/* Safe to read xcr0 */
-		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
-	else
-		/* xgetbv will cause #UD - use reset value for xcr0 */
-		ghcb_set_xcr0(ghcb, 1);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) &&
-	      ghcb_rbx_is_valid(ghcb) &&
-	      ghcb_rcx_is_valid(ghcb) &&
-	      ghcb_rdx_is_valid(ghcb)))
-		return ES_VMM_ERROR;
-
-	leaf->eax = ghcb->save.rax;
-	leaf->ebx = ghcb->save.rbx;
-	leaf->ecx = ghcb->save.rcx;
-	leaf->edx = ghcb->save.rdx;
-
-	return ES_OK;
-}
-
-static int sev_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
-{
-	return ghcb ? __sev_cpuid_hv_ghcb(ghcb, ctxt, leaf)
-		    : __sev_cpuid_hv_msr(leaf);
-}
-
-/*
- * This may be called early while still running on the initial identity
- * mapping. Use RIP-relative addressing to obtain the correct address
- * while running with the initial identity mapping as well as the
- * switch-over to kernel virtual addresses later.
- */
-static const struct snp_cpuid_table *snp_cpuid_get_table(void)
-{
-	return &RIP_REL_REF(cpuid_table_copy);
-}
-
-/*
- * The SNP Firmware ABI, Revision 0.9, Section 7.1, details the use of
- * XCR0_IN and XSS_IN to encode multiple versions of 0xD subfunctions 0
- * and 1 based on the corresponding features enabled by a particular
- * combination of XCR0 and XSS registers so that a guest can look up the
- * version corresponding to the features currently enabled in its XCR0/XSS
- * registers. The only values that differ between these versions/table
- * entries is the enabled XSAVE area size advertised via EBX.
- *
- * While hypervisors may choose to make use of this support, it is more
- * robust/secure for a guest to simply find the entry corresponding to the
- * base/legacy XSAVE area size (XCR0=1 or XCR0=3), and then calculate the
- * XSAVE area size using subfunctions 2 through 64, as documented in APM
- * Volume 3, Rev 3.31, Appendix E.3.8, which is what is done here.
- *
- * Since base/legacy XSAVE area size is documented as 0x240, use that value
- * directly rather than relying on the base size in the CPUID table.
- *
- * Return: XSAVE area size on success, 0 otherwise.
- */
-static u32 snp_cpuid_calc_xsave_size(u64 xfeatures_en, bool compacted)
-{
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
-	u64 xfeatures_found = 0;
-	u32 xsave_size = 0x240;
-	int i;
-
-	for (i = 0; i < cpuid_table->count; i++) {
-		const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
-
-		if (!(e->eax_in == 0xD && e->ecx_in > 1 && e->ecx_in < 64))
-			continue;
-		if (!(xfeatures_en & (BIT_ULL(e->ecx_in))))
-			continue;
-		if (xfeatures_found & (BIT_ULL(e->ecx_in)))
-			continue;
-
-		xfeatures_found |= (BIT_ULL(e->ecx_in));
-
-		if (compacted)
-			xsave_size += e->eax;
-		else
-			xsave_size = max(xsave_size, e->eax + e->ebx);
-	}
-
-	/*
-	 * Either the guest set unsupported XCR0/XSS bits, or the corresponding
-	 * entries in the CPUID table were not present. This is not a valid
-	 * state to be in.
-	 */
-	if (xfeatures_found != (xfeatures_en & GENMASK_ULL(63, 2)))
-		return 0;
-
-	return xsave_size;
-}
-
-static bool __head
-snp_cpuid_get_validated_func(struct cpuid_leaf *leaf)
-{
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
-	int i;
-
-	for (i = 0; i < cpuid_table->count; i++) {
-		const struct snp_cpuid_fn *e = &cpuid_table->fn[i];
-
-		if (e->eax_in != leaf->fn)
-			continue;
-
-		if (cpuid_function_is_indexed(leaf->fn) && e->ecx_in != leaf->subfn)
-			continue;
-
-		/*
-		 * For 0xD subfunctions 0 and 1, only use the entry corresponding
-		 * to the base/legacy XSAVE area size (XCR0=1 or XCR0=3, XSS=0).
-		 * See the comments above snp_cpuid_calc_xsave_size() for more
-		 * details.
-		 */
-		if (e->eax_in == 0xD && (e->ecx_in == 0 || e->ecx_in == 1))
-			if (!(e->xcr0_in == 1 || e->xcr0_in == 3) || e->xss_in)
-				continue;
-
-		leaf->eax = e->eax;
-		leaf->ebx = e->ebx;
-		leaf->ecx = e->ecx;
-		leaf->edx = e->edx;
-
-		return true;
-	}
-
-	return false;
-}
-
-static void snp_cpuid_hv(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
-{
-	if (sev_cpuid_hv(ghcb, ctxt, leaf))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID_HV);
-}
-
-static int snp_cpuid_postprocess(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 struct cpuid_leaf *leaf)
-{
-	struct cpuid_leaf leaf_hv = *leaf;
-
-	switch (leaf->fn) {
-	case 0x1:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
-
-		/* initial APIC ID */
-		leaf->ebx = (leaf_hv.ebx & GENMASK(31, 24)) | (leaf->ebx & GENMASK(23, 0));
-		/* APIC enabled bit */
-		leaf->edx = (leaf_hv.edx & BIT(9)) | (leaf->edx & ~BIT(9));
-
-		/* OSXSAVE enabled bit */
-		if (native_read_cr4() & X86_CR4_OSXSAVE)
-			leaf->ecx |= BIT(27);
-		break;
-	case 0x7:
-		/* OSPKE enabled bit */
-		leaf->ecx &= ~BIT(4);
-		if (native_read_cr4() & X86_CR4_PKE)
-			leaf->ecx |= BIT(4);
-		break;
-	case 0xB:
-		leaf_hv.subfn = 0;
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
-
-		/* extended APIC ID */
-		leaf->edx = leaf_hv.edx;
-		break;
-	case 0xD: {
-		bool compacted = false;
-		u64 xcr0 = 1, xss = 0;
-		u32 xsave_size;
-
-		if (leaf->subfn != 0 && leaf->subfn != 1)
-			return 0;
-
-		if (native_read_cr4() & X86_CR4_OSXSAVE)
-			xcr0 = xgetbv(XCR_XFEATURE_ENABLED_MASK);
-		if (leaf->subfn == 1) {
-			/* Get XSS value if XSAVES is enabled. */
-			if (leaf->eax & BIT(3)) {
-				unsigned long lo, hi;
-
-				asm volatile("rdmsr" : "=a" (lo), "=d" (hi)
-						     : "c" (MSR_IA32_XSS));
-				xss = (hi << 32) | lo;
-			}
-
-			/*
-			 * The PPR and APM aren't clear on what size should be
-			 * encoded in 0xD:0x1:EBX when compaction is not enabled
-			 * by either XSAVEC (feature bit 1) or XSAVES (feature
-			 * bit 3) since SNP-capable hardware has these feature
-			 * bits fixed as 1. KVM sets it to 0 in this case, but
-			 * to avoid this becoming an issue it's safer to simply
-			 * treat this as unsupported for SNP guests.
-			 */
-			if (!(leaf->eax & (BIT(1) | BIT(3))))
-				return -EINVAL;
-
-			compacted = true;
-		}
-
-		xsave_size = snp_cpuid_calc_xsave_size(xcr0 | xss, compacted);
-		if (!xsave_size)
-			return -EINVAL;
-
-		leaf->ebx = xsave_size;
-		}
-		break;
-	case 0x8000001E:
-		snp_cpuid_hv(ghcb, ctxt, &leaf_hv);
-
-		/* extended APIC ID */
-		leaf->eax = leaf_hv.eax;
-		/* compute ID */
-		leaf->ebx = (leaf->ebx & GENMASK(31, 8)) | (leaf_hv.ebx & GENMASK(7, 0));
-		/* node ID */
-		leaf->ecx = (leaf->ecx & GENMASK(31, 8)) | (leaf_hv.ecx & GENMASK(7, 0));
-		break;
-	default:
-		/* No fix-ups needed, use values as-is. */
-		break;
-	}
-
-	return 0;
-}
-
-/*
- * Returns -EOPNOTSUPP if feature not enabled. Any other non-zero return value
- * should be treated as fatal by caller.
- */
-static int __head
-snp_cpuid(struct ghcb *ghcb, struct es_em_ctxt *ctxt, struct cpuid_leaf *leaf)
-{
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
-
-	if (!cpuid_table->count)
-		return -EOPNOTSUPP;
-
-	if (!snp_cpuid_get_validated_func(leaf)) {
-		/*
-		 * Some hypervisors will avoid keeping track of CPUID entries
-		 * where all values are zero, since they can be handled the
-		 * same as out-of-range values (all-zero). This is useful here
-		 * as well as it allows virtually all guest configurations to
-		 * work using a single SNP CPUID table.
-		 *
-		 * To allow for this, there is a need to distinguish between
-		 * out-of-range entries and in-range zero entries, since the
-		 * CPUID table entries are only a template that may need to be
-		 * augmented with additional values for things like
-		 * CPU-specific information during post-processing. So if it's
-		 * not in the table, set the values to zero. Then, if they are
-		 * within a valid CPUID range, proceed with post-processing
-		 * using zeros as the initial values. Otherwise, skip
-		 * post-processing and just return zeros immediately.
-		 */
-		leaf->eax = leaf->ebx = leaf->ecx = leaf->edx = 0;
-
-		/* Skip post-processing for out-of-range zero leafs. */
-		if (!(leaf->fn <= RIP_REL_REF(cpuid_std_range_max) ||
-		      (leaf->fn >= 0x40000000 && leaf->fn <= RIP_REL_REF(cpuid_hyp_range_max)) ||
-		      (leaf->fn >= 0x80000000 && leaf->fn <= RIP_REL_REF(cpuid_ext_range_max))))
-			return 0;
-	}
-
-	return snp_cpuid_postprocess(ghcb, ctxt, leaf);
-}
-
-/*
- * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
- * page yet, so it only supports the MSR based communication with the
- * hypervisor and only the CPUID exit-code.
- */
-void __head do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
-{
-	unsigned int subfn = lower_bits(regs->cx, 32);
-	unsigned int fn = lower_bits(regs->ax, 32);
-	u16 opcode = *(unsigned short *)regs->ip;
-	struct cpuid_leaf leaf;
-	int ret;
-
-	/* Only CPUID is supported via MSR protocol */
-	if (exit_code != SVM_EXIT_CPUID)
-		goto fail;
-
-	/* Is it really a CPUID insn? */
-	if (opcode != 0xa20f)
-		goto fail;
-
-	leaf.fn = fn;
-	leaf.subfn = subfn;
-
-	ret = snp_cpuid(NULL, NULL, &leaf);
-	if (!ret)
-		goto cpuid_done;
-
-	if (ret != -EOPNOTSUPP)
-		goto fail;
-
-	if (__sev_cpuid_hv_msr(&leaf))
-		goto fail;
-
-cpuid_done:
-	regs->ax = leaf.eax;
-	regs->bx = leaf.ebx;
-	regs->cx = leaf.ecx;
-	regs->dx = leaf.edx;
-
-	/*
-	 * This is a VC handler and the #VC is only raised when SEV-ES is
-	 * active, which means SEV must be active too. Do sanity checks on the
-	 * CPUID results to make sure the hypervisor does not trick the kernel
-	 * into the no-sev path. This could map sensitive data unencrypted and
-	 * make it accessible to the hypervisor.
-	 *
-	 * In particular, check for:
-	 *	- Availability of CPUID leaf 0x8000001f
-	 *	- SEV CPUID bit.
-	 *
-	 * The hypervisor might still report the wrong C-bit position, but this
-	 * can't be checked here.
-	 */
-
-	if (fn == 0x80000000 && (regs->ax < 0x8000001f))
-		/* SEV leaf check */
-		goto fail;
-	else if ((fn == 0x8000001f && !(regs->ax & BIT(1))))
-		/* SEV bit */
-		goto fail;
-
-	/* Skip over the CPUID two-byte opcode */
-	regs->ip += 2;
-
-	return;
-
-fail:
-	/* Terminate the guest */
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-}
-
-static enum es_result vc_insn_string_check(struct es_em_ctxt *ctxt,
-					   unsigned long address,
-					   bool write)
-{
-	if (user_mode(ctxt->regs) && fault_in_kernel_space(address)) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = X86_PF_USER;
-		ctxt->fi.cr2        = address;
-		if (write)
-			ctxt->fi.error_code |= X86_PF_WRITE;
-
-		return ES_EXCEPTION;
-	}
-
-	return ES_OK;
-}
-
-static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
-					  void *src, char *buf,
-					  unsigned int data_size,
-					  unsigned int count,
-					  bool backwards)
-{
-	int i, b = backwards ? -1 : 1;
-	unsigned long address = (unsigned long)src;
-	enum es_result ret;
-
-	ret = vc_insn_string_check(ctxt, address, false);
-	if (ret != ES_OK)
-		return ret;
-
-	for (i = 0; i < count; i++) {
-		void *s = src + (i * data_size * b);
-		char *d = buf + (i * data_size);
-
-		ret = vc_read_mem(ctxt, s, d, data_size);
-		if (ret != ES_OK)
-			break;
-	}
-
-	return ret;
-}
-
-static enum es_result vc_insn_string_write(struct es_em_ctxt *ctxt,
-					   void *dst, char *buf,
-					   unsigned int data_size,
-					   unsigned int count,
-					   bool backwards)
-{
-	int i, s = backwards ? -1 : 1;
-	unsigned long address = (unsigned long)dst;
-	enum es_result ret;
-
-	ret = vc_insn_string_check(ctxt, address, true);
-	if (ret != ES_OK)
-		return ret;
-
-	for (i = 0; i < count; i++) {
-		void *d = dst + (i * data_size * s);
-		char *b = buf + (i * data_size);
-
-		ret = vc_write_mem(ctxt, d, b, data_size);
-		if (ret != ES_OK)
-			break;
-	}
-
-	return ret;
-}
-
-#define IOIO_TYPE_STR  BIT(2)
-#define IOIO_TYPE_IN   1
-#define IOIO_TYPE_INS  (IOIO_TYPE_IN | IOIO_TYPE_STR)
-#define IOIO_TYPE_OUT  0
-#define IOIO_TYPE_OUTS (IOIO_TYPE_OUT | IOIO_TYPE_STR)
-
-#define IOIO_REP       BIT(3)
-
-#define IOIO_ADDR_64   BIT(9)
-#define IOIO_ADDR_32   BIT(8)
-#define IOIO_ADDR_16   BIT(7)
-
-#define IOIO_DATA_32   BIT(6)
-#define IOIO_DATA_16   BIT(5)
-#define IOIO_DATA_8    BIT(4)
-
-#define IOIO_SEG_ES    (0 << 10)
-#define IOIO_SEG_DS    (3 << 10)
-
-static enum es_result vc_ioio_exitinfo(struct es_em_ctxt *ctxt, u64 *exitinfo)
-{
-	struct insn *insn = &ctxt->insn;
-	size_t size;
-	u64 port;
-
-	*exitinfo = 0;
-
-	switch (insn->opcode.bytes[0]) {
-	/* INS opcodes */
-	case 0x6c:
-	case 0x6d:
-		*exitinfo |= IOIO_TYPE_INS;
-		*exitinfo |= IOIO_SEG_ES;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	/* OUTS opcodes */
-	case 0x6e:
-	case 0x6f:
-		*exitinfo |= IOIO_TYPE_OUTS;
-		*exitinfo |= IOIO_SEG_DS;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	/* IN immediate opcodes */
-	case 0xe4:
-	case 0xe5:
-		*exitinfo |= IOIO_TYPE_IN;
-		port	   = (u8)insn->immediate.value & 0xffff;
-		break;
-
-	/* OUT immediate opcodes */
-	case 0xe6:
-	case 0xe7:
-		*exitinfo |= IOIO_TYPE_OUT;
-		port	   = (u8)insn->immediate.value & 0xffff;
-		break;
-
-	/* IN register opcodes */
-	case 0xec:
-	case 0xed:
-		*exitinfo |= IOIO_TYPE_IN;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	/* OUT register opcodes */
-	case 0xee:
-	case 0xef:
-		*exitinfo |= IOIO_TYPE_OUT;
-		port	   = ctxt->regs->dx & 0xffff;
-		break;
-
-	default:
-		return ES_DECODE_FAILED;
-	}
-
-	*exitinfo |= port << 16;
-
-	switch (insn->opcode.bytes[0]) {
-	case 0x6c:
-	case 0x6e:
-	case 0xe4:
-	case 0xe6:
-	case 0xec:
-	case 0xee:
-		/* Single byte opcodes */
-		*exitinfo |= IOIO_DATA_8;
-		size       = 1;
-		break;
-	default:
-		/* Length determined by instruction parsing */
-		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
-						     : IOIO_DATA_32;
-		size       = (insn->opnd_bytes == 2) ? 2 : 4;
-	}
-
-	switch (insn->addr_bytes) {
-	case 2:
-		*exitinfo |= IOIO_ADDR_16;
-		break;
-	case 4:
-		*exitinfo |= IOIO_ADDR_32;
-		break;
-	case 8:
-		*exitinfo |= IOIO_ADDR_64;
-		break;
-	}
-
-	if (insn_has_rep_prefix(insn))
-		*exitinfo |= IOIO_REP;
-
-	return vc_ioio_check(ctxt, (u16)port, size);
-}
-
-static enum es_result vc_handle_ioio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	u64 exit_info_1, exit_info_2;
-	enum es_result ret;
-
-	ret = vc_ioio_exitinfo(ctxt, &exit_info_1);
-	if (ret != ES_OK)
-		return ret;
-
-	if (exit_info_1 & IOIO_TYPE_STR) {
-
-		/* (REP) INS/OUTS */
-
-		bool df = ((regs->flags & X86_EFLAGS_DF) == X86_EFLAGS_DF);
-		unsigned int io_bytes, exit_bytes;
-		unsigned int ghcb_count, op_count;
-		unsigned long es_base;
-		u64 sw_scratch;
-
-		/*
-		 * For the string variants with rep prefix the amount of in/out
-		 * operations per #VC exception is limited so that the kernel
-		 * has a chance to take interrupts and re-schedule while the
-		 * instruction is emulated.
-		 */
-		io_bytes   = (exit_info_1 >> 4) & 0x7;
-		ghcb_count = sizeof(ghcb->shared_buffer) / io_bytes;
-
-		op_count    = (exit_info_1 & IOIO_REP) ? regs->cx : 1;
-		exit_info_2 = min(op_count, ghcb_count);
-		exit_bytes  = exit_info_2 * io_bytes;
-
-		es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
-
-		/* Read bytes of OUTS into the shared buffer */
-		if (!(exit_info_1 & IOIO_TYPE_IN)) {
-			ret = vc_insn_string_read(ctxt,
-					       (void *)(es_base + regs->si),
-					       ghcb->shared_buffer, io_bytes,
-					       exit_info_2, df);
-			if (ret)
-				return ret;
-		}
-
-		/*
-		 * Issue an VMGEXIT to the HV to consume the bytes from the
-		 * shared buffer or to have it write them into the shared buffer
-		 * depending on the instruction: OUTS or INS.
-		 */
-		sw_scratch = __pa(ghcb) + offsetof(struct ghcb, shared_buffer);
-		ghcb_set_sw_scratch(ghcb, sw_scratch);
-		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO,
-					  exit_info_1, exit_info_2);
-		if (ret != ES_OK)
-			return ret;
-
-		/* Read bytes from shared buffer into the guest's destination. */
-		if (exit_info_1 & IOIO_TYPE_IN) {
-			ret = vc_insn_string_write(ctxt,
-						   (void *)(es_base + regs->di),
-						   ghcb->shared_buffer, io_bytes,
-						   exit_info_2, df);
-			if (ret)
-				return ret;
-
-			if (df)
-				regs->di -= exit_bytes;
-			else
-				regs->di += exit_bytes;
-		} else {
-			if (df)
-				regs->si -= exit_bytes;
-			else
-				regs->si += exit_bytes;
-		}
-
-		if (exit_info_1 & IOIO_REP)
-			regs->cx -= exit_info_2;
-
-		ret = regs->cx ? ES_RETRY : ES_OK;
-
-	} else {
-
-		/* IN/OUT into/from rAX */
-
-		int bits = (exit_info_1 & 0x70) >> 1;
-		u64 rax = 0;
-
-		if (!(exit_info_1 & IOIO_TYPE_IN))
-			rax = lower_bits(regs->ax, bits);
-
-		ghcb_set_rax(ghcb, rax);
-
-		ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_IOIO, exit_info_1, 0);
-		if (ret != ES_OK)
-			return ret;
-
-		if (exit_info_1 & IOIO_TYPE_IN) {
-			if (!ghcb_rax_is_valid(ghcb))
-				return ES_VMM_ERROR;
-			regs->ax = lower_bits(ghcb->save.rax, bits);
-		}
-	}
-
-	return ret;
-}
-
-static int vc_handle_cpuid_snp(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	struct cpuid_leaf leaf;
-	int ret;
-
-	leaf.fn = regs->ax;
-	leaf.subfn = regs->cx;
-	ret = snp_cpuid(ghcb, ctxt, &leaf);
-	if (!ret) {
-		regs->ax = leaf.eax;
-		regs->bx = leaf.ebx;
-		regs->cx = leaf.ecx;
-		regs->dx = leaf.edx;
-	}
-
-	return ret;
-}
-
-static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	u32 cr4 = native_read_cr4();
-	enum es_result ret;
-	int snp_cpuid_ret;
-
-	snp_cpuid_ret = vc_handle_cpuid_snp(ghcb, ctxt);
-	if (!snp_cpuid_ret)
-		return ES_OK;
-	if (snp_cpuid_ret != -EOPNOTSUPP)
-		return ES_VMM_ERROR;
-
-	ghcb_set_rax(ghcb, regs->ax);
-	ghcb_set_rcx(ghcb, regs->cx);
-
-	if (cr4 & X86_CR4_OSXSAVE)
-		/* Safe to read xcr0 */
-		ghcb_set_xcr0(ghcb, xgetbv(XCR_XFEATURE_ENABLED_MASK));
-	else
-		/* xgetbv will cause #GP - use reset value for xcr0 */
-		ghcb_set_xcr0(ghcb, 1);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_CPUID, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) &&
-	      ghcb_rbx_is_valid(ghcb) &&
-	      ghcb_rcx_is_valid(ghcb) &&
-	      ghcb_rdx_is_valid(ghcb)))
-		return ES_VMM_ERROR;
-
-	regs->ax = ghcb->save.rax;
-	regs->bx = ghcb->save.rbx;
-	regs->cx = ghcb->save.rcx;
-	regs->dx = ghcb->save.rdx;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_rdtsc(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt,
-				      unsigned long exit_code)
-{
-	bool rdtscp = (exit_code == SVM_EXIT_RDTSCP);
-	enum es_result ret;
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb) &&
-	     (!rdtscp || ghcb_rcx_is_valid(ghcb))))
-		return ES_VMM_ERROR;
-
-	ctxt->regs->ax = ghcb->save.rax;
-	ctxt->regs->dx = ghcb->save.rdx;
-	if (rdtscp)
-		ctxt->regs->cx = ghcb->save.rcx;
-
-	return ES_OK;
-}
-
-struct cc_setup_data {
-	struct setup_data header;
-	u32 cc_blob_address;
-};
-
-/*
- * Search for a Confidential Computing blob passed in as a setup_data entry
- * via the Linux Boot Protocol.
- */
-static __head
-struct cc_blob_sev_info *find_cc_blob_setup_data(struct boot_params *bp)
-{
-	struct cc_setup_data *sd = NULL;
-	struct setup_data *hdr;
-
-	hdr = (struct setup_data *)bp->hdr.setup_data;
-
-	while (hdr) {
-		if (hdr->type == SETUP_CC_BLOB) {
-			sd = (struct cc_setup_data *)hdr;
-			return (struct cc_blob_sev_info *)(unsigned long)sd->cc_blob_address;
-		}
-		hdr = (struct setup_data *)hdr->next;
-	}
-
-	return NULL;
-}
-
-/*
- * Initialize the kernel's copy of the SNP CPUID table, and set up the
- * pointer that will be used to access it.
- *
- * Maintaining a direct mapping of the SNP CPUID table used by firmware would
- * be possible as an alternative, but the approach is brittle since the
- * mapping needs to be updated in sync with all the changes to virtual memory
- * layout and related mapping facilities throughout the boot process.
- */
-static void __head setup_cpuid_table(const struct cc_blob_sev_info *cc_info)
-{
-	const struct snp_cpuid_table *cpuid_table_fw, *cpuid_table;
-	int i;
-
-	if (!cc_info || !cc_info->cpuid_phys || cc_info->cpuid_len < PAGE_SIZE)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_table_fw = (const struct snp_cpuid_table *)cc_info->cpuid_phys;
-	if (!cpuid_table_fw->count || cpuid_table_fw->count > SNP_CPUID_COUNT_MAX)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_CPUID);
-
-	cpuid_table = snp_cpuid_get_table();
-	memcpy((void *)cpuid_table, cpuid_table_fw, sizeof(*cpuid_table));
-
-	/* Initialize CPUID ranges for range-checking. */
-	for (i = 0; i < cpuid_table->count; i++) {
-		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
-
-		if (fn->eax_in == 0x0)
-			RIP_REL_REF(cpuid_std_range_max) = fn->eax;
-		else if (fn->eax_in == 0x40000000)
-			RIP_REL_REF(cpuid_hyp_range_max) = fn->eax;
-		else if (fn->eax_in == 0x80000000)
-			RIP_REL_REF(cpuid_ext_range_max) = fn->eax;
-	}
-}
-
-static inline void __pval_terminate(u64 pfn, bool action, unsigned int page_size,
-				    int ret, u64 svsm_ret)
-{
-	WARN(1, "PVALIDATE failure: pfn: 0x%llx, action: %u, size: %u, ret: %d, svsm_ret: 0x%llx\n",
-	     pfn, action, page_size, ret, svsm_ret);
-
-	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PVALIDATE);
-}
-
-static void svsm_pval_terminate(struct svsm_pvalidate_call *pc, int ret, u64 svsm_ret)
-{
-	unsigned int page_size;
-	bool action;
-	u64 pfn;
-
-	pfn = pc->entry[pc->cur_index].pfn;
-	action = pc->entry[pc->cur_index].action;
-	page_size = pc->entry[pc->cur_index].page_size;
-
-	__pval_terminate(pfn, action, page_size, ret, svsm_ret);
-}
-
-static void svsm_pval_4k_page(unsigned long paddr, bool validate)
-{
-	struct svsm_pvalidate_call *pc;
-	struct svsm_call call = {};
-	unsigned long flags;
-	u64 pc_pa;
-	int ret;
-
-	/*
-	 * This can be called very early in the boot, use native functions in
-	 * order to avoid paravirt issues.
-	 */
-	flags = native_local_irq_save();
-
-	call.caa = svsm_get_caa();
-
-	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
-
-	pc->num_entries = 1;
-	pc->cur_index   = 0;
-	pc->entry[0].page_size = RMP_PG_SIZE_4K;
-	pc->entry[0].action    = validate;
-	pc->entry[0].ignore_cf = 0;
-	pc->entry[0].pfn       = paddr >> PAGE_SHIFT;
-
-	/* Protocol 0, Call ID 1 */
-	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
-	call.rcx = pc_pa;
-
-	ret = svsm_perform_call_protocol(&call);
-	if (ret)
-		svsm_pval_terminate(pc, ret, call.rax_out);
-
-	native_local_irq_restore(flags);
-}
-
-static void pvalidate_4k_page(unsigned long vaddr, unsigned long paddr, bool validate)
-{
-	int ret;
-
-	/*
-	 * This can be called very early during boot, so use rIP-relative
-	 * references as needed.
-	 */
-	if (RIP_REL_REF(snp_vmpl)) {
-		svsm_pval_4k_page(paddr, validate);
-	} else {
-		ret = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
-		if (ret)
-			__pval_terminate(PHYS_PFN(paddr), validate, RMP_PG_SIZE_4K, ret, 0);
-	}
-}
-
-static void pval_pages(struct snp_psc_desc *desc)
-{
-	struct psc_entry *e;
-	unsigned long vaddr;
-	unsigned int size;
-	unsigned int i;
-	bool validate;
-	u64 pfn;
-	int rc;
-
-	for (i = 0; i <= desc->hdr.end_entry; i++) {
-		e = &desc->entries[i];
-
-		pfn = e->gfn;
-		vaddr = (unsigned long)pfn_to_kaddr(pfn);
-		size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
-		validate = e->operation == SNP_PAGE_STATE_PRIVATE;
-
-		rc = pvalidate(vaddr, size, validate);
-		if (!rc)
-			continue;
-
-		if (rc == PVALIDATE_FAIL_SIZEMISMATCH && size == RMP_PG_SIZE_2M) {
-			unsigned long vaddr_end = vaddr + PMD_SIZE;
-
-			for (; vaddr < vaddr_end; vaddr += PAGE_SIZE, pfn++) {
-				rc = pvalidate(vaddr, RMP_PG_SIZE_4K, validate);
-				if (rc)
-					__pval_terminate(pfn, validate, RMP_PG_SIZE_4K, rc, 0);
-			}
-		} else {
-			__pval_terminate(pfn, validate, size, rc, 0);
-		}
-	}
-}
-
-static u64 svsm_build_ca_from_pfn_range(u64 pfn, u64 pfn_end, bool action,
-					struct svsm_pvalidate_call *pc)
-{
-	struct svsm_pvalidate_entry *pe;
-
-	/* Nothing in the CA yet */
-	pc->num_entries = 0;
-	pc->cur_index   = 0;
-
-	pe = &pc->entry[0];
-
-	while (pfn < pfn_end) {
-		pe->page_size = RMP_PG_SIZE_4K;
-		pe->action    = action;
-		pe->ignore_cf = 0;
-		pe->pfn       = pfn;
-
-		pe++;
-		pfn++;
-
-		pc->num_entries++;
-		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
-			break;
-	}
-
-	return pfn;
-}
-
-static int svsm_build_ca_from_psc_desc(struct snp_psc_desc *desc, unsigned int desc_entry,
-				       struct svsm_pvalidate_call *pc)
-{
-	struct svsm_pvalidate_entry *pe;
-	struct psc_entry *e;
-
-	/* Nothing in the CA yet */
-	pc->num_entries = 0;
-	pc->cur_index   = 0;
-
-	pe = &pc->entry[0];
-	e  = &desc->entries[desc_entry];
-
-	while (desc_entry <= desc->hdr.end_entry) {
-		pe->page_size = e->pagesize ? RMP_PG_SIZE_2M : RMP_PG_SIZE_4K;
-		pe->action    = e->operation == SNP_PAGE_STATE_PRIVATE;
-		pe->ignore_cf = 0;
-		pe->pfn       = e->gfn;
-
-		pe++;
-		e++;
-
-		desc_entry++;
-		pc->num_entries++;
-		if (pc->num_entries == SVSM_PVALIDATE_MAX_COUNT)
-			break;
-	}
-
-	return desc_entry;
-}
-
-static void svsm_pval_pages(struct snp_psc_desc *desc)
-{
-	struct svsm_pvalidate_entry pv_4k[VMGEXIT_PSC_MAX_ENTRY];
-	unsigned int i, pv_4k_count = 0;
-	struct svsm_pvalidate_call *pc;
-	struct svsm_call call = {};
-	unsigned long flags;
-	bool action;
-	u64 pc_pa;
-	int ret;
-
-	/*
-	 * This can be called very early in the boot, use native functions in
-	 * order to avoid paravirt issues.
-	 */
-	flags = native_local_irq_save();
-
-	/*
-	 * The SVSM calling area (CA) can support processing 510 entries at a
-	 * time. Loop through the Page State Change descriptor until the CA is
-	 * full or the last entry in the descriptor is reached, at which time
-	 * the SVSM is invoked. This repeats until all entries in the descriptor
-	 * are processed.
-	 */
-	call.caa = svsm_get_caa();
-
-	pc = (struct svsm_pvalidate_call *)call.caa->svsm_buffer;
-	pc_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
-
-	/* Protocol 0, Call ID 1 */
-	call.rax = SVSM_CORE_CALL(SVSM_CORE_PVALIDATE);
-	call.rcx = pc_pa;
-
-	for (i = 0; i <= desc->hdr.end_entry;) {
-		i = svsm_build_ca_from_psc_desc(desc, i, pc);
-
-		do {
-			ret = svsm_perform_call_protocol(&call);
-			if (!ret)
-				continue;
-
-			/*
-			 * Check if the entry failed because of an RMP mismatch (a
-			 * PVALIDATE at 2M was requested, but the page is mapped in
-			 * the RMP as 4K).
-			 */
-
-			if (call.rax_out == SVSM_PVALIDATE_FAIL_SIZEMISMATCH &&
-			    pc->entry[pc->cur_index].page_size == RMP_PG_SIZE_2M) {
-				/* Save this entry for post-processing at 4K */
-				pv_4k[pv_4k_count++] = pc->entry[pc->cur_index];
-
-				/* Skip to the next one unless at the end of the list */
-				pc->cur_index++;
-				if (pc->cur_index < pc->num_entries)
-					ret = -EAGAIN;
-				else
-					ret = 0;
-			}
-		} while (ret == -EAGAIN);
-
-		if (ret)
-			svsm_pval_terminate(pc, ret, call.rax_out);
-	}
-
-	/* Process any entries that failed to be validated at 2M and validate them at 4K */
-	for (i = 0; i < pv_4k_count; i++) {
-		u64 pfn, pfn_end;
-
-		action  = pv_4k[i].action;
-		pfn     = pv_4k[i].pfn;
-		pfn_end = pfn + 512;
-
-		while (pfn < pfn_end) {
-			pfn = svsm_build_ca_from_pfn_range(pfn, pfn_end, action, pc);
-
-			ret = svsm_perform_call_protocol(&call);
-			if (ret)
-				svsm_pval_terminate(pc, ret, call.rax_out);
-		}
-	}
-
-	native_local_irq_restore(flags);
-}
-
-static void pvalidate_pages(struct snp_psc_desc *desc)
-{
-	if (snp_vmpl)
-		svsm_pval_pages(desc);
-	else
-		pval_pages(desc);
-}
-
-static int vmgexit_psc(struct ghcb *ghcb, struct snp_psc_desc *desc)
-{
-	int cur_entry, end_entry, ret = 0;
-	struct snp_psc_desc *data;
-	struct es_em_ctxt ctxt;
-
-	vc_ghcb_invalidate(ghcb);
-
-	/* Copy the input desc into GHCB shared buffer */
-	data = (struct snp_psc_desc *)ghcb->shared_buffer;
-	memcpy(ghcb->shared_buffer, desc, min_t(int, GHCB_SHARED_BUF_SIZE, sizeof(*desc)));
-
-	/*
-	 * As per the GHCB specification, the hypervisor can resume the guest
-	 * before processing all the entries. Check whether all the entries
-	 * are processed. If not, then keep retrying. Note, the hypervisor
-	 * will update the data memory directly to indicate the status, so
-	 * reference the data->hdr everywhere.
-	 *
-	 * The strategy here is to wait for the hypervisor to change the page
-	 * state in the RMP table before guest accesses the memory pages. If the
-	 * page state change was not successful, then later memory access will
-	 * result in a crash.
-	 */
-	cur_entry = data->hdr.cur_entry;
-	end_entry = data->hdr.end_entry;
-
-	while (data->hdr.cur_entry <= data->hdr.end_entry) {
-		ghcb_set_sw_scratch(ghcb, (u64)__pa(data));
-
-		/* This will advance the shared buffer data points to. */
-		ret = sev_es_ghcb_hv_call(ghcb, &ctxt, SVM_VMGEXIT_PSC, 0, 0);
-
-		/*
-		 * Page State Change VMGEXIT can pass error code through
-		 * exit_info_2.
-		 */
-		if (WARN(ret || ghcb->save.sw_exit_info_2,
-			 "SNP: PSC failed ret=%d exit_info_2=%llx\n",
-			 ret, ghcb->save.sw_exit_info_2)) {
-			ret = 1;
-			goto out;
-		}
-
-		/* Verify that reserved bit is not set */
-		if (WARN(data->hdr.reserved, "Reserved bit is set in the PSC header\n")) {
-			ret = 1;
-			goto out;
-		}
-
-		/*
-		 * Sanity check that entry processing is not going backwards.
-		 * This will happen only if hypervisor is tricking us.
-		 */
-		if (WARN(data->hdr.end_entry > end_entry || cur_entry > data->hdr.cur_entry,
-"SNP: PSC processing going backward, end_entry %d (got %d) cur_entry %d (got %d)\n",
-			 end_entry, data->hdr.end_entry, cur_entry, data->hdr.cur_entry)) {
-			ret = 1;
-			goto out;
-		}
-	}
-
-out:
-	return ret;
-}
-
-static enum es_result vc_check_opcode_bytes(struct es_em_ctxt *ctxt,
-					    unsigned long exit_code)
-{
-	unsigned int opcode = (unsigned int)ctxt->insn.opcode.value;
-	u8 modrm = ctxt->insn.modrm.value;
-
-	switch (exit_code) {
-
-	case SVM_EXIT_IOIO:
-	case SVM_EXIT_NPF:
-		/* handled separately */
-		return ES_OK;
-
-	case SVM_EXIT_CPUID:
-		if (opcode == 0xa20f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_INVD:
-		if (opcode == 0x080f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_MONITOR:
-		/* MONITOR and MONITORX instructions generate the same error code */
-		if (opcode == 0x010f && (modrm == 0xc8 || modrm == 0xfa))
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_MWAIT:
-		/* MWAIT and MWAITX instructions generate the same error code */
-		if (opcode == 0x010f && (modrm == 0xc9 || modrm == 0xfb))
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_MSR:
-		/* RDMSR */
-		if (opcode == 0x320f ||
-		/* WRMSR */
-		    opcode == 0x300f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_RDPMC:
-		if (opcode == 0x330f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_RDTSC:
-		if (opcode == 0x310f)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_RDTSCP:
-		if (opcode == 0x010f && modrm == 0xf9)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_READ_DR7:
-		if (opcode == 0x210f &&
-		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_VMMCALL:
-		if (opcode == 0x010f && modrm == 0xd9)
-			return ES_OK;
-
-		break;
-
-	case SVM_EXIT_WRITE_DR7:
-		if (opcode == 0x230f &&
-		    X86_MODRM_REG(ctxt->insn.modrm.value) == 7)
-			return ES_OK;
-		break;
-
-	case SVM_EXIT_WBINVD:
-		if (opcode == 0x90f)
-			return ES_OK;
-		break;
-
-	default:
-		break;
-	}
-
-	sev_printk(KERN_ERR "Wrong/unhandled opcode bytes: 0x%x, exit_code: 0x%lx, rIP: 0x%lx\n",
-		   opcode, exit_code, ctxt->regs->ip);
-
-	return ES_UNSUPPORTED;
-}
-
-/*
- * Maintain the GPA of the SVSM Calling Area (CA) in order to utilize the SVSM
- * services needed when not running in VMPL0.
- */
-static bool __head svsm_setup_ca(const struct cc_blob_sev_info *cc_info)
-{
-	struct snp_secrets_page *secrets_page;
-	struct snp_cpuid_table *cpuid_table;
-	unsigned int i;
-	u64 caa;
-
-	BUILD_BUG_ON(sizeof(*secrets_page) != PAGE_SIZE);
-
-	/*
-	 * Check if running at VMPL0.
-	 *
-	 * Use RMPADJUST (see the rmpadjust() function for a description of what
-	 * the instruction does) to update the VMPL1 permissions of a page. If
-	 * the guest is running at VMPL0, this will succeed and implies there is
-	 * no SVSM. If the guest is running at any other VMPL, this will fail.
-	 * Linux SNP guests only ever run at a single VMPL level so permission mask
-	 * changes of a lesser-privileged VMPL are a don't-care.
-	 *
-	 * Use a rip-relative reference to obtain the proper address, since this
-	 * routine is running identity mapped when called, both by the decompressor
-	 * code and the early kernel code.
-	 */
-	if (!rmpadjust((unsigned long)&RIP_REL_REF(boot_ghcb_page), RMP_PG_SIZE_4K, 1))
-		return false;
-
-	/*
-	 * Not running at VMPL0, ensure everything has been properly supplied
-	 * for running under an SVSM.
-	 */
-	if (!cc_info || !cc_info->secrets_phys || cc_info->secrets_len != PAGE_SIZE)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SECRETS_PAGE);
-
-	secrets_page = (struct snp_secrets_page *)cc_info->secrets_phys;
-	if (!secrets_page->svsm_size)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_NO_SVSM);
-
-	if (!secrets_page->svsm_guest_vmpl)
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_VMPL0);
-
-	RIP_REL_REF(snp_vmpl) = secrets_page->svsm_guest_vmpl;
-
-	caa = secrets_page->svsm_caa;
-
-	/*
-	 * An open-coded PAGE_ALIGNED() in order to avoid including
-	 * kernel-proper headers into the decompressor.
-	 */
-	if (caa & (PAGE_SIZE - 1))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_SVSM_CAA);
-
-	/*
-	 * The CA is identity mapped when this routine is called, both by the
-	 * decompressor code and the early kernel code.
-	 */
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)caa;
-	RIP_REL_REF(boot_svsm_caa_pa) = caa;
-
-	/* Advertise the SVSM presence via CPUID. */
-	cpuid_table = (struct snp_cpuid_table *)snp_cpuid_get_table();
-	for (i = 0; i < cpuid_table->count; i++) {
-		struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
-
-		if (fn->eax_in == 0x8000001f)
-			fn->eax |= BIT(28);
-	}
-
-	return true;
-}
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
deleted file mode 100644
index 726d9df..0000000
--- a/arch/x86/kernel/sev.c
+++ /dev/null
@@ -1,2606 +0,0 @@
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
-#include <linux/sched/debug.h>	/* For show_regs() */
-#include <linux/percpu-defs.h>
-#include <linux/cc_platform.h>
-#include <linux/printk.h>
-#include <linux/mm_types.h>
-#include <linux/set_memory.h>
-#include <linux/memblock.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/cpumask.h>
-#include <linux/efi.h>
-#include <linux/platform_device.h>
-#include <linux/io.h>
-#include <linux/psp-sev.h>
-#include <linux/dmi.h>
-#include <uapi/linux/sev-guest.h>
-
-#include <asm/init.h>
-#include <asm/cpu_entry_area.h>
-#include <asm/stacktrace.h>
-#include <asm/sev.h>
-#include <asm/insn-eval.h>
-#include <asm/fpu/xcr.h>
-#include <asm/processor.h>
-#include <asm/realmode.h>
-#include <asm/setup.h>
-#include <asm/traps.h>
-#include <asm/svm.h>
-#include <asm/smp.h>
-#include <asm/cpu.h>
-#include <asm/apic.h>
-#include <asm/cpuid.h>
-#include <asm/cmdline.h>
-
-#define DR7_RESET_VALUE        0x400
-
-/* AP INIT values as documented in the APM2  section "Processor Initialization State" */
-#define AP_INIT_CS_LIMIT		0xffff
-#define AP_INIT_DS_LIMIT		0xffff
-#define AP_INIT_LDTR_LIMIT		0xffff
-#define AP_INIT_GDTR_LIMIT		0xffff
-#define AP_INIT_IDTR_LIMIT		0xffff
-#define AP_INIT_TR_LIMIT		0xffff
-#define AP_INIT_RFLAGS_DEFAULT		0x2
-#define AP_INIT_DR6_DEFAULT		0xffff0ff0
-#define AP_INIT_GPAT_DEFAULT		0x0007040600070406ULL
-#define AP_INIT_XCR0_DEFAULT		0x1
-#define AP_INIT_X87_FTW_DEFAULT		0x5555
-#define AP_INIT_X87_FCW_DEFAULT		0x0040
-#define AP_INIT_CR0_DEFAULT		0x60000010
-#define AP_INIT_MXCSR_DEFAULT		0x1f80
-
-static const char * const sev_status_feat_names[] = {
-	[MSR_AMD64_SEV_ENABLED_BIT]		= "SEV",
-	[MSR_AMD64_SEV_ES_ENABLED_BIT]		= "SEV-ES",
-	[MSR_AMD64_SEV_SNP_ENABLED_BIT]		= "SEV-SNP",
-	[MSR_AMD64_SNP_VTOM_BIT]		= "vTom",
-	[MSR_AMD64_SNP_REFLECT_VC_BIT]		= "ReflectVC",
-	[MSR_AMD64_SNP_RESTRICTED_INJ_BIT]	= "RI",
-	[MSR_AMD64_SNP_ALT_INJ_BIT]		= "AI",
-	[MSR_AMD64_SNP_DEBUG_SWAP_BIT]		= "DebugSwap",
-	[MSR_AMD64_SNP_PREVENT_HOST_IBS_BIT]	= "NoHostIBS",
-	[MSR_AMD64_SNP_BTB_ISOLATION_BIT]	= "BTBIsol",
-	[MSR_AMD64_SNP_VMPL_SSS_BIT]		= "VmplSSS",
-	[MSR_AMD64_SNP_SECURE_TSC_BIT]		= "SecureTSC",
-	[MSR_AMD64_SNP_VMGEXIT_PARAM_BIT]	= "VMGExitParam",
-	[MSR_AMD64_SNP_IBS_VIRT_BIT]		= "IBSVirt",
-	[MSR_AMD64_SNP_VMSA_REG_PROT_BIT]	= "VMSARegProt",
-	[MSR_AMD64_SNP_SMT_PROT_BIT]		= "SMTProt",
-};
-
-/* For early boot hypervisor communication in SEV-ES enabled guests */
-static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-
-/*
- * Needs to be in the .data section because we need it NULL before bss is
- * cleared
- */
-static struct ghcb *boot_ghcb __section(".data");
-
-/* Bitmap of SEV features supported by the hypervisor */
-static u64 sev_hv_features __ro_after_init;
-
-/* #VC handler runtime per-CPU data */
-struct sev_es_runtime_data {
-	struct ghcb ghcb_page;
-
-	/*
-	 * Reserve one page per CPU as backup storage for the unencrypted GHCB.
-	 * It is needed when an NMI happens while the #VC handler uses the real
-	 * GHCB, and the NMI handler itself is causing another #VC exception. In
-	 * that case the GHCB content of the first handler needs to be backed up
-	 * and restored.
-	 */
-	struct ghcb backup_ghcb;
-
-	/*
-	 * Mark the per-cpu GHCBs as in-use to detect nested #VC exceptions.
-	 * There is no need for it to be atomic, because nothing is written to
-	 * the GHCB between the read and the write of ghcb_active. So it is safe
-	 * to use it when a nested #VC exception happens before the write.
-	 *
-	 * This is necessary for example in the #VC->NMI->#VC case when the NMI
-	 * happens while the first #VC handler uses the GHCB. When the NMI code
-	 * raises a second #VC handler it might overwrite the contents of the
-	 * GHCB written by the first handler. To avoid this the content of the
-	 * GHCB is saved and restored when the GHCB is detected to be in use
-	 * already.
-	 */
-	bool ghcb_active;
-	bool backup_ghcb_active;
-
-	/*
-	 * Cached DR7 value - write it on DR7 writes and return it on reads.
-	 * That value will never make it to the real hardware DR7 as debugging
-	 * is currently unsupported in SEV-ES guests.
-	 */
-	unsigned long dr7;
-};
-
-struct ghcb_state {
-	struct ghcb *ghcb;
-};
-
-/* For early boot SVSM communication */
-static struct svsm_ca boot_svsm_ca_page __aligned(PAGE_SIZE);
-
-static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
-static DEFINE_PER_CPU(struct sev_es_save_area *, sev_vmsa);
-static DEFINE_PER_CPU(struct svsm_ca *, svsm_caa);
-static DEFINE_PER_CPU(u64, svsm_caa_pa);
-
-struct sev_config {
-	__u64 debug		: 1,
-
-	      /*
-	       * Indicates when the per-CPU GHCB has been created and registered
-	       * and thus can be used by the BSP instead of the early boot GHCB.
-	       *
-	       * For APs, the per-CPU GHCB is created before they are started
-	       * and registered upon startup, so this flag can be used globally
-	       * for the BSP and APs.
-	       */
-	      ghcbs_initialized	: 1,
-
-	      /*
-	       * Indicates when the per-CPU SVSM CA is to be used instead of the
-	       * boot SVSM CA.
-	       *
-	       * For APs, the per-CPU SVSM CA is created as part of the AP
-	       * bringup, so this flag can be used globally for the BSP and APs.
-	       */
-	      use_cas		: 1,
-
-	      __reserved	: 62;
-};
-
-static struct sev_config sev_cfg __read_mostly;
-
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
-/*
- * Nothing shall interrupt this code path while holding the per-CPU
- * GHCB. The backup GHCB is only for NMIs interrupting this path.
- *
- * Callers must disable local interrupts around it.
- */
-static noinstr struct ghcb *__sev_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
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
-			data->ghcb_active        = false;
-			data->backup_ghcb_active = false;
-
-			instrumentation_begin();
-			panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-			instrumentation_end();
-		}
-
-		/* Mark backup_ghcb active before writing to it */
-		data->backup_ghcb_active = true;
-
-		state->ghcb = &data->backup_ghcb;
-
-		/* Backup GHCB content */
-		*state->ghcb = *ghcb;
-	} else {
-		state->ghcb = NULL;
-		data->ghcb_active = true;
-	}
-
-	return ghcb;
-}
-
-static inline u64 sev_es_rd_ghcb_msr(void)
-{
-	return __rdmsr(MSR_AMD64_SEV_ES_GHCB);
-}
-
-static __always_inline void sev_es_wr_ghcb_msr(u64 val)
-{
-	u32 low, high;
-
-	low  = (u32)(val);
-	high = (u32)(val >> 32);
-
-	native_wrmsr(MSR_AMD64_SEV_ES_GHCB, low, high);
-}
-
-static int vc_fetch_insn_kernel(struct es_em_ctxt *ctxt,
-				unsigned char *buffer)
-{
-	return copy_from_kernel_nofault(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
-}
-
-static enum es_result __vc_decode_user_insn(struct es_em_ctxt *ctxt)
-{
-	char buffer[MAX_INSN_SIZE];
-	int insn_bytes;
-
-	insn_bytes = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (insn_bytes == 0) {
-		/* Nothing could be copied */
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
-		ctxt->fi.cr2        = ctxt->regs->ip;
-		return ES_EXCEPTION;
-	} else if (insn_bytes == -EINVAL) {
-		/* Effective RIP could not be calculated */
-		ctxt->fi.vector     = X86_TRAP_GP;
-		ctxt->fi.error_code = 0;
-		ctxt->fi.cr2        = 0;
-		return ES_EXCEPTION;
-	}
-
-	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, insn_bytes))
-		return ES_DECODE_FAILED;
-
-	if (ctxt->insn.immediate.got)
-		return ES_OK;
-	else
-		return ES_DECODE_FAILED;
-}
-
-static enum es_result __vc_decode_kern_insn(struct es_em_ctxt *ctxt)
-{
-	char buffer[MAX_INSN_SIZE];
-	int res, ret;
-
-	res = vc_fetch_insn_kernel(ctxt, buffer);
-	if (res) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = X86_PF_INSTR;
-		ctxt->fi.cr2        = ctxt->regs->ip;
-		return ES_EXCEPTION;
-	}
-
-	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
-	if (ret < 0)
-		return ES_DECODE_FAILED;
-	else
-		return ES_OK;
-}
-
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
-{
-	if (user_mode(ctxt->regs))
-		return __vc_decode_user_insn(ctxt);
-	else
-		return __vc_decode_kern_insn(ctxt);
-}
-
-static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
-				   char *dst, char *buf, size_t size)
-{
-	unsigned long error_code = X86_PF_PROT | X86_PF_WRITE;
-
-	/*
-	 * This function uses __put_user() independent of whether kernel or user
-	 * memory is accessed. This works fine because __put_user() does no
-	 * sanity checks of the pointer being accessed. All that it does is
-	 * to report when the access failed.
-	 *
-	 * Also, this function runs in atomic context, so __put_user() is not
-	 * allowed to sleep. The page-fault handler detects that it is running
-	 * in atomic context and will not try to take mmap_sem and handle the
-	 * fault, so additional pagefault_enable()/disable() calls are not
-	 * needed.
-	 *
-	 * The access can't be done via copy_to_user() here because
-	 * vc_write_mem() must not use string instructions to access unsafe
-	 * memory. The reason is that MOVS is emulated by the #VC handler by
-	 * splitting the move up into a read and a write and taking a nested #VC
-	 * exception on whatever of them is the MMIO access. Using string
-	 * instructions here would cause infinite nesting.
-	 */
-	switch (size) {
-	case 1: {
-		u8 d1;
-		u8 __user *target = (u8 __user *)dst;
-
-		memcpy(&d1, buf, 1);
-		if (__put_user(d1, target))
-			goto fault;
-		break;
-	}
-	case 2: {
-		u16 d2;
-		u16 __user *target = (u16 __user *)dst;
-
-		memcpy(&d2, buf, 2);
-		if (__put_user(d2, target))
-			goto fault;
-		break;
-	}
-	case 4: {
-		u32 d4;
-		u32 __user *target = (u32 __user *)dst;
-
-		memcpy(&d4, buf, 4);
-		if (__put_user(d4, target))
-			goto fault;
-		break;
-	}
-	case 8: {
-		u64 d8;
-		u64 __user *target = (u64 __user *)dst;
-
-		memcpy(&d8, buf, 8);
-		if (__put_user(d8, target))
-			goto fault;
-		break;
-	}
-	default:
-		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
-		return ES_UNSUPPORTED;
-	}
-
-	return ES_OK;
-
-fault:
-	if (user_mode(ctxt->regs))
-		error_code |= X86_PF_USER;
-
-	ctxt->fi.vector = X86_TRAP_PF;
-	ctxt->fi.error_code = error_code;
-	ctxt->fi.cr2 = (unsigned long)dst;
-
-	return ES_EXCEPTION;
-}
-
-static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
-				  char *src, char *buf, size_t size)
-{
-	unsigned long error_code = X86_PF_PROT;
-
-	/*
-	 * This function uses __get_user() independent of whether kernel or user
-	 * memory is accessed. This works fine because __get_user() does no
-	 * sanity checks of the pointer being accessed. All that it does is
-	 * to report when the access failed.
-	 *
-	 * Also, this function runs in atomic context, so __get_user() is not
-	 * allowed to sleep. The page-fault handler detects that it is running
-	 * in atomic context and will not try to take mmap_sem and handle the
-	 * fault, so additional pagefault_enable()/disable() calls are not
-	 * needed.
-	 *
-	 * The access can't be done via copy_from_user() here because
-	 * vc_read_mem() must not use string instructions to access unsafe
-	 * memory. The reason is that MOVS is emulated by the #VC handler by
-	 * splitting the move up into a read and a write and taking a nested #VC
-	 * exception on whatever of them is the MMIO access. Using string
-	 * instructions here would cause infinite nesting.
-	 */
-	switch (size) {
-	case 1: {
-		u8 d1;
-		u8 __user *s = (u8 __user *)src;
-
-		if (__get_user(d1, s))
-			goto fault;
-		memcpy(buf, &d1, 1);
-		break;
-	}
-	case 2: {
-		u16 d2;
-		u16 __user *s = (u16 __user *)src;
-
-		if (__get_user(d2, s))
-			goto fault;
-		memcpy(buf, &d2, 2);
-		break;
-	}
-	case 4: {
-		u32 d4;
-		u32 __user *s = (u32 __user *)src;
-
-		if (__get_user(d4, s))
-			goto fault;
-		memcpy(buf, &d4, 4);
-		break;
-	}
-	case 8: {
-		u64 d8;
-		u64 __user *s = (u64 __user *)src;
-		if (__get_user(d8, s))
-			goto fault;
-		memcpy(buf, &d8, 8);
-		break;
-	}
-	default:
-		WARN_ONCE(1, "%s: Invalid size: %zu\n", __func__, size);
-		return ES_UNSUPPORTED;
-	}
-
-	return ES_OK;
-
-fault:
-	if (user_mode(ctxt->regs))
-		error_code |= X86_PF_USER;
-
-	ctxt->fi.vector = X86_TRAP_PF;
-	ctxt->fi.error_code = error_code;
-	ctxt->fi.cr2 = (unsigned long)src;
-
-	return ES_EXCEPTION;
-}
-
-static enum es_result vc_slow_virt_to_phys(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-					   unsigned long vaddr, phys_addr_t *paddr)
-{
-	unsigned long va = (unsigned long)vaddr;
-	unsigned int level;
-	phys_addr_t pa;
-	pgd_t *pgd;
-	pte_t *pte;
-
-	pgd = __va(read_cr3_pa());
-	pgd = &pgd[pgd_index(va)];
-	pte = lookup_address_in_pgd(pgd, va, &level);
-	if (!pte) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.cr2        = vaddr;
-		ctxt->fi.error_code = 0;
-
-		if (user_mode(ctxt->regs))
-			ctxt->fi.error_code |= X86_PF_USER;
-
-		return ES_EXCEPTION;
-	}
-
-	if (WARN_ON_ONCE(pte_val(*pte) & _PAGE_ENC))
-		/* Emulated MMIO to/from encrypted memory not supported */
-		return ES_UNSUPPORTED;
-
-	pa = (phys_addr_t)pte_pfn(*pte) << PAGE_SHIFT;
-	pa |= va & ~page_level_mask(level);
-
-	*paddr = pa;
-
-	return ES_OK;
-}
-
-static enum es_result vc_ioio_check(struct es_em_ctxt *ctxt, u16 port, size_t size)
-{
-	BUG_ON(size > 4);
-
-	if (user_mode(ctxt->regs)) {
-		struct thread_struct *t = &current->thread;
-		struct io_bitmap *iobm = t->io_bitmap;
-		size_t idx;
-
-		if (!iobm)
-			goto fault;
-
-		for (idx = port; idx < port + size; ++idx) {
-			if (test_bit(idx, iobm->bitmap))
-				goto fault;
-		}
-	}
-
-	return ES_OK;
-
-fault:
-	ctxt->fi.vector = X86_TRAP_GP;
-	ctxt->fi.error_code = 0;
-
-	return ES_EXCEPTION;
-}
-
-static __always_inline void vc_forward_exception(struct es_em_ctxt *ctxt)
-{
-	long error_code = ctxt->fi.error_code;
-	int trapnr = ctxt->fi.vector;
-
-	ctxt->regs->orig_ax = ctxt->fi.error_code;
-
-	switch (trapnr) {
-	case X86_TRAP_GP:
-		exc_general_protection(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_UD:
-		exc_invalid_op(ctxt->regs);
-		break;
-	case X86_TRAP_PF:
-		write_cr2(ctxt->fi.cr2);
-		exc_page_fault(ctxt->regs, error_code);
-		break;
-	case X86_TRAP_AC:
-		exc_alignment_check(ctxt->regs, error_code);
-		break;
-	default:
-		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
-		BUG();
-	}
-}
-
-/* Include code shared with pre-decompression boot stage */
-#include "sev-shared.c"
-
-static inline struct svsm_ca *svsm_get_caa(void)
-{
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
-		return this_cpu_read(svsm_caa);
-	else
-		return RIP_REL_REF(boot_svsm_caa);
-}
-
-static u64 svsm_get_caa_pa(void)
-{
-	/*
-	 * Use rIP-relative references when called early in the boot. If
-	 * ->use_cas is set, then it is late in the boot and no need
-	 * to worry about rIP-relative references.
-	 */
-	if (RIP_REL_REF(sev_cfg).use_cas)
-		return this_cpu_read(svsm_caa_pa);
-	else
-		return RIP_REL_REF(boot_svsm_caa_pa);
-}
-
-static noinstr void __sev_put_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	WARN_ON(!irqs_disabled());
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (state->ghcb) {
-		/* Restore GHCB from Backup */
-		*ghcb = *state->ghcb;
-		data->backup_ghcb_active = false;
-		state->ghcb = NULL;
-	} else {
-		/*
-		 * Invalidate the GHCB so a VMGEXIT instruction issued
-		 * from userspace won't appear to be valid.
-		 */
-		vc_ghcb_invalidate(ghcb);
-		data->ghcb_active = false;
-	}
-}
-
-static int svsm_perform_call_protocol(struct svsm_call *call)
-{
-	struct ghcb_state state;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	int ret;
-
-	/*
-	 * This can be called very early in the boot, use native functions in
-	 * order to avoid paravirt issues.
-	 */
-	flags = native_local_irq_save();
-
-	/*
-	 * Use rip-relative references when called early in the boot. If
-	 * ghcbs_initialized is set, then it is late in the boot and no need
-	 * to worry about rip-relative references in called functions.
-	 */
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
-		ghcb = __sev_get_ghcb(&state);
-	else if (RIP_REL_REF(boot_ghcb))
-		ghcb = RIP_REL_REF(boot_ghcb);
-	else
-		ghcb = NULL;
-
-	do {
-		ret = ghcb ? svsm_perform_ghcb_protocol(ghcb, call)
-			   : svsm_perform_msr_protocol(call);
-	} while (ret == -EAGAIN);
-
-	if (RIP_REL_REF(sev_cfg).ghcbs_initialized)
-		__sev_put_ghcb(&state);
-
-	native_local_irq_restore(flags);
-
-	return ret;
-}
-
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
-static u64 __init get_secrets_page(void)
-{
-	u64 pa_data = boot_params.cc_blob_address;
-	struct cc_blob_sev_info info;
-	void *map;
-
-	/*
-	 * The CC blob contains the address of the secrets page, check if the
-	 * blob is present.
-	 */
-	if (!pa_data)
-		return 0;
-
-	map = early_memremap(pa_data, sizeof(info));
-	if (!map) {
-		pr_err("Unable to locate SNP secrets page: failed to map the Confidential Computing blob.\n");
-		return 0;
-	}
-	memcpy(&info, map, sizeof(info));
-	early_memunmap(map, sizeof(info));
-
-	/* smoke-test the secrets page passed */
-	if (!info.secrets_phys || info.secrets_len != PAGE_SIZE)
-		return 0;
-
-	return info.secrets_phys;
-}
-
-static u64 __init get_snp_jump_table_addr(void)
-{
-	struct snp_secrets_page *secrets;
-	void __iomem *mem;
-	u64 pa, addr;
-
-	pa = get_secrets_page();
-	if (!pa)
-		return 0;
-
-	mem = ioremap_encrypted(pa, PAGE_SIZE);
-	if (!mem) {
-		pr_err("Unable to locate AP jump table address: failed to map the SNP secrets page.\n");
-		return 0;
-	}
-
-	secrets = (__force struct snp_secrets_page *)mem;
-
-	addr = secrets->os_area.ap_jump_table_pa;
-	iounmap(mem);
-
-	return addr;
-}
-
-static u64 __init get_jump_table_addr(void)
-{
-	struct ghcb_state state;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	u64 ret = 0;
-
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return get_snp_jump_table_addr();
-
-	local_irq_save(flags);
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_JUMP_TABLE);
-	ghcb_set_sw_exit_info_1(ghcb, SVM_VMGEXIT_GET_AP_JUMP_TABLE);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	if (ghcb_sw_exit_info_1_is_valid(ghcb) &&
-	    ghcb_sw_exit_info_2_is_valid(ghcb))
-		ret = ghcb->save.sw_exit_info_2;
-
-	__sev_put_ghcb(&state);
-
-	local_irq_restore(flags);
-
-	return ret;
-}
-
-static void __head
-early_set_pages_state(unsigned long vaddr, unsigned long paddr,
-		      unsigned long npages, enum psc_op op)
-{
-	unsigned long paddr_end;
-	u64 val;
-
-	vaddr = vaddr & PAGE_MASK;
-
-	paddr = paddr & PAGE_MASK;
-	paddr_end = paddr + (npages << PAGE_SHIFT);
-
-	while (paddr < paddr_end) {
-		/* Page validation must be rescinded before changing to shared */
-		if (op == SNP_PAGE_STATE_SHARED)
-			pvalidate_4k_page(vaddr, paddr, false);
-
-		/*
-		 * Use the MSR protocol because this function can be called before
-		 * the GHCB is established.
-		 */
-		sev_es_wr_ghcb_msr(GHCB_MSR_PSC_REQ_GFN(paddr >> PAGE_SHIFT, op));
-		VMGEXIT();
-
-		val = sev_es_rd_ghcb_msr();
-
-		if (WARN(GHCB_RESP_CODE(val) != GHCB_MSR_PSC_RESP,
-			 "Wrong PSC response code: 0x%x\n",
-			 (unsigned int)GHCB_RESP_CODE(val)))
-			goto e_term;
-
-		if (WARN(GHCB_MSR_PSC_RESP_VAL(val),
-			 "Failed to change page state to '%s' paddr 0x%lx error 0x%llx\n",
-			 op == SNP_PAGE_STATE_PRIVATE ? "private" : "shared",
-			 paddr, GHCB_MSR_PSC_RESP_VAL(val)))
-			goto e_term;
-
-		/* Page validation must be performed after changing to private */
-		if (op == SNP_PAGE_STATE_PRIVATE)
-			pvalidate_4k_page(vaddr, paddr, true);
-
-		vaddr += PAGE_SIZE;
-		paddr += PAGE_SIZE;
-	}
-
-	return;
-
-e_term:
-	sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-}
-
-void __head early_snp_set_memory_private(unsigned long vaddr, unsigned long paddr,
-					 unsigned long npages)
-{
-	/*
-	 * This can be invoked in early boot while running identity mapped, so
-	 * use an open coded check for SNP instead of using cc_platform_has().
-	 * This eliminates worries about jump tables or checking boot_cpu_data
-	 * in the cc_platform_has() function.
-	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
-		return;
-
-	 /*
-	  * Ask the hypervisor to mark the memory pages as private in the RMP
-	  * table.
-	  */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_PRIVATE);
-}
-
-void __init early_snp_set_memory_shared(unsigned long vaddr, unsigned long paddr,
-					unsigned long npages)
-{
-	/*
-	 * This can be invoked in early boot while running identity mapped, so
-	 * use an open coded check for SNP instead of using cc_platform_has().
-	 * This eliminates worries about jump tables or checking boot_cpu_data
-	 * in the cc_platform_has() function.
-	 */
-	if (!(RIP_REL_REF(sev_status) & MSR_AMD64_SEV_SNP_ENABLED))
-		return;
-
-	 /* Ask hypervisor to mark the memory pages shared in the RMP table. */
-	early_set_pages_state(vaddr, paddr, npages, SNP_PAGE_STATE_SHARED);
-}
-
-static unsigned long __set_pages_state(struct snp_psc_desc *data, unsigned long vaddr,
-				       unsigned long vaddr_end, int op)
-{
-	struct ghcb_state state;
-	bool use_large_entry;
-	struct psc_hdr *hdr;
-	struct psc_entry *e;
-	unsigned long flags;
-	unsigned long pfn;
-	struct ghcb *ghcb;
-	int i;
-
-	hdr = &data->hdr;
-	e = data->entries;
-
-	memset(data, 0, sizeof(*data));
-	i = 0;
-
-	while (vaddr < vaddr_end && i < ARRAY_SIZE(data->entries)) {
-		hdr->end_entry = i;
-
-		if (is_vmalloc_addr((void *)vaddr)) {
-			pfn = vmalloc_to_pfn((void *)vaddr);
-			use_large_entry = false;
-		} else {
-			pfn = __pa(vaddr) >> PAGE_SHIFT;
-			use_large_entry = true;
-		}
-
-		e->gfn = pfn;
-		e->operation = op;
-
-		if (use_large_entry && IS_ALIGNED(vaddr, PMD_SIZE) &&
-		    (vaddr_end - vaddr) >= PMD_SIZE) {
-			e->pagesize = RMP_PG_SIZE_2M;
-			vaddr += PMD_SIZE;
-		} else {
-			e->pagesize = RMP_PG_SIZE_4K;
-			vaddr += PAGE_SIZE;
-		}
-
-		e++;
-		i++;
-	}
-
-	/* Page validation must be rescinded before changing to shared */
-	if (op == SNP_PAGE_STATE_SHARED)
-		pvalidate_pages(data);
-
-	local_irq_save(flags);
-
-	if (sev_cfg.ghcbs_initialized)
-		ghcb = __sev_get_ghcb(&state);
-	else
-		ghcb = boot_ghcb;
-
-	/* Invoke the hypervisor to perform the page state changes */
-	if (!ghcb || vmgexit_psc(ghcb, data))
-		sev_es_terminate(SEV_TERM_SET_LINUX, GHCB_TERM_PSC);
-
-	if (sev_cfg.ghcbs_initialized)
-		__sev_put_ghcb(&state);
-
-	local_irq_restore(flags);
-
-	/* Page validation must be performed after changing to private */
-	if (op == SNP_PAGE_STATE_PRIVATE)
-		pvalidate_pages(data);
-
-	return vaddr;
-}
-
-static void set_pages_state(unsigned long vaddr, unsigned long npages, int op)
-{
-	struct snp_psc_desc desc;
-	unsigned long vaddr_end;
-
-	/* Use the MSR protocol when a GHCB is not available. */
-	if (!boot_ghcb)
-		return early_set_pages_state(vaddr, __pa(vaddr), npages, op);
-
-	vaddr = vaddr & PAGE_MASK;
-	vaddr_end = vaddr + (npages << PAGE_SHIFT);
-
-	while (vaddr < vaddr_end)
-		vaddr = __set_pages_state(&desc, vaddr, vaddr_end, op);
-}
-
-void snp_set_memory_shared(unsigned long vaddr, unsigned long npages)
-{
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return;
-
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_SHARED);
-}
-
-void snp_set_memory_private(unsigned long vaddr, unsigned long npages)
-{
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return;
-
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
-}
-
-void snp_accept_memory(phys_addr_t start, phys_addr_t end)
-{
-	unsigned long vaddr, npages;
-
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return;
-
-	vaddr = (unsigned long)__va(start);
-	npages = (end - start) >> PAGE_SHIFT;
-
-	set_pages_state(vaddr, npages, SNP_PAGE_STATE_PRIVATE);
-}
-
-static int snp_set_vmsa(void *va, void *caa, int apic_id, bool make_vmsa)
-{
-	int ret;
-
-	if (snp_vmpl) {
-		struct svsm_call call = {};
-		unsigned long flags;
-
-		local_irq_save(flags);
-
-		call.caa = this_cpu_read(svsm_caa);
-		call.rcx = __pa(va);
-
-		if (make_vmsa) {
-			/* Protocol 0, Call ID 2 */
-			call.rax = SVSM_CORE_CALL(SVSM_CORE_CREATE_VCPU);
-			call.rdx = __pa(caa);
-			call.r8  = apic_id;
-		} else {
-			/* Protocol 0, Call ID 3 */
-			call.rax = SVSM_CORE_CALL(SVSM_CORE_DELETE_VCPU);
-		}
-
-		ret = svsm_perform_call_protocol(&call);
-
-		local_irq_restore(flags);
-	} else {
-		/*
-		 * If the kernel runs at VMPL0, it can change the VMSA
-		 * bit for a page using the RMPADJUST instruction.
-		 * However, for the instruction to succeed it must
-		 * target the permissions of a lesser privileged (higher
-		 * numbered) VMPL level, so use VMPL1.
-		 */
-		u64 attrs = 1;
-
-		if (make_vmsa)
-			attrs |= RMPADJUST_VMSA_PAGE_BIT;
-
-		ret = rmpadjust((unsigned long)va, RMP_PG_SIZE_4K, attrs);
-	}
-
-	return ret;
-}
-
-#define __ATTR_BASE		(SVM_SELECTOR_P_MASK | SVM_SELECTOR_S_MASK)
-#define INIT_CS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_READ_MASK | SVM_SELECTOR_CODE_MASK)
-#define INIT_DS_ATTRIBS		(__ATTR_BASE | SVM_SELECTOR_WRITE_MASK)
-
-#define INIT_LDTR_ATTRIBS	(SVM_SELECTOR_P_MASK | 2)
-#define INIT_TR_ATTRIBS		(SVM_SELECTOR_P_MASK | 3)
-
-static void *snp_alloc_vmsa_page(int cpu)
-{
-	struct page *p;
-
-	/*
-	 * Allocate VMSA page to work around the SNP erratum where the CPU will
-	 * incorrectly signal an RMP violation #PF if a large page (2MB or 1GB)
-	 * collides with the RMP entry of VMSA page. The recommended workaround
-	 * is to not use a large page.
-	 *
-	 * Allocate an 8k page which is also 8k-aligned.
-	 */
-	p = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL_ACCOUNT | __GFP_ZERO, 1);
-	if (!p)
-		return NULL;
-
-	split_page(p, 1);
-
-	/* Free the first 4k. This page may be 2M/1G aligned and cannot be used. */
-	__free_page(p);
-
-	return page_address(p + 1);
-}
-
-static void snp_cleanup_vmsa(struct sev_es_save_area *vmsa, int apic_id)
-{
-	int err;
-
-	err = snp_set_vmsa(vmsa, NULL, apic_id, false);
-	if (err)
-		pr_err("clear VMSA page failed (%u), leaking page\n", err);
-	else
-		free_page((unsigned long)vmsa);
-}
-
-static int wakeup_cpu_via_vmgexit(u32 apic_id, unsigned long start_ip)
-{
-	struct sev_es_save_area *cur_vmsa, *vmsa;
-	struct ghcb_state state;
-	struct svsm_ca *caa;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	u8 sipi_vector;
-	int cpu, ret;
-	u64 cr4;
-
-	/*
-	 * The hypervisor SNP feature support check has happened earlier, just check
-	 * the AP_CREATION one here.
-	 */
-	if (!(sev_hv_features & GHCB_HV_FT_SNP_AP_CREATION))
-		return -EOPNOTSUPP;
-
-	/*
-	 * Verify the desired start IP against the known trampoline start IP
-	 * to catch any future new trampolines that may be introduced that
-	 * would require a new protected guest entry point.
-	 */
-	if (WARN_ONCE(start_ip != real_mode_header->trampoline_start,
-		      "Unsupported SNP start_ip: %lx\n", start_ip))
-		return -EINVAL;
-
-	/* Override start_ip with known protected guest start IP */
-	start_ip = real_mode_header->sev_es_trampoline_start;
-
-	/* Find the logical CPU for the APIC ID */
-	for_each_present_cpu(cpu) {
-		if (arch_match_cpu_phys_id(cpu, apic_id))
-			break;
-	}
-	if (cpu >= nr_cpu_ids)
-		return -EINVAL;
-
-	cur_vmsa = per_cpu(sev_vmsa, cpu);
-
-	/*
-	 * A new VMSA is created each time because there is no guarantee that
-	 * the current VMSA is the kernels or that the vCPU is not running. If
-	 * an attempt was done to use the current VMSA with a running vCPU, a
-	 * #VMEXIT of that vCPU would wipe out all of the settings being done
-	 * here.
-	 */
-	vmsa = (struct sev_es_save_area *)snp_alloc_vmsa_page(cpu);
-	if (!vmsa)
-		return -ENOMEM;
-
-	/* If an SVSM is present, the SVSM per-CPU CAA will be !NULL */
-	caa = per_cpu(svsm_caa, cpu);
-
-	/* CR4 should maintain the MCE value */
-	cr4 = native_read_cr4() & X86_CR4_MCE;
-
-	/* Set the CS value based on the start_ip converted to a SIPI vector */
-	sipi_vector		= (start_ip >> 12);
-	vmsa->cs.base		= sipi_vector << 12;
-	vmsa->cs.limit		= AP_INIT_CS_LIMIT;
-	vmsa->cs.attrib		= INIT_CS_ATTRIBS;
-	vmsa->cs.selector	= sipi_vector << 8;
-
-	/* Set the RIP value based on start_ip */
-	vmsa->rip		= start_ip & 0xfff;
-
-	/* Set AP INIT defaults as documented in the APM */
-	vmsa->ds.limit		= AP_INIT_DS_LIMIT;
-	vmsa->ds.attrib		= INIT_DS_ATTRIBS;
-	vmsa->es		= vmsa->ds;
-	vmsa->fs		= vmsa->ds;
-	vmsa->gs		= vmsa->ds;
-	vmsa->ss		= vmsa->ds;
-
-	vmsa->gdtr.limit	= AP_INIT_GDTR_LIMIT;
-	vmsa->ldtr.limit	= AP_INIT_LDTR_LIMIT;
-	vmsa->ldtr.attrib	= INIT_LDTR_ATTRIBS;
-	vmsa->idtr.limit	= AP_INIT_IDTR_LIMIT;
-	vmsa->tr.limit		= AP_INIT_TR_LIMIT;
-	vmsa->tr.attrib		= INIT_TR_ATTRIBS;
-
-	vmsa->cr4		= cr4;
-	vmsa->cr0		= AP_INIT_CR0_DEFAULT;
-	vmsa->dr7		= DR7_RESET_VALUE;
-	vmsa->dr6		= AP_INIT_DR6_DEFAULT;
-	vmsa->rflags		= AP_INIT_RFLAGS_DEFAULT;
-	vmsa->g_pat		= AP_INIT_GPAT_DEFAULT;
-	vmsa->xcr0		= AP_INIT_XCR0_DEFAULT;
-	vmsa->mxcsr		= AP_INIT_MXCSR_DEFAULT;
-	vmsa->x87_ftw		= AP_INIT_X87_FTW_DEFAULT;
-	vmsa->x87_fcw		= AP_INIT_X87_FCW_DEFAULT;
-
-	/* SVME must be set. */
-	vmsa->efer		= EFER_SVME;
-
-	/*
-	 * Set the SNP-specific fields for this VMSA:
-	 *   VMPL level
-	 *   SEV_FEATURES (matches the SEV STATUS MSR right shifted 2 bits)
-	 */
-	vmsa->vmpl		= snp_vmpl;
-	vmsa->sev_features	= sev_status >> 2;
-
-	/* Switch the page over to a VMSA page now that it is initialized */
-	ret = snp_set_vmsa(vmsa, caa, apic_id, true);
-	if (ret) {
-		pr_err("set VMSA page failed (%u)\n", ret);
-		free_page((unsigned long)vmsa);
-
-		return -EINVAL;
-	}
-
-	/* Issue VMGEXIT AP Creation NAE event */
-	local_irq_save(flags);
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	ghcb_set_rax(ghcb, vmsa->sev_features);
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_CREATION);
-	ghcb_set_sw_exit_info_1(ghcb,
-				((u64)apic_id << 32)	|
-				((u64)snp_vmpl << 16)	|
-				SVM_VMGEXIT_AP_CREATE);
-	ghcb_set_sw_exit_info_2(ghcb, __pa(vmsa));
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	if (!ghcb_sw_exit_info_1_is_valid(ghcb) ||
-	    lower_32_bits(ghcb->save.sw_exit_info_1)) {
-		pr_err("SNP AP Creation error\n");
-		ret = -EINVAL;
-	}
-
-	__sev_put_ghcb(&state);
-
-	local_irq_restore(flags);
-
-	/* Perform cleanup if there was an error */
-	if (ret) {
-		snp_cleanup_vmsa(vmsa, apic_id);
-		vmsa = NULL;
-	}
-
-	/* Free up any previous VMSA page */
-	if (cur_vmsa)
-		snp_cleanup_vmsa(cur_vmsa, apic_id);
-
-	/* Record the current VMSA page */
-	per_cpu(sev_vmsa, cpu) = vmsa;
-
-	return ret;
-}
-
-void __init snp_set_wakeup_secondary_cpu(void)
-{
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return;
-
-	/*
-	 * Always set this override if SNP is enabled. This makes it the
-	 * required method to start APs under SNP. If the hypervisor does
-	 * not support AP creation, then no APs will be started.
-	 */
-	apic_update_callback(wakeup_secondary_cpu, wakeup_cpu_via_vmgexit);
-}
-
-int __init sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
-{
-	u16 startup_cs, startup_ip;
-	phys_addr_t jump_table_pa;
-	u64 jump_table_addr;
-	u16 __iomem *jump_table;
-
-	jump_table_addr = get_jump_table_addr();
-
-	/* On UP guests there is no jump table so this is not a failure */
-	if (!jump_table_addr)
-		return 0;
-
-	/* Check if AP Jump Table is page-aligned */
-	if (jump_table_addr & ~PAGE_MASK)
-		return -EINVAL;
-
-	jump_table_pa = jump_table_addr & PAGE_MASK;
-
-	startup_cs = (u16)(rmh->trampoline_start >> 4);
-	startup_ip = (u16)(rmh->sev_es_trampoline_start -
-			   rmh->trampoline_start);
-
-	jump_table = ioremap_encrypted(jump_table_pa, PAGE_SIZE);
-	if (!jump_table)
-		return -EIO;
-
-	writew(startup_ip, &jump_table[0]);
-	writew(startup_cs, &jump_table[1]);
-
-	iounmap(jump_table);
-
-	return 0;
-}
-
-/*
- * This is needed by the OVMF UEFI firmware which will use whatever it finds in
- * the GHCB MSR as its GHCB to talk to the hypervisor. So make sure the per-cpu
- * runtime GHCBs used by the kernel are also mapped in the EFI page-table.
- */
-int __init sev_es_efi_map_ghcbs(pgd_t *pgd)
-{
-	struct sev_es_runtime_data *data;
-	unsigned long address, pflags;
-	int cpu;
-	u64 pfn;
-
-	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		return 0;
-
-	pflags = _PAGE_NX | _PAGE_RW;
-
-	for_each_possible_cpu(cpu) {
-		data = per_cpu(runtime_data, cpu);
-
-		address = __pa(&data->ghcb_page);
-		pfn = address >> PAGE_SHIFT;
-
-		if (kernel_map_pages_in_pgd(pgd, pfn, address, 1, pflags))
-			return 1;
-	}
-
-	return 0;
-}
-
-static enum es_result vc_handle_msr(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	enum es_result ret;
-	u64 exit_info_1;
-
-	/* Is it a WRMSR? */
-	exit_info_1 = (ctxt->insn.opcode.bytes[1] == 0x30) ? 1 : 0;
-
-	if (regs->cx == MSR_SVSM_CAA) {
-		/* Writes to the SVSM CAA msr are ignored */
-		if (exit_info_1)
-			return ES_OK;
-
-		regs->ax = lower_32_bits(this_cpu_read(svsm_caa_pa));
-		regs->dx = upper_32_bits(this_cpu_read(svsm_caa_pa));
-
-		return ES_OK;
-	}
-
-	ghcb_set_rcx(ghcb, regs->cx);
-	if (exit_info_1) {
-		ghcb_set_rax(ghcb, regs->ax);
-		ghcb_set_rdx(ghcb, regs->dx);
-	}
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_MSR, exit_info_1, 0);
-
-	if ((ret == ES_OK) && (!exit_info_1)) {
-		regs->ax = ghcb->save.rax;
-		regs->dx = ghcb->save.rdx;
-	}
-
-	return ret;
-}
-
-static void snp_register_per_cpu_ghcb(void)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	snp_register_ghcb_early(__pa(ghcb));
-}
-
-void setup_ghcb(void)
-{
-	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		return;
-
-	/*
-	 * Check whether the runtime #VC exception handler is active. It uses
-	 * the per-CPU GHCB page which is set up by sev_es_init_vc_handling().
-	 *
-	 * If SNP is active, register the per-CPU GHCB page so that the runtime
-	 * exception handler can use it.
-	 */
-	if (initial_vc_handler == (unsigned long)kernel_exc_vmm_communication) {
-		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-			snp_register_per_cpu_ghcb();
-
-		sev_cfg.ghcbs_initialized = true;
-
-		return;
-	}
-
-	/*
-	 * Make sure the hypervisor talks a supported protocol.
-	 * This gets called only in the BSP boot phase.
-	 */
-	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
-	/*
-	 * Clear the boot_ghcb. The first exception comes in before the bss
-	 * section is cleared.
-	 */
-	memset(&boot_ghcb_page, 0, PAGE_SIZE);
-
-	/* Alright - Make the boot-ghcb public */
-	boot_ghcb = &boot_ghcb_page;
-
-	/* SNP guest requires that GHCB GPA must be registered. */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		snp_register_ghcb_early(__pa(&boot_ghcb_page));
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-static void sev_es_ap_hlt_loop(void)
-{
-	struct ghcb_state state;
-	struct ghcb *ghcb;
-
-	ghcb = __sev_get_ghcb(&state);
-
-	while (true) {
-		vc_ghcb_invalidate(ghcb);
-		ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_AP_HLT_LOOP);
-		ghcb_set_sw_exit_info_1(ghcb, 0);
-		ghcb_set_sw_exit_info_2(ghcb, 0);
-
-		sev_es_wr_ghcb_msr(__pa(ghcb));
-		VMGEXIT();
-
-		/* Wakeup signal? */
-		if (ghcb_sw_exit_info_2_is_valid(ghcb) &&
-		    ghcb->save.sw_exit_info_2)
-			break;
-	}
-
-	__sev_put_ghcb(&state);
-}
-
-/*
- * Play_dead handler when running under SEV-ES. This is needed because
- * the hypervisor can't deliver an SIPI request to restart the AP.
- * Instead the kernel has to issue a VMGEXIT to halt the VCPU until the
- * hypervisor wakes it up again.
- */
-static void sev_es_play_dead(void)
-{
-	play_dead_common();
-
-	/* IRQs now disabled */
-
-	sev_es_ap_hlt_loop();
-
-	/*
-	 * If we get here, the VCPU was woken up again. Jump to CPU
-	 * startup code to get it back online.
-	 */
-	soft_restart_cpu();
-}
-#else  /* CONFIG_HOTPLUG_CPU */
-#define sev_es_play_dead	native_play_dead
-#endif /* CONFIG_HOTPLUG_CPU */
-
-#ifdef CONFIG_SMP
-static void __init sev_es_setup_play_dead(void)
-{
-	smp_ops.play_dead = sev_es_play_dead;
-}
-#else
-static inline void sev_es_setup_play_dead(void) { }
-#endif
-
-static void __init alloc_runtime_data(int cpu)
-{
-	struct sev_es_runtime_data *data;
-
-	data = memblock_alloc_node(sizeof(*data), PAGE_SIZE, cpu_to_node(cpu));
-	if (!data)
-		panic("Can't allocate SEV-ES runtime data");
-
-	per_cpu(runtime_data, cpu) = data;
-
-	if (snp_vmpl) {
-		struct svsm_ca *caa;
-
-		/* Allocate the SVSM CA page if an SVSM is present */
-		caa = memblock_alloc(sizeof(*caa), PAGE_SIZE);
-		if (!caa)
-			panic("Can't allocate SVSM CA page\n");
-
-		per_cpu(svsm_caa, cpu) = caa;
-		per_cpu(svsm_caa_pa, cpu) = __pa(caa);
-	}
-}
-
-static void __init init_ghcb(int cpu)
-{
-	struct sev_es_runtime_data *data;
-	int err;
-
-	data = per_cpu(runtime_data, cpu);
-
-	err = early_set_memory_decrypted((unsigned long)&data->ghcb_page,
-					 sizeof(data->ghcb_page));
-	if (err)
-		panic("Can't map GHCBs unencrypted");
-
-	memset(&data->ghcb_page, 0, sizeof(data->ghcb_page));
-
-	data->ghcb_active = false;
-	data->backup_ghcb_active = false;
-}
-
-void __init sev_es_init_vc_handling(void)
-{
-	int cpu;
-
-	BUILD_BUG_ON(offsetof(struct sev_es_runtime_data, ghcb_page) % PAGE_SIZE);
-
-	if (!cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
-		return;
-
-	if (!sev_es_check_cpu_features())
-		panic("SEV-ES CPU Features missing");
-
-	/*
-	 * SNP is supported in v2 of the GHCB spec which mandates support for HV
-	 * features.
-	 */
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP)) {
-		sev_hv_features = get_hv_features();
-
-		if (!(sev_hv_features & GHCB_HV_FT_SNP))
-			sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-	}
-
-	/* Initialize per-cpu GHCB pages */
-	for_each_possible_cpu(cpu) {
-		alloc_runtime_data(cpu);
-		init_ghcb(cpu);
-	}
-
-	/* If running under an SVSM, switch to the per-cpu CA */
-	if (snp_vmpl) {
-		struct svsm_call call = {};
-		unsigned long flags;
-		int ret;
-
-		local_irq_save(flags);
-
-		/*
-		 * SVSM_CORE_REMAP_CA call:
-		 *   RAX = 0 (Protocol=0, CallID=0)
-		 *   RCX = New CA GPA
-		 */
-		call.caa = svsm_get_caa();
-		call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
-		call.rcx = this_cpu_read(svsm_caa_pa);
-		ret = svsm_perform_call_protocol(&call);
-		if (ret)
-			panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n",
-			      ret, call.rax_out);
-
-		sev_cfg.use_cas = true;
-
-		local_irq_restore(flags);
-	}
-
-	sev_es_setup_play_dead();
-
-	/* Secondary CPUs use the runtime #VC handler */
-	initial_vc_handler = (unsigned long)kernel_exc_vmm_communication;
-}
-
-static void __init vc_early_forward_exception(struct es_em_ctxt *ctxt)
-{
-	int trapnr = ctxt->fi.vector;
-
-	if (trapnr == X86_TRAP_PF)
-		native_write_cr2(ctxt->fi.cr2);
-
-	ctxt->regs->orig_ax = ctxt->fi.error_code;
-	do_early_exception(ctxt->regs, trapnr);
-}
-
-static long *vc_insn_get_rm(struct es_em_ctxt *ctxt)
-{
-	long *reg_array;
-	int offset;
-
-	reg_array = (long *)ctxt->regs;
-	offset    = insn_get_modrm_rm_off(&ctxt->insn, ctxt->regs);
-
-	if (offset < 0)
-		return NULL;
-
-	offset /= sizeof(long);
-
-	return reg_array + offset;
-}
-static enum es_result vc_do_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt,
-				 unsigned int bytes, bool read)
-{
-	u64 exit_code, exit_info_1, exit_info_2;
-	unsigned long ghcb_pa = __pa(ghcb);
-	enum es_result res;
-	phys_addr_t paddr;
-	void __user *ref;
-
-	ref = insn_get_addr_ref(&ctxt->insn, ctxt->regs);
-	if (ref == (void __user *)-1L)
-		return ES_UNSUPPORTED;
-
-	exit_code = read ? SVM_VMGEXIT_MMIO_READ : SVM_VMGEXIT_MMIO_WRITE;
-
-	res = vc_slow_virt_to_phys(ghcb, ctxt, (unsigned long)ref, &paddr);
-	if (res != ES_OK) {
-		if (res == ES_EXCEPTION && !read)
-			ctxt->fi.error_code |= X86_PF_WRITE;
-
-		return res;
-	}
-
-	exit_info_1 = paddr;
-	/* Can never be greater than 8 */
-	exit_info_2 = bytes;
-
-	ghcb_set_sw_scratch(ghcb, ghcb_pa + offsetof(struct ghcb, shared_buffer));
-
-	return sev_es_ghcb_hv_call(ghcb, ctxt, exit_code, exit_info_1, exit_info_2);
-}
-
-/*
- * The MOVS instruction has two memory operands, which raises the
- * problem that it is not known whether the access to the source or the
- * destination caused the #VC exception (and hence whether an MMIO read
- * or write operation needs to be emulated).
- *
- * Instead of playing games with walking page-tables and trying to guess
- * whether the source or destination is an MMIO range, split the move
- * into two operations, a read and a write with only one memory operand.
- * This will cause a nested #VC exception on the MMIO address which can
- * then be handled.
- *
- * This implementation has the benefit that it also supports MOVS where
- * source _and_ destination are MMIO regions.
- *
- * It will slow MOVS on MMIO down a lot, but in SEV-ES guests it is a
- * rare operation. If it turns out to be a performance problem the split
- * operations can be moved to memcpy_fromio() and memcpy_toio().
- */
-static enum es_result vc_handle_mmio_movs(struct es_em_ctxt *ctxt,
-					  unsigned int bytes)
-{
-	unsigned long ds_base, es_base;
-	unsigned char *src, *dst;
-	unsigned char buffer[8];
-	enum es_result ret;
-	bool rep;
-	int off;
-
-	ds_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_DS);
-	es_base = insn_get_seg_base(ctxt->regs, INAT_SEG_REG_ES);
-
-	if (ds_base == -1L || es_base == -1L) {
-		ctxt->fi.vector = X86_TRAP_GP;
-		ctxt->fi.error_code = 0;
-		return ES_EXCEPTION;
-	}
-
-	src = ds_base + (unsigned char *)ctxt->regs->si;
-	dst = es_base + (unsigned char *)ctxt->regs->di;
-
-	ret = vc_read_mem(ctxt, src, buffer, bytes);
-	if (ret != ES_OK)
-		return ret;
-
-	ret = vc_write_mem(ctxt, dst, buffer, bytes);
-	if (ret != ES_OK)
-		return ret;
-
-	if (ctxt->regs->flags & X86_EFLAGS_DF)
-		off = -bytes;
-	else
-		off =  bytes;
-
-	ctxt->regs->si += off;
-	ctxt->regs->di += off;
-
-	rep = insn_has_rep_prefix(&ctxt->insn);
-	if (rep)
-		ctxt->regs->cx -= 1;
-
-	if (!rep || ctxt->regs->cx == 0)
-		return ES_OK;
-	else
-		return ES_RETRY;
-}
-
-static enum es_result vc_handle_mmio(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	struct insn *insn = &ctxt->insn;
-	enum insn_mmio_type mmio;
-	unsigned int bytes = 0;
-	enum es_result ret;
-	u8 sign_byte;
-	long *reg_data;
-
-	mmio = insn_decode_mmio(insn, &bytes);
-	if (mmio == INSN_MMIO_DECODE_FAILED)
-		return ES_DECODE_FAILED;
-
-	if (mmio != INSN_MMIO_WRITE_IMM && mmio != INSN_MMIO_MOVS) {
-		reg_data = insn_get_modrm_reg_ptr(insn, ctxt->regs);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-	}
-
-	if (user_mode(ctxt->regs))
-		return ES_UNSUPPORTED;
-
-	switch (mmio) {
-	case INSN_MMIO_WRITE:
-		memcpy(ghcb->shared_buffer, reg_data, bytes);
-		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
-		break;
-	case INSN_MMIO_WRITE_IMM:
-		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
-		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
-		break;
-	case INSN_MMIO_READ:
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Zero-extend for 32-bit operation */
-		if (bytes == 4)
-			*reg_data = 0;
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-	case INSN_MMIO_READ_ZERO_EXTEND:
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Zero extend based on operand size */
-		memset(reg_data, 0, insn->opnd_bytes);
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-	case INSN_MMIO_READ_SIGN_EXTEND:
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		if (bytes == 1) {
-			u8 *val = (u8 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x80) ? 0xff : 0x00;
-		} else {
-			u16 *val = (u16 *)ghcb->shared_buffer;
-
-			sign_byte = (*val & 0x8000) ? 0xff : 0x00;
-		}
-
-		/* Sign extend based on operand size */
-		memset(reg_data, sign_byte, insn->opnd_bytes);
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-	case INSN_MMIO_MOVS:
-		ret = vc_handle_mmio_movs(ctxt, bytes);
-		break;
-	default:
-		ret = ES_UNSUPPORTED;
-		break;
-	}
-
-	return ret;
-}
-
-static enum es_result vc_handle_dr7_write(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt)
-{
-	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
-	long val, *reg = vc_insn_get_rm(ctxt);
-	enum es_result ret;
-
-	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
-		return ES_VMM_ERROR;
-
-	if (!reg)
-		return ES_DECODE_FAILED;
-
-	val = *reg;
-
-	/* Upper 32 bits must be written as zeroes */
-	if (val >> 32) {
-		ctxt->fi.vector = X86_TRAP_GP;
-		ctxt->fi.error_code = 0;
-		return ES_EXCEPTION;
-	}
-
-	/* Clear out other reserved bits and set bit 10 */
-	val = (val & 0xffff23ffL) | BIT(10);
-
-	/* Early non-zero writes to DR7 are not supported */
-	if (!data && (val & ~DR7_RESET_VALUE))
-		return ES_UNSUPPORTED;
-
-	/* Using a value of 0 for ExitInfo1 means RAX holds the value */
-	ghcb_set_rax(ghcb, val);
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WRITE_DR7, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (data)
-		data->dr7 = val;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_dr7_read(struct ghcb *ghcb,
-					 struct es_em_ctxt *ctxt)
-{
-	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
-	long *reg = vc_insn_get_rm(ctxt);
-
-	if (sev_status & MSR_AMD64_SNP_DEBUG_SWAP)
-		return ES_VMM_ERROR;
-
-	if (!reg)
-		return ES_DECODE_FAILED;
-
-	if (data)
-		*reg = data->dr7;
-	else
-		*reg = DR7_RESET_VALUE;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_wbinvd(struct ghcb *ghcb,
-				       struct es_em_ctxt *ctxt)
-{
-	return sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_WBINVD, 0, 0);
-}
-
-static enum es_result vc_handle_rdpmc(struct ghcb *ghcb, struct es_em_ctxt *ctxt)
-{
-	enum es_result ret;
-
-	ghcb_set_rcx(ghcb, ctxt->regs->cx);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_RDPMC, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!(ghcb_rax_is_valid(ghcb) && ghcb_rdx_is_valid(ghcb)))
-		return ES_VMM_ERROR;
-
-	ctxt->regs->ax = ghcb->save.rax;
-	ctxt->regs->dx = ghcb->save.rdx;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_monitor(struct ghcb *ghcb,
-					struct es_em_ctxt *ctxt)
-{
-	/*
-	 * Treat it as a NOP and do not leak a physical address to the
-	 * hypervisor.
-	 */
-	return ES_OK;
-}
-
-static enum es_result vc_handle_mwait(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt)
-{
-	/* Treat the same as MONITOR/MONITORX */
-	return ES_OK;
-}
-
-static enum es_result vc_handle_vmmcall(struct ghcb *ghcb,
-					struct es_em_ctxt *ctxt)
-{
-	enum es_result ret;
-
-	ghcb_set_rax(ghcb, ctxt->regs->ax);
-	ghcb_set_cpl(ghcb, user_mode(ctxt->regs) ? 3 : 0);
-
-	if (x86_platform.hyper.sev_es_hcall_prepare)
-		x86_platform.hyper.sev_es_hcall_prepare(ghcb, ctxt->regs);
-
-	ret = sev_es_ghcb_hv_call(ghcb, ctxt, SVM_EXIT_VMMCALL, 0, 0);
-	if (ret != ES_OK)
-		return ret;
-
-	if (!ghcb_rax_is_valid(ghcb))
-		return ES_VMM_ERROR;
-
-	ctxt->regs->ax = ghcb->save.rax;
-
-	/*
-	 * Call sev_es_hcall_finish() after regs->ax is already set.
-	 * This allows the hypervisor handler to overwrite it again if
-	 * necessary.
-	 */
-	if (x86_platform.hyper.sev_es_hcall_finish &&
-	    !x86_platform.hyper.sev_es_hcall_finish(ghcb, ctxt->regs))
-		return ES_VMM_ERROR;
-
-	return ES_OK;
-}
-
-static enum es_result vc_handle_trap_ac(struct ghcb *ghcb,
-					struct es_em_ctxt *ctxt)
-{
-	/*
-	 * Calling ecx_alignment_check() directly does not work, because it
-	 * enables IRQs and the GHCB is active. Forward the exception and call
-	 * it later from vc_forward_exception().
-	 */
-	ctxt->fi.vector = X86_TRAP_AC;
-	ctxt->fi.error_code = 0;
-	return ES_EXCEPTION;
-}
-
-static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
-					 struct ghcb *ghcb,
-					 unsigned long exit_code)
-{
-	enum es_result result = vc_check_opcode_bytes(ctxt, exit_code);
-
-	if (result != ES_OK)
-		return result;
-
-	switch (exit_code) {
-	case SVM_EXIT_READ_DR7:
-		result = vc_handle_dr7_read(ghcb, ctxt);
-		break;
-	case SVM_EXIT_WRITE_DR7:
-		result = vc_handle_dr7_write(ghcb, ctxt);
-		break;
-	case SVM_EXIT_EXCP_BASE + X86_TRAP_AC:
-		result = vc_handle_trap_ac(ghcb, ctxt);
-		break;
-	case SVM_EXIT_RDTSC:
-	case SVM_EXIT_RDTSCP:
-		result = vc_handle_rdtsc(ghcb, ctxt, exit_code);
-		break;
-	case SVM_EXIT_RDPMC:
-		result = vc_handle_rdpmc(ghcb, ctxt);
-		break;
-	case SVM_EXIT_INVD:
-		pr_err_ratelimited("#VC exception for INVD??? Seriously???\n");
-		result = ES_UNSUPPORTED;
-		break;
-	case SVM_EXIT_CPUID:
-		result = vc_handle_cpuid(ghcb, ctxt);
-		break;
-	case SVM_EXIT_IOIO:
-		result = vc_handle_ioio(ghcb, ctxt);
-		break;
-	case SVM_EXIT_MSR:
-		result = vc_handle_msr(ghcb, ctxt);
-		break;
-	case SVM_EXIT_VMMCALL:
-		result = vc_handle_vmmcall(ghcb, ctxt);
-		break;
-	case SVM_EXIT_WBINVD:
-		result = vc_handle_wbinvd(ghcb, ctxt);
-		break;
-	case SVM_EXIT_MONITOR:
-		result = vc_handle_monitor(ghcb, ctxt);
-		break;
-	case SVM_EXIT_MWAIT:
-		result = vc_handle_mwait(ghcb, ctxt);
-		break;
-	case SVM_EXIT_NPF:
-		result = vc_handle_mmio(ghcb, ctxt);
-		break;
-	default:
-		/*
-		 * Unexpected #VC exception
-		 */
-		result = ES_UNSUPPORTED;
-	}
-
-	return result;
-}
-
-static __always_inline bool is_vc2_stack(unsigned long sp)
-{
-	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
-}
-
-static __always_inline bool vc_from_invalid_context(struct pt_regs *regs)
-{
-	unsigned long sp, prev_sp;
-
-	sp      = (unsigned long)regs;
-	prev_sp = regs->sp;
-
-	/*
-	 * If the code was already executing on the VC2 stack when the #VC
-	 * happened, let it proceed to the normal handling routine. This way the
-	 * code executing on the VC2 stack can cause #VC exceptions to get handled.
-	 */
-	return is_vc2_stack(sp) && !is_vc2_stack(prev_sp);
-}
-
-static bool vc_raw_handle_exception(struct pt_regs *regs, unsigned long error_code)
-{
-	struct ghcb_state state;
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-	struct ghcb *ghcb;
-	bool ret = true;
-
-	ghcb = __sev_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	result = vc_init_em_ctxt(&ctxt, regs, error_code);
-
-	if (result == ES_OK)
-		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
-
-	__sev_put_ghcb(&state);
-
-	/* Done - now check the result */
-	switch (result) {
-	case ES_OK:
-		vc_finish_insn(&ctxt);
-		break;
-	case ES_UNSUPPORTED:
-		pr_err_ratelimited("Unsupported exit-code 0x%02lx in #VC exception (IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		ret = false;
-		break;
-	case ES_VMM_ERROR:
-		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		ret = false;
-		break;
-	case ES_DECODE_FAILED:
-		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		ret = false;
-		break;
-	case ES_EXCEPTION:
-		vc_forward_exception(&ctxt);
-		break;
-	case ES_RETRY:
-		/* Nothing to do */
-		break;
-	default:
-		pr_emerg("Unknown result in %s():%d\n", __func__, result);
-		/*
-		 * Emulating the instruction which caused the #VC exception
-		 * failed - can't continue so print debug information
-		 */
-		BUG();
-	}
-
-	return ret;
-}
-
-static __always_inline bool vc_is_db(unsigned long error_code)
-{
-	return error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB;
-}
-
-/*
- * Runtime #VC exception handler when raised from kernel mode. Runs in NMI mode
- * and will panic when an error happens.
- */
-DEFINE_IDTENTRY_VC_KERNEL(exc_vmm_communication)
-{
-	irqentry_state_t irq_state;
-
-	/*
-	 * With the current implementation it is always possible to switch to a
-	 * safe stack because #VC exceptions only happen at known places, like
-	 * intercepted instructions or accesses to MMIO areas/IO ports. They can
-	 * also happen with code instrumentation when the hypervisor intercepts
-	 * #DB, but the critical paths are forbidden to be instrumented, so #DB
-	 * exceptions currently also only happen in safe places.
-	 *
-	 * But keep this here in case the noinstr annotations are violated due
-	 * to bug elsewhere.
-	 */
-	if (unlikely(vc_from_invalid_context(regs))) {
-		instrumentation_begin();
-		panic("Can't handle #VC exception from unsupported context\n");
-		instrumentation_end();
-	}
-
-	/*
-	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
-	 */
-	if (vc_is_db(error_code)) {
-		exc_debug(regs);
-		return;
-	}
-
-	irq_state = irqentry_nmi_enter(regs);
-
-	instrumentation_begin();
-
-	if (!vc_raw_handle_exception(regs, error_code)) {
-		/* Show some debug info */
-		show_regs(regs);
-
-		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-
-		/* If that fails and we get here - just panic */
-		panic("Returned from Terminate-Request to Hypervisor\n");
-	}
-
-	instrumentation_end();
-	irqentry_nmi_exit(regs, irq_state);
-}
-
-/*
- * Runtime #VC exception handler when raised from user mode. Runs in IRQ mode
- * and will kill the current task with SIGBUS when an error happens.
- */
-DEFINE_IDTENTRY_VC_USER(exc_vmm_communication)
-{
-	/*
-	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
-	 */
-	if (vc_is_db(error_code)) {
-		noist_exc_debug(regs);
-		return;
-	}
-
-	irqentry_enter_from_user_mode(regs);
-	instrumentation_begin();
-
-	if (!vc_raw_handle_exception(regs, error_code)) {
-		/*
-		 * Do not kill the machine if user-space triggered the
-		 * exception. Send SIGBUS instead and let user-space deal with
-		 * it.
-		 */
-		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
-	}
-
-	instrumentation_end();
-	irqentry_exit_to_user_mode(regs);
-}
-
-bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
-{
-	unsigned long exit_code = regs->orig_ax;
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-
-	vc_ghcb_invalidate(boot_ghcb);
-
-	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
-	if (result == ES_OK)
-		result = vc_handle_exitcode(&ctxt, boot_ghcb, exit_code);
-
-	/* Done - now check the result */
-	switch (result) {
-	case ES_OK:
-		vc_finish_insn(&ctxt);
-		break;
-	case ES_UNSUPPORTED:
-		early_printk("PANIC: Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
-				exit_code, regs->ip);
-		goto fail;
-	case ES_VMM_ERROR:
-		early_printk("PANIC: Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
-				exit_code, regs->ip);
-		goto fail;
-	case ES_DECODE_FAILED:
-		early_printk("PANIC: Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
-				exit_code, regs->ip);
-		goto fail;
-	case ES_EXCEPTION:
-		vc_early_forward_exception(&ctxt);
-		break;
-	case ES_RETRY:
-		/* Nothing to do */
-		break;
-	default:
-		BUG();
-	}
-
-	return true;
-
-fail:
-	show_regs(regs);
-
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SEV_ES_GEN_REQ);
-}
-
-/*
- * Initial set up of SNP relies on information provided by the
- * Confidential Computing blob, which can be passed to the kernel
- * in the following ways, depending on how it is booted:
- *
- * - when booted via the boot/decompress kernel:
- *   - via boot_params
- *
- * - when booted directly by firmware/bootloader (e.g. CONFIG_PVH):
- *   - via a setup_data entry, as defined by the Linux Boot Protocol
- *
- * Scan for the blob in that order.
- */
-static __head struct cc_blob_sev_info *find_cc_blob(struct boot_params *bp)
-{
-	struct cc_blob_sev_info *cc_info;
-
-	/* Boot kernel would have passed the CC blob via boot_params. */
-	if (bp->cc_blob_address) {
-		cc_info = (struct cc_blob_sev_info *)(unsigned long)bp->cc_blob_address;
-		goto found_cc_info;
-	}
-
-	/*
-	 * If kernel was booted directly, without the use of the
-	 * boot/decompression kernel, the CC blob may have been passed via
-	 * setup_data instead.
-	 */
-	cc_info = find_cc_blob_setup_data(bp);
-	if (!cc_info)
-		return NULL;
-
-found_cc_info:
-	if (cc_info->magic != CC_BLOB_SEV_HDR_MAGIC)
-		snp_abort();
-
-	return cc_info;
-}
-
-static __head void svsm_setup(struct cc_blob_sev_info *cc_info)
-{
-	struct svsm_call call = {};
-	int ret;
-	u64 pa;
-
-	/*
-	 * Record the SVSM Calling Area address (CAA) if the guest is not
-	 * running at VMPL0. The CA will be used to communicate with the
-	 * SVSM to perform the SVSM services.
-	 */
-	if (!svsm_setup_ca(cc_info))
-		return;
-
-	/*
-	 * It is very early in the boot and the kernel is running identity
-	 * mapped but without having adjusted the pagetables to where the
-	 * kernel was loaded (physbase), so the get the CA address using
-	 * RIP-relative addressing.
-	 */
-	pa = (u64)&RIP_REL_REF(boot_svsm_ca_page);
-
-	/*
-	 * Switch over to the boot SVSM CA while the current CA is still
-	 * addressable. There is no GHCB at this point so use the MSR protocol.
-	 *
-	 * SVSM_CORE_REMAP_CA call:
-	 *   RAX = 0 (Protocol=0, CallID=0)
-	 *   RCX = New CA GPA
-	 */
-	call.caa = svsm_get_caa();
-	call.rax = SVSM_CORE_CALL(SVSM_CORE_REMAP_CA);
-	call.rcx = pa;
-	ret = svsm_perform_call_protocol(&call);
-	if (ret)
-		panic("Can't remap the SVSM CA, ret=%d, rax_out=0x%llx\n", ret, call.rax_out);
-
-	RIP_REL_REF(boot_svsm_caa) = (struct svsm_ca *)pa;
-	RIP_REL_REF(boot_svsm_caa_pa) = pa;
-}
-
-bool __head snp_init(struct boot_params *bp)
-{
-	struct cc_blob_sev_info *cc_info;
-
-	if (!bp)
-		return false;
-
-	cc_info = find_cc_blob(bp);
-	if (!cc_info)
-		return false;
-
-	setup_cpuid_table(cc_info);
-
-	svsm_setup(cc_info);
-
-	/*
-	 * The CC blob will be used later to access the secrets page. Cache
-	 * it here like the boot kernel does.
-	 */
-	bp->cc_blob_address = (u32)(unsigned long)cc_info;
-
-	return true;
-}
-
-void __head __noreturn snp_abort(void)
-{
-	sev_es_terminate(SEV_TERM_SET_GEN, GHCB_SNP_UNSUPPORTED);
-}
-
-/*
- * SEV-SNP guests should only execute dmi_setup() if EFI_CONFIG_TABLES are
- * enabled, as the alternative (fallback) logic for DMI probing in the legacy
- * ROM region can cause a crash since this region is not pre-validated.
- */
-void __init snp_dmi_setup(void)
-{
-	if (efi_enabled(EFI_CONFIG_TABLES))
-		dmi_setup();
-}
-
-static void dump_cpuid_table(void)
-{
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
-	int i = 0;
-
-	pr_info("count=%d reserved=0x%x reserved2=0x%llx\n",
-		cpuid_table->count, cpuid_table->__reserved1, cpuid_table->__reserved2);
-
-	for (i = 0; i < SNP_CPUID_COUNT_MAX; i++) {
-		const struct snp_cpuid_fn *fn = &cpuid_table->fn[i];
-
-		pr_info("index=%3d fn=0x%08x subfn=0x%08x: eax=0x%08x ebx=0x%08x ecx=0x%08x edx=0x%08x xcr0_in=0x%016llx xss_in=0x%016llx reserved=0x%016llx\n",
-			i, fn->eax_in, fn->ecx_in, fn->eax, fn->ebx, fn->ecx,
-			fn->edx, fn->xcr0_in, fn->xss_in, fn->__reserved);
-	}
-}
-
-/*
- * It is useful from an auditing/testing perspective to provide an easy way
- * for the guest owner to know that the CPUID table has been initialized as
- * expected, but that initialization happens too early in boot to print any
- * sort of indicator, and there's not really any other good place to do it,
- * so do it here.
- *
- * If running as an SNP guest, report the current VM privilege level (VMPL).
- */
-static int __init report_snp_info(void)
-{
-	const struct snp_cpuid_table *cpuid_table = snp_cpuid_get_table();
-
-	if (cpuid_table->count) {
-		pr_info("Using SNP CPUID table, %d entries present.\n",
-			cpuid_table->count);
-
-		if (sev_cfg.debug)
-			dump_cpuid_table();
-	}
-
-	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		pr_info("SNP running at VMPL%u.\n", snp_vmpl);
-
-	return 0;
-}
-arch_initcall(report_snp_info);
-
-static int __init init_sev_config(char *str)
-{
-	char *s;
-
-	while ((s = strsep(&str, ","))) {
-		if (!strcmp(s, "debug")) {
-			sev_cfg.debug = true;
-			continue;
-		}
-
-		pr_info("SEV command-line option '%s' was not recognized\n", s);
-	}
-
-	return 1;
-}
-__setup("sev=", init_sev_config);
-
-static void update_attest_input(struct svsm_call *call, struct svsm_attest_call *input)
-{
-	/* If (new) lengths have been returned, propagate them up */
-	if (call->rcx_out != call->rcx)
-		input->manifest_buf.len = call->rcx_out;
-
-	if (call->rdx_out != call->rdx)
-		input->certificates_buf.len = call->rdx_out;
-
-	if (call->r8_out != call->r8)
-		input->report_buf.len = call->r8_out;
-}
-
-int snp_issue_svsm_attest_req(u64 call_id, struct svsm_call *call,
-			      struct svsm_attest_call *input)
-{
-	struct svsm_attest_call *ac;
-	unsigned long flags;
-	u64 attest_call_pa;
-	int ret;
-
-	if (!snp_vmpl)
-		return -EINVAL;
-
-	local_irq_save(flags);
-
-	call->caa = svsm_get_caa();
-
-	ac = (struct svsm_attest_call *)call->caa->svsm_buffer;
-	attest_call_pa = svsm_get_caa_pa() + offsetof(struct svsm_ca, svsm_buffer);
-
-	*ac = *input;
-
-	/*
-	 * Set input registers for the request and set RDX and R8 to known
-	 * values in order to detect length values being returned in them.
-	 */
-	call->rax = call_id;
-	call->rcx = attest_call_pa;
-	call->rdx = -1;
-	call->r8 = -1;
-	ret = svsm_perform_call_protocol(call);
-	update_attest_input(call, input);
-
-	local_irq_restore(flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snp_issue_svsm_attest_req);
-
-int snp_issue_guest_request(u64 exit_code, struct snp_req_data *input, struct snp_guest_request_ioctl *rio)
-{
-	struct ghcb_state state;
-	struct es_em_ctxt ctxt;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	int ret;
-
-	rio->exitinfo2 = SEV_RET_NO_FW_CALL;
-
-	/*
-	 * __sev_get_ghcb() needs to run with IRQs disabled because it is using
-	 * a per-CPU GHCB.
-	 */
-	local_irq_save(flags);
-
-	ghcb = __sev_get_ghcb(&state);
-	if (!ghcb) {
-		ret = -EIO;
-		goto e_restore_irq;
-	}
-
-	vc_ghcb_invalidate(ghcb);
-
-	if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
-		ghcb_set_rax(ghcb, input->data_gpa);
-		ghcb_set_rbx(ghcb, input->data_npages);
-	}
-
-	ret = sev_es_ghcb_hv_call(ghcb, &ctxt, exit_code, input->req_gpa, input->resp_gpa);
-	if (ret)
-		goto e_put;
-
-	rio->exitinfo2 = ghcb->save.sw_exit_info_2;
-	switch (rio->exitinfo2) {
-	case 0:
-		break;
-
-	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_BUSY):
-		ret = -EAGAIN;
-		break;
-
-	case SNP_GUEST_VMM_ERR(SNP_GUEST_VMM_ERR_INVALID_LEN):
-		/* Number of expected pages are returned in RBX */
-		if (exit_code == SVM_VMGEXIT_EXT_GUEST_REQUEST) {
-			input->data_npages = ghcb_get_rbx(ghcb);
-			ret = -ENOSPC;
-			break;
-		}
-		fallthrough;
-	default:
-		ret = -EIO;
-		break;
-	}
-
-e_put:
-	__sev_put_ghcb(&state);
-e_restore_irq:
-	local_irq_restore(flags);
-
-	return ret;
-}
-EXPORT_SYMBOL_GPL(snp_issue_guest_request);
-
-static struct platform_device sev_guest_device = {
-	.name		= "sev-guest",
-	.id		= -1,
-};
-
-static int __init snp_init_platform_device(void)
-{
-	struct sev_guest_platform_data data;
-	u64 gpa;
-
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return -ENODEV;
-
-	gpa = get_secrets_page();
-	if (!gpa)
-		return -ENODEV;
-
-	data.secrets_gpa = gpa;
-	if (platform_device_add_data(&sev_guest_device, &data, sizeof(data)))
-		return -ENODEV;
-
-	if (platform_device_register(&sev_guest_device))
-		return -ENODEV;
-
-	pr_info("SNP guest platform device initialized.\n");
-	return 0;
-}
-device_initcall(snp_init_platform_device);
-
-void sev_show_status(void)
-{
-	int i;
-
-	pr_info("Status: ");
-	for (i = 0; i < MSR_AMD64_SNP_RESV_BIT; i++) {
-		if (sev_status & BIT_ULL(i)) {
-			if (!sev_status_feat_names[i])
-				continue;
-
-			pr_cont("%s ", sev_status_feat_names[i]);
-		}
-	}
-	pr_cont("\n");
-}
-
-void __init snp_update_svsm_ca(void)
-{
-	if (!snp_vmpl)
-		return;
-
-	/* Update the CAA to a proper kernel address */
-	boot_svsm_caa = &boot_svsm_ca_page;
-}
-
-#ifdef CONFIG_SYSFS
-static ssize_t vmpl_show(struct kobject *kobj,
-			 struct kobj_attribute *attr, char *buf)
-{
-	return sysfs_emit(buf, "%d\n", snp_vmpl);
-}
-
-static struct kobj_attribute vmpl_attr = __ATTR_RO(vmpl);
-
-static struct attribute *vmpl_attrs[] = {
-	&vmpl_attr.attr,
-	NULL
-};
-
-static struct attribute_group sev_attr_group = {
-	.attrs = vmpl_attrs,
-};
-
-static int __init sev_sysfs_init(void)
-{
-	struct kobject *sev_kobj;
-	struct device *dev_root;
-	int ret;
-
-	if (!cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
-		return -ENODEV;
-
-	dev_root = bus_get_dev_root(&cpu_subsys);
-	if (!dev_root)
-		return -ENODEV;
-
-	sev_kobj = kobject_create_and_add("sev", &dev_root->kobj);
-	put_device(dev_root);
-
-	if (!sev_kobj)
-		return -ENOMEM;
-
-	ret = sysfs_create_group(sev_kobj, &sev_attr_group);
-	if (ret)
-		kobject_put(sev_kobj);
-
-	return ret;
-}
-arch_initcall(sev_sysfs_init);
-#endif // CONFIG_SYSFS

