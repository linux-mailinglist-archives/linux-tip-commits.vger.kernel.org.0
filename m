Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14BD7223EB0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jul 2020 16:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726205AbgGQOvQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jul 2020 10:51:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726856AbgGQOvL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jul 2020 10:51:11 -0400
Date:   Fri, 17 Jul 2020 14:51:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594997468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQqyKN2xfH3m7OlTlBc/MA5x2Nb6zrzqzw00WX7Wec8=;
        b=IDpVDRwsmBU/elGGR1+CKDQfF0ALIRWtmBYe8jcpxc9D5qHV3XYzsS0+Cwcggn+5ro8KJn
        kfChthRlgLJ3YnL7+aJ4kE+smQDOD5Wm7F9WaPSD7Ich7pHbM391RIl770Gpt+dcG3if9F
        kAMMSHsQf6f106OGcmUCLyubBAWkP75VEzUAcHrZMMDtUkowbGUbVSeZOqZcbBTq3fVZ4z
        gRO0qU/8yB8AQCgM9QvAOfNu4v3MR6w6Woi+8n6fHwxWvrAYZLMxsUH8VJXzFo3vHlMc9x
        IRMZxVA8LUKE+XAVs11mX+bFBJR3+ITzEHsluZbvKlDdNoAOiAoopPwA/6WojQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594997468;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PQqyKN2xfH3m7OlTlBc/MA5x2Nb6zrzqzw00WX7Wec8=;
        b=ntrlp5XRbEwE8j0NWzPzqAdY3JHNekeybgnVGTqeKYCbVkNnvTPKdLMdQgijCombrUa26Z
        2zWNwSs+QIW2L8Dg==
From:   "tip-bot2 for steve.wahl@hpe.com" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/efi: Remove unused EFI_UV1_MEMMAP code
Cc:     Steve Wahl <steve.wahl@hpe.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200713212956.019149227@hpe.com>
References: <20200713212956.019149227@hpe.com>
MIME-Version: 1.0
Message-ID: <159499746650.4006.15958852805586049775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam: Yes
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     3bcf25a40b018e632d70bb866d75746748953fbc
Gitweb:        https://git.kernel.org/tip/3bcf25a40b018e632d70bb866d75746748953fbc
Author:        steve.wahl@hpe.com <steve.wahl@hpe.com>
AuthorDate:    Mon, 13 Jul 2020 16:30:07 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 17 Jul 2020 16:47:48 +02:00

x86/efi: Remove unused EFI_UV1_MEMMAP code

With UV1 support removed, EFI_UV1_MEMMAP is no longer used.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
Link: https://lkml.kernel.org/r/20200713212956.019149227@hpe.com

---
 arch/x86/include/asm/efi.h | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index e7d2ccf..b9c2667 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -22,17 +22,7 @@ extern unsigned long efi_fw_vendor, efi_config_table;
  *
  * This is the main reason why we're doing stable VA mappings for RT
  * services.
- *
- * SGI UV1 machines are known to be incompatible with this scheme, so we
- * provide an opt-out for these machines via a DMI quirk that sets the
- * attribute below.
  */
-#define EFI_UV1_MEMMAP         EFI_ARCH_1
-
-static inline bool efi_have_uv1_memmap(void)
-{
-	return IS_ENABLED(CONFIG_X86_UV) && efi_enabled(EFI_UV1_MEMMAP);
-}
 
 #define EFI32_LOADER_SIGNATURE	"EL32"
 #define EFI64_LOADER_SIGNATURE	"EL64"
@@ -122,9 +112,7 @@ struct efi_scratch {
 	efi_sync_low_kernel_mappings();					\
 	kernel_fpu_begin();						\
 	firmware_restrict_branch_speculation_start();			\
-									\
-	if (!efi_have_uv1_memmap())					\
-		efi_switch_mm(&efi_mm);					\
+	efi_switch_mm(&efi_mm);						\
 })
 
 #define arch_efi_call_virt(p, f, args...)				\
@@ -132,9 +120,7 @@ struct efi_scratch {
 
 #define arch_efi_call_virt_teardown()					\
 ({									\
-	if (!efi_have_uv1_memmap())					\
-		efi_switch_mm(efi_scratch.prev_mm);			\
-									\
+	efi_switch_mm(efi_scratch.prev_mm);				\
 	firmware_restrict_branch_speculation_end();			\
 	kernel_fpu_end();						\
 })
@@ -176,8 +162,6 @@ extern void efi_delete_dummy_variable(void);
 extern void efi_switch_mm(struct mm_struct *mm);
 extern void efi_recover_from_page_fault(unsigned long phys_addr);
 extern void efi_free_boot_services(void);
-extern pgd_t * __init efi_uv1_memmap_phys_prolog(void);
-extern void __init efi_uv1_memmap_phys_epilog(pgd_t *save_pgd);
 
 /* kexec external ABI */
 struct efi_setup_data {
