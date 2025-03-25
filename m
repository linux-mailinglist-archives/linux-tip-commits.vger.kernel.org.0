Return-Path: <linux-tip-commits+bounces-4506-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D745EA6ECB7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 10:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C99A7188C24F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32D9525745F;
	Tue, 25 Mar 2025 09:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y8ZUwaxT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UFOl3OKb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A741B257424;
	Tue, 25 Mar 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742895394; cv=none; b=JLNhaBEBgK20Vhr1uGbqy+RAYBYsz7Zok7+eWWlAqkcV6iWe62ehbfiA9SK8y8Ovfj5gDgakKtps9neE0jyUe5EzEVSrUc+yNA9Q8NaGG8fIqUB07joxdH6M+xZe8Z5lnOqX7DpPtwPWEJNF2IDkvxVImj0f9RkTtXizyHUhpTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742895394; c=relaxed/simple;
	bh=MpsES1aOfwb9PVAYJCjaz9/YKDO7U1wxJizrOt1L3js=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LuH9R2JKY3GJJNco18hGN3mm0iMQd3aFBlSymNkeMvV5q71TbL3xaeCmTo1gxACaauZZ+bxOjdaKzcU1wV0c2rrR5PpefePVlDoBT/uIwqfbwxI5jcoWKrelmqUAX78Uo0zYGK/ZnLmfP+GgyW/qU20Ei2oyf7hIgbqaybNCERs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y8ZUwaxT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UFOl3OKb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 09:36:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742895389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwQhVEZegoNmIFMSUX/bQYZVzZfbd6ocxXnd6M3VY30=;
	b=y8ZUwaxTUjKInA5DW5UQ6QftJ2c7QTmtVhyRWGrjG7AR9VBV4icRmdIyYUnFnnvlcFuis2
	np8z+i6wh6/91G4QAgacKj05kA+XzNUuaXpeDOo+x8YyA6IflpY1j/7sWaJYf7CkKyLBbU
	Qb9FKSb/6fbKZz/sYjZapkKWLI5iIhzTM9dpzsXlJMTQv9NW/GXVG1nUJEPN1vP5gWC+ot
	wUk6bcGix5pQhpJkebGHBuj7jrdtMXIDfLvsjXauXUT4DCp4pPmnT88kLdgO/QJv5hNMgd
	zx1Nn2K+FYinMnzVDxVatoBXM2jeWEL+R7rylAd0eI3fddPW+WVybPqBJZlTgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742895389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dwQhVEZegoNmIFMSUX/bQYZVzZfbd6ocxXnd6M3VY30=;
	b=UFOl3OKb8+kMiToECmZB4XkHKu2XcpwOsM3OMrezNaYATdaRuHkzLS7ePOdZwr8OXy/gEp
	xlOeTgRTftrHKmDg==
From: "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cacheinfo: Separate Intel and AMD CPUID leaf 0x4
 code paths
Cc: "Ahmed S. Darwish" <darwi@linutronix.de>, Ingo Molnar <mingo@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250324133324.23458-16-darwi@linutronix.de>
References: <20250324133324.23458-16-darwi@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289538917.14745.12734456253889364296.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     2d56cc87225035919dfceb40e676081d833dab13
Gitweb:        https://git.kernel.org/tip/2d56cc87225035919dfceb40e676081d833dab13
Author:        Ahmed S. Darwish <darwi@linutronix.de>
AuthorDate:    Mon, 24 Mar 2025 14:33:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Mar 2025 10:22:45 +01:00

x86/cacheinfo: Separate Intel and AMD CPUID leaf 0x4 code paths

The CPUID leaf 0x4 parsing code at cpuid4_cache_lookup_regs() is ugly and
convoluted.  It is tangled with multiple nested conditions to handle:

  * AMD with TOPEXT, or Hygon CPUs via leaf 0x8000001d

  * Legacy AMD fallback via leaf 0x4 emulation

  * Intel CPUs via the actual CPUID leaf 0x4

Moreover, AMD L3 northbridge initialization is also awkwardly placed
alongside the CPUID calls of the first two scenarios above.  Refactor all
of that as follows:

  * Update AMD's leaf 0x4 emulation comment to represent current state

  * Clearly label the AMD leaf 0x4 emulation function as a fallback

  * Split AMD/Hygon and Intel code paths into separate functions

  * Move AMD L3 northbridge initialization out of CPUID leaf 0x4 code,
    and into populate_cache_leaves() where it belongs.  There,
    ci_info_init() can directly store the initialized object in the
    private pointer of the <linux/cacheinfo.h> API.

Signed-off-by: Ahmed S. Darwish <darwi@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250324133324.23458-16-darwi@linutronix.de
---
 arch/x86/kernel/cpu/cacheinfo.c | 95 ++++++++++++++++++--------------
 1 file changed, 54 insertions(+), 41 deletions(-)

diff --git a/arch/x86/kernel/cpu/cacheinfo.c b/arch/x86/kernel/cpu/cacheinfo.c
index ea6fba9..10a79d8 100644
--- a/arch/x86/kernel/cpu/cacheinfo.c
+++ b/arch/x86/kernel/cpu/cacheinfo.c
@@ -167,12 +167,11 @@ struct _cpuid4_info_regs {
 	unsigned long size;
 };
 
