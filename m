Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E74702D59AA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 12:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730713AbgLJLuj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 06:50:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53416 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728557AbgLJLuh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 06:50:37 -0500
Date:   Thu, 10 Dec 2020 11:49:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FIX814nEHUPMjwkv1AjMaIrKfaJ0xWl41OZy/VCyttw=;
        b=UPjz7zl3238q3s1YL2HPn34yuGaSw+Tak6hKNWDw3My9w2WXTzMhqJmIw/40uhFR24Lqea
        owhUu0HzYnvMFxPPLoGndu4qzoOHAaRCpiE+ALZaPtRvgsqnCpM7PW4vK7OUrtNHleMv32
        ZZcWs8zmBfQf1+ERLITV69NkS9O04Gw8EByFVhBtcAmPK6brCfy/ku4vikcDXjO35d5ayG
        tdUFAqnH7MpBFOR8vryQC7ARRXNxs//HWKg9Zt698J1ag0qcZCDHzsZJsQO/DW3XN1GT1D
        jKlyi9Z6qHCKI6a/TbN4WrFs1n2nxr58DqeMQwZOn4VREGsALN3G6DkLCQLHLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=FIX814nEHUPMjwkv1AjMaIrKfaJ0xWl41OZy/VCyttw=;
        b=jEee4QhyJjhQec/s80ksIFDWDI7dX56xGYXMX2dAvQ1gzNesDa5No2hF+He7c341uKBzWs
        HXW+wW2aa4oeyvDg==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: capsule: clean scatter-gather entries from the D-cache
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160760099018.3364.9963182173136934121.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     4dbe44fb538c59a4adae5abfa9ded2f310250315
Gitweb:        https://git.kernel.org/tip/4dbe44fb538c59a4adae5abfa9ded2f310250315
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Mon, 07 Dec 2020 18:40:53 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 09 Dec 2020 08:37:27 +01:00

efi: capsule: clean scatter-gather entries from the D-cache

Scatter-gather lists passed to UpdateCapsule() should be cleaned
from the D-cache to ensure that they are visible to the CPU after a
warm reboot before the MMU is enabled. On ARM and arm64 systems, this
implies a D-cache clean by virtual address to the point of coherency.

However, due to the fact that the firmware itself is not able to map
physical addresses back to virtual addresses when running under the OS,
this must be done by the caller.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h     |  5 +++++
 arch/arm64/include/asm/efi.h   |  5 +++++
 drivers/firmware/efi/capsule.c | 12 ++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index 3ee4f43..e9a06e1 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -93,4 +93,9 @@ struct efi_arm_entry_state {
 	u32	sctlr_after_ebs;
 };
 
+static inline void efi_capsule_flush_cache_range(void *addr, int size)
+{
+	__cpuc_flush_dcache_area(addr, size);
+}
+
 #endif /* _ASM_ARM_EFI_H */
diff --git a/arch/arm64/include/asm/efi.h b/arch/arm64/include/asm/efi.h
index 973b144..00bd1e1 100644
--- a/arch/arm64/include/asm/efi.h
+++ b/arch/arm64/include/asm/efi.h
@@ -141,4 +141,9 @@ static inline void efi_set_pgd(struct mm_struct *mm)
 void efi_virtmap_load(void);
 void efi_virtmap_unload(void);
 
+static inline void efi_capsule_flush_cache_range(void *addr, int size)
+{
+	__flush_dcache_area(addr, size);
+}
+
 #endif /* _ASM_EFI_H */
diff --git a/drivers/firmware/efi/capsule.c b/drivers/firmware/efi/capsule.c
index 43f6fe7..7684302 100644
--- a/drivers/firmware/efi/capsule.c
+++ b/drivers/firmware/efi/capsule.c
@@ -12,6 +12,7 @@
 #include <linux/highmem.h>
 #include <linux/efi.h>
 #include <linux/vmalloc.h>
+#include <asm/efi.h>
 #include <asm/io.h>
 
 typedef struct {
@@ -265,6 +266,17 @@ int efi_capsule_update(efi_capsule_header_t *capsule, phys_addr_t *pages)
 		else
 			sglist[j].data = page_to_phys(sg_pages[i + 1]);
 
+#if defined(CONFIG_ARM) || defined(CONFIG_ARM64)
+		/*
+		 * At runtime, the firmware has no way to find out where the
+		 * sglist elements are mapped, if they are mapped in the first
+		 * place. Therefore, on architectures that can only perform
+		 * cache maintenance by virtual address, the firmware is unable
+		 * to perform this maintenance, and so it is up to the OS to do
+		 * it instead.
+		 */
+		efi_capsule_flush_cache_range(sglist, PAGE_SIZE);
+#endif
 		kunmap_atomic(sglist);
 	}
 
