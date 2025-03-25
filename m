Return-Path: <linux-tip-commits+bounces-4509-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 786F0A6ECBB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0CAB18946BD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BBB32580C4;
	Tue, 25 Mar 2025 09:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iaCf2FQH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pTjdcfQj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88BB257443;
	Tue, 25 Mar 2025 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895395; cv=none; b=Gp7ST540EIdomuLpmHKx4rFPsiNVm2ms0EQYP25hU7ea6d2BElrD6oJYTXWhv66woEWNhueqRVAvXGumh37LnDYLL0fQZDtWTaeMYBNLYMcU89js0aPXL6AHVPLEWDnY1gPXs7uoJJEepo0ju5BWbyLs7jIvBSPqVakGatu+2HI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895395; c=relaxed/simple;
	bh=86KQS7IcUjzvdpKI+H427/Pr4eSKFFo9HP57xCOXv24=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aP+IYerPwfdp6m8hV7e+E4kkqWkSuO9ckqfdIiG+YNGZtthTUKW6Xnfm7EleZierCdaTN+iG+KIB3D+WSyb0mCR/p31yJQNiuBusKFqJxm0ox64fuAerdeA2OmR9qBQfsT+31fWYV6IE6Oz5Hqrtgw0Wj2ECbJH2VbsclQDDxPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iaCf2FQH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pTjdcfQj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxcP53A3cnhYdH7lOh2tDtp4T8N+ZsUTD3A1C0711wg=;
	b=iaCf2FQHjYLfVBe46xuJPeRlmBodJP3jkTgyVFY3xnMhfaq6YdqKcWSacC8IAAnNgPS5Bl
	mJkIEPfkf5tKuOg7QOtkIJRO4lTSN6+G96agYykntKu6cpbYGrP9WrhCBv0OQGsN6FcIjQ
	TVxFqnGOggI2SkjxIgXG4UvCiOJfQxgkHCYg+zMIEbQVU9YLqzWQxJFXBLjSGXRWNF0pLK
	QOjMNOrLAhRM5cDc8W18IwgJomDDSXhwuoGk7S3qaGRwh8+OK9jbXBSXpPw8dlQwtb7JJs
	tKQ3vbF8aSHkWfttNZCKGDabtQTsxJLZA3S62w2NN7Ui6WJkZ1Qn/gSOMziT2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dxcP53A3cnhYdH7lOh2tDtp4T8N+ZsUTD3A1C0711wg=;
	b=pTjdcfQjG1Y3b5QCDusG0TdC6Nlym40AsiIObnsLeO+UCmso/NWWzBGPs3mf8GAx4eSZaZ
	2Lzikc7nmkm0kmCw==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-12-darwi@linutronix.de>
References: <20250324133324.23458-12-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289539140.14745.8486150700907966296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     77676e6802a10ffa5a0ad6367e8f6e14cbd88781
Gitweb:        https://git.kernel.org/tip/77676e6802a10ffa5a0ad6367e8f6e14cbd88781
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:32 +01:00

x86/cacheinfo: Consolidate AMD/Hygon leaf 0x8000001d calls

While gathering CPU cache info, CPUID leaf 0x8000001d is invoked in two
separate if blocks: one for Hygon CPUs and one for AMDs with topology
extensions.  After each invocation, amd_init_l3_cache() is called.

Merge the two if blocks into a single condition, thus removing the
duplicated code.  Future commits will expand these if blocks, so
combining them now is both cleaner and more maintainable.

Note, while at it, remove a useless "better error?" comment that was
within the same function since the 2005 commit e2cac78935ff ("[PATCH]
x86_64: When running cpuid4 need to run on the correct CPU").

Note, as previously done at commit aec28d852ed2 ("x86/cpuid: Standardize
on u32 in <asm/cpuid/api.h>"), standardize on using 'u32' and 'u8' types.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-12-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index 1b2a2bf..f1055e8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -593,28 +593,28 @@ static void amd_init_l3_cache(struct _cpuid4_info_regs *id4, int index)
 static int
 cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4)
 {
-	union _cpuid4_leaf_eax	eax;
-	union _cpuid4_leaf_ebx	ebx;
-	union _cpuid4_leaf_ecx	ecx;
-	unsigned		edx;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD) {
-		if (boot_cpu_has(X86_FEATURE_TOPOEXT))
-			cpuid_count(0x8000001d, index, &eax.full,
-				    &ebx.full, &ecx.full, &edx);
-		else
+	u8 cpu_vendor = boot_cpu_data.x86_vendor;
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	u32 edx;
+
+	if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) {
+		if (boot_cpu_has(X86_FEATURE_TOPOEXT) || cpu_vendor == X86_VENDOR_HYGON) {
+			/* AMD with TOPOEXT, or HYGON */
+			cpuid_count(0x8000001d, index, &eax.full, &ebx.full, &ecx.full, &edx);
+		} else {
+			/* Legacy AMD fallback */
 			amd_cpuid4(index, &eax, &ebx, &ecx);
-		amd_init_l3_cache(id4, index);
-	} else if (boot_cpu_data.x86_vendor == X86_VENDOR_HYGON) {
-		cpuid_count(0x8000001d, index, &eax.full,
-			    &ebx.full, &ecx.full, &edx);
+		}
 		amd_init_l3_cache(id4, index);
 	} else {
+		/* Intel */
 		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
 	}
 
 	if (eax.split.type == CTYPE_NULL)
-		return -EIO; /* better error ? */
+		return -EIO;
 
 	id4->eax = eax;
 	id4->ebx = ebx;

