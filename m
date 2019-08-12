Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 621A08A401
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Aug 2019 19:07:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbfHLRGi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 12 Aug 2019 13:06:38 -0400
Received: from terminus.zytor.com ([198.137.202.136]:50017 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726881AbfHLRGi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 12 Aug 2019 13:06:38 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7CH6Tw5994162
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Mon, 12 Aug 2019 10:06:29 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7CH6Tw5994162
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565629590;
        bh=FKQib1FOswsbUedFQaIQf/qtyl4Np9Vbjeq6H20OoZ4=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=E+lSg8/kPJeDqUL4iKPntvu78A4nQKwSFGMMJuofZ4Uije1R30bGaeY5KkegZ0KST
         4AQbu+l8dq0fIYcZ4xOa00wBeDN6RvZmEdFHvjJXPEbkXftaXB4ivAep8TKtTD/Hbs
         3fxW4cI6MPHsOUH9QitCRhLzme1M7/SFwXecD+Lc8zimsFg7Ajg9FIJ+CJ22qRFnAE
         e1kd2yQbdd7cCuMpiBvLFQ6GIGWOe8JN6WRgXFabDQi97/f7oKK5CvEULeFbVwrwXQ
         HXCxrn3JnpUVRqPu7BNs3bPppFHjeyrPWI1M0wmTM5Y1tb3Hlt+jVKZFzOkIfgS1Fc
         3UftHIo9LU9uA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7CH6THG994159;
        Mon, 12 Aug 2019 10:06:29 -0700
Date:   Mon, 12 Aug 2019 10:06:29 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Narendra K <tipbot@zytor.com>
Message-ID: <tip-1c5fecb61255aa12a16c4c06335ab68979865914@git.kernel.org>
Cc:     mario.limonciello@dell.com, ard.biesheuvel@linaro.org,
        Narendra.K@dell.com, mingo@kernel.org, hpa@zytor.com,
        tglx@linutronix.de
Reply-To: tglx@linutronix.de, mingo@kernel.org, hpa@zytor.com,
          linux-kernel@vger.kernel.org, mario.limonciello@dell.com,
          Narendra.K@dell.com, ard.biesheuvel@linaro.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:efi/core] efi: Export Runtime Configuration Interface table to
 sysfs
Git-Commit-ID: 1c5fecb61255aa12a16c4c06335ab68979865914
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

Commit-ID:  1c5fecb61255aa12a16c4c06335ab68979865914
Gitweb:     https://git.kernel.org/tip/1c5fecb61255aa12a16c4c06335ab68979865914
Author:     Narendra K <Narendra.K@dell.com>
AuthorDate: Wed, 10 Jul 2019 18:59:15 +0000
Committer:  Ard Biesheuvel <ard.biesheuvel@linaro.org>
CommitDate: Thu, 8 Aug 2019 11:10:25 +0300

efi: Export Runtime Configuration Interface table to sysfs

System firmware advertises the address of the 'Runtime
Configuration Interface table version 2 (RCI2)' via
an EFI Configuration Table entry. This code retrieves the RCI2
table from the address and exports it to sysfs as a binary
attribute 'rci2' under /sys/firmware/efi/tables directory.
The approach adopted is similar to the attribute 'DMI' under
/sys/firmware/dmi/tables.

RCI2 table contains BIOS HII in XML format and is used to populate
BIOS setup page in Dell EMC OpenManage Server Administrator tool.
The BIOS setup page contains BIOS tokens which can be configured.

Signed-off-by: Narendra K <Narendra.K@dell.com>
Reviewed-by: Mario Limonciello <mario.limonciello@dell.com>
Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 Documentation/ABI/testing/sysfs-firmware-efi |   8 ++
 arch/x86/platform/efi/efi.c                  |   3 +
 drivers/firmware/efi/Kconfig                 |  13 +++
 drivers/firmware/efi/Makefile                |   1 +
 drivers/firmware/efi/efi.c                   |   3 +
 drivers/firmware/efi/rci2-table.c            | 147 +++++++++++++++++++++++++++
 include/linux/efi.h                          |   5 +
 7 files changed, 180 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-firmware-efi b/Documentation/ABI/testing/sysfs-firmware-efi
index e794eac32a90..5e4d0b27cdfe 100644
--- a/Documentation/ABI/testing/sysfs-firmware-efi
+++ b/Documentation/ABI/testing/sysfs-firmware-efi
@@ -28,3 +28,11 @@ Description:	Displays the physical addresses of all EFI Configuration
 		versions are always printed first, i.e. ACPI20 comes
 		before ACPI.
 Users:		dmidecode
