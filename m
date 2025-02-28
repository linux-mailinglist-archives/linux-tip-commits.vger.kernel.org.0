Return-Path: <linux-tip-commits+bounces-3742-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E26A49F64
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 17:53:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65692174B64
	for <lists+linux-tip-commits@lfdr.de>; Fri, 28 Feb 2025 16:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ADB8276027;
	Fri, 28 Feb 2025 16:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J4WJBDZz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BdOBBaYq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F32426F444;
	Fri, 28 Feb 2025 16:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740761619; cv=none; b=A5JHFQopnCUFNtFhR/0bxXyiB88N28nrGcXW7uwA/mbuPOlG8dTSEWX2HfPXDQAOrGcEA/uZgIXX6Ye4AuQ7y+vApUMsfzGo3UDl1rGuG4C4oi1JgTWvQXooIlvkLXmndGT2Tis/B9ZnKJ+6oQJcBhcrzVJv+vDKrpndTYr3wQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740761619; c=relaxed/simple;
	bh=jCeEbPR4yCf9lMck0L3mqWtfy4kue6GJFZeIy+/TVPk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WJkNQik+jW03whZP6oZmWk2kdsUF3Riy6etBAu3+Wqpcg82FHWEHnqPZdXEOYk8s9AvBzW+Zb6D1PrXxwEozzeDNsgjvaRTUu9CIlcuX30h+L5foY8mm1RPgnnkEpXzFBr0pYvo8NQwxh6fVeEy+ncGs5mbQ0+PoBQdlvMPFDqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J4WJBDZz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BdOBBaYq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 28 Feb 2025 16:53:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740761614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhWQcI5KRL5x9wvV1rbJFn8+OvXAtZWDC62iyPlSVnQ=;
	b=J4WJBDZzJnLSYXEStOyfaMazLptP/hF91q1/z25/vpdWyLJngPE1ArnXaxGJ2vJaWCGnAe
	5x4iQddr+VPE38fKa6ZVXzQJUPNc+Fv5PPocwn4CFkWFZpLvzZzcpLrdwQiYMlY4P4BtNp
	MkSZ4RzWcRdYIY/61Mt+8SquQkrg2SF60wyyRn8ZYfNhEGkANuCQ5c4PHXaxrChmjVmguF
	oXwEGeBR0h+S93H9QAaA33Kj4+3ewGIReDJ2hQR78ahIuzW1wUCaXhQiTp7Oa/4aEcM1WW
	jmHZGLSciWQGoZ/k/2V+kxIW/ujtbnALZQYjxNU8hKf0D4it+C0CiED2SbaPmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740761614;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QhWQcI5KRL5x9wvV1rbJFn8+OvXAtZWDC62iyPlSVnQ=;
	b=BdOBBaYqaNvbzIp7GumO2Xt5966ZNB0rKnQ9XXqURR3VDNe/v5qy7IevBIJ0U+Nh4sR+91
	xHY7JpNwe+usSsDA==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpufeatures: Remove {disabled,required}-features.h
Cc: "Xin Li (Intel)" <xin@zytor.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250228082338.73859-5-xin@zytor.com>
References: <20250228082338.73859-5-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174076161402.10177.11448207608290287125.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     d65093f047ed0e942c83d1f299d5674211eda39d
Gitweb:        https://git.kernel.org/tip/d65093f047ed0e942c83d1f299d5674211eda39d
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Fri, 28 Feb 2025 00:23:37 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Feb 2025 12:14:40 +01:00

x86/cpufeatures: Remove {disabled,required}-features.h

The functionalities of {disabled,required}-features.h have been replaced with
the auto-generated header cpufeature_masks.h. Thus they are no longer needed.
So delete them.

None of the macros defined in {disabled,required}-features.h is used in tools,
delete them too.

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250228082338.73859-5-xin@zytor.com
---
 arch/x86/include/asm/disabled-features.h       | 161 +----------------
 arch/x86/include/asm/required-features.h       | 105 +----------
 tools/arch/x86/include/asm/cpufeatures.h       |   8 +-
 tools/arch/x86/include/asm/disabled-features.h | 161 +----------------
 tools/arch/x86/include/asm/required-features.h | 105 +----------
 tools/perf/check-headers.sh                    |   2 +-
 6 files changed, 542 deletions(-)
 delete mode 100644 arch/x86/include/asm/disabled-features.h
 delete mode 100644 arch/x86/include/asm/required-features.h
 delete mode 100644 tools/arch/x86/include/asm/disabled-features.h
 delete mode 100644 tools/arch/x86/include/asm/required-features.h

