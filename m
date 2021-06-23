Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2BC03B2340
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbhFWWNL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231270AbhFWWMD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD69FC0611F8;
        Wed, 23 Jun 2021 15:09:15 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy2mVTfQmzh+Gp+5jl8L81Z/8MWojRDxzebcCnQzwDY=;
        b=rzQ4DetEkCfZpcjX56XZbcodo8NK5UwaYrHfrW4U3W2EoF9eglcQELiIWl6SBHFHmwMkXi
        q/YxBEo6kY7x7QX8X0OV3LmI2UKtPR7U1SBpenLgMjMSYmkXfXRcyrcVq2l2/d3q6tAf6+
        6gwcm/3b7qEFJjtRZE1avT6KQcwqyey4Lqsmk75kPJiHLyXBbLezfUmGsrcqW/A5vI5qIB
        Bns1iBVc9m8HWiNI+25xNNVhOfidC8BDVCwMMNMWd2cyqpxhLHKWmNnTO3k1jQcLsYoKeJ
        DutRffoet7ifSYeQLUHzJe4GReVij96iJeS09qx5twUnZawB54sUegJB/MIsPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486154;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vy2mVTfQmzh+Gp+5jl8L81Z/8MWojRDxzebcCnQzwDY=;
        b=yx9J16RBBaCAKVFk35q7ZsHNYPsKxvpih4wQLQyuE/kxTA1IEU1lQkxuNMG7g5im/9Hqnx
        UUAju34f0vziY5Dg==
From:   "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/pkeys: Move read_pkru() and write_pkru()
Cc:     Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.102647114@linutronix.de>
References: <20210623121455.102647114@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615328.395.17643990036241916135.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     784a46618f634973a17535b7d3d03cd4ebc0ccbd
Gitweb:        https://git.kernel.org/tip/784a46618f634973a17535b7d3d03cd4ebc0ccbd
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Wed, 23 Jun 2021 14:02:05 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:52:57 +02:00

x86/pkeys: Move read_pkru() and write_pkru()

write_pkru() was originally used just to write to the PKRU register.  It
was mercifully short and sweet and was not out of place in pgtable.h with
some other pkey-related code.

But, later work included a requirement to also modify the task XSAVE
buffer when updating the register.  This really is more related to the
XSAVE architecture than to paging.

Move the read/write_pkru() to asm/pkru.h.  pgtable.h won't miss them.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.102647114@linutronix.de
---
 arch/x86/include/asm/fpu/xstate.h |  1 +-
 arch/x86/include/asm/pgtable.h    | 57 +----------------------------
 arch/x86/include/asm/pkru.h       | 61 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/process_64.c      |  1 +-
 arch/x86/kvm/svm/sev.c            |  1 +-
 arch/x86/kvm/x86.c                |  1 +-
 arch/x86/mm/pkeys.c               |  1 +-
 7 files changed, 67 insertions(+), 56 deletions(-)
 create mode 100644 arch/x86/include/asm/pkru.h

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 7de2384..5764cbe 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -6,6 +6,7 @@
 #include <linux/types.h>
 
 #include <asm/processor.h>
+#include <asm/fpu/api.h>
 #include <asm/user.h>
 
 /* Bit 63 of XCR0 is reserved for future expansion */
diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
index b1099f2..ec0d8e1 100644
--- a/arch/x86/include/asm/pgtable.h
+++ b/arch/x86/include/asm/pgtable.h
@@ -23,7 +23,7 @@
 
 #ifndef __ASSEMBLY__
 #include <asm/x86_init.h>
-#include <asm/fpu/xstate.h>
+#include <asm/pkru.h>
 #include <asm/fpu/api.h>
 #include <asm-generic/pgtable_uffd.h>
 
@@ -126,35 +126,6 @@ static inline int pte_dirty(pte_t pte)
 	return pte_flags(pte) & _PAGE_DIRTY;
 }
 
