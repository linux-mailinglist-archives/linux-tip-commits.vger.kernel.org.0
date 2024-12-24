Return-Path: <linux-tip-commits+bounces-3120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBEA9FBBA2
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:55:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B9A31887267
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:51:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9308D1D9350;
	Tue, 24 Dec 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LA+mKSZv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="olQt/uEH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A601B3936;
	Tue, 24 Dec 2024 09:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033710; cv=none; b=pCyJiyHVTtHzvMGp8O7GWnzITKMKTeEgXVrkRYERg89mLPSlMDUdlLrHUFILzQDHZC5/p0VKs6IxMsbzAFLZVTOtExs+xghtEW26H2ptPF4ydXZ+BPac1e4CFWhZYvVge1jNLH5u3uLOEjTM4WAKP+lea4EUX1avo6sbOm0q9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033710; c=relaxed/simple;
	bh=vnZsVJqk9hJ6roDy0yGKWOOeWtXuDz+m9uiye4YKyRY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=oYQwOKWgzzWWaxz4EA3kMnu6rllMfImHtyAASkmEsB7GXn1DaTyqF+qgpTficen0Qs7t1bzevfOk7/ZvnMaFbhBgkcE/xi1yABTMa16mANxTcBPwJtqwrZgit4/aAEWtjwnPo2QaM66sTxNep7mf5EUdSSCSCihL/oNE7RySwuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LA+mKSZv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=olQt/uEH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BERCrygVsOtyyiF/77ZkX4mumK3OTqwa/ZW695FV5ZU=;
	b=LA+mKSZvrvdTuuRNFKVuzzjwsIwvgWzU3D4HBio6AmTglYURdLT+tpMcPN5W2QGwImz915
	zdlbzwWQrPkrRAMVhoNcZ4m+p/tAj96VLGhik/SihRv9CLCMH8wecunMvIcAgI9yjymc9O
	herzOXpZYVILGkYx1N36Zc8tIgo5vppYVZkhpCAlCI8YGPOWCWHJpz8J4dksX2ltATNwnc
	oacxB5526PjHkBrTBY4VQ4QXfsMurzjd/O69IlQfC+dzZBdPHynVIk1RByDwvJi7F/Ias2
	1ugnxgR4WZrHXEbos0pqoG+xQg5pAYWS80IkhyULnAWPt5i30GuEWSBqltNSSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BERCrygVsOtyyiF/77ZkX4mumK3OTqwa/ZW695FV5ZU=;
	b=olQt/uEHOEliZaxCdX2qvIlJIISqeyOplJpqq7eiXtvEMeC/T/JGsd2dgRL562Lu3eH+ZV
	A4E+CxPzNirwznCQ==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Start to track all global metadata in
 one structure
Cc: Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503370653.399.5971602278767340142.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     c4e0862a62c059498000914305ae60f9cbd0818a
Gitweb:        https://git.kernel.org/tip/c4e0862a62c059498000914305ae60f9cbd0818a
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 15 Dec 2024 04:15:43 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 14:36:01 -08:00

x86/virt/tdx: Start to track all global metadata in one structure

The TDX module provides a set of "Global Metadata Fields".  They report
things like TDX module version, supported features, and fields related
to create/run TDX guests and so on.

Today the kernel only reads "TD Memory Region" (TDMR) related fields for
module initialization.  KVM will need to read additional metadata fields
to run TDX guests.  Move towards having the TDX host core-kernel provide
a centralized, canonical, and immutable structure for the global
metadata that comes out from the TDX module for all kernel components to
use.

As the first step, introduce a new 'struct tdx_sys_info' to track all
global metadata fields.

TDX categorizes global metadata fields into different "Classes".  E.g.,
the TDMR related fields are under class "TDMR Info".  Instead of making
'struct tdx_sys_info' a plain structure to contain all metadata fields,
organize them in smaller structures based on the "Class".

This allows those metadata fields to be used in finer granularity thus
makes the code clearer.  E.g., construct_tdmrs() can just take the
structure which contains "TDMR Info" metadata fields.

Add get_tdx_sys_info() as the placeholder to read all metadata fields.
Have it only call get_tdx_sys_info_tdmr() to read TDMR related fields
for now.

Place get_tdx_sys_info() as the first step of init_tdx_module() to
enable early prerequisite checks on the metadata to support early module
initialization abort.  This results in moving get_tdx_sys_info_tdmr() to
be before build_tdx_memlist(), but this is fine because there are no
dependencies between these two functions.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/all/bfacb4e90527cf79d4be0d1753e6f318eea21118.1734188033.git.kai.huang%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 19 ++++++++++++-------
 arch/x86/virt/vmx/tdx/tdx.h | 19 ++++++++++++-------
 2 files changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index e979bf4..7a2f979 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -326,6 +326,11 @@ static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 	return 0;
 }
 
+static int get_tdx_sys_info(struct tdx_sys_info *sysinfo)
+{
+	return get_tdx_sys_info_tdmr(&sysinfo->tdmr);
+}
+
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
 {
@@ -1098,9 +1103,13 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 
 static int init_tdx_module(void)
 {
-	struct tdx_sys_info_tdmr sysinfo_tdmr;
+	struct tdx_sys_info sysinfo;
 	int ret;
 
+	ret = get_tdx_sys_info(&sysinfo);
+	if (ret)
+		return ret;
+
 	/*
 	 * To keep things simple, assume that all TDX-protected memory
 	 * will come from the page allocator.  Make sure all pages in the
@@ -1117,17 +1126,13 @@ static int init_tdx_module(void)
 	if (ret)
 		goto out_put_tdxmem;
 
-	ret = get_tdx_sys_info_tdmr(&sysinfo_tdmr);
-	if (ret)
-		goto err_free_tdxmem;
-
 	/* Allocate enough space for constructing TDMRs */
-	ret = alloc_tdmr_list(&tdx_tdmr_list, &sysinfo_tdmr);
+	ret = alloc_tdmr_list(&tdx_tdmr_list, &sysinfo.tdmr);
 	if (ret)
 		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
-	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo_tdmr);
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo.tdmr);
 	if (ret)
 		goto err_free_tdmrs;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 148f9b4..2600ec3 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -80,6 +80,18 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
+/* Class "TDMR info" */
+struct tdx_sys_info_tdmr {
+	u16 max_tdmrs;
+	u16 max_reserved_per_tdmr;
+	u16 pamt_entry_size[TDX_PS_NR];
+};
+
+/* Kernel used global metadata fields */
+struct tdx_sys_info {
+	struct tdx_sys_info_tdmr tdmr;
+};
+
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!
@@ -99,13 +111,6 @@ struct tdx_memblock {
 	int nid;
 };
 
-/* "TDMR info" part of "Global Scope Metadata" for constructing TDMRs */
-struct tdx_sys_info_tdmr {
-	u16 max_tdmrs;
-	u16 max_reserved_per_tdmr;
-	u16 pamt_entry_size[TDX_PS_NR];
-};
-
 /* Warn if kernel has less than TDMR_NR_WARN TDMRs after allocation */
 #define TDMR_NR_WARN 4
 

