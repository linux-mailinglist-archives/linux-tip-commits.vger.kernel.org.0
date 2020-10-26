Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB0022993AF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 18:23:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1421186AbgJZRXa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 13:23:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41272 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1774674AbgJZRX3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 13:23:29 -0400
Date:   Mon, 26 Oct 2020 17:23:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603733006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0emFXgdDtDcQ3Ms+iXnK2/3c/PuQX4E6Kz9iVHVmi0=;
        b=25bkLJEJJ4irRLJJRdL39yb13/GD6sCgIUdWtx+0CTID21zSXIqe9SzFChODDqyAeTDu42
        ocy9NtZaHbFSCdw+Cy53941Ws43v+yx48oskdb7T7JtB79G63zlhrhAY2wOvB4IwC5p1km
        oHcchIleaExc2jh+go/hmcczyklQG2gFBwKZGY/viDPt7jafgnMCoxWosEnoyHCZBStGbY
        vnB55BhprByWT3iP4eu0CmAiFtCN/lp87bz2mK9guVJOtgc9hnu2sYHcwNAZ4WsbTAyJd/
        zdDEWog0xUFFlufjr03uLUXTw6Ga+WzUFUP14i+5nMIvncUh1fjwGewpRLTHqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603733006;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0emFXgdDtDcQ3Ms+iXnK2/3c/PuQX4E6Kz9iVHVmi0=;
        b=RIQCL3sp3ofiB+2R2UjgaJPX0tgsmUBq9g4lwTjpEoHnI522UiKpGBk4PjArI1G/7Y1zVp
        rdHrwp0a4xE1VXDw==
From:   "tip-bot2 for Dan Williams" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86, libnvdimm/test: Remove COPY_MC_TEST
Cc:     Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C160316688322=2E3374697=2E8648308115165836243=2Es?=
 =?utf-8?q?tgit=40dwillia2-desk3=2Eamr=2Ecorp=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C160316688322=2E3374697=2E8648308115165836243=2Est?=
 =?utf-8?q?git=40dwillia2-desk3=2Eamr=2Ecorp=2Eintel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <160373300516.397.176216149235494763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     3adb776384f2042ef6bda876e91a7a7ac2872c5e
Gitweb:        https://git.kernel.org/tip/3adb776384f2042ef6bda876e91a7a7ac2872c5e
Author:        Dan Williams <dan.j.williams@intel.com>
AuthorDate:    Mon, 19 Oct 2020 21:08:03 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 26 Oct 2020 18:08:35 +01:00

x86, libnvdimm/test: Remove COPY_MC_TEST

The COPY_MC_TEST facility has served its purpose for validating the
early termination conditions of the copy_mc_fragile() implementation.
Remove it and the EXPORT_SYMBOL_GPL of copy_mc_fragile().

Reported-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/160316688322.3374697.8648308115165836243.stgit@dwillia2-desk3.amr.corp.intel.com
---
 arch/x86/Kconfig.debug              |   3 +-
 arch/x86/include/asm/copy_mc_test.h |  75 +--------------------
 arch/x86/lib/copy_mc.c              |   4 +-
 arch/x86/lib/copy_mc_64.S           |  10 +---
 tools/testing/nvdimm/test/nfit.c    | 103 +---------------------------
 5 files changed, 195 deletions(-)
 delete mode 100644 arch/x86/include/asm/copy_mc_test.h

diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
index 27b5e2b..80b57e7 100644
--- a/arch/x86/Kconfig.debug
+++ b/arch/x86/Kconfig.debug
@@ -62,9 +62,6 @@ config EARLY_PRINTK_USB_XDBC
 	  You should normally say N here, unless you want to debug early
 	  crashes or need a very simple printk logging facility.
 
-config COPY_MC_TEST
-	def_bool n
-
 config EFI_PGT_DUMP
 	bool "Dump the EFI pagetable"
 	depends on EFI
