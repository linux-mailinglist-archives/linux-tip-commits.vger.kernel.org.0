Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD032B6C7B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Nov 2020 19:04:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgKQSDK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Nov 2020 13:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728606AbgKQSDJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC1C4C0613CF;
        Tue, 17 Nov 2020 10:03:09 -0800 (PST)
Date:   Tue, 17 Nov 2020 18:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605636188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IF9Xl7DqWF2XkNwY3WpOHtA4a6/iAFJCq2G+lpH2cDo=;
        b=SmbW2pK3eukDYC0RGXT8u00jhw0VieZxj2g6/OR4zD7cJFEPgHYqAmOUm5oQ2ELhmpPWcL
        ewuq/1aWsbFaUgO0DtJyCcxUBwnTknYeu/gpxK+0gXjb4qRUzamYy1SsNVuh2fpnCiIXkj
        fIpgnYniHJgwriauVdzGw2yuKCiqTTpjKeVBVUCJgifb3DgHxiCd971tVwuRjmdmD+lqLJ
        QZBzF8KQW641tk73B7EHTLSNUUi7QrMp15UVuuwhyfiT0/SMIjG4KCS2FX3XHIdF01K4O7
        CcHgWcjFfA8LLJJ1HGdfHAlRSKGAbeH8rjiu3J/BOLYGyx11NeyL+RHelNR6mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605636188;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=IF9Xl7DqWF2XkNwY3WpOHtA4a6/iAFJCq2G+lpH2cDo=;
        b=KH8za0MapKhHcHdtx0Brb/Ler5hEGmmevVACZfGjpQrSj542YH6/m7y6o5rjhZTgxujEfC
        P+vvjz7Nvq69TGCw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: x86/xen: switch to efi_get_secureboot_mode helper
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160563618702.11244.379068919462473914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     b283477d394ac41ca59ee20eb9293ae9002eb1d7
Gitweb:        https://git.kernel.org/tip/b283477d394ac41ca59ee20eb9293ae9002eb1d7
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Tue, 03 Nov 2020 07:50:04 +01:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 17 Nov 2020 15:09:32 +01:00

efi: x86/xen: switch to efi_get_secureboot_mode helper

Now that we have a static inline helper to discover the platform's secure
boot mode that can be shared between the EFI stub and the kernel proper,
switch to it, and drop some comments about keeping them in sync manually.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/xen/efi.c                        | 37 +++++-----------------
 drivers/firmware/efi/libstub/secureboot.c |  3 +--
 2 files changed, 9 insertions(+), 31 deletions(-)

diff --git a/arch/x86/xen/efi.c b/arch/x86/xen/efi.c
index 205a9bc..7d7ffb9 100644
--- a/arch/x86/xen/efi.c
+++ b/arch/x86/xen/efi.c
@@ -93,37 +93,22 @@ static efi_system_table_t __init *xen_efi_probe(void)
 
 /*
  * Determine whether we're in secure boot mode.
- *
- * Please keep the logic in sync with
- * drivers/firmware/efi/libstub/secureboot.c:efi_get_secureboot().
  */
 static enum efi_secureboot_mode xen_efi_get_secureboot(void)
 {
-	static efi_guid_t efi_variable_guid = EFI_GLOBAL_VARIABLE_GUID;
 	static efi_guid_t shim_guid = EFI_SHIM_LOCK_GUID;
+	enum efi_secureboot_mode mode;
 	efi_status_t status;
-	u8 moksbstate, secboot, setupmode;
+	u8 moksbstate;
 	unsigned long size;
 
-	size = sizeof(secboot);
-	status = efi.get_variable(L"SecureBoot", &efi_variable_guid,
-				  NULL, &size, &secboot);
-
-	if (status == EFI_NOT_FOUND)
-		return efi_secureboot_mode_disabled;
-
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	size = sizeof(setupmode);
-	status = efi.get_variable(L"SetupMode", &efi_variable_guid,
-				  NULL, &size, &setupmode);
-
-	if (status != EFI_SUCCESS)
-		goto out_efi_err;
-
-	if (secboot == 0 || setupmode == 1)
-		return efi_secureboot_mode_disabled;
+	mode = efi_get_secureboot_mode(efi.get_variable);
+	if (mode == efi_secureboot_mode_unknown) {
+		pr_err("Could not determine UEFI Secure Boot status.\n");
+		return efi_secureboot_mode_unknown;
+	}
+	if (mode != efi_secureboot_mode_enabled)
+		return mode;
 
 	/* See if a user has put the shim into insecure mode. */
 	size = sizeof(moksbstate);
@@ -140,10 +125,6 @@ static enum efi_secureboot_mode xen_efi_get_secureboot(void)
  secure_boot_enabled:
 	pr_info("UEFI Secure Boot is enabled.\n");
 	return efi_secureboot_mode_enabled;
-
- out_efi_err:
-	pr_err("Could not determine UEFI Secure Boot status.\n");
-	return efi_secureboot_mode_unknown;
 }
 
 void __init xen_efi_init(struct boot_params *boot_params)
diff --git a/drivers/firmware/efi/libstub/secureboot.c b/drivers/firmware/efi/libstub/secureboot.c
index af18d86..8a18930 100644
--- a/drivers/firmware/efi/libstub/secureboot.c
+++ b/drivers/firmware/efi/libstub/secureboot.c
@@ -24,9 +24,6 @@ static efi_status_t get_var(efi_char16_t *name, efi_guid_t *vendor, u32 *attr,
 
 /*
  * Determine whether we're in secure boot mode.
- *
- * Please keep the logic in sync with
- * arch/x86/xen/efi.c:xen_efi_get_secureboot().
  */
 enum efi_secureboot_mode efi_get_secureboot(void)
 {
