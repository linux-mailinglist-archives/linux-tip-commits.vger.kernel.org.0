Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9CB377E6B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 May 2021 10:43:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbhEJIoP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 10 May 2021 04:44:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbhEJIoN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 10 May 2021 04:44:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5863BC061574;
        Mon, 10 May 2021 01:43:05 -0700 (PDT)
Date:   Mon, 10 May 2021 08:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620636183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KTjyY8fi2JlDiyf369YAxBCX34EnNm3MeQpUYA9ay4=;
        b=X6bUzysHnmWI3gj+fSI3IuDobWc/0jLMVb8hfhW/csHmXXepo6rFAaGRjl1YltWYAbtBSO
        HmJNo2YKTJ7rWWEfUjq2Vj4tfP6Yi6k4tRSgV1rxUpv6fDRuqdV/wYtdP8bcBLWtU7WnTx
        clAEFI0jYm1uPDRAipt1Jx7uwxopxwC9oayJKUTPo6QOi8Y5nkc6LMUR2QI5tfUkZ6khNJ
        UnY4KAL7hQIZZ5kwllxwPDruBLBVNIRYKHhsPvDfxDgddx++72zzYop/Aq+UvhMZAGa4dS
        uMHeTOS5e/IbfuH7jxqr5CblqnCpW3CqvtbEQxjbXJUh39/ISmScVCxMe5MeWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620636183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7KTjyY8fi2JlDiyf369YAxBCX34EnNm3MeQpUYA9ay4=;
        b=QV3dpglSLp7mv6rXu7rGNSuChfnWe2HjLjmV8xo1LUHQ3wWHyLrhYYEhackN/FuQTgg2Yg
        ajYYqRXHzmJVlsAw==
From:   "tip-bot2 for Brijesh Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/sev-es: Rename sev-es.{ch} to sev.{ch}
Cc:     Brijesh Singh <brijesh.singh@amd.com>,
        Borislav Petkov <bp@suse.de>, Joerg Roedel <jroedel@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210427111636.1207-2-brijesh.singh@amd.com>
References: <20210427111636.1207-2-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <162063618298.29796.2768335483145893203.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     e759959fe3b8313c81d6200be44cb8a644d845ea
Gitweb:        https://git.kernel.org/tip/e759959fe3b8313c81d6200be44cb8a644d845ea
Author:        Brijesh Singh <brijesh.singh@amd.com>
AuthorDate:    Tue, 27 Apr 2021 06:16:34 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 10 May 2021 07:40:27 +02:00

x86/sev-es: Rename sev-es.{ch} to sev.{ch}

SEV-SNP builds upon the SEV-ES functionality while adding new hardware
protection. Version 2 of the GHCB specification adds new NAE events that
are SEV-SNP specific. Rename the sev-es.{ch} to sev.{ch} so that all
SEV* functionality can be consolidated in one place.

Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Joerg Roedel <jroedel@suse.de>
Link: https://lkml.kernel.org/r/20210427111636.1207-2-brijesh.singh@amd.com
---
 arch/x86/boot/compressed/Makefile |    6 +-
 arch/x86/boot/compressed/sev-es.c |  206 +----
 arch/x86/boot/compressed/sev.c    |  206 ++++-
 arch/x86/include/asm/sev-es.h     |  114 +--
 arch/x86/include/asm/sev.h        |  114 ++-
 arch/x86/kernel/Makefile          |    6 +-
 arch/x86/kernel/head64.c          |    2 +-
 arch/x86/kernel/nmi.c             |    2 +-
 arch/x86/kernel/sev-es-shared.c   |  525 +----------
 arch/x86/kernel/sev-es.c          | 1461 +----------------------------
 arch/x86/kernel/sev-shared.c      |  525 ++++++++++-
 arch/x86/kernel/sev.c             | 1461 ++++++++++++++++++++++++++++-
 arch/x86/mm/extable.c             |    2 +-
 arch/x86/platform/efi/efi_64.c    |    2 +-
 arch/x86/realmode/init.c          |    2 +-
 15 files changed, 2317 insertions(+), 2317 deletions(-)
 delete mode 100644 arch/x86/boot/compressed/sev-es.c
 create mode 100644 arch/x86/boot/compressed/sev.c
 delete mode 100644 arch/x86/include/asm/sev-es.h
 create mode 100644 arch/x86/include/asm/sev.h
 delete mode 100644 arch/x86/kernel/sev-es-shared.c
 delete mode 100644 arch/x86/kernel/sev-es.c
 create mode 100644 arch/x86/kernel/sev-shared.c
 create mode 100644 arch/x86/kernel/sev.c

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index 6e5522a..2a29752 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -48,10 +48,10 @@ KBUILD_CFLAGS += $(call as-option,-Wa$(comma)-mrelax-relocations=no)
 KBUILD_CFLAGS += -include $(srctree)/include/linux/hidden.h
 KBUILD_CFLAGS += $(CLANG_FLAGS)
 
-# sev-es.c indirectly inludes inat-table.h which is generated during
+# sev.c indirectly inludes inat-table.h which is generated during
 # compilation and stored in $(objtree). Add the directory to the includes so
 # that the compiler finds it even with out-of-tree builds (make O=/some/path).
-CFLAGS_sev-es.o += -I$(objtree)/arch/x86/lib/
+CFLAGS_sev.o += -I$(objtree)/arch/x86/lib/
 
 KBUILD_AFLAGS  := $(KBUILD_CFLAGS) -D__ASSEMBLY__
 GCOV_PROFILE := n
@@ -93,7 +93,7 @@ ifdef CONFIG_X86_64
 	vmlinux-objs-y += $(obj)/idt_64.o $(obj)/idt_handlers_64.o
 	vmlinux-objs-y += $(obj)/mem_encrypt.o
 	vmlinux-objs-y += $(obj)/pgtable_64.o
-	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev-es.o
+	vmlinux-objs-$(CONFIG_AMD_MEM_ENCRYPT) += $(obj)/sev.o
 endif
 
 vmlinux-objs-$(CONFIG_ACPI) += $(obj)/acpi.o
