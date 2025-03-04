Return-Path: <linux-tip-commits+bounces-3895-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A2820A4DA66
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 11:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A887A6B0A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D55020101E;
	Tue,  4 Mar 2025 10:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yNS4rI7/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zw6iPzND"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48CB61FE461;
	Tue,  4 Mar 2025 10:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741083981; cv=none; b=JH45qxVy0SXc7tkHd5rjfB4h9M/lMwyJk6jDgi0oKiS3HNaaLSm1zMfAZE48MDtTC55HNERmeXtU22ZTf7WFEi3+UUpIvOTxZPAbWcXLSqZpRyqM97aQ+kIaqR6svyxUudPhTOsbEdjC4G7KOvcsWceKU2vQJbvydbh68wdnCms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741083981; c=relaxed/simple;
	bh=KMKvcHGjPYXd+EX02JXNGwj2yOtCHfAxNiaeak5JTMs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HE37otpNKBD96CLTVfcfyKdZmiYKMTvr4fABGXMV4zB+4As7VyQp+S2Uefd4gqzPckPfLU/NtcYQlEGlEuvMikpkTEKLnBRqIg50e8fphxW3zi6MFPUY4ScTh9GQfbgNc8mqirTvpPuS48nCJ0tJ1fTM8AEVjlZSzZf/IYFoLrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yNS4rI7/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zw6iPzND; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 10:26:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741083977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coJ54pP5WwHfuRCAOvROwFIUr43qb5GMjW7sKG5nJxM=;
	b=yNS4rI7/gd9W9TLRXt4ol62MdnORIO8FHWx86B7oHFSzFNk5oXoVbpCsMu+1l68jJN5HJm
	iNTOgw0zVF4RIzgQAtdzUMX4xuLX3wSX031t9pl5E0VXHK8L30C9Rot5JGVyWxynfJmCOW
	/nc/5Xvawng8Vr/V94sfO6sE+A0Wor03JblDbd4JblbXOqlVoHSbadqSimZQcwWPVV3Kzq
	xNGNVWgPioutDEZfrkfldaHPkqIXioq7qhn6MPPznt5VP1S2eH7jeddr29KKwJaPP23IF7
	wJxrYy0ZgPdK8Odq8BNfi7B2lUuHxUUyibdDs6V3V42UAe8xgQSUmA6Dw1Y5eQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741083977;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=coJ54pP5WwHfuRCAOvROwFIUr43qb5GMjW7sKG5nJxM=;
	b=zw6iPzNDwDF1ls6vv9sf6yTmqEmmIK5cFKUwFHT/Rt2TfAn/Eo1XjAfCnT4FwD4xZ6yU4p
	g6qXyRktIicZk4Ag==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Remove unused TLB strings
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-10-darwi@linutronix.de>
References: <20250304085152.51092-10-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108397684.14745.1067513160965175306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     1f61dfdf16cd3bab383741c2eb43e7f69e9f592f
Gitweb:        https://git.kernel.org/tip/1f61dfdf16cd3bab383741c2eb43e7f69e9f592f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 11:17:33 +01:00

x86/cpu: Remove unused TLB strings

Commit:

  e0ba94f14f74 ("x86/tlb_info: get last level TLB entry number of CPU")

added the TLB table for parsing CPUID(0x4), including strings
describing them. The string entry in the table was never used.

Convert them to comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-10-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cpu.h   |  8 +----
 arch/x86/kernel/cpu/intel.c | 80 +++++++++++++++++++-----------------
 2 files changed, 43 insertions(+), 45 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 1beccef..51deb60 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -33,14 +33,6 @@ struct cpu_dev {
 #endif
 };
 
-struct _tlb_table {
-	unsigned char descriptor;
-	char tlb_type;
-	unsigned int entries;
-	/* unsigned int ways; */
-	char info[128];
-};
-
 #define cpu_dev_register(cpu_devX) \
 	static const struct cpu_dev *const __cpu_dev_##cpu_devX __used \
 	__section(".x86_cpu_dev.init") = \
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 61d3fd3..291c828 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -658,44 +658,50 @@ static unsigned int intel_size_cache(struct cpuinfo_x86 *c, unsigned int size)
  */
 #define TLB_0x63_2M_4M_ENTRIES	32
 
