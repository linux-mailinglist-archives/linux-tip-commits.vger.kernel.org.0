Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EE221B9330
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Apr 2020 20:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbgDZSnn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Apr 2020 14:43:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726315AbgDZSm4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Apr 2020 14:42:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5CAC061A0F;
        Sun, 26 Apr 2020 11:42:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSmEq-00079N-O7; Sun, 26 Apr 2020 20:42:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 639571C0330;
        Sun, 26 Apr 2020 20:42:48 +0200 (CEST)
Date:   Sun, 26 Apr 2020 18:42:48 -0000
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/tlb: Move PCID helpers where they are used
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200421092600.145772183@linutronix.de>
References: <20200421092600.145772183@linutronix.de>
MIME-Version: 1.0
Message-ID: <158792656800.28353.11560387286755262359.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6c9b7d79a801074837c683fc996e231266ca47ae
Gitweb:        https://git.kernel.org/tip/6c9b7d79a801074837c683fc996e231266ca47ae
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 21 Apr 2020 11:20:41 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Sun, 26 Apr 2020 18:49:44 +02:00

x86/tlb: Move PCID helpers where they are used

Aside of the fact that they are used only in the TLB code, especially
having the comment close to the actual implementation makes a lot of
sense.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Alexandre Chartre <alexandre.chartre@oracle.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200421092600.145772183@linutronix.de
---
 arch/x86/include/asm/tlbflush.h | 133 +------------------------------
 arch/x86/mm/tlb.c               | 120 ++++++++++++++++++++++++++++-
 2 files changed, 126 insertions(+), 127 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 1c17f5a..f973121 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -13,133 +13,6 @@
 #include <asm/pti.h>
 #include <asm/processor-flags.h>
 