diff --git a/arch/x86/boot/compressed/sev-es.c b/arch/x86/boot/compressed/sev-es.c
deleted file mode 100644
index 82041bd..0000000
--- a/arch/x86/boot/compressed/sev-es.c
+++ /dev/null
@@ -1,206 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * AMD Encrypted Register State Support
- *
- * Author: Joerg Roedel <jroedel@suse.de>
- */
-
-/*
- * misc.h needs to be first because it knows how to include the other kernel
- * headers in the pre-decompression code in a way that does not break
- * compilation.
- */
-#include "misc.h"
-
-#include <asm/pgtable_types.h>
-#include <asm/sev-es.h>
-#include <asm/trapnr.h>
-#include <asm/trap_pf.h>
-#include <asm/msr-index.h>
-#include <asm/fpu/xcr.h>
-#include <asm/ptrace.h>
-#include <asm/svm.h>
-
-#include "error.h"
-
-struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
-struct ghcb *boot_ghcb;
-
-/*
- * Copy a version of this function here - insn-eval.c can't be used in
- * pre-decompression code.
- */
-static bool insn_has_rep_prefix(struct insn *insn)
-{
-	insn_byte_t p;
-	int i;
-
-	insn_get_prefixes(insn);
-
-	for_each_insn_prefix(insn, i, p) {
-		if (p == 0xf2 || p == 0xf3)
-			return true;
-	}
-
-	return false;
-}
-
-/*
- * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
- * doesn't use segments.
- */
-static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
-{
-	return 0UL;
-}
-
-static inline u64 sev_es_rd_ghcb_msr(void)
-{
-	unsigned long low, high;
-
-	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
-			"c" (MSR_AMD64_SEV_ES_GHCB));
-
-	return ((high << 32) | low);
-}
-
-static inline void sev_es_wr_ghcb_msr(u64 val)
-{
-	u32 low, high;
-
-	low  = val & 0xffffffffUL;
-	high = val >> 32;
-
-	asm volatile("wrmsr" : : "c" (MSR_AMD64_SEV_ES_GHCB),
-			"a"(low), "d" (high) : "memory");
-}
-
-static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
-{
-	char buffer[MAX_INSN_SIZE];
-	int ret;
-
-	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
-
-	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
-	if (ret < 0)
-		return ES_DECODE_FAILED;
-
-	return ES_OK;
-}
-
-static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
-				   void *dst, char *buf, size_t size)
-{
-	memcpy(dst, buf, size);
-
-	return ES_OK;
-}
-
-static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
-				  void *src, char *buf, size_t size)
-{
-	memcpy(buf, src, size);
-
-	return ES_OK;
-}
-
-#undef __init
-#undef __pa
-#define __init
-#define __pa(x)	((unsigned long)(x))
-
-#define __BOOT_COMPRESSED
-
-/* Basic instruction decoding support needed */
-#include "../../lib/inat.c"
-#include "../../lib/insn.c"
-
-/* Include code for early handlers */
-#include "../../kernel/sev-es-shared.c"
-
-static bool early_setup_sev_es(void)
-{
-	if (!sev_es_negotiate_protocol())
-		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
-
-	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
-		return false;
-
-	/* Page is now mapped decrypted, clear it */
-	memset(&boot_ghcb_page, 0, sizeof(boot_ghcb_page));
-
-	boot_ghcb = &boot_ghcb_page;
-
-	/* Initialize lookup tables for the instruction decoder */
-	inat_init_tables();
-
-	return true;
-}
-
-void sev_es_shutdown_ghcb(void)
-{
-	if (!boot_ghcb)
-		return;
-
-	if (!sev_es_check_cpu_features())
-		error("SEV-ES CPU Features missing.");
-
-	/*
-	 * GHCB Page must be flushed from the cache and mapped encrypted again.
-	 * Otherwise the running kernel will see strange cache effects when
-	 * trying to use that page.
-	 */
-	if (set_page_encrypted((unsigned long)&boot_ghcb_page))
-		error("Can't map GHCB page encrypted");
-
-	/*
-	 * GHCB page is mapped encrypted again and flushed from the cache.
-	 * Mark it non-present now to catch bugs when #VC exceptions trigger
-	 * after this point.
-	 */
-	if (set_page_non_present((unsigned long)&boot_ghcb_page))
-		error("Can't unmap GHCB page");
-}
-
-bool sev_es_check_ghcb_fault(unsigned long address)
-{
-	/* Check whether the fault was on the GHCB page */
-	return ((address & PAGE_MASK) == (unsigned long)&boot_ghcb_page);
-}
-
-void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
-{
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-
-	if (!boot_ghcb && !early_setup_sev_es())
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
-
-	vc_ghcb_invalidate(boot_ghcb);
-	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
-	if (result != ES_OK)
-		goto finish;
-
-	switch (exit_code) {
-	case SVM_EXIT_RDTSC:
-	case SVM_EXIT_RDTSCP:
-		result = vc_handle_rdtsc(boot_ghcb, &ctxt, exit_code);
-		break;
-	case SVM_EXIT_IOIO:
-		result = vc_handle_ioio(boot_ghcb, &ctxt);
-		break;
-	case SVM_EXIT_CPUID:
-		result = vc_handle_cpuid(boot_ghcb, &ctxt);
-		break;
-	default:
-		result = ES_UNSUPPORTED;
-		break;
-	}
-
-finish:
-	if (result == ES_OK)
-		vc_finish_insn(&ctxt);
-	else if (result != ES_RETRY)
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
-}
diff --git a/arch/x86/boot/compressed/sev.c b/arch/x86/boot/compressed/sev.c
new file mode 100644
index 0000000..670e998
--- /dev/null
+++ b/arch/x86/boot/compressed/sev.c
@@ -0,0 +1,206 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * AMD Encrypted Register State Support
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+/*
+ * misc.h needs to be first because it knows how to include the other kernel
+ * headers in the pre-decompression code in a way that does not break
+ * compilation.
+ */
+#include "misc.h"
+
+#include <asm/pgtable_types.h>
+#include <asm/sev.h>
+#include <asm/trapnr.h>
+#include <asm/trap_pf.h>
+#include <asm/msr-index.h>
+#include <asm/fpu/xcr.h>
+#include <asm/ptrace.h>
+#include <asm/svm.h>
+
+#include "error.h"
+
+struct ghcb boot_ghcb_page __aligned(PAGE_SIZE);
+struct ghcb *boot_ghcb;
+
+/*
+ * Copy a version of this function here - insn-eval.c can't be used in
+ * pre-decompression code.
+ */
+static bool insn_has_rep_prefix(struct insn *insn)
+{
+	insn_byte_t p;
+	int i;
+
+	insn_get_prefixes(insn);
+
+	for_each_insn_prefix(insn, i, p) {
+		if (p == 0xf2 || p == 0xf3)
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Only a dummy for insn_get_seg_base() - Early boot-code is 64bit only and
+ * doesn't use segments.
+ */
+static unsigned long insn_get_seg_base(struct pt_regs *regs, int seg_reg_idx)
+{
+	return 0UL;
+}
+
+static inline u64 sev_es_rd_ghcb_msr(void)
+{
+	unsigned long low, high;
+
+	asm volatile("rdmsr" : "=a" (low), "=d" (high) :
+			"c" (MSR_AMD64_SEV_ES_GHCB));
+
+	return ((high << 32) | low);
+}
+
+static inline void sev_es_wr_ghcb_msr(u64 val)
+{
+	u32 low, high;
+
+	low  = val & 0xffffffffUL;
+	high = val >> 32;
+
+	asm volatile("wrmsr" : : "c" (MSR_AMD64_SEV_ES_GHCB),
+			"a"(low), "d" (high) : "memory");
+}
+
+static enum es_result vc_decode_insn(struct es_em_ctxt *ctxt)
+{
+	char buffer[MAX_INSN_SIZE];
+	int ret;
+
+	memcpy(buffer, (unsigned char *)ctxt->regs->ip, MAX_INSN_SIZE);
+
+	ret = insn_decode(&ctxt->insn, buffer, MAX_INSN_SIZE, INSN_MODE_64);
+	if (ret < 0)
+		return ES_DECODE_FAILED;
+
+	return ES_OK;
+}
+
+static enum es_result vc_write_mem(struct es_em_ctxt *ctxt,
+				   void *dst, char *buf, size_t size)
+{
+	memcpy(dst, buf, size);
+
+	return ES_OK;
+}
+
+static enum es_result vc_read_mem(struct es_em_ctxt *ctxt,
+				  void *src, char *buf, size_t size)
+{
+	memcpy(buf, src, size);
+
+	return ES_OK;
+}
+
+#undef __init
+#undef __pa
+#define __init
+#define __pa(x)	((unsigned long)(x))
+
+#define __BOOT_COMPRESSED
+
+/* Basic instruction decoding support needed */
+#include "../../lib/inat.c"
+#include "../../lib/insn.c"
+
+/* Include code for early handlers */
+#include "../../kernel/sev-shared.c"
+
+static bool early_setup_sev_es(void)
+{
+	if (!sev_es_negotiate_protocol())
+		sev_es_terminate(GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED);
+
+	if (set_page_decrypted((unsigned long)&boot_ghcb_page))
+		return false;
+
+	/* Page is now mapped decrypted, clear it */
+	memset(&boot_ghcb_page, 0, sizeof(boot_ghcb_page));
+
+	boot_ghcb = &boot_ghcb_page;
+
+	/* Initialize lookup tables for the instruction decoder */
+	inat_init_tables();
+
+	return true;
+}
+
+void sev_es_shutdown_ghcb(void)
+{
+	if (!boot_ghcb)
+		return;
+
+	if (!sev_es_check_cpu_features())
+		error("SEV-ES CPU Features missing.");
+
+	/*
+	 * GHCB Page must be flushed from the cache and mapped encrypted again.
+	 * Otherwise the running kernel will see strange cache effects when
+	 * trying to use that page.
+	 */
+	if (set_page_encrypted((unsigned long)&boot_ghcb_page))
+		error("Can't map GHCB page encrypted");
+
+	/*
+	 * GHCB page is mapped encrypted again and flushed from the cache.
+	 * Mark it non-present now to catch bugs when #VC exceptions trigger
+	 * after this point.
+	 */
+	if (set_page_non_present((unsigned long)&boot_ghcb_page))
+		error("Can't unmap GHCB page");
+}
+
+bool sev_es_check_ghcb_fault(unsigned long address)
+{
+	/* Check whether the fault was on the GHCB page */
+	return ((address & PAGE_MASK) == (unsigned long)&boot_ghcb_page);
+}
+
+void do_boot_stage2_vc(struct pt_regs *regs, unsigned long exit_code)
+{
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	if (!boot_ghcb && !early_setup_sev_es())
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+
+	vc_ghcb_invalidate(boot_ghcb);
+	result = vc_init_em_ctxt(&ctxt, regs, exit_code);
+	if (result != ES_OK)
+		goto finish;
+
+	switch (exit_code) {
+	case SVM_EXIT_RDTSC:
+	case SVM_EXIT_RDTSCP:
+		result = vc_handle_rdtsc(boot_ghcb, &ctxt, exit_code);
+		break;
+	case SVM_EXIT_IOIO:
+		result = vc_handle_ioio(boot_ghcb, &ctxt);
+		break;
+	case SVM_EXIT_CPUID:
+		result = vc_handle_cpuid(boot_ghcb, &ctxt);
+		break;
+	default:
+		result = ES_UNSUPPORTED;
+		break;
+	}
+
+finish:
+	if (result == ES_OK)
+		vc_finish_insn(&ctxt);
+	else if (result != ES_RETRY)
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+}
diff --git a/arch/x86/include/asm/sev-es.h b/arch/x86/include/asm/sev-es.h
deleted file mode 100644
index cf1d957..0000000
--- a/arch/x86/include/asm/sev-es.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/*
- * AMD Encrypted Register State Support
- *
- * Author: Joerg Roedel <jroedel@suse.de>
- */
-
-#ifndef __ASM_ENCRYPTED_STATE_H
-#define __ASM_ENCRYPTED_STATE_H
-
-#include <linux/types.h>
-#include <asm/insn.h>
-
-#define GHCB_SEV_INFO		0x001UL
-#define GHCB_SEV_INFO_REQ	0x002UL
-#define		GHCB_INFO(v)		((v) & 0xfffUL)
-#define		GHCB_PROTO_MAX(v)	(((v) >> 48) & 0xffffUL)
-#define		GHCB_PROTO_MIN(v)	(((v) >> 32) & 0xffffUL)
-#define		GHCB_PROTO_OUR		0x0001UL
-#define GHCB_SEV_CPUID_REQ	0x004UL
-#define		GHCB_CPUID_REQ_EAX	0
-#define		GHCB_CPUID_REQ_EBX	1
-#define		GHCB_CPUID_REQ_ECX	2
-#define		GHCB_CPUID_REQ_EDX	3
-#define		GHCB_CPUID_REQ(fn, reg) (GHCB_SEV_CPUID_REQ | \
-					(((unsigned long)reg & 3) << 30) | \
-					(((unsigned long)fn) << 32))
-
-#define	GHCB_PROTOCOL_MAX	0x0001UL
-#define GHCB_DEFAULT_USAGE	0x0000UL
-
-#define GHCB_SEV_CPUID_RESP	0x005UL
-#define GHCB_SEV_TERMINATE	0x100UL
-#define		GHCB_SEV_TERMINATE_REASON(reason_set, reason_val)	\
-			(((((u64)reason_set) &  0x7) << 12) |		\
-			 ((((u64)reason_val) & 0xff) << 16))
-#define		GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
-#define		GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
-
-#define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
-#define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
-
-enum es_result {
-	ES_OK,			/* All good */
-	ES_UNSUPPORTED,		/* Requested operation not supported */
-	ES_VMM_ERROR,		/* Unexpected state from the VMM */
-	ES_DECODE_FAILED,	/* Instruction decoding failed */
-	ES_EXCEPTION,		/* Instruction caused exception */
-	ES_RETRY,		/* Retry instruction emulation */
-};
-
-struct es_fault_info {
-	unsigned long vector;
-	unsigned long error_code;
-	unsigned long cr2;
-};
-
-struct pt_regs;
-
-/* ES instruction emulation context */
-struct es_em_ctxt {
-	struct pt_regs *regs;
-	struct insn insn;
-	struct es_fault_info fi;
-};
-
-void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
-
-static inline u64 lower_bits(u64 val, unsigned int bits)
-{
-	u64 mask = (1ULL << bits) - 1;
-
-	return (val & mask);
-}
-
-struct real_mode_header;
-enum stack_type;
-
-/* Early IDT entry points for #VC handler */
-extern void vc_no_ghcb(void);
-extern void vc_boot_ghcb(void);
-extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
-
-#ifdef CONFIG_AMD_MEM_ENCRYPT
-extern struct static_key_false sev_es_enable_key;
-extern void __sev_es_ist_enter(struct pt_regs *regs);
-extern void __sev_es_ist_exit(void);
-static __always_inline void sev_es_ist_enter(struct pt_regs *regs)
-{
-	if (static_branch_unlikely(&sev_es_enable_key))
-		__sev_es_ist_enter(regs);
-}
-static __always_inline void sev_es_ist_exit(void)
-{
-	if (static_branch_unlikely(&sev_es_enable_key))
-		__sev_es_ist_exit();
-}
-extern int sev_es_setup_ap_jump_table(struct real_mode_header *rmh);
-extern void __sev_es_nmi_complete(void);
-static __always_inline void sev_es_nmi_complete(void)
-{
-	if (static_branch_unlikely(&sev_es_enable_key))
-		__sev_es_nmi_complete();
-}
-extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
-#else
-static inline void sev_es_ist_enter(struct pt_regs *regs) { }
-static inline void sev_es_ist_exit(void) { }
-static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
-static inline void sev_es_nmi_complete(void) { }
-static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
-#endif
-
-#endif
diff --git a/arch/x86/include/asm/sev.h b/arch/x86/include/asm/sev.h
new file mode 100644
index 0000000..cf1d957
--- /dev/null
+++ b/arch/x86/include/asm/sev.h
@@ -0,0 +1,114 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * AMD Encrypted Register State Support
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+#ifndef __ASM_ENCRYPTED_STATE_H
+#define __ASM_ENCRYPTED_STATE_H
+
+#include <linux/types.h>
+#include <asm/insn.h>
+
+#define GHCB_SEV_INFO		0x001UL
+#define GHCB_SEV_INFO_REQ	0x002UL
+#define		GHCB_INFO(v)		((v) & 0xfffUL)
+#define		GHCB_PROTO_MAX(v)	(((v) >> 48) & 0xffffUL)
+#define		GHCB_PROTO_MIN(v)	(((v) >> 32) & 0xffffUL)
+#define		GHCB_PROTO_OUR		0x0001UL
+#define GHCB_SEV_CPUID_REQ	0x004UL
+#define		GHCB_CPUID_REQ_EAX	0
+#define		GHCB_CPUID_REQ_EBX	1
+#define		GHCB_CPUID_REQ_ECX	2
+#define		GHCB_CPUID_REQ_EDX	3
+#define		GHCB_CPUID_REQ(fn, reg) (GHCB_SEV_CPUID_REQ | \
+					(((unsigned long)reg & 3) << 30) | \
+					(((unsigned long)fn) << 32))
+
+#define	GHCB_PROTOCOL_MAX	0x0001UL
+#define GHCB_DEFAULT_USAGE	0x0000UL
+
+#define GHCB_SEV_CPUID_RESP	0x005UL
+#define GHCB_SEV_TERMINATE	0x100UL
+#define		GHCB_SEV_TERMINATE_REASON(reason_set, reason_val)	\
+			(((((u64)reason_set) &  0x7) << 12) |		\
+			 ((((u64)reason_val) & 0xff) << 16))
+#define		GHCB_SEV_ES_REASON_GENERAL_REQUEST	0
+#define		GHCB_SEV_ES_REASON_PROTOCOL_UNSUPPORTED	1
+
+#define	GHCB_SEV_GHCB_RESP_CODE(v)	((v) & 0xfff)
+#define	VMGEXIT()			{ asm volatile("rep; vmmcall\n\r"); }
+
+enum es_result {
+	ES_OK,			/* All good */
+	ES_UNSUPPORTED,		/* Requested operation not supported */
+	ES_VMM_ERROR,		/* Unexpected state from the VMM */
+	ES_DECODE_FAILED,	/* Instruction decoding failed */
+	ES_EXCEPTION,		/* Instruction caused exception */
+	ES_RETRY,		/* Retry instruction emulation */
+};
+
+struct es_fault_info {
+	unsigned long vector;
+	unsigned long error_code;
+	unsigned long cr2;
+};
+
+struct pt_regs;
+
+/* ES instruction emulation context */
+struct es_em_ctxt {
+	struct pt_regs *regs;
+	struct insn insn;
+	struct es_fault_info fi;
+};
+
+void do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code);
+
+static inline u64 lower_bits(u64 val, unsigned int bits)
+{
+	u64 mask = (1ULL << bits) - 1;
+
+	return (val & mask);
+}
+
+struct real_mode_header;
+enum stack_type;
+
+/* Early IDT entry points for #VC handler */
+extern void vc_no_ghcb(void);
+extern void vc_boot_ghcb(void);
+extern bool handle_vc_boot_ghcb(struct pt_regs *regs);
+
+#ifdef CONFIG_AMD_MEM_ENCRYPT
+extern struct static_key_false sev_es_enable_key;
+extern void __sev_es_ist_enter(struct pt_regs *regs);
+extern void __sev_es_ist_exit(void);
+static __always_inline void sev_es_ist_enter(struct pt_regs *regs)
+{
+	if (static_branch_unlikely(&sev_es_enable_key))
+		__sev_es_ist_enter(regs);
+}
+static __always_inline void sev_es_ist_exit(void)
+{
+	if (static_branch_unlikely(&sev_es_enable_key))
+		__sev_es_ist_exit();
+}
+extern int sev_es_setup_ap_jump_table(struct real_mode_header *rmh);
+extern void __sev_es_nmi_complete(void);
+static __always_inline void sev_es_nmi_complete(void)
+{
+	if (static_branch_unlikely(&sev_es_enable_key))
+		__sev_es_nmi_complete();
+}
+extern int __init sev_es_efi_map_ghcbs(pgd_t *pgd);
+#else
+static inline void sev_es_ist_enter(struct pt_regs *regs) { }
+static inline void sev_es_ist_exit(void) { }
+static inline int sev_es_setup_ap_jump_table(struct real_mode_header *rmh) { return 0; }
+static inline void sev_es_nmi_complete(void) { }
+static inline int sev_es_efi_map_ghcbs(pgd_t *pgd) { return 0; }
+#endif
+
+#endif
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 0704c2a..0f66682 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -20,7 +20,7 @@ CFLAGS_REMOVE_kvmclock.o = -pg
 CFLAGS_REMOVE_ftrace.o = -pg
 CFLAGS_REMOVE_early_printk.o = -pg
 CFLAGS_REMOVE_head64.o = -pg
