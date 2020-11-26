Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2E0E2C5BE4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Nov 2020 19:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404930AbgKZSUt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Nov 2020 13:20:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58294 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404543AbgKZSUt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Nov 2020 13:20:49 -0500
Date:   Thu, 26 Nov 2020 18:20:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606414845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LR7auITkQA9ciSP1P0XCz5vxQA2k3hEVf0nbTjy/oaU=;
        b=hlfYWgpwkyZh5oymWVQGdGd9Q7YZy2tm1LUqKRyYPKM2FQkFwdtYo4uQxg/SJIgh6+JmMV
        SQK5OQcf/PDBWABrcvvMSb45ybQH+PJdJBw0O0PiUvBT1zyzaJugu2p7JJDK5pgzJsIZPA
        H/nHNHRtti1FNi1BbzioQKbwrgAvFHC9b3DlHFgqsQCiDgyZr3DTCl7cBh7+RsbF8mvICY
        qGo8XyDODqmdx+TO6eh/j7LCJNxLElk30/SFfKJFBfl8KzoJEgvl2Yk57FekM9M4ZL/q/L
        J/oQ1RfXVFFk4zlt1FWWsHdPL88weapqvoQA1EWDUT4nHrQo83gQ9ufrfXsA2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606414845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LR7auITkQA9ciSP1P0XCz5vxQA2k3hEVf0nbTjy/oaU=;
        b=VH8ZyrABy6a5O4UJBq/xsO3/LdLjy5J3JffM66Wh+2nNigTekmSvM/YWixQls41NVy709B
        a64SU3EtsAZWCCDA==
From:   "tip-bot2 for Justin Ernst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/platform] x86/platform/uv: Add and export uv_bios_* functions
Cc:     Justin Ernst <justin.ernst@hpe.com>, Borislav Petkov <bp@suse.de>,
        Steve Wahl <steve.wahl@hpe.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201125175444.279074-3-justin.ernst@hpe.com>
References: <20201125175444.279074-3-justin.ernst@hpe.com>
MIME-Version: 1.0
Message-ID: <160641484533.3364.16984449727126439665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/platform branch of tip:

Commit-ID:     9a3c425cfdfee169622f1cb1a974b2f287e5560c
Gitweb:        https://git.kernel.org/tip/9a3c425cfdfee169622f1cb1a974b2f287e5560c
Author:        Justin Ernst <justin.ernst@hpe.com>
AuthorDate:    Wed, 25 Nov 2020 11:54:41 -06:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 26 Nov 2020 12:50:44 +01:00

x86/platform/uv: Add and export uv_bios_* functions

Add additional uv_bios_call() variant functions to expose information
needed by the new uv_sysfs driver. This includes the addition of several
new data types defined by UV BIOS and used in the new functions.

Signed-off-by: Justin Ernst <justin.ernst@hpe.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Steve Wahl <steve.wahl@hpe.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lkml.kernel.org/r/20201125175444.279074-3-justin.ernst@hpe.com
---
 arch/x86/include/asm/uv/bios.h   |  49 ++++++++++++++-
 arch/x86/include/asm/uv/uv_geo.h | 103 ++++++++++++++++++++++++++++++-
 arch/x86/platform/uv/bios_uv.c   |  55 ++++++++++++++++-
 3 files changed, 207 insertions(+)
 create mode 100644 arch/x86/include/asm/uv/uv_geo.h

diff --git a/arch/x86/include/asm/uv/bios.h b/arch/x86/include/asm/uv/bios.h
index 08b3d81..01ba080 100644
--- a/arch/x86/include/asm/uv/bios.h
+++ b/arch/x86/include/asm/uv/bios.h
@@ -28,6 +28,20 @@ enum uv_bios_cmd {
 	UV_BIOS_SET_LEGACY_VGA_TARGET
 };
 
+#define UV_BIOS_EXTRA			    0x10000
+#define UV_BIOS_GET_PCI_TOPOLOGY	    0x10001
+#define UV_BIOS_GET_GEOINFO		    0x10003
+
+#define UV_BIOS_EXTRA_OP_MEM_COPYIN	    0x1000
+#define UV_BIOS_EXTRA_OP_MEM_COPYOUT	    0x2000
+#define UV_BIOS_EXTRA_OP_MASK		    0x0fff
+#define UV_BIOS_EXTRA_GET_HEAPSIZE	    1
+#define UV_BIOS_EXTRA_INSTALL_HEAP	    2
+#define UV_BIOS_EXTRA_MASTER_NASID	    3
+#define UV_BIOS_EXTRA_OBJECT_COUNT	    (10|UV_BIOS_EXTRA_OP_MEM_COPYOUT)
+#define UV_BIOS_EXTRA_ENUM_OBJECTS	    (12|UV_BIOS_EXTRA_OP_MEM_COPYOUT)
+#define UV_BIOS_EXTRA_ENUM_PORTS	    (13|UV_BIOS_EXTRA_OP_MEM_COPYOUT)
+
 /*
  * Status values returned from a BIOS call.
  */
