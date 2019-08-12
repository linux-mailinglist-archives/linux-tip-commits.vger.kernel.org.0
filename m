Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43C68A3F6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 19:05:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbfHLRFD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 13:05:03 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38819 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHLRFD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 13:05:03 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CH4v4l993774
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 10:04:57 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CH4v4l993774
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565629497;
        bh=komMyQDolpbwxLYoW3jrMsLce9ShPDN5ORXHDhjO5gs=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=PS138w1iPmEyL7R6fMhgtzLyyLxrq/6NRsNRKZ+PtKcAcRYtJ5oOdnyxB6U7NIm7Q
         7v+WYTgFsJB/MriY8xrcXWGcoz6aegQclMW1V2CeGxBqSyp3CjRCeAcu4lqaDTHz/8
         iHVQCp2HI57ly3S5UYcH0Z3nvWDXjo3CqD3yTfVt073PFrEg8/Guox9j1BfOF98aw4
         vrJmxThYp16zoNA0iaMYxTVANBbdQ0bnEMolKCG+BGlxM1pv/RofM1J///TKIOBKUf
         njeCkXGshrotDnGkNxJMZzOjPLPfOB/c396SpT3j8HpebwwvDnZwiCVR7MAcl/LBKa
         yZmKGBw8nEEOg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CH4uNB993771;
        Mon, 12 Aug 2019 10:04:56 -0700
Date:   Mon, 12 Aug 2019 10:04:56 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-ec7e1605d79d1d469b25e396f2056e42386f512f@git.kernel.org>
Cc:     mingo@kernel.org, hpa@zytor.com, ard.biesheuvel@linaro.org,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org,
          linux-kernel@vger.kernel.org, ard.biesheuvel@linaro.org,
          hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi/x86: move UV_SYSTAB handling into arch/x86
Git-Commit-ID: ec7e1605d79d1d469b25e396f2056e42386f512f
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  ec7e1605d79d1d469b25e396f2056e42386f512f
Gitweb:     https://git.kernel.org/tip/ec7e1605d79d1d469b25e396f2056e42386f512f
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 25 Jun 2019 15:48:35 +0200
Committer:  Ard Biesheuvel <ard.biesheuvel@linaro.org>
CommitDate: Thu, 8 Aug 2019 11:01:48 +0300

efi/x86: move UV_SYSTAB handling into arch/x86

The SGI UV UEFI machines are tightly coupled to the x86 architecture
so there is no need to keep any awareness of its existence in the
generic EFI layer, especially since we already have the infrastructure
to handle arch-specific configuration tables, and were even already
using it to some extent.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/uv/uv.h   |  4 +++-
 arch/x86/platform/efi/efi.c    |  6 ++++--
 arch/x86/platform/uv/bios_uv.c | 10 ++++++----
 drivers/firmware/efi/efi.c     |  1 -
 include/linux/efi.h            |  1 -
 5 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/uv/uv.h b/arch/x86/include/asm/uv/uv.h
index e60c45fd3679..6bc6d89d8e2a 100644
--- a/arch/x86/include/asm/uv/uv.h
+++ b/arch/x86/include/asm/uv/uv.h
@@ -12,10 +12,12 @@ struct mm_struct;
 #ifdef CONFIG_X86_UV
 #include <linux/efi.h>
 
+extern unsigned long uv_systab_phys;
+
 extern enum uv_system_type get_uv_system_type(void);
 static inline bool is_early_uv_system(void)
 {
-	return !((efi.uv_systab == EFI_INVALID_TABLE_ADDR) || !efi.uv_systab);
+	return uv_systab_phys && uv_systab_phys != EFI_INVALID_TABLE_ADDR;
 }
 extern int is_uv_system(void);
 extern int is_uv_hubless(void);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 8d9be97a5607..9866a3584765 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -59,7 +59,7 @@ static efi_system_table_t efi_systab __initdata;
 
 static efi_config_table_type_t arch_tables[] __initdata = {
 #ifdef CONFIG_X86_UV
-	{UV_SYSTEM_TABLE_GUID, "UVsystab", &efi.uv_systab},
+	{UV_SYSTEM_TABLE_GUID, "UVsystab", &uv_systab_phys},
 #endif
 	{NULL_GUID, NULL, NULL},
 };
@@ -74,7 +74,9 @@ static const unsigned long * const efi_tables[] = {
 	&efi.boot_info,
 	&efi.hcdp,
 	&efi.uga,
-	&efi.uv_systab,
+#ifdef CONFIG_X86_UV
+	&uv_systab_phys,
+#endif
 	&efi.fw_vendor,
 	&efi.runtime,
 	&efi.config_table,
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 7c69652ffeea..c2ee31953372 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -14,6 +14,8 @@
 #include <asm/uv/bios.h>
 #include <asm/uv/uv_hub.h>
 
+unsigned long uv_systab_phys __ro_after_init = EFI_INVALID_TABLE_ADDR;
+
 struct uv_systab *uv_systab;
 
 static s64 __uv_bios_call(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
@@ -185,13 +187,13 @@ EXPORT_SYMBOL_GPL(uv_bios_set_legacy_vga_target);
 void uv_bios_init(void)
 {
 	uv_systab = NULL;
-	if ((efi.uv_systab == EFI_INVALID_TABLE_ADDR) ||
-	    !efi.uv_systab || efi_runtime_disabled()) {
+	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
+	    !uv_systab_phys || efi_runtime_disabled()) {
 		pr_crit("UV: UVsystab: missing\n");
 		return;
 	}
 
-	uv_systab = ioremap(efi.uv_systab, sizeof(struct uv_systab));
+	uv_systab = ioremap(uv_systab_phys, sizeof(struct uv_systab));
 	if (!uv_systab || strncmp(uv_systab->signature, UV_SYSTAB_SIG, 4)) {
 		pr_err("UV: UVsystab: bad signature!\n");
 		iounmap(uv_systab);
@@ -203,7 +205,7 @@ void uv_bios_init(void)
 		int size = uv_systab->size;
 
 		iounmap(uv_systab);
-		uv_systab = ioremap(efi.uv_systab, size);
+		uv_systab = ioremap(uv_systab_phys, size);
 		if (!uv_systab) {
 			pr_err("UV: UVsystab: ioremap(%d) failed!\n", size);
 			return;
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index cbdbdbc8f9eb..4dfd873373bd 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -43,7 +43,6 @@ struct efi __read_mostly efi = {
 	.boot_info		= EFI_INVALID_TABLE_ADDR,
 	.hcdp			= EFI_INVALID_TABLE_ADDR,
 	.uga			= EFI_INVALID_TABLE_ADDR,
-	.uv_systab		= EFI_INVALID_TABLE_ADDR,
 	.fw_vendor		= EFI_INVALID_TABLE_ADDR,
 	.runtime		= EFI_INVALID_TABLE_ADDR,
 	.config_table		= EFI_INVALID_TABLE_ADDR,
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 60a6242765d8..171bb1005a10 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -988,7 +988,6 @@ extern struct efi {
 	unsigned long boot_info;	/* boot info table */
 	unsigned long hcdp;		/* HCDP table */
 	unsigned long uga;		/* UGA table */
-	unsigned long uv_systab;	/* UV system table */
 	unsigned long fw_vendor;	/* fw_vendor */
 	unsigned long runtime;		/* runtime table */
 	unsigned long config_table;	/* config tables */
