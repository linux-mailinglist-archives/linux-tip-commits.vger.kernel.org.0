Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D86E27E028
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Sep 2020 07:23:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725306AbgI3FW3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Sep 2020 01:22:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725777AbgI3FW2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Sep 2020 01:22:28 -0400
Date:   Wed, 30 Sep 2020 05:22:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601443344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BHt70+PWI5VwA1dMSPAwzBYKL1kgElEFIh0qk9P0uQ=;
        b=ALkVfsiQYEDPuvrXCK2jN9e5PfeVBlPnbrGrYZgPF5cvOdyBeJebTDv3gUocqXV37jIHWx
        IR6V8KLOjO9eC96b82/zqRFcq9ntfpDOVp6jY8ZlxWOqWp+NFu4KJZcOhuxGxN0flKIydI
        CHZgzKMRTFOfKBQRsiHh9q4/EOrLOivaz0RvQdldX6W+5hL5MI7n06WABxE2FPGiZsQQ5w
        dJegCJDumXQSZYZ5fskmU/8XV+jf+jAcQ+e7PB9yRFOGMyqEamEPdTIii7TSZG09mr66zY
        rbApyR0FoXhP+zzifn4WqeonWIgyIVQ46GM9C+uAsRU+eqxqtYz2MViaDlQ/0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601443344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7BHt70+PWI5VwA1dMSPAwzBYKL1kgElEFIh0qk9P0uQ=;
        b=F390x7tzix+pZXFYBsX5TDv9qIaAJGFnk/j4Yy+13glbl7QNUZZnlaBL1mF/5aZXQuQ6cz
        INHRZemLOCwglpBw==
From:   "tip-bot2 for Arvind Sankar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: efi/core] efi/x86: Add a quirk to support command line
 arguments on Dell EFI firmware
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Jacobo Pantoja <jacobopantoja@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200914213535.933454-2-nivedita@alum.mit.edu>
References: <20200914213535.933454-2-nivedita@alum.mit.edu>
MIME-Version: 1.0
Message-ID: <160144334358.7002.5722251016649401624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the efi/core branch of tip:

Commit-ID:     4a568ce29d3f48df95919f82a80e4b9be7ea0dc1
Gitweb:        https://git.kernel.org/tip/4a568ce29d3f48df95919f82a80e4b9be7ea0dc1
Author:        Arvind Sankar <nivedita@alum.mit.edu>
AuthorDate:    Mon, 14 Sep 2020 17:35:35 -04:00
Committer:     Ard Biesheuvel <ardb@kernel.org>
CommitterDate: Thu, 17 Sep 2020 10:19:53 +03:00

efi/x86: Add a quirk to support command line arguments on Dell EFI firmware

At least some versions of Dell EFI firmware pass the entire
EFI_LOAD_OPTION descriptor, rather than just the OptionalData part, to
the loaded image. This was verified with firmware revision 2.15.0 on a
Dell Precision T3620 by Jacobo Pantoja.

To handle this, add a quirk to check if the options look like a valid
EFI_LOAD_OPTION descriptor, and if so, use the OptionalData part as the
command line.

Signed-off-by: Arvind Sankar <nivedita@alum.mit.edu>
Reported-by: Jacobo Pantoja <jacobopantoja@gmail.com>
Link: https://lore.kernel.org/linux-efi/20200907170021.GA2284449@rani.riverdale.lan/
Link: https://lore.kernel.org/r/20200914213535.933454-2-nivedita@alum.mit.edu
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/firmware/efi/libstub/efi-stub-helper.c | 101 +++++++++++++++-
 drivers/firmware/efi/libstub/efistub.h         |  31 +++++-
 drivers/firmware/efi/libstub/file.c            |   5 +-
 3 files changed, 135 insertions(+), 2 deletions(-)