-CFLAGS_REMOVE_sev-es.o = -pg
+CFLAGS_REMOVE_sev.o = -pg
 endif
 
 KASAN_SANITIZE_head$(BITS).o				:= n
@@ -28,7 +28,7 @@ KASAN_SANITIZE_dumpstack.o				:= n
 KASAN_SANITIZE_dumpstack_$(BITS).o			:= n
 KASAN_SANITIZE_stacktrace.o				:= n
 KASAN_SANITIZE_paravirt.o				:= n
-KASAN_SANITIZE_sev-es.o					:= n
+KASAN_SANITIZE_sev.o					:= n
 
 # With some compiler versions the generated code results in boot hangs, caused
 # by several compilation units. To be safe, disable all instrumentation.
@@ -148,7 +148,7 @@ obj-$(CONFIG_UNWINDER_ORC)		+= unwind_orc.o
 obj-$(CONFIG_UNWINDER_FRAME_POINTER)	+= unwind_frame.o
 obj-$(CONFIG_UNWINDER_GUESS)		+= unwind_guess.o
 
-obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev-es.o
+obj-$(CONFIG_AMD_MEM_ENCRYPT)		+= sev.o
 ###
 # 64 bit specific files
 ifeq ($(CONFIG_X86_64),y)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 18be441..de01903 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -39,7 +39,7 @@
 #include <asm/realmode.h>
 #include <asm/extable.h>
 #include <asm/trapnr.h>