+struct _tlb_table {
+	unsigned char descriptor;
+	char tlb_type;
+	unsigned int entries;
+};
+
 static const struct _tlb_table intel_tlb_table[] = {
-	{ 0x01, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages, 4-way set associative" },
-	{ 0x02, TLB_INST_4M,		2,	" TLB_INST 4 MByte pages, full associative" },
-	{ 0x03, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way set associative" },
-	{ 0x04, TLB_DATA_4M,		8,	" TLB_DATA 4 MByte pages, 4-way set associative" },
-	{ 0x05, TLB_DATA_4M,		32,	" TLB_DATA 4 MByte pages, 4-way set associative" },
-	{ 0x0b, TLB_INST_4M,		4,	" TLB_INST 4 MByte pages, 4-way set associative" },
-	{ 0x4f, TLB_INST_4K,		32,	" TLB_INST 4 KByte pages" },
-	{ 0x50, TLB_INST_ALL,		64,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
-	{ 0x51, TLB_INST_ALL,		128,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
-	{ 0x52, TLB_INST_ALL,		256,	" TLB_INST 4 KByte and 2-MByte or 4-MByte pages" },
-	{ 0x55, TLB_INST_2M_4M,		7,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
-	{ 0x56, TLB_DATA0_4M,		16,	" TLB_DATA0 4 MByte pages, 4-way set associative" },
-	{ 0x57, TLB_DATA0_4K,		16,	" TLB_DATA0 4 KByte pages, 4-way associative" },
-	{ 0x59, TLB_DATA0_4K,		16,	" TLB_DATA0 4 KByte pages, fully associative" },
-	{ 0x5a, TLB_DATA0_2M_4M,	32,	" TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative" },
-	{ 0x5b, TLB_DATA_4K_4M,		64,	" TLB_DATA 4 KByte and 4 MByte pages" },
-	{ 0x5c, TLB_DATA_4K_4M,		128,	" TLB_DATA 4 KByte and 4 MByte pages" },
-	{ 0x5d, TLB_DATA_4K_4M,		256,	" TLB_DATA 4 KByte and 4 MByte pages" },
-	{ 0x61, TLB_INST_4K,		48,	" TLB_INST 4 KByte pages, full associative" },
-	{ 0x63, TLB_DATA_1G_2M_4M,	4,	" TLB_DATA 1 GByte pages, 4-way set associative"
-						" (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here)" },
-	{ 0x6b, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 8-way associative" },
-	{ 0x6c, TLB_DATA_2M_4M,		128,	" TLB_DATA 2 MByte or 4 MByte pages, 8-way associative" },
-	{ 0x6d, TLB_DATA_1G,		16,	" TLB_DATA 1 GByte pages, fully associative" },
-	{ 0x76, TLB_INST_2M_4M,		8,	" TLB_INST 2-MByte or 4-MByte pages, fully associative" },
-	{ 0xb0, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 4-way set associative" },
-	{ 0xb1, TLB_INST_2M_4M,		4,	" TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries" },
-	{ 0xb2, TLB_INST_4K,		64,	" TLB_INST 4KByte pages, 4-way set associative" },
-	{ 0xb3, TLB_DATA_4K,		128,	" TLB_DATA 4 KByte pages, 4-way set associative" },
-	{ 0xb4, TLB_DATA_4K,		256,	" TLB_DATA 4 KByte pages, 4-way associative" },
-	{ 0xb5, TLB_INST_4K,		64,	" TLB_INST 4 KByte pages, 8-way set associative" },
-	{ 0xb6, TLB_INST_4K,		128,	" TLB_INST 4 KByte pages, 8-way set associative" },
-	{ 0xba, TLB_DATA_4K,		64,	" TLB_DATA 4 KByte pages, 4-way associative" },
-	{ 0xc0, TLB_DATA_4K_4M,		8,	" TLB_DATA 4 KByte and 4 MByte pages, 4-way associative" },
-	{ 0xc1, STLB_4K_2M,		1024,	" STLB 4 KByte and 2 MByte pages, 8-way associative" },
-	{ 0xc2, TLB_DATA_2M_4M,		16,	" TLB_DATA 2 MByte/4MByte pages, 4-way associative" },
-	{ 0xca, STLB_4K,		512,	" STLB 4 KByte pages, 4-way associative" },
+	{ 0x01, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages, 4-way set associative */
+	{ 0x02, TLB_INST_4M,		2},	/* TLB_INST 4 MByte pages, full associative */
+	{ 0x03, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way set associative */
+	{ 0x04, TLB_DATA_4M,		8},	/* TLB_DATA 4 MByte pages, 4-way set associative */
+	{ 0x05, TLB_DATA_4M,		32},	/* TLB_DATA 4 MByte pages, 4-way set associative */
+	{ 0x0b, TLB_INST_4M,		4},	/* TLB_INST 4 MByte pages, 4-way set associative */
+	{ 0x4f, TLB_INST_4K,		32},	/* TLB_INST 4 KByte pages */
+	{ 0x50, TLB_INST_ALL,		64},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	{ 0x51, TLB_INST_ALL,		128},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	{ 0x52, TLB_INST_ALL,		256},	/* TLB_INST 4 KByte and 2-MByte or 4-MByte pages */
+	{ 0x55, TLB_INST_2M_4M,		7},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
+	{ 0x56, TLB_DATA0_4M,		16},	/* TLB_DATA0 4 MByte pages, 4-way set associative */
+	{ 0x57, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, 4-way associative */
+	{ 0x59, TLB_DATA0_4K,		16},	/* TLB_DATA0 4 KByte pages, fully associative */
+	{ 0x5a, TLB_DATA0_2M_4M,	32},	/* TLB_DATA0 2-MByte or 4 MByte pages, 4-way set associative */
+	{ 0x5b, TLB_DATA_4K_4M,		64},	/* TLB_DATA 4 KByte and 4 MByte pages */
+	{ 0x5c, TLB_DATA_4K_4M,		128},	/* TLB_DATA 4 KByte and 4 MByte pages */
+	{ 0x5d, TLB_DATA_4K_4M,		256},	/* TLB_DATA 4 KByte and 4 MByte pages */
+	{ 0x61, TLB_INST_4K,		48},	/* TLB_INST 4 KByte pages, full associative */
+	{ 0x63, TLB_DATA_1G_2M_4M,	4},	/* TLB_DATA 1 GByte pages, 4-way set associative
+						 * (plus 32 entries TLB_DATA 2 MByte or 4 MByte pages, not encoded here) */
+	{ 0x6b, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 8-way associative */
+	{ 0x6c, TLB_DATA_2M_4M,		128},	/* TLB_DATA 2 MByte or 4 MByte pages, 8-way associative */
+	{ 0x6d, TLB_DATA_1G,		16},	/* TLB_DATA 1 GByte pages, fully associative */
+	{ 0x76, TLB_INST_2M_4M,		8},	/* TLB_INST 2-MByte or 4-MByte pages, fully associative */
+	{ 0xb0, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 4-way set associative */
+	{ 0xb1, TLB_INST_2M_4M,		4},	/* TLB_INST 2M pages, 4-way, 8 entries or 4M pages, 4-way entries */
+	{ 0xb2, TLB_INST_4K,		64},	/* TLB_INST 4KByte pages, 4-way set associative */
+	{ 0xb3, TLB_DATA_4K,		128},	/* TLB_DATA 4 KByte pages, 4-way set associative */
+	{ 0xb4, TLB_DATA_4K,		256},	/* TLB_DATA 4 KByte pages, 4-way associative */
+	{ 0xb5, TLB_INST_4K,		64},	/* TLB_INST 4 KByte pages, 8-way set associative */
+	{ 0xb6, TLB_INST_4K,		128},	/* TLB_INST 4 KByte pages, 8-way set associative */
+	{ 0xba, TLB_DATA_4K,		64},	/* TLB_DATA 4 KByte pages, 4-way associative */
+	{ 0xc0, TLB_DATA_4K_4M,		8},	/* TLB_DATA 4 KByte and 4 MByte pages, 4-way associative */
+	{ 0xc1, STLB_4K_2M,		1024},	/* STLB 4 KByte and 2 MByte pages, 8-way associative */
+	{ 0xc2, TLB_DATA_2M_4M,		16},	/* TLB_DATA 2 MByte/4MByte pages, 4-way associative */
+	{ 0xca, STLB_4K,		512},	/* STLB 4 KByte pages, 4-way associative */
 	{ 0x00, 0, 0 }
 };
 

