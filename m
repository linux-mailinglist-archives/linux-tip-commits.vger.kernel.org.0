Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B7C4C285910
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 09:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgJGHMa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727662AbgJGHMG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 03:12:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83E0EC061755;
        Wed,  7 Oct 2020 00:12:05 -0700 (PDT)
Date:   Wed, 07 Oct 2020 07:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602054724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVCL9+6mHMlL1nC7P+FDJgLnoP3GomAbfN+fsaBjDRw=;
        b=kkOgzxAr1bvxEHyr1O0lSLNyOE8CiLWvulZzV6/0675lgv0ohPbGXe2AGQkMypsQNJbb8q
        iVXkJIIb1TXJgdJwEnnQGgzPjbq+9jRI+s2Mdtbq/rBgPfuNBFqbk/RFnOvJ4+0DPp1Q0U
        TEVqehuMKIqbjNGwX54Lgrwm0ZKUGBWkdHosReLlm/r1OR1DfGnddgFCb24RLh6CKtn/Hx
        JXl3wVBOOI3BFr3noQSBtMcNNdehp0oImw9lMyT5PRouqsOWv0C9u49k6XJppXHWFQial6
        vOH0Hi8zjrbik/x+5rgMre6zOpqlilhn+GZHxj8b1pFAALUixBr1+C6c5VLotg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602054724;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rVCL9+6mHMlL1nC7P+FDJgLnoP3GomAbfN+fsaBjDRw=;
        b=Hxmi+m+4Rdo0InCJMZBbmhOs0KYVTM+hruvRMa8cMJH8RdVUTCf8chso6YrO6IAe4ftSzh
        +EXgWjtv3+BZyGAw==
From:   "tip-bot2 for Mike Travis" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add and decode Arch Type in UVsystab
Cc:     kernel test robot <lkp@intel.com>,
        Mike Travis <mike.travis@hpe.com>,
        Borislav Petkov <bp@suse.de>,
        Dimitri Sivanich <dimitri.sivanich@hpe.com>,
        Steve Wahl <steve.wahl@hpe.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201005203929.148656-7-mike.travis@hpe.com>
References: <20201005203929.148656-7-mike.travis@hpe.com>
MIME-Version: 1.0
Message-ID: <160205472336.7002.8181802603428970662.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     1e61f5a95f1913c015a2d6a1544c108248b3971c
Gitweb:        https://git.kernel.org/tip/1e61f5a95f1913c015a2d6a1544c108248b3971c
Author:        Mike Travis <mike.travis@hpe.com>
AuthorDate:    Mon, 05 Oct 2020 15:39:22 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 07 Oct 2020 09:06:10 +02:00

x86/platform/uv: Add and decode Arch Type in UVsystab

When the UV BIOS starts the kernel it passes the UVsystab info struct to
the kernel which contains information elements more specific than ACPI,
and generally pertinent only to the MMRs. These are read only fields
so information is passed one way only. A new field starting with UV5 is
the UV architecture type so the ACPI OEM_ID field can be used for other
purposes going forward. The UV Arch Type selects the entirety of the
MMRs available, with their addresses and fields defined in uv_mmrs.h.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Mike Travis <mike.travis@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Dimitri Sivanich <dimitri.sivanich@hpe.com>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Link: https://lkml.kernel.org/r/20201005203929.148656-7-mike.travis@hpe.com
---
 arch/x86/include/asm/uv/bios.h     |  16 ++-
 arch/x86/kernel/apic/x2apic_uv_x.c | 135 ++++++++++++++++++++++++----
 arch/x86/platform/uv/bios_uv.c     |  27 ++++--
 3 files changed, 148 insertions(+), 30 deletions(-)

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 70050d0..97ac595 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -5,8 +5,8 @@
 /*
  * UV BIOS layer definitions.
  *
- *  Copyright (c) 2008-2009 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson <rja@sgi.com>
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Russ Anderson <rja@sgi.com>
  */
 
 #include <linux/rtc.h>
@@ -71,6 +71,11 @@ struct uv_gam_range_entry {
 	u32	limit;		/* PA bits 56:26 (UV_GAM_RANGE_SHFT) */
 };
 
+#define	UV_AT_SIZE	8	/* 7 character arch type + NULL char */
+struct uv_arch_type_entry {
+	char	archtype[UV_AT_SIZE];
+};
+
 #define	UV_SYSTAB_SIG			"UVST"
 #define	UV_SYSTAB_VERSION_1		1	/* UV2/3 BIOS version */
 #define	UV_SYSTAB_VERSION_UV4		0x400	/* UV4 BIOS base version */