-#include <asm/sev-es.h>
+#include <asm/sev.h>
 
 /*
  * Manage page tables very early on.
diff --git a/arch/x86/kernel/nmi.c b/arch/x86/kernel/nmi.c
index 2ef961c..4bce802 100644
--- a/arch/x86/kernel/nmi.c
+++ b/arch/x86/kernel/nmi.c
@@ -33,7 +33,7 @@
 #include <asm/reboot.h>
 #include <asm/cache.h>
 #include <asm/nospec-branch.h>
-#include <asm/sev-es.h>
+#include <asm/sev.h>
 
 #define CREATE_TRACE_POINTS
 #include <trace/events/nmi.h>
diff --git a/arch/x86/kernel/sev-es-shared.c b/arch/x86/kernel/sev-es-shared.c
deleted file mode 100644
index 0aa9f13..0000000
--- a/arch/x86/kernel/sev-es-shared.c
+++ /dev/null
@@ -1,525 +0,0 @@
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
-#ifndef __BOOT_COMPRESSED
-#define error(v)	pr_err(v)
-#define has_cpuflag(f)	boot_cpu_has(f)
-#endif
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
-static void __noreturn sev_es_terminate(unsigned int reason)
-{
-	u64 val = GHCB_SEV_TERMINATE;
-
-	/*
-	 * Tell the hypervisor what went wrong - only reason-set 0 is
-	 * currently supported.
-	 */
-	val |= GHCB_SEV_TERMINATE_REASON(0, reason);
-
-	/* Request Guest Termination from Hypvervisor */
-	sev_es_wr_ghcb_msr(val);
-	VMGEXIT();
-
-	while (true)
-		asm volatile("hlt\n" : : : "memory");
-}
-
-static bool sev_es_negotiate_protocol(void)
-{
-	u64 val;
-
-	/* Do the GHCB protocol version negotiation */
-	sev_es_wr_ghcb_msr(GHCB_SEV_INFO_REQ);
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-
-	if (GHCB_INFO(val) != GHCB_SEV_INFO)
-		return false;
-
-	if (GHCB_PROTO_MAX(val) < GHCB_PROTO_OUR ||
-	    GHCB_PROTO_MIN(val) > GHCB_PROTO_OUR)
-		return false;
-
-	return true;
-}
-
-static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
-{
-	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
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
-static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
-					  struct es_em_ctxt *ctxt,
-					  u64 exit_code, u64 exit_info_1,
-					  u64 exit_info_2)
-{
-	enum es_result ret;
-
-	/* Fill in protocol and format specifiers */
-	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
-	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
-
-	ghcb_set_sw_exit_code(ghcb, exit_code);
-	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
-	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
-
-	sev_es_wr_ghcb_msr(__pa(ghcb));
-	VMGEXIT();
-
-	if ((ghcb->save.sw_exit_info_1 & 0xffffffff) == 1) {
-		u64 info = ghcb->save.sw_exit_info_2;
-		unsigned long v;
-
-		info = ghcb->save.sw_exit_info_2;
-		v = info & SVM_EVTINJ_VEC_MASK;
-
-		/* Check if exception information from hypervisor is sane. */
-		if ((info & SVM_EVTINJ_VALID) &&
-		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
-		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
-			ctxt->fi.vector = v;
-			if (info & SVM_EVTINJ_VALID_ERR)
-				ctxt->fi.error_code = info >> 32;
-			ret = ES_EXCEPTION;
-		} else {
-			ret = ES_VMM_ERROR;
-		}
-	} else {
-		ret = ES_OK;
-	}
-
-	return ret;
-}
-
-/*
- * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
- * page yet, so it only supports the MSR based communication with the
- * hypervisor and only the CPUID exit-code.
- */
-void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
-{
-	unsigned int fn = lower_bits(regs->ax, 32);
-	unsigned long val;
-
-	/* Only CPUID is supported via MSR protocol */
-	if (exit_code != SVM_EXIT_CPUID)
-		goto fail;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
-		goto fail;
-	regs->ax = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
-		goto fail;
-	regs->bx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
-		goto fail;
-	regs->cx = val >> 32;
-
-	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
-	VMGEXIT();
-	val = sev_es_rd_ghcb_msr();
-	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
-		goto fail;
-	regs->dx = val >> 32;
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
-	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
-}
-
-static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
-					  void *src, char *buf,
-					  unsigned int data_size,
-					  unsigned int count,
-					  bool backwards)
-{
-	int i, b = backwards ? -1 : 1;
-	enum es_result ret = ES_OK;
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
-	enum es_result ret = ES_OK;
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
-	*exitinfo = 0;
-
-	switch (insn->opcode.bytes[0]) {
-	/* INS opcodes */
-	case 0x6c:
-	case 0x6d:
-		*exitinfo |= IOIO_TYPE_INS;
-		*exitinfo |= IOIO_SEG_ES;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
-		break;
-
-	/* OUTS opcodes */
-	case 0x6e:
-	case 0x6f:
-		*exitinfo |= IOIO_TYPE_OUTS;
-		*exitinfo |= IOIO_SEG_DS;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
-		break;
-
-	/* IN immediate opcodes */
-	case 0xe4:
-	case 0xe5:
-		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (u8)insn->immediate.value << 16;
-		break;
-
-	/* OUT immediate opcodes */
-	case 0xe6:
-	case 0xe7:
-		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (u8)insn->immediate.value << 16;
-		break;
-
-	/* IN register opcodes */
-	case 0xec:
-	case 0xed:
-		*exitinfo |= IOIO_TYPE_IN;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
-		break;
-
-	/* OUT register opcodes */
-	case 0xee:
-	case 0xef:
-		*exitinfo |= IOIO_TYPE_OUT;
-		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
-		break;
-
-	default:
-		return ES_DECODE_FAILED;
-	}
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
-		break;
-	default:
-		/* Length determined by instruction parsing */
-		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
-						     : IOIO_DATA_32;
-	}
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
-	return ES_OK;
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
-static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
-				      struct es_em_ctxt *ctxt)
-{
-	struct pt_regs *regs = ctxt->regs;
-	u32 cr4 = native_read_cr4();
-	enum es_result ret;
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
diff --git a/arch/x86/kernel/sev-es.c b/arch/x86/kernel/sev-es.c
deleted file mode 100644
index 73873b0..0000000
--- a/arch/x86/kernel/sev-es.c
+++ /dev/null
@@ -1,1461 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * AMD Memory Encryption Support
- *
- * Copyright (C) 2019 SUSE
- *
- * Author: Joerg Roedel <jroedel@suse.de>
- */
-
-#define pr_fmt(fmt)	"SEV-ES: " fmt
-
-#include <linux/sched/debug.h>	/* For show_regs() */
-#include <linux/percpu-defs.h>
-#include <linux/mem_encrypt.h>
-#include <linux/lockdep.h>
-#include <linux/printk.h>
-#include <linux/mm_types.h>
-#include <linux/set_memory.h>
-#include <linux/memblock.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-
-#include <asm/cpu_entry_area.h>
-#include <asm/stacktrace.h>
-#include <asm/sev-es.h>
-#include <asm/insn-eval.h>
-#include <asm/fpu/internal.h>
-#include <asm/processor.h>
-#include <asm/realmode.h>
-#include <asm/traps.h>
-#include <asm/svm.h>
-#include <asm/smp.h>
-#include <asm/cpu.h>
-
-#define DR7_RESET_VALUE        0x400
-
-/* For early boot hypervisor communication in SEV-ES enabled guests */
-static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
-
-/*
- * Needs to be in the .data section because we need it NULL before bss is
- * cleared
- */
-static struct ghcb __initdata *boot_ghcb;
-
-/* #VC handler runtime per-CPU data */
-struct sev_es_runtime_data {
-	struct ghcb ghcb_page;
-
-	/* Physical storage for the per-CPU IST stack of the #VC handler */
-	char ist_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
-
-	/*
-	 * Physical storage for the per-CPU fall-back stack of the #VC handler.
-	 * The fall-back stack is used when it is not safe to switch back to the
-	 * interrupted stack in the #VC entry code.
-	 */
-	char fallback_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
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
-static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
-DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
-
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
-
-static void __init setup_vc_stacks(int cpu)
-{
-	struct sev_es_runtime_data *data;
-	struct cpu_entry_area *cea;
-	unsigned long vaddr;
-	phys_addr_t pa;
-
-	data = per_cpu(runtime_data, cpu);
-	cea  = get_cpu_entry_area(cpu);
-
-	/* Map #VC IST stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
-	pa    = __pa(data->ist_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
-
-	/* Map VC fall-back stack */
-	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
-	pa    = __pa(data->fallback_stack);
-	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
-}
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
-static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
-
-	data = this_cpu_read(runtime_data);
-	ghcb = &data->ghcb_page;
-
-	if (unlikely(data->ghcb_active)) {
-		/* GHCB is already in use - save its contents */
-
-		if (unlikely(data->backup_ghcb_active))
-			return NULL;
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
-static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
-{
-	struct sev_es_runtime_data *data;
-	struct ghcb *ghcb;
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
-		data->ghcb_active = false;
-	}
-}
-
-/* Needed in vc_early_forward_exception */
-void do_early_exception(struct pt_regs *regs, int trapnr);
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
-	int res;
-
-	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
-	if (!res) {
-		ctxt->fi.vector     = X86_TRAP_PF;
-		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
-		ctxt->fi.cr2        = ctxt->regs->ip;
-		return ES_EXCEPTION;
-	}
-
-	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
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
-	char __user *target = (char __user *)dst;
-	u64 d8;
-	u32 d4;
-	u16 d2;
-	u8  d1;
-
-	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
-	if (!user_mode(ctxt->regs) && !access_ok(target, size)) {
-		memcpy(dst, buf, size);
-		return ES_OK;
-	}
-
-	switch (size) {
-	case 1:
-		memcpy(&d1, buf, 1);
-		if (put_user(d1, target))
-			goto fault;
-		break;
-	case 2:
-		memcpy(&d2, buf, 2);
-		if (put_user(d2, target))
-			goto fault;
-		break;
-	case 4:
-		memcpy(&d4, buf, 4);
-		if (put_user(d4, target))
-			goto fault;
-		break;
-	case 8:
-		memcpy(&d8, buf, 8);
-		if (put_user(d8, target))
-			goto fault;
-		break;
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
-	char __user *s = (char __user *)src;
-	u64 d8;
-	u32 d4;
-	u16 d2;
-	u8  d1;
-
-	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
-	if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
-		memcpy(buf, src, size);
-		return ES_OK;
-	}
-
-	switch (size) {
-	case 1:
-		if (get_user(d1, s))
-			goto fault;
-		memcpy(buf, &d1, 1);
-		break;
-	case 2:
-		if (get_user(d2, s))
-			goto fault;
-		memcpy(buf, &d2, 2);
-		break;
-	case 4:
-		if (get_user(d4, s))
-			goto fault;
-		memcpy(buf, &d4, 4);
-		break;
-	case 8:
-		if (get_user(d8, s))
-			goto fault;
-		memcpy(buf, &d8, 8);
-		break;
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
-/* Include code shared with pre-decompression boot stage */
-#include "sev-es-shared.c"
-
-void noinstr __sev_es_nmi_complete(void)
-{
-	struct ghcb_state state;
-	struct ghcb *ghcb;
-
-	ghcb = sev_es_get_ghcb(&state);
-
-	vc_ghcb_invalidate(ghcb);
-	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
-	ghcb_set_sw_exit_info_1(ghcb, 0);
-	ghcb_set_sw_exit_info_2(ghcb, 0);
-
-	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
-	VMGEXIT();
-
-	sev_es_put_ghcb(&state);
-}
-
-static u64 get_jump_table_addr(void)
-{
-	struct ghcb_state state;
-	unsigned long flags;
-	struct ghcb *ghcb;
-	u64 ret = 0;
-
-	local_irq_save(flags);
-
-	ghcb = sev_es_get_ghcb(&state);
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
-	sev_es_put_ghcb(&state);
-
-	local_irq_restore(flags);
-
-	return ret;
-}
-
-int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
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
-	if (!sev_es_active())
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
-/*
- * This function runs on the first #VC exception after the kernel
- * switched to virtual addresses.
- */
-static bool __init sev_es_setup_ghcb(void)
-{
-	/* First make sure the hypervisor talks a supported protocol. */
-	if (!sev_es_negotiate_protocol())
-		return false;
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
-	return true;
-}
-
-#ifdef CONFIG_HOTPLUG_CPU
-static void sev_es_ap_hlt_loop(void)
-{
-	struct ghcb_state state;
-	struct ghcb *ghcb;
-
-	ghcb = sev_es_get_ghcb(&state);
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
-	sev_es_put_ghcb(&state);
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
-	start_cpu0();
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
-	data = memblock_alloc(sizeof(*data), PAGE_SIZE);
-	if (!data)
-		panic("Can't allocate SEV-ES runtime data");
-
-	per_cpu(runtime_data, cpu) = data;
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
-	if (!sev_es_active())
-		return;
-
-	if (!sev_es_check_cpu_features())
-		panic("SEV-ES CPU Features missing");
-
-	/* Enable SEV-ES special handling */
-	static_branch_enable(&sev_es_enable_key);
-
-	/* Initialize per-cpu GHCB pages */
-	for_each_possible_cpu(cpu) {
-		alloc_runtime_data(cpu);
-		init_ghcb(cpu);
-		setup_vc_stacks(cpu);
-	}
-
-	sev_es_setup_play_dead();
-
-	/* Secondary CPUs use the runtime #VC handler */
-	initial_vc_handler = (unsigned long)safe_stack_exc_vmm_communication;
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
-static long *vc_insn_get_reg(struct es_em_ctxt *ctxt)
-{
-	long *reg_array;
-	int offset;
-
-	reg_array = (long *)ctxt->regs;
-	offset    = insn_get_modrm_reg_off(&ctxt->insn, ctxt->regs);
-
-	if (offset < 0)
-		return NULL;
-
-	offset /= sizeof(long);
-
-	return reg_array + offset;
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
-static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
-						 struct es_em_ctxt *ctxt)
-{
-	struct insn *insn = &ctxt->insn;
-	unsigned int bytes = 0;
-	enum es_result ret;
-	int sign_byte;
-	long *reg_data;
-
-	switch (insn->opcode.bytes[1]) {
-		/* MMIO Read w/ zero-extension */
-	case 0xb6:
-		bytes = 1;
-		fallthrough;
-	case 0xb7:
-		if (!bytes)
-			bytes = 2;
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Zero extend based on operand size */
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
-		memset(reg_data, 0, insn->opnd_bytes);
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-
-		/* MMIO Read w/ sign-extension */
-	case 0xbe:
-		bytes = 1;
-		fallthrough;
-	case 0xbf:
-		if (!bytes)
-			bytes = 2;
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		/* Sign extend based on operand size */
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
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
-		memset(reg_data, sign_byte, insn->opnd_bytes);
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-
-	default:
-		ret = ES_UNSUPPORTED;
-	}
-
-	return ret;
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
-static enum es_result vc_handle_mmio(struct ghcb *ghcb,
-				     struct es_em_ctxt *ctxt)
-{
-	struct insn *insn = &ctxt->insn;
-	unsigned int bytes = 0;
-	enum es_result ret;
-	long *reg_data;
-
-	switch (insn->opcode.bytes[0]) {
-	/* MMIO Write */
-	case 0x88:
-		bytes = 1;
-		fallthrough;
-	case 0x89:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
-		memcpy(ghcb->shared_buffer, reg_data, bytes);
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
-		break;
-
-	case 0xc6:
-		bytes = 1;
-		fallthrough;
-	case 0xc7:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
-		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
-		break;
-
-		/* MMIO Read */
-	case 0x8a:
-		bytes = 1;
-		fallthrough;
-	case 0x8b:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
-		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
-		if (ret)
-			break;
-
-		reg_data = vc_insn_get_reg(ctxt);
-		if (!reg_data)
-			return ES_DECODE_FAILED;
-
-		/* Zero-extend for 32-bit operation */
-		if (bytes == 4)
-			*reg_data = 0;
-
-		memcpy(reg_data, ghcb->shared_buffer, bytes);
-		break;
-
-		/* MOVS instruction */
-	case 0xa4:
-		bytes = 1;
-		fallthrough;
-	case 0xa5:
-		if (!bytes)
-			bytes = insn->opnd_bytes;
-
-		ret = vc_handle_mmio_movs(ctxt, bytes);
-		break;
-		/* Two-Byte Opcodes */
-	case 0x0f:
-		ret = vc_handle_mmio_twobyte_ops(ghcb, ctxt);
-		break;
-	default:
-		ret = ES_UNSUPPORTED;
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
-static __always_inline void vc_handle_trap_db(struct pt_regs *regs)
-{
-	if (user_mode(regs))
-		noist_exc_debug(regs);
-	else
-		exc_debug(regs);
-}
-
-static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
-					 struct ghcb *ghcb,
-					 unsigned long exit_code)
-{
-	enum es_result result;
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
-	case X86_TRAP_AC:
-		exc_alignment_check(ctxt->regs, error_code);
-		break;
-	default:
-		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
-		BUG();
-	}
-}
-
-static __always_inline bool on_vc_fallback_stack(struct pt_regs *regs)
-{
-	unsigned long sp = (unsigned long)regs;
-
-	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
-}
-
-/*
- * Main #VC exception handler. It is called when the entry code was able to
- * switch off the IST to a safe kernel stack.
- *
- * With the current implementation it is always possible to switch to a safe
- * stack because #VC exceptions only happen at known places, like intercepted
- * instructions or accesses to MMIO areas/IO ports. They can also happen with
- * code instrumentation when the hypervisor intercepts #DB, but the critical
- * paths are forbidden to be instrumented, so #DB exceptions currently also
- * only happen in safe places.
- */
-DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
-{
-	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
-	irqentry_state_t irq_state;
-	struct ghcb_state state;
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-	struct ghcb *ghcb;
-
-	/*
-	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
-	 */
-	if (error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB) {
-		vc_handle_trap_db(regs);
-		return;
-	}
-
-	irq_state = irqentry_nmi_enter(regs);
-	lockdep_assert_irqs_disabled();
-	instrumentation_begin();
-
-	/*
-	 * This is invoked through an interrupt gate, so IRQs are disabled. The
-	 * code below might walk page-tables for user or kernel addresses, so
-	 * keep the IRQs disabled to protect us against concurrent TLB flushes.
-	 */
-
-	ghcb = sev_es_get_ghcb(&state);
-	if (!ghcb) {
-		/*
-		 * Mark GHCBs inactive so that panic() is able to print the
-		 * message.
-		 */
-		data->ghcb_active        = false;
-		data->backup_ghcb_active = false;
-
-		panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
-	}
-
-	vc_ghcb_invalidate(ghcb);
-	result = vc_init_em_ctxt(&ctxt, regs, error_code);
-
-	if (result == ES_OK)
-		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
-
-	sev_es_put_ghcb(&state);
-
-	/* Done - now check the result */
-	switch (result) {
-	case ES_OK:
-		vc_finish_insn(&ctxt);
-		break;
-	case ES_UNSUPPORTED:
-		pr_err_ratelimited("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		goto fail;
-	case ES_VMM_ERROR:
-		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		goto fail;
-	case ES_DECODE_FAILED:
-		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
-				   error_code, regs->ip);
-		goto fail;
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
-out:
-	instrumentation_end();
-	irqentry_nmi_exit(regs, irq_state);
-
-	return;
-
-fail:
-	if (user_mode(regs)) {
-		/*
-		 * Do not kill the machine if user-space triggered the
-		 * exception. Send SIGBUS instead and let user-space deal with
-		 * it.
-		 */
-		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
-	} else {
-		pr_emerg("PANIC: Unhandled #VC exception in kernel space (result=%d)\n",
-			 result);
-
-		/* Show some debug info */
-		show_regs(regs);
-
-		/* Ask hypervisor to sev_es_terminate */
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
-
-		/* If that fails and we get here - just panic */
-		panic("Returned from Terminate-Request to Hypervisor\n");
-	}
-
-	goto out;
-}
-
-/* This handler runs on the #VC fall-back stack. It can cause further #VC exceptions */
-DEFINE_IDTENTRY_VC_IST(exc_vmm_communication)
-{
-	instrumentation_begin();
-	panic("Can't handle #VC exception from unsupported context\n");
-	instrumentation_end();
-}
-
-DEFINE_IDTENTRY_VC(exc_vmm_communication)
-{
-	if (likely(!on_vc_fallback_stack(regs)))
-		safe_stack_exc_vmm_communication(regs, error_code);
-	else
-		ist_exc_vmm_communication(regs, error_code);
-}
-
-bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
-{
-	unsigned long exit_code = regs->orig_ax;
-	struct es_em_ctxt ctxt;
-	enum es_result result;
-
-	/* Do initial setup or terminate the guest */
-	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
-		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
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
-	while (true)
-		halt();
-}
diff --git a/arch/x86/kernel/sev-shared.c b/arch/x86/kernel/sev-shared.c
new file mode 100644
index 0000000..0aa9f13
--- /dev/null
+++ b/arch/x86/kernel/sev-shared.c
@@ -0,0 +1,525 @@
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
+#ifndef __BOOT_COMPRESSED
+#define error(v)	pr_err(v)
+#define has_cpuflag(f)	boot_cpu_has(f)
+#endif
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
+static void __noreturn sev_es_terminate(unsigned int reason)
+{
+	u64 val = GHCB_SEV_TERMINATE;
+
+	/*
+	 * Tell the hypervisor what went wrong - only reason-set 0 is
+	 * currently supported.
+	 */
+	val |= GHCB_SEV_TERMINATE_REASON(0, reason);
+
+	/* Request Guest Termination from Hypvervisor */
+	sev_es_wr_ghcb_msr(val);
+	VMGEXIT();
+
+	while (true)
+		asm volatile("hlt\n" : : : "memory");
+}
+
+static bool sev_es_negotiate_protocol(void)
+{
+	u64 val;
+
+	/* Do the GHCB protocol version negotiation */
+	sev_es_wr_ghcb_msr(GHCB_SEV_INFO_REQ);
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+
+	if (GHCB_INFO(val) != GHCB_SEV_INFO)
+		return false;
+
+	if (GHCB_PROTO_MAX(val) < GHCB_PROTO_OUR ||
+	    GHCB_PROTO_MIN(val) > GHCB_PROTO_OUR)
+		return false;
+
+	return true;
+}
+
+static __always_inline void vc_ghcb_invalidate(struct ghcb *ghcb)
+{
+	memset(ghcb->save.valid_bitmap, 0, sizeof(ghcb->save.valid_bitmap));
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
+static enum es_result sev_es_ghcb_hv_call(struct ghcb *ghcb,
+					  struct es_em_ctxt *ctxt,
+					  u64 exit_code, u64 exit_info_1,
+					  u64 exit_info_2)
+{
+	enum es_result ret;
+
+	/* Fill in protocol and format specifiers */
+	ghcb->protocol_version = GHCB_PROTOCOL_MAX;
+	ghcb->ghcb_usage       = GHCB_DEFAULT_USAGE;
+
+	ghcb_set_sw_exit_code(ghcb, exit_code);
+	ghcb_set_sw_exit_info_1(ghcb, exit_info_1);
+	ghcb_set_sw_exit_info_2(ghcb, exit_info_2);
+
+	sev_es_wr_ghcb_msr(__pa(ghcb));
+	VMGEXIT();
+
+	if ((ghcb->save.sw_exit_info_1 & 0xffffffff) == 1) {
+		u64 info = ghcb->save.sw_exit_info_2;
+		unsigned long v;
+
+		info = ghcb->save.sw_exit_info_2;
+		v = info & SVM_EVTINJ_VEC_MASK;
+
+		/* Check if exception information from hypervisor is sane. */
+		if ((info & SVM_EVTINJ_VALID) &&
+		    ((v == X86_TRAP_GP) || (v == X86_TRAP_UD)) &&
+		    ((info & SVM_EVTINJ_TYPE_MASK) == SVM_EVTINJ_TYPE_EXEPT)) {
+			ctxt->fi.vector = v;
+			if (info & SVM_EVTINJ_VALID_ERR)
+				ctxt->fi.error_code = info >> 32;
+			ret = ES_EXCEPTION;
+		} else {
+			ret = ES_VMM_ERROR;
+		}
+	} else {
+		ret = ES_OK;
+	}
+
+	return ret;
+}
+
+/*
+ * Boot VC Handler - This is the first VC handler during boot, there is no GHCB
+ * page yet, so it only supports the MSR based communication with the
+ * hypervisor and only the CPUID exit-code.
+ */
+void __init do_vc_no_ghcb(struct pt_regs *regs, unsigned long exit_code)
+{
+	unsigned int fn = lower_bits(regs->ax, 32);
+	unsigned long val;
+
+	/* Only CPUID is supported via MSR protocol */
+	if (exit_code != SVM_EXIT_CPUID)
+		goto fail;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EAX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->ax = val >> 32;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EBX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->bx = val >> 32;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_ECX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->cx = val >> 32;
+
+	sev_es_wr_ghcb_msr(GHCB_CPUID_REQ(fn, GHCB_CPUID_REQ_EDX));
+	VMGEXIT();
+	val = sev_es_rd_ghcb_msr();
+	if (GHCB_SEV_GHCB_RESP_CODE(val) != GHCB_SEV_CPUID_RESP)
+		goto fail;
+	regs->dx = val >> 32;
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
+	sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+}
+
+static enum es_result vc_insn_string_read(struct es_em_ctxt *ctxt,
+					  void *src, char *buf,
+					  unsigned int data_size,
+					  unsigned int count,
+					  bool backwards)
+{
+	int i, b = backwards ? -1 : 1;
+	enum es_result ret = ES_OK;
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
+	enum es_result ret = ES_OK;
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
+	*exitinfo = 0;
+
+	switch (insn->opcode.bytes[0]) {
+	/* INS opcodes */
+	case 0x6c:
+	case 0x6d:
+		*exitinfo |= IOIO_TYPE_INS;
+		*exitinfo |= IOIO_SEG_ES;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* OUTS opcodes */
+	case 0x6e:
+	case 0x6f:
+		*exitinfo |= IOIO_TYPE_OUTS;
+		*exitinfo |= IOIO_SEG_DS;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* IN immediate opcodes */
+	case 0xe4:
+	case 0xe5:
+		*exitinfo |= IOIO_TYPE_IN;
+		*exitinfo |= (u8)insn->immediate.value << 16;
+		break;
+
+	/* OUT immediate opcodes */
+	case 0xe6:
+	case 0xe7:
+		*exitinfo |= IOIO_TYPE_OUT;
+		*exitinfo |= (u8)insn->immediate.value << 16;
+		break;
+
+	/* IN register opcodes */
+	case 0xec:
+	case 0xed:
+		*exitinfo |= IOIO_TYPE_IN;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	/* OUT register opcodes */
+	case 0xee:
+	case 0xef:
+		*exitinfo |= IOIO_TYPE_OUT;
+		*exitinfo |= (ctxt->regs->dx & 0xffff) << 16;
+		break;
+
+	default:
+		return ES_DECODE_FAILED;
+	}
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
+		break;
+	default:
+		/* Length determined by instruction parsing */
+		*exitinfo |= (insn->opnd_bytes == 2) ? IOIO_DATA_16
+						     : IOIO_DATA_32;
+	}
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
+	return ES_OK;
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
+static enum es_result vc_handle_cpuid(struct ghcb *ghcb,
+				      struct es_em_ctxt *ctxt)
+{
+	struct pt_regs *regs = ctxt->regs;
+	u32 cr4 = native_read_cr4();
+	enum es_result ret;
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
diff --git a/arch/x86/kernel/sev.c b/arch/x86/kernel/sev.c
new file mode 100644
index 0000000..9578c82
--- /dev/null
+++ b/arch/x86/kernel/sev.c
@@ -0,0 +1,1461 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * AMD Memory Encryption Support
+ *
+ * Copyright (C) 2019 SUSE
+ *
+ * Author: Joerg Roedel <jroedel@suse.de>
+ */
+
+#define pr_fmt(fmt)	"SEV-ES: " fmt
+
+#include <linux/sched/debug.h>	/* For show_regs() */
+#include <linux/percpu-defs.h>
+#include <linux/mem_encrypt.h>
+#include <linux/lockdep.h>
+#include <linux/printk.h>
+#include <linux/mm_types.h>
+#include <linux/set_memory.h>
+#include <linux/memblock.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+
+#include <asm/cpu_entry_area.h>
+#include <asm/stacktrace.h>
+#include <asm/sev.h>
+#include <asm/insn-eval.h>
+#include <asm/fpu/internal.h>
+#include <asm/processor.h>
+#include <asm/realmode.h>
+#include <asm/traps.h>
+#include <asm/svm.h>
+#include <asm/smp.h>
+#include <asm/cpu.h>
+
+#define DR7_RESET_VALUE        0x400
+
+/* For early boot hypervisor communication in SEV-ES enabled guests */
+static struct ghcb boot_ghcb_page __bss_decrypted __aligned(PAGE_SIZE);
+
+/*
+ * Needs to be in the .data section because we need it NULL before bss is
+ * cleared
+ */
+static struct ghcb __initdata *boot_ghcb;
+
+/* #VC handler runtime per-CPU data */
+struct sev_es_runtime_data {
+	struct ghcb ghcb_page;
+
+	/* Physical storage for the per-CPU IST stack of the #VC handler */
+	char ist_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
+
+	/*
+	 * Physical storage for the per-CPU fall-back stack of the #VC handler.
+	 * The fall-back stack is used when it is not safe to switch back to the
+	 * interrupted stack in the #VC entry code.
+	 */
+	char fallback_stack[EXCEPTION_STKSZ] __aligned(PAGE_SIZE);
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
+static DEFINE_PER_CPU(struct sev_es_runtime_data*, runtime_data);
+DEFINE_STATIC_KEY_FALSE(sev_es_enable_key);
+
+/* Needed in vc_early_forward_exception */
+void do_early_exception(struct pt_regs *regs, int trapnr);
+
+static void __init setup_vc_stacks(int cpu)
+{
+	struct sev_es_runtime_data *data;
+	struct cpu_entry_area *cea;
+	unsigned long vaddr;
+	phys_addr_t pa;
+
+	data = per_cpu(runtime_data, cpu);
+	cea  = get_cpu_entry_area(cpu);
+
+	/* Map #VC IST stack */
+	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC);
+	pa    = __pa(data->ist_stack);
+	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+
+	/* Map VC fall-back stack */
+	vaddr = CEA_ESTACK_BOT(&cea->estacks, VC2);
+	pa    = __pa(data->fallback_stack);
+	cea_set_pte((void *)vaddr, pa, PAGE_KERNEL);
+}
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
+static __always_inline struct ghcb *sev_es_get_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
+
+	data = this_cpu_read(runtime_data);
+	ghcb = &data->ghcb_page;
+
+	if (unlikely(data->ghcb_active)) {
+		/* GHCB is already in use - save its contents */
+
+		if (unlikely(data->backup_ghcb_active))
+			return NULL;
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
+static __always_inline void sev_es_put_ghcb(struct ghcb_state *state)
+{
+	struct sev_es_runtime_data *data;
+	struct ghcb *ghcb;
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
+		data->ghcb_active = false;
+	}
+}
+
+/* Needed in vc_early_forward_exception */
+void do_early_exception(struct pt_regs *regs, int trapnr);
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
+	int res;
+
+	res = insn_fetch_from_user_inatomic(ctxt->regs, buffer);
+	if (!res) {
+		ctxt->fi.vector     = X86_TRAP_PF;
+		ctxt->fi.error_code = X86_PF_INSTR | X86_PF_USER;
+		ctxt->fi.cr2        = ctxt->regs->ip;
+		return ES_EXCEPTION;
+	}
+
+	if (!insn_decode_from_regs(&ctxt->insn, ctxt->regs, buffer, res))
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
+	char __user *target = (char __user *)dst;
+	u64 d8;
+	u32 d4;
+	u16 d2;
+	u8  d1;
+
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(target, size)) {
+		memcpy(dst, buf, size);
+		return ES_OK;
+	}
+
+	switch (size) {
+	case 1:
+		memcpy(&d1, buf, 1);
+		if (put_user(d1, target))
+			goto fault;
+		break;
+	case 2:
+		memcpy(&d2, buf, 2);
+		if (put_user(d2, target))
+			goto fault;
+		break;
+	case 4:
+		memcpy(&d4, buf, 4);
+		if (put_user(d4, target))
+			goto fault;
+		break;
+	case 8:
+		memcpy(&d8, buf, 8);
+		if (put_user(d8, target))
+			goto fault;
+		break;
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
+	char __user *s = (char __user *)src;
+	u64 d8;
+	u32 d4;
+	u16 d2;
+	u8  d1;
+
+	/* If instruction ran in kernel mode and the I/O buffer is in kernel space */
+	if (!user_mode(ctxt->regs) && !access_ok(s, size)) {
+		memcpy(buf, src, size);
+		return ES_OK;
+	}
+
+	switch (size) {
+	case 1:
+		if (get_user(d1, s))
+			goto fault;
+		memcpy(buf, &d1, 1);
+		break;
+	case 2:
+		if (get_user(d2, s))
+			goto fault;
+		memcpy(buf, &d2, 2);
+		break;
+	case 4:
+		if (get_user(d4, s))
+			goto fault;
+		memcpy(buf, &d4, 4);
+		break;
+	case 8:
+		if (get_user(d8, s))
+			goto fault;
+		memcpy(buf, &d8, 8);
+		break;
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
+/* Include code shared with pre-decompression boot stage */
+#include "sev-shared.c"
+
+void noinstr __sev_es_nmi_complete(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = sev_es_get_ghcb(&state);
+
+	vc_ghcb_invalidate(ghcb);
+	ghcb_set_sw_exit_code(ghcb, SVM_VMGEXIT_NMI_COMPLETE);
+	ghcb_set_sw_exit_info_1(ghcb, 0);
+	ghcb_set_sw_exit_info_2(ghcb, 0);
+
+	sev_es_wr_ghcb_msr(__pa_nodebug(ghcb));
+	VMGEXIT();
+
+	sev_es_put_ghcb(&state);
+}
+
+static u64 get_jump_table_addr(void)
+{
+	struct ghcb_state state;
+	unsigned long flags;
+	struct ghcb *ghcb;
+	u64 ret = 0;
+
+	local_irq_save(flags);
+
+	ghcb = sev_es_get_ghcb(&state);
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
+	sev_es_put_ghcb(&state);
+
+	local_irq_restore(flags);
+
+	return ret;
+}
+
+int sev_es_setup_ap_jump_table(struct real_mode_header *rmh)
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
+	if (!sev_es_active())
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
+/*
+ * This function runs on the first #VC exception after the kernel
+ * switched to virtual addresses.
+ */
+static bool __init sev_es_setup_ghcb(void)
+{
+	/* First make sure the hypervisor talks a supported protocol. */
+	if (!sev_es_negotiate_protocol())
+		return false;
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
+	return true;
+}
+
+#ifdef CONFIG_HOTPLUG_CPU
+static void sev_es_ap_hlt_loop(void)
+{
+	struct ghcb_state state;
+	struct ghcb *ghcb;
+
+	ghcb = sev_es_get_ghcb(&state);
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
+	sev_es_put_ghcb(&state);
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
+	start_cpu0();
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
+	data = memblock_alloc(sizeof(*data), PAGE_SIZE);
+	if (!data)
+		panic("Can't allocate SEV-ES runtime data");
+
+	per_cpu(runtime_data, cpu) = data;
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
+	if (!sev_es_active())
+		return;
+
+	if (!sev_es_check_cpu_features())
+		panic("SEV-ES CPU Features missing");
+
+	/* Enable SEV-ES special handling */
+	static_branch_enable(&sev_es_enable_key);
+
+	/* Initialize per-cpu GHCB pages */
+	for_each_possible_cpu(cpu) {
+		alloc_runtime_data(cpu);
+		init_ghcb(cpu);
+		setup_vc_stacks(cpu);
+	}
+
+	sev_es_setup_play_dead();
+
+	/* Secondary CPUs use the runtime #VC handler */
+	initial_vc_handler = (unsigned long)safe_stack_exc_vmm_communication;
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
+static long *vc_insn_get_reg(struct es_em_ctxt *ctxt)
+{
+	long *reg_array;
+	int offset;
+
+	reg_array = (long *)ctxt->regs;
+	offset    = insn_get_modrm_reg_off(&ctxt->insn, ctxt->regs);
+
+	if (offset < 0)
+		return NULL;
+
+	offset /= sizeof(long);
+
+	return reg_array + offset;
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
+static enum es_result vc_handle_mmio_twobyte_ops(struct ghcb *ghcb,
+						 struct es_em_ctxt *ctxt)
+{
+	struct insn *insn = &ctxt->insn;
+	unsigned int bytes = 0;
+	enum es_result ret;
+	int sign_byte;
+	long *reg_data;
+
+	switch (insn->opcode.bytes[1]) {
+		/* MMIO Read w/ zero-extension */
+	case 0xb6:
+		bytes = 1;
+		fallthrough;
+	case 0xb7:
+		if (!bytes)
+			bytes = 2;
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Zero extend based on operand size */
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+
+		memset(reg_data, 0, insn->opnd_bytes);
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+
+		/* MMIO Read w/ sign-extension */
+	case 0xbe:
+		bytes = 1;
+		fallthrough;
+	case 0xbf:
+		if (!bytes)
+			bytes = 2;
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		/* Sign extend based on operand size */
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
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
+		memset(reg_data, sign_byte, insn->opnd_bytes);
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+
+	default:
+		ret = ES_UNSUPPORTED;
+	}
+
+	return ret;
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
+static enum es_result vc_handle_mmio(struct ghcb *ghcb,
+				     struct es_em_ctxt *ctxt)
+{
+	struct insn *insn = &ctxt->insn;
+	unsigned int bytes = 0;
+	enum es_result ret;
+	long *reg_data;
+
+	switch (insn->opcode.bytes[0]) {
+	/* MMIO Write */
+	case 0x88:
+		bytes = 1;
+		fallthrough;
+	case 0x89:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+
+		memcpy(ghcb->shared_buffer, reg_data, bytes);
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+
+	case 0xc6:
+		bytes = 1;
+		fallthrough;
+	case 0xc7:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		memcpy(ghcb->shared_buffer, insn->immediate1.bytes, bytes);
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, false);
+		break;
+
+		/* MMIO Read */
+	case 0x8a:
+		bytes = 1;
+		fallthrough;
+	case 0x8b:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		ret = vc_do_mmio(ghcb, ctxt, bytes, true);
+		if (ret)
+			break;
+
+		reg_data = vc_insn_get_reg(ctxt);
+		if (!reg_data)
+			return ES_DECODE_FAILED;
+
+		/* Zero-extend for 32-bit operation */
+		if (bytes == 4)
+			*reg_data = 0;
+
+		memcpy(reg_data, ghcb->shared_buffer, bytes);
+		break;
+
+		/* MOVS instruction */
+	case 0xa4:
+		bytes = 1;
+		fallthrough;
+	case 0xa5:
+		if (!bytes)
+			bytes = insn->opnd_bytes;
+
+		ret = vc_handle_mmio_movs(ctxt, bytes);
+		break;
+		/* Two-Byte Opcodes */
+	case 0x0f:
+		ret = vc_handle_mmio_twobyte_ops(ghcb, ctxt);
+		break;
+	default:
+		ret = ES_UNSUPPORTED;
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
+static __always_inline void vc_handle_trap_db(struct pt_regs *regs)
+{
+	if (user_mode(regs))
+		noist_exc_debug(regs);
+	else
+		exc_debug(regs);
+}
+
+static enum es_result vc_handle_exitcode(struct es_em_ctxt *ctxt,
+					 struct ghcb *ghcb,
+					 unsigned long exit_code)
+{
+	enum es_result result;
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
+	case X86_TRAP_AC:
+		exc_alignment_check(ctxt->regs, error_code);
+		break;
+	default:
+		pr_emerg("Unsupported exception in #VC instruction emulation - can't continue\n");
+		BUG();
+	}
+}
+
+static __always_inline bool on_vc_fallback_stack(struct pt_regs *regs)
+{
+	unsigned long sp = (unsigned long)regs;
+
+	return (sp >= __this_cpu_ist_bottom_va(VC2) && sp < __this_cpu_ist_top_va(VC2));
+}
+
+/*
+ * Main #VC exception handler. It is called when the entry code was able to
+ * switch off the IST to a safe kernel stack.
+ *
+ * With the current implementation it is always possible to switch to a safe
+ * stack because #VC exceptions only happen at known places, like intercepted
+ * instructions or accesses to MMIO areas/IO ports. They can also happen with
+ * code instrumentation when the hypervisor intercepts #DB, but the critical
+ * paths are forbidden to be instrumented, so #DB exceptions currently also
+ * only happen in safe places.
+ */
+DEFINE_IDTENTRY_VC_SAFE_STACK(exc_vmm_communication)
+{
+	struct sev_es_runtime_data *data = this_cpu_read(runtime_data);
+	irqentry_state_t irq_state;
+	struct ghcb_state state;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+	struct ghcb *ghcb;
+
+	/*
+	 * Handle #DB before calling into !noinstr code to avoid recursive #DB.
+	 */
+	if (error_code == SVM_EXIT_EXCP_BASE + X86_TRAP_DB) {
+		vc_handle_trap_db(regs);
+		return;
+	}
+
+	irq_state = irqentry_nmi_enter(regs);
+	lockdep_assert_irqs_disabled();
+	instrumentation_begin();
+
+	/*
+	 * This is invoked through an interrupt gate, so IRQs are disabled. The
+	 * code below might walk page-tables for user or kernel addresses, so
+	 * keep the IRQs disabled to protect us against concurrent TLB flushes.
+	 */
+
+	ghcb = sev_es_get_ghcb(&state);
+	if (!ghcb) {
+		/*
+		 * Mark GHCBs inactive so that panic() is able to print the
+		 * message.
+		 */
+		data->ghcb_active        = false;
+		data->backup_ghcb_active = false;
+
+		panic("Unable to handle #VC exception! GHCB and Backup GHCB are already in use");
+	}
+
+	vc_ghcb_invalidate(ghcb);
+	result = vc_init_em_ctxt(&ctxt, regs, error_code);
+
+	if (result == ES_OK)
+		result = vc_handle_exitcode(&ctxt, ghcb, error_code);
+
+	sev_es_put_ghcb(&state);
+
+	/* Done - now check the result */
+	switch (result) {
+	case ES_OK:
+		vc_finish_insn(&ctxt);
+		break;
+	case ES_UNSUPPORTED:
+		pr_err_ratelimited("Unsupported exit-code 0x%02lx in early #VC exception (IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		goto fail;
+	case ES_VMM_ERROR:
+		pr_err_ratelimited("Failure in communication with VMM (exit-code 0x%02lx IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		goto fail;
+	case ES_DECODE_FAILED:
+		pr_err_ratelimited("Failed to decode instruction (exit-code 0x%02lx IP: 0x%lx)\n",
+				   error_code, regs->ip);
+		goto fail;
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
+out:
+	instrumentation_end();
+	irqentry_nmi_exit(regs, irq_state);
+
+	return;
+
+fail:
+	if (user_mode(regs)) {
+		/*
+		 * Do not kill the machine if user-space triggered the
+		 * exception. Send SIGBUS instead and let user-space deal with
+		 * it.
+		 */
+		force_sig_fault(SIGBUS, BUS_OBJERR, (void __user *)0);
+	} else {
+		pr_emerg("PANIC: Unhandled #VC exception in kernel space (result=%d)\n",
+			 result);
+
+		/* Show some debug info */
+		show_regs(regs);
+
+		/* Ask hypervisor to sev_es_terminate */
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
+
+		/* If that fails and we get here - just panic */
+		panic("Returned from Terminate-Request to Hypervisor\n");
+	}
+
+	goto out;
+}
+
+/* This handler runs on the #VC fall-back stack. It can cause further #VC exceptions */
+DEFINE_IDTENTRY_VC_IST(exc_vmm_communication)
+{
+	instrumentation_begin();
+	panic("Can't handle #VC exception from unsupported context\n");
+	instrumentation_end();
+}
+
+DEFINE_IDTENTRY_VC(exc_vmm_communication)
+{
+	if (likely(!on_vc_fallback_stack(regs)))
+		safe_stack_exc_vmm_communication(regs, error_code);
+	else
+		ist_exc_vmm_communication(regs, error_code);
+}
+
+bool __init handle_vc_boot_ghcb(struct pt_regs *regs)
+{
+	unsigned long exit_code = regs->orig_ax;
+	struct es_em_ctxt ctxt;
+	enum es_result result;
+
+	/* Do initial setup or terminate the guest */
+	if (unlikely(boot_ghcb == NULL && !sev_es_setup_ghcb()))
+		sev_es_terminate(GHCB_SEV_ES_REASON_GENERAL_REQUEST);
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
+	while (true)
+		halt();
+}
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index b93d6cd..121921b 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -5,7 +5,7 @@
 #include <xen/xen.h>
 
 #include <asm/fpu/internal.h>
-#include <asm/sev-es.h>
+#include <asm/sev.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
 
diff --git a/arch/x86/platform/efi/efi_64.c b/arch/x86/platform/efi/efi_64.c
index df7b547..7515e78 100644
--- a/arch/x86/platform/efi/efi_64.c
+++ b/arch/x86/platform/efi/efi_64.c
@@ -47,7 +47,7 @@
 #include <asm/realmode.h>
 #include <asm/time.h>
 #include <asm/pgalloc.h>
-#include <asm/sev-es.h>
+#include <asm/sev.h>
 
 /*
  * We allocate runtime services regions top-down, starting from -4G, i.e.
diff --git a/arch/x86/realmode/init.c b/arch/x86/realmode/init.c
index 1be71ef..2e1c1be 100644
--- a/arch/x86/realmode/init.c
+++ b/arch/x86/realmode/init.c
@@ -9,7 +9,7 @@
 #include <asm/realmode.h>
 #include <asm/tlbflush.h>
 #include <asm/crash.h>
-#include <asm/sev-es.h>
+#include <asm/sev.h>
 
 struct real_mode_header *real_mode_header;
 u32 *trampoline_cr4_features;
