Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 755A026F85E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Sep 2020 10:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726743AbgIRIcD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 18 Sep 2020 04:32:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726452AbgIRIa5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 18 Sep 2020 04:30:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C20C061788;
        Fri, 18 Sep 2020 01:30:57 -0700 (PDT)
Date:   Fri, 18 Sep 2020 08:30:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600417855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlAtRB4/hUhT3HPYhpFboLPxYhWVHH7wEH1c1XH0Ay0=;
        b=HXJj1o91Dii/BwS67bxR6QeeEUlBoaQQramq9jQkRxTwX4AGdo0zyz9erMk/Ex60cw4dXD
        oKVM2xH7yZ9T/FQwEaHYRJU8p8t0hsLTDyPQkqsrGOfGs2TeTVOY6nnXddLF49yNPrmokX
        PR/gVm4QcBEZfVNsLUGeVDb8KIICmM7J88qYhTlv3Nw3u03o4sICz8Tke20dyDPEn+7Qoy
        LohAKrT5OR/0qF+B7jTmk7Nf/8Khxps2ND0EZAA7n9iXiluKZsVOdO2kLpOaO7xP7IkBbb
        i5ALd3DscJk27LcM8BS1IJOBdzOBC7/EzwvOj+K4DkPKnS8/XUlEbfM37aWLyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600417855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SlAtRB4/hUhT3HPYhpFboLPxYhWVHH7wEH1c1XH0Ay0=;
        b=y6LuVReEHuHk55A2tr6oMkfJAsQtCRh5YjMYT0vMu4B6aIG9RYZOvPvDC0OFQcBnluFGyo
        fJVmLht3UgMtq8Aw==
From:   "tip-bot2 for Lenny Szubowicz" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi: Support for MOK variable config table
Cc:     Lenny Szubowicz <lszubowi@redhat.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200905013107.10457-2-lszubowi@redhat.com>
References: <20200905013107.10457-2-lszubowi@redhat.com>
MIME-Version: 1.0
Message-ID: <160041785494.15536.5659054027150173595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     58c909022a5a56cd1d9e89c8c5461fd1f6a27bb5
Gitweb:        https://git.kernel.org/tip/58c909022a5a56cd1d9e89c8c5461fd1f6a27bb5
Author:        Lenny Szubowicz <lszubowi@redhat.com>
AuthorDate:    Fri, 04 Sep 2020 21:31:05 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Wed, 16 Sep 2020 18:53:42 +03:00

efi: Support for MOK variable config table

Because of system-specific EFI firmware limitations, EFI volatile
variables may not be capable of holding the required contents of
the Machine Owner Key (MOK) certificate store when the certificate
list grows above some size. Therefore, an EFI boot loader may pass
the MOK certs via a EFI configuration table created specifically for
this purpose to avoid this firmware limitation.

An EFI configuration table is a much more primitive mechanism
compared to EFI variables and is well suited for one-way passage
of static information from a pre-OS environment to the kernel.

This patch adds initial kernel support to recognize, parse,
and validate the EFI MOK configuration table, where named
entries contain the same data that would otherwise be provided
in similarly named EFI variables.

Additionally, this patch creates a sysfs binary file for each
EFI MOK configuration table entry found. These files are read-only
to root and are provided for use by user space utilities such as
mokutil.

A subsequent patch will load MOK certs into the trusted platform
key ring using this infrastructure.

Signed-off-by: Lenny Szubowicz <lszubowi@redhat.com>
Link: https://lore.kernel.org/r/20200905013107.10457-2-lszubowi@redhat.com
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 arch/x86/kernel/setup.c             |   1 +-
 arch/x86/platform/efi/efi.c         |   3 +-
 drivers/firmware/efi/Makefile       |   1 +-
 drivers/firmware/efi/efi-init.c     |   1 +-
 drivers/firmware/efi/efi.c          |   6 +-
 drivers/firmware/efi/mokvar-table.c | 360 +++++++++++++++++++++++++++-
 include/linux/efi.h                 |  34 +++-
 7 files changed, 406 insertions(+)
 create mode 100644 drivers/firmware/efi/mokvar-table.c

diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 3511736..d41be0d 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1077,6 +1077,7 @@ void __init setup_arch(char **cmdline_p)
 	efi_fake_memmap();
 	efi_find_mirror();
 	efi_esrt_init();