+
+What:		/sys/firmware/efi/tables/rci2
+Date:		July 2019
+Contact:	Narendra K <Narendra.K@dell.com>, linux-bugs@dell.com
+Description:	Displays the content of the Runtime Configuration Interface
+		Table version 2 on Dell EMC PowerEdge systems in binary format
+Users:		It is used by Dell EMC OpenManage Server Administrator tool to
+		populate BIOS setup page.
diff --git a/arch/x86/platform/efi/efi.c b/arch/x86/platform/efi/efi.c
index 6697c109c449..c202e1b07e29 100644
--- a/arch/x86/platform/efi/efi.c
+++ b/arch/x86/platform/efi/efi.c
@@ -82,6 +82,9 @@ static const unsigned long * const efi_tables[] = {
 	&efi.esrt,
 	&efi.properties_table,
 	&efi.mem_attr_table,
+#ifdef CONFIG_EFI_RCI2_TABLE
+	&rci2_table_phys,
+#endif
 };
 
 u64 efi_setup;		/* efi setup_data physical address */
diff --git a/drivers/firmware/efi/Kconfig b/drivers/firmware/efi/Kconfig
index d4ea929e8b34..178ee8106828 100644
--- a/drivers/firmware/efi/Kconfig
+++ b/drivers/firmware/efi/Kconfig
@@ -180,6 +180,19 @@ config RESET_ATTACK_MITIGATION
 	  have been evicted, since otherwise it will trigger even on clean
 	  reboots.
 
+config EFI_RCI2_TABLE
+	bool "EFI Runtime Configuration Interface Table Version 2 Support"
+	help
+	  Displays the content of the Runtime Configuration Interface
+	  Table version 2 on Dell EMC PowerEdge systems as a binary
+	  attribute 'rci2' under /sys/firmware/efi/tables directory.
+
+	  RCI2 table contains BIOS HII in XML format and is used to populate
+	  BIOS setup page in Dell EMC OpenManage Server Administrator tool.
+	  The BIOS setup page contains BIOS tokens which can be configured.
+
+	  Say Y here for Dell EMC PowerEdge systems.
+
 endmenu
 
 config UEFI_CPER
diff --git a/drivers/firmware/efi/Makefile b/drivers/firmware/efi/Makefile
index d2d0d2030620..4ac2de4dfa72 100644
--- a/drivers/firmware/efi/Makefile
+++ b/drivers/firmware/efi/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_EFI_BOOTLOADER_CONTROL)	+= efibc.o
 obj-$(CONFIG_EFI_TEST)			+= test/
 obj-$(CONFIG_EFI_DEV_PATH_PARSER)	+= dev-path-parser.o
 obj-$(CONFIG_APPLE_PROPERTIES)		+= apple-properties.o
+obj-$(CONFIG_EFI_RCI2_TABLE)		+= rci2-table.o
 
 arm-obj-$(CONFIG_EFI)			:= arm-init.o arm-runtime.o
 obj-$(CONFIG_ARM)			+= $(arm-obj-y)
diff --git a/drivers/firmware/efi/efi.c b/drivers/firmware/efi/efi.c
index 801925c5bcfb..8f1ab04f6743 100644
--- a/drivers/firmware/efi/efi.c
+++ b/drivers/firmware/efi/efi.c
@@ -465,6 +465,9 @@ static __initdata efi_config_table_type_t common_tables[] = {
 	{LINUX_EFI_TPM_EVENT_LOG_GUID, "TPMEventLog", &efi.tpm_log},
 	{LINUX_EFI_TPM_FINAL_LOG_GUID, "TPMFinalLog", &efi.tpm_final_log},
 	{LINUX_EFI_MEMRESERVE_TABLE_GUID, "MEMRESERVE", &efi.mem_reserve},
+#ifdef CONFIG_EFI_RCI2_TABLE
+	{DELLEMC_EFI_RCI2_TABLE_GUID, NULL, &rci2_table_phys},
+#endif
 	{NULL_GUID, NULL, NULL},
 };
 
