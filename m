Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB72D2DABEB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Dec 2020 12:28:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbgLOLRv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Dec 2020 06:17:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728571AbgLOLRo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Dec 2020 06:17:44 -0500
Date:   Tue, 15 Dec 2020 11:17:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1608031022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5coZMAK4+1PV+rG/fWhWtD4p9lMjlU4fLEKnmnMhejE=;
        b=SLfrZqBrtnwqa9lyeBtEmqOOHkW9ltuyWOvZtIZeVGCeg7hlSeIJviLZpTQFL20LYoWVYz
        3ztTdPCa9569m1XQvRsvCDJwvFHGINDeA4UuZXQ96rhLimu4ByXGrZ8qFMKLppl2lyQAWU
        ogS+/R9Bdfthw+FvtX5B59Fw6IowKwv4QTfsU0c70VOfu5MaHSMcuO15e3KHi2sftenqIz
        URMFr8lqLCotHFt/kCcr1plFy2fg8efbgQ3+iEzoLlDNp9QRMQUmzQydr+SJ6YY0+0JSpB
        wruO1dhQjtaeC/zOyNMpLCIbMKojiEWSul+2izXx7IWM5d3teCPcYM9zxUCiMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1608031022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5coZMAK4+1PV+rG/fWhWtD4p9lMjlU4fLEKnmnMhejE=;
        b=uwt7fDZv1MU+HaWZtaBqVCUkwi+4+S1OzuIKIW5J0C9nANqchebjEYNkZDNc0KKWeRXYsF
        7KiEbuouzpwYTXCQ==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: ia64: disable the capsule loader
Cc:     Tony Luck <tony.luck@intel.com>, Ard Biesheuvel <ardb@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201214152200.38353-1-ardb@kernel.org>
References: <20201214152200.38353-1-ardb@kernel.org>
MIME-Version: 1.0
Message-ID: <160803102166.3364.17797727743647853675.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     e0a6aa30504cb8179d07609fb6386705e8f00663
Gitweb:        https://git.kernel.org/tip/e0a6aa30504cb8179d07609fb6386705e8f00663
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sun, 13 Dec 2020 09:39:40 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Mon, 14 Dec 2020 16:24:19 +01:00

efi: ia64: disable the capsule loader

EFI capsule loading is a feature that was introduced into EFI long after
its initial introduction on Itanium, and it is highly unlikely that IA64
systems are receiving firmware updates in the first place, let alone
using EFI capsules.

So let's disable capsule support altogether on IA64. This fixes a build
error on IA64 due to a recent change that added an unconditional
include of asm/efi.h, which IA64 does not provide.

While at it, tweak the make rules a bit so that the EFI capsule
component that is always builtin (even if the EFI capsule loader itself
is built as a module) is omitted for all architectures if the module is
not enabled in the build.

Cc: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/linux-efi/20201214152200.38353-1-ardb@kernel.org
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig  |  2 +-
 drivers/firmware/efi/Makefile |  5 ++++-
 include/linux/efi.h           | 10 ++++------
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index b452cfa..5ac2a37 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -147,7 +147,7 @@ config EFI_BOOTLOADER_CONTROL
 
 config EFI_CAPSULE_LOADER
 	tristate "EFI capsule loader"
-	depends on EFI
+	depends on EFI && !IA64
 	help
 	  This option exposes a loader interface "/dev/efi_capsule_loader" for
 	  users to load EFI capsules. This driver requires working runtime
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index d6ca2da..467e942 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -12,7 +12,10 @@ KASAN_SANITIZE_runtime-wrappers.o	:= n
 
 obj-$(CONFIG_ACPI_BGRT) 		+= efi-bgrt.o
 obj-$(CONFIG_EFI)			+= efi.o vars.o reboot.o memattr.o tpm.o
-obj-$(CONFIG_EFI)			+= capsule.o memmap.o
+obj-$(CONFIG_EFI)			+= memmap.o
+ifneq ($(CONFIG_EFI_CAPSULE_LOADER),)
+obj-$(CONFIG_EFI)			+= capsule.o
+endif
 obj-$(CONFIG_EFI_PARAMS_FROM_FDT)	+= fdtparams.o
 obj-$(CONFIG_EFI_VARS)			+= efivars.o
 obj-$(CONFIG_EFI_ESRT)			+= esrt.o
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 1cd5d91..763b816 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -817,12 +817,6 @@ static inline bool efi_enabled(int feature)
 static inline void
 efi_reboot(enum reboot_mode reboot_mode, const char *__unused) {}
 
-static inline bool
-efi_capsule_pending(int *reset_type)
-{
-	return false;
-}
-
 static inline bool efi_soft_reserve_enabled(void)
 {
 	return false;
@@ -1038,6 +1032,7 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
+#if IS_ENABLED(CONFIG_EFI_CAPSULE_LOADER)
 extern bool efi_capsule_pending(int *reset_type);
 
 extern int efi_capsule_supported(efi_guid_t guid, u32 flags,
@@ -1045,6 +1040,9 @@ extern int efi_capsule_supported(efi_guid_t guid, u32 flags,
 
 extern int efi_capsule_update(efi_capsule_header_t *capsule,
 			      phys_addr_t *pages);
+#else
+static inline bool efi_capsule_pending(int *reset_type) { return false; }
+#endif
 
 #ifdef CONFIG_EFI_RUNTIME_MAP
 int efi_runtime_map_init(struct kobject *);