+	efi_mokvar_table_init();
 
 	/*
 	 * The EFI specification says that boot service code won't be
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index f6ea8f1..6961bed 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -91,6 +91,9 @@ static const unsigned long * const efi_tables[] = {
 	&efi.tpm_log,
 	&efi.tpm_final_log,
 	&efi_rng_seed,
+#ifdef CONFIG_LOAD_UEFI_KEYS
+	&efi.mokvar_table,
+#endif
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index 61fd1e8..e8da782 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -28,6 +28,7 @@ obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
 obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 obj-$(CONFIG_EFI_EMBEDDED_FIRMWARE)	+= embedded-firmware.o
+obj-$(CONFIG_LOAD_UEFI_KEYS)		+= mokvar-table.o
 
 fake_map-y				+= fake_mem.o
 fake_map-$(CONFIG_X86)			+= x86_fake_mem.o
diff --git a/drivers/firmware/efi/efi-init.c b/drivers/firmware/efi/efi-init.c
index 71c445d..f55a92f 100644
--- a/drivers/firmware/efi/efi-init.c
+++ b/drivers/firmware/efi/efi-init.c
@@ -236,6 +236,7 @@ void __init efi_init(void)
 
 	reserve_regions();
 	efi_esrt_init();
+	efi_mokvar_table_init();
 
 	memblock_reserve(data.phys_map & PAGE_MASK,
 			 PAGE_ALIGN(data.size + (data.phys_map & ~PAGE_MASK)));
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index fdd1db0..820f5b1 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -43,6 +43,9 @@ struct efi __read_mostly efi = {
 	.esrt			= EFI_INVALID_TABLE_ADDR,
 	.tpm_log		= EFI_INVALID_TABLE_ADDR,
 	.tpm_final_log		= EFI_INVALID_TABLE_ADDR,
+#ifdef CONFIG_LOAD_UEFI_KEYS
+	.mokvar_table		= EFI_INVALID_TABLE_ADDR,
+#endif
 };
 EXPORT_SYMBOL(efi);
 
@@ -517,6 +520,9 @@ static const efi_config_table_type_t common_tables[] __initconst = {
 #ifdef CONFIG_EFI_RCI2_TABLE
 	{DELLEMC_EFI_RCI2_TABLE_GUID,		&rci2_table_phys			},
 #endif
+#ifdef CONFIG_LOAD_UEFI_KEYS
+	{LINUX_EFI_MOK_VARIABLE_TABLE_GUID,	&efi.mokvar_table,	"MOKvar"	},
+#endif
 	{},
 };
 
diff --git a/drivers/firmware/efi/mokvar-table.c b/drivers/firmware/efi/mokvar-table.c
new file mode 100644
index 0000000..b1cd498
--- /dev/null
+++ b/drivers/firmware/efi/mokvar-table.c
@@ -0,0 +1,360 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * mokvar-table.c
+ *
+ * Copyright (c) 2020 Red Hat
+ * Author: Lenny Szubowicz <lszubowi@redhat.com>
+ *
+ * This module contains the kernel support for the Linux EFI Machine
+ * Owner Key (MOK) variable configuration table, which is identified by
+ * the LINUX_EFI_MOK_VARIABLE_TABLE_GUID.
+ *
+ * This EFI configuration table provides a more robust alternative to
+ * EFI volatile variables by which an EFI boot loader can pass the
+ * contents of the Machine Owner Key (MOK) certificate stores to the
+ * kernel during boot. If both the EFI MOK config table and corresponding
+ * EFI MOK variables are present, the table should be considered as
+ * more authoritative.
+ *
+ * This module includes code that validates and maps the EFI MOK table,
+ * if it's presence was detected very early in boot.
+ *
+ * Kernel interface routines are provided to walk through all the
+ * entries in the MOK config table or to search for a specific named
+ * entry.
+ *
+ * The contents of the individual named MOK config table entries are
+ * made available to user space via read-only sysfs binary files under:
+ *
+ * /sys/firmware/efi/mok-variables/
+ *
+ */
+#define pr_fmt(fmt) "mokvar: " fmt
+
+#include <linux/capability.h>
+#include <linux/efi.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/kobject.h>
+#include <linux/list.h>
+#include <linux/slab.h>
+
+/*
+ * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table is a packed
+ * sequence of struct efi_mokvar_table_entry, one for each named
+ * MOK variable. The sequence is terminated by an entry with a
+ * completely NULL name and 0 data size.
+ *
+ * efi_mokvar_table_size is set to the computed size of the
+ * MOK config table by efi_mokvar_table_init(). This will be
+ * non-zero if and only if the table if present and has been
+ * validated by efi_mokvar_table_init().
+ */
+static size_t efi_mokvar_table_size;
+
+/*
+ * efi_mokvar_table_va is the kernel virtual address at which the
+ * EFI MOK config table has been mapped by efi_mokvar_sysfs_init().
+ */
+static struct efi_mokvar_table_entry *efi_mokvar_table_va;
+
+/*
+ * Each /sys/firmware/efi/mok-variables/ sysfs file is represented by
+ * an instance of struct efi_mokvar_sysfs_attr on efi_mokvar_sysfs_list.
+ * bin_attr.private points to the associated EFI MOK config table entry.
+ *
+ * This list is created during boot and then remains unchanged.
+ * So no synchronization is currently required to walk the list.
+ */
+struct efi_mokvar_sysfs_attr {
+	struct bin_attribute bin_attr;
+	struct list_head node;
+};
+
+static LIST_HEAD(efi_mokvar_sysfs_list);
+static struct kobject *mokvar_kobj;
+
+/*
+ * efi_mokvar_table_init() - Early boot validation of EFI MOK config table
+ *
+ * If present, validate and compute the size of the EFI MOK variable
+ * configuration table. This table may be provided by an EFI boot loader
+ * as an alternative to ordinary EFI variables, due to platform-dependent
+ * limitations. The memory occupied by this table is marked as reserved.
+ *
+ * This routine must be called before efi_free_boot_services() in order
+ * to guarantee that it can mark the table as reserved.
+ *
+ * Implicit inputs:
+ * efi.mokvar_table:	Physical address of EFI MOK variable config table
+ *			or special value that indicates no such table.
+ *
+ * Implicit outputs:
+ * efi_mokvar_table_size: Computed size of EFI MOK variable config table.
+ *			The table is considered present and valid if this
+ *			is non-zero.
+ */
+void __init efi_mokvar_table_init(void)
+{
+	efi_memory_desc_t md;
+	u64 end_pa;
+	void *va = NULL;
+	size_t cur_offset = 0;
+	size_t offset_limit;
+	size_t map_size = 0;
+	size_t map_size_needed = 0;
+	size_t size;
+	struct efi_mokvar_table_entry *mokvar_entry;
+	int err = -EINVAL;
+
+	if (!efi_enabled(EFI_MEMMAP))
+		return;
+
+	if (efi.mokvar_table == EFI_INVALID_TABLE_ADDR)
+		return;
+	/*
+	 * The EFI MOK config table must fit within a single EFI memory
+	 * descriptor range.
+	 */
+	err = efi_mem_desc_lookup(efi.mokvar_table, &md);
+	if (err) {
+		pr_warn("EFI MOKvar config table is not within the EFI memory map\n");
+		return;
+	}
+	end_pa = efi_mem_desc_end(&md);
+	if (efi.mokvar_table >= end_pa) {
+		pr_err("EFI memory descriptor containing MOKvar config table is invalid\n");
+		return;
+	}
+	offset_limit = end_pa - efi.mokvar_table;
+	/*
+	 * Validate the MOK config table. Since there is no table header
+	 * from which we could get the total size of the MOK config table,
+	 * we compute the total size as we validate each variably sized
+	 * entry, remapping as necessary.
+	 */
+	while (cur_offset + sizeof(*mokvar_entry) <= offset_limit) {
+		mokvar_entry = va + cur_offset;
+		map_size_needed = cur_offset + sizeof(*mokvar_entry);
+		if (map_size_needed > map_size) {
+			if (va)
+				early_memunmap(va, map_size);
+			/*
+			 * Map a little more than the fixed size entry
+			 * header, anticipating some data. It's safe to
+			 * do so as long as we stay within current memory
+			 * descriptor.
+			 */
+			map_size = min(map_size_needed + 2*EFI_PAGE_SIZE,
+				       offset_limit);
+			va = early_memremap(efi.mokvar_table, map_size);
+			if (!va) {
+				pr_err("Failed to map EFI MOKvar config table pa=0x%lx, size=%zu.\n",
+				       efi.mokvar_table, map_size);
+				return;
+			}
+			mokvar_entry = va + cur_offset;
+		}
+
+		/* Check for last sentinel entry */
+		if (mokvar_entry->name[0] == '\0') {
+			if (mokvar_entry->data_size != 0)
+				break;
+			err = 0;
+			break;
+		}
+
+		/* Sanity check that the name is null terminated */
+		size = strnlen(mokvar_entry->name,
+			       sizeof(mokvar_entry->name));
+		if (size >= sizeof(mokvar_entry->name))
+			break;
+
+		/* Advance to the next entry */
+		cur_offset = map_size_needed + mokvar_entry->data_size;
+	}
+
+	if (va)
+		early_memunmap(va, map_size);
+	if (err) {
+		pr_err("EFI MOKvar config table is not valid\n");
+		return;
+	}
+	efi_mem_reserve(efi.mokvar_table, map_size_needed);
+	efi_mokvar_table_size = map_size_needed;
+}
+
+/*
+ * efi_mokvar_entry_next() - Get next entry in the EFI MOK config table
+ *
+ * mokvar_entry:	Pointer to current EFI MOK config table entry
+ *			or null. Null indicates get first entry.
+ *			Passed by reference. This is updated to the
+ *			same value as the return value.
+ *
+ * Returns:		Pointer to next EFI MOK config table entry
+ *			or null, if there are no more entries.
+ *			Same value is returned in the mokvar_entry
+ *			parameter.
+ *
+ * This routine depends on the EFI MOK config table being entirely
+ * mapped with it's starting virtual address in efi_mokvar_table_va.
+ */
+struct efi_mokvar_table_entry *efi_mokvar_entry_next(
+			struct efi_mokvar_table_entry **mokvar_entry)
+{
+	struct efi_mokvar_table_entry *mokvar_cur;
+	struct efi_mokvar_table_entry *mokvar_next;
+	size_t size_cur;
+
+	mokvar_cur = *mokvar_entry;
+	*mokvar_entry = NULL;
+
+	if (efi_mokvar_table_va == NULL)
+		return NULL;
+
+	if (mokvar_cur == NULL) {
+		mokvar_next = efi_mokvar_table_va;
+	} else {
+		if (mokvar_cur->name[0] == '\0')
+			return NULL;
+		size_cur = sizeof(*mokvar_cur) + mokvar_cur->data_size;
+		mokvar_next = (void *)mokvar_cur + size_cur;
+	}
+
+	if (mokvar_next->name[0] == '\0')
+		return NULL;
+
+	*mokvar_entry = mokvar_next;
+	return mokvar_next;
+}
+
+/*
+ * efi_mokvar_entry_find() - Find EFI MOK config entry by name
+ *
+ * name:	Name of the entry to look for.
+ *
+ * Returns:	Pointer to EFI MOK config table entry if found;
+ *		null otherwise.
+ *
+ * This routine depends on the EFI MOK config table being entirely
+ * mapped with it's starting virtual address in efi_mokvar_table_va.
+ */
+struct efi_mokvar_table_entry *efi_mokvar_entry_find(const char *name)
+{
+	struct efi_mokvar_table_entry *mokvar_entry = NULL;
+
+	while (efi_mokvar_entry_next(&mokvar_entry)) {
+		if (!strncmp(name, mokvar_entry->name,
+			     sizeof(mokvar_entry->name)))
+			return mokvar_entry;
+	}
+	return NULL;
+}
+
+/*
+ * efi_mokvar_sysfs_read() - sysfs binary file read routine
+ *
+ * Returns:	Count of bytes read.
+ *
+ * Copy EFI MOK config table entry data for this mokvar sysfs binary file
+ * to the supplied buffer, starting at the specified offset into mokvar table
+ * entry data, for the specified count bytes. The copy is limited by the
+ * amount of data in this mokvar config table entry.
+ */
+static ssize_t efi_mokvar_sysfs_read(struct file *file, struct kobject *kobj,
+				 struct bin_attribute *bin_attr, char *buf,
+				 loff_t off, size_t count)
+{
+	struct efi_mokvar_table_entry *mokvar_entry = bin_attr->private;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return 0;
+
+	if (off >= mokvar_entry->data_size)
+		return 0;
+	if (count >  mokvar_entry->data_size - off)
+		count = mokvar_entry->data_size - off;
+
+	memcpy(buf, mokvar_entry->data + off, count);
+	return count;
+}
+
+/*
+ * efi_mokvar_sysfs_init() - Map EFI MOK config table and create sysfs
+ *
+ * Map the EFI MOK variable config table for run-time use by the kernel
+ * and create the sysfs entries in /sys/firmware/efi/mok-variables/
+ *
+ * This routine just returns if a valid EFI MOK variable config table
+ * was not found earlier during boot.
+ *
+ * This routine must be called during a "middle" initcall phase, i.e.
+ * after efi_mokvar_table_init() but before UEFI certs are loaded
+ * during late init.
+ *
+ * Implicit inputs:
+ * efi.mokvar_table:	Physical address of EFI MOK variable config table
+ *			or special value that indicates no such table.
+ *
+ * efi_mokvar_table_size: Computed size of EFI MOK variable config table.
+ *			The table is considered present and valid if this
+ *			is non-zero.
+ *
+ * Implicit outputs:
+ * efi_mokvar_table_va:	Start virtual address of the EFI MOK config table.
+ */
+static int __init efi_mokvar_sysfs_init(void)
+{
+	void *config_va;
+	struct efi_mokvar_table_entry *mokvar_entry = NULL;
+	struct efi_mokvar_sysfs_attr *mokvar_sysfs = NULL;
+	int err = 0;
+
+	if (efi_mokvar_table_size == 0)
+		return -ENOENT;
+
+	config_va = memremap(efi.mokvar_table, efi_mokvar_table_size,
+			     MEMREMAP_WB);
+	if (!config_va) {
+		pr_err("Failed to map EFI MOKvar config table\n");
+		return -ENOMEM;
+	}
+	efi_mokvar_table_va = config_va;
+
+	mokvar_kobj = kobject_create_and_add("mok-variables", efi_kobj);
+	if (!mokvar_kobj) {
+		pr_err("Failed to create EFI mok-variables sysfs entry\n");
+		return -ENOMEM;
+	}
+
+	while (efi_mokvar_entry_next(&mokvar_entry)) {
+		mokvar_sysfs = kzalloc(sizeof(*mokvar_sysfs), GFP_KERNEL);
+		if (!mokvar_sysfs) {
+			err = -ENOMEM;
+			break;
+		}
+
+		sysfs_bin_attr_init(&mokvar_sysfs->bin_attr);
+		mokvar_sysfs->bin_attr.private = mokvar_entry;
+		mokvar_sysfs->bin_attr.attr.name = mokvar_entry->name;
+		mokvar_sysfs->bin_attr.attr.mode = 0400;
+		mokvar_sysfs->bin_attr.size = mokvar_entry->data_size;
+		mokvar_sysfs->bin_attr.read = efi_mokvar_sysfs_read;
+
+		err = sysfs_create_bin_file(mokvar_kobj,
+					   &mokvar_sysfs->bin_attr);
+		if (err)
+			break;
+
+		list_add_tail(&mokvar_sysfs->node, &efi_mokvar_sysfs_list);
+	}
+
+	if (err) {
+		pr_err("Failed to create some EFI mok-variables sysfs entries\n");
+		kfree(mokvar_sysfs);
+	}
+	return err;
+}
+device_initcall(efi_mokvar_sysfs_init);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index 73db1ae..4a2332f 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -357,6 +357,7 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 #define LINUX_EFI_INITRD_MEDIA_GUID		EFI_GUID(0x5568e427, 0x68fc, 0x4f3d,  0xac, 0x74, 0xca, 0x55, 0x52, 0x31, 0xcc, 0x68)
+#define LINUX_EFI_MOK_VARIABLE_TABLE_GUID	EFI_GUID(0xc451ed2b, 0x9694, 0x45d3,  0xba, 0xba, 0xed, 0x9f, 0x89, 0x88, 0xa3, 0x89)
 
 /* OEM GUIDs */
 #define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
