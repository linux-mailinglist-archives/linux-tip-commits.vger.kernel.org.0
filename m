Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51D6A2B6C82
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:04:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730401AbgKQSDN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:03:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:49772 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgKQSDM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:12 -0500
Date:   Tue, 17 Nov 2020 18:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605636189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zu9/exQYH/ZcvQtbFPNF09u/MVBQckahb30jvyKD99g=;
        b=n1nRsWPDRIxYg/7/pp+CSKZEh9zDXrIWTDsaJW6hKSv+XH3KuxxNtcxdjlh2AptKAiL3+O
        x+h9b82VVPiK8oOWyHYhL43lxdnkY2KqdxnFJmg07Pyz/6zVeTKOEBS/KgS7W00EZtpJdV
        LUohZ3QVRLq2P7arzXt4/Jg1khSxUEE/lHRwG46XWPqzZZmC0u9J5UejdoU00C/toSZDUy
        F1Ew5YgW3TKPjucv2KUPh3c99f3RGeu2VRbNMxnqGlB64qZx+pzA5pshawtVoXqxxkvaY0
        sW8A0OrkPlZrXA5X4REddFq1zMlQa8NDfHUTIotbhHsKYj7Wat+cWAAgKv0zog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605636189;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=zu9/exQYH/ZcvQtbFPNF09u/MVBQckahb30jvyKD99g=;
        b=oaZMOWaIrkfLrS1EnUGAGEONQbvRFMZQ7Uww1osusZMUC2WBprkHc+KEToseBBSuinkKsH
        EwrfYaTTBDxYM2DQ==
From:   "tip-bot2 for Chester Lin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: generalize efi_get_secureboot
Cc:     Chester Lin <clin@suse.com>, Mimi Zohar <zohar@linux.ibm.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160563618897.11244.6024847866326161619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     e1ac4b2406d94eddce8ac2c5ab4235f6075a9602
Gitweb:        https://git.kernel.org/tip/e1ac4b2406d94eddce8ac2c5ab4235f6075a9602
Author:        Chester Lin <clin@suse.com>
AuthorDate:    Fri, 30 Oct 2020 14:08:38 +08:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 04 Nov 2020 23:05:40 +01:00

efi: generalize efi_get_secureboot

Generalize the efi_get_secureboot() function so not only efistub but also
other subsystems can use it.

Note that the MokSbState handling is not factored out: the variable is
boot time only, and so it cannot be parameterized as easily. Also, the
IMA code will switch to this version in a future patch, and it does not
incorporate the MokSbState exception in the first place.

Note that the new efi_get_secureboot_mode() helper treats any failures
to read SetupMode as setup mode being disabled.

Co-developed-by: Chester Lin <clin@suse.com>
Signed-off-by: Chester Lin <clin@suse.com>
Acked-by: Mimi Zohar <zohar@linux.ibm.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/boot/compressed/Makefile         |  2 +-
 drivers/firmware/efi/libstub/efistub.h    |  2 +-
 drivers/firmware/efi/libstub/secureboot.c | 41 ++++++++--------------
 include/linux/efi.h                       | 23 +++++++++++-
 4 files changed, 40 insertions(+), 28 deletions(-)

diff --git a/arch/x86/boot/compressed/Makefile b/arch/x86/boot/compressed/Makefile
index ee24908..8d358a6 100644
--- a/arch/x86/boot/compressed/Makefile
+++ b/arch/x86/boot/compressed/Makefile
@@ -35,7 +35,7 @@ cflags-$(CONFIG_X86_32) := -march=i386
 cflags-$(CONFIG_X86_64) := -mcmodel=small -mno-red-zone
 KBUILD_CFLAGS += $(cflags-y)
 KBUILD_CFLAGS += -mno-mmx -mno-sse
