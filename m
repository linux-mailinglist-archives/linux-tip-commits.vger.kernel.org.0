Return-Path: <linux-tip-commits+bounces-4314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74C05A67C62
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 19:56:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 069DD19C2D83
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Mar 2025 18:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C3214221;
	Tue, 18 Mar 2025 18:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hGz4Ioua";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZpMODOLQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A7B021323E;
	Tue, 18 Mar 2025 18:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742324079; cv=none; b=MfyYyh+GsNP51k+xl9dXAD0jYAuVzreirOdYcZ56M2KLft7aVqjCFNexgxFAFMtIaRF4Y/OAJGZNehYPYZcjSUxSkE1oJzzIBuvVgNCo95qu82GbK+/x8+KQ5BObx01jcexm8OGQ3RPSa6y3ndts0YZ/xMn986qiErYl++/x3n4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742324079; c=relaxed/simple;
	bh=nwZu10HEnXVOj9O7Ex5HtyLl1U+PWZlLRZt86GzHDAo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CMHRscburjsu0UUnLJE+DNUtaOW3vAoqEuhqIDfMJa+baWqwzaxEHpm53oeZL+GcNjoM2RghhL/EC51oWQsJAKFxTax4N30FC9m6zzB+hXXwVc20WeuX8/HH3RETO9PidQFO3+1y9Su/uFfWyYlu391sBRdkDGbhPt6Q5BRAIoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hGz4Ioua; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZpMODOLQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Mar 2025 18:54:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742324072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7dJ/a3cb89pwNBuriFzAVmfduMi2XOoBfR6jSWZW0k=;
	b=hGz4IouagjrgClxmD34icrSSEN3KHMm5vn4QbPE1tybYkCyBsx1lA7Sj+myO7hRwpy4qIj
	C5KHrobgBuQ+la3Mwo+B5Q3wsJBva1rFpFR3vwMud2h1MFvzbL2xhXzJUcgNCWBcN1QoQn
	+3pAATCaBLqapuyOcU8WWHOZ53EqULCJdKvvNYzCw5Jhrr3trAvMc8e5V3UCwEh4NuK1IP
	W1h6Hk9RjLw2VwrYvwL7OlJzgkbvtovwBndP1rSAGBMt6HXmeqoCSTvyEfNcxd5wXgkbar
	yZkTjf7LfuaxHJ90Jrwg5SUxj22Z/6jC7mvAujI1sZ+RE2T+qAmPw3Oikp6KJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742324072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7dJ/a3cb89pwNBuriFzAVmfduMi2XOoBfR6jSWZW0k=;
	b=ZpMODOLQLZ5/6fKM0I3Qs4zrvTTy2SXXt95k+PgzHHVOrXsT8xuPWFq+gze1Ek9BO0yh8g
	VA1GziyQZplMrVBg==
From: "tip-bot2 for Sohil Mehta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu/intel: Replace Family 15 checks with VFM ones
Cc: Sohil Mehta <sohil.mehta@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250219184133.816753-7-sohil.mehta@intel.com>
References: <20250219184133.816753-7-sohil.mehta@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174232407152.14745.14252134648730135071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     93a1337433ab6ae596d9c8a3e4d6fbcbe128afad
Gitweb:        https://git.kernel.org/tip/93a1337433ab6ae596d9c8a3e4d6fbcbe128afad
Author:        Sohil Mehta <sohil.mehta@intel.com>
AuthorDate:    Wed, 19 Feb 2025 18:41:24 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 18 Mar 2025 19:33:45 +01:00

x86/cpu/intel: Replace Family 15 checks with VFM ones

Introduce names for some old pentium 4 models and replace the x86_model
checks with VFM ones.

Signed-off-by: Sohil Mehta <sohil.mehta@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20250219184133.816753-7-sohil.mehta@intel.com
---
 arch/x86/include/asm/intel-family.h | 4 ++++
 arch/x86/kernel/cpu/intel.c         | 6 +++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 58735bc..0108695 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -184,6 +184,10 @@
 /* Family 5 */
 #define INTEL_QUARK_X1000		IFM(5, 0x09) /* Quark X1000 SoC */
 
+/* Family 15 - NetBurst */
+#define INTEL_P4_WILLAMETTE		IFM(15, 0x01) /* Also Xeon Foster */
+#define INTEL_P4_PRESCOTT		IFM(15, 0x03)
+
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a49615f..42cebca 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -247,8 +247,8 @@ static void early_init_intel(struct cpuinfo_x86 *c)
 #endif
 
 	/* CPUID workaround for 0F33/0F34 CPU */
-	if (c->x86 == 0xF && c->x86_model == 0x3
-	    && (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
+	if (c->x86_vfm == INTEL_P4_PRESCOTT &&
+	    (c->x86_stepping == 0x3 || c->x86_stepping == 0x4))
 		c->x86_phys_bits = 36;
 
 	/*
@@ -421,7 +421,7 @@ static void intel_workarounds(struct cpuinfo_x86 *c)
 	 * P4 Xeon erratum 037 workaround.
 	 * Hardware prefetcher may cause stale data to be loaded into the cache.
 	 */
-	if ((c->x86 == 15) && (c->x86_model == 1) && (c->x86_stepping == 1)) {
+	if (c->x86_vfm == INTEL_P4_WILLAMETTE && c->x86_stepping == 1) {
 		if (msr_set_bit(MSR_IA32_MISC_ENABLE,
 				MSR_IA32_MISC_ENABLE_PREFETCH_DISABLE_BIT) > 0) {
 			pr_info("CPU: C0 stepping P4 Xeon detected.\n");

