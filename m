Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E26C12B6C7F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:04:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730287AbgKQSDN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730286AbgKQSDL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CC0C0613CF;
        Tue, 17 Nov 2020 10:03:10 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605636189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gAUdI08FG9y7TeYcYcanwAnLIyAkRP4lZNUNKJZseSM=;
        b=qV/xJRTLnNx/P6SLezrpHfwk4UNx0PymQ6ukWAjWoBR+BvcSHE54xAE8SENRpjEh1s8f+G
        MUGTkWFMx3SNSJE/6paaHpQu7Ait0Ir35BXnD+/RsN0FBChbLZir4fKNSqIyEZXJ7gc2WX
        ZCWzhzlPI8WCmduaJHYylJ+AYnLXv5SoE3ObYXfcIFqpNcIrzAxRFBjSpVsfa6tBIFcBob
        opA2lVVTb0XGOqMILV6RZAykaBSUTLuaiSxrWr323Sd32mdFPeRxLsiH1E+Oz7RyoOX5US
        vQnXkEi8jqr+zqj+Z/2YQbQj4dnxuU4wGGFiGltZnpW2An7KQT/f+SCn2KsFqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605636189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gAUdI08FG9y7TeYcYcanwAnLIyAkRP4lZNUNKJZseSM=;
        b=EJxbxRk0ZNvT6tnNk3Wqwp4QZloJOFcicLoYqeSTwnSzdFY84fVFYodOB3Py7gpr5Kx3b0
        +6Ve4iwvRo5fVjBw==
From:   "tip-bot2 for Chester Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] ima: generalize x86/EFI arch glue for other EFI architectures
Cc:     Chester Lin <clin@suse.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160563618835.11244.6772332423131200299.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     25519d68344269f9dc58b5bc72f648248a1fafb9
Gitweb:        https://git.kernel.org/tip/25519d68344269f9dc58b5bc72f648248a1fafb9
Author:        Chester Lin <clin@suse.com>
AuthorDate:    Fri, 30 Oct 2020 14:08:39 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Fri, 06 Nov 2020 07:40:42 +01:00

ima: generalize x86/EFI arch glue for other EFI architectures

Move the x86 IMA arch code into security/integrity/ima/ima_efi.c,
so that we will be able to wire it up for arm64 in a future patch.

Co-developed-by: Chester Lin <clin@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/include/asm/efi.h       |  3 +-
 arch/x86/kernel/Makefile         |  2 +-
 arch/x86/kernel/ima_arch.c       | 94 +-------------------------------
 security/integrity/ima/Makefile  |  4 +-
 security/integrity/ima/ima_efi.c | 73 ++++++++++++++++++++++++-
 5 files changed, 80 insertions(+), 96 deletions(-)
 delete mode 100644 arch/x86/kernel/ima_arch.c
 create mode 100644 security/integrity/ima/ima_efi.c

diff --git a/arch/x86/include/asm/efi.h b/arch/x86/include/asm/efi.h
index 7673dc8..c98f783 100644
--- a/arch/x86/include/asm/efi.h
+++ b/arch/x86/include/asm/efi.h
@@ -380,4 +380,7 @@ static inline void efi_fake_memmap_early(void)
 }
 #endif
 
+#define arch_ima_efi_boot_mode	\
+	({ extern struct boot_params boot_params; boot_params.secure_boot; })
+
 #endif /* _ASM_X86_EFI_H */
diff --git a/arch/x86/kernel/Makefile b/arch/x86/kernel/Makefile
index 68608bd..5eeb808 100644
--- a/arch/x86/kernel/Makefile
+++ b/arch/x86/kernel/Makefile
@@ -161,5 +161,3 @@ ifeq ($(CONFIG_X86_64),y)
 	obj-$(CONFIG_MMCONF_FAM10H)	+= mmconf-fam10h_64.o
 	obj-y				+= vsmp_64.o
 endif
