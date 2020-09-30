Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CFB027E025
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbgI3FWX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53720 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbgI3FWX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:23 -0400
Date:   Wed, 30 Sep 2020 05:22:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iyWJg4Mz9uWVaNU8ubkZlVK1CO0nPKxKlTCf42bmovU=;
        b=wjHGnh+uHHHABpJy9MzhlzseVj0hKHMjp/0H6MU8aHozxtS8EYfmCAU6Fw33MWr1vFWX/d
        2Afg9KpanKOK2EL40gqgstfq1wxcaxE54VMuSsY5JouKbKpz/PcB/wMIqcsCGeIsUEogjB
        fPUvuMluiR94Pl1CbEHkeiULnF+arPWS4vLRbfqiTEIhQOD3yGhLrUAOl3FU5Jgh/Een++
        yEuE9iJBeIZPWneABARuaEjiyVrlSfP3IVkUT4+YINV40NsOKnOFQt6gunGR6czRX4igab
        KEeDI6kg2gmSew0mUvroyGdgHRz7FIaAAkHmJQhlhPc8HpWEBueo3dHJSR0VmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=iyWJg4Mz9uWVaNU8ubkZlVK1CO0nPKxKlTCf42bmovU=;
        b=KCj3A9nzgu1VvxoIWM6p2vEZO8AW0aAjXumlEdPDZYXv/qe/CnwXvZ6bxaOF6NgAGw9sze
        Bfiu5uCgjvTCFICA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: efivars: un-export efivars_sysfs_init()
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144334071.7002.5697117125830877495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     5d3c8617ccee6387ba73a5dba77fb9dc21cb85f4
Gitweb:        https://git.kernel.org/tip/5d3c8617ccee6387ba73a5dba77fb9dc21cb85f4
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 10:13:07 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 29 Sep 2020 19:40:57 +02:00

efi: efivars: un-export efivars_sysfs_init()

efivars_sysfs_init() is only used locally in the source file that
defines it, so make it static and unexport it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efivars.c | 3 +--
 include/linux/efi.h            | 4 ----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index f39321d..a76f50e 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -638,7 +638,7 @@ static void efivars_sysfs_exit(void)
 	kset_unregister(efivars_kset);
 }
 
-int efivars_sysfs_init(void)
+static int efivars_sysfs_init(void)
 {
 	struct kobject *parent_kobj = efivars_kobject();
 	int error = 0;
@@ -666,7 +666,6 @@ int efivars_sysfs_init(void)
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(efivars_sysfs_init);
 
 module_init(efivars_sysfs_init);
 module_exit(efivars_sysfs_exit);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index ab8c803..4c8dae0 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1037,10 +1037,6 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
-#if defined(CONFIG_EFI_VARS) || defined(CONFIG_EFI_VARS_MODULE)
-int efivars_sysfs_init(void);
-
-#endif /* CONFIG_EFI_VARS */
 extern bool efi_capsule_pending(int *reset_type);
 
 extern int efi_capsule_supported(efi_guid_t guid, u32 flags,
