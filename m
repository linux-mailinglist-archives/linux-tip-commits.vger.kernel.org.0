Return-Path: <linux-tip-commits+bounces-3121-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DB3549FBBA5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACE6F1889366
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D697F1DACB8;
	Tue, 24 Dec 2024 09:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pl7AxqYa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTyXxsSh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D09AE1D9587;
	Tue, 24 Dec 2024 09:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033712; cv=none; b=r1mFEE/yb9EwoXvzHOBtgp4imGrIctWgj/KIpBeLnU9gzg+rASHyPCzIjgP+cX5gZ8XzxQGnbsZKroVtuYumz7v05X9mWaXbUWqmuoafq3qsjpsY1V2XYgxiEY0AePazhH0JfdKutDc2+kxtZ88cq8NkLn7NBL8I74bKYhtlTPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033712; c=relaxed/simple;
	bh=44DPz2XHzSvYhepcA/mwVWhScUQXBHUoOAv0Uk2szVA=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=JnsQ2uJnn0SJmzU656DwsmYCtFqRtWSxBFJgNWQbfrcb9p/chTWgMAmKmsBv1voICNXHWKmTDPg/V18m3kGTPFR4/CQOrSp2p4k98YOJTGuC+Y9lYsTrEMdBO+Ko89LnXiv0LV5toq40itM8P6+NKXwrERu1f2WYAp6rMWxqLA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pl7AxqYa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTyXxsSh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GHDdo63kt/IilYM4pilKUge2HTifaE+9eF+JhXHgsJY=;
	b=pl7AxqYaTZCH3vnF8zNx3r0ORP8hpp/cv37QTsJ/TLavt8x6R/9lYwm7intX2U81L3kg82
	DSnuPt8v1gMClDovs8q4xLM79+dzmqiVp1yIBacy+S3Pt5fnbz1Noe0cMkN3bqiQU3FXqT
	FWbW0/BkGBSc5gqbVgbhwc4qEwIWzJFWFmdjSpkodxr1N1jzI4dx2ntZQ4GC7+prkpRwsv
	WPw9447kA9wyf99gcM09R4jHftvGZthRB11G+ZDU35TTTwG86Sp2AR6SIugYmIVctjYrxr
	1/Wag5gPqWQ4zzWd+XBRQPSsivOozO7KVZe0JFr7ezPRDSFW+N8xdKWPZXuNyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033707;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GHDdo63kt/IilYM4pilKUge2HTifaE+9eF+JhXHgsJY=;
	b=aTyXxsSh1QVXcl4L/ff8fjb/c2sjPiLa8eube3bgc1nUI7qMBQ/pfp6++qVYVyjaw//I8i
	hinq489gdWGn0UAw==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Rename 'struct tdx_tdmr_sysinfo' to
 reflect the spec better
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
Message-ID: <173503370684.399.6660572223024391287.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     e8aa393b0ada3b5ce1b3e8475b02e90e5dce6841
Gitweb:        https://git.kernel.org/tip/e8aa393b0ada3b5ce1b3e8475b02e90e5dce6841
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 15 Dec 2024 04:15:42 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 14:36:01 -08:00

x86/virt/tdx: Rename 'struct tdx_tdmr_sysinfo' to reflect the spec better

The TDX module provides a set of "Global Metadata Fields".  They report
things like TDX module version, supported features, and fields related
to create/run TDX guests and so on.

TDX organizes those metadata fields by "Classes" based on the meaning of
those fields.  E.g., for now the kernel only reads "TD Memory Region"
(TDMR) related fields for module initialization.  Those fields are
defined under class "TDMR Info".

Today the kernel reads some of the global metadata to initialize the TDX
module.  KVM will need to read additional metadata fields to run TDX
guests.  Move towards having the TDX host core-kernel provide a
centralized, canonical, and immutable structure for the global metadata
that comes out from the TDX module for all kernel components to use.

More specifically, prepare the code to end up with an organization like:

       struct tdx_sys_info {
	       struct tdx_sys_info_classA a;
	       struct tdx_sys_info_classB b;
	       ...
       };

Currently the kernel organizes all fields under "TDMR Info" class in
'struct tdx_tdmr_sysinfo'.  Prepare for the above by renaming the
structure to 'struct tdx_sys_info_tdmr' to follow the class name better.

