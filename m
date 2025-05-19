Return-Path: <linux-tip-commits+bounces-5670-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AC8ABBE63
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 May 2025 14:55:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16BF7174238
	for <lists+linux-tip-commits@lfdr.de>; Mon, 19 May 2025 12:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ABD31DE4C4;
	Mon, 19 May 2025 12:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qDnpC5Pz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YMryAjt8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECEAA55;
	Mon, 19 May 2025 12:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747659328; cv=none; b=Rx8eyr3KdPZMhdUzmOEQmg7rG9qma26BG9C3HajuhnT39/7vDVyONcDhuIlUSSNPr5/fonV5q5s2R6UjNKm82zAn8eZcKvpHCytRM68QJGWIXPztsUmx9WtYxOUvlfT8wP0XFkM9MPHROy2QErjeZhSts42JWTepjB8Qb7ytve4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747659328; c=relaxed/simple;
	bh=nqyTvZnuN0HY7wJI7LSdFcsCCyDBoE9iuykTtH/rF4s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tjuyo0BK5G36y4e5mHHvKzR1zkuP3bmACO2yUArfDH6789qgq4dYNY2aZRcQOy8hjhTo7B2//wGh9RJhYGlA3KM6bhsGXuv0t+nw98aloASaqDS4qv3ohlaY+4XXtMrRykicIMA4j4O/Fw3lFoMbWxFqI7ajNugltfVuuULP8es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qDnpC5Pz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YMryAjt8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 19 May 2025 12:55:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747659323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAoqUZLxB1cNDmjrU0QVE8Kkin+DY8geZSdxsOxiqKA=;
	b=qDnpC5PzhOTeF5Yl/zSyXWxLfDuGh9BEG0O3yzXaVqRjzCQpHu+VCFfc6zpY5fxV0iXrMO
	eV8OmaOxArp5eTELciExrL0KSNxTCNczgyhFZ0381akqoDqFNbpBBuDW+e/6uuwOvJRvmX
	tLfYhSgCsYuV7rcjWT6CpWM9hbVDQ5TTC/sAHKWqr9e7V1VAxDsYds3GKVIhlifXCKKQJU
	oFfq0frhxZyBhO0IKzrRtCuph89iqBDRreiNQjg79jWRsdi9WLTIgok0LMi3CCTKKwjYNM
	+00oUDClLIdypuDovwOmo+mS6pspXAwo7PdTNHWUe9NZP9y4XACSMwmF4pbWzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747659323;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MAoqUZLxB1cNDmjrU0QVE8Kkin+DY8geZSdxsOxiqKA=;
	b=YMryAjt8b6f2FQA+Di9odtcp/5G40bdFSu7BCo5bYiSKgOLZ8znU9BbqBkN4FnxmTYQaVw
	OmQhbd/Nf8yBd+Dg==
From: "tip-bot2 for Ard Biesheuvel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/cpu: Use a new feature flag for 5-level paging
Cc: Ard Biesheuvel <ardb@kernel.org>, Ingo Molnar <mingo@kernel.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>,
 Andrew Cooper <andrew.cooper3@citrix.com>, Brian Gerst <brgerst@gmail.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Juergen Gross <jgross@suse.com>, "Kirill A. Shutemov" <kirill@shutemov.name>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250517091639.3807875-9-ardb+git@google.com>
References: <20250517091639.3807875-9-ardb+git@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174765932243.406.15487430117390098144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     ae41ee699c6c89850d11ba64a282490f287d9be7
Gitweb:        https://git.kernel.org/tip/ae41ee699c6c89850d11ba64a282490f287d9be7
Author:        Ard Biesheuvel <ardb@kernel.org>
AuthorDate:    Sat, 17 May 2025 11:16:41 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 19 May 2025 10:37:21 +02:00

x86/cpu: Use a new feature flag for 5-level paging

Currently, the LA57 CPU feature flag is taken to mean two different
things at once:

 - Whether the CPU implements the LA57 extension, and is therefore
   capable of supporting 5-level paging;

 - whether 5-level paging is currently in use.

This means the LA57 capability of the hardware is hidden when a LA57
capable CPU is forced to run with 4-level paging. It also means the
the ordinary CPU capability detection code will happily set the LA57
capability and it needs to be cleared explicitly afterwards to avoid
inconsistencies.

Separate the two so that the CPU hardware capability can be identified
unambigously in all cases.

The 'la57' flag's behavior in /proc/cpuinfo remains unchanged.

Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Ahmed S. Darwish <darwi@linutronix.de>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: Kirill A. Shutemov <kirill@shutemov.name>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250517091639.3807875-9-ardb+git@google.com
---
 arch/x86/include/asm/cpufeatures.h      |  3 ++-
 arch/x86/include/asm/page_64.h          |  2 +-
 arch/x86/include/asm/pgtable_64_types.h |  2 +-
 arch/x86/kernel/cpu/common.c            | 16 ++--------------
 drivers/iommu/amd/init.c                |  4 ++--
 drivers/iommu/intel/svm.c               |  4 ++--
 6 files changed, 10 insertions(+), 21 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index f67a93f..5c19bee 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -395,7 +395,7 @@
 #define X86_FEATURE_AVX512_BITALG	(16*32+12) /* "avx512_bitalg" Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
 #define X86_FEATURE_TME			(16*32+13) /* "tme" Intel Total Memory Encryption */
 #define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* "avx512_vpopcntdq" POPCNT for vectors of DW/QW */