-/* AMD doesn't have CPUID4. Emulate it here to report the same
-   information to the user.  This makes some assumptions about the machine:
-   L2 not shared, no SMT etc. that is currently true on AMD CPUs.
+/*
+ * Fallback AMD CPUID(4) emulation
+ * AMD CPUs with TOPOEXT can just use CPUID(0x8000001d)
+ */
 
-   In theory the TLBs could be reported as fake type (they are in "dummy").
-   Maybe later */
 union l1_cache {
 	struct {
 		unsigned line_size:8;
@@ -228,9 +227,8 @@ static const enum cache_type cache_type_map[] = {
 	[CTYPE_UNIFIED] = CACHE_TYPE_UNIFIED,
 };
 
-static void
-amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
-	   union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
+static void legacy_amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
+			      union _cpuid4_leaf_ebx *ebx, union _cpuid4_leaf_ecx *ecx)
 {
 	unsigned int dummy, line_size, lines_per_tag, assoc, size_in_kb;
 	union l1_cache l1i, l1d;
@@ -297,36 +295,9 @@ amd_cpuid4(int index, union _cpuid4_leaf_eax *eax,
 		(ebx->split.ways_of_associativity + 1) - 1;
 }
 
-/*
- * Fill passed _cpuid4_info_regs structure.
- * Intel-only code paths should pass NULL for the amd_northbridge
- * return pointer.
- */
-static int cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4,
-				    struct amd_northbridge **nb)
+static int cpuid4_info_fill_done(struct _cpuid4_info_regs *id4, union _cpuid4_leaf_eax eax,
+				 union _cpuid4_leaf_ebx ebx, union _cpuid4_leaf_ecx ecx)
 {
-	u8 cpu_vendor = boot_cpu_data.x86_vendor;
-	union _cpuid4_leaf_eax eax;
-	union _cpuid4_leaf_ebx ebx;
-	union _cpuid4_leaf_ecx ecx;
-	u32 edx;
-
-	if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) {
-		if (boot_cpu_has(X86_FEATURE_TOPOEXT) || cpu_vendor == X86_VENDOR_HYGON) {
-			/* AMD with TOPOEXT, or HYGON */
-			cpuid_count(0x8000001d, index, &eax.full, &ebx.full, &ecx.full, &edx);
-		} else {
-			/* Legacy AMD fallback */
-			amd_cpuid4(index, &eax, &ebx, &ecx);
-		}
-
-		if (nb)
-			*nb = amd_init_l3_cache(index);
-	} else {
-		/* Intel */
-		cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &edx);
-	}
-
 	if (eax.split.type == CTYPE_NULL)
 		return -EIO;
 
@@ -341,6 +312,42 @@ static int cpuid4_cache_lookup_regs(int index, struct _cpuid4_info_regs *id4,
 	return 0;
 }
 
+static int amd_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	u32 ignored;
+
+	if (boot_cpu_has(X86_FEATURE_TOPOEXT) || boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		cpuid_count(0x8000001d, index, &eax.full, &ebx.full, &ecx.full, &ignored);
+	else
+		legacy_amd_cpuid4(index, &eax, &ebx, &ecx);
+
+	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+}
+
+static int intel_fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	union _cpuid4_leaf_eax eax;
+	union _cpuid4_leaf_ebx ebx;
+	union _cpuid4_leaf_ecx ecx;
+	u32 ignored;
+
+	cpuid_count(4, index, &eax.full, &ebx.full, &ecx.full, &ignored);
+
+	return cpuid4_info_fill_done(id4, eax, ebx, ecx);
+}
+
+static int fill_cpuid4_info(int index, struct _cpuid4_info_regs *id4)
+{
+	u8 cpu_vendor = boot_cpu_data.x86_vendor;
+
+	return (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON) ?
+		amd_fill_cpuid4_info(index, id4) :
+		intel_fill_cpuid4_info(index, id4);
+}
+
 static int find_num_cache_leaves(struct cpuinfo_x86 *c)
 {
 	unsigned int		eax, ebx, ecx, edx, op;
@@ -472,7 +479,7 @@ void init_intel_cacheinfo(struct cpuinfo_x86 *c)
 			struct _cpuid4_info_regs id4 = {};
 			int retval;
 
-			retval = cpuid4_cache_lookup_regs(i, &id4, NULL);
+			retval = intel_fill_cpuid4_info(i, &id4);
 			if (retval < 0)
 				continue;
 
@@ -692,17 +699,23 @@ static void get_cache_id(int cpu, struct _cpuid4_info_regs *id4)
 
 int populate_cache_leaves(unsigned int cpu)
 {
-	unsigned int idx, ret;
 	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
 	struct cacheinfo *ci = this_cpu_ci->info_list;
+	u8 cpu_vendor = boot_cpu_data.x86_vendor;
 	struct _cpuid4_info_regs id4 = {};
-	struct amd_northbridge *nb;
+	struct amd_northbridge *nb = NULL;
+	int idx, ret;
 
 	for (idx = 0; idx < this_cpu_ci->num_leaves; idx++) {
-		ret = cpuid4_cache_lookup_regs(idx, &id4, &nb);
+		ret = fill_cpuid4_info(idx, &id4);
 		if (ret)
 			return ret;
+
 		get_cache_id(cpu, &id4);
+
+		if (cpu_vendor == X86_VENDOR_AMD || cpu_vendor == X86_VENDOR_HYGON)
+			nb = amd_init_l3_cache(idx);
+
 		ci_info_init(ci++, &id4, nb);
 		__cache_cpumap_setup(cpu, idx, &id4);
 	}

