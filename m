Return-Path: <linux-tip-commits+bounces-1459-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E778490D4AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 16:24:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC2611C23566
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jun 2024 14:24:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35F1E1A3BDA;
	Tue, 18 Jun 2024 14:01:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZQoY3uEI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ni2tHUyy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920251A2FA5;
	Tue, 18 Jun 2024 14:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718719316; cv=none; b=VuNz4yVOQX5w2isExrorl4SuBBHn443U6o1rVHaTHWqZNAwVtF5icTNW4WFeYN0wLCqXttvoPEoTZJ+pio8E++EzSMftKO4fAJUNL9J/7/3F5SDQfe9SMAd1+nykJAS+rbYLOUOMARj5SsgkLeFzonrxkiqPtSeQ8wPZ97iT29s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718719316; c=relaxed/simple;
	bh=lNMnkA5Lv8OG/caUNBlGsJ+w9w7CJJXYY6C7Mn0wdeE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lqtyQiJ4VGewTJ/BDSXLiFMyPMU5sr0nmFPJzMA4B29FDllTRXzjCHYXDWtOTavvEb1QPJL1p/ftY2j+DmiD9zedCY2pgTHZbpilBIQVZYoiM2o8Ooe9xdr+M/z3wcoF75mnnytLocDLfeAbYxdVWGDHbvXAMXJLKHAvvCMdk6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZQoY3uEI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ni2tHUyy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Jun 2024 14:01:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718719301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+k9nE53NuRbWHzr1HnPrrTbu3qrrtlREBanqYxs7OcU=;
	b=ZQoY3uEInOcJAjVFYunrqvuGmnq8DZfWiW9zelYo482ul/bex9n6J8Ok0Jy3oejmxqz2f6
	igKs52o4W5HkjccyT2CHw2wrVgjmydN+MqY2rxhM8ZEab6fH3OprGBnzOjIIa22o0ZC43a
	JCA7kBygFGvuIuPiGBd2vgHyd+O4J/1wZWMuaguarMERQ+NS2f6fTtCB6v4+2LVVk+Ub+y
	Ah4XcG6ho87CflA18DTa5BQPww/bndNEbziT8iqofl2NkxLb43IwIRtU3ErjPozJrEIZnt
	zzguHlauMRdDdi0bdVLfxoi7JN4rZk4PGsT3JvOnpJ+xcjt5RmnPqqw94SzdZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718719301;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+k9nE53NuRbWHzr1HnPrrTbu3qrrtlREBanqYxs7OcU=;
	b=ni2tHUyyH6IC7ky16RrRwFrt5rVu4h+9nDDKhruJ16vCvbyF0BkyQ18MsiuYjJn5rwjAf7
	qqhJJa30nGH6dwDw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cc] x86/tdx: Convert shared memory back to private on kexec
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>, Kai Huang <kai.huang@intel.com>,
 Tao Liu <ltao@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240614095904.1345461-12-kirill.shutemov@linux.intel.com>
References: <20240614095904.1345461-12-kirill.shutemov@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171871930069.10875.8795812694370524886.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cc branch of tip:

Commit-ID:     859e63b789d6b17b3c64e51a0aabdc58752a0254
Gitweb:        https://git.kernel.org/tip/859e63b789d6b17b3c64e51a0aabdc58752a0254
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 14 Jun 2024 12:58:56 +03:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 17 Jun 2024 17:46:05 +02:00

x86/tdx: Convert shared memory back to private on kexec

TDX guests allocate shared buffers to perform I/O. It is done by allocating
pages normally from the buddy allocator and converting them to shared with
set_memory_decrypted().

The second, kexec-ed kernel has no idea what memory is converted this way. It
only sees E820_TYPE_RAM.

Accessing shared memory via private mapping is fatal. It leads to unrecoverable
TD exit.

On kexec, walk direct mapping and convert all shared memory back to private. It
makes all RAM private again and second kernel may use it normally.

