Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C16F88A3F7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 19:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726822AbfHLRFr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 13:05:47 -0400
Received: from terminus.zytor.com ([198.137.202.136]:38183 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726679AbfHLRFr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 13:05:47 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CH5ere993849
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 10:05:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CH5ere993849
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565629541;
        bh=eV4xRwRpCH1dPaugtqq7Bgb3wB9SIFOY8+i+ds18LmE=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=A/YAXIE0go0bcy9PCHb0Aofa7HOAMfK+PCfhdziO1okxClCjhXhDbeRrdZrmMKxIv
         +Q6tDwIraM4mN6Lh19gZtvfxLg/N3xJ7IfS9HCkV013onKI16GriJTqWco5/O5Nwvo
         knvdPYE4qQRHchSKO2gw5SNakMDOFLI6h0Chag8SzgfAcsovwhq+1ESChFjfQzSCzX
         gsUus9f6ZrKZXBMIVdOv+2VNfDjh5q4v5Xc0NTkrcTyzepJeIWliJJJNsUSoVEIubk
         s1NgrI1j3c1lcL2pUJbK1gqhNyQhW5gsfAsCKWNZmH0BdKgNqDaGVpGgkxvegyEYcO
         s+0hgIb64MXJQ==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CH5efO993846;
        Mon, 12 Aug 2019 10:05:40 -0700
Date:   Mon, 12 Aug 2019 10:05:40 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-5828efb95bc43ad6a59f05458d3aed9649dd5a63@git.kernel.org>
Cc:     ard.biesheuvel@linaro.org, hpa@zytor.com, mingo@kernel.org,
        tglx@linutronix.de
Reply-To: hpa@zytor.com, tglx@linutronix.de, mingo@kernel.org,
          ard.biesheuvel@linaro.org, linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: ia64: move SAL systab handling out of generic
 EFI code
Git-Commit-ID: 5828efb95bc43ad6a59f05458d3aed9649dd5a63
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

Commit-ID:  5828efb95bc43ad6a59f05458d3aed9649dd5a63
Gitweb:     https://git.kernel.org/tip/5828efb95bc43ad6a59f05458d3aed9649dd5a63
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 25 Jun 2019 16:28:53 +0200
Committer:  Ard Biesheuvel <ard.biesheuvel@linaro.org>
CommitDate: Thu, 8 Aug 2019 11:01:48 +0300

efi: ia64: move SAL systab handling out of generic EFI code

The SAL systab is an Itanium specific EFI configuration table, so
move its handling into arch/ia64 where it belongs.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/ia64/include/asm/sal.h       | 1 +
 arch/ia64/include/asm/sn/sn_sal.h | 2 +-
 arch/ia64/kernel/efi.c            | 3 +++
 arch/ia64/kernel/setup.c          | 2 +-
 arch/x86/platform/efi/efi.c       | 1 -
 drivers/firmware/efi/efi.c        | 2 --
 include/linux/efi.h               | 1 -
 7 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/include/asm/sal.h b/arch/ia64/include/asm/sal.h
index 588f33156da6..08f5b6aaed73 100644
--- a/arch/ia64/include/asm/sal.h
+++ b/arch/ia64/include/asm/sal.h
@@ -43,6 +43,7 @@
 #include <asm/pal.h>
 #include <asm/fpu.h>
 
+extern unsigned long sal_systab_phys;
 extern spinlock_t sal_lock;
 
 /* SAL spec _requires_ eight args for each call. */
diff --git a/arch/ia64/include/asm/sn/sn_sal.h b/arch/ia64/include/asm/sn/sn_sal.h
index 1f5ff470a5a1..5142c444652d 100644
--- a/arch/ia64/include/asm/sn/sn_sal.h
+++ b/arch/ia64/include/asm/sn/sn_sal.h
@@ -167,7 +167,7 @@
 static inline u32
 sn_sal_rev(void)
 {
-	struct ia64_sal_systab *systab = __va(efi.sal_systab);
+	struct ia64_sal_systab *systab = __va(sal_systab_phys);
 
 	return (u32)(systab->sal_b_rev_major << 8 | systab->sal_b_rev_minor);
 }
diff --git a/arch/ia64/kernel/efi.c b/arch/ia64/kernel/efi.c
index 3795d18276c4..0a34dcc435c6 100644
--- a/arch/ia64/kernel/efi.c
+++ b/arch/ia64/kernel/efi.c
@@ -47,8 +47,11 @@
 
 static __initdata unsigned long palo_phys;
 
+unsigned long sal_systab_phys = EFI_INVALID_TABLE_ADDR;
+
 static __initdata efi_config_table_type_t arch_tables[] = {
 	{PROCESSOR_ABSTRACTION_LAYER_OVERWRITE_GUID, "PALO", &palo_phys},
+	{SAL_SYSTEM_TABLE_GUID, "SALsystab", &sal_systab_phys},
 	{NULL_GUID, NULL, 0},
 };
 
diff --git a/arch/ia64/kernel/setup.c b/arch/ia64/kernel/setup.c
index c9cfa760cd57..0e1b4eb149b4 100644
--- a/arch/ia64/kernel/setup.c
+++ b/arch/ia64/kernel/setup.c
@@ -572,7 +572,7 @@ setup_arch (char **cmdline_p)
 	find_memory();
 
 	/* process SAL system table: */
-	ia64_sal_init(__va(efi.sal_systab));
+	ia64_sal_init(__va(sal_systab_phys));
 
 #ifdef CONFIG_ITANIUM
 	ia64_patch_rse((u64) __start___rse_patchlist, (u64) __end___rse_patchlist);
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 9866a3584765..6697c109c449 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -70,7 +70,6 @@ static const unsigned long * const efi_tables[] = {
 	&efi.acpi20,
 	&efi.smbios,
 	&efi.smbios3,
-	&efi.sal_systab,
 	&efi.boot_info,
 	&efi.hcdp,
 	&efi.uga,
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 4dfd873373bd..801925c5bcfb 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -39,7 +39,6 @@ struct efi __read_mostly efi = {
 	.acpi20			= EFI_INVALID_TABLE_ADDR,
 	.smbios			= EFI_INVALID_TABLE_ADDR,
 	.smbios3		= EFI_INVALID_TABLE_ADDR,
-	.sal_systab		= EFI_INVALID_TABLE_ADDR,
 	.boot_info		= EFI_INVALID_TABLE_ADDR,
 	.hcdp			= EFI_INVALID_TABLE_ADDR,
 	.uga			= EFI_INVALID_TABLE_ADDR,
@@ -456,7 +455,6 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{ACPI_TABLE_GUID, "ACPI", &efi.acpi},
 	{HCDP_TABLE_GUID, "HCDP", &efi.hcdp},
 	{MPS_TABLE_GUID, "MPS", &efi.mps},
-	{SAL_SYSTEM_TABLE_GUID, "SALsystab", &efi.sal_systab},
 	{SMBIOS_TABLE_GUID, "SMBIOS", &efi.smbios},
 	{SMBIOS3_TABLE_GUID, "SMBIOS 3.0", &efi.smbios3},
 	{UGA_IO_PROTOCOL_GUID, "UGA", &efi.uga},
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 171bb1005a10..f88318b85fb0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -984,7 +984,6 @@ extern struct efi {
 	unsigned long acpi20;		/* ACPI table  (ACPI 2.0) */
 	unsigned long smbios;		/* SMBIOS table (32 bit entry point) */
 	unsigned long smbios3;		/* SMBIOS table (64 bit entry point) */
-	unsigned long sal_systab;	/* SAL system table */
 	unsigned long boot_info;	/* boot info table */
 	unsigned long hcdp;		/* HCDP table */
 	unsigned long uga;		/* UGA table */
