Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE2127E02D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727787AbgI3FWe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53728 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725320AbgI3FWZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:25 -0400
Date:   Wed, 30 Sep 2020 05:22:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dPCQsuMsHBeuYgIQ/41ybBEWQ9ifLXlUlxN6trHNCTQ=;
        b=jJ5XPJ0slfeKHnZAuS0KH/hsJk8n8aAFvNV4e2jKUH7kyTETYN2Gy7sr4qMsuNXkPHPLIK
        CN3KwRFW0WoPpsYk7S6YejvuFbd0etAVtqLLqUa/9F8OziPzsZWIr9ihJ+CWLKe25RjBjI
        qqtEitmJMvuWV1F6dFvQQ10uduzkuC7gn2QQ23ieYIh+XoNOzrR3PIsVJwvBABvfMdpeMV
        34jGcGFBOwLCcxUQIm0A3pWbVkKpac+zEUu8hxHmInBklJB/QJsL0hH0UAJzD9gzXQl6aI
        mGU9WshHDXXDmdqCxnlGSxuU06ndGoebaDkhwirEJFWqv4vI0k8M6vQuzHcNnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443342;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=dPCQsuMsHBeuYgIQ/41ybBEWQ9ifLXlUlxN6trHNCTQ=;
        b=QvpmDdgwkY8Q1LBqvyCLmoQBaFetHwySXiqTtyomdDWBBrSPiuSoCQIfxyaZy7CZwSY4iQ
        OfCvGhGHDTJR8gBA==
From:   "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: pstore: disentangle from deprecated efivars module
Cc:     Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160144334169.7002.18043090415739220297.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     232f4eb6393f42f7f9418560ae9228e747fc6faf
Gitweb:        https://git.kernel.org/tip/232f4eb6393f42f7f9418560ae9228e747fc6faf
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 09:56:14 +02:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Tue, 29 Sep 2020 19:40:57 +02:00

efi: pstore: disentangle from deprecated efivars module

The EFI pstore implementation relies on the 'efivars' abstraction,
which encapsulates the EFI variable store in a way that can be
overridden by other backing stores, like the Google SMI one.

On top of that, the EFI pstore implementation also relies on the
efivars.ko module, which is a separate layer built on top of the
'efivars' abstraction that exposes the [deprecated] sysfs entries
for each variable that exists in the backing store.

Since the efivars.ko module is deprecated, and all users appear to
have moved to the efivarfs file system instead, let's prepare for
its removal, by removing EFI pstore's dependency on it.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/Kconfig      |  2 +-
 drivers/firmware/efi/efi-pstore.c | 76 ++++++++++++++++++++++++++++--
 drivers/firmware/efi/efivars.c    | 41 +----------------
 include/linux/efi.h               |  4 +--
 4 files changed, 74 insertions(+), 49 deletions(-)

diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index 3939699..dd8d108 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -26,7 +26,7 @@ config EFI_ESRT
 
 config EFI_VARS_PSTORE
 	tristate "Register efivars backend for pstore"
-	depends on EFI_VARS && PSTORE
+	depends on PSTORE
 	default y
 	help
 	  Say Y here to enable use efivars as a backend to pstore. This
diff --git a/drivers/firmware/efi/efi-pstore.c b/drivers/firmware/efi/efi-pstore.c
index feb7fe6..785f5e6 100644
--- a/drivers/firmware/efi/efi-pstore.c
+++ b/drivers/firmware/efi/efi-pstore.c
@@ -8,6 +8,8 @@
 
 #define DUMP_NAME_LEN 66
 
+#define EFIVARS_DATA_SIZE_MAX 1024
+
 static bool efivars_pstore_disable =
 	IS_ENABLED(CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE);
 
@@ -18,6 +20,8 @@ module_param_named(pstore_disable, efivars_pstore_disable, bool, 0644);
 	 EFI_VARIABLE_BOOTSERVICE_ACCESS | \
 	 EFI_VARIABLE_RUNTIME_ACCESS)
 