No functional change intended.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/all/de165d09e0b571cfeb119a368f4be6e2888ebb93.1734188033.git.kai.huang%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 36 ++++++++++++++++++------------------
 arch/x86/virt/vmx/tdx/tdx.h |  2 +-
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 4e2b2e2..e979bf4 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -272,7 +272,7 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 
 static int read_sys_metadata_field16(u64 field_id,
 				     int offset,
-				     struct tdx_tdmr_sysinfo *ts)
+				     struct tdx_sys_info_tdmr *ts)
 {
 	u16 *ts_member = ((void *)ts) + offset;
 	u64 tmp;
@@ -298,9 +298,9 @@ struct field_mapping {
 
 #define TD_SYSINFO_MAP(_field_id, _offset) \
 	{ .field_id = MD_FIELD_ID_##_field_id,	   \
-	  .offset   = offsetof(struct tdx_tdmr_sysinfo, _offset) }
+	  .offset   = offsetof(struct tdx_sys_info_tdmr, _offset) }
 
-/* Map TD_SYSINFO fields into 'struct tdx_tdmr_sysinfo': */
+/* Map TD_SYSINFO fields into 'struct tdx_sys_info_tdmr': */
 static const struct field_mapping fields[] = {
 	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
 	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
@@ -309,16 +309,16 @@ static const struct field_mapping fields[] = {
 	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
 };
 
-static int get_tdx_tdmr_sysinfo(struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret;
 	int i;
 
-	/* Populate 'tdmr_sysinfo' fields using the mapping structure above: */
+	/* Populate 'sysinfo_tdmr' fields using the mapping structure above: */
 	for (i = 0; i < ARRAY_SIZE(fields); i++) {
 		ret = read_sys_metadata_field16(fields[i].field_id,
 						fields[i].offset,
-						tdmr_sysinfo);
+						sysinfo_tdmr);
 		if (ret)
 			return ret;
 	}
@@ -342,13 +342,13 @@ static int tdmr_size_single(u16 max_reserved_per_tdmr)
 }
 
 static int alloc_tdmr_list(struct tdmr_info_list *tdmr_list,
-			   struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	size_t tdmr_sz, tdmr_array_sz;
 	void *tdmr_array;
 
-	tdmr_sz = tdmr_size_single(tdmr_sysinfo->max_reserved_per_tdmr);
-	tdmr_array_sz = tdmr_sz * tdmr_sysinfo->max_tdmrs;
+	tdmr_sz = tdmr_size_single(sysinfo_tdmr->max_reserved_per_tdmr);
+	tdmr_array_sz = tdmr_sz * sysinfo_tdmr->max_tdmrs;
 
 	/*
 	 * To keep things simple, allocate all TDMRs together.
@@ -367,7 +367,7 @@ static int alloc_tdmr_list(struct tdmr_info_list *tdmr_list,
 	 * at a given index in the TDMR list.
 	 */
 	tdmr_list->tdmr_sz = tdmr_sz;
-	tdmr_list->max_tdmrs = tdmr_sysinfo->max_tdmrs;
+	tdmr_list->max_tdmrs = sysinfo_tdmr->max_tdmrs;
 	tdmr_list->nr_consumed_tdmrs = 0;
 
 	return 0;
@@ -921,11 +921,11 @@ static int tdmrs_populate_rsvd_areas_all(struct tdmr_info_list *tdmr_list,
 /*
  * Construct a list of TDMRs on the preallocated space in @tdmr_list
  * to cover all TDX memory regions in @tmb_list based on the TDX module
- * TDMR global information in @tdmr_sysinfo.
+ * TDMR global information in @sysinfo_tdmr.
  */
 static int construct_tdmrs(struct list_head *tmb_list,
 			   struct tdmr_info_list *tdmr_list,
-			   struct tdx_tdmr_sysinfo *tdmr_sysinfo)
+			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
 	int ret;
 
@@ -934,12 +934,12 @@ static int construct_tdmrs(struct list_head *tmb_list,
 		return ret;
 
 	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list,
-			tdmr_sysinfo->pamt_entry_size);
+			sysinfo_tdmr->pamt_entry_size);
 	if (ret)
 		return ret;
 
 	ret = tdmrs_populate_rsvd_areas_all(tdmr_list, tmb_list,
-			tdmr_sysinfo->max_reserved_per_tdmr);
+			sysinfo_tdmr->max_reserved_per_tdmr);
 	if (ret)
 		tdmrs_free_pamt_all(tdmr_list);
 
@@ -1098,7 +1098,7 @@ static int init_tdmrs(struct tdmr_info_list *tdmr_list)
 
 static int init_tdx_module(void)
 {
-	struct tdx_tdmr_sysinfo tdmr_sysinfo;
+	struct tdx_sys_info_tdmr sysinfo_tdmr;
 	int ret;
 
 	/*
@@ -1117,17 +1117,17 @@ static int init_tdx_module(void)
 	if (ret)
 		goto out_put_tdxmem;
 
-	ret = get_tdx_tdmr_sysinfo(&tdmr_sysinfo);
+	ret = get_tdx_sys_info_tdmr(&sysinfo_tdmr);
 	if (ret)
 		goto err_free_tdxmem;
 
 	/* Allocate enough space for constructing TDMRs */
-	ret = alloc_tdmr_list(&tdx_tdmr_list, &tdmr_sysinfo);
+	ret = alloc_tdmr_list(&tdx_tdmr_list, &sysinfo_tdmr);
 	if (ret)
 		goto err_free_tdxmem;
 
 	/* Cover all TDX-usable memory regions in TDMRs */
-	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &tdmr_sysinfo);
+	ret = construct_tdmrs(&tdx_memlist, &tdx_tdmr_list, &sysinfo_tdmr);
 	if (ret)
 		goto err_free_tdmrs;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index b701f69..148f9b4 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -100,7 +100,7 @@ struct tdx_memblock {
 };
 
 /* "TDMR info" part of "Global Scope Metadata" for constructing TDMRs */
-struct tdx_tdmr_sysinfo {
+struct tdx_sys_info_tdmr {
 	u16 max_tdmrs;
 	u16 max_reserved_per_tdmr;
 	u16 pamt_entry_size[TDX_PS_NR];