diff --git a/drivers/firmware/efi/libstub/efi-stub-helper.c b/drivers/firmware/efi/libstub/efi-stub-helper.c
index 6bca70b..4dbf04c 100644
--- a/drivers/firmware/efi/libstub/efi-stub-helper.c
+++ b/drivers/firmware/efi/libstub/efi-stub-helper.c
@@ -231,6 +231,102 @@ efi_status_t efi_parse_options(char const *cmdline)
 }
 
 /*
+ * The EFI_LOAD_OPTION descriptor has the following layout:
+ *	u32 Attributes;
+ *	u16 FilePathListLength;
+ *	u16 Description[];
+ *	efi_device_path_protocol_t FilePathList[];
+ *	u8 OptionalData[];
+ *
+ * This function validates and unpacks the variable-size data fields.
+ */
+static
+bool efi_load_option_unpack(efi_load_option_unpacked_t *dest,
+			    const efi_load_option_t *src, size_t size)
+{
+	const void *pos;
+	u16 c;
+	efi_device_path_protocol_t header;
+	const efi_char16_t *description;
+	const efi_device_path_protocol_t *file_path_list;
+
+	if (size < offsetof(efi_load_option_t, variable_data))
+		return false;
+	pos = src->variable_data;
+	size -= offsetof(efi_load_option_t, variable_data);
+
+	if ((src->attributes & ~EFI_LOAD_OPTION_MASK) != 0)
+		return false;
+
+	/* Scan description. */
+	description = pos;
+	do {
+		if (size < sizeof(c))
+			return false;
+		c = *(const u16 *)pos;
+		pos += sizeof(c);
+		size -= sizeof(c);
+	} while (c != L'\0');
+
+	/* Scan file_path_list. */
+	file_path_list = pos;
+	do {
+		if (size < sizeof(header))
+			return false;
+		header = *(const efi_device_path_protocol_t *)pos;
+		if (header.length < sizeof(header))
+			return false;
+		if (size < header.length)
+			return false;
+		pos += header.length;
+		size -= header.length;
+	} while ((header.type != EFI_DEV_END_PATH && header.type != EFI_DEV_END_PATH2) ||
+		 (header.sub_type != EFI_DEV_END_ENTIRE));
+	if (pos != (const void *)file_path_list + src->file_path_list_length)
+		return false;
+
+	dest->attributes = src->attributes;
+	dest->file_path_list_length = src->file_path_list_length;
+	dest->description = description;
+	dest->file_path_list = file_path_list;
+	dest->optional_data_size = size;
+	dest->optional_data = size ? pos : NULL;
+
+	return true;
+}
+
+/*
+ * At least some versions of Dell firmware pass the entire contents of the
+ * Boot#### variable, i.e. the EFI_LOAD_OPTION descriptor, rather than just the
+ * OptionalData field.
+ *
+ * Detect this case and extract OptionalData.
+ */
+void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size)
+{
+	const efi_load_option_t *load_option = *load_options;
+	efi_load_option_unpacked_t load_option_unpacked;
+
+	if (!IS_ENABLED(CONFIG_X86))
+		return;
+	if (!load_option)
+		return;
+	if (*load_options_size < sizeof(*load_option))
+		return;
+	if ((load_option->attributes & ~EFI_LOAD_OPTION_BOOT_MASK) != 0)
+		return;
+
+	if (!efi_load_option_unpack(&load_option_unpacked, load_option, *load_options_size))
+		return;
+
+	efi_warn_once(FW_BUG "LoadOptions is an EFI_LOAD_OPTION descriptor\n");
+	efi_warn_once(FW_BUG "Using OptionalData as a workaround\n");
+
+	*load_options = load_option_unpacked.optional_data;
+	*load_options_size = load_option_unpacked.optional_data_size;
+}
+
+/*
  * Convert the unicode UEFI command line to ASCII to pass to kernel.
  * Size of memory allocated return in *cmd_line_len.
  * Returns NULL on error.
@@ -239,12 +335,15 @@ char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len)
 {
 	const u16 *s2;
 	unsigned long cmdline_addr = 0;
-	int options_chars = efi_table_attr(image, load_options_size) / 2;
+	int options_chars = efi_table_attr(image, load_options_size);
 	const u16 *options = efi_table_attr(image, load_options);
 	int options_bytes = 0, safe_options_bytes = 0;  /* UTF-8 bytes */
 	bool in_quote = false;
 	efi_status_t status;
 