diff --git a/arch/x86/include/asm/copy_mc_test.h b/arch/x86/include/asm/copy_mc_test.h
deleted file mode 100644
index e4991ba..0000000
--- a/arch/x86/include/asm/copy_mc_test.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _COPY_MC_TEST_H_
-#define _COPY_MC_TEST_H_
-
-#ifndef __ASSEMBLY__
-#ifdef CONFIG_COPY_MC_TEST
-extern unsigned long copy_mc_test_src;
-extern unsigned long copy_mc_test_dst;
-
-static inline void copy_mc_inject_src(void *addr)
-{
-	if (addr)
-		copy_mc_test_src = (unsigned long) addr;
-	else
-		copy_mc_test_src = ~0UL;
-}
-
-static inline void copy_mc_inject_dst(void *addr)
-{
-	if (addr)
-		copy_mc_test_dst = (unsigned long) addr;
-	else
-		copy_mc_test_dst = ~0UL;
-}
-#else /* CONFIG_COPY_MC_TEST */
-static inline void copy_mc_inject_src(void *addr)
-{
-}
-
-static inline void copy_mc_inject_dst(void *addr)
-{
-}
-#endif /* CONFIG_COPY_MC_TEST */
-
-#else /* __ASSEMBLY__ */
-#include <asm/export.h>
-
-#ifdef CONFIG_COPY_MC_TEST
-.macro COPY_MC_TEST_CTL
-	.pushsection .data
-	.align 8
-	.globl copy_mc_test_src
-	copy_mc_test_src:
-		.quad 0
-	EXPORT_SYMBOL_GPL(copy_mc_test_src)
-	.globl copy_mc_test_dst
-	copy_mc_test_dst:
-		.quad 0
-	EXPORT_SYMBOL_GPL(copy_mc_test_dst)
-	.popsection
-.endm
-
-.macro COPY_MC_TEST_SRC reg count target
-	leaq \count(\reg), %r9
-	cmp copy_mc_test_src, %r9
-	ja \target
-.endm
-
-.macro COPY_MC_TEST_DST reg count target
-	leaq \count(\reg), %r9
-	cmp copy_mc_test_dst, %r9
-	ja \target
-.endm
-#else
-.macro COPY_MC_TEST_CTL
-.endm
-
-.macro COPY_MC_TEST_SRC reg count target
-.endm
-
-.macro COPY_MC_TEST_DST reg count target
-.endm
-#endif /* CONFIG_COPY_MC_TEST */
-#endif /* __ASSEMBLY__ */
-#endif /* _COPY_MC_TEST_H_ */
diff --git a/arch/x86/lib/copy_mc.c b/arch/x86/lib/copy_mc.c
index c13e8c9..80efd45 100644
--- a/arch/x86/lib/copy_mc.c
+++ b/arch/x86/lib/copy_mc.c
@@ -10,10 +10,6 @@
 #include <asm/mce.h>
 
 #ifdef CONFIG_X86_MCE
-/*
- * See COPY_MC_TEST for self-test of the copy_mc_fragile()
- * implementation.
- */
 static DEFINE_STATIC_KEY_FALSE(copy_mc_fragile_key);
 
 void enable_copy_mc_fragile(void)
diff --git a/arch/x86/lib/copy_mc_64.S b/arch/x86/lib/copy_mc_64.S
index 892d891..e5f77e2 100644
--- a/arch/x86/lib/copy_mc_64.S
+++ b/arch/x86/lib/copy_mc_64.S
@@ -2,14 +2,11 @@
 /* Copyright(c) 2016-2020 Intel Corporation. All rights reserved. */
 
 #include <linux/linkage.h>
-#include <asm/copy_mc_test.h>
-#include <asm/export.h>
 #include <asm/asm.h>
 
 #ifndef CONFIG_UML
 
 #ifdef CONFIG_X86_MCE
