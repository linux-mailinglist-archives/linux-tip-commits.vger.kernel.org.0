Return-Path: <linux-tip-commits+bounces-3100-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C019F6837
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 15:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5276C1892785
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Dec 2024 14:23:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AD9E1C548A;
	Wed, 18 Dec 2024 14:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XmYzxzo0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yw4AqVUZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96737224F6;
	Wed, 18 Dec 2024 14:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734531758; cv=none; b=chx7fd8nuN7KwDoWorIbz80w+s9+62HfgYXEIuCy8KhpQXpRmRAodJp8zZF4hN0CTnM2TCD4+9WxJrLVJ/xXD7Y+OjqvYn9M6VmlNz12Bq19gIFIsVa0nUq0aqdOYVQXk3Uw2fpr5JmFtJQnDFnKqfYFfEmL8cl2gpdxnl8b9t4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734531758; c=relaxed/simple;
	bh=92nP0IqWurufE9d9hLUFl9XUiEUM8JjsRLwo3tja6D8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=tCcc5+1nOmoQ6EPTrPrRS1CDoEVcHXnyNKsS64RgUy2Kl8lsLmh8x59I3Wnzvd3wsIqBxIY1uuYjTaIhPhOtMv1o0zSxr71DvqSEGYm5PSRSKaFb5ARLfMiwupisxTNQ/AlsPRusEo5pJr5+Cai/hT2qYqTOvvzbJ1FcXltLV0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XmYzxzo0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yw4AqVUZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 18 Dec 2024 14:22:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734531754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hGPSzY0M8B33AV1LSvpOaRr5XQGabMHuH7KBr1rAivk=;
	b=XmYzxzo0W//9K7K6AjhP7DpLhi2W5cb4Q4YDVnRbVbWWPVSsQ1TLd7SsytpoDlMcjTZJQc
	zZrSo/f6Zlq3yD+iRWmnYGfzouPREq0W1LocE0OFffmOd8UYZUlb7RU1jfYu2mERmGFooG
	cPP3iwkYC99RIfN6yMvARtjlJYnAeX6S6vpokTDlkz8X9D1eij7E5gLIK24DI8v6Bh1Xju
	rbvsyKkuInD8lMEv6LmWBggC/oq8R33WhKRTNbZjKf0fYQMTcVeDSZ+UwFzsBQQfW9jM2+
	ZyL2Q0yse74RhcdYmIv4bvmC/NpQ/npWtjvkcWq1SraYlqnwgK/zybxXRb7ESw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734531754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=hGPSzY0M8B33AV1LSvpOaRr5XQGabMHuH7KBr1rAivk=;
	b=Yw4AqVUZlvYI8PERymxU8ve3oqD27+sdxz79Al6+zmBZouXHmWZVhbvqzDTmvHpy0fXcf5
	e7K96hUc5tuitiBw==
From: "tip-bot2 for Dave Hansen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsc: Remove CPUID "frequency" leaf magic numbers.
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173453175400.7135.9551373560447754310.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     e558eadf6bd6199a3f454299de3c6338931d4e46
Gitweb:        https://git.kernel.org/tip/e558eadf6bd6199a3f454299de3c6338931d4e46
Author:        Dave Hansen <dave.hansen@linux.intel.com>
AuthorDate:    Fri, 13 Dec 2024 12:50:36 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 18 Dec 2024 06:17:40 -08:00

x86/tsc: Remove CPUID "frequency" leaf magic numbers.

All the code that reads the CPUID frequency information leaf hard-codes
a magic number.  Give it a symbolic name and use it.

Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/all/20241213205036.4397658F%40davehans-spike.ostc.intel.com
---
 arch/x86/include/asm/cpuid.h |  1 +
 arch/x86/kernel/tsc.c        | 12 ++++++------
 2 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/cpuid.h b/arch/x86/include/asm/cpuid.h
index 9b0d14b..e7803c2 100644
--- a/arch/x86/include/asm/cpuid.h
+++ b/arch/x86/include/asm/cpuid.h
@@ -24,6 +24,7 @@ enum cpuid_regs_idx {
 #define CPUID_MWAIT_LEAF	0x5
 #define CPUID_DCA_LEAF		0x9
 #define CPUID_TSC_LEAF		0x15
+#define CPUID_FREQ_LEAF		0x16
 
 #ifdef CONFIG_X86_32
 bool have_cpuid_p(void);
diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 8091b0e..678c36f 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -681,8 +681,8 @@ unsigned long native_calibrate_tsc(void)
 
 	/*
 	 * Denverton SoCs don't report crystal clock, and also don't support
-	 * CPUID.0x16 for the calculation below, so hardcode the 25MHz crystal
-	 * clock.
+	 * CPUID_FREQ_LEAF for the calculation below, so hardcode the 25MHz
+	 * crystal clock.
 	 */
 	if (crystal_khz == 0 &&
 			boot_cpu_data.x86_vfm == INTEL_ATOM_GOLDMONT_D)
@@ -701,10 +701,10 @@ unsigned long native_calibrate_tsc(void)
 	 * clock, but we can easily calculate it to a high degree of accuracy
 	 * by considering the crystal ratio and the CPU speed.
 	 */
-	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= 0x16) {
+	if (crystal_khz == 0 && boot_cpu_data.cpuid_level >= CPUID_FREQ_LEAF) {
 		unsigned int eax_base_mhz, ebx, ecx, edx;
 
-		cpuid(0x16, &eax_base_mhz, &ebx, &ecx, &edx);
+		cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx, &ecx, &edx);
 		crystal_khz = eax_base_mhz * 1000 *
 			eax_denominator / ebx_numerator;
 	}
@@ -739,12 +739,12 @@ static unsigned long cpu_khz_from_cpuid(void)
 	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
 		return 0;
 
-	if (boot_cpu_data.cpuid_level < 0x16)
+	if (boot_cpu_data.cpuid_level < CPUID_FREQ_LEAF)
 		return 0;
 
 	eax_base_mhz = ebx_max_mhz = ecx_bus_mhz = edx = 0;
 
-	cpuid(0x16, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
+	cpuid(CPUID_FREQ_LEAF, &eax_base_mhz, &ebx_max_mhz, &ecx_bus_mhz, &edx);
 
 	return eax_base_mhz * 1000;
 }