@@ -79,10 +84,14 @@ struct uv_gam_range_entry {
 #define	UV_SYSTAB_VERSION_UV4_3		0x403	/* - GAM Range PXM Value */
 #define	UV_SYSTAB_VERSION_UV4_LATEST	UV_SYSTAB_VERSION_UV4_3
 
+#define	UV_SYSTAB_VERSION_UV5		0x500	/* UV5 GAM base version */
+#define	UV_SYSTAB_VERSION_UV5_LATEST	UV_SYSTAB_VERSION_UV5
+
 #define	UV_SYSTAB_TYPE_UNUSED		0	/* End of table (offset == 0) */
 #define	UV_SYSTAB_TYPE_GAM_PARAMS	1	/* GAM PARAM conversions */
 #define	UV_SYSTAB_TYPE_GAM_RNG_TBL	2	/* GAM entry table */
-#define	UV_SYSTAB_TYPE_MAX		3
+#define	UV_SYSTAB_TYPE_ARCH_TYPE	3	/* UV arch type */
+#define	UV_SYSTAB_TYPE_MAX		4
 
 /*
  * The UV system table describes specific firmware
@@ -133,6 +142,7 @@ extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
 extern int uv_bios_init(void);
+extern unsigned long get_uv_systab_phys(bool msg);
 
 extern unsigned long sn_rtc_cycles_per_second;
 extern int uv_type;
diff --git a/arch/x86/kernel/apic/x2apic_uv_x.c b/arch/x86/kernel/apic/x2apic_uv_x.c
index fca5f94..9b7a334 100644
--- a/arch/x86/kernel/apic/x2apic_uv_x.c
+++ b/arch/x86/kernel/apic/x2apic_uv_x.c
@@ -31,7 +31,8 @@ static u64			gru_start_paddr, gru_end_paddr;
 static union uvh_apicid		uvh_apicid;
 static int			uv_node_id;
 
-/* Unpack OEM/TABLE ID's to be NULL terminated strings */
+/* Unpack AT/OEM/TABLE ID's to be NULL terminated strings */
+static u8 uv_archtype[UV_AT_SIZE];
 static u8 oem_id[ACPI_OEM_ID_SIZE + 1];
 static u8 oem_table_id[ACPI_OEM_TABLE_ID_SIZE + 1];
 
@@ -284,18 +285,102 @@ static void __init uv_stringify(int len, char *to, char *from)
 	strncpy(to, from, len-1);
 }
 