-
-static inline u32 read_pkru(void)
-{
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
-		return rdpkru();
-	return 0;
-}
-
-static inline void write_pkru(u32 pkru)
-{
-	struct pkru_state *pk;
-
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
-		return;
-
-	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
-
-	/*
-	 * The PKRU value in xstate needs to be in sync with the value that is
-	 * written to the CPU. The FPU restore on return to userland would
-	 * otherwise load the previous value again.
-	 */
-	fpregs_lock();
-	if (pk)
-		pk->pkru = pkru;
-	__write_pkru(pkru);
-	fpregs_unlock();
-}
-
 static inline int pte_young(pte_t pte)
 {
 	return pte_flags(pte) & _PAGE_ACCESSED;
@@ -1360,32 +1331,6 @@ static inline pmd_t pmd_swp_clear_uffd_wp(pmd_t pmd)
 }
 #endif /* CONFIG_HAVE_ARCH_USERFAULTFD_WP */
 
-#define PKRU_AD_BIT 0x1
-#define PKRU_WD_BIT 0x2
-#define PKRU_BITS_PER_PKEY 2
-
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-extern u32 init_pkru_value;
-#else
-#define init_pkru_value	0
-#endif
-
-static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
-{
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
-}
-
-static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
-{
-	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
-	/*
-	 * Access-disable disables writes too so we need to check
-	 * both bits here.
-	 */
-	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
-}
-
 static inline u16 pte_flags_pkey(unsigned long pte_flags)
 {
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
new file mode 100644
index 0000000..35ffcfd
--- /dev/null
+++ b/arch/x86/include/asm/pkru.h
@@ -0,0 +1,61 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_X86_PKRU_H
+#define _ASM_X86_PKRU_H
+
+#include <asm/fpu/xstate.h>
+
+#define PKRU_AD_BIT 0x1
+#define PKRU_WD_BIT 0x2
+#define PKRU_BITS_PER_PKEY 2
+
+#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
+extern u32 init_pkru_value;
+#else
+#define init_pkru_value	0
+#endif
+
+static inline bool __pkru_allows_read(u32 pkru, u16 pkey)
+{
+	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
+	return !(pkru & (PKRU_AD_BIT << pkru_pkey_bits));
+}
+
+static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
+{
+	int pkru_pkey_bits = pkey * PKRU_BITS_PER_PKEY;
+	/*
+	 * Access-disable disables writes too so we need to check
+	 * both bits here.
+	 */
+	return !(pkru & ((PKRU_AD_BIT|PKRU_WD_BIT) << pkru_pkey_bits));
+}
+
+static inline u32 read_pkru(void)
+{
+	if (boot_cpu_has(X86_FEATURE_OSPKE))
+		return rdpkru();
+	return 0;
+}
+
+static inline void write_pkru(u32 pkru)
+{
+	struct pkru_state *pk;
+
+	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+		return;
+
+	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
+
+	/*
+	 * The PKRU value in xstate needs to be in sync with the value that is
+	 * written to the CPU. The FPU restore on return to userland would
+	 * otherwise load the previous value again.
+	 */
+	fpregs_lock();
+	if (pk)
+		pk->pkru = pkru;
+	__write_pkru(pkru);
+	fpregs_unlock();
+}
+
+#endif
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d08307d..4651ab0 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -41,6 +41,7 @@
 #include <linux/syscalls.h>
 
 #include <asm/processor.h>
+#include <asm/pkru.h>
 #include <asm/fpu/internal.h>
 #include <asm/mmu_context.h>
 #include <asm/prctl.h>
diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index 8d36f0c..62926f1 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -19,6 +19,7 @@
 #include <linux/trace_events.h>
 #include <asm/fpu/internal.h>
 
+#include <asm/pkru.h>
 #include <asm/trapnr.h>
 
 #include "x86.h"
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 6f651b9..07f7888 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -65,6 +65,7 @@
 #include <asm/msr.h>
 #include <asm/desc.h>
 #include <asm/mce.h>
+#include <asm/pkru.h>
 #include <linux/kernel_stat.h>
 #include <asm/fpu/internal.h> /* Ugh! */
 #include <asm/pvclock.h>
diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
index a840ac7..a02cfcf 100644
--- a/arch/x86/mm/pkeys.c
+++ b/arch/x86/mm/pkeys.c
@@ -10,6 +10,7 @@
 
 #include <asm/cpufeature.h>             /* boot_cpu_has, ...            */
 #include <asm/mmu_context.h>            /* vma_pkey()                   */
+#include <asm/pkru.h>			/* read/write_pkru()		*/
 
 int __execute_only_pkey(struct mm_struct *mm)
 {
