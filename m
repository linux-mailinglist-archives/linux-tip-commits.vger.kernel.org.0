Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98E9C8A3F0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 19:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726457AbfHLREZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 13:04:25 -0400
Received: from terminus.zytor.com ([198.137.202.136]:44155 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726334AbfHLREZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 13:04:25 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CH4CDf993686
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 10:04:12 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CH4CDf993686
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565629452;
        bh=qiqqkqRa9CnfcEbv8qVEU22fBAfhw9pXw+CwU1hjMS8=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=1mm+7FsMussrdL9jXtlUwzcpf8ME6FiHPmWJZgwqDl0f6OPHQV8hAqXqmxT229uoX
         DYg0zjAdM6gHRP4c/wdLrc9SYLv8mGQ3fSjYHfRca8Ajy83Do0jDVZrjJPj4dqZ+ut
         nYeNw5ipT2XlHPdQrvn0YpEJeUiXy3SFujRGVGXvpstXcKZk9k1XhG5rm3jiGkwrTY
         zX5iGgYCZYScXsXMvc+CNScs6AytBncuNFhoKXrif2Epjc0yuMzfgHetpEJLMFpA1J
         EHAayQUuJhH5wvBzTrlpBrPnC0QHLYRqtmnJjKHNm0EULeSJkOBWOTfVTVsJDVVaen
         NNBBKTNKfPDyg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CH4CbJ993683;
        Mon, 12 Aug 2019 10:04:12 -0700
Date:   Mon, 12 Aug 2019 10:04:12 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Ard Biesheuvel <tipbot@zytor.com>
Message-ID: <tip-e55f31a599478fb06a5a5d95e019e963322535cb@git.kernel.org>
Cc:     hpa@zytor.com, tglx@linutronix.de, ard.biesheuvel@linaro.org,
        mingo@kernel.org
Reply-To: linux-kernel@vger.kernel.org, hpa@zytor.com, tglx@linutronix.de,
          ard.biesheuvel@linaro.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: x86: move efi_is_table_address() into arch/x86
Git-Commit-ID: e55f31a599478fb06a5a5d95e019e963322535cb
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

Commit-ID:  e55f31a599478fb06a5a5d95e019e963322535cb
Gitweb:     https://git.kernel.org/tip/e55f31a599478fb06a5a5d95e019e963322535cb
Author:     Ard Biesheuvel <ard.biesheuvel@linaro.org>
AuthorDate: Tue, 25 Jun 2019 15:36:45 +0200
Committer:  Ard Biesheuvel <ard.biesheuvel@linaro.org>
CommitDate: Thu, 8 Aug 2019 11:01:48 +0300

efi: x86: move efi_is_table_address() into arch/x86

The function efi_is_table_address() and the associated array of table
pointers is specific to x86. Since we will be adding some more x86
specific tables, let's move this code out of the generic code first.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/efi.h  |  5 +++++
 arch/x86/mm/ioremap.c       |  1 +
 arch/x86/platform/efi/efi.c | 33 +++++++++++++++++++++++++++++++++
 drivers/firmware/efi/efi.c  | 33 ---------------------------------
 include/linux/efi.h         |  7 -------
 5 files changed, 39 insertions(+), 40 deletions(-)

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 606a4b6a9812..43a82e59c59d 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -242,6 +242,7 @@ static inline bool efi_is_64bit(void)
 		__efi_early()->runtime_services), __VA_ARGS__)
 
 extern bool efi_reboot_required(void);
+extern bool efi_is_table_address(unsigned long phys_addr);
 
 #else
 static inline void parse_efi_setup(u64 phys_addr, u32 data_len) {}
@@ -249,6 +250,10 @@ static inline bool efi_reboot_required(void)
 {
 	return false;
 }