-COPY_MC_TEST_CTL
 
 /*
  * copy_mc_fragile - copy memory with indication if an exception / fault happened
@@ -38,8 +35,6 @@ SYM_FUNC_START(copy_mc_fragile)
 	subl %ecx, %edx
 .L_read_leading_bytes:
 	movb (%rsi), %al
-	COPY_MC_TEST_SRC %rsi 1 .E_leading_bytes
-	COPY_MC_TEST_DST %rdi 1 .E_leading_bytes
 .L_write_leading_bytes:
 	movb %al, (%rdi)
 	incq %rsi
@@ -55,8 +50,6 @@ SYM_FUNC_START(copy_mc_fragile)
 
 .L_read_words:
 	movq (%rsi), %r8
-	COPY_MC_TEST_SRC %rsi 8 .E_read_words
-	COPY_MC_TEST_DST %rdi 8 .E_write_words
 .L_write_words:
 	movq %r8, (%rdi)
 	addq $8, %rsi
@@ -73,8 +66,6 @@ SYM_FUNC_START(copy_mc_fragile)
 	movl %edx, %ecx
 .L_read_trailing_bytes:
 	movb (%rsi), %al
-	COPY_MC_TEST_SRC %rsi 1 .E_trailing_bytes
-	COPY_MC_TEST_DST %rdi 1 .E_trailing_bytes
 .L_write_trailing_bytes:
 	movb %al, (%rdi)
 	incq %rsi
@@ -88,7 +79,6 @@ SYM_FUNC_START(copy_mc_fragile)
 .L_done:
 	ret
 SYM_FUNC_END(copy_mc_fragile)
-EXPORT_SYMBOL_GPL(copy_mc_fragile)
 
 	.section .fixup, "ax"
 	/*
diff --git a/tools/testing/nvdimm/test/nfit.c b/tools/testing/nvdimm/test/nfit.c
index 2ac0fff..9b185bf 100644
--- a/tools/testing/nvdimm/test/nfit.c
+++ b/tools/testing/nvdimm/test/nfit.c
@@ -23,7 +23,6 @@
 #include "nfit_test.h"
 #include "../watermark.h"
 
-#include <asm/copy_mc_test.h>
 #include <asm/mce.h>
 
 /*
@@ -3284,107 +3283,6 @@ static struct platform_driver nfit_test_driver = {
 	.id_table = nfit_test_id,
 };
 
-static char copy_mc_buf[PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
-
-enum INJECT {
-	INJECT_NONE,
-	INJECT_SRC,
-	INJECT_DST,
-};
-
-static void copy_mc_test_init(char *dst, char *src, size_t size)
-{
-	size_t i;
-
-	memset(dst, 0xff, size);
-	for (i = 0; i < size; i++)
-		src[i] = (char) i;
-}
-
-static bool copy_mc_test_validate(unsigned char *dst, unsigned char *src,
-		size_t size, unsigned long rem)
-{
-	size_t i;
-
-	for (i = 0; i < size - rem; i++)
-		if (dst[i] != (unsigned char) i) {
-			pr_info_once("%s:%d: offset: %zd got: %#x expect: %#x\n",
-					__func__, __LINE__, i, dst[i],
-					(unsigned char) i);
-			return false;
-		}
-	for (i = size - rem; i < size; i++)
-		if (dst[i] != 0xffU) {
-			pr_info_once("%s:%d: offset: %zd got: %#x expect: 0xff\n",
-					__func__, __LINE__, i, dst[i]);
-			return false;
-		}
-	return true;
-}
-
-void copy_mc_test(void)
-{
-	char *inject_desc[] = { "none", "source", "destination" };
-	enum INJECT inj;
-
-	if (IS_ENABLED(CONFIG_COPY_MC_TEST)) {
-		pr_info("%s: run...\n", __func__);
-	} else {
-		pr_info("%s: disabled, skip.\n", __func__);
-		return;
-	}
-
-	for (inj = INJECT_NONE; inj <= INJECT_DST; inj++) {
-		int i;
-
-		pr_info("%s: inject: %s\n", __func__, inject_desc[inj]);
-		for (i = 0; i < 512; i++) {
-			unsigned long expect, rem;
-			void *src, *dst;
-			bool valid;
-
-			switch (inj) {
-			case INJECT_NONE:
-				copy_mc_inject_src(NULL);
-				copy_mc_inject_dst(NULL);
-				dst = &copy_mc_buf[2048];
-				src = &copy_mc_buf[1024 - i];
-				expect = 0;
-				break;
-			case INJECT_SRC:
-				copy_mc_inject_src(&copy_mc_buf[1024]);
-				copy_mc_inject_dst(NULL);
-				dst = &copy_mc_buf[2048];
-				src = &copy_mc_buf[1024 - i];
-				expect = 512 - i;
-				break;
-			case INJECT_DST:
-				copy_mc_inject_src(NULL);
-				copy_mc_inject_dst(&copy_mc_buf[2048]);
-				dst = &copy_mc_buf[2048 - i];
-				src = &copy_mc_buf[1024];
-				expect = 512 - i;
-				break;
-			}
-
-			copy_mc_test_init(dst, src, 512);
-			rem = copy_mc_fragile(dst, src, 512);
-			valid = copy_mc_test_validate(dst, src, 512, expect);
-			if (rem == expect && valid)
-				continue;
-			pr_info("%s: copy(%#lx, %#lx, %d) off: %d rem: %ld %s expect: %ld\n",
-					__func__,
-					((unsigned long) dst) & ~PAGE_MASK,
-					((unsigned long ) src) & ~PAGE_MASK,
-					512, i, rem, valid ? "valid" : "bad",
-					expect);
-		}
-	}
-
-	copy_mc_inject_src(NULL);
-	copy_mc_inject_dst(NULL);
-}
-
 static __init int nfit_test_init(void)
 {
 	int rc, i;
@@ -3393,7 +3291,6 @@ static __init int nfit_test_init(void)
 	libnvdimm_test();
 	acpi_nfit_test();
 	device_dax_test();
-	copy_mc_test();
 	dax_pmem_test();
 	dax_pmem_core_test();
 #ifdef CONFIG_DEV_DAX_PMEM_COMPAT
