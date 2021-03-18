Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 10208340E54
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Mar 2021 20:35:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbhCRTeu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 18 Mar 2021 15:34:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhCRTeh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 18 Mar 2021 15:34:37 -0400
Date:   Thu, 18 Mar 2021 19:34:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616096076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgBJ8dAbI+xdC3DgGpVFjl4W4K+XrHTFeI4c7i0BqIU=;
        b=wQIJRSXLa2H4+xOf4M7Etf6xcZ+MjpgjY5/5Lb9MRWv8BIYcrWxJEqNl4rDH5uRAmB7wdR
        l5u6FaTuqd5/ntQEFc9loazffsZCsJrJYpPnYNIL5xTVWJEkzjPZUzjGVAnawRhlJ8a7xZ
        RCkHKQI+TaBPBhawr2SHdvY3x2ijqG2ZUHdmOgsa18H3/ra1gF2AFS6rkjQOm+ZsgMmwBs
        TkPpZnqTmsQ6/yhNOG0w5LrjYhH3ALbvkTGCWRGgzq2ffy1clLtYc0rc1JfAa4/4F5sP8W
        hRGkWfc93kBk4l96hncPIcFy7WEmtcSM3BuxruHlIFjfmVg4ZSTUy4RoRdUtyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616096076;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bgBJ8dAbI+xdC3DgGpVFjl4W4K+XrHTFeI4c7i0BqIU=;
        b=OjWpcrn9+3HyiU0yrr5A3Mj+mxTrE7RVUi149WwnfxIRaed0pjAdwRT3D9N+OG/Rh3BNsQ
        3yo5+LV9RU972aAA==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] x86/boot/compressed/64: Cleanup exception handling
 before booting kernel
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210312123824.306-2-joro@8bytes.org>
References: <20210312123824.306-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <161609607565.398.17424336852133612426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     b099155e2df7dadf8b1ad9828158b89f5639f654
Gitweb:        https://git.kernel.org/tip/b099155e2df7dadf8b1ad9828158b89f5639f654
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Wed, 10 Mar 2021 09:43:19 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 18 Mar 2021 16:44:36 +01:00

x86/boot/compressed/64: Cleanup exception handling before booting kernel

Disable the exception handling before booting the kernel to make sure
any exceptions that happen during early kernel boot are not directed to
the pre-decompression code.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210312123824.306-2-joro@8bytes.org
---
 arch/x86/boot/compressed/idt_64.c | 14 ++++++++++++++
 arch/x86/boot/compressed/misc.c   |  7 ++-----
 arch/x86/boot/compressed/misc.h   |  6 ++++++
 3 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/arch/x86/boot/compressed/idt_64.c b/arch/x86/boot/compressed/idt_64.c
index 804a502..9b93567 100644
--- a/arch/x86/boot/compressed/idt_64.c
+++ b/arch/x86/boot/compressed/idt_64.c
@@ -52,3 +52,17 @@ void load_stage2_idt(void)
 
 	load_boot_idt(&boot_idt_desc);
 }
+
+void cleanup_exception_handling(void)
+{
+	/*
+	 * Flush GHCB from cache and map it encrypted again when running as
+	 * SEV-ES guest.
+	 */
+	sev_es_shutdown_ghcb();
+
+	/* Set a null-idt, disabling #PF and #VC handling */
+	boot_idt_desc.size    = 0;
+	boot_idt_desc.address = 0;
+	load_boot_idt(&boot_idt_desc);
+}
diff --git a/arch/x86/boot/compressed/misc.c b/arch/x86/boot/compressed/misc.c
index 267e7f9..cc9fd0e 100644
--- a/arch/x86/boot/compressed/misc.c
+++ b/arch/x86/boot/compressed/misc.c
@@ -443,11 +443,8 @@ asmlinkage __visible void *extract_kernel(void *rmode, memptr heap,
 	handle_relocations(output, output_len, virt_addr);
 	debug_putstr("done.\nBooting the kernel.\n");
 
-	/*
-	 * Flush GHCB from cache and map it encrypted again when running as
-	 * SEV-ES guest.
-	 */
-	sev_es_shutdown_ghcb();
+	/* Disable exception handling before booting the kernel */
+	cleanup_exception_handling();
 
 	return output;
 }
diff --git a/arch/x86/boot/compressed/misc.h b/arch/x86/boot/compressed/misc.h
index 901ea5e..e5612f0 100644
--- a/arch/x86/boot/compressed/misc.h
+++ b/arch/x86/boot/compressed/misc.h
@@ -155,6 +155,12 @@ extern pteval_t __default_kernel_pte_mask;
 extern gate_desc boot_idt[BOOT_IDT_ENTRIES];
 extern struct desc_ptr boot_idt_desc;
 
+#ifdef CONFIG_X86_64
+void cleanup_exception_handling(void);
+#else
+static inline void cleanup_exception_handling(void) { }
+#endif
+
 /* IDT Entry Points */
 void boot_page_fault(void);
 void boot_stage1_vc(void);
