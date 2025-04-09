Return-Path: <linux-tip-commits+bounces-4814-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B232A830A6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 21:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BFF004468F0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 19:40:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8233020297C;
	Wed,  9 Apr 2025 19:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KLtSFQlW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4e8Q2lCg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31DB1F560D;
	Wed,  9 Apr 2025 19:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744227617; cv=none; b=a+ZmkrbQrLTTitvU5Hs+Rq9NEbexDBDu2842ZQXaXelqTh1DQ0nIu1F3F4ZL6gVZPK8a0zAYsUYTHpR7kZRlN996BHVHvKojm+rev0QlSX6LS19t0dT8abuWpaWx/GLjFSa63104IruZLNqNYYNaMg0l0xTm+R7ZZIa4QX41Gtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744227617; c=relaxed/simple;
	bh=BKjWlgATClR/jbh/2TtHwEOlIWRbba20iVBWvvU6aUA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=smuvto7DwO+EhsVvqhhD0qblb5akQjQ8ADZerXul2MKYPc6ihVlFFlcdLzj6+ZkYOxS9GBCyhWE8xUHBzR93O/Zyzqpv6B34pHmJ3UzFcW8ZjxUu98K9cgSWDvzn1dFEoyhqX3Xqwv+VzCpFGR8ryQmu9QxU9daTdCiS+Xu7M6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KLtSFQlW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4e8Q2lCg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 19:40:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744227614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFFp9QvJ9yjqhFS0MjkEplCanwzuCzCVOFKqt5PWuTs=;
	b=KLtSFQlWTYhFTT62a4uX5HX1a6MO4pMrKAJm8tyAKjnFXGJiHdOi4tS456DlrNwdDRnpz6
	QR2oaCS4G6dEe4v1FfFiRWYUiHp/94ZTpsuUuzmlDXfQyU07y4H94PEjSQplt1tr2YTbjx
	uTYq7ja7LS2NxRd9kpc6Sll0XLjSVi8Gm2SgXV/gaPoqcc2rHBHy2o58gEvrfkG1ka/6UI
	D9YxXCh3Rz782siUKbD1LKlWOoe8r4298+fMR9J5Vzn/J3t6iGhrxGnfm6TmTsVQ58SLgt
	7WvU+4asetWe4eT8odE4igScBUqWKA98CfLpcujCzvPM1SehhafWVu9ycgNyMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744227614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uFFp9QvJ9yjqhFS0MjkEplCanwzuCzCVOFKqt5PWuTs=;
	b=4e8Q2lCgj936Kl1dB8o7C01ih2CjzRjoruvOwqKxO3/104MZdtLtyc2pCenp1y++xY6S2i
	dLvu7nXWUlCvWRCw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Properly parse CPUID(0x80000006) L2/L3
 associativity
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>, "H. Peter Anvin" <hpa@zytor.com>,
 John Ogness <john.ogness@linutronix.de>, x86-cpuid@lists.linux.dev,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250409122233.1058601-3-darwi@linutronix.de>
References: <20250409122233.1058601-3-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174422761319.31282.4153060826522358872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d02c83d75f9f76dda046edbd9f39b911427677c9
Gitweb:        https://git.kernel.org/tip/d02c83d75f9f76dda046edbd9f39b911427677c9
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Wed, 09 Apr 2025 14:22:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 20:47:05 +02:00

x86/cacheinfo: Properly parse CPUID(0x80000006) L2/L3 associativity

Complete the AMD CPUID(4) emulation logic, which uses CPUID(0x80000006)
for L2/L3 cache info and an assocs[] associativity mapping array, by
adding entries for 3-way caches and 6-way caches.

Properly handle the case where CPUID(0x80000006) returns an L2/L3
associativity of 9.  This is not real associativity, but a marker to
indicate that the respective L2/L3 cache information should be retrieved
from CPUID(0x8000001d) instead.  If such a marker is encountered, return
early from legacy_amd_cpuid4(), thus effectively emulating an "invalid
index" CPUID(4) response with a cache type of zero.

When checking if CPUID(0x80000006) L2/L3 cache info output is valid, and
given the associtivity marker 9 above, do not just check if the whole
ECX/EDX register is zero.  Rather, check if the associativity is zero or
9.  An associativity of zero implies no L2/L3 cache, which make it the
more correct check anyway vs. a zero check of the whole output register.

Fixes: a326e948c538 ("x86, cacheinfo: Fixup L3 cache information for AMD multi-node processors")
Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: John Ogness <john.ogness@linutronix.de>
Cc: x86-cpuid@lists.linux.dev
Link: https://lore.kernel.org/r/20250409122233.1058601-3-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index f4817cd..52727f8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -89,9 +89,13 @@ static const enum cache_type cache_type_map[] = {
 /*
  * Fallback AMD CPUID(4) emulation
  * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
+ *
+ * @AMD_L2_L3_INVALID_ASSOC: cache info for the respective L2/L3 cache should
+ * be determined from CPUID(0x8000001d) instead of CPUID(0x80000006).
  */
 
 #define AMD_CPUID4_FULLY_ASSOCIATIVE	0xffff
+#define AMD_L2_L3_INVALID_ASSOC		0x9
 
 union l1_cache {
 	struct {
@@ -128,7 +132,9 @@ union l3_cache {
 static const unsigned short assocs[] = {
 	[1]		= 1,
 	[2]		= 2,
+	[3]		= 3,
 	[4]		= 4,
+	[5]		= 6,
 	[6]		= 8,
 	[8]		= 16,
 	[0xa]		= 32,
@@ -172,7 +178,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		size_in_kb	= l1->size_in_kb;
 		break;
 	case 2:
-		if (!l2.val)
+		if (!l2.assoc || l2.assoc == AMD_L2_L3_INVALID_ASSOC)
 			return;
 
 		/* Use x86_cache_size as it might have K7 errata fixes */
@@ -182,7 +188,7 @@ static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		size_in_kb	= __this_cpu_read(cpu_info.x86_cache_size);
 		break;
 	case 3:
-		if (!l3.val)
+		if (!l3.assoc || l3.assoc == AMD_L2_L3_INVALID_ASSOC)
 			return;
 
 		assoc		= assocs[l3.assoc];

