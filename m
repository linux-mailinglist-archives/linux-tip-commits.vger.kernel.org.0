Return-Path: <linux-tip-commits+bounces-22-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A06E80F39E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 17:52:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7A706B20D69
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 16:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58BF7A22D;
	Tue, 12 Dec 2023 16:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LOHXEhQg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BapbxzBJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E696EA;
	Tue, 12 Dec 2023 08:52:28 -0800 (PST)
Date: Tue, 12 Dec 2023 16:52:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702399946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xLbDl2HIBcW5FGZPqlIK9qZSO0NAgCGCcc8t/IGLViw=;
	b=LOHXEhQgxQnjONBZpptrGMKJOAZ6vZITrcYlufyNOpIa2Xdm26w9yoiWKP5axW1JGpxSp7
	IplN7gYD9cms4QTpN4w1zCHiS68yZNQC88YOLxmWAW2lA1wZKkpmpy6HEcXB4KOM/XOE3J
	D7rh3e9wGv4LrJnMDyx7IIbtYuyxOrX06bNLWNdKIK06o6lG+RLV/z7l/Sysr635hMnEEv
	egzc+eFZWbg1iCIIrJyyzscfqH8G4bwJ9PpLN0BpvU2036x8R8cRs9s4/2UUEFY+s4aaad
	1TEKhxSyCKj+p8KluLou2xb7KieSGIM6VxKZ0s9y7ImNYjWBmmj8T6WYop9MGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702399946;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=xLbDl2HIBcW5FGZPqlIK9qZSO0NAgCGCcc8t/IGLViw=;
	b=BapbxzBJwwri5cfW4HAdxImSwabSSY1a3J62l0n/5yuwGxXeMHkSc3jytVtekxVlFZtV3I
	L9R6Zqv44hnjSXAg==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/mce: Differentiate real hardware #MCs from TDX
 erratum ones
Cc: Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Yuan Yao <yuan.yao@intel.com>, Tony Luck <tony.luck@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170239994598.398.2311909876381672877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     70060463cb2ba72bbb77c7ced503f53e09380f17
Gitweb:        https://git.kernel.org/tip/70060463cb2ba72bbb77c7ced503f53e09380f17
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Fri, 08 Dec 2023 09:07:38 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 12 Dec 2023 08:46:46 -08:00

x86/mce: Differentiate real hardware #MCs from TDX erratum ones

The first few generations of TDX hardware have an erratum.  Triggering
it in Linux requires some kind of kernel bug involving relatively exotic
memory writes to TDX private memory and will manifest via
spurious-looking machine checks when reading the affected memory.

Make an effort to detect these TDX-induced machine checks and spit out
a new blurb to dmesg so folks do not think their hardware is failing.

== Background ==

Virtually all kernel memory accesses operations happen in full
cachelines.  In practice, writing a "byte" of memory usually reads a 64
byte cacheline of memory, modifies it, then writes the whole line back.
Those operations do not trigger this problem.

This problem is triggered by "partial" writes where a write transaction
of less than cacheline lands at the memory controller.  The CPU does
these via non-temporal write instructions (like MOVNTI), or through
UC/WC memory mappings.  The issue can also be triggered away from the
CPU by devices doing partial writes via DMA.

== Problem ==

A partial write to a TDX private memory cacheline will silently "poison"
the line.  Subsequent reads will consume the poison and generate a
machine check.  According to the TDX hardware spec, neither of these
things should have happened.

To add insult to injury, the Linux machine code will present these as a
literal "Hardware error" when they were, in fact, a software-triggered
issue.

== Solution ==

In the end, this issue is hard to trigger.  Rather than do something
rash (and incomplete) like unmap TDX private memory from the direct map,
improve the machine check handler.

Currently, the #MC handler doesn't distinguish whether the memory is
TDX private memory or not but just dump, for instance, below message:

 [...] mce: [Hardware Error]: CPU 147: Machine Check Exception: f Bank 1: bd80000000100134
 [...] mce: [Hardware Error]: RIP 10:<ffffffffadb69870> {__tlb_remove_page_size+0x10/0xa0}
 	...
 [...] mce: [Hardware Error]: Run the above through 'mcelog --ascii'
 [...] mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
 [...] Kernel panic - not syncing: Fatal local machine check

Which says "Hardware Error" and "Data load in unrecoverable area of
kernel".

Ideally, it's better for the log to say "software bug around TDX private
memory" instead of "Hardware Error".  But in reality the real hardware
memory error can happen, and sadly such software-triggered #MC cannot be
distinguished from the real hardware error.  Also, the error message is
used by userspace tool 'mcelog' to parse, so changing the output may
break userspace.

So keep the "Hardware Error".  The "Data load in unrecoverable area of
kernel" is also helpful, so keep it too.