+/* Find UV arch type entry in UVsystab */
+static unsigned long __init early_find_archtype(struct uv_systab *st)
+{
+	int i;
+
+	for (i = 0; st->entry[i].type != UV_SYSTAB_TYPE_UNUSED; i++) {
+		unsigned long ptr = st->entry[i].offset;
+
+		if (!ptr)
+			continue;
+		ptr += (unsigned long)st;
+		if (st->entry[i].type == UV_SYSTAB_TYPE_ARCH_TYPE)
+			return ptr;
+	}
+	return 0;
+}
+
+/* Validate UV arch type field in UVsystab */
+static int __init decode_arch_type(unsigned long ptr)
+{
+	struct uv_arch_type_entry *uv_ate = (struct uv_arch_type_entry *)ptr;
+	int n = strlen(uv_ate->archtype);
+
+	if (n > 0 && n < sizeof(uv_ate->archtype)) {
+		pr_info("UV: UVarchtype received from BIOS\n");
+		uv_stringify(UV_AT_SIZE, uv_archtype, uv_ate->archtype);
+		return 1;
+	}
+	return 0;
+}
+
+/* Determine if UV arch type entry might exist in UVsystab */
+static int __init early_get_arch_type(void)
+{
+	unsigned long uvst_physaddr, uvst_size, ptr;
+	struct uv_systab *st;
+	u32 rev;
+	int ret;
+
+	uvst_physaddr = get_uv_systab_phys(0);
+	if (!uvst_physaddr)
+		return 0;
+
+	st = early_memremap_ro(uvst_physaddr, sizeof(struct uv_systab));
+	if (!st) {
+		pr_err("UV: Cannot access UVsystab, remap failed\n");
+		return 0;
+	}
+
+	rev = st->revision;
+	if (rev < UV_SYSTAB_VERSION_UV5) {
+		early_memunmap(st, sizeof(struct uv_systab));
+		return 0;
+	}
+
+	uvst_size = st->size;
+	early_memunmap(st, sizeof(struct uv_systab));
+	st = early_memremap_ro(uvst_physaddr, uvst_size);
+	if (!st) {
+		pr_err("UV: Cannot access UVarchtype, remap failed\n");
+		return 0;
+	}
+
+	ptr = early_find_archtype(st);
+	if (!ptr) {
+		early_memunmap(st, uvst_size);
+		return 0;
+	}
+
+	ret = decode_arch_type(ptr);
+	early_memunmap(st, uvst_size);
+	return ret;
+}
+
 static int __init uv_set_system_type(char *_oem_id)
 {
-	/* Save OEM ID */
+	/* Save OEM_ID passed from ACPI MADT */
 	uv_stringify(sizeof(oem_id), oem_id, _oem_id);
 
-	/* Set hubless type if true */
-	if (strncmp(oem_id, "SGI", 3) != 0) {
-		if (strncmp(oem_id, "NSGI", 4) != 0)
+	/* Check if BIOS sent us a UVarchtype */
+	if (!early_get_arch_type())
+
+		/* If not use OEM ID for UVarchtype */
+		uv_stringify(UV_AT_SIZE, uv_archtype, _oem_id);
+
+	/* Check if not hubbed */
+	if (strncmp(uv_archtype, "SGI", 3) != 0) {
+
+		/* (Not hubbed), check if not hubless */
+		if (strncmp(uv_archtype, "NSGI", 4) != 0)
+
+			/* (Not hubless), not a UV */
 			return 0;
 
 		/* UV4 Hubless: CH */
-		if (strncmp(oem_id, "NSGI4", 5) == 0)
+		if (strncmp(uv_archtype, "NSGI4", 5) == 0)
 			uv_hubless_system = 0x11;
 
 		/* UV3 Hubless: UV300/MC990X w/o hub */
@@ -314,10 +399,10 @@ static int __init uv_set_system_type(char *_oem_id)
 
 	/* Set hubbed type if true */
 	uv_hub_info->hub_revision =
-		!strncmp(oem_id, "SGI5", 4) ? UV5_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
-		!strncmp(oem_id, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
-		!strcmp(oem_id, "SGI2") ? UV2_HUB_REVISION_BASE : 0;
+		!strncmp(uv_archtype, "SGI5", 4) ? UV5_HUB_REVISION_BASE :
+		!strncmp(uv_archtype, "SGI4", 4) ? UV4_HUB_REVISION_BASE :
+		!strncmp(uv_archtype, "SGI3", 4) ? UV3_HUB_REVISION_BASE :
+		!strcmp(uv_archtype, "SGI2") ? UV2_HUB_REVISION_BASE : 0;
 
 	switch (uv_hub_info->hub_revision) {
 	case UV5_HUB_REVISION_BASE:
@@ -388,8 +473,7 @@ static int __init uv_acpi_madt_oem_check(char *_oem_id, char *_oem_table_id)
 	return 0;
 
 badbios:
-	pr_err("UV: OEM_ID:%s OEM_TABLE_ID:%s\n", oem_id, oem_table_id);
-	pr_err("UV: Current UV Type or BIOS not supported\n");
+	pr_err("UV: UVarchtype:%s not supported\n", uv_archtype);
 	BUG();
 }
 
@@ -1180,6 +1264,7 @@ static void __init decode_gam_rng_tbl(unsigned long ptr)
 	pr_info("UV: GRT: %d entries, sockets(min:%x,max:%x) pnodes(min:%x,max:%x)\n", index, _min_socket, _max_socket, _min_pnode, _max_pnode);
 }
 
+/* Walk through UVsystab decoding the fields */
 static int __init decode_uv_systab(void)
 {
 	struct uv_systab *st;
@@ -1209,7 +1294,8 @@ static int __init decode_uv_systab(void)
 		if (!ptr)
 			continue;
 
-		ptr = ptr + (unsigned long)st;
+		/* point to payload */
+		ptr += (unsigned long)st;
 
 		switch (st->entry[i].type) {
 		case UV_SYSTAB_TYPE_GAM_PARAMS:
@@ -1219,6 +1305,15 @@ static int __init decode_uv_systab(void)
 		case UV_SYSTAB_TYPE_GAM_RNG_TBL:
 			decode_gam_rng_tbl(ptr);
 			break;
+
+		case UV_SYSTAB_TYPE_ARCH_TYPE:
+			/* already processed in early startup */
+			break;
+
+		default:
+			pr_err("UV:%s:Unrecognized UV_SYSTAB_TYPE:%d, skipped\n",
+				__func__, st->entry[i].type);
+			break;
 		}
 	}
 	return 0;
@@ -1259,7 +1354,7 @@ static void __init build_socket_tables(void)
 			pr_info("UV: No UVsystab socket table, ignoring\n");
 			return;
 		}
-		pr_crit("UV: Error: UVsystab address translations not available!\n");
+		pr_err("UV: Error: UVsystab address translations not available!\n");
 		BUG();
 	}
 
@@ -1385,9 +1480,9 @@ static int __maybe_unused proc_hubless_show(struct seq_file *file, void *data)
 	return 0;
 }
 