-/*
- * The x86 feature is called PCID (Process Context IDentifier). It is similar
- * to what is traditionally called ASID on the RISC processors.
- *
- * We don't use the traditional ASID implementation, where each process/mm gets
- * its own ASID and flush/restart when we run out of ASID space.
- *
- * Instead we have a small per-cpu array of ASIDs and cache the last few mm's
- * that came by on this CPU, allowing cheaper switch_mm between processes on
- * this CPU.
- *
- * We end up with different spaces for different things. To avoid confusion we
- * use different names for each of them:
- *
- * ASID  - [0, TLB_NR_DYN_ASIDS-1]
- *         the canonical identifier for an mm
- *
- * kPCID - [1, TLB_NR_DYN_ASIDS]
- *         the value we write into the PCID part of CR3; corresponds to the
- *         ASID+1, because PCID 0 is special.
- *
- * uPCID - [2048 + 1, 2048 + TLB_NR_DYN_ASIDS]
- *         for KPTI each mm has two address spaces and thus needs two
- *         PCID values, but we can still do with a single ASID denomination
- *         for each mm. Corresponds to kPCID + 2048.
- *
- */
-
-/* There are 12 bits of space for ASIDS in CR3 */
-#define CR3_HW_ASID_BITS		12
-
-/*
- * When enabled, PAGE_TABLE_ISOLATION consumes a single bit for
- * user/kernel switches
- */
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-# define PTI_CONSUMED_PCID_BITS	1
-#else
-# define PTI_CONSUMED_PCID_BITS	0
-#endif
-
-#define CR3_AVAIL_PCID_BITS (X86_CR3_PCID_BITS - PTI_CONSUMED_PCID_BITS)
-
-/*
- * ASIDs are zero-based: 0->MAX_AVAIL_ASID are valid.  -1 below to account
- * for them being zero-based.  Another -1 is because PCID 0 is reserved for
- * use by non-PCID-aware users.
- */
-#define MAX_ASID_AVAILABLE ((1 << CR3_AVAIL_PCID_BITS) - 2)
-
-/*
- * 6 because 6 should be plenty and struct tlb_state will fit in two cache
- * lines.
- */
-#define TLB_NR_DYN_ASIDS	6
-
-/*
- * Given @asid, compute kPCID
- */
-static inline u16 kern_pcid(u16 asid)
-{
-	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
-
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	/*
-	 * Make sure that the dynamic ASID space does not confict with the
-	 * bit we are using to switch between user and kernel ASIDs.
-	 */
-	BUILD_BUG_ON(TLB_NR_DYN_ASIDS >= (1 << X86_CR3_PTI_PCID_USER_BIT));
-
-	/*
-	 * The ASID being passed in here should have respected the
-	 * MAX_ASID_AVAILABLE and thus never have the switch bit set.
-	 */
-	VM_WARN_ON_ONCE(asid & (1 << X86_CR3_PTI_PCID_USER_BIT));
-#endif
-	/*
-	 * The dynamically-assigned ASIDs that get passed in are small
-	 * (<TLB_NR_DYN_ASIDS).  They never have the high switch bit set,
-	 * so do not bother to clear it.
-	 *
-	 * If PCID is on, ASID-aware code paths put the ASID+1 into the
-	 * PCID bits.  This serves two purposes.  It prevents a nasty
-	 * situation in which PCID-unaware code saves CR3, loads some other
-	 * value (with PCID == 0), and then restores CR3, thus corrupting
-	 * the TLB for ASID 0 if the saved ASID was nonzero.  It also means
-	 * that any bugs involving loading a PCID-enabled CR3 with
-	 * CR4.PCIDE off will trigger deterministically.
-	 */
-	return asid + 1;
-}
-
-/*
- * Given @asid, compute uPCID
- */
-static inline u16 user_pcid(u16 asid)
-{
-	u16 ret = kern_pcid(asid);
-#ifdef CONFIG_PAGE_TABLE_ISOLATION
-	ret |= 1 << X86_CR3_PTI_PCID_USER_BIT;
-#endif
-	return ret;
-}
-
-struct pgd_t;
-static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
-{
-	if (static_cpu_has(X86_FEATURE_PCID)) {
-		return __sme_pa(pgd) | kern_pcid(asid);
-	} else {
-		VM_WARN_ON_ONCE(asid != 0);
-		return __sme_pa(pgd);
-	}
-}
-
-static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
-{
-	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
-	/*
-	 * Use boot_cpu_has() instead of this_cpu_has() as this function
-	 * might be called during early boot. This should work even after
-	 * boot because all CPU's the have same capabilities:
-	 */
-	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
-	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
-}
-
 struct flush_tlb_info;
 
 void __flush_tlb_all(void);