+static LIST_HEAD(efi_pstore_list);
+
 static int efi_pstore_open(struct pstore_info *psi)
 {
 	psi->data = NULL;
@@ -126,7 +130,7 @@ static inline int __efi_pstore_scan_sysfs_exit(struct efivar_entry *entry,
 	if (entry->deleting) {
 		list_del(&entry->list);
 		efivar_entry_iter_end();
-		efivar_unregister(entry);
+		kfree(entry);
 		if (efivar_entry_iter_begin())
 			return -EINTR;
 	} else if (turn_off_scanning)
@@ -169,7 +173,7 @@ static int efi_pstore_sysfs_entry_iter(struct pstore_record *record)
 {
 	struct efivar_entry **pos = (struct efivar_entry **)&record->psi->data;
 	struct efivar_entry *entry, *n;
-	struct list_head *head = &efivar_sysfs_list;
+	struct list_head *head = &efi_pstore_list;
 	int size = 0;
 	int ret;
 
@@ -314,12 +318,12 @@ static int efi_pstore_erase_name(const char *name)
 	if (efivar_entry_iter_begin())
 		return -EINTR;
 
-	found = __efivar_entry_iter(efi_pstore_erase_func, &efivar_sysfs_list,
+	found = __efivar_entry_iter(efi_pstore_erase_func, &efi_pstore_list,
 				    efi_name, &entry);
 	efivar_entry_iter_end();
 
 	if (found && !entry->scanning)
-		efivar_unregister(entry);
+		kfree(entry);
 
 	return found ? 0 : -ENOENT;
 }
@@ -354,14 +358,76 @@ static struct pstore_info efi_pstore_info = {
 	.erase		= efi_pstore_erase,
 };
 
+static int efi_pstore_callback(efi_char16_t *name, efi_guid_t vendor,
+			       unsigned long name_size, void *data)
+{
+	struct efivar_entry *entry;
+	int ret;
+
+	entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+	if (!entry)
+		return -ENOMEM;
+
+	memcpy(entry->var.VariableName, name, name_size);
+	entry->var.VendorGuid = vendor;
+
+	ret = efivar_entry_add(entry, &efi_pstore_list);
+	if (ret)
+		kfree(entry);
+
+	return ret;
+}
+
+static int efi_pstore_update_entry(efi_char16_t *name, efi_guid_t vendor,
+				   unsigned long name_size, void *data)
+{
+	struct efivar_entry *entry = data;
+
+	if (efivar_entry_find(name, vendor, &efi_pstore_list, false))
+		return 0;
+
+	memcpy(entry->var.VariableName, name, name_size);
+	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
+
+	return 1;
+}
+
+static void efi_pstore_update_entries(struct work_struct *work)
+{
+	struct efivar_entry *entry;
+	int err;
+
+	/* Add new sysfs entries */
+	while (1) {
+		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
+		if (!entry)
+			return;
+
+		err = efivar_init(efi_pstore_update_entry, entry,
+				  false, &efi_pstore_list);
+		if (!err)
+			break;
+
+		efivar_entry_add(entry, &efi_pstore_list);
+	}
+
+	kfree(entry);
+}
+
 static __init int efivars_pstore_init(void)
 {
+	int ret;
+
 	if (!efivars_kobject() || !efivar_supports_writes())
 		return 0;
 
 	if (efivars_pstore_disable)
 		return 0;
 
+	ret = efivar_init(efi_pstore_callback, NULL, true, &efi_pstore_list);
+	if (ret)
+		return ret;
+
 	efi_pstore_info.buf = kmalloc(4096, GFP_KERNEL);
 	if (!efi_pstore_info.buf)
 		return -ENOMEM;
@@ -374,6 +440,8 @@ static __init int efivars_pstore_init(void)
 		efi_pstore_info.bufsize = 0;
 	}
 
+	INIT_WORK(&efivar_work, efi_pstore_update_entries);
+
 	return 0;
 }
 
diff --git a/drivers/firmware/efi/efivars.c b/drivers/firmware/efi/efivars.c
index dcea137..f39321d 100644
--- a/drivers/firmware/efi/efivars.c
+++ b/drivers/firmware/efi/efivars.c
@@ -24,8 +24,7 @@ MODULE_LICENSE("GPL");
 MODULE_VERSION(EFIVARS_VERSION);
 MODULE_ALIAS("platform:efivars");
 
-LIST_HEAD(efivar_sysfs_list);
-EXPORT_SYMBOL_GPL(efivar_sysfs_list);
+static LIST_HEAD(efivar_sysfs_list);
 
 static struct kset *efivars_kset;
 
@@ -591,42 +590,6 @@ out_free:
 	return error;
 }
 
-static int efivar_update_sysfs_entry(efi_char16_t *name, efi_guid_t vendor,
-				     unsigned long name_size, void *data)
-{
-	struct efivar_entry *entry = data;
-
-	if (efivar_entry_find(name, vendor, &efivar_sysfs_list, false))
-		return 0;
-
-	memcpy(entry->var.VariableName, name, name_size);
-	memcpy(&(entry->var.VendorGuid), &vendor, sizeof(efi_guid_t));
-
-	return 1;
-}
-
-static void efivar_update_sysfs_entries(struct work_struct *work)
-{
-	struct efivar_entry *entry;
-	int err;
-
-	/* Add new sysfs entries */
-	while (1) {
-		entry = kzalloc(sizeof(*entry), GFP_KERNEL);
-		if (!entry)
-			return;
-
-		err = efivar_init(efivar_update_sysfs_entry, entry,
-				  false, &efivar_sysfs_list);
-		if (!err)
-			break;
-
-		efivar_create_sysfs_entry(entry);
-	}
-
-	kfree(entry);
-}
-
 static int efivars_sysfs_callback(efi_char16_t *name, efi_guid_t vendor,
 				  unsigned long name_size, void *data)
 {
@@ -701,8 +664,6 @@ int efivars_sysfs_init(void)
 		return error;
 	}
 
-	INIT_WORK(&efivar_work, efivar_update_sysfs_entries);
-
 	return 0;
 }
 EXPORT_SYMBOL_GPL(efivars_sysfs_init);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 4a2332f..7066c11 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -986,8 +986,6 @@ struct efivar_entry {
 	bool deleting;
 };
 
-extern struct list_head efivar_sysfs_list;
-
 static inline void
 efivar_unregister(struct efivar_entry *var)
 {
@@ -1045,8 +1043,6 @@ void efivar_run_worker(void);
 #if defined(CONFIG_EFI_VARS) || defined(CONFIG_EFI_VARS_MODULE)
 int efivars_sysfs_init(void);
 
-#define EFIVARS_DATA_SIZE_MAX 1024
-
 #endif /* CONFIG_EFI_VARS */
 extern bool efi_capsule_pending(int *reset_type);
 
