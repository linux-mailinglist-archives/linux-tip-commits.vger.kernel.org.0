Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 697A927E035
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:23:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728074AbgI3FWv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53724 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbgI3FWY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:24 -0400
Date:   Wed, 30 Sep 2020 05:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3F1ZpbTBAc7vdngHubC+l5SIzj5EFU9qdDdojF2nKJs=;
        b=uLRMuqbV9Hx+hGH07xvl54a8ZtFdXanyOBD02xKnimOsKlevE+JwAUukwczNLLsA6QjehN
        HgdCSAXCLy6rBl6SwQP9Yr3o5j3Ozigpi/UDGxyimUjVprWfq2fsjd80IQ19Vk4KE7RAQv
        NtCCluO1ph3uifusB9AE9crf6Gi0TKZENQAGyTNeH8/HNn4Ti1z7GUaGqf4tFWUv6JCilT
        4Bc2B8r7nui1NpiN7Y2zXCMsV21N/jtWM0OcMf29HVv9/NtGDwMXNR1GRsFfIxzL6+R1e/
        p88acFdcfK+caS56XKabkiK250sWAllQDy8XwIWFtZSe0Jm2hNqUfKuJEZSxqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443341;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=3F1ZpbTBAc7vdngHubC+l5SIzj5EFU9qdDdojF2nKJs=;
        b=VzzfyE5ju1gYbkPJcdqHXnlgfZULdf+NJcQejASsAIzQCLfXvYFxYNf/NEje7hzOJt1sAt
        +zRZGXg6ZWXlmyAw==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: pstore: move workqueue handling out of efivars
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144334116.7002.274752693055027947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     c9b51a2dbfe7f47643e133bf48e1bf28f1b85d2a
Gitweb:        https://git.kernel.org/tip/c9b51a2dbfe7f47643e133bf48e1bf28f1b85d2a
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 10:07:49 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 29 Sep 2020 19:40:57 +02:00

efi: pstore: move workqueue handling out of efivars

The worker thread that gets kicked off to sync the state of the
EFI variable list is only used by the EFI pstore implementation,
and is defined in its source file. So let's move its scheduling
there as well. Since our efivar_init() scan will bail on duplicate
entries, there is no need to disable the workqueue like we did
before, so we can run it unconditionally.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/efi-pstore.c |  7 +++++--
 drivers/firmware/efi/vars.c       | 21 ---------------------
 include/linux/efi.h               |  3 ---
 3 files changed, 5 insertions(+), 26 deletions(-)

diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index 785f5e6..0ef086e 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -21,6 +21,7 @@ module_param_named(pstore_disable, efivars_pstore_disable, bool, 0644);
 	 EFI_VARIABLE_RUNTIME_ACCESS)
 
 static LIST_HEAD(efi_pstore_list);
+static DECLARE_WORK(efivar_work, NULL);
 
 static int efi_pstore_open(struct pstore_info *psi)
 {
@@ -267,8 +268,9 @@ static int efi_pstore_write(struct pstore_record *record)
 	ret = efivar_entry_set_safe(efi_name, vendor, PSTORE_EFI_ATTRIBUTES,
 			      preemptible(), record->size, record->psi->buf);
 
-	if (record->reason == KMSG_DUMP_OOPS)
-		efivar_run_worker();
+	if (record->reason == KMSG_DUMP_OOPS && try_module_get(THIS_MODULE))
+		if (!schedule_work(&efivar_work))
+			module_put(THIS_MODULE);
 
 	return ret;
 };
@@ -412,6 +414,7 @@ static void efi_pstore_update_entries(struct work_struct *work)
 	}
 
 	kfree(entry);
+	module_put(THIS_MODULE);
 }
 
 static __init int efivars_pstore_init(void)
diff --git a/drivers/firmware/efi/vars.c b/drivers/firmware/efi/vars.c
index 973eef2..ffb12f6 100644
--- a/drivers/firmware/efi/vars.c
+++ b/drivers/firmware/efi/vars.c
@@ -32,10 +32,6 @@ static struct efivars *__efivars;
  */
 static DEFINE_SEMAPHORE(efivars_lock);
 
-static bool efivar_wq_enabled = true;
-DECLARE_WORK(efivar_work, NULL);
-EXPORT_SYMBOL_GPL(efivar_work);
-
 static bool
 validate_device_path(efi_char16_t *var_name, int match, u8 *buffer,
 		     unsigned long len)
@@ -391,13 +387,6 @@ static void dup_variable_bug(efi_char16_t *str16, efi_guid_t *vendor_guid,
 	size_t i, len8 = len16 / sizeof(efi_char16_t);
 	char *str8;
 
-	/*
-	 * Disable the workqueue since the algorithm it uses for
-	 * detecting new variables won't work with this buggy
-	 * implementation of GetNextVariableName().
-	 */
-	efivar_wq_enabled = false;
-
 	str8 = kzalloc(len8, GFP_KERNEL);
 	if (!str8)
 		return;
@@ -1158,16 +1147,6 @@ struct kobject *efivars_kobject(void)
 EXPORT_SYMBOL_GPL(efivars_kobject);
 
 /**
- * efivar_run_worker - schedule the efivar worker thread
- */
-void efivar_run_worker(void)
-{
-	if (efivar_wq_enabled)
-		schedule_work(&efivar_work);
-}
-EXPORT_SYMBOL_GPL(efivar_run_worker);
-
-/**
  * efivars_register - register an efivars
  * @efivars: efivars to register
  * @ops: efivars operations
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 7066c11..ab8c803 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -1037,9 +1037,6 @@ bool efivar_validate(efi_guid_t vendor, efi_char16_t *var_name, u8 *data,
 bool efivar_variable_is_removable(efi_guid_t vendor, const char *name,
 				  size_t len);
 
-extern struct work_struct efivar_work;
-void efivar_run_worker(void);
-
 #if defined(CONFIG_EFI_VARS) || defined(CONFIG_EFI_VARS_MODULE)
 int efivars_sysfs_init(void);
 