@@ -546,6 +547,7 @@ extern struct efi {
 	unsigned long			esrt;			/* ESRT table */
 	unsigned long			tpm_log;		/* TPM2 Event Log table */
 	unsigned long			tpm_final_log;		/* TPM2 Final Events Log table */
+	unsigned long			mokvar_table;		/* MOK variable config table */
 
 	efi_get_time_t			*get_time;
 	efi_set_time_t			*set_time;
@@ -1252,4 +1254,36 @@ void __init efi_arch_mem_reserve(phys_addr_t addr, u64 size);
 
 char *efi_systab_show_arch(char *str);
 
+/*
+ * The LINUX_EFI_MOK_VARIABLE_TABLE_GUID config table can be provided
+ * to the kernel by an EFI boot loader. The table contains a packed
+ * sequence of these entries, one for each named MOK variable.
+ * The sequence is terminated by an entry with a completely NULL
+ * name and 0 data size.
+ */
+struct efi_mokvar_table_entry {
+	char name[256];
+	u64 data_size;
+	u8 data[];
+} __attribute((packed));
+
+#ifdef CONFIG_LOAD_UEFI_KEYS
+extern void __init efi_mokvar_table_init(void);
+extern struct efi_mokvar_table_entry *efi_mokvar_entry_next(
+			struct efi_mokvar_table_entry **mokvar_entry);
+extern struct efi_mokvar_table_entry *efi_mokvar_entry_find(const char *name);
+#else
+static inline void efi_mokvar_table_init(void) { }
+static inline struct efi_mokvar_table_entry *efi_mokvar_entry_next(
+			struct efi_mokvar_table_entry **mokvar_entry)
+{
+	return NULL;
+}
+static inline struct efi_mokvar_table_entry *efi_mokvar_entry_find(
+			const char *name)
+{
+	return NULL;
+}
+#endif
+
 #endif /* _LINUX_EFI_H */