-
-obj-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT)	+= ima_arch.o
diff --git a/arch/x86/kernel/ima_arch.c b/arch/x86/kernel/ima_arch.c
deleted file mode 100644
index 7dfb1e8..0000000
--- a/arch/x86/kernel/ima_arch.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0+ */
-/*
- * Copyright (C) 2018 IBM Corporation
- */
-#include <linux/efi.h>
-#include <linux/module.h>
-#include <linux/ima.h>
-
-extern struct boot_params boot_params;
-
-static enum efi_secureboot_mode get_sb_mode(void)
-{
-	efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
-	efi_status_t status;
-	unsigned long size;
-	u8 secboot, setupmode;
-
-	size = sizeof(secboot);
-
-	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
-		pr_info("ima: secureboot mode unknown, no efi\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	/* Get variable contents into buffer */
-	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
-				  NULL, &size, &secboot);
-	if (status == EFI_NOT_FOUND) {
-		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	if (status != EFI_SUCCESS) {
-		pr_info("ima: secureboot mode unknown\n");
-		return efi_secureboot_mode_unknown;
-	}
-
-	size = sizeof(setupmode);
-	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
-				  NULL, &size, &setupmode);
-
-	if (status != EFI_SUCCESS)	/* ignore unknown SetupMode */
-		setupmode = 0;
-
-	if (secboot == 0 || setupmode == 1) {
-		pr_info("ima: secureboot mode disabled\n");
-		return efi_secureboot_mode_disabled;
-	}
-
-	pr_info("ima: secureboot mode enabled\n");
-	return efi_secureboot_mode_enabled;
-}
-
-bool arch_ima_get_secureboot(void)
-{
-	static enum efi_secureboot_mode sb_mode;
-	static bool initialized;
-
-	if (!initialized && efi_enabled(EFI_BOOT)) {
-		sb_mode = boot_params.secure_boot;
-
-		if (sb_mode == efi_secureboot_mode_unset)
-			sb_mode = get_sb_mode();
-		initialized = true;
-	}
-
-	if (sb_mode == efi_secureboot_mode_enabled)
-		return true;
-	else
-		return false;
-}
-
-/* secureboot arch rules */
-static const char * const sb_arch_rules[] = {
-#if !IS_ENABLED(CONFIG_KEXEC_SIG)
-	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
-#endif /* CONFIG_KEXEC_SIG */
-	"measure func=KEXEC_KERNEL_CHECK",
-#if !IS_ENABLED(CONFIG_MODULE_SIG)
-	"appraise func=MODULE_CHECK appraise_type=imasig",
-#endif
-	"measure func=MODULE_CHECK",
-	NULL
-};
-
-const char * const *arch_get_ima_policy(void)
-{
-	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
-		if (IS_ENABLED(CONFIG_MODULE_SIG))
-			set_module_sig_enforced();
-		return sb_arch_rules;
-	}
-	return NULL;
-}
diff --git a/security/integrity/ima/Makefile b/security/integrity/ima/Makefile
index 67dabca..2499f24 100644
--- a/security/integrity/ima/Makefile
+++ b/security/integrity/ima/Makefile
@@ -14,3 +14,7 @@ ima-$(CONFIG_HAVE_IMA_KEXEC) += ima_kexec.o
 ima-$(CONFIG_IMA_BLACKLIST_KEYRING) += ima_mok.o
 ima-$(CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS) += ima_asymmetric_keys.o
 ima-$(CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS) += ima_queue_keys.o
+
+ifeq ($(CONFIG_EFI),y)
+ima-$(CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT) += ima_efi.o
+endif
diff --git a/security/integrity/ima/ima_efi.c b/security/integrity/ima/ima_efi.c
new file mode 100644
index 0000000..71786d0
--- /dev/null
+++ b/security/integrity/ima/ima_efi.c
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0+ */
+/*
+ * Copyright (C) 2018 IBM Corporation
+ */
+#include <linux/efi.h>
+#include <linux/module.h>
+#include <linux/ima.h>
+#include <asm/efi.h>
+
+#ifndef arch_ima_efi_boot_mode
+#define arch_ima_efi_boot_mode efi_secureboot_mode_unset
+#endif
+
+static enum efi_secureboot_mode get_sb_mode(void)
+{
+	enum efi_secureboot_mode mode;
+
+	if (!efi_rt_services_supported(EFI_RT_SUPPORTED_GET_VARIABLE)) {
+		pr_info("ima: secureboot mode unknown, no efi\n");
+		return efi_secureboot_mode_unknown;
+	}
+
+	mode = efi_get_secureboot_mode(efi.get_variable);
+	if (mode == efi_secureboot_mode_disabled)
+		pr_info("ima: secureboot mode disabled\n");
+	else if (mode == efi_secureboot_mode_unknown)
+		pr_info("ima: secureboot mode unknown\n");
+	else
+		pr_info("ima: secureboot mode enabled\n");
+	return mode;
+}
+
+bool arch_ima_get_secureboot(void)
+{
+	static enum efi_secureboot_mode sb_mode;
+	static bool initialized;
+
+	if (!initialized && efi_enabled(EFI_BOOT)) {
+		sb_mode = arch_ima_efi_boot_mode;
+
+		if (sb_mode == efi_secureboot_mode_unset)
+			sb_mode = get_sb_mode();
+		initialized = true;
+	}
+
+	if (sb_mode == efi_secureboot_mode_enabled)
+		return true;
+	else
+		return false;
+}
+
+/* secureboot arch rules */
+static const char * const sb_arch_rules[] = {
+#if !IS_ENABLED(CONFIG_KEXEC_SIG)
+	"appraise func=KEXEC_KERNEL_CHECK appraise_type=imasig",
+#endif /* CONFIG_KEXEC_SIG */
+	"measure func=KEXEC_KERNEL_CHECK",
+#if !IS_ENABLED(CONFIG_MODULE_SIG)
+	"appraise func=MODULE_CHECK appraise_type=imasig",
+#endif
+	"measure func=MODULE_CHECK",
+	NULL
+};
+
+const char * const *arch_get_ima_policy(void)
+{
+	if (IS_ENABLED(CONFIG_IMA_ARCH_POLICY) && arch_ima_get_secureboot()) {
+		if (IS_ENABLED(CONFIG_MODULE_SIG))
+			set_module_sig_enforced();
+		return sb_arch_rules;
+	}
+	return NULL;
+}