Instead of modifying above error log, improve the error log by printing
additional TDX related message to make the log like:

  ...
 [...] mce: [Hardware Error]: Machine check: Data load in unrecoverable area of kernel
 [...] mce: [Hardware Error]: Machine Check: TDX private memory error. Possible kernel bug.

Adding this additional message requires determination of whether the
memory page is TDX private memory.  There is no existing infrastructure
to do that.  Add an interface to query the TDX module to fill this gap.

== Impact ==

This issue requires some kind of kernel bug to trigger.

TDX private memory should never be mapped UC/WC.  A partial write
originating from these mappings would require *two* bugs, first mapping
the wrong page, then writing the wrong memory.  It would also be
detectable using traditional memory corruption techniques like
DEBUG_PAGEALLOC.

MOVNTI (and friends) could cause this issue with something like a simple
buffer overrun or use-after-free on the direct map.  It should also be
detectable with normal debug techniques.

The one place where this might get nasty would be if the CPU read data
then wrote back the same data.  That would trigger this problem but
would not, for instance, set off mechanisms like slab redzoning because
it doesn't actually corrupt data.

With an IOMMU at least, the DMA exposure is similar to the UC/WC issue.
TDX private memory would first need to be incorrectly mapped into the
I/O space and then a later DMA to that mapping would actually cause the
poisoning event.

[ dhansen: changelog tweaks ]

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Reviewed-by: Yuan Yao <yuan.yao@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/all/20231208170740.53979-18-dave.hansen%40intel.com
---
 arch/x86/include/asm/tdx.h     |   4 +-
 arch/x86/kernel/cpu/mce/core.c |  15 ++++-
 arch/x86/virt/vmx/tdx/tdx.c    | 109 ++++++++++++++++++++++++++++++++-
 arch/x86/virt/vmx/tdx/tdx.h    |   5 +-
 4 files changed, 133 insertions(+)

diff --git a/arch/x86/include/asm/tdx.h b/arch/x86/include/asm/tdx.h
index c54948e..eba1789 100644
--- a/arch/x86/include/asm/tdx.h
+++ b/arch/x86/include/asm/tdx.h
@@ -32,6 +32,8 @@
 
 #ifndef __ASSEMBLY__
 
+#include <uapi/asm/mce.h>
+
 /*
  * Used by the #VE exception handler to gather the #VE exception
  * info from the TDX module. This is a software only structure
@@ -113,10 +115,12 @@ static inline u64 sc_retry(sc_func_t func, u64 fn,
 #define seamcall_saved_ret(_fn, _args)	sc_retry(__seamcall_saved_ret, (_fn), (_args))
 int tdx_cpu_enable(void);
 int tdx_enable(void);
+const char *tdx_dump_mce_info(struct mce *m);
 #else
 static inline void tdx_init(void) { }
 static inline int tdx_cpu_enable(void) { return -ENODEV; }
 static inline int tdx_enable(void)  { return -ENODEV; }
+static inline const char *tdx_dump_mce_info(struct mce *m) { return NULL; }
 #endif	/* CONFIG_INTEL_TDX_HOST */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 7b39737..00d2b6b 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -52,6 +52,7 @@
 #include <asm/mce.h>
 #include <asm/msr.h>
 #include <asm/reboot.h>
+#include <asm/tdx.h>
 
 #include "internal.h"
 
@@ -228,11 +229,20 @@ static void wait_for_panic(void)
 	panic("Panicing machine check CPU died");
 }
 
+static const char *mce_dump_aux_info(struct mce *m)
+{
+	if (boot_cpu_has_bug(X86_BUG_TDX_PW_MCE))
+		return tdx_dump_mce_info(m);
+
+	return NULL;
+}
+
 static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 {
 	struct llist_node *pending;
 	struct mce_evt_llist *l;
 	int apei_err = 0;
+	const char *memmsg;
 
 	/*
 	 * Allow instrumentation around external facilities usage. Not that it
@@ -283,6 +293,11 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
 	}
 	if (exp)
 		pr_emerg(HW_ERR "Machine check: %s\n", exp);
+
+	memmsg = mce_dump_aux_info(final);
+	if (memmsg)
+		pr_emerg(HW_ERR "Machine check: %s\n", memmsg);
+
 	if (!fake_panic) {
 		if (panic_timeout == 0)
 			panic_timeout = mca_cfg.panic_timeout;
diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 06b04b9..4d6826a 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -27,6 +27,7 @@
 #include <linux/log2.h>
 #include <linux/acpi.h>
 #include <linux/suspend.h>
+#include <linux/acpi.h>
 #include <asm/page.h>
 #include <asm/special_insns.h>
 #include <asm/msr-index.h>
@@ -35,6 +36,7 @@
 #include <asm/tdx.h>
 #include <asm/intel-family.h>
 #include <asm/processor.h>
+#include <asm/mce.h>
 #include "tdx.h"
 
 static u32 tdx_global_keyid __ro_after_init;
@@ -942,6 +944,13 @@ static int construct_tdmrs(struct list_head *tmb_list,
 	if (ret)
 		tdmrs_free_pamt_all(tdmr_list);
 
+	/*
+	 * The tdmr_info_list is read-only from here on out.
+	 * Ensure that these writes are seen by other CPUs.
+	 * Pairs with a smp_rmb() in is_pamt_page().
+	 */
+	smp_wmb();
+
 	return ret;
 }
 