+	efi_apply_loadoptions_quirk((const void **)&options, &options_chars);
+	options_chars /= sizeof(*options);
+
 	if (options) {
 		s2 = options;
 		while (options_bytes < COMMAND_LINE_SIZE && options_chars--) {
diff --git a/drivers/firmware/efi/libstub/efistub.h b/drivers/firmware/efi/libstub/efistub.h
index 9ea87a2..2d7abcd 100644
--- a/drivers/firmware/efi/libstub/efistub.h
+++ b/drivers/firmware/efi/libstub/efistub.h
@@ -708,6 +708,35 @@ union efi_load_file_protocol {
 	} mixed_mode;
 };
 
+typedef struct {
+	u32 attributes;
+	u16 file_path_list_length;
+	u8 variable_data[];
+	// efi_char16_t description[];
+	// efi_device_path_protocol_t file_path_list[];
+	// u8 optional_data[];
+} __packed efi_load_option_t;
+
+#define EFI_LOAD_OPTION_ACTIVE		0x0001U
+#define EFI_LOAD_OPTION_FORCE_RECONNECT	0x0002U
+#define EFI_LOAD_OPTION_HIDDEN		0x0008U
+#define EFI_LOAD_OPTION_CATEGORY	0x1f00U
+#define   EFI_LOAD_OPTION_CATEGORY_BOOT	0x0000U
+#define   EFI_LOAD_OPTION_CATEGORY_APP	0x0100U
+
+#define EFI_LOAD_OPTION_BOOT_MASK \
+	(EFI_LOAD_OPTION_ACTIVE|EFI_LOAD_OPTION_HIDDEN|EFI_LOAD_OPTION_CATEGORY)
+#define EFI_LOAD_OPTION_MASK (EFI_LOAD_OPTION_FORCE_RECONNECT|EFI_LOAD_OPTION_BOOT_MASK)
+
+typedef struct {
+	u32 attributes;
+	u16 file_path_list_length;
+	const efi_char16_t *description;
+	const efi_device_path_protocol_t *file_path_list;
+	size_t optional_data_size;
+	const void *optional_data;
+} efi_load_option_unpacked_t;
+
 void efi_pci_disable_bridge_busmaster(void);
 
 typedef efi_status_t (*efi_exit_boot_map_processing)(
@@ -750,6 +779,8 @@ __printf(1, 2) int efi_printk(char const *fmt, ...);
 
 void efi_free(unsigned long size, unsigned long addr);
 
+void efi_apply_loadoptions_quirk(const void **load_options, int *load_options_size);
+
 char *efi_convert_cmdline(efi_loaded_image_t *image, int *cmd_line_len);
 
 efi_status_t efi_get_memory_map(struct efi_boot_memmap *map);
diff --git a/drivers/firmware/efi/libstub/file.c b/drivers/firmware/efi/libstub/file.c
index 630caa6..4e81c60 100644
--- a/drivers/firmware/efi/libstub/file.c
+++ b/drivers/firmware/efi/libstub/file.c
@@ -136,7 +136,7 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 				  unsigned long *load_size)
 {
 	const efi_char16_t *cmdline = image->load_options;
-	int cmdline_len = image->load_options_size / 2;
+	int cmdline_len = image->load_options_size;
 	unsigned long efi_chunk_size = ULONG_MAX;
 	efi_file_protocol_t *volume = NULL;
 	efi_file_protocol_t *file;
@@ -148,6 +148,9 @@ efi_status_t handle_cmdline_files(efi_loaded_image_t *image,
 	if (!load_addr || !load_size)
 		return EFI_INVALID_PARAMETER;
 
+	efi_apply_loadoptions_quirk((const void **)&cmdline, &cmdline_len);
+	cmdline_len /= sizeof(*cmdline);
+
 	if (IS_ENABLED(CONFIG_X86) && !efi_nochunk)
 		efi_chunk_size = EFI_READ_CHUNK_SIZE;
 