diff --git a/drivers/firmware/efi/rci2-table.c b/drivers/firmware/efi/rci2-table.c
new file mode 100644
index 000000000000..3e290f96620a
--- /dev/null
+++ b/drivers/firmware/efi/rci2-table.c
@@ -0,0 +1,147 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Export Runtime Configuration Interface Table Version 2 (RCI2)
+ * to sysfs
+ *
+ * Copyright (C) 2019 Dell Inc
+ * by Narendra K <Narendra.K@dell.com>
+ *
+ * System firmware advertises the address of the RCI2 Table via
+ * an EFI Configuration Table entry. This code retrieves the RCI2
+ * table from the address and exports it to sysfs as a binary
+ * attribute 'rci2' under /sys/firmware/efi/tables directory.
+ */
+
+#include <linux/kobject.h>
+#include <linux/device.h>
+#include <linux/sysfs.h>
+#include <linux/efi.h>
+#include <linux/types.h>
+#include <linux/io.h>
+
+#define RCI_SIGNATURE	"_RC_"
+
+struct rci2_table_global_hdr {
+	u16 type;
+	u16 resvd0;
+	u16 hdr_len;
+	u8 rci2_sig[4];
+	u16 resvd1;
+	u32 resvd2;
+	u32 resvd3;
+	u8 major_rev;
+	u8 minor_rev;
+	u16 num_of_structs;
+	u32 rci2_len;
+	u16 rci2_chksum;
+} __packed;
+
+static u8 *rci2_base;
+static u32 rci2_table_len;
+unsigned long rci2_table_phys __ro_after_init = EFI_INVALID_TABLE_ADDR;
+
+static ssize_t raw_table_read(struct file *file, struct kobject *kobj,
+			      struct bin_attribute *attr, char *buf,
+			      loff_t pos, size_t count)
+{
+	memcpy(buf, attr->private + pos, count);
+	return count;
+}
+
+static BIN_ATTR(rci2, S_IRUSR, raw_table_read, NULL, 0);
+
+static u16 checksum(void)
+{
+	u8 len_is_odd = rci2_table_len % 2;
+	u32 chksum_len = rci2_table_len;
+	u16 *base = (u16 *)rci2_base;
+	u8 buf[2] = {0};
+	u32 offset = 0;
+	u16 chksum = 0;
+
+	if (len_is_odd)
+		chksum_len -= 1;
+
+	while (offset < chksum_len) {
+		chksum += *base;
+		offset += 2;
+		base++;
+	}
+
+	if (len_is_odd) {
+		buf[0] = *(u8 *)base;
+		chksum += *(u16 *)(buf);
+	}
+
+	return chksum;
+}
+
+int __init efi_rci2_sysfs_init(void)
+{
+	struct kobject *tables_kobj;
+	int ret = -ENOMEM;
+
+	rci2_base = memremap(rci2_table_phys,
+			     sizeof(struct rci2_table_global_hdr),
+			     MEMREMAP_WB);
+	if (!rci2_base) {
+		pr_debug("RCI2 table init failed - could not map RCI2 table\n");
+		goto err;
+	}
+
+	if (strncmp(rci2_base +
+		    offsetof(struct rci2_table_global_hdr, rci2_sig),
+		    RCI_SIGNATURE, 4)) {
+		pr_debug("RCI2 table init failed - incorrect signature\n");
+		ret = -ENODEV;
+		goto err_unmap;
+	}
+
+	rci2_table_len = *(u32 *)(rci2_base +
+				  offsetof(struct rci2_table_global_hdr,
+				  rci2_len));
+
+	memunmap(rci2_base);
+
+	if (!rci2_table_len) {
+		pr_debug("RCI2 table init failed - incorrect table length\n");
+		goto err;
+	}
+
+	rci2_base = memremap(rci2_table_phys, rci2_table_len, MEMREMAP_WB);
+	if (!rci2_base) {
+		pr_debug("RCI2 table - could not map RCI2 table\n");
+		goto err;
+	}
+
+	if (checksum() != 0) {
+		pr_debug("RCI2 table - incorrect checksum\n");
+		ret = -ENODEV;
+		goto err_unmap;
+	}
+
+	tables_kobj = kobject_create_and_add("tables", efi_kobj);
+	if (!tables_kobj) {
+		pr_debug("RCI2 table - tables_kobj creation failed\n");
+		goto err_unmap;
+	}
+
+	bin_attr_rci2.size = rci2_table_len;
+	bin_attr_rci2.private = rci2_base;
+	ret = sysfs_create_bin_file(tables_kobj, &bin_attr_rci2);
+	if (ret != 0) {
+		pr_debug("RCI2 table - rci2 sysfs bin file creation failed\n");
+		kobject_del(tables_kobj);
+		kobject_put(tables_kobj);
+		goto err_unmap;
+	}
+
+	return 0;
+
+ err_unmap:
+	memunmap(rci2_base);
+ err:
+	pr_debug("RCI2 table - sysfs initialization failed\n");
+	return ret;
+}
+late_initcall(efi_rci2_sysfs_init);
diff --git a/include/linux/efi.h b/include/linux/efi.h
index f88318b85fb0..bd3837022307 100644
--- a/include/linux/efi.h
+++ b/include/linux/efi.h
@@ -692,6 +692,9 @@ void efi_native_runtime_setup(void);
 #define LINUX_EFI_TPM_FINAL_LOG_GUID		EFI_GUID(0x1e2ed096, 0x30e2, 0x4254,  0xbd, 0x89, 0x86, 0x3b, 0xbe, 0xf8, 0x23, 0x25)
 #define LINUX_EFI_MEMRESERVE_TABLE_GUID		EFI_GUID(0x888eb0c6, 0x8ede, 0x4ff5,  0xa8, 0xf0, 0x9a, 0xee, 0x5c, 0xb9, 0x77, 0xc2)
 
+/* OEM GUIDs */
+#define DELLEMC_EFI_RCI2_TABLE_GUID		EFI_GUID(0x2d9f28a2, 0xa886, 0x456a,  0x97, 0xa8, 0xf1, 0x1e, 0xf2, 0x4f, 0xf4, 0x55)
+
 typedef struct {
 	efi_guid_t guid;
 	u64 table;
@@ -1713,6 +1716,8 @@ struct efi_tcg2_final_events_table {
 };
 extern int efi_tpm_final_log_size;
 
+extern unsigned long rci2_table_phys;
+
 /*
  * efi_runtime_service() function identifiers.
  * "NONE" is used by efi_recover_from_page_fault() to check if the page