+static inline  bool efi_is_table_address(unsigned long phys_addr)
+{
+	return false;
+}
 #endif /* CONFIG_EFI */
 
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 63e99f15d7cf..a39dcdb5ae34 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -19,6 +19,7 @@
 
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
+#include <asm/efi.h>
 #include <asm/fixmap.h>
 #include <asm/pgtable.h>
 #include <asm/tlbflush.h>
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index a7189a3b4d70..8d9be97a5607 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -64,6 +64,25 @@ static efi_config_table_type_t arch_tables[] __initdata = {
 	{NULL_GUID, NULL, NULL},
 };
 
+static const unsigned long * const efi_tables[] = {
+	&efi.mps,
+	&efi.acpi,
+	&efi.acpi20,
+	&efi.smbios,
+	&efi.smbios3,
+	&efi.sal_systab,
+	&efi.boot_info,
+	&efi.hcdp,
+	&efi.uga,
+	&efi.uv_systab,
+	&efi.fw_vendor,
+	&efi.runtime,
+	&efi.config_table,
+	&efi.esrt,
+	&efi.properties_table,
+	&efi.mem_attr_table,
+};
+
 u64 efi_setup;		/* efi setup_data physical address */
 
 static int add_efi_memmap __initdata;
@@ -1049,3 +1068,17 @@ static int __init arch_parse_efi_cmdline(char *str)
 	return 0;
 }
 early_param("efi", arch_parse_efi_cmdline);
+
+bool efi_is_table_address(unsigned long phys_addr)
+{
+	unsigned int i;
+
+	if (phys_addr == EFI_INVALID_TABLE_ADDR)
+		return false;
+
+	for (i = 0; i < ARRAY_SIZE(efi_tables); i++)
+		if (*(efi_tables[i]) == phys_addr)
+			return true;
+
+	return false;
+}
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index ad3b1f4866b3..cbdbdbc8f9eb 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -57,25 +57,6 @@ struct efi __read_mostly efi = {
 };
 EXPORT_SYMBOL(efi);
 
-static unsigned long *efi_tables[] = {
-	&efi.mps,
-	&efi.acpi,
-	&efi.acpi20,
-	&efi.smbios,
-	&efi.smbios3,
-	&efi.sal_systab,
-	&efi.boot_info,
-	&efi.hcdp,
-	&efi.uga,
-	&efi.uv_systab,
-	&efi.fw_vendor,
-	&efi.runtime,
-	&efi.config_table,
-	&efi.esrt,
-	&efi.properties_table,
-	&efi.mem_attr_table,
-};
-
 struct mm_struct efi_mm = {
 	.mm_rb			= RB_ROOT,
 	.mm_users		= ATOMIC_INIT(2),
@@ -964,20 +945,6 @@ int efi_status_to_err(efi_status_t status)
 	return err;
 }
 
-bool efi_is_table_address(unsigned long phys_addr)
-{
-	unsigned int i;
-
-	if (phys_addr == EFI_INVALID_TABLE_ADDR)
-		return false;
-
-	for (i = 0; i < ARRAY_SIZE(efi_tables); i++)
-		if (*(efi_tables[i]) == phys_addr)
-			return true;
-
-	return false;
-}
-
 static DEFINE_SPINLOCK(efi_mem_reserve_persistent_lock);
 static struct linux_efi_memreserve *efi_memreserve_root __ro_after_init;
 
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f87fabea4a85..60a6242765d8 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1211,8 +1211,6 @@ static inline bool efi_enabled(int feature)
 	return test_bit(feature, &efi.flags) != 0;
 }
 extern void efi_reboot(enum reboot_mode reboot_mode, const char *__unused);
-
-extern bool efi_is_table_address(unsigned long phys_addr);
 #else
 static inline bool efi_enabled(int feature)
 {
@@ -1226,11 +1224,6 @@ efi_capsule_pending(int *reset_type)
 {
 	return false;
 }
-
-static inline bool efi_is_table_address(unsigned long phys_addr)
-{
-	return false;
-}
 #endif
 
 extern int efi_status_to_err(efi_status_t status);
