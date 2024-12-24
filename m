Return-Path: <linux-tip-commits+bounces-3119-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F1D9FBB87
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:51:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11CF97A0422
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74FE1BD014;
	Tue, 24 Dec 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rj00ZXHZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+I1lCiU1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCE031B3935;
	Tue, 24 Dec 2024 09:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033709; cv=none; b=orxO4o2h/6piSxqCnAVZpvw0JNQ7n6Heccl/JvGqQWH9vqjIIRL9/9aqnGlN6hp7Li7A4SNWOZgWS1evvf+N0XIeTpphHaQRkEJgX3FqmozwelM9h068YGU5fSS3AntMqOPagP46Gibx+hXRFP4gXOjYOpRtHNzOHuL7LQHElqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033709; c=relaxed/simple;
	bh=BsMkI9zFblEL/5/jhkEAOsAblEteZiktRByY3luIe4Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BP+1/bu7XV4EUVdYJA6+X0TjfkOQ6XB+a1xWRwh3wybivLCtOJ1abcZHrTI/tQ2xLEaeJ0tvJ58WgNEqLYx3CJLPDGujMA+cXTDvBd81nkYZIG6KeIti2PBm7J94sgirBgo2Ls70bIUiKSNxDHEmjGwvKbkjihQHLiz/khE1lsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rj00ZXHZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+I1lCiU1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:48:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=k/NuajBtvCdqyZoUoya7a4DW9JnOO2gUK9wBZ9CiKQM=;
	b=rj00ZXHZ/fvNYPK23g8R+hYdtzZK5PDyduWk3b+06j7YDVs1wLKxeArTSwrgX4a0GjsLcz
	Yg50bLI13IccTpj171KJAUHmcoCgEo9QdJ6e/q5zkssQKE5FpMF/fWlChxgCLIrLxbrPQx
	mlTwN713jVmmBzaeOXkYKPb72OI/ORZn5WmbhdgcXTTnwGenR/KAQcmE0dFG+DTKyl+eEw
	Hqubh7+DQsuaSrCnABtGnsDdIhM8b0m86uYctaAk6sphOSuVrvEBHnEE5H+KBc2UWkuE7g
	2hcLPGePPDLzMny6GpMv2peYwpVMVKFX1OGVJ3JyV15N5cfdd/tvLRlB4ZoT8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033706;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=k/NuajBtvCdqyZoUoya7a4DW9JnOO2gUK9wBZ9CiKQM=;
	b=+I1lCiU1mXqanx+AR/knpk8ytniIt4FLOSThFYxdWK3qb5oydzJ+QUg+2HWuiZSQi/Rq0m
	QToWJzovZ1oJQDAA==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Use dedicated struct members for PAMT
 entry sizes
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
Message-ID: <173503370579.399.10433282365241242968.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     6bfb77f4893f9809fd1dc3591c8b343534c87a65
Gitweb:        https://git.kernel.org/tip/6bfb77f4893f9809fd1dc3591c8b343534c87a65
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 15 Dec 2024 04:15:45 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 14:36:02 -08:00

x86/virt/tdx: Use dedicated struct members for PAMT entry sizes

Currently, the 'struct tdmr_sys_info_tdmr' which includes TDMR related
fields defines the PAMT entry sizes for TDX supported page sizes (4KB,
2MB and 1GB) as an array:

	struct tdx_sys_info_tdmr {
		...
		u16 pamt_entry_sizes[TDX_PS_NR];
	};

PAMT entry sizes are needed when allocating PAMTs for each TDMR.  Using
the array to contain PAMT entry sizes reduces the number of arguments
that need to be passed when calling tdmr_set_up_pamt().  It also makes
the code pattern like below clearer:

	for (pgsz = TDX_PS_4K; pgsz < TDX_PS_NR; pgsz++) {
		pamt_size[pgsz] = tdmr_get_pamt_sz(tdmr, pgsz,
					pamt_entry_size[pgsz]);
		tdmr_pamt_size += pamt_size[pgsz];
	}

However, the auto-generated metadata reading code generates a structure
member for each field.  The 'global_metadata.json' has a dedicated field
for each PAMT entry size, and the new 'struct tdx_sys_info_tdmr' looks
like:

	struct tdx_sys_info_tdmr {
		...
		u16 pamt_4k_entry_size;
		u16 pamt_2m_entry_size;
		u16 pamt_1g_entry_size;
	};

Prepare to use the autogenerated code by making the existing 'struct
tdx_sys_info_tdmr' look like the generated one.  When passing to
tdmrs_set_up_pamt_all(), build a local array of PAMT entry sizes from
the structure so the code to allocate PAMTs can stay the same.

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/all/ccf46f3dacb01be1fb8309592616d443ac17caba.1734188033.git.kai.huang%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 14 +++++++++-----
 arch/x86/virt/vmx/tdx/tdx.h |  4 +++-
 2 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 7a2f979..28537a6 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -304,9 +304,9 @@ struct field_mapping {
 static const struct field_mapping fields[] = {
 	TD_SYSINFO_MAP(MAX_TDMRS,	      max_tdmrs),
 	TD_SYSINFO_MAP(MAX_RESERVED_PER_TDMR, max_reserved_per_tdmr),
-	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_entry_size[TDX_PS_4K]),
-	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_entry_size[TDX_PS_2M]),
-	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_entry_size[TDX_PS_1G]),
+	TD_SYSINFO_MAP(PAMT_4K_ENTRY_SIZE,    pamt_4k_entry_size),
+	TD_SYSINFO_MAP(PAMT_2M_ENTRY_SIZE,    pamt_2m_entry_size),
+	TD_SYSINFO_MAP(PAMT_1G_ENTRY_SIZE,    pamt_1g_entry_size),
 };
 
 static int get_tdx_sys_info_tdmr(struct tdx_sys_info_tdmr *sysinfo_tdmr)
@@ -932,14 +932,18 @@ static int construct_tdmrs(struct list_head *tmb_list,
 			   struct tdmr_info_list *tdmr_list,
 			   struct tdx_sys_info_tdmr *sysinfo_tdmr)
 {
+	u16 pamt_entry_size[TDX_PS_NR] = {
+		sysinfo_tdmr->pamt_4k_entry_size,
+		sysinfo_tdmr->pamt_2m_entry_size,
+		sysinfo_tdmr->pamt_1g_entry_size,
+	};
 	int ret;
 
 	ret = fill_out_tdmrs(tmb_list, tdmr_list);
 	if (ret)
 		return ret;
 
-	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list,
-			sysinfo_tdmr->pamt_entry_size);
+	ret = tdmrs_set_up_pamt_all(tdmr_list, tmb_list, pamt_entry_size);
 	if (ret)
 		return ret;
 
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 2600ec3..ec879d5 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -84,7 +84,9 @@ struct tdmr_info {
 struct tdx_sys_info_tdmr {
 	u16 max_tdmrs;
 	u16 max_reserved_per_tdmr;
-	u16 pamt_entry_size[TDX_PS_NR];
+	u16 pamt_4k_entry_size;
+	u16 pamt_2m_entry_size;
+	u16 pamt_1g_entry_size;
 };
 
 /* Kernel used global metadata fields */