@@ -109,6 +123,32 @@ struct uv_systab {
 	} entry[1];		/* additional entries follow */
 };
 extern struct uv_systab *uv_systab;
+
+#define UV_BIOS_MAXSTRING	      128
+struct uv_bios_hub_info {
+	unsigned int id;
+	union {
+		struct {
+			unsigned long long this_part:1;
+			unsigned long long is_shared:1;
+			unsigned long long is_disabled:1;
+		} fields;
+		struct {
+			unsigned long long flags;
+			unsigned long long reserved;
+		} b;
+	} f;
+	char name[UV_BIOS_MAXSTRING];
+	char location[UV_BIOS_MAXSTRING];
+	unsigned int ports;
+};
+
+struct uv_bios_port_info {
+	unsigned int port;
+	unsigned int conn_id;
+	unsigned int conn_port;
+};
+
 /* (... end of definitions from UV BIOS ...) */
 
 enum {
@@ -142,6 +182,15 @@ extern s64 uv_bios_change_memprotect(u64, u64, enum uv_memprotect);
 extern s64 uv_bios_reserved_page_pa(u64, u64 *, u64 *, u64 *);
 extern int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus);
 
+extern s64 uv_bios_get_master_nasid(u64 sz, u64 *nasid);
+extern s64 uv_bios_get_heapsize(u64 nasid, u64 sz, u64 *heap_sz);
+extern s64 uv_bios_install_heap(u64 nasid, u64 sz, u64 *heap);
+extern s64 uv_bios_obj_count(u64 nasid, u64 sz, u64 *objcnt);
+extern s64 uv_bios_enum_objs(u64 nasid, u64 sz, u64 *objbuf);
+extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 sz, u64 *portbuf);
+extern s64 uv_bios_get_geoinfo(u64 nasid, u64 sz, u64 *geo);
+extern s64 uv_bios_get_pci_topology(u64 sz, u64 *buf);
+
 extern int uv_bios_init(void);
 extern unsigned long get_uv_systab_phys(bool msg);
 