diff --git a/arch/x86/include/asm/disabled-features.h b/arch/x86/include/asm/disabled-features.h
deleted file mode 100644
index c492bdc..0000000
--- a/arch/x86/include/asm/disabled-features.h
+++ /dev/null
@@ -1,161 +0,0 @@
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#define _ASM_X86_DISABLED_FEATURES_H
-
-/* These features, although they might be available in a CPU
- * will not be used because the compile options to support
- * them are not present.
- *
- * This code allows them to be checked and disabled at
- * compile time without an explicit #ifdef.  Use
- * cpu_feature_enabled().
- */
-
-#ifdef CONFIG_X86_UMIP
-# define DISABLE_UMIP	0
-#else
-# define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
-#endif
-
-#ifdef CONFIG_X86_64
-# define DISABLE_VME		(1<<(X86_FEATURE_VME & 31))
-# define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
-# define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
-# define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
-# define DISABLE_PCID		0
-#else
-# define DISABLE_VME		0
-# define DISABLE_K6_MTRR	0
-# define DISABLE_CYRIX_ARR	0
-# define DISABLE_CENTAUR_MCR	0
-# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
-#endif /* CONFIG_X86_64 */
-
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-# define DISABLE_PKU		0
-# define DISABLE_OSPKE		0
-#else
-# define DISABLE_PKU		(1<<(X86_FEATURE_PKU & 31))
-# define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
-#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
-
-#ifdef CONFIG_X86_5LEVEL
-# define DISABLE_LA57	0
-#else
-# define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
-# define DISABLE_PTI		0
-#else
-# define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETPOLINE
-# define DISABLE_RETPOLINE	0
-#else
-# define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
-				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETHUNK
-# define DISABLE_RETHUNK	0
-#else
-# define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_UNRET_ENTRY
-# define DISABLE_UNRET		0
-#else
-# define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-# define DISABLE_CALL_DEPTH_TRACKING	0
-#else
-# define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
-#endif
-
-#ifdef CONFIG_ADDRESS_MASKING
-# define DISABLE_LAM		0
-#else
-# define DISABLE_LAM		(1 << (X86_FEATURE_LAM & 31))
-#endif
-
-#ifdef CONFIG_INTEL_IOMMU_SVM
-# define DISABLE_ENQCMD		0
-#else
-# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
-#endif
-
-#ifdef CONFIG_X86_SGX
-# define DISABLE_SGX	0
-#else
-# define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
-#endif
-
-#ifdef CONFIG_XEN_PV
-# define DISABLE_XENPV		0
-#else
-# define DISABLE_XENPV		(1 << (X86_FEATURE_XENPV & 31))
-#endif
-
-#ifdef CONFIG_INTEL_TDX_GUEST
-# define DISABLE_TDX_GUEST	0
-#else
-# define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
-#endif
-
-#ifdef CONFIG_X86_USER_SHADOW_STACK
-#define DISABLE_USER_SHSTK	0
-#else
-#define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
-#endif
-
-#ifdef CONFIG_X86_KERNEL_IBT
-#define DISABLE_IBT	0
-#else
-#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
-#endif
-
-#ifdef CONFIG_X86_FRED
-# define DISABLE_FRED	0
-#else
-# define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
-#endif
-
-#ifdef CONFIG_KVM_AMD_SEV
-#define DISABLE_SEV_SNP		0
-#else
-#define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
-#endif
-
-/*
- * Make sure to add features to the correct mask
- */
-#define DISABLED_MASK0	(DISABLE_VME)
-#define DISABLED_MASK1	0
-#define DISABLED_MASK2	0
-#define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	(DISABLE_PCID)
-#define DISABLED_MASK5	0
-#define DISABLED_MASK6	0
-#define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
-#define DISABLED_MASK9	(DISABLE_SGX)
-#define DISABLED_MASK10	0
-#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
-			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
-#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
-#define DISABLED_MASK14	0
-#define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
-#define DISABLED_MASK17	0
-#define DISABLED_MASK18	(DISABLE_IBT)
-#define DISABLED_MASK19	(DISABLE_SEV_SNP)
-#define DISABLED_MASK20	0
-#define DISABLED_MASK21	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
-
-#endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/arch/x86/include/asm/required-features.h b/arch/x86/include/asm/required-features.h
deleted file mode 100644
index 0068133..0000000
--- a/arch/x86/include/asm/required-features.h
+++ /dev/null
@@ -1,105 +0,0 @@
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#define _ASM_X86_REQUIRED_FEATURES_H
-
-/* Define minimum CPUID feature set for kernel These bits are checked
-   really early to actually display a visible error message before the
-   kernel dies.  Make sure to assign features to the proper mask!
-
-   Some requirements that are not in CPUID yet are also in the
-   CONFIG_X86_MINIMUM_CPU_FAMILY which is checked too.
-
-   The real information is in arch/x86/Kconfig.cpu, this just converts
-   the CONFIGs into a bitmask */
-
-#ifndef CONFIG_MATH_EMULATION
-# define NEED_FPU	(1<<(X86_FEATURE_FPU & 31))
-#else
-# define NEED_FPU	0
-#endif
-
-#if defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
-# define NEED_PAE	(1<<(X86_FEATURE_PAE & 31))
-#else
-# define NEED_PAE	0
-#endif
-
-#ifdef CONFIG_X86_CX8
-# define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
-#else
-# define NEED_CX8	0
-#endif
-
-#if defined(CONFIG_X86_CMOV) || defined(CONFIG_X86_64)
-# define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
-#else
-# define NEED_CMOV	0
-#endif
-
-# define NEED_3DNOW	0
-
-#if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
-# define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
-#else
-# define NEED_NOPL	0
-#endif
-
-#ifdef CONFIG_MATOM
-# define NEED_MOVBE	(1<<(X86_FEATURE_MOVBE & 31))
-#else
-# define NEED_MOVBE	0
-#endif
-
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
-/* Paravirtualized systems may not have PSE or PGE available */
-#define NEED_PSE	0
-#define NEED_PGE	0
-#else
-#define NEED_PSE	(1<<(X86_FEATURE_PSE) & 31)
-#define NEED_PGE	(1<<(X86_FEATURE_PGE) & 31)
-#endif
-#define NEED_MSR	(1<<(X86_FEATURE_MSR & 31))
-#define NEED_FXSR	(1<<(X86_FEATURE_FXSR & 31))
-#define NEED_XMM	(1<<(X86_FEATURE_XMM & 31))
-#define NEED_XMM2	(1<<(X86_FEATURE_XMM2 & 31))
-#define NEED_LM		(1<<(X86_FEATURE_LM & 31))
-#else
-#define NEED_PSE	0
-#define NEED_MSR	0
-#define NEED_PGE	0
-#define NEED_FXSR	0
-#define NEED_XMM	0
-#define NEED_XMM2	0
-#define NEED_LM		0
-#endif
-
-#define REQUIRED_MASK0	(NEED_FPU|NEED_PSE|NEED_MSR|NEED_PAE|\
-			 NEED_CX8|NEED_PGE|NEED_FXSR|NEED_CMOV|\
-			 NEED_XMM|NEED_XMM2)
-#define SSE_MASK	(NEED_XMM|NEED_XMM2)
-
-#define REQUIRED_MASK1	(NEED_LM|NEED_3DNOW)
-
-#define REQUIRED_MASK2	0
-#define REQUIRED_MASK3	(NEED_NOPL)
-#define REQUIRED_MASK4	(NEED_MOVBE)
-#define REQUIRED_MASK5	0
-#define REQUIRED_MASK6	0
-#define REQUIRED_MASK7	0
-#define REQUIRED_MASK8	0
-#define REQUIRED_MASK9	0
-#define REQUIRED_MASK10	0
-#define REQUIRED_MASK11	0
-#define REQUIRED_MASK12	0
-#define REQUIRED_MASK13	0
-#define REQUIRED_MASK14	0
-#define REQUIRED_MASK15	0
-#define REQUIRED_MASK16	0
-#define REQUIRED_MASK17	0
-#define REQUIRED_MASK18	0
-#define REQUIRED_MASK19	0
-#define REQUIRED_MASK20	0
-#define REQUIRED_MASK21	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
-
-#endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 17b6590..c691481 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -2,14 +2,6 @@
 #ifndef _ASM_X86_CPUFEATURES_H
 #define _ASM_X86_CPUFEATURES_H
 
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#include <asm/required-features.h>
-#endif
-
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#include <asm/disabled-features.h>
-#endif
-
 /*
  * Defines x86 CPU feature bits
  */