The conversion occurs in two steps: stopping new conversions and unsharing all
memory. In the case of normal kexec, the stopping of conversions takes place
while scheduling is still functioning. This allows for waiting until any ongoing
conversions are finished. The second step is carried out when all CPUs except one
are inactive and interrupts are disabled. This prevents any conflicts with code
that may access shared memory.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Tested-by: Tao Liu <ltao@redhat.com>
Link: https://lore.kernel.org/r/20240614095904.1345461-12-kirill.shutemov@linux.intel.com
---
 arch/x86/coco/tdx/tdx.c           | 94 ++++++++++++++++++++++++++++++-
 arch/x86/include/asm/pgtable.h    |  5 ++-
 arch/x86/include/asm/set_memory.h |  3 +-
 arch/x86/mm/pat/set_memory.c      | 42 ++++++++++++-
 4 files changed, 141 insertions(+), 3 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index 979891e..078e2ba 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -7,6 +7,7 @@
 #include <linux/cpufeature.h>
 #include <linux/export.h>
 #include <linux/io.h>
+#include <linux/kexec.h>
 #include <asm/coco.h>
 #include <asm/tdx.h>
 #include <asm/vmx.h>
@@ -14,6 +15,7 @@
 #include <asm/insn.h>
 #include <asm/insn-eval.h>
 #include <asm/pgtable.h>
+#include <asm/set_memory.h>
 
 /* MMIO direction */
 #define EPT_READ	0
@@ -831,6 +833,95 @@ static int tdx_enc_status_change_finish(unsigned long vaddr, int numpages,
 	return 0;
 }
 