diff --git a/arch/x86/include/asm/uv/uv_geo.h b/arch/x86/include/asm/uv/uv_geo.h
new file mode 100644
index 0000000..f241451
--- /dev/null
+++ b/arch/x86/include/asm/uv/uv_geo.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2020 Hewlett Packard Enterprise Development LP. All rights reserved.
+ */
+
+#ifndef _ASM_UV_GEO_H
+#define _ASM_UV_GEO_H
+
+/* Type declaractions */
+
+/* Size of a geoid_s structure (must be before decl. of geoid_u) */
+#define GEOID_SIZE	8
+
+/* Fields common to all substructures */
+struct geo_common_s {
+	unsigned char type;		/* What type of h/w is named by this geoid_s */
+	unsigned char blade;
+	unsigned char slot;		/* slot is IRU */
+	unsigned char upos;
+	unsigned char rack;
+};
+
+/* Additional fields for particular types of hardware */
+struct geo_node_s {
+	struct geo_common_s common;		/* No additional fields needed */
+};
+
+struct geo_rtr_s {
+	struct geo_common_s common;		/* No additional fields needed */
+};
+
+struct geo_iocntl_s {
+	struct geo_common_s common;		/* No additional fields needed */
+};
+
+struct geo_pcicard_s {
+	struct geo_iocntl_s common;
+	char bus;				/* Bus/widget number */
+	char slot;				/* PCI slot number */
+};
+
+/* Subcomponents of a node */
+struct geo_cpu_s {
+	struct geo_node_s node;
+	unsigned char	socket:4,	/* Which CPU on the node */
+			thread:4;
+	unsigned char	core;
+};
+
+struct geo_mem_s {
+	struct geo_node_s node;
+	char membus;			/* The memory bus on the node */
+	char memslot;			/* The memory slot on the bus */
+};
+
+union geoid_u {
+	struct geo_common_s common;
+	struct geo_node_s node;
+	struct geo_iocntl_s iocntl;
+	struct geo_pcicard_s pcicard;
+	struct geo_rtr_s rtr;
+	struct geo_cpu_s cpu;
+	struct geo_mem_s mem;
+	char padsize[GEOID_SIZE];
+};
+
+/* Defined constants */
+
+#define GEO_MAX_LEN	48
+
+#define GEO_TYPE_INVALID	0
+#define GEO_TYPE_MODULE		1
+#define GEO_TYPE_NODE		2
+#define GEO_TYPE_RTR		3
+#define GEO_TYPE_IOCNTL		4
+#define GEO_TYPE_IOCARD		5
+#define GEO_TYPE_CPU		6
+#define GEO_TYPE_MEM		7
+#define GEO_TYPE_MAX		(GEO_TYPE_MEM+1)
+
+static inline int geo_rack(union geoid_u g)
+{
+	return (g.common.type == GEO_TYPE_INVALID) ?
+		-1 : g.common.rack;
+}
+
+static inline int geo_slot(union geoid_u g)
+{
+	return (g.common.type == GEO_TYPE_INVALID) ?
+		-1 : g.common.upos;
+}
+
+static inline int geo_blade(union geoid_u g)
+{
+	return (g.common.type == GEO_TYPE_INVALID) ?
+		-1 : g.common.blade * 2 + g.common.slot;
+}
+
+#endif /* _ASM_UV_GEO_H */
diff --git a/arch/x86/platform/uv/bios_uv.c b/arch/x86/platform/uv/bios_uv.c
index 54511ea..bf31af3 100644
--- a/arch/x86/platform/uv/bios_uv.c
+++ b/arch/x86/platform/uv/bios_uv.c
@@ -72,6 +72,7 @@ static s64 uv_bios_call_irqsave(enum uv_bios_cmd which, u64 a1, u64 a2, u64 a3,
 long sn_partition_id;
 EXPORT_SYMBOL_GPL(sn_partition_id);
 long sn_coherency_id;
+EXPORT_SYMBOL_GPL(sn_coherency_id);
 long sn_region_size;
 EXPORT_SYMBOL_GPL(sn_region_size);
 long system_serial_number;
@@ -171,6 +172,60 @@ int uv_bios_set_legacy_vga_target(bool decode, int domain, int bus)
 				(u64)decode, (u64)domain, (u64)bus, 0, 0);
 }
 
+extern s64 uv_bios_get_master_nasid(u64 size, u64 *master_nasid)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, 0, UV_BIOS_EXTRA_MASTER_NASID, 0,
+				size, (u64)master_nasid);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_master_nasid);
+
+extern s64 uv_bios_get_heapsize(u64 nasid, u64 size, u64 *heap_size)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_GET_HEAPSIZE,
+				0, size, (u64)heap_size);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_heapsize);
+
+extern s64 uv_bios_install_heap(u64 nasid, u64 heap_size, u64 *bios_heap)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_INSTALL_HEAP,
+				0, heap_size, (u64)bios_heap);
+}
+EXPORT_SYMBOL_GPL(uv_bios_install_heap);
+
+extern s64 uv_bios_obj_count(u64 nasid, u64 size, u64 *objcnt)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_OBJECT_COUNT,
+				0, size, (u64)objcnt);
+}
+EXPORT_SYMBOL_GPL(uv_bios_obj_count);
+
+extern s64 uv_bios_enum_objs(u64 nasid, u64 size, u64 *objbuf)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_OBJECTS,
+				0, size, (u64)objbuf);
+}
+EXPORT_SYMBOL_GPL(uv_bios_enum_objs);
+
+extern s64 uv_bios_enum_ports(u64 nasid, u64 obj_id, u64 size, u64 *portbuf)
+{
+	return uv_bios_call(UV_BIOS_EXTRA, nasid, UV_BIOS_EXTRA_ENUM_PORTS,
+				obj_id, size, (u64)portbuf);
+}
+EXPORT_SYMBOL_GPL(uv_bios_enum_ports);
+
+extern s64 uv_bios_get_geoinfo(u64 nasid, u64 size, u64 *buf)
+{
+	return uv_bios_call(UV_BIOS_GET_GEOINFO, nasid, (u64)buf, size, 0, 0);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_geoinfo);
+
+extern s64 uv_bios_get_pci_topology(u64 size, u64 *buf)
+{
+	return uv_bios_call(UV_BIOS_GET_PCI_TOPOLOGY, (u64)buf, size, 0, 0, 0);
+}
+EXPORT_SYMBOL_GPL(uv_bios_get_pci_topology);
+
 unsigned long get_uv_systab_phys(bool msg)
 {
 	if ((uv_systab_phys == EFI_INVALID_TABLE_ADDR) ||