diff --git a/tools/arch/x86/include/asm/disabled-features.h b/tools/arch/x86/include/asm/disabled-features.h
deleted file mode 100644
index c492bdc..0000000
--- a/tools/arch/x86/include/asm/disabled-features.h
+++ /dev/null
@@ -1,161 +0,0 @@
-#ifndef _ASM_X86_DISABLED_FEATURES_H
-#define _ASM_X86_DISABLED_FEATURES_H
-
-/* These features, although they might be available in a CPU
- * will not be used because the compile options to support
- * them are not present.
- *
- * This code allows them to be checked and disabled at
- * compile time without an explicit #ifdef.  Use
- * cpu_feature_enabled().
- */
-
-#ifdef CONFIG_X86_UMIP
-# define DISABLE_UMIP	0
-#else
-# define DISABLE_UMIP	(1<<(X86_FEATURE_UMIP & 31))
-#endif
-
-#ifdef CONFIG_X86_64
-# define DISABLE_VME		(1<<(X86_FEATURE_VME & 31))
-# define DISABLE_K6_MTRR	(1<<(X86_FEATURE_K6_MTRR & 31))
-# define DISABLE_CYRIX_ARR	(1<<(X86_FEATURE_CYRIX_ARR & 31))
-# define DISABLE_CENTAUR_MCR	(1<<(X86_FEATURE_CENTAUR_MCR & 31))
-# define DISABLE_PCID		0
-#else
-# define DISABLE_VME		0
-# define DISABLE_K6_MTRR	0
-# define DISABLE_CYRIX_ARR	0
-# define DISABLE_CENTAUR_MCR	0
-# define DISABLE_PCID		(1<<(X86_FEATURE_PCID & 31))
-#endif /* CONFIG_X86_64 */
-
-#ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
-# define DISABLE_PKU		0
-# define DISABLE_OSPKE		0
-#else
-# define DISABLE_PKU		(1<<(X86_FEATURE_PKU & 31))
-# define DISABLE_OSPKE		(1<<(X86_FEATURE_OSPKE & 31))
-#endif /* CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS */
-
-#ifdef CONFIG_X86_5LEVEL
-# define DISABLE_LA57	0
-#else
-# define DISABLE_LA57	(1<<(X86_FEATURE_LA57 & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_PAGE_TABLE_ISOLATION
-# define DISABLE_PTI		0
-#else
-# define DISABLE_PTI		(1 << (X86_FEATURE_PTI & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETPOLINE
-# define DISABLE_RETPOLINE	0
-#else
-# define DISABLE_RETPOLINE	((1 << (X86_FEATURE_RETPOLINE & 31)) | \
-				 (1 << (X86_FEATURE_RETPOLINE_LFENCE & 31)))
-#endif
-
-#ifdef CONFIG_MITIGATION_RETHUNK
-# define DISABLE_RETHUNK	0
-#else
-# define DISABLE_RETHUNK	(1 << (X86_FEATURE_RETHUNK & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_UNRET_ENTRY
-# define DISABLE_UNRET		0
-#else
-# define DISABLE_UNRET		(1 << (X86_FEATURE_UNRET & 31))
-#endif
-
-#ifdef CONFIG_MITIGATION_CALL_DEPTH_TRACKING
-# define DISABLE_CALL_DEPTH_TRACKING	0
-#else
-# define DISABLE_CALL_DEPTH_TRACKING	(1 << (X86_FEATURE_CALL_DEPTH & 31))
-#endif
-
-#ifdef CONFIG_ADDRESS_MASKING
-# define DISABLE_LAM		0
-#else
-# define DISABLE_LAM		(1 << (X86_FEATURE_LAM & 31))
-#endif
-
-#ifdef CONFIG_INTEL_IOMMU_SVM
-# define DISABLE_ENQCMD		0
-#else
-# define DISABLE_ENQCMD		(1 << (X86_FEATURE_ENQCMD & 31))
-#endif
-
-#ifdef CONFIG_X86_SGX
-# define DISABLE_SGX	0
-#else
-# define DISABLE_SGX	(1 << (X86_FEATURE_SGX & 31))
-#endif
-
-#ifdef CONFIG_XEN_PV
-# define DISABLE_XENPV		0
-#else
-# define DISABLE_XENPV		(1 << (X86_FEATURE_XENPV & 31))
-#endif
-
-#ifdef CONFIG_INTEL_TDX_GUEST
-# define DISABLE_TDX_GUEST	0
-#else
-# define DISABLE_TDX_GUEST	(1 << (X86_FEATURE_TDX_GUEST & 31))
-#endif
-
-#ifdef CONFIG_X86_USER_SHADOW_STACK
-#define DISABLE_USER_SHSTK	0
-#else
-#define DISABLE_USER_SHSTK	(1 << (X86_FEATURE_USER_SHSTK & 31))
-#endif
-
-#ifdef CONFIG_X86_KERNEL_IBT
-#define DISABLE_IBT	0
-#else
-#define DISABLE_IBT	(1 << (X86_FEATURE_IBT & 31))
-#endif
-
-#ifdef CONFIG_X86_FRED
-# define DISABLE_FRED	0
-#else
-# define DISABLE_FRED	(1 << (X86_FEATURE_FRED & 31))
-#endif
-
-#ifdef CONFIG_KVM_AMD_SEV
-#define DISABLE_SEV_SNP		0
-#else
-#define DISABLE_SEV_SNP		(1 << (X86_FEATURE_SEV_SNP & 31))
-#endif
-
-/*
- * Make sure to add features to the correct mask
- */
-#define DISABLED_MASK0	(DISABLE_VME)
-#define DISABLED_MASK1	0
-#define DISABLED_MASK2	0
-#define DISABLED_MASK3	(DISABLE_CYRIX_ARR|DISABLE_CENTAUR_MCR|DISABLE_K6_MTRR)
-#define DISABLED_MASK4	(DISABLE_PCID)
-#define DISABLED_MASK5	0
-#define DISABLED_MASK6	0
-#define DISABLED_MASK7	(DISABLE_PTI)
-#define DISABLED_MASK8	(DISABLE_XENPV|DISABLE_TDX_GUEST)
-#define DISABLED_MASK9	(DISABLE_SGX)
-#define DISABLED_MASK10	0
-#define DISABLED_MASK11	(DISABLE_RETPOLINE|DISABLE_RETHUNK|DISABLE_UNRET| \
-			 DISABLE_CALL_DEPTH_TRACKING|DISABLE_USER_SHSTK)
-#define DISABLED_MASK12	(DISABLE_FRED|DISABLE_LAM)
-#define DISABLED_MASK13	0
-#define DISABLED_MASK14	0
-#define DISABLED_MASK15	0
-#define DISABLED_MASK16	(DISABLE_PKU|DISABLE_OSPKE|DISABLE_LA57|DISABLE_UMIP| \
-			 DISABLE_ENQCMD)
-#define DISABLED_MASK17	0
-#define DISABLED_MASK18	(DISABLE_IBT)
-#define DISABLED_MASK19	(DISABLE_SEV_SNP)
-#define DISABLED_MASK20	0
-#define DISABLED_MASK21	0
-#define DISABLED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
-
-#endif /* _ASM_X86_DISABLED_FEATURES_H */
diff --git a/tools/arch/x86/include/asm/required-features.h b/tools/arch/x86/include/asm/required-features.h
deleted file mode 100644
index 0068133..0000000
--- a/tools/arch/x86/include/asm/required-features.h
+++ /dev/null
@@ -1,105 +0,0 @@
-#ifndef _ASM_X86_REQUIRED_FEATURES_H
-#define _ASM_X86_REQUIRED_FEATURES_H
-
-/* Define minimum CPUID feature set for kernel These bits are checked
-   really early to actually display a visible error message before the
-   kernel dies.  Make sure to assign features to the proper mask!
-
-   Some requirements that are not in CPUID yet are also in the
-   CONFIG_X86_MINIMUM_CPU_FAMILY which is checked too.
-
-   The real information is in arch/x86/Kconfig.cpu, this just converts
-   the CONFIGs into a bitmask */
-
-#ifndef CONFIG_MATH_EMULATION
-# define NEED_FPU	(1<<(X86_FEATURE_FPU & 31))
-#else
-# define NEED_FPU	0
-#endif
-
-#if defined(CONFIG_X86_PAE) || defined(CONFIG_X86_64)
-# define NEED_PAE	(1<<(X86_FEATURE_PAE & 31))
-#else
-# define NEED_PAE	0
-#endif
-
-#ifdef CONFIG_X86_CX8
-# define NEED_CX8	(1<<(X86_FEATURE_CX8 & 31))
-#else
-# define NEED_CX8	0
-#endif
-
-#if defined(CONFIG_X86_CMOV) || defined(CONFIG_X86_64)
-# define NEED_CMOV	(1<<(X86_FEATURE_CMOV & 31))
-#else
-# define NEED_CMOV	0
-#endif
-
-# define NEED_3DNOW	0
-
-#if defined(CONFIG_X86_P6_NOP) || defined(CONFIG_X86_64)
-# define NEED_NOPL	(1<<(X86_FEATURE_NOPL & 31))
-#else
-# define NEED_NOPL	0
-#endif
-
-#ifdef CONFIG_MATOM
-# define NEED_MOVBE	(1<<(X86_FEATURE_MOVBE & 31))
-#else
-# define NEED_MOVBE	0
-#endif
-
-#ifdef CONFIG_X86_64
-#ifdef CONFIG_PARAVIRT_XXL
-/* Paravirtualized systems may not have PSE or PGE available */
-#define NEED_PSE	0
-#define NEED_PGE	0
-#else
-#define NEED_PSE	(1<<(X86_FEATURE_PSE) & 31)
-#define NEED_PGE	(1<<(X86_FEATURE_PGE) & 31)
-#endif
-#define NEED_MSR	(1<<(X86_FEATURE_MSR & 31))
-#define NEED_FXSR	(1<<(X86_FEATURE_FXSR & 31))
-#define NEED_XMM	(1<<(X86_FEATURE_XMM & 31))
-#define NEED_XMM2	(1<<(X86_FEATURE_XMM2 & 31))
-#define NEED_LM		(1<<(X86_FEATURE_LM & 31))
-#else
-#define NEED_PSE	0
-#define NEED_MSR	0
-#define NEED_PGE	0
-#define NEED_FXSR	0
-#define NEED_XMM	0
-#define NEED_XMM2	0
-#define NEED_LM		0
-#endif
-
-#define REQUIRED_MASK0	(NEED_FPU|NEED_PSE|NEED_MSR|NEED_PAE|\
-			 NEED_CX8|NEED_PGE|NEED_FXSR|NEED_CMOV|\
-			 NEED_XMM|NEED_XMM2)
-#define SSE_MASK	(NEED_XMM|NEED_XMM2)
-
-#define REQUIRED_MASK1	(NEED_LM|NEED_3DNOW)
-
-#define REQUIRED_MASK2	0
-#define REQUIRED_MASK3	(NEED_NOPL)
-#define REQUIRED_MASK4	(NEED_MOVBE)
-#define REQUIRED_MASK5	0
-#define REQUIRED_MASK6	0
-#define REQUIRED_MASK7	0
-#define REQUIRED_MASK8	0
-#define REQUIRED_MASK9	0
-#define REQUIRED_MASK10	0
-#define REQUIRED_MASK11	0
-#define REQUIRED_MASK12	0
-#define REQUIRED_MASK13	0
-#define REQUIRED_MASK14	0
-#define REQUIRED_MASK15	0
-#define REQUIRED_MASK16	0
-#define REQUIRED_MASK17	0
-#define REQUIRED_MASK18	0
-#define REQUIRED_MASK19	0
-#define REQUIRED_MASK20	0
-#define REQUIRED_MASK21	0
-#define REQUIRED_MASK_CHECK BUILD_BUG_ON_ZERO(NCAPINTS != 22)
-
-#endif /* _ASM_X86_REQUIRED_FEATURES_H */
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index d3c6e10..a4499e5 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -26,8 +26,6 @@ FILES=(
   "include/linux/hash.h"
   "include/linux/list-sort.h"
   "include/uapi/linux/hw_breakpoint.h"
-  "arch/x86/include/asm/disabled-features.h"
-  "arch/x86/include/asm/required-features.h"
   "arch/x86/include/asm/cpufeatures.h"
   "arch/x86/include/asm/inat_types.h"
   "arch/x86/include/asm/emulate_prefix.h"