@@ -153,6 +26,12 @@ void flush_tlb_others(const struct cpumask *cpumask,
 #include <asm/paravirt.h>
 #endif
 
+/*
+ * 6 because 6 should be plenty and struct tlb_state will fit in two cache
+ * lines.
+ */
+#define TLB_NR_DYN_ASIDS	6
+
 struct tlb_context {
 	u64 ctx_id;
 	u64 tlb_gen;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 45426ae..cf81902 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -49,6 +49,126 @@
 #define LAST_USER_MM_IBPB	0x1UL
 
 /*
+ * The x86 feature is called PCID (Process Context IDentifier). It is similar
+ * to what is traditionally called ASID on the RISC processors.
+ *
+ * We don't use the traditional ASID implementation, where each process/mm gets
+ * its own ASID and flush/restart when we run out of ASID space.
+ *
+ * Instead we have a small per-cpu array of ASIDs and cache the last few mm's
+ * that came by on this CPU, allowing cheaper switch_mm between processes on
+ * this CPU.
+ *
+ * We end up with different spaces for different things. To avoid confusion we
+ * use different names for each of them:
+ *
+ * ASID  - [0, TLB_NR_DYN_ASIDS-1]
+ *         the canonical identifier for an mm
+ *
+ * kPCID - [1, TLB_NR_DYN_ASIDS]
+ *         the value we write into the PCID part of CR3; corresponds to the
+ *         ASID+1, because PCID 0 is special.
+ *
+ * uPCID - [2048 + 1, 2048 + TLB_NR_DYN_ASIDS]
+ *         for KPTI each mm has two address spaces and thus needs two
+ *         PCID values, but we can still do with a single ASID denomination
+ *         for each mm. Corresponds to kPCID + 2048.
+ *
+ */
+
+/* There are 12 bits of space for ASIDS in CR3 */
+#define CR3_HW_ASID_BITS		12
+
+/*
+ * When enabled, PAGE_TABLE_ISOLATION consumes a single bit for
+ * user/kernel switches
+ */
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+# define PTI_CONSUMED_PCID_BITS	1
+#else
+# define PTI_CONSUMED_PCID_BITS	0
+#endif
+
+#define CR3_AVAIL_PCID_BITS (X86_CR3_PCID_BITS - PTI_CONSUMED_PCID_BITS)
+
+/*
+ * ASIDs are zero-based: 0->MAX_AVAIL_ASID are valid.  -1 below to account
+ * for them being zero-based.  Another -1 is because PCID 0 is reserved for
+ * use by non-PCID-aware users.
+ */
+#define MAX_ASID_AVAILABLE ((1 << CR3_AVAIL_PCID_BITS) - 2)
+
+/*
+ * Given @asid, compute kPCID
+ */
+static inline u16 kern_pcid(u16 asid)
+{
+	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
+
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	/*
+	 * Make sure that the dynamic ASID space does not confict with the
+	 * bit we are using to switch between user and kernel ASIDs.
+	 */
+	BUILD_BUG_ON(TLB_NR_DYN_ASIDS >= (1 << X86_CR3_PTI_PCID_USER_BIT));
+
+	/*
+	 * The ASID being passed in here should have respected the
+	 * MAX_ASID_AVAILABLE and thus never have the switch bit set.
+	 */
+	VM_WARN_ON_ONCE(asid & (1 << X86_CR3_PTI_PCID_USER_BIT));
+#endif
+	/*
+	 * The dynamically-assigned ASIDs that get passed in are small
+	 * (<TLB_NR_DYN_ASIDS).  They never have the high switch bit set,
+	 * so do not bother to clear it.
+	 *
+	 * If PCID is on, ASID-aware code paths put the ASID+1 into the
+	 * PCID bits.  This serves two purposes.  It prevents a nasty
+	 * situation in which PCID-unaware code saves CR3, loads some other
+	 * value (with PCID == 0), and then restores CR3, thus corrupting
+	 * the TLB for ASID 0 if the saved ASID was nonzero.  It also means
+	 * that any bugs involving loading a PCID-enabled CR3 with
+	 * CR4.PCIDE off will trigger deterministically.
+	 */
+	return asid + 1;
+}
+
+/*
+ * Given @asid, compute uPCID
+ */
+static inline u16 user_pcid(u16 asid)
+{
+	u16 ret = kern_pcid(asid);
+#ifdef CONFIG_PAGE_TABLE_ISOLATION
+	ret |= 1 << X86_CR3_PTI_PCID_USER_BIT;
+#endif
+	return ret;
+}
+
+static inline unsigned long build_cr3(pgd_t *pgd, u16 asid)
+{
+	if (static_cpu_has(X86_FEATURE_PCID)) {
+		return __sme_pa(pgd) | kern_pcid(asid);
+	} else {
+		VM_WARN_ON_ONCE(asid != 0);
+		return __sme_pa(pgd);
+	}
+}
+
+static inline unsigned long build_cr3_noflush(pgd_t *pgd, u16 asid)
+{
+	VM_WARN_ON_ONCE(asid > MAX_ASID_AVAILABLE);
+	/*
+	 * Use boot_cpu_has() instead of this_cpu_has() as this function
+	 * might be called during early boot. This should work even after
+	 * boot because all CPU's the have same capabilities:
+	 */
+	VM_WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_PCID));
+	return __sme_pa(pgd) | kern_pcid(asid) | CR3_NOFLUSH;
+}
+
+/*
  * We get here when we do something requiring a TLB invalidation
  * but could not go invalidate all of the contexts.  We do the
  * necessary invalidation by clearing out the 'ctx_id' which