-#define X86_FEATURE_LA57		(16*32+16) /* "la57" 5-level page tables */
+#define X86_FEATURE_LA57		(16*32+16) /* 57-bit linear addressing */
 #define X86_FEATURE_RDPID		(16*32+22) /* "rdpid" RDPID instruction */
 #define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* "bus_lock_detect" Bus Lock detect */
 #define X86_FEATURE_CLDEMOTE		(16*32+25) /* "cldemote" CLDEMOTE instruction */
@@ -483,6 +483,7 @@
 #define X86_FEATURE_PREFER_YMM		(21*32+ 8) /* Avoid ZMM registers due to downclocking */
 #define X86_FEATURE_APX			(21*32+ 9) /* Advanced Performance Extensions */
 #define X86_FEATURE_INDIRECT_THUNK_ITS	(21*32+10) /* Use thunk for indirect branches in lower half of cacheline */
+#define X86_FEATURE_5LEVEL_PAGING	(21*32+11) /* "la57" Whether 5 levels of page tables are in use */
 
 /*
  * BUG word(s)
diff --git a/arch/x86/include/asm/page_64.h b/arch/x86/include/asm/page_64.h
index 015d23f..754be17 100644
--- a/arch/x86/include/asm/page_64.h
+++ b/arch/x86/include/asm/page_64.h
@@ -85,7 +85,7 @@ static __always_inline unsigned long task_size_max(void)
 	unsigned long ret;
 
 	alternative_io("movq %[small],%0","movq %[large],%0",
-			X86_FEATURE_LA57,
+			X86_FEATURE_5LEVEL_PAGING,
 			"=r" (ret),
 			[small] "i" ((1ul << 47)-PAGE_SIZE),
 			[large] "i" ((1ul << 56)-PAGE_SIZE));
diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
index 4604f92..9217688 100644
--- a/arch/x86/include/asm/pgtable_64_types.h
+++ b/arch/x86/include/asm/pgtable_64_types.h
@@ -33,7 +33,7 @@ static inline bool pgtable_l5_enabled(void)
 	return __pgtable_l5_enabled;
 }
 #else
-#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_LA57)
+#define pgtable_l5_enabled() cpu_feature_enabled(X86_FEATURE_5LEVEL_PAGING)
 #endif /* USE_EARLY_PGTABLE_L5 */
 
 extern unsigned int pgdir_shift;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 8feb8fd..67cdbd9 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1755,20 +1755,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	setup_clear_cpu_cap(X86_FEATURE_PCID);
 #endif
 
-	/*
-	 * Later in the boot process pgtable_l5_enabled() relies on
-	 * cpu_feature_enabled(X86_FEATURE_LA57). If 5-level paging is not
-	 * enabled by this point we need to clear the feature bit to avoid
-	 * false-positives at the later stage.
-	 *
-	 * pgtable_l5_enabled() can be false here for several reasons:
-	 *  - 5-level paging is disabled compile-time;
-	 *  - it's 32-bit kernel;
-	 *  - machine doesn't support 5-level paging;
-	 *  - user specified 'no5lvl' in kernel command line.
-	 */
-	if (!pgtable_l5_enabled())
-		setup_clear_cpu_cap(X86_FEATURE_LA57);
+	if (native_read_cr4() & X86_CR4_LA57)
+		setup_force_cpu_cap(X86_FEATURE_5LEVEL_PAGING);
 
 	detect_nopl();
 }
diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 14aa0d7..083fca8 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3084,7 +3084,7 @@ static int __init early_amd_iommu_init(void)
 		goto out;
 
 	/* 5 level guest page table */
-	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	if (cpu_feature_enabled(X86_FEATURE_5LEVEL_PAGING) &&
 	    FIELD_GET(FEATURE_GATS, amd_iommu_efr) == GUEST_PGTABLE_5_LEVEL)
 		amd_iommu_gpt_level = PAGE_MODE_5_LEVEL;
 
@@ -3691,7 +3691,7 @@ __setup("ivrs_acpihid",		parse_ivrs_acpihid);
 bool amd_iommu_pasid_supported(void)
 {
 	/* CPU page table size should match IOMMU guest page table size */
-	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	if (cpu_feature_enabled(X86_FEATURE_5LEVEL_PAGING) &&
 	    amd_iommu_gpt_level != PAGE_MODE_5_LEVEL)
 		return false;
 
diff --git a/drivers/iommu/intel/svm.c b/drivers/iommu/intel/svm.c
index ba93123..1f615e6 100644
--- a/drivers/iommu/intel/svm.c
+++ b/drivers/iommu/intel/svm.c
@@ -37,7 +37,7 @@ void intel_svm_check(struct intel_iommu *iommu)
 		return;
 	}
 
-	if (cpu_feature_enabled(X86_FEATURE_LA57) &&
+	if (cpu_feature_enabled(X86_FEATURE_5LEVEL_PAGING) &&
 	    !cap_fl5lp_support(iommu->cap)) {
 		pr_err("%s SVM disabled, incompatible paging mode\n",
 		       iommu->name);
@@ -165,7 +165,7 @@ static int intel_svm_set_dev_pasid(struct iommu_domain *domain,
 		return PTR_ERR(dev_pasid);
 
 	/* Setup the pasid table: */
-	sflags = cpu_feature_enabled(X86_FEATURE_LA57) ? PASID_FLAG_FL5LP : 0;
+	sflags = cpu_feature_enabled(X86_FEATURE_5LEVEL_PAGING) ? PASID_FLAG_FL5LP : 0;
 	ret = __domain_setup_first_level(iommu, dev, pasid,
 					 FLPT_DEFAULT_DID, mm->pgd,
 					 sflags, old);

