Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8582306437
	for <lists+linux-tip-commits@lfdr.de>; Wed, 27 Jan 2021 20:37:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344532AbhA0Tfh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 27 Jan 2021 14:35:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231704AbhA0Tb5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 27 Jan 2021 14:31:57 -0500
Date:   Wed, 27 Jan 2021 19:31:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611775872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AhKO4K2HzOCvVQ9ZqBgzClyMjpmqqFgQQ03NcZYTka0=;
        b=O1dzd2sXtkQ/HIue1ZEDQcGJHDmcsCshEWrrVODkiFQwMuYh2WziOzifEqpu+iAidXSY62
        u3EH9auoYlq0gTfjzQt5LgNjIDdTxEiojraz6f1PbaC7kI/rwmXCbb3oUqPqGKYMg0EayN
        6CiReOg308JPxyj4hT+s0wUy1rM+WpXqL7zPvWZAd17hgSnI6biSCYFxfs14vXlWLRcAF+
        PetowfUvoHrsd/cH4eEIMZyQxCXZzg6ykjYzbL6BAEuMu4YP5HYrE+dBE6xf4q5HJ2KYoH
        K6rLn05vNRWY7zqlpFDCZZv8VkSZL0vBAmjIf3NoepedQGNqSOJkui2ZsjFZPA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611775872;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AhKO4K2HzOCvVQ9ZqBgzClyMjpmqqFgQQ03NcZYTka0=;
        b=uvsiEMxXmELnpj0Cwi1Lrrz3XHd0qtq33oNy+aaNLkiTB9dtd1Ydw20AHu46/1C7WQ3DYf
        DDseE7Nuw/ep4/Dw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: ia64: move IA64-only declarations to new
 asm/efi.h header
Cc:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161177587138.23325.17245237441010462333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     8ff059b8531f3b98e14f0461859fc7cdd95823e4
Gitweb:        https://git.kernel.org/tip/8ff059b8531f3b98e14f0461859fc7cdd95823e4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 18 Jan 2021 13:38:42 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 18 Jan 2021 13:50:37 +01:00

efi: ia64: move IA64-only declarations to new asm/efi.h header

Move some EFI related declarations that are only referenced on IA64 to
a new asm/efi.h arch header.

Cc: Tony Luck <tony.luck@intel.com>
Cc: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/ia64/include/asm/efi.h      | 13 +++++++++++++
 arch/ia64/kernel/efi.c           |  1 +
 arch/ia64/kernel/machine_kexec.c |  1 +
 arch/ia64/kernel/mca.c           |  1 +
 arch/ia64/kernel/smpboot.c       |  1 +
 arch/ia64/kernel/time.c          |  1 +
 arch/ia64/kernel/uncached.c      |  4 +---
 arch/ia64/mm/contig.c            |  1 +
 arch/ia64/mm/discontig.c         |  1 +
 arch/ia64/mm/init.c              |  1 +
 include/linux/efi.h              |  6 ------
 11 files changed, 22 insertions(+), 9 deletions(-)
 create mode 100644 arch/ia64/include/asm/efi.h

diff --git a/arch/ia64/include/asm/efi.h b/arch/ia64/include/asm/efi.h
new file mode 100644
index 0000000..6a4a50d
--- /dev/null
+++ b/arch/ia64/include/asm/efi.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_EFI_H
+#define _ASM_EFI_H
+
+typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
+
+void *efi_get_pal_addr(void);
+void efi_map_pal_code(void);
+void efi_memmap_walk(efi_freemem_callback_t, void *);
+void efi_memmap_walk_uc(efi_freemem_callback_t, void *);
+void efi_gettimeofday(struct timespec64 *ts);
+
+#endif
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index f932b25..dd7fd75 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -34,6 +34,7 @@
 #include <linux/kexec.h>
 #include <linux/mm.h>
 
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/kregs.h>
 #include <asm/meminit.h>
diff --git a/arch/ia64/kernel/machine_kexec.c b/arch/ia64/kernel/machine_kexec.c
index efc9b56..af310dc 100644
--- a/arch/ia64/kernel/machine_kexec.c
+++ b/arch/ia64/kernel/machine_kexec.c
@@ -16,6 +16,7 @@
 #include <linux/numa.h>
 #include <linux/mmzone.h>
 