@@ -1235,6 +1244,106 @@ int tdx_enable(void)
 }
 EXPORT_SYMBOL_GPL(tdx_enable);
 
+static bool is_pamt_page(unsigned long phys)
+{
+	struct tdmr_info_list *tdmr_list = &tdx_tdmr_list;
+	int i;
+
+	/* Ensure that all remote 'tdmr_list' writes are visible: */
+	smp_rmb();
+
+	/*
+	 * The TDX module is no longer returning TDX_SYS_NOT_READY and
+	 * is initialized.  The 'tdmr_list' was initialized long ago
+	 * and is now read-only.
+	 */
+	for (i = 0; i < tdmr_list->nr_consumed_tdmrs; i++) {
+		unsigned long base, size;
+
+		tdmr_get_pamt(tdmr_entry(tdmr_list, i), &base, &size);
+
+		if (phys >= base && phys < (base + size))
+			return true;
+	}
+
+	return false;
+}
+
+/*
+ * Return whether the memory page at the given physical address is TDX
+ * private memory or not.
+ *
+ * This can be imprecise for two known reasons:
+ * 1. PAMTs are private memory and exist before the TDX module is
+ *    ready and TDH_PHYMEM_PAGE_RDMD works.  This is a relatively
+ *    short window that occurs once per boot.
+ * 2. TDH_PHYMEM_PAGE_RDMD reflects the TDX module's knowledge of the
+ *    page.  However, the page can still cause #MC until it has been
+ *    fully converted to shared using 64-byte writes like MOVDIR64B.
+ *    Buggy hosts might still leave #MC-causing memory in place which
+ *    this function can not detect.
+ */
+static bool paddr_is_tdx_private(unsigned long phys)
+{
+	struct tdx_module_args args = {
+		.rcx = phys & PAGE_MASK,
+	};
+	u64 sret;
+
+	if (!boot_cpu_has(X86_FEATURE_TDX_HOST_PLATFORM))
+		return false;
+
+	/* Get page type from the TDX module */
+	sret = __seamcall_ret(TDH_PHYMEM_PAGE_RDMD, &args);
+
+	/*
+	 * The SEAMCALL will not return success unless there is a
+	 * working, "ready" TDX module.  Assume an absence of TDX
+	 * private pages until SEAMCALL is working.
+	 */
+	if (sret)
+		return false;
+
+	/*
+	 * SEAMCALL was successful -- read page type (via RCX):
+	 *
+	 *  - PT_NDA:	Page is not used by the TDX module
+	 *  - PT_RSVD:	Reserved for Non-TDX use
+	 *  - Others:	Page is used by the TDX module
+	 *
+	 * Note PAMT pages are marked as PT_RSVD but they are also TDX
+	 * private memory.
+	 */
+	switch (args.rcx) {
+	case PT_NDA:
+		return false;
+	case PT_RSVD:
+		return is_pamt_page(phys);
+	default:
+		return true;
+	}
+}
+
+/*
+ * Some TDX-capable CPUs have an erratum.  A write to TDX private
+ * memory poisons that memory, and a subsequent read of that memory
+ * triggers #MC.
+ *
+ * Help distinguish erratum-triggered #MCs from a normal hardware one.
+ * Just print additional message to show such #MC may be result of the
+ * erratum.
+ */
+const char *tdx_dump_mce_info(struct mce *m)
+{
+	if (!m || !mce_is_memory_error(m) || !mce_usable_address(m))
+		return NULL;
+
+	if (!paddr_is_tdx_private(m->addr))
+		return NULL;
+
+	return "TDX private memory error. Possible kernel bug.";
+}
+
 static __init int record_keyid_partitioning(u32 *tdx_keyid_start,
 					    u32 *nr_tdx_keyids)
 {
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index c0610f0..b701f69 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -14,6 +14,7 @@
 /*
  * TDX module SEAMCALL leaf functions
  */
+#define TDH_PHYMEM_PAGE_RDMD	24
 #define TDH_SYS_KEY_CONFIG	31
 #define TDH_SYS_INIT		33
 #define TDH_SYS_RD		34
@@ -21,6 +22,10 @@
 #define TDH_SYS_TDMR_INIT	36
 #define TDH_SYS_CONFIG		45
 
+/* TDX page types */
+#define	PT_NDA		0x0
+#define	PT_RSVD		0x1
+
 /*
  * Global scope metadata field ID.
  *

