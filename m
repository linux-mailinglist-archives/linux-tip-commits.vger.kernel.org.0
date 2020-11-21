Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0CAB2BBE95
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Nov 2020 12:07:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727522AbgKULHF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 21 Nov 2020 06:07:05 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45680 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727518AbgKULHE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 21 Nov 2020 06:07:04 -0500
Date:   Sat, 21 Nov 2020 11:06:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txlSfJqKhThbhT7CLn9D7/3R9bz1dZaP9JTohNLFxoE=;
        b=dS1YwvJsQouUyqRCgH7ydW3xOcG8i3xWFLBuSrBsHtGzGmkRN+ImcyuCWVTlgTFH+VPiIx
        teA59i33N4x39oCAg2H/Ld4WZV6djztrkx5fBU6KWR+ipvFq3uwpzpmsPsBDkLZBiPYLWI
        GF+x6hfjYTZzmKn3HFOQd2KKrju7YoZfWM01EdwFDyDJ6PlIRTCK/b9aUT2wPoEAZD3Cie
        /ILC0yi9PPGK939Fn2Q+o9Zny5EbXQ5HsK17MJ2hODTAukL4fQ+ZZLLjlIXzdieY8V81Jb
        aYrTQiRKXp4cvpt+/bVci323WcrZIFPBtmYJFWrO2EzvOKAxBP3C2Vk1OSYzWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605956820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=txlSfJqKhThbhT7CLn9D7/3R9bz1dZaP9JTohNLFxoE=;
        b=9K9GV+nHGBpH3Kx1AsrPD3ZtYO5cae5zyzKGL6QixJ4nCXkbpiPX4zOQaWw+ZyZwOLlYXa
        FoDokZDnWdVwxeBw==
From:   "tip-bot2 for Smita Koralahalli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce, cper: Pass x86 CPER through the MCA handling chain
Cc:     kernel test robot <lkp@intel.com>,
        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>,
        Borislav Petkov <bp@suse.de>,
        Punit Agrawal <punit1.agrawal@toshiba.co.jp>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201119182938.151155-1-Smita.KoralahalliChannabasappa@amd.com>
References: <20201119182938.151155-1-Smita.KoralahalliChannabasappa@amd.com>
MIME-Version: 1.0
Message-ID: <160595681938.11244.13446793891723739104.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4a24d80b8c3e9f89d6a6a7b89bd057c463b638d3
Gitweb:        https://git.kernel.org/tip/4a24d80b8c3e9f89d6a6a7b89bd057c463b638d3
Author:        Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
AuthorDate:    Thu, 19 Nov 2020 12:29:38 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sat, 21 Nov 2020 12:05:41 +01:00

x86/mce, cper: Pass x86 CPER through the MCA handling chain

The kernel uses ACPI Boot Error Record Table (BERT) to report fatal
errors that occurred in a previous boot. The MCA errors in the BERT are
reported using the x86 Processor Error Common Platform Error Record
(CPER) format. Currently, the record prints out the raw MSR values and
AMD relies on the raw record to provide MCA information.

Extract the raw MSR values of MCA registers from the BERT and feed them
into mce_log() to decode them properly.

The implementation is SMCA-specific as the raw MCA register values are
given in the register offset order of the SMCA address space.

 [ bp: Massage. ]

[ Fix a build breakage in patch v1. ]
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Smita Koralahalli <Smita.KoralahalliChannabasappa@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Punit Agrawal <punit1.agrawal@toshiba.co.jp>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20201119182938.151155-1-Smita.KoralahalliChannabasappa@amd.com
---
 arch/x86/include/asm/acpi.h     | 11 ++++++-
 arch/x86/include/asm/mce.h      |  6 +++-
 arch/x86/kernel/acpi/apei.c     |  5 +++-
 arch/x86/kernel/cpu/mce/apei.c  | 61 ++++++++++++++++++++++++++++++++-
 drivers/firmware/efi/cper-x86.c | 11 ++++--
 5 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/acpi.h b/arch/x86/include/asm/acpi.h
index 6d2df1e..65064d9 100644
--- a/arch/x86/include/asm/acpi.h
+++ b/arch/x86/include/asm/acpi.h
@@ -159,6 +159,8 @@ static inline u64 x86_default_get_root_pointer(void)
 extern int x86_acpi_numa_init(void);
 #endif /* CONFIG_ACPI_NUMA */
 
+struct cper_ia_proc_ctx;
+
 #ifdef CONFIG_ACPI_APEI
 static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 {
@@ -177,6 +179,15 @@ static inline pgprot_t arch_apei_get_mem_attribute(phys_addr_t addr)
 	 */
 	return PAGE_KERNEL_NOENC;
 }
+
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+			       u64 lapic_id);
+#else
+static inline int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+					     u64 lapic_id)
+{
+	return -EINVAL;
+}
 #endif
 
 #define ACPI_TABLE_UPGRADE_MAX_PHYS (max_low_pfn_mapped << PAGE_SHIFT)
diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index fc25c88..56cdeaa 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -199,16 +199,22 @@ static inline void enable_copy_mc_fragile(void)
 }
 #endif
 
+struct cper_ia_proc_ctx;
+
 #ifdef CONFIG_X86_MCE
 int mcheck_init(void);
 void mcheck_cpu_init(struct cpuinfo_x86 *c);
 void mcheck_cpu_clear(struct cpuinfo_x86 *c);
 void mcheck_vendor_init_severity(void);
