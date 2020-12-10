Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D31BE2D59BA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 12:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729846AbgLJLug (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 06:50:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729145AbgLJLug (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 06:50:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFA35C0613CF;
        Thu, 10 Dec 2020 03:49:51 -0800 (PST)
Date:   Thu, 10 Dec 2020 11:49:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AA21U8t2EvvRBLA8lpQulNVYckzq+3CkMnMrPJO/DK0=;
        b=2nqyaAm7ItP1rrtZLqh5nJEoA13CWtD5rPJq8EyTdl3xON9rU2wbKCz9UiyagM03vZs/OR
        nXweRdd2ugu5oGVifU7YWx4A+V8Vn1Fa8bL6lCNd0XjMD5OnXa5w1P8PDKNCebze29/HSK
        Y5wkcPIdKLgtMoT8c6esx/gvoSBq8rFvCdTB5rt4b65X4CxK65GUw0nhiIZO6HbCHWsiA4
        ZqTkNTHTs7pCcn8K5PIfV6sNtGAOghc23f1JBd7kw3060sdRUlYHXBYzhiRIgTmyHEyxZx
        IaJJhDy8gaMq3wBNjpeRBVNRt592srEJCrpZJ5yB7E0cruDCrlRV8BIaCIU8Bw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607600990;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AA21U8t2EvvRBLA8lpQulNVYckzq+3CkMnMrPJO/DK0=;
        b=ktfI+OZDprGgwOs7Um0HdD+3yio16EI3hF8Yew5WjUNdJv1DbLngFj4OaNUXQ159bBoprQ
        UnJeoz52F7+MAoAQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: arm: reduce minimum alignment of uncompressed kernel
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160760098993.3364.7561911482150004641.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     c0249238feefbbb99d517d06ace4338393901b67
Gitweb:        https://git.kernel.org/tip/c0249238feefbbb99d517d06ace4338393901b67
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Thu, 12 Nov 2020 15:42:27 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 09 Dec 2020 08:37:27 +01:00

efi: arm: reduce minimum alignment of uncompressed kernel

Now that we reduced the minimum relative alignment between PHYS_OFFSET
and PAGE_OFFSET to 2 MiB, we can take this into account when allocating
memory for the decompressed kernel when booting via EFI. This minimizes
the amount of unusable memory we may end up with due to the base of DRAM
being occupied by firmware.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/arm/include/asm/efi.h | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/arch/arm/include/asm/efi.h b/arch/arm/include/asm/efi.h
index e9a06e1..1536805 100644
--- a/arch/arm/include/asm/efi.h
+++ b/arch/arm/include/asm/efi.h
@@ -66,13 +66,12 @@ static inline void efifb_setup_from_dmi(struct screen_info *si, const char *opt)
 #define MAX_UNCOMP_KERNEL_SIZE	SZ_32M
 
 /*
- * phys-to-virt patching requires that the physical to virtual offset fits
- * into the immediate field of an add/sub instruction, which comes down to the
- * 24 least significant bits being zero, and so the offset should be a multiple
- * of 16 MB. Since PAGE_OFFSET itself is a multiple of 16 MB, the physical
- * base should be aligned to 16 MB as well.
+ * phys-to-virt patching requires that the physical to virtual offset is a
+ * multiple of 2 MiB. However, using an alignment smaller than TEXT_OFFSET
+ * here throws off the memory allocation logic, so let's use the lowest power
+ * of two greater than 2 MiB and greater than TEXT_OFFSET.
  */
-#define EFI_PHYS_ALIGN		SZ_16M
+#define EFI_PHYS_ALIGN		max(SZ_2M, roundup_pow_of_two(TEXT_OFFSET))
 
 /* on ARM, the FDT should be located in a lowmem region */
 static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
@@ -83,7 +82,7 @@ static inline unsigned long efi_get_max_fdt_addr(unsigned long image_addr)
 /* on ARM, the initrd should be loaded in a lowmem region */
 static inline unsigned long efi_get_max_initrd_addr(unsigned long image_addr)
 {
-	return round_down(image_addr, EFI_PHYS_ALIGN) + SZ_512M;
+	return round_down(image_addr, SZ_4M) + SZ_512M;
 }
 
 struct efi_arm_entry_state {
