Return-Path: <linux-tip-commits+bounces-3118-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA93D9FBB9B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:54:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 533FA1885E0C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:51:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A45D1BCA07;
	Tue, 24 Dec 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AGTX+Tng";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FvurLimY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF621B2184;
	Tue, 24 Dec 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033709; cv=none; b=mP3lA+mBDe7i8uf4MmYryErEN5iUfZPYJuSm+kirDUdNa1xBGwrPxC9g6gP1qw8DCrF9LYJ9iIdSSHN0BEDAEzH6FNGq2qZip/qUJb1uW42IBQzJjm/Pbzf0J3opjf75PSlSE5i4X1pZoH9CW+ZRv3I5n8i6ogRJyvL+sKZFvyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033709; c=relaxed/simple;
	bh=O+rmltMe/dtZ9z6TJhDTB/SGswRg3Oay6ok9d/8eKTU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Jp5IX7iSVmGsxRGbG9CUTaGgOkCEb0cgZpKayWazXFR9qoS0bORYtrv9YcYDS8XTtWgWtdolu6jikkUY1MpbQNV9kQX94XCaKLfCVNJlqB8HbWrtA94MBj/uk8Jmn6R8y5de+qxyDc7/cQq+q7Cgtk5HwRZrBtjURwb+UzMeREs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AGTX+Tng; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FvurLimY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:48:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9Vck0T0o6udtt5RmIZAuWknnGlrJ9DbkAZ/P8oeLZP4=;
	b=AGTX+TngK7EDLxfiVr2eujcjcjrBVNFqN9LG9FSl0FPDBjSMOtPU8IQPrMBA5KNvjHSy6Q
	auLgEVk61x/wgyOQTQj7cZQMoVolVS2CXMraXunA1JUwoOcQmjE9skrZM4+oCKw5Cd934z
	Q8UdcLZHbXI4tSZmm66lwSMlSLdIAWj3vkORNVCPFPtjeZcjNdagZgyQbqFdzBMe8Wtmdx
	k7jwpJC7pIZ3ISt+9oJcwzlki7fa7Ce5YU2kEaN4joOdx41vqkjg3/E6tkHZwKisTp9rxu
	PX06lTPrU8kaDEYI+iwc3dq9cYKYLxQj+/Rx8U8hZN+tcrwen+ljylzniOuUXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=9Vck0T0o6udtt5RmIZAuWknnGlrJ9DbkAZ/P8oeLZP4=;
	b=FvurLimYAHV2D8LKwI+xhFw46/DVO3QKURq+fGDSMIaBW9zbgFBhrydP47EBtxG08VvXNm
	uAdlMJzkjTk/FTCw==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Switch to use auto-generated global
 metadata reading code
Cc: Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503370540.399.17027560156322714019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     fae43b24a6ba8f3def312af371ed86d8ce85e11b
Gitweb:        https://git.kernel.org/tip/fae43b24a6ba8f3def312af371ed86d8ce85e11b
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 15 Dec 2024 04:15:46 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 14:36:02 -08:00

x86/virt/tdx: Switch to use auto-generated global metadata reading code

Continue the process to have a centralized solution for TDX global
metadata reading.  Now that the new autogenerated solution is ready for
use, switch to it and remove the old one.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/all/fc025d1e13b92900323f47cfe9aac3157bf08ee7.1734188033.git.kai.huang%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 61 +------------------------------------
 arch/x86/virt/vmx/tdx/tdx.h | 45 +---------------------------
 2 files changed, 2 insertions(+), 104 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 28537a6..43ec56d 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -270,66 +270,7 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 	return 0;
 }
 
-static int read_sys_metadata_field16(u64 field_id,
-				     int offset,
-				     struct tdx_sys_info_tdmr *ts)
-{
-	u16 *ts_member = ((void *)ts) + offset;
-	u64 tmp;
-	int ret;
-
-	if (WARN_ON_ONCE(MD_FIELD_ID_ELE_SIZE_CODE(field_id) !=
-			MD_FIELD_ID_ELE_SIZE_16BIT))
-		return -EINVAL;
-
-	ret = read_sys_metadata_field(field_id, &tmp);
-	if (ret)
-		return ret;
-
-	*ts_member = tmp;
-
-	return 0;
-}
-
-struct field_mapping {
-	u64 field_id;
-	int offset;
-};
-
-#define TD_SYSINFO_MAP(_field_id, _offset) \
-	{ .field_id = MD_FIELD_ID_##_field_id,	   \
-	  .offset   = offsetof(struct tdx_sys_info_tdmr, _offset) }
-
-/* Map TD_SYSINFO fields into 'struct tdx_sys_info_tdmr': */
-static const struct field_mapping fields[] = {
-	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
-	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
-	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_4k_entry_size),
-	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_2m_entry_size),
-	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_1g_entry_size),
-};
-
-static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
-{
-	int ret;
-	int i;
-
-	/* Populate 'sysinfo_tdmr' fields using the mapping structure above: */
-	for (i = 0; i < ARRAY_SIZE(fields); i++) {
-		ret = read_sys_metadata_field16(fields[i].field_id,
-						fields[i].offset,
-						sysinfo_tdmr);
-		if (ret)
-			return ret;
-	}
-
-	return 0;
-}
-
-static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
-{
-	return get_tdx_sys_info_tdmr(&sysinfo->tdmr);
-}
+#include "tdx_global_metadata.c"
 
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index ec879d5..641beec 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,7 +2,7 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
-#include <linux/bits.h>
+#include "tdx_global_metadata.h"
 
 /*
  * This file contains both macros and data structures defined by the TDX
@@ -26,35 +26,6 @@
 #define	PT_NDA		0x0
 #define	PT_RSVD		0x1
 
-/*
- * Global scope metadata field ID.
- *
- * See Table "Global Scope Metadata", TDX module 1.5 ABI spec.
- */
-#define MD_FIELD_ID_MAX_TDMRS			0x9100000100000008ULL
-#define MD_FIELD_ID_MAX_RESERVED_PER_TDMR	0x9100000100000009ULL
-#define MD_FIELD_ID_PAMT_4K_ENTRY_SIZE		0x9100000100000010ULL
-#define MD_FIELD_ID_PAMT_2M_ENTRY_SIZE		0x9100000100000011ULL
-#define MD_FIELD_ID_PAMT_1G_ENTRY_SIZE		0x9100000100000012ULL
-
-/*
- * Sub-field definition of metadata field ID.
- *
- * See Table "MD_FIELD_ID (Metadata Field Identifier / Sequence Header)
- * Definition", TDX module 1.5 ABI spec.
- *
- *  - Bit 33:32: ELEMENT_SIZE_CODE -- size of a single element of metadata
- *
- *	0: 8 bits
- *	1: 16 bits
- *	2: 32 bits
- *	3: 64 bits
- */
-#define MD_FIELD_ID_ELE_SIZE_CODE(_field_id)	\
-		(((_field_id) & GENMASK_ULL(33, 32)) >> 32)
-
-#define MD_FIELD_ID_ELE_SIZE_16BIT	1
-
 struct tdmr_reserved_area {
 	u64 offset;
 	u64 size;
@@ -80,20 +51,6 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
-/* Class "TDMR info" */
-struct tdx_sys_info_tdmr {
-	u16 max_tdmrs;
-	u16 max_reserved_per_tdmr;
-	u16 pamt_4k_entry_size;
-	u16 pamt_2m_entry_size;
-	u16 pamt_1g_entry_size;
-};
-
-/* Kernel used global metadata fields */
-struct tdx_sys_info {
-	struct tdx_sys_info_tdmr tdmr;
-};
-
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!