+/* Stop new private<->shared conversions */
+static void tdx_kexec_begin(void)
+{
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	/*
+	 * Crash kernel reaches here with interrupts disabled: can't wait for
+	 * conversions to finish.
+	 *
+	 * If race happened, just report and proceed.
+	 */
+	if (!set_memory_enc_stop_conversion())
+		pr_warn("Failed to stop shared<->private conversions\n");
+}
+
+/* Walk direct mapping and convert all shared memory back to private */
+static void tdx_kexec_finish(void)
+{
+	unsigned long addr, end;
+	long found = 0, shared;
+
+	if (!IS_ENABLED(CONFIG_KEXEC_CORE))
+		return;
+
+	lockdep_assert_irqs_disabled();
+
+	addr = PAGE_OFFSET;
+	end  = PAGE_OFFSET + get_max_mapped();
+
+	while (addr < end) {
+		unsigned long size;
+		unsigned int level;
+		pte_t *pte;
+
+		pte = lookup_address(addr, &level);
+		size = page_level_size(level);
+
+		if (pte && pte_decrypted(*pte)) {
+			int pages = size / PAGE_SIZE;
+
+			/*
+			 * Touching memory with shared bit set triggers implicit
+			 * conversion to shared.
+			 *
+			 * Make sure nobody touches the shared range from
+			 * now on.
+			 */
+			set_pte(pte, __pte(0));
+
+			/*
+			 * Memory encryption state persists across kexec.
+			 * If tdx_enc_status_changed() fails in the first
+			 * kernel, it leaves memory in an unknown state.
+			 *
+			 * If that memory remains shared, accessing it in the
+			 * *next* kernel through a private mapping will result
+			 * in an unrecoverable guest shutdown.
+			 *
+			 * The kdump kernel boot is not impacted as it uses
+			 * a pre-reserved memory range that is always private.
+			 * However, gathering crash information could lead to
+			 * a crash if it accesses unconverted memory through
+			 * a private mapping which is possible when accessing
+			 * that memory through /proc/vmcore, for example.
+			 *
+			 * In all cases, print error info in order to leave
+			 * enough bread crumbs for debugging.
+			 */
+			if (!tdx_enc_status_changed(addr, pages, true)) {
+				pr_err("Failed to unshare range %#lx-%#lx\n",
+				       addr, addr + size);
+			}
+
+			found += pages;
+		}
+
+		addr += size;
+	}
+
+	__flush_tlb_all();
+
+	shared = atomic_long_read(&nr_shared);
+	if (shared != found) {
+		pr_err("shared page accounting is off\n");
+		pr_err("nr_shared = %ld, nr_found = %ld\n", shared, found);
+	}
+}
+
 void __init tdx_early_init(void)
 {
 	struct tdx_module_args args = {
@@ -890,6 +981,9 @@ void __init tdx_early_init(void)
 	x86_platform.guest.enc_cache_flush_required  = tdx_cache_flush_required;
 	x86_platform.guest.enc_tlb_flush_required    = tdx_tlb_flush_required;
 
+	x86_platform.guest.enc_kexec_begin	     = tdx_kexec_begin;
+	x86_platform.guest.enc_kexec_finish	     = tdx_kexec_finish;
+
 	/*
 	 * TDX intercepts the RDMSR to read the X2APIC ID in the parallel
 	 * bringup low level code. That raises #VE which cannot be handled
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index 65b8e5b..e39311a 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -140,6 +140,11 @@ static inline int pte_young(pte_t pte)
 	return pte_flags(pte) & _PAGE_ACCESSED;
 }
 
+static inline bool pte_decrypted(pte_t pte)
+{
+	return cc_mkdec(pte_val(pte)) == pte_val(pte);
+}
+
 #define pmd_dirty pmd_dirty
 static inline bool pmd_dirty(pmd_t pmd)
 {
diff --git a/arch/x86/include/asm/set_memory.h b/arch/x86/include/asm/set_memory.h
index 9aee318..4b2abce 100644
--- a/arch/x86/include/asm/set_memory.h
+++ b/arch/x86/include/asm/set_memory.h
@@ -49,8 +49,11 @@ int set_memory_wb(unsigned long addr, int numpages);
 int set_memory_np(unsigned long addr, int numpages);
 int set_memory_p(unsigned long addr, int numpages);
 int set_memory_4k(unsigned long addr, int numpages);
+
+bool set_memory_enc_stop_conversion(void);
 int set_memory_encrypted(unsigned long addr, int numpages);
 int set_memory_decrypted(unsigned long addr, int numpages);
+
 int set_memory_np_noalias(unsigned long addr, int numpages);
 int set_memory_nonglobal(unsigned long addr, int numpages);
 int set_memory_global(unsigned long addr, int numpages);
diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index a7a7a6c..443a97e 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -2227,12 +2227,48 @@ vmm_fail:
 	return ret;
 }
 
+/*
+ * The lock serializes conversions between private and shared memory.
+ *
+ * It is taken for read on conversion. A write lock guarantees that no
+ * concurrent conversions are in progress.
+ */
+static DECLARE_RWSEM(mem_enc_lock);
+
+/*
+ * Stop new private<->shared conversions.
+ *
+ * Taking the exclusive mem_enc_lock waits for in-flight conversions to complete.
+ * The lock is not released to prevent new conversions from being started.
+ */
+bool set_memory_enc_stop_conversion(void)
+{
+	/*
+	 * In a crash scenario, sleep is not allowed. Try to take the lock.
+	 * Failure indicates that there is a race with the conversion.
+	 */
+	if (oops_in_progress)
+		return down_write_trylock(&mem_enc_lock);
+
+	down_write(&mem_enc_lock);
+
+	return true;
+}
+
 static int __set_memory_enc_dec(unsigned long addr, int numpages, bool enc)
 {
-	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT))
-		return __set_memory_enc_pgtable(addr, numpages, enc);
+	int ret = 0;
 
-	return 0;
+	if (cc_platform_has(CC_ATTR_MEM_ENCRYPT)) {
+		if (!down_read_trylock(&mem_enc_lock))
+			return -EBUSY;
+
+		ret = __set_memory_enc_pgtable(addr, numpages, enc);
+
+		up_read(&mem_enc_lock);
+	}
+
+	return ret;
 }
 
 int set_memory_encrypted(unsigned long addr, int numpages)

