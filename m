Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 595602C2954
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Nov 2020 15:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387670AbgKXOVI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 24 Nov 2020 09:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388797AbgKXOU5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 24 Nov 2020 09:20:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB64C0613D6;
        Tue, 24 Nov 2020 06:20:56 -0800 (PST)
Date:   Tue, 24 Nov 2020 14:20:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606227655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogbhSPWEG83zhK0V2u2AAzjIFeJ1GvhqBfhw7E+Qc3w=;
        b=bXFFzXPIvE7djAUvQzMUsgbwmLxpZMzOdNMn9bQsPhF7SCSxd9eP6e0Wycx3i2EppWtfVD
        KvQVVu5LG62tZRNV72AWHgIIY2cqtk0iDG8Zz1A4/IWokMWsH17p3Wlop+k8ibHuz4khIr
        LmShfhru+ewLzLA4vGvm3dhch0fsCvfGDSRwLqiNTnJKwLFkvGkhmiWAomyH2xdH7f8plh
        h5qhBBmCpQjEnGnnt23hf8tj/32M7+zPrsnSDBlpLhd7arPmLHYklSZmfdCQ9KgoJL6YI6
        zLPPKY24TxlaJtyVUG3DIg82kSvXvycQ3v1HTXVZK+paN2t7Jq2Bq6mR3Ze8Pw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606227655;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ogbhSPWEG83zhK0V2u2AAzjIFeJ1GvhqBfhw7E+Qc3w=;
        b=TOnL7V2L9JSRghilXK2awW3GO7/gSfeWK7GJvi7nLp403b7c1oeIL+fx6lYs7tAdNER2Bn
        W5exX/YFpuCHIzCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/mm] x86: Support kmap_local() forced debugging
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201118204007.169209557@linutronix.de>
References: <20201118204007.169209557@linutronix.de>
MIME-Version: 1.0
Message-ID: <160622765461.11115.741920401947490414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/mm branch of tip:

Commit-ID:     14df32670291588036a498051a54cd8462d7f611
Gitweb:        https://git.kernel.org/tip/14df32670291588036a498051a54cd8462d7f611
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 18 Nov 2020 20:48:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 24 Nov 2020 14:42:09 +01:00

x86: Support kmap_local() forced debugging

kmap_local() and related interfaces are NOOPs on 64bit and only create
temporary fixmaps for highmem pages on 32bit. That means the test coverage
for this code is pretty small.

CONFIG_KMAP_LOCAL can be enabled independent from CONFIG_HIGHMEM, which
allows to provide support for enforced kmap_local() debugging even on
64bit.

For 32bit the support is unconditional, for 64bit it's only supported when
CONFIG_NR_CPUS <= 4096 as supporting it for 8192 CPUs would require to set
up yet another fixmap PGT.

If CONFIG_KMAP_LOCAL_FORCE_DEBUG is enabled then kmap_local()/kmap_atomic()
will use the temporary fixmap mapping path.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20201118204007.169209557@linutronix.de

---
 arch/x86/Kconfig                        |  1 +
 arch/x86/include/asm/fixmap.h           | 12 +++++++++---
 arch/x86/include/asm/pgtable_64_types.h |  6 +++++-
 3 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 33c273c..b5137cc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -93,6 +93,7 @@ config X86
 	select ARCH_SUPPORTS_ACPI
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_NUMA_BALANCING	if X86_64
+	select ARCH_SUPPORTS_KMAP_LOCAL_FORCE_MAP	if NR_CPUS <= 4096
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
diff --git a/arch/x86/include/asm/fixmap.h b/arch/x86/include/asm/fixmap.h
index 8eba66a..9f1a0a9 100644
--- a/arch/x86/include/asm/fixmap.h
+++ b/arch/x86/include/asm/fixmap.h
@@ -14,13 +14,20 @@
 #ifndef _ASM_X86_FIXMAP_H
 #define _ASM_X86_FIXMAP_H
 
+#include <asm/kmap_size.h>
+
 /*
  * Exposed to assembly code for setting up initial page tables. Cannot be
  * calculated in assembly code (fixmap entries are an enum), but is sanity
  * checked in the actual fixmap C code to make sure that the fixmap is
  * covered fully.
  */
-#define FIXMAP_PMD_NUM	2
+#ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+# define FIXMAP_PMD_NUM	2
+#else
+# define KM_PMDS	(KM_MAX_IDX * ((CONFIG_NR_CPUS + 511) / 512))
+# define FIXMAP_PMD_NUM (KM_PMDS + 2)
+#endif
 /* fixmap starts downwards from the 507th entry in level2_fixmap_pgt */
 #define FIXMAP_PMD_TOP	507
 
@@ -31,7 +38,6 @@
 #include <asm/pgtable_types.h>
 #ifdef CONFIG_X86_32
 #include <linux/threads.h>
-#include <asm/kmap_size.h>
 #else
 #include <uapi/asm/vsyscall.h>
 #endif
@@ -92,7 +98,7 @@ enum fixed_addresses {
 	FIX_IO_APIC_BASE_0,
 	FIX_IO_APIC_BASE_END = FIX_IO_APIC_BASE_0 + MAX_IO_APICS - 1,
 #endif
-#ifdef CONFIG_X86_32
+#ifdef CONFIG_KMAP_LOCAL
 	FIX_KMAP_BEGIN,	/* reserved pte's for temporary kernel mappings */
 	FIX_KMAP_END = FIX_KMAP_BEGIN + (KM_MAX_IDX * NR_CPUS) - 1,
 #ifdef CONFIG_PCI_MMCONFIG
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 52e5f5f..91ac106 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -143,7 +143,11 @@ extern unsigned int ptrs_per_p4d;
 
 #define MODULES_VADDR		(__START_KERNEL_map + KERNEL_IMAGE_SIZE)
 /* The module sections ends with the start of the fixmap */
-#define MODULES_END		_AC(0xffffffffff000000, UL)
+#ifndef CONFIG_DEBUG_KMAP_LOCAL_FORCE_MAP
+# define MODULES_END		_AC(0xffffffffff000000, UL)
+#else
+# define MODULES_END		_AC(0xfffffffffe000000, UL)
+#endif
 #define MODULES_LEN		(MODULES_END - MODULES_VADDR)
 
 #define ESPFIX_PGD_ENTRY	_AC(-2, UL)
