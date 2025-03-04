Return-Path: <linux-tip-commits+bounces-3881-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B8ECA4D8D6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 568AE176CE6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B99561FECBB;
	Tue,  4 Mar 2025 09:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jt5a+P66";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JICOKs7Z"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 759FE1FECDC;
	Tue,  4 Mar 2025 09:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741081044; cv=none; b=WKTMQhKG391lvK2epDDJK89QuKFE5f7e8DaSiAhF4FVkVQlHFcunsXMOIKV4sFCewkZ4t4b7VFiyNZfoNpoP4cwZcuTc3OJe5JgB2/cRdHGcQR0EQqc2W+JMbAkkeXXZdkPTJrJ90qDGKGuuYE1z85W4iVbHv/h6Si0oo2ZrCK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741081044; c=relaxed/simple;
	bh=TNSRq921SfkNLxASubUaOMvN8H9YK0WYul07mLUrQdM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aE9oRZvst0mSBPnOsRiOn2S0VM+dNPwatHl6NJsfmyAVRahGGnXWXerzXnlgmpFK9iPEMRmVUqwkXONFT+fNODvD9lbMfK/tTRecPVWpgj1aAvir9XKht86q99Foi2LIFdnzApp2XibwTyMOH2RAs1a0p+tnNjkNl3jyShMQ6gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jt5a+P66; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JICOKs7Z; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 09:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741081040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5f3J9SceVHaHIf9aPpTooOyANZ6vHnVoGgtHqsR8i0=;
	b=Jt5a+P66Q9QJN9HalZ7zId66m88wGwuT3UDLtxXfPcD/1RidWN/ZWYUlvoxHQIQ7NHBibs
	IWMYXLu/0V6wl6pSbw9hKS/ewegPYt/y9577eguOmTFMpUb2ptgTOrOebhvRk7ywEu6anL
	upUixGj0MSrHqHXDjtvmzBjzgev1cRVMOQA5pfv9xP3oCvTErmR6QBOVjfeoZLTQ6R2H/j
	pgpxqs92e2/mZKeWlS9X9ritdnXw1vXIQKYTwqO0FYOUIdm8uq2tao2w2jttZ3YEd4Q+v6
	W7+LmKPApzZYlSSsk1ymRYlZ5e8G7WtcgoX+EWGNtS3brDb2LdPk3sL1Z9+g1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741081040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5f3J9SceVHaHIf9aPpTooOyANZ6vHnVoGgtHqsR8i0=;
	b=JICOKs7ZLwwu8AW2eVH8cIhOB3oG5csjNN40Gj+zbnabdBrgef7tlFdaWn8V9w6GCtvUOw
	Vv2/3ikcO866IkAQ==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpu: Use max() for CPUID leaf 0x2 TLB descriptors parsing
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250304085152.51092-7-darwi@linutronix.de>
References: <20250304085152.51092-7-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174108104025.14745.208647637497123476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     581616f5254333d510886ebb2206f0bff85778ff
Gitweb:        https://git.kernel.org/tip/581616f5254333d510886ebb2206f0bff85778ff
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Tue, 04 Mar 2025 09:51:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 10:15:24 +01:00

x86/cpu: Use max() for CPUID leaf 0x2 TLB descriptors parsing

The conditional statement "if (x < y) { x = y; }" appears 22 times at
the Intel leaf 0x2 descriptors parsing logic.

Replace each of such instances with a max() expression to simplify
the code.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250304085152.51092-7-darwi@linutronix.de
---
 arch/x86/kernel/cpu/intel.c | 76 +++++++++++++-----------------------
 1 file changed, 28 insertions(+), 48 deletions(-)

diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 60b58b1..42a57b8 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -3,6 +3,7 @@
 #include <linux/bitops.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
+#include <linux/minmax.h>
 #include <linux/smp.h>
 #include <linux/string.h>
 
@@ -700,7 +701,9 @@ static const struct _tlb_table intel_tlb_table[] = {
 
 static void intel_tlb_lookup(const unsigned char desc)
 {
+	unsigned int entries;
 	unsigned char k;
+
 	if (desc == 0)
 		return;
 
@@ -712,81 +715,58 @@ static void intel_tlb_lookup(const unsigned char desc)
 	if (intel_tlb_table[k].tlb_type == 0)
 		return;
 
+	entries = intel_tlb_table[k].entries;
 	switch (intel_tlb_table[k].tlb_type) {
 	case STLB_4K:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
 		break;
 	case STLB_4K_2M:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
+		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_INST_ALL:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
+		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
 		break;
 	case TLB_INST_4K:
-		if (tlb_lli_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4k[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4k[ENTRIES] = max(tlb_lli_4k[ENTRIES], entries);
 		break;
 	case TLB_INST_4M:
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
 		break;
 	case TLB_INST_2M_4M:
-		if (tlb_lli_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lli_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lli_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lli_2m[ENTRIES] = max(tlb_lli_2m[ENTRIES], entries);
+		tlb_lli_4m[ENTRIES] = max(tlb_lli_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_4K:
 	case TLB_DATA0_4K:
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
 		break;
 	case TLB_DATA_4M:
 	case TLB_DATA0_4M:
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_2M_4M:
 	case TLB_DATA0_2M_4M:
-		if (tlb_lld_2m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_2m[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], entries);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_4K_4M:
-		if (tlb_lld_4k[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4k[ENTRIES] = intel_tlb_table[k].entries;
-		if (tlb_lld_4m[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_4m[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_4k[ENTRIES] = max(tlb_lld_4k[ENTRIES], entries);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], entries);
 		break;
 	case TLB_DATA_1G_2M_4M:
-		if (tlb_lld_2m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
-			tlb_lld_2m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
-		if (tlb_lld_4m[ENTRIES] < TLB_0x63_2M_4M_ENTRIES)
-			tlb_lld_4m[ENTRIES] = TLB_0x63_2M_4M_ENTRIES;
+		tlb_lld_2m[ENTRIES] = max(tlb_lld_2m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
+		tlb_lld_4m[ENTRIES] = max(tlb_lld_4m[ENTRIES], TLB_0x63_2M_4M_ENTRIES);
 		fallthrough;
 	case TLB_DATA_1G:
-		if (tlb_lld_1g[ENTRIES] < intel_tlb_table[k].entries)
-			tlb_lld_1g[ENTRIES] = intel_tlb_table[k].entries;
+		tlb_lld_1g[ENTRIES] = max(tlb_lld_1g[ENTRIES], entries);
 		break;
 	}
 }

