Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 763604535E2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Nov 2021 16:34:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238327AbhKPPgW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Nov 2021 10:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238319AbhKPPgR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Nov 2021 10:36:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA5F1C061570;
        Tue, 16 Nov 2021 07:33:18 -0800 (PST)
Date:   Tue, 16 Nov 2021 15:33:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637076796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/MFmn50BAEDlOyGJJI4CqEFN8mghM98o84wYiim7ys=;
        b=yOizHkSyGdzyWfg1H7mkJtGJfd/QMhUw0Zc5l/1RJ/jFo1ydViz007nbHTN7VmDf7VVskM
        qiOnAOUJH5JNYikShbJISiDVk/OqTp561Pu6mESIyGah22JeXkaN0657KAWI3PId7ZhUUm
        wJKnNzckVh2ojiU23OLD9Jwljv3UKlLSiFCQg6LnyB7ca77DsWKIJpYDJibhyx0AZWZ04j
        nLJoUxXhsdldvW8zGiuBm3X0FM1n9F+umq0PEIxyn8i/pUA5Cd3kYZRtLVbNdtkdciwpmU
        9+O99RqMFdZjbTr8Y0LECOSOeD3tkkdd1nPtp8mKPJTM4YJRbx+Hbw2JWr+dNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637076796;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T/MFmn50BAEDlOyGJJI4CqEFN8mghM98o84wYiim7ys=;
        b=rnXStD4s1pJ92QDtLuV8xSTZ3L8swv/yXdS9v+jYcjvWo3VPffrR7l0kcC9hF16SKPHegq
        UdgLsqCOfaYbGwDQ==
From:   "tip-bot2 for Borislav Petkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sev] x86/head64: Carve out the guest encryption
 postprocessing into a helper
Cc:     Borislav Petkov <bp@suse.de>,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211110220731.2396491-7-brijesh.singh@amd.com>
References: <20211110220731.2396491-7-brijesh.singh@amd.com>
MIME-Version: 1.0
Message-ID: <163707679584.414.14001177725173837713.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/sev branch of tip:

Commit-ID:     5ed0a99b12aa2dd09afe7ba485145529b89f26e6
Gitweb:        https://git.kernel.org/tip/5ed0a99b12aa2dd09afe7ba485145529b89f26e6
Author:        Borislav Petkov <bp@suse.de>
AuthorDate:    Wed, 10 Nov 2021 16:06:52 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 15 Nov 2021 21:05:14 +01:00

x86/head64: Carve out the guest encryption postprocessing into a helper

Carve it out so that it is abstracted out of the main boot path. All
other encrypted guest-relevant processing should be placed in there.

No functional changes.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Brijesh Singh <brijesh.singh@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211110220731.2396491-7-brijesh.singh@amd.com
---
 arch/x86/kernel/head64.c | 60 ++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index fc5371a..3be9dd2 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -126,6 +126,36 @@ static bool __head check_la57_support(unsigned long physaddr)
 }
 #endif
 
+static unsigned long sme_postprocess_startup(struct boot_params *bp, pmdval_t *pmd)
+{
+	unsigned long vaddr, vaddr_end;
+	int i;
+
+	/* Encrypt the kernel and related (if SME is active) */
+	sme_encrypt_kernel(bp);
+
+	/*
+	 * Clear the memory encryption mask from the .bss..decrypted section.
+	 * The bss section will be memset to zero later in the initialization so
+	 * there is no need to zero it after changing the memory encryption
+	 * attribute.
+	 */
+	if (sme_get_me_mask()) {
+		vaddr = (unsigned long)__start_bss_decrypted;
+		vaddr_end = (unsigned long)__end_bss_decrypted;
+		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
+			i = pmd_index(vaddr);
+			pmd[i] -= sme_get_me_mask();
+		}
+	}
+
+	/*
+	 * Return the SME encryption mask (if SME is active) to be used as a
+	 * modifier for the initial pgdir entry programmed into CR3.
+	 */
+	return sme_get_me_mask();
+}
+
 /* Code in __startup_64() can be relocated during execution, but the compiler
  * doesn't have to generate PC-relative relocations when accessing globals from
  * that function. Clang actually does not generate them, which leads to
@@ -135,7 +165,6 @@ static bool __head check_la57_support(unsigned long physaddr)
 unsigned long __head __startup_64(unsigned long physaddr,
 				  struct boot_params *bp)
 {
-	unsigned long vaddr, vaddr_end;
 	unsigned long load_delta, *p;
 	unsigned long pgtable_flags;
 	pgdval_t *pgd;
@@ -276,34 +305,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 	 */
 	*fixup_long(&phys_base, physaddr) += load_delta - sme_get_me_mask();
 
-	/* Encrypt the kernel and related (if SME is active) */
-	sme_encrypt_kernel(bp);
-
-	/*
-	 * Clear the memory encryption mask from the .bss..decrypted section.
-	 * The bss section will be memset to zero later in the initialization so
-	 * there is no need to zero it after changing the memory encryption
-	 * attribute.
-	 *
-	 * This is early code, use an open coded check for SME instead of
-	 * using cc_platform_has(). This eliminates worries about removing
-	 * instrumentation or checking boot_cpu_data in the cc_platform_has()
-	 * function.
-	 */
-	if (sme_get_me_mask()) {
-		vaddr = (unsigned long)__start_bss_decrypted;
-		vaddr_end = (unsigned long)__end_bss_decrypted;
-		for (; vaddr < vaddr_end; vaddr += PMD_SIZE) {
-			i = pmd_index(vaddr);
-			pmd[i] -= sme_get_me_mask();
-		}
-	}
-
-	/*
-	 * Return the SME encryption mask (if SME is active) to be used as a
-	 * modifier for the initial pgdir entry programmed into CR3.
-	 */
-	return sme_get_me_mask();
+	return sme_postprocess_startup(bp, pmd);
 }
 
 unsigned long __startup_secondary_64(void)