-static int __maybe_unused proc_oemid_show(struct seq_file *file, void *data)
+static int __maybe_unused proc_archtype_show(struct seq_file *file, void *data)
 {
-	seq_printf(file, "%s/%s\n", oem_id, oem_table_id);
+	seq_printf(file, "%s/%s\n", uv_archtype, oem_table_id);
 	return 0;
 }
 
@@ -1396,7 +1491,7 @@ static __init void uv_setup_proc_files(int hubless)
 	struct proc_dir_entry *pde;
 
 	pde = proc_mkdir(UV_PROC_NODE, NULL);
-	proc_create_single("oemid", 0, pde, proc_oemid_show);
+	proc_create_single("archtype", 0, pde, proc_archtype_show);
 	if (hubless)
 		proc_create_single("hubless", 0, pde, proc_hubless_show);
 	else
@@ -1448,12 +1543,14 @@ static void __init uv_system_init_hub(void)
 
 	map_low_mmrs();
 
-	/* Get uv_systab for decoding: */
+	/* Get uv_systab for decoding, setup UV BIOS calls */
 	uv_bios_init();
 
 	/* If there's an UVsystab problem then abort UV init: */
-	if (decode_uv_systab() < 0)
+	if (decode_uv_systab() < 0) {
+		pr_err("UV: Mangled UVsystab format\n");
 		return;
+	}
 
 	build_socket_tables();
 	build_uv_gr_table();
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index a2f447d..b148b4c 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -2,8 +2,8 @@
 /*
  * BIOS run time interface routines.
  *
- *  Copyright (c) 2008-2009 Silicon Graphics, Inc.  All Rights Reserved.
- *  Copyright (c) Russ Anderson <rja@sgi.com>
+ * Copyright (C) 2007-2017 Silicon Graphics, Inc. All rights reserved.
+ * Copyright (c) Russ Anderson <rja@sgi.com>
  */
 
 #include <linux/efi.h>
@@ -170,16 +170,27 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 				(u64)decode, (u64)domain, (u64)bus, 0, 0);
 }
 
-int uv_bios_init(void)
+unsigned long get_uv_systab_phys(bool msg)
 {
-	uv_systab = NULL;
 	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
 	    !uv_systab_phys || efi_runtime_disabled()) {
-		pr_crit("UV: UVsystab: missing\n");
-		return -EEXIST;
+		if (msg)
+			pr_crit("UV: UVsystab: missing\n");
+		return 0;
 	}
+	return uv_systab_phys;
+}
+
+int uv_bios_init(void)
+{
+	unsigned long uv_systab_phys_addr;
+
+	uv_systab = NULL;
+	uv_systab_phys_addr = get_uv_systab_phys(1);
+	if (!uv_systab_phys_addr)
+		return -EEXIST;
 
-	uv_systab = ioremap(uv_systab_phys, sizeof(struct uv_systab));
+	uv_systab = ioremap(uv_systab_phys_addr, sizeof(struct uv_systab));
 	if (!uv_systab || strncmp(uv_systab->signature, UV_SYSTAB_SIG, 4)) {
 		pr_err("UV: UVsystab: bad signature!\n");
 		iounmap(uv_systab);
@@ -191,7 +202,7 @@ int uv_bios_init(void)
 		int size = uv_systab->size;
 
 		iounmap(uv_systab);
-		uv_systab = ioremap(uv_systab_phys, size);
+		uv_systab = ioremap(uv_systab_phys_addr, size);
 		if (!uv_systab) {
 			pr_err("UV: UVsystab: ioremap(%d) failed!\n", size);
 			return -EFAULT;