+int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+			       u64 lapic_id);
 #else
 static inline int mcheck_init(void) { return 0; }
 static inline void mcheck_cpu_init(struct cpuinfo_x86 *c) {}
 static inline void mcheck_cpu_clear(struct cpuinfo_x86 *c) {}
 static inline void mcheck_vendor_init_severity(void) {}
+static inline int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info,
+					     u64 lapic_id) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_X86_ANCIENT_MCE
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index c22fb55..0916f00 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -43,3 +43,8 @@ void arch_apei_report_mem_error(int sev, struct cper_sec_mem_err *mem_err)
 	apei_mce_report_mem_error(sev, mem_err);
 #endif
 }
+
+int arch_apei_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
+{
+	return apei_smca_report_x86_error(ctx_info, lapic_id);
+}
diff --git a/arch/x86/kernel/cpu/mce/apei.c b/arch/x86/kernel/cpu/mce/apei.c
index af8d379..b58b853 100644
--- a/arch/x86/kernel/cpu/mce/apei.c
+++ b/arch/x86/kernel/cpu/mce/apei.c
@@ -51,6 +51,67 @@ void apei_mce_report_mem_error(int severity, struct cper_sec_mem_err *mem_err)
 }
 EXPORT_SYMBOL_GPL(apei_mce_report_mem_error);
 
+int apei_smca_report_x86_error(struct cper_ia_proc_ctx *ctx_info, u64 lapic_id)
+{
+	const u64 *i_mce = ((const u64 *) (ctx_info + 1));
+	unsigned int cpu;
+	struct mce m;
+
+	if (!boot_cpu_has(X86_FEATURE_SMCA))
+		return -EINVAL;
+
+	/*
+	 * The starting address of the register array extracted from BERT must
+	 * match with the first expected register in the register layout of
+	 * SMCA address space. This address corresponds to banks's MCA_STATUS
+	 * register.
+	 *
+	 * Match any MCi_STATUS register by turning off bank numbers.
+	 */
+	if ((ctx_info->msr_addr & MSR_AMD64_SMCA_MC0_STATUS) !=
+				  MSR_AMD64_SMCA_MC0_STATUS)
+		return -EINVAL;
+
+	/*
+	 * The register array size must be large enough to include all the
+	 * SMCA registers which need to be extracted.
+	 *
+	 * The number of registers in the register array is determined by
+	 * Register Array Size/8 as defined in UEFI spec v2.8, sec N.2.4.2.2.
+	 * The register layout is fixed and currently the raw data in the
+	 * register array includes 6 SMCA registers which the kernel can
+	 * extract.
+	 */
+	if (ctx_info->reg_arr_size < 48)
+		return -EINVAL;
+
+	mce_setup(&m);
+
+	m.extcpu = -1;
+	m.socketid = -1;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_data(cpu).initial_apicid == lapic_id) {
+			m.extcpu = cpu;
+			m.socketid = cpu_data(m.extcpu).phys_proc_id;
+			break;
+		}
+	}
+
+	m.apicid = lapic_id;
+	m.bank = (ctx_info->msr_addr >> 4) & 0xFF;
+	m.status = *i_mce;
+	m.addr = *(i_mce + 1);
+	m.misc = *(i_mce + 2);
+	/* Skipping MCA_CONFIG */
+	m.ipid = *(i_mce + 4);
+	m.synd = *(i_mce + 5);
+
+	mce_log(&m);
+
+	return 0;
+}
+
 #define CPER_CREATOR_MCE						\
 	GUID_INIT(0x75a574e3, 0x5052, 0x4b29, 0x8a, 0x8e, 0xbe, 0x2c,	\
 		  0x64, 0x90, 0xb8, 0x9d)
diff --git a/drivers/firmware/efi/cper-x86.c b/drivers/firmware/efi/cper-x86.c
index 2531de4..438ed9e 100644
--- a/drivers/firmware/efi/cper-x86.c
+++ b/drivers/firmware/efi/cper-x86.c
@@ -2,6 +2,7 @@
 // Copyright (C) 2018, Advanced Micro Devices, Inc.
 
 #include <linux/cper.h>
+#include <linux/acpi.h>
 
 /*
  * We don't need a "CPER_IA" prefix since these are all locally defined.
@@ -347,9 +348,13 @@ void cper_print_proc_ia(const char *pfx, const struct cper_sec_proc_ia *proc)
 			       ctx_info->mm_reg_addr);
 		}
 
-		printk("%sRegister Array:\n", newpfx);
-		print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16, groupsize,
-			       (ctx_info + 1), ctx_info->reg_arr_size, 0);
+		if (ctx_info->reg_ctx_type != CTX_TYPE_MSR ||
+		    arch_apei_report_x86_error(ctx_info, proc->lapic_id)) {
+			printk("%sRegister Array:\n", newpfx);
+			print_hex_dump(newpfx, "", DUMP_PREFIX_OFFSET, 16,
+				       groupsize, (ctx_info + 1),
+				       ctx_info->reg_arr_size, 0);
+		}
 
 		ctx_info = (struct cper_ia_proc_ctx *)((long)ctx_info + size);
 	}
