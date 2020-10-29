Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 972AE29F4BD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 20:18:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726039AbgJ2TSc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 15:18:32 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35550 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2TRo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 15:17:44 -0400
Date:   Thu, 29 Oct 2020 19:17:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603999061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewhzt3ov+k4TqqYL6myx+k611JR93JqwHQuyL9E5zt0=;
        b=niuY8hYNIDZcoXRMuQ2IkWuFtNfTvIe2l0eI79liYkoflS5EcSuM5pAXNYSAcuVocvlNK4
        NznlCvQS+jWE2mxv/jErVv8K/mBAzOIyFO8pdgdrzbLVJFpo+rEBsusx/iCqm84xTqucQp
        wdBNE+LmwQkyyu1QzgY86er/ABnHh2rtHCst11KEcCYllodwcL0pIOla2z9qVi8lg1JjY+
        z2dulcnaG8gr9IBnyxWwuNK7GYkeZ4E4yeiFYlFChwNiRI0ygeg9TCIzuvxuWndPwDO7vD
        mxMroH4ErqHlWX+ucs07TXeBRLqBGbTzUunh6elP36yN44DbSUjk/oznTDyuWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603999061;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ewhzt3ov+k4TqqYL6myx+k611JR93JqwHQuyL9E5zt0=;
        b=z5QHlOUPu/lQLeafpUoUs9zzuU1HKbrmiLemHd9+QinZF46FjA3WcxCywNLeSnu9HlonvP
        GKASh7oWPUzDUODQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/head/64: Check SEV encryption before switching
 to kernel page-table
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201028164659.27002-5-joro@8bytes.org>
References: <20201028164659.27002-5-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <160399906056.397.8553939010243281657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     c9f09539e16e281f92a27760fdfae71e8af036f6
Gitweb:        https://git.kernel.org/tip/c9f09539e16e281f92a27760fdfae71e8af036f6
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 28 Oct 2020 17:46:58 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 29 Oct 2020 18:09:59 +01:00

x86/head/64: Check SEV encryption before switching to kernel page-table

When SEV is enabled, the kernel requests the C-bit position again from
the hypervisor to build its own page-table. Since the hypervisor is an
untrusted source, the C-bit position needs to be verified before the
kernel page-table is used.

Call sev_verify_cbit() before writing the CR3.

 [ bp: Massage. ]

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Link: https://lkml.kernel.org/r/20201028164659.27002-5-joro@8bytes.org
---
 arch/x86/kernel/head_64.S | 16 ++++++++++++++++
 arch/x86/mm/mem_encrypt.c |  1 +
 2 files changed, 17 insertions(+)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 7eb2a1c..3c41773 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -161,6 +161,21 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 
 	/* Setup early boot stage 4-/5-level pagetables. */
 	addq	phys_base(%rip), %rax
+
+	/*
+	 * For SEV guests: Verify that the C-bit is correct. A malicious
+	 * hypervisor could lie about the C-bit position to perform a ROP
+	 * attack on the guest by writing to the unencrypted stack and wait for
+	 * the next RET instruction.
+	 * %rsi carries pointer to realmode data and is callee-clobbered. Save
+	 * and restore it.
+	 */
+	pushq	%rsi
+	movq	%rax, %rdi
+	call	sev_verify_cbit
+	popq	%rsi
+
+	/* Switch to new page-table */
 	movq	%rax, %cr3
 
 	/* Ensure I am executing from virtual addresses */
@@ -279,6 +294,7 @@ SYM_INNER_LABEL(secondary_startup_64_no_verify, SYM_L_GLOBAL)
 SYM_CODE_END(secondary_startup_64)
 
 #include "verify_cpu.S"
+#include "sev_verify_cbit.S"
 
 #ifdef CONFIG_HOTPLUG_CPU
 /*
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index efbb3de..bc08337 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -39,6 +39,7 @@
  */
 u64 sme_me_mask __section(".data") = 0;
 u64 sev_status __section(".data") = 0;
+u64 sev_check_data __section(".data") = 0;
 EXPORT_SYMBOL(sme_me_mask);
 DEFINE_STATIC_KEY_FALSE(sev_enable_key);
 EXPORT_SYMBOL_GPL(sev_enable_key);
