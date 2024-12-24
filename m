Return-Path: <linux-tip-commits+bounces-3117-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AEFD9FBB99
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 10:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA80B1887109
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Dec 2024 09:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B3D21BC9E6;
	Tue, 24 Dec 2024 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="taMzubCq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JTK1ZYpw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FF101AF0B5;
	Tue, 24 Dec 2024 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735033709; cv=none; b=npU7EYAXYBq7Dmzb4xaEcKCYkE6uDo6hmeF71ASb3IywWZUBCznPRf1l5wm7Sut8NnoqIVx+0ehCliogrN93BEBQz8jVa0FmbSRtDWOMUv4oYb/PaWXHtW90VPud10+ogtsmROwxguVai1AA9utK08d4OQdztoseMNOYxwJHX9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735033709; c=relaxed/simple;
	bh=22iAy2/XKLBhJQSzDZfBjzejJHSoAuIsqdw+64hlE3o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dz4u/OKnkoM0Z8V64Aft054pNUTsPSFDXZv83pUmYTmoToHSmH3hW7rNxQBfDta7pqpH4Ywh09O1Gq7GI9y/NFx/rztWKUJZwjVIgOcJsqWUolarcmCaaEA19UDvsrusRBL9kWq16o5T/k9ffrxQb9kkg1ep5IJBNCbnfhTNQCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=taMzubCq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JTK1ZYpw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Dec 2024 09:48:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735033705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5b/Tg3Z0w4aDSSMHU24ONIVfAW0WD7Q2RtpG23iHRm8=;
	b=taMzubCqbuXuJG0SfxoDrC28RdWczj94vCPcGqFjntjJvyasZj9zTCTgZ1G80s9sMS0YeS
	ur4pXiS0+1MxHaCcyg00fs3RyuwaeWAqTO4uombecipTIAuJahUSQRbF9kBMp/TWG2gu5o
	uO7G+ci7ebjp0zQ123QgDVcm5U9gN/q3Pi78Q+lxBMDDhONZ+Xn5XZygUcE54rsb/AzEIB
	4VBqmEQTvU7LCuYSLH86FSXaGBNrCHdDKcMUXz9CrF3R57aRYYsv9RfmRL76rV8zMLNyWu
	aChQNJy0VT3C3bZ8QQw6eHqCorMBcco1u/kGyNqPE3feFGEATc4gRIsgRGn1gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735033705;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=5b/Tg3Z0w4aDSSMHU24ONIVfAW0WD7Q2RtpG23iHRm8=;
	b=JTK1ZYpw70tSZQm32Dhd3XNnuzHweWkpUgcX/aUVQw59wUiIMfkEpZFdGQAquJpDG/KKr2
	SYPCUz6Ph5Mjx1CA==
From: "tip-bot2 for Kai Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/virt/tdx: Require the module to assert it has the
 NO_RBP_MOD mitigation
Cc: Kai Huang <kai.huang@intel.com>, Dave Hansen <dave.hansen@linux.intel.com>,
 Nikolay Borisov <nik.borisov@suse.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Dan Williams <dan.j.williams@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173503370499.399.255333079423628939.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     6f5c71cc42d49203771bceed91a023d4dbec54f4
Gitweb:        https://git.kernel.org/tip/6f5c71cc42d49203771bceed91a023d4dbec54f4
Author:        Kai Huang <kai.huang@intel.com>
AuthorDate:    Sun, 15 Dec 2024 04:15:47 +13:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 14:36:02 -08:00

x86/virt/tdx: Require the module to assert it has the NO_RBP_MOD mitigation

Old TDX modules can clobber RBP in the TDH.VP.ENTER SEAMCALL.  However
RBP is used as frame pointer in the x86_64 calling convention, and
clobbering RBP could result in bad things like being unable to unwind
the stack if any non-maskable exceptions (NMI, #MC etc) happens in that
gap.

A new "NO_RBP_MOD" feature was introduced to more recent TDX modules to
not clobber RBP.  KVM will need to use the TDH.VP.ENTER SEAMCALL to run
TDX guests.  It won't be safe to run TDX guests w/o this feature.  To
prevent it, just don't initialize the TDX module if this feature is not
supported [1].

Note the bit definitions of TDX_FEATURES0 are not auto-generated in
tdx_global_metadata.h.  Manually define a macro for it in "tdx.h".

Signed-off-by: Kai Huang <kai.huang@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Link: https://lore.kernel.org/fc0e8ab7-86d4-4428-be31-82e1ece6dd21@intel.com/ [1]
Link: https://lore.kernel.org/all/76ae5025502c84d799e3a56a6fc4f69a82da8f93.1734188033.git.kai.huang%40intel.com
---
 arch/x86/virt/vmx/tdx/tdx.c | 17 +++++++++++++++++
 arch/x86/virt/vmx/tdx/tdx.h |  4 ++++
 2 files changed, 21 insertions(+)

diff --git a/arch/x86/virt/vmx/tdx/tdx.c b/arch/x86/virt/vmx/tdx/tdx.c
index 43ec56d..7fdb373 100644
--- a/arch/x86/virt/vmx/tdx/tdx.c
+++ b/arch/x86/virt/vmx/tdx/tdx.c
@@ -272,6 +272,18 @@ static int read_sys_metadata_field(u64 field_id, u64 *data)
 
 #include "tdx_global_metadata.c"
 
+static int check_features(struct tdx_sys_info *sysinfo)
+{
+	u64 tdx_features0 = sysinfo->features.tdx_features0;
+
+	if (!(tdx_features0 & TDX_FEATURES0_NO_RBP_MOD)) {
+		pr_err("frame pointer (RBP) clobber bug present, upgrade TDX module\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 /* Calculate the actual TDMR size */
 static int tdmr_size_single(u16 max_reserved_per_tdmr)
 {
@@ -1055,6 +1067,11 @@ static int init_tdx_module(void)
 	if (ret)
 		return ret;
 
+	/* Check whether the kernel can support this module */
+	ret = check_features(&sysinfo);
+	if (ret)
+		return ret;
+
 	/*
 	 * To keep things simple, assume that all TDX-protected memory
 	 * will come from the page allocator.  Make sure all pages in the
diff --git a/arch/x86/virt/vmx/tdx/tdx.h b/arch/x86/virt/vmx/tdx/tdx.h
index 641beec..4e3d533 100644
--- a/arch/x86/virt/vmx/tdx/tdx.h
+++ b/arch/x86/virt/vmx/tdx/tdx.h
@@ -2,6 +2,7 @@
 #ifndef _X86_VIRT_TDX_H
 #define _X86_VIRT_TDX_H
 
+#include <linux/bits.h>
 #include "tdx_global_metadata.h"
 
 /*
@@ -51,6 +52,9 @@ struct tdmr_info {
 	DECLARE_FLEX_ARRAY(struct tdmr_reserved_area, reserved_areas);
 } __packed __aligned(TDMR_INFO_ALIGNMENT);
 
+/* Bit definitions of TDX_FEATURES0 metadata field */
+#define TDX_FEATURES0_NO_RBP_MOD	BIT(18)
+
 /*
  * Do not put any hardware-defined TDX structure representations below
  * this comment!

