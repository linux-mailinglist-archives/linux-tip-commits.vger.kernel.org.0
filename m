Return-Path: <linux-tip-commits+bounces-2826-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A7C49C0E06
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 19:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD001F22F19
	for <lists+linux-tip-commits@lfdr.de>; Thu,  7 Nov 2024 18:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806AE217305;
	Thu,  7 Nov 2024 18:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PWsCM/ui";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WZi3SjLF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877A213133;
	Thu,  7 Nov 2024 18:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731005169; cv=none; b=DkimWISY93xHvhbXKJaN9Lh2kfcuhLTOdwo9XXm3H0n8+2WU7FCmy4ts4ee7KH4KLVlL8UhfYhhicfR0oTQRs0xASfS461sEHReRtmS4v62RLR+45DUvemz73NVtr7RtFXuKk6KfaedhFHPUIBHQOGnns9rjkFElGaKsIJ1VeNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731005169; c=relaxed/simple;
	bh=2NBwx4zhNiqrbJJzA9AnkMWKu1GmCfhLbEdaWjta6vM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=o6AFu49LojhDRYixmRlkKv+mUbtUgApUd1hx3QZlt0uKEIUnm/pWjM13M9XvRwp3SyeLQkB1nC9IOusaD3kojDBe2ZmWUG7Xf5k82+B5r4f2ON7dDdFhZns/j+L35PcMNykXcneaQjfO1424Fs7PdNDWQetUu8TF8X828rRuQug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PWsCM/ui; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WZi3SjLF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 07 Nov 2024 18:46:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731005165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Cc9jMYKU+OBqae0Xa4TUzPdGRtY7gGLTFxIUWro0ILQ=;
	b=PWsCM/uiNUQyCb6IkLN5bsQfdP6/E8IhWrUrWk6cIHuoLdjUC+4DVQgfa6Z+j+RbtwSYhy
	4wDEOerSzn0A2YCpsiTq+3SpG1XayDPYXdmXW/oeG8Wm/71OO6dvgU8EWNnuCHlhGJcror
	7wP39p3DH0pSI994XQo+SOM8p+Ol1in+E9zxM/Q/Z5xWAe4SsfLA7ewAr7kau1tGUCSbVa
	EMVahO19l9QcfEBk0m6Fx1N2VpfohcfP/G5KkTWH4ktc6qNPKuMI65bl2L9kC37GZnm/nC
	aIhnyENX2y3lx1/Z9hVWv8Qy/FHymsQbMmuSP74M/DDVyd6rB75SmdnF50JaAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731005165;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Cc9jMYKU+OBqae0Xa4TUzPdGRtY7gGLTFxIUWro0ILQ=;
	b=WZi3SjLF448V/quCFiLcLyMzxy/gDcU4N0Vb/V59xEYolao5lrxbyXEOxVEiF+Ma1Buo2N
	uY0ekCATNc5+aQAg==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/tdx] x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Kai Huang <kai.huang@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173100516505.32228.4321733316668401170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     b064043d9565786b385f85e6436ca5716bbd5552
Gitweb:        https://git.kernel.org/tip/b064043d9565786b385f85e6436ca5716bbd5552
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Mon, 04 Nov 2024 12:38:01 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Thu, 07 Nov 2024 10:26:37 -08:00

x86/tdx: Rename tdx_parse_tdinfo() to tdx_setup()

Rename tdx_parse_tdinfo() to tdx_setup() and move setting NOTIFY_ENABLES
there.

The function will be extended to adjust TD configuration.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Kai Huang <kai.huang@intel.com>
Link: https://lore.kernel.org/all/20241104103803.195705-3-kirill.shutemov%40linux.intel.com
---
 arch/x86/coco/tdx/tdx.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/coco/tdx/tdx.c b/arch/x86/coco/tdx/tdx.c
index c74bb9e..28b321a 100644
--- a/arch/x86/coco/tdx/tdx.c
+++ b/arch/x86/coco/tdx/tdx.c
@@ -194,7 +194,7 @@ static void __noreturn tdx_panic(const char *msg)
 		__tdx_hypercall(&args);
 }
 
-static void tdx_parse_tdinfo(u64 *cc_mask)
+static void tdx_setup(u64 *cc_mask)
 {
 	struct tdx_module_args args = {};
 	unsigned int gpa_width;
@@ -219,6 +219,9 @@ static void tdx_parse_tdinfo(u64 *cc_mask)
 	gpa_width = args.rcx & GENMASK(5, 0);
 	*cc_mask = BIT_ULL(gpa_width - 1);
 
+	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
+	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+
 	/*
 	 * The kernel can not handle #VE's when accessing normal kernel
 	 * memory.  Ensure that no #VE will be delivered for accesses to
@@ -969,11 +972,11 @@ void __init tdx_early_init(void)
 	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
 
 	cc_vendor = CC_VENDOR_INTEL;
-	tdx_parse_tdinfo(&cc_mask);
-	cc_set_mask(cc_mask);
 
-	/* Kernel does not use NOTIFY_ENABLES and does not need random #VEs */
-	tdg_vm_wr(TDCS_NOTIFY_ENABLES, 0, -1ULL);
+	/* Configure the TD */
+	tdx_setup(&cc_mask);
+
+	cc_set_mask(cc_mask);
 
 	/*
 	 * All bits above GPA width are reserved and kernel treats shared bit