-KBUILD_CFLAGS += -ffreestanding
+KBUILD_CFLAGS += -ffreestanding -fshort-wchar
 KBUILD_CFLAGS += -fno-stack-protector
 KBUILD_CFLAGS += $(call cc-disable-warning, address-of-packed-member)
 KBUILD_CFLAGS += $(call cc-disable-warning, gnu)
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 2d7abcd..b8ec29d 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -848,4 +848,6 @@ asmlinkage void __noreturn efi_enter_kernel(unsigned long entrypoint,
 
 void efi_handle_post_ebs_state(void);
 
+enum efi_secureboot_mode efi_get_secureboot(void);
+
 #endif
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index 5efc524..af18d86 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -12,15 +12,16 @@
 
 #include "efistub.h"
 
-/* BIOS variables */
-static const efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
-static const efi_char16_t efi_SecureBoot_name[] = L"SecureBoot";
-static const efi_char16_t efi_SetupMode_name[] = L"SetupMode";
-
 /* SHIM variables */
 static const efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
 static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 
+static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
+			    unsigned long *data_size, void *data)
+{
+	return get_efi_var(name, vendor, attr, data_size, data);
+}
+
 /*
  * Determine whether we're in secure boot mode.
  *
@@ -30,26 +31,18 @@ static const efi_char16_t shim_MokSBState_name[] = L"MokSBState";
 enum efi_secureboot_mode efi_get_secureboot(void)
 {
 	u32 attr;
-	u8 secboot, setupmode, moksbstate;
 	unsigned long size;
+	enum efi_secureboot_mode mode;
 	efi_status_t status;
+	u8 moksbstate;
 
-	size = sizeof(secboot);
-	status = get_efi_var(efi_SecureBoot_name, &efi_variable_guid,
-			     NULL, &size, &secboot);
-	if (status == EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	size = sizeof(setupmode);
-	status = get_efi_var(efi_SetupMode_name, &efi_variable_guid,
-			     NULL, &size, &setupmode);
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	if (secboot == 0 || setupmode == 1)
-		return efi_secureboot_mode_disabled;
+	mode = efi_get_secureboot_mode(get_var);
+	if (mode == efi_secureboot_mode_unknown) {
+		efi_err("Could not determine UEFI Secure Boot status.\n");
+		return efi_secureboot_mode_unknown;
+	}
+	if (mode != efi_secureboot_mode_enabled)
+		return mode;
 
 	/*
 	 * See if a user has put the shim into insecure mode. If so, and if the
@@ -69,8 +62,4 @@ enum efi_secureboot_mode efi_get_secureboot(void)
 secure_boot_enabled:
 	efi_info("UEFI Secure Boot is enabled.\n");
 	return efi_secureboot_mode_enabled;
-
-out_efi_err:
-	efi_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
 }
diff --git a/include/linux/efi.h b/include/linux/efi.h
index d7c0e73..1cd5d91 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1089,7 +1089,28 @@ enum efi_secureboot_mode {
 	efi_secureboot_mode_disabled,
 	efi_secureboot_mode_enabled,
 };
-enum efi_secureboot_mode efi_get_secureboot(void);
+
+static inline
+enum efi_secureboot_mode efi_get_secureboot_mode(efi_get_variable_t *get_var)
+{
+	u8 secboot, setupmode = 0;
+	efi_status_t status;
+	unsigned long size;
+
+	size = sizeof(secboot);
+	status = get_var(L"SecureBoot", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size,
+			 &secboot);
+	if (status == EFI_NOT_FOUND)
+		return efi_secureboot_mode_disabled;
+	if (status != EFI_SUCCESS)
+		return efi_secureboot_mode_unknown;
+
+	size = sizeof(setupmode);
+	get_var(L"SetupMode", &EFI_GLOBAL_VARIABLE_GUID, NULL, &size, &setupmode);
+	if (secboot == 0 || setupmode == 1)
+		return efi_secureboot_mode_disabled;
+	return efi_secureboot_mode_enabled;
+}
 
 #ifdef CONFIG_RESET_ATTACK_MITIGATION
 void efi_enable_reset_attack_mitigation(void);