+#include <asm/efi.h>
 #include <asm/numa.h>
 #include <asm/mmu_context.h>
 #include <asm/setup.h>
diff --git a/arch/ia64/kernel/mca.c b/arch/ia64/kernel/mca.c
index 2703f77..0fea266 100644
--- a/arch/ia64/kernel/mca.c
+++ b/arch/ia64/kernel/mca.c
@@ -91,6 +91,7 @@
 #include <linux/gfp.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
diff --git a/arch/ia64/kernel/smpboot.c b/arch/ia64/kernel/smpboot.c
index 093040f..49b4885 100644
--- a/arch/ia64/kernel/smpboot.c
+++ b/arch/ia64/kernel/smpboot.c
@@ -45,6 +45,7 @@
 #include <asm/cache.h>
 #include <asm/current.h>
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/mca.h>
diff --git a/arch/ia64/kernel/time.c b/arch/ia64/kernel/time.c
index ed9fc3d..a37f161 100644
--- a/arch/ia64/kernel/time.c
+++ b/arch/ia64/kernel/time.c
@@ -26,6 +26,7 @@
 #include <linux/sched/cputime.h>
 
 #include <asm/delay.h>
+#include <asm/efi.h>
 #include <asm/hw_irq.h>
 #include <asm/ptrace.h>
 #include <asm/sal.h>
diff --git a/arch/ia64/kernel/uncached.c b/arch/ia64/kernel/uncached.c
index 0750f36..51883a6 100644
--- a/arch/ia64/kernel/uncached.c
+++ b/arch/ia64/kernel/uncached.c
@@ -20,14 +20,12 @@
 #include <linux/genalloc.h>
 #include <linux/gfp.h>
 #include <linux/pgtable.h>
+#include <asm/efi.h>
 #include <asm/page.h>
 #include <asm/pal.h>
 #include <linux/atomic.h>
 #include <asm/tlbflush.h>
 
-
-extern void __init efi_memmap_walk_uc(efi_freemem_callback_t, void *);
-
 struct uncached_pool {
 	struct gen_pool *pool;
 	struct mutex add_chunk_mutex;	/* serialize adding a converted chunk */
diff --git a/arch/ia64/mm/contig.c b/arch/ia64/mm/contig.c
index bfc4ecd..62fe80a 100644
--- a/arch/ia64/mm/contig.c
+++ b/arch/ia64/mm/contig.c
@@ -21,6 +21,7 @@
 #include <linux/swap.h>
 #include <linux/sizes.h>
 
+#include <asm/efi.h>
 #include <asm/meminit.h>
 #include <asm/sections.h>
 #include <asm/mca.h>
diff --git a/arch/ia64/mm/discontig.c b/arch/ia64/mm/discontig.c
index c731113..03b3a02 100644
--- a/arch/ia64/mm/discontig.c
+++ b/arch/ia64/mm/discontig.c
@@ -24,6 +24,7 @@
 #include <linux/efi.h>
 #include <linux/nodemask.h>
 #include <linux/slab.h>
+#include <asm/efi.h>
 #include <asm/tlb.h>
 #include <asm/meminit.h>
 #include <asm/numa.h>
diff --git a/arch/ia64/mm/init.c b/arch/ia64/mm/init.c
index 9b5acf8..24583a3 100644
--- a/arch/ia64/mm/init.c
+++ b/arch/ia64/mm/init.c
@@ -27,6 +27,7 @@
 #include <linux/swiotlb.h>
 
 #include <asm/dma.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 #include <asm/numa.h>
 #include <asm/patch.h>
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 763b816..0c31af3 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -167,8 +167,6 @@ struct capsule_info {
 
 int __efi_capsule_setup_info(struct capsule_info *cap_info);
 
-typedef int (*efi_freemem_callback_t) (u64 start, u64 end, void *arg);
-
 /*
  * Types and defines for Time Services
  */
@@ -605,10 +603,6 @@ efi_guid_to_str(efi_guid_t *guid, char *out)
 }
 
 extern void efi_init (void);
-extern void *efi_get_pal_addr (void);
-extern void efi_map_pal_code (void);
-extern void efi_memmap_walk (efi_freemem_callback_t callback, void *arg);
-extern void efi_gettimeofday (struct timespec64 *ts);
 #ifdef CONFIG_EFI
 extern void efi_enter_virtual_mode (void);	/* switch EFI to virtual mode, if possible */
 #else
