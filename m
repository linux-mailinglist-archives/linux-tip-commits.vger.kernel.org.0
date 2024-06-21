Return-Path: <linux-tip-commits+bounces-1479-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99292912276
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 12:31:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A60828B011
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Jun 2024 10:31:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5627476034;
	Fri, 21 Jun 2024 10:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xCuEbi1D";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9lu8+SfY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A0824B3;
	Fri, 21 Jun 2024 10:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718965902; cv=none; b=iJuIiN5M99KLVvRpoTNOkVxvoSqjoRXCWLHLrazSGU4LiLGEccIdqPF6rw5gE4rb3/9iEBmt1lViorOuZPOGego3tpuhDqssrPZflL2jw3uMRkZ26ld6+cxVJnoioaQkB+udMexirnX595zlVNzgBKFFHO+0DpOw83+9M8R9lFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718965902; c=relaxed/simple;
	bh=mi8wvGBxyetl8JbipekX8Dn23hCcy+Wb2fzMG7wtDEY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gTuWMaOTwrz6EeCU3XeSJQ5WhmlfjTYxIsGEkBEObQ2MdB8TRWwR48ZEsMqowKgEgiVE4fSukusPf3JntF5sdqOLlyZCA1wQH9iqG+X10fsawB3Ve4y4XEOETCdHUGc90RPnGypImXQxq2cyfxBrlx4GBXNJvgMaqye+0qvvVXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xCuEbi1D; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9lu8+SfY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Jun 2024 10:31:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718965896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nf4qsA03mNfMDhDOdnf0sCICoSo6OR+7uHtHspCKEl8=;
	b=xCuEbi1DEPf3ll792qgktMpOOBQYLEG5m55q7dDzSQL18RL2HD0LzdDoBaZ2vCn6lRCwPd
	LZdSUyo2VsHsn82D0qboNyhaMhPnODVYi2PpoXCqCcYXagdF+ZBxp/SFTovMZuRk9k/1ZR
	CH5mxy3bcJoOptow8qpf1ZzaAFwg2DOczpTqX1wuPahMEZLkdwoTpVekmOpV8Sy3PWvhe6
	O+h0Za93a5pWf+IqPLr7qVSMKiTEOD8RBYsWMAfqH8eKaIGtQP0b4J2gxK6sJKGmVkoD56
	XXdMm1KkOArO2LLVO3m4jC7DLmWCDBoTQsrOC3XGTaBBbjdX/4fi8lDJR5yS/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718965896;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nf4qsA03mNfMDhDOdnf0sCICoSo6OR+7uHtHspCKEl8=;
	b=9lu8+SfYUNDvWilzoYPB5i2Z/zLarcckoqcwY6pLQu5AHLcCa9ndA97iJ9izxoJlr5tRFC
	nylM2d/WD8zr3mCA==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/cpufeatures: Flip the /proc/cpuinfo appearance logic
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240618113840.24163-1-bp@kernel.org>
References: <20240618113840.24163-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171896589560.10875.17795573311375152040.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     78ce84b9e0a54a0c91a7449f321c1f852c0cd3fc
Gitweb:        https://git.kernel.org/tip/78ce84b9e0a54a0c91a7449f321c1f852c0cd3fc
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Thu, 20 Jun 2024 20:47:46 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 20 Jun 2024 21:04:22 +02:00

x86/cpufeatures: Flip the /proc/cpuinfo appearance logic

I'm getting tired of telling people to put a magic "" in the

  #define X86_FEATURE		/* "" ... */

comment to hide the new feature flag from the user-visible
/proc/cpuinfo.

Flip the logic to make it explicit: an explicit "<name>" in the comment
adds the flag to /proc/cpuinfo and otherwise not, by default.

Add the "<name>" of all the existing flags to keep backwards
compatibility with userspace.

There should be no functional changes resulting from this.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20240618113840.24163-1-bp@kernel.org
---
 arch/x86/include/asm/cpufeatures.h | 800 ++++++++++++++--------------
 arch/x86/include/asm/vmxfeatures.h | 110 ++--
 arch/x86/kernel/cpu/mkcapflags.sh  |   3 +-
 3 files changed, 456 insertions(+), 457 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 3c74343..a1dd810 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -18,170 +18,170 @@
 
 /*
  * Note: If the comment begins with a quoted string, that string is used
- * in /proc/cpuinfo instead of the macro name.  If the string is "",
- * this feature bit is not displayed in /proc/cpuinfo at all.
+ * in /proc/cpuinfo instead of the macro name.  Otherwise, this feature
+ * bit is not displayed in /proc/cpuinfo at all.
  *
  * When adding new features here that depend on other features,
  * please update the table in kernel/cpu/cpuid-deps.c as well.
  */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (EDX), word 0 */
-#define X86_FEATURE_FPU			( 0*32+ 0) /* Onboard FPU */
-#define X86_FEATURE_VME			( 0*32+ 1) /* Virtual Mode Extensions */
-#define X86_FEATURE_DE			( 0*32+ 2) /* Debugging Extensions */
-#define X86_FEATURE_PSE			( 0*32+ 3) /* Page Size Extensions */
-#define X86_FEATURE_TSC			( 0*32+ 4) /* Time Stamp Counter */
-#define X86_FEATURE_MSR			( 0*32+ 5) /* Model-Specific Registers */
-#define X86_FEATURE_PAE			( 0*32+ 6) /* Physical Address Extensions */
-#define X86_FEATURE_MCE			( 0*32+ 7) /* Machine Check Exception */
-#define X86_FEATURE_CX8			( 0*32+ 8) /* CMPXCHG8 instruction */
-#define X86_FEATURE_APIC		( 0*32+ 9) /* Onboard APIC */
-#define X86_FEATURE_SEP			( 0*32+11) /* SYSENTER/SYSEXIT */
-#define X86_FEATURE_MTRR		( 0*32+12) /* Memory Type Range Registers */
-#define X86_FEATURE_PGE			( 0*32+13) /* Page Global Enable */
-#define X86_FEATURE_MCA			( 0*32+14) /* Machine Check Architecture */
-#define X86_FEATURE_CMOV		( 0*32+15) /* CMOV instructions (plus FCMOVcc, FCOMI with FPU) */
-#define X86_FEATURE_PAT			( 0*32+16) /* Page Attribute Table */
-#define X86_FEATURE_PSE36		( 0*32+17) /* 36-bit PSEs */
-#define X86_FEATURE_PN			( 0*32+18) /* Processor serial number */
-#define X86_FEATURE_CLFLUSH		( 0*32+19) /* CLFLUSH instruction */
+#define X86_FEATURE_FPU			( 0*32+ 0) /* "fpu" Onboard FPU */
+#define X86_FEATURE_VME			( 0*32+ 1) /* "vme" Virtual Mode Extensions */
+#define X86_FEATURE_DE			( 0*32+ 2) /* "de" Debugging Extensions */
+#define X86_FEATURE_PSE			( 0*32+ 3) /* "pse" Page Size Extensions */
+#define X86_FEATURE_TSC			( 0*32+ 4) /* "tsc" Time Stamp Counter */
+#define X86_FEATURE_MSR			( 0*32+ 5) /* "msr" Model-Specific Registers */
+#define X86_FEATURE_PAE			( 0*32+ 6) /* "pae" Physical Address Extensions */
+#define X86_FEATURE_MCE			( 0*32+ 7) /* "mce" Machine Check Exception */
+#define X86_FEATURE_CX8			( 0*32+ 8) /* "cx8" CMPXCHG8 instruction */
+#define X86_FEATURE_APIC		( 0*32+ 9) /* "apic" Onboard APIC */
+#define X86_FEATURE_SEP			( 0*32+11) /* "sep" SYSENTER/SYSEXIT */
+#define X86_FEATURE_MTRR		( 0*32+12) /* "mtrr" Memory Type Range Registers */
+#define X86_FEATURE_PGE			( 0*32+13) /* "pge" Page Global Enable */
+#define X86_FEATURE_MCA			( 0*32+14) /* "mca" Machine Check Architecture */
+#define X86_FEATURE_CMOV		( 0*32+15) /* "cmov" CMOV instructions (plus FCMOVcc, FCOMI with FPU) */
+#define X86_FEATURE_PAT			( 0*32+16) /* "pat" Page Attribute Table */
+#define X86_FEATURE_PSE36		( 0*32+17) /* "pse36" 36-bit PSEs */
+#define X86_FEATURE_PN			( 0*32+18) /* "pn" Processor serial number */
+#define X86_FEATURE_CLFLUSH		( 0*32+19) /* "clflush" CLFLUSH instruction */
 #define X86_FEATURE_DS			( 0*32+21) /* "dts" Debug Store */
-#define X86_FEATURE_ACPI		( 0*32+22) /* ACPI via MSR */
-#define X86_FEATURE_MMX			( 0*32+23) /* Multimedia Extensions */
-#define X86_FEATURE_FXSR		( 0*32+24) /* FXSAVE/FXRSTOR, CR4.OSFXSR */
+#define X86_FEATURE_ACPI		( 0*32+22) /* "acpi" ACPI via MSR */
+#define X86_FEATURE_MMX			( 0*32+23) /* "mmx" Multimedia Extensions */
+#define X86_FEATURE_FXSR		( 0*32+24) /* "fxsr" FXSAVE/FXRSTOR, CR4.OSFXSR */
 #define X86_FEATURE_XMM			( 0*32+25) /* "sse" */
 #define X86_FEATURE_XMM2		( 0*32+26) /* "sse2" */
 #define X86_FEATURE_SELFSNOOP		( 0*32+27) /* "ss" CPU self snoop */
-#define X86_FEATURE_HT			( 0*32+28) /* Hyper-Threading */
+#define X86_FEATURE_HT			( 0*32+28) /* "ht" Hyper-Threading */
 #define X86_FEATURE_ACC			( 0*32+29) /* "tm" Automatic clock control */
-#define X86_FEATURE_IA64		( 0*32+30) /* IA-64 processor */
-#define X86_FEATURE_PBE			( 0*32+31) /* Pending Break Enable */
+#define X86_FEATURE_IA64		( 0*32+30) /* "ia64" IA-64 processor */
+#define X86_FEATURE_PBE			( 0*32+31) /* "pbe" Pending Break Enable */
 
 /* AMD-defined CPU features, CPUID level 0x80000001, word 1 */
 /* Don't duplicate feature flags which are redundant with Intel! */
-#define X86_FEATURE_SYSCALL		( 1*32+11) /* SYSCALL/SYSRET */
-#define X86_FEATURE_MP			( 1*32+19) /* MP Capable */
-#define X86_FEATURE_NX			( 1*32+20) /* Execute Disable */
-#define X86_FEATURE_MMXEXT		( 1*32+22) /* AMD MMX extensions */
-#define X86_FEATURE_FXSR_OPT		( 1*32+25) /* FXSAVE/FXRSTOR optimizations */
+#define X86_FEATURE_SYSCALL		( 1*32+11) /* "syscall" SYSCALL/SYSRET */
+#define X86_FEATURE_MP			( 1*32+19) /* "mp" MP Capable */
+#define X86_FEATURE_NX			( 1*32+20) /* "nx" Execute Disable */
+#define X86_FEATURE_MMXEXT		( 1*32+22) /* "mmxext" AMD MMX extensions */
+#define X86_FEATURE_FXSR_OPT		( 1*32+25) /* "fxsr_opt" FXSAVE/FXRSTOR optimizations */
 #define X86_FEATURE_GBPAGES		( 1*32+26) /* "pdpe1gb" GB pages */
-#define X86_FEATURE_RDTSCP		( 1*32+27) /* RDTSCP */
-#define X86_FEATURE_LM			( 1*32+29) /* Long Mode (x86-64, 64-bit support) */
-#define X86_FEATURE_3DNOWEXT		( 1*32+30) /* AMD 3DNow extensions */
-#define X86_FEATURE_3DNOW		( 1*32+31) /* 3DNow */
+#define X86_FEATURE_RDTSCP		( 1*32+27) /* "rdtscp" RDTSCP */
+#define X86_FEATURE_LM			( 1*32+29) /* "lm" Long Mode (x86-64, 64-bit support) */
+#define X86_FEATURE_3DNOWEXT		( 1*32+30) /* "3dnowext" AMD 3DNow extensions */
+#define X86_FEATURE_3DNOW		( 1*32+31) /* "3dnow" 3DNow */
 
 /* Transmeta-defined CPU features, CPUID level 0x80860001, word 2 */
-#define X86_FEATURE_RECOVERY		( 2*32+ 0) /* CPU in recovery mode */
-#define X86_FEATURE_LONGRUN		( 2*32+ 1) /* Longrun power control */
-#define X86_FEATURE_LRTI		( 2*32+ 3) /* LongRun table interface */
+#define X86_FEATURE_RECOVERY		( 2*32+ 0) /* "recovery" CPU in recovery mode */
+#define X86_FEATURE_LONGRUN		( 2*32+ 1) /* "longrun" Longrun power control */
+#define X86_FEATURE_LRTI		( 2*32+ 3) /* "lrti" LongRun table interface */
 
 /* Other features, Linux-defined mapping, word 3 */
 /* This range is used for feature bits which conflict or are synthesized */
-#define X86_FEATURE_CXMMX		( 3*32+ 0) /* Cyrix MMX extensions */
-#define X86_FEATURE_K6_MTRR		( 3*32+ 1) /* AMD K6 nonstandard MTRRs */
-#define X86_FEATURE_CYRIX_ARR		( 3*32+ 2) /* Cyrix ARRs (= MTRRs) */
-#define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* Centaur MCRs (= MTRRs) */
-#define X86_FEATURE_K8			( 3*32+ 4) /* "" Opteron, Athlon64 */
-#define X86_FEATURE_ZEN5		( 3*32+ 5) /* "" CPU based on Zen5 microarchitecture */
-#define X86_FEATURE_P3			( 3*32+ 6) /* "" P3 */
-#define X86_FEATURE_P4			( 3*32+ 7) /* "" P4 */
-#define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* TSC ticks at a constant rate */
-#define X86_FEATURE_UP			( 3*32+ 9) /* SMP kernel running on UP */
-#define X86_FEATURE_ART			( 3*32+10) /* Always running timer (ART) */
-#define X86_FEATURE_ARCH_PERFMON	( 3*32+11) /* Intel Architectural PerfMon */
-#define X86_FEATURE_PEBS		( 3*32+12) /* Precise-Event Based Sampling */
-#define X86_FEATURE_BTS			( 3*32+13) /* Branch Trace Store */
-#define X86_FEATURE_SYSCALL32		( 3*32+14) /* "" syscall in IA32 userspace */
-#define X86_FEATURE_SYSENTER32		( 3*32+15) /* "" sysenter in IA32 userspace */
-#define X86_FEATURE_REP_GOOD		( 3*32+16) /* REP microcode works well */
-#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* AMD Last Branch Record Extension Version 2 */
-#define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* "" Clear CPU buffers using VERW */
-#define X86_FEATURE_ACC_POWER		( 3*32+19) /* AMD Accumulated Power Mechanism */
-#define X86_FEATURE_NOPL		( 3*32+20) /* The NOPL (0F 1F) instructions */
-#define X86_FEATURE_ALWAYS		( 3*32+21) /* "" Always-present feature */
-#define X86_FEATURE_XTOPOLOGY		( 3*32+22) /* CPU topology enum extensions */
-#define X86_FEATURE_TSC_RELIABLE	( 3*32+23) /* TSC is known to be reliable */
-#define X86_FEATURE_NONSTOP_TSC		( 3*32+24) /* TSC does not stop in C states */
-#define X86_FEATURE_CPUID		( 3*32+25) /* CPU has CPUID instruction itself */
-#define X86_FEATURE_EXTD_APICID		( 3*32+26) /* Extended APICID (8 bits) */
-#define X86_FEATURE_AMD_DCM		( 3*32+27) /* AMD multi-node processor */
-#define X86_FEATURE_APERFMPERF		( 3*32+28) /* P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
-#define X86_FEATURE_RAPL		( 3*32+29) /* AMD/Hygon RAPL interface */
-#define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* TSC doesn't stop in S3 state */
-#define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* TSC has known frequency */
+#define X86_FEATURE_CXMMX		( 3*32+ 0) /* "cxmmx" Cyrix MMX extensions */
+#define X86_FEATURE_K6_MTRR		( 3*32+ 1) /* "k6_mtrr" AMD K6 nonstandard MTRRs */
+#define X86_FEATURE_CYRIX_ARR		( 3*32+ 2) /* "cyrix_arr" Cyrix ARRs (= MTRRs) */
+#define X86_FEATURE_CENTAUR_MCR		( 3*32+ 3) /* "centaur_mcr" Centaur MCRs (= MTRRs) */
+#define X86_FEATURE_K8			( 3*32+ 4) /* Opteron, Athlon64 */
+#define X86_FEATURE_ZEN5		( 3*32+ 5) /* CPU based on Zen5 microarchitecture */
+#define X86_FEATURE_P3			( 3*32+ 6) /* P3 */
+#define X86_FEATURE_P4			( 3*32+ 7) /* P4 */
+#define X86_FEATURE_CONSTANT_TSC	( 3*32+ 8) /* "constant_tsc" TSC ticks at a constant rate */
+#define X86_FEATURE_UP			( 3*32+ 9) /* "up" SMP kernel running on UP */
+#define X86_FEATURE_ART			( 3*32+10) /* "art" Always running timer (ART) */
+#define X86_FEATURE_ARCH_PERFMON	( 3*32+11) /* "arch_perfmon" Intel Architectural PerfMon */
+#define X86_FEATURE_PEBS		( 3*32+12) /* "pebs" Precise-Event Based Sampling */
+#define X86_FEATURE_BTS			( 3*32+13) /* "bts" Branch Trace Store */
+#define X86_FEATURE_SYSCALL32		( 3*32+14) /* syscall in IA32 userspace */
+#define X86_FEATURE_SYSENTER32		( 3*32+15) /* sysenter in IA32 userspace */
+#define X86_FEATURE_REP_GOOD		( 3*32+16) /* "rep_good" REP microcode works well */
+#define X86_FEATURE_AMD_LBR_V2		( 3*32+17) /* "amd_lbr_v2" AMD Last Branch Record Extension Version 2 */
+#define X86_FEATURE_CLEAR_CPU_BUF	( 3*32+18) /* Clear CPU buffers using VERW */
+#define X86_FEATURE_ACC_POWER		( 3*32+19) /* "acc_power" AMD Accumulated Power Mechanism */
+#define X86_FEATURE_NOPL		( 3*32+20) /* "nopl" The NOPL (0F 1F) instructions */
+#define X86_FEATURE_ALWAYS		( 3*32+21) /* Always-present feature */
+#define X86_FEATURE_XTOPOLOGY		( 3*32+22) /* "xtopology" CPU topology enum extensions */
+#define X86_FEATURE_TSC_RELIABLE	( 3*32+23) /* "tsc_reliable" TSC is known to be reliable */
+#define X86_FEATURE_NONSTOP_TSC		( 3*32+24) /* "nonstop_tsc" TSC does not stop in C states */
+#define X86_FEATURE_CPUID		( 3*32+25) /* "cpuid" CPU has CPUID instruction itself */
+#define X86_FEATURE_EXTD_APICID		( 3*32+26) /* "extd_apicid" Extended APICID (8 bits) */
+#define X86_FEATURE_AMD_DCM		( 3*32+27) /* "amd_dcm" AMD multi-node processor */
+#define X86_FEATURE_APERFMPERF		( 3*32+28) /* "aperfmperf" P-State hardware coordination feedback capability (APERF/MPERF MSRs) */
+#define X86_FEATURE_RAPL		( 3*32+29) /* "rapl" AMD/Hygon RAPL interface */
+#define X86_FEATURE_NONSTOP_TSC_S3	( 3*32+30) /* "nonstop_tsc_s3" TSC doesn't stop in S3 state */
+#define X86_FEATURE_TSC_KNOWN_FREQ	( 3*32+31) /* "tsc_known_freq" TSC has known frequency */
 
 /* Intel-defined CPU features, CPUID level 0x00000001 (ECX), word 4 */
 #define X86_FEATURE_XMM3		( 4*32+ 0) /* "pni" SSE-3 */
-#define X86_FEATURE_PCLMULQDQ		( 4*32+ 1) /* PCLMULQDQ instruction */
-#define X86_FEATURE_DTES64		( 4*32+ 2) /* 64-bit Debug Store */
+#define X86_FEATURE_PCLMULQDQ		( 4*32+ 1) /* "pclmulqdq" PCLMULQDQ instruction */
+#define X86_FEATURE_DTES64		( 4*32+ 2) /* "dtes64" 64-bit Debug Store */
 #define X86_FEATURE_MWAIT		( 4*32+ 3) /* "monitor" MONITOR/MWAIT support */
 #define X86_FEATURE_DSCPL		( 4*32+ 4) /* "ds_cpl" CPL-qualified (filtered) Debug Store */
-#define X86_FEATURE_VMX			( 4*32+ 5) /* Hardware virtualization */
-#define X86_FEATURE_SMX			( 4*32+ 6) /* Safer Mode eXtensions */
-#define X86_FEATURE_EST			( 4*32+ 7) /* Enhanced SpeedStep */
-#define X86_FEATURE_TM2			( 4*32+ 8) /* Thermal Monitor 2 */
-#define X86_FEATURE_SSSE3		( 4*32+ 9) /* Supplemental SSE-3 */
-#define X86_FEATURE_CID			( 4*32+10) /* Context ID */
-#define X86_FEATURE_SDBG		( 4*32+11) /* Silicon Debug */
-#define X86_FEATURE_FMA			( 4*32+12) /* Fused multiply-add */
-#define X86_FEATURE_CX16		( 4*32+13) /* CMPXCHG16B instruction */
-#define X86_FEATURE_XTPR		( 4*32+14) /* Send Task Priority Messages */
-#define X86_FEATURE_PDCM		( 4*32+15) /* Perf/Debug Capabilities MSR */
-#define X86_FEATURE_PCID		( 4*32+17) /* Process Context Identifiers */
-#define X86_FEATURE_DCA			( 4*32+18) /* Direct Cache Access */
+#define X86_FEATURE_VMX			( 4*32+ 5) /* "vmx" Hardware virtualization */
+#define X86_FEATURE_SMX			( 4*32+ 6) /* "smx" Safer Mode eXtensions */
+#define X86_FEATURE_EST			( 4*32+ 7) /* "est" Enhanced SpeedStep */
+#define X86_FEATURE_TM2			( 4*32+ 8) /* "tm2" Thermal Monitor 2 */
+#define X86_FEATURE_SSSE3		( 4*32+ 9) /* "ssse3" Supplemental SSE-3 */
+#define X86_FEATURE_CID			( 4*32+10) /* "cid" Context ID */
+#define X86_FEATURE_SDBG		( 4*32+11) /* "sdbg" Silicon Debug */
+#define X86_FEATURE_FMA			( 4*32+12) /* "fma" Fused multiply-add */
+#define X86_FEATURE_CX16		( 4*32+13) /* "cx16" CMPXCHG16B instruction */
+#define X86_FEATURE_XTPR		( 4*32+14) /* "xtpr" Send Task Priority Messages */
+#define X86_FEATURE_PDCM		( 4*32+15) /* "pdcm" Perf/Debug Capabilities MSR */
+#define X86_FEATURE_PCID		( 4*32+17) /* "pcid" Process Context Identifiers */
+#define X86_FEATURE_DCA			( 4*32+18) /* "dca" Direct Cache Access */
 #define X86_FEATURE_XMM4_1		( 4*32+19) /* "sse4_1" SSE-4.1 */
 #define X86_FEATURE_XMM4_2		( 4*32+20) /* "sse4_2" SSE-4.2 */
-#define X86_FEATURE_X2APIC		( 4*32+21) /* X2APIC */
-#define X86_FEATURE_MOVBE		( 4*32+22) /* MOVBE instruction */
-#define X86_FEATURE_POPCNT		( 4*32+23) /* POPCNT instruction */
-#define X86_FEATURE_TSC_DEADLINE_TIMER	( 4*32+24) /* TSC deadline timer */
-#define X86_FEATURE_AES			( 4*32+25) /* AES instructions */
-#define X86_FEATURE_XSAVE		( 4*32+26) /* XSAVE/XRSTOR/XSETBV/XGETBV instructions */
-#define X86_FEATURE_OSXSAVE		( 4*32+27) /* "" XSAVE instruction enabled in the OS */
-#define X86_FEATURE_AVX			( 4*32+28) /* Advanced Vector Extensions */
-#define X86_FEATURE_F16C		( 4*32+29) /* 16-bit FP conversions */
-#define X86_FEATURE_RDRAND		( 4*32+30) /* RDRAND instruction */
-#define X86_FEATURE_HYPERVISOR		( 4*32+31) /* Running on a hypervisor */
+#define X86_FEATURE_X2APIC		( 4*32+21) /* "x2apic" X2APIC */
+#define X86_FEATURE_MOVBE		( 4*32+22) /* "movbe" MOVBE instruction */
+#define X86_FEATURE_POPCNT		( 4*32+23) /* "popcnt" POPCNT instruction */
+#define X86_FEATURE_TSC_DEADLINE_TIMER	( 4*32+24) /* "tsc_deadline_timer" TSC deadline timer */
+#define X86_FEATURE_AES			( 4*32+25) /* "aes" AES instructions */
+#define X86_FEATURE_XSAVE		( 4*32+26) /* "xsave" XSAVE/XRSTOR/XSETBV/XGETBV instructions */
+#define X86_FEATURE_OSXSAVE		( 4*32+27) /* XSAVE instruction enabled in the OS */
+#define X86_FEATURE_AVX			( 4*32+28) /* "avx" Advanced Vector Extensions */
+#define X86_FEATURE_F16C		( 4*32+29) /* "f16c" 16-bit FP conversions */
+#define X86_FEATURE_RDRAND		( 4*32+30) /* "rdrand" RDRAND instruction */
+#define X86_FEATURE_HYPERVISOR		( 4*32+31) /* "hypervisor" Running on a hypervisor */
 
 /* VIA/Cyrix/Centaur-defined CPU features, CPUID level 0xC0000001, word 5 */
 #define X86_FEATURE_XSTORE		( 5*32+ 2) /* "rng" RNG present (xstore) */
 #define X86_FEATURE_XSTORE_EN		( 5*32+ 3) /* "rng_en" RNG enabled */
 #define X86_FEATURE_XCRYPT		( 5*32+ 6) /* "ace" on-CPU crypto (xcrypt) */
 #define X86_FEATURE_XCRYPT_EN		( 5*32+ 7) /* "ace_en" on-CPU crypto enabled */
-#define X86_FEATURE_ACE2		( 5*32+ 8) /* Advanced Cryptography Engine v2 */
-#define X86_FEATURE_ACE2_EN		( 5*32+ 9) /* ACE v2 enabled */
-#define X86_FEATURE_PHE			( 5*32+10) /* PadLock Hash Engine */
-#define X86_FEATURE_PHE_EN		( 5*32+11) /* PHE enabled */
-#define X86_FEATURE_PMM			( 5*32+12) /* PadLock Montgomery Multiplier */
-#define X86_FEATURE_PMM_EN		( 5*32+13) /* PMM enabled */
+#define X86_FEATURE_ACE2		( 5*32+ 8) /* "ace2" Advanced Cryptography Engine v2 */
+#define X86_FEATURE_ACE2_EN		( 5*32+ 9) /* "ace2_en" ACE v2 enabled */
+#define X86_FEATURE_PHE			( 5*32+10) /* "phe" PadLock Hash Engine */
+#define X86_FEATURE_PHE_EN		( 5*32+11) /* "phe_en" PHE enabled */
+#define X86_FEATURE_PMM			( 5*32+12) /* "pmm" PadLock Montgomery Multiplier */
+#define X86_FEATURE_PMM_EN		( 5*32+13) /* "pmm_en" PMM enabled */
 
 /* More extended AMD flags: CPUID level 0x80000001, ECX, word 6 */
-#define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* LAHF/SAHF in long mode */
-#define X86_FEATURE_CMP_LEGACY		( 6*32+ 1) /* If yes HyperThreading not valid */
-#define X86_FEATURE_SVM			( 6*32+ 2) /* Secure Virtual Machine */
-#define X86_FEATURE_EXTAPIC		( 6*32+ 3) /* Extended APIC space */
-#define X86_FEATURE_CR8_LEGACY		( 6*32+ 4) /* CR8 in 32-bit mode */
-#define X86_FEATURE_ABM			( 6*32+ 5) /* Advanced bit manipulation */
-#define X86_FEATURE_SSE4A		( 6*32+ 6) /* SSE-4A */
-#define X86_FEATURE_MISALIGNSSE		( 6*32+ 7) /* Misaligned SSE mode */
-#define X86_FEATURE_3DNOWPREFETCH	( 6*32+ 8) /* 3DNow prefetch instructions */
-#define X86_FEATURE_OSVW		( 6*32+ 9) /* OS Visible Workaround */
-#define X86_FEATURE_IBS			( 6*32+10) /* Instruction Based Sampling */
-#define X86_FEATURE_XOP			( 6*32+11) /* extended AVX instructions */
-#define X86_FEATURE_SKINIT		( 6*32+12) /* SKINIT/STGI instructions */
-#define X86_FEATURE_WDT			( 6*32+13) /* Watchdog timer */
-#define X86_FEATURE_LWP			( 6*32+15) /* Light Weight Profiling */
-#define X86_FEATURE_FMA4		( 6*32+16) /* 4 operands MAC instructions */
-#define X86_FEATURE_TCE			( 6*32+17) /* Translation Cache Extension */
-#define X86_FEATURE_NODEID_MSR		( 6*32+19) /* NodeId MSR */
-#define X86_FEATURE_TBM			( 6*32+21) /* Trailing Bit Manipulations */
-#define X86_FEATURE_TOPOEXT		( 6*32+22) /* Topology extensions CPUID leafs */
-#define X86_FEATURE_PERFCTR_CORE	( 6*32+23) /* Core performance counter extensions */
-#define X86_FEATURE_PERFCTR_NB		( 6*32+24) /* NB performance counter extensions */
-#define X86_FEATURE_BPEXT		( 6*32+26) /* Data breakpoint extension */
-#define X86_FEATURE_PTSC		( 6*32+27) /* Performance time-stamp counter */
-#define X86_FEATURE_PERFCTR_LLC		( 6*32+28) /* Last Level Cache performance counter extensions */
-#define X86_FEATURE_MWAITX		( 6*32+29) /* MWAIT extension (MONITORX/MWAITX instructions) */
+#define X86_FEATURE_LAHF_LM		( 6*32+ 0) /* "lahf_lm" LAHF/SAHF in long mode */
+#define X86_FEATURE_CMP_LEGACY		( 6*32+ 1) /* "cmp_legacy" If yes HyperThreading not valid */
+#define X86_FEATURE_SVM			( 6*32+ 2) /* "svm" Secure Virtual Machine */
+#define X86_FEATURE_EXTAPIC		( 6*32+ 3) /* "extapic" Extended APIC space */
+#define X86_FEATURE_CR8_LEGACY		( 6*32+ 4) /* "cr8_legacy" CR8 in 32-bit mode */
+#define X86_FEATURE_ABM			( 6*32+ 5) /* "abm" Advanced bit manipulation */
+#define X86_FEATURE_SSE4A		( 6*32+ 6) /* "sse4a" SSE-4A */
+#define X86_FEATURE_MISALIGNSSE		( 6*32+ 7) /* "misalignsse" Misaligned SSE mode */
+#define X86_FEATURE_3DNOWPREFETCH	( 6*32+ 8) /* "3dnowprefetch" 3DNow prefetch instructions */
+#define X86_FEATURE_OSVW		( 6*32+ 9) /* "osvw" OS Visible Workaround */
+#define X86_FEATURE_IBS			( 6*32+10) /* "ibs" Instruction Based Sampling */
+#define X86_FEATURE_XOP			( 6*32+11) /* "xop" Extended AVX instructions */
+#define X86_FEATURE_SKINIT		( 6*32+12) /* "skinit" SKINIT/STGI instructions */
+#define X86_FEATURE_WDT			( 6*32+13) /* "wdt" Watchdog timer */
+#define X86_FEATURE_LWP			( 6*32+15) /* "lwp" Light Weight Profiling */
+#define X86_FEATURE_FMA4		( 6*32+16) /* "fma4" 4 operands MAC instructions */
+#define X86_FEATURE_TCE			( 6*32+17) /* "tce" Translation Cache Extension */
+#define X86_FEATURE_NODEID_MSR		( 6*32+19) /* "nodeid_msr" NodeId MSR */
+#define X86_FEATURE_TBM			( 6*32+21) /* "tbm" Trailing Bit Manipulations */
+#define X86_FEATURE_TOPOEXT		( 6*32+22) /* "topoext" Topology extensions CPUID leafs */
+#define X86_FEATURE_PERFCTR_CORE	( 6*32+23) /* "perfctr_core" Core performance counter extensions */
+#define X86_FEATURE_PERFCTR_NB		( 6*32+24) /* "perfctr_nb" NB performance counter extensions */
+#define X86_FEATURE_BPEXT		( 6*32+26) /* "bpext" Data breakpoint extension */
+#define X86_FEATURE_PTSC		( 6*32+27) /* "ptsc" Performance time-stamp counter */
+#define X86_FEATURE_PERFCTR_LLC		( 6*32+28) /* "perfctr_llc" Last Level Cache performance counter extensions */
+#define X86_FEATURE_MWAITX		( 6*32+29) /* "mwaitx" MWAIT extension (MONITORX/MWAITX instructions) */
 
 /*
  * Auxiliary flags: Linux defined - For features scattered in various
@@ -189,93 +189,93 @@
  *
  * Reuse free bits when adding new feature flags!
  */
-#define X86_FEATURE_RING3MWAIT		( 7*32+ 0) /* Ring 3 MONITOR/MWAIT instructions */
-#define X86_FEATURE_CPUID_FAULT		( 7*32+ 1) /* Intel CPUID faulting */
-#define X86_FEATURE_CPB			( 7*32+ 2) /* AMD Core Performance Boost */
-#define X86_FEATURE_EPB			( 7*32+ 3) /* IA32_ENERGY_PERF_BIAS support */
-#define X86_FEATURE_CAT_L3		( 7*32+ 4) /* Cache Allocation Technology L3 */
-#define X86_FEATURE_CAT_L2		( 7*32+ 5) /* Cache Allocation Technology L2 */
-#define X86_FEATURE_CDP_L3		( 7*32+ 6) /* Code and Data Prioritization L3 */
-#define X86_FEATURE_TDX_HOST_PLATFORM	( 7*32+ 7) /* Platform supports being a TDX host */
-#define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* AMD HW-PState */
-#define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* AMD ProcFeedbackInterface */
-#define X86_FEATURE_XCOMPACTED		( 7*32+10) /* "" Use compacted XSTATE (XSAVES or XSAVEC) */
-#define X86_FEATURE_PTI			( 7*32+11) /* Kernel Page Table Isolation enabled */
-#define X86_FEATURE_KERNEL_IBRS		( 7*32+12) /* "" Set/clear IBRS on kernel entry/exit */
-#define X86_FEATURE_RSB_VMEXIT		( 7*32+13) /* "" Fill RSB on VM-Exit */
-#define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* Intel Processor Inventory Number */
-#define X86_FEATURE_CDP_L2		( 7*32+15) /* Code and Data Prioritization L2 */
-#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* "" MSR SPEC_CTRL is implemented */
-#define X86_FEATURE_SSBD		( 7*32+17) /* Speculative Store Bypass Disable */
-#define X86_FEATURE_MBA			( 7*32+18) /* Memory Bandwidth Allocation */
-#define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* "" Fill RSB on context switches */
-#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* AMD Performance Monitoring Version 2 */
-#define X86_FEATURE_USE_IBPB		( 7*32+21) /* "" Indirect Branch Prediction Barrier enabled */
-#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* "" Use IBRS during runtime firmware calls */
-#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* "" Disable Speculative Store Bypass. */
-#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* "" AMD SSBD implementation via LS_CFG MSR */
-#define X86_FEATURE_IBRS		( 7*32+25) /* Indirect Branch Restricted Speculation */
-#define X86_FEATURE_IBPB		( 7*32+26) /* Indirect Branch Prediction Barrier */
-#define X86_FEATURE_STIBP		( 7*32+27) /* Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_ZEN			( 7*32+28) /* "" Generic flag for all Zen and newer */
-#define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* "" L1TF workaround PTE inversion */
-#define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* Enhanced IBRS */
-#define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* "" MSR IA32_FEAT_CTL configured */
+#define X86_FEATURE_RING3MWAIT		( 7*32+ 0) /* "ring3mwait" Ring 3 MONITOR/MWAIT instructions */
+#define X86_FEATURE_CPUID_FAULT		( 7*32+ 1) /* "cpuid_fault" Intel CPUID faulting */
+#define X86_FEATURE_CPB			( 7*32+ 2) /* "cpb" AMD Core Performance Boost */
+#define X86_FEATURE_EPB			( 7*32+ 3) /* "epb" IA32_ENERGY_PERF_BIAS support */
+#define X86_FEATURE_CAT_L3		( 7*32+ 4) /* "cat_l3" Cache Allocation Technology L3 */
+#define X86_FEATURE_CAT_L2		( 7*32+ 5) /* "cat_l2" Cache Allocation Technology L2 */
+#define X86_FEATURE_CDP_L3		( 7*32+ 6) /* "cdp_l3" Code and Data Prioritization L3 */
+#define X86_FEATURE_TDX_HOST_PLATFORM	( 7*32+ 7) /* "tdx_host_platform" Platform supports being a TDX host */
+#define X86_FEATURE_HW_PSTATE		( 7*32+ 8) /* "hw_pstate" AMD HW-PState */
+#define X86_FEATURE_PROC_FEEDBACK	( 7*32+ 9) /* "proc_feedback" AMD ProcFeedbackInterface */
+#define X86_FEATURE_XCOMPACTED		( 7*32+10) /* Use compacted XSTATE (XSAVES or XSAVEC) */
+#define X86_FEATURE_PTI			( 7*32+11) /* "pti" Kernel Page Table Isolation enabled */
+#define X86_FEATURE_KERNEL_IBRS		( 7*32+12) /* Set/clear IBRS on kernel entry/exit */
+#define X86_FEATURE_RSB_VMEXIT		( 7*32+13) /* Fill RSB on VM-Exit */
+#define X86_FEATURE_INTEL_PPIN		( 7*32+14) /* "intel_ppin" Intel Processor Inventory Number */
+#define X86_FEATURE_CDP_L2		( 7*32+15) /* "cdp_l2" Code and Data Prioritization L2 */
+#define X86_FEATURE_MSR_SPEC_CTRL	( 7*32+16) /* MSR SPEC_CTRL is implemented */
+#define X86_FEATURE_SSBD		( 7*32+17) /* "ssbd" Speculative Store Bypass Disable */
+#define X86_FEATURE_MBA			( 7*32+18) /* "mba" Memory Bandwidth Allocation */
+#define X86_FEATURE_RSB_CTXSW		( 7*32+19) /* Fill RSB on context switches */
+#define X86_FEATURE_PERFMON_V2		( 7*32+20) /* "perfmon_v2" AMD Performance Monitoring Version 2 */
+#define X86_FEATURE_USE_IBPB		( 7*32+21) /* Indirect Branch Prediction Barrier enabled */
+#define X86_FEATURE_USE_IBRS_FW		( 7*32+22) /* Use IBRS during runtime firmware calls */
+#define X86_FEATURE_SPEC_STORE_BYPASS_DISABLE	( 7*32+23) /* Disable Speculative Store Bypass. */
+#define X86_FEATURE_LS_CFG_SSBD		( 7*32+24)  /* AMD SSBD implementation via LS_CFG MSR */
+#define X86_FEATURE_IBRS		( 7*32+25) /* "ibrs" Indirect Branch Restricted Speculation */
+#define X86_FEATURE_IBPB		( 7*32+26) /* "ibpb" Indirect Branch Prediction Barrier */
+#define X86_FEATURE_STIBP		( 7*32+27) /* "stibp" Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_ZEN			( 7*32+28) /* Generic flag for all Zen and newer */
+#define X86_FEATURE_L1TF_PTEINV		( 7*32+29) /* L1TF workaround PTE inversion */
+#define X86_FEATURE_IBRS_ENHANCED	( 7*32+30) /* "ibrs_enhanced" Enhanced IBRS */
+#define X86_FEATURE_MSR_IA32_FEAT_CTL	( 7*32+31) /* MSR IA32_FEAT_CTL configured */
 
 /* Virtualization flags: Linux defined, word 8 */
-#define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* Intel TPR Shadow */
-#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* Intel FlexPriority */
-#define X86_FEATURE_EPT			( 8*32+ 2) /* Intel Extended Page Table */
-#define X86_FEATURE_VPID		( 8*32+ 3) /* Intel Virtual Processor ID */
+#define X86_FEATURE_TPR_SHADOW		( 8*32+ 0) /* "tpr_shadow" Intel TPR Shadow */
+#define X86_FEATURE_FLEXPRIORITY	( 8*32+ 1) /* "flexpriority" Intel FlexPriority */
+#define X86_FEATURE_EPT			( 8*32+ 2) /* "ept" Intel Extended Page Table */
+#define X86_FEATURE_VPID		( 8*32+ 3) /* "vpid" Intel Virtual Processor ID */
 
-#define X86_FEATURE_VMMCALL		( 8*32+15) /* Prefer VMMCALL to VMCALL */
-#define X86_FEATURE_XENPV		( 8*32+16) /* "" Xen paravirtual guest */
-#define X86_FEATURE_EPT_AD		( 8*32+17) /* Intel Extended Page Table access-dirty bit */
-#define X86_FEATURE_VMCALL		( 8*32+18) /* "" Hypervisor supports the VMCALL instruction */
-#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* "" VMware prefers VMMCALL hypercall instruction */
-#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* "" PV unlock function */
-#define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* "" PV vcpu_is_preempted function */
-#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* Intel Trust Domain Extensions Guest */
+#define X86_FEATURE_VMMCALL		( 8*32+15) /* "vmmcall" Prefer VMMCALL to VMCALL */
+#define X86_FEATURE_XENPV		( 8*32+16) /* Xen paravirtual guest */
+#define X86_FEATURE_EPT_AD		( 8*32+17) /* "ept_ad" Intel Extended Page Table access-dirty bit */
+#define X86_FEATURE_VMCALL		( 8*32+18) /* Hypervisor supports the VMCALL instruction */
+#define X86_FEATURE_VMW_VMMCALL		( 8*32+19) /* VMware prefers VMMCALL hypercall instruction */
+#define X86_FEATURE_PVUNLOCK		( 8*32+20) /* PV unlock function */
+#define X86_FEATURE_VCPUPREEMPT		( 8*32+21) /* PV vcpu_is_preempted function */
+#define X86_FEATURE_TDX_GUEST		( 8*32+22) /* "tdx_guest" Intel Trust Domain Extensions Guest */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EBX), word 9 */
-#define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
-#define X86_FEATURE_TSC_ADJUST		( 9*32+ 1) /* TSC adjustment MSR 0x3B */
-#define X86_FEATURE_SGX			( 9*32+ 2) /* Software Guard Extensions */
-#define X86_FEATURE_BMI1		( 9*32+ 3) /* 1st group bit manipulation extensions */
-#define X86_FEATURE_HLE			( 9*32+ 4) /* Hardware Lock Elision */
-#define X86_FEATURE_AVX2		( 9*32+ 5) /* AVX2 instructions */
-#define X86_FEATURE_FDP_EXCPTN_ONLY	( 9*32+ 6) /* "" FPU data pointer updated only on x87 exceptions */
-#define X86_FEATURE_SMEP		( 9*32+ 7) /* Supervisor Mode Execution Protection */
-#define X86_FEATURE_BMI2		( 9*32+ 8) /* 2nd group bit manipulation extensions */
-#define X86_FEATURE_ERMS		( 9*32+ 9) /* Enhanced REP MOVSB/STOSB instructions */
-#define X86_FEATURE_INVPCID		( 9*32+10) /* Invalidate Processor Context ID */
-#define X86_FEATURE_RTM			( 9*32+11) /* Restricted Transactional Memory */
-#define X86_FEATURE_CQM			( 9*32+12) /* Cache QoS Monitoring */
-#define X86_FEATURE_ZERO_FCS_FDS	( 9*32+13) /* "" Zero out FPU CS and FPU DS */
-#define X86_FEATURE_MPX			( 9*32+14) /* Memory Protection Extension */
-#define X86_FEATURE_RDT_A		( 9*32+15) /* Resource Director Technology Allocation */
-#define X86_FEATURE_AVX512F		( 9*32+16) /* AVX-512 Foundation */
-#define X86_FEATURE_AVX512DQ		( 9*32+17) /* AVX-512 DQ (Double/Quad granular) Instructions */
-#define X86_FEATURE_RDSEED		( 9*32+18) /* RDSEED instruction */
-#define X86_FEATURE_ADX			( 9*32+19) /* ADCX and ADOX instructions */
-#define X86_FEATURE_SMAP		( 9*32+20) /* Supervisor Mode Access Prevention */
-#define X86_FEATURE_AVX512IFMA		( 9*32+21) /* AVX-512 Integer Fused Multiply-Add instructions */
-#define X86_FEATURE_CLFLUSHOPT		( 9*32+23) /* CLFLUSHOPT instruction */
-#define X86_FEATURE_CLWB		( 9*32+24) /* CLWB instruction */
-#define X86_FEATURE_INTEL_PT		( 9*32+25) /* Intel Processor Trace */
-#define X86_FEATURE_AVX512PF		( 9*32+26) /* AVX-512 Prefetch */
-#define X86_FEATURE_AVX512ER		( 9*32+27) /* AVX-512 Exponential and Reciprocal */
-#define X86_FEATURE_AVX512CD		( 9*32+28) /* AVX-512 Conflict Detection */
-#define X86_FEATURE_SHA_NI		( 9*32+29) /* SHA1/SHA256 Instruction Extensions */
-#define X86_FEATURE_AVX512BW		( 9*32+30) /* AVX-512 BW (Byte/Word granular) Instructions */
-#define X86_FEATURE_AVX512VL		( 9*32+31) /* AVX-512 VL (128/256 Vector Length) Extensions */
+#define X86_FEATURE_FSGSBASE		( 9*32+ 0) /* "fsgsbase" RDFSBASE, WRFSBASE, RDGSBASE, WRGSBASE instructions*/
+#define X86_FEATURE_TSC_ADJUST		( 9*32+ 1) /* "tsc_adjust" TSC adjustment MSR 0x3B */
+#define X86_FEATURE_SGX			( 9*32+ 2) /* "sgx" Software Guard Extensions */
+#define X86_FEATURE_BMI1		( 9*32+ 3) /* "bmi1" 1st group bit manipulation extensions */
+#define X86_FEATURE_HLE			( 9*32+ 4) /* "hle" Hardware Lock Elision */
+#define X86_FEATURE_AVX2		( 9*32+ 5) /* "avx2" AVX2 instructions */
+#define X86_FEATURE_FDP_EXCPTN_ONLY	( 9*32+ 6) /* FPU data pointer updated only on x87 exceptions */
+#define X86_FEATURE_SMEP		( 9*32+ 7) /* "smep" Supervisor Mode Execution Protection */
+#define X86_FEATURE_BMI2		( 9*32+ 8) /* "bmi2" 2nd group bit manipulation extensions */
+#define X86_FEATURE_ERMS		( 9*32+ 9) /* "erms" Enhanced REP MOVSB/STOSB instructions */
+#define X86_FEATURE_INVPCID		( 9*32+10) /* "invpcid" Invalidate Processor Context ID */
+#define X86_FEATURE_RTM			( 9*32+11) /* "rtm" Restricted Transactional Memory */
+#define X86_FEATURE_CQM			( 9*32+12) /* "cqm" Cache QoS Monitoring */
+#define X86_FEATURE_ZERO_FCS_FDS	( 9*32+13) /* Zero out FPU CS and FPU DS */
+#define X86_FEATURE_MPX			( 9*32+14) /* "mpx" Memory Protection Extension */
+#define X86_FEATURE_RDT_A		( 9*32+15) /* "rdt_a" Resource Director Technology Allocation */
+#define X86_FEATURE_AVX512F		( 9*32+16) /* "avx512f" AVX-512 Foundation */
+#define X86_FEATURE_AVX512DQ		( 9*32+17) /* "avx512dq" AVX-512 DQ (Double/Quad granular) Instructions */
+#define X86_FEATURE_RDSEED		( 9*32+18) /* "rdseed" RDSEED instruction */
+#define X86_FEATURE_ADX			( 9*32+19) /* "adx" ADCX and ADOX instructions */
+#define X86_FEATURE_SMAP		( 9*32+20) /* "smap" Supervisor Mode Access Prevention */
+#define X86_FEATURE_AVX512IFMA		( 9*32+21) /* "avx512ifma" AVX-512 Integer Fused Multiply-Add instructions */
+#define X86_FEATURE_CLFLUSHOPT		( 9*32+23) /* "clflushopt" CLFLUSHOPT instruction */
+#define X86_FEATURE_CLWB		( 9*32+24) /* "clwb" CLWB instruction */
+#define X86_FEATURE_INTEL_PT		( 9*32+25) /* "intel_pt" Intel Processor Trace */
+#define X86_FEATURE_AVX512PF		( 9*32+26) /* "avx512pf" AVX-512 Prefetch */
+#define X86_FEATURE_AVX512ER		( 9*32+27) /* "avx512er" AVX-512 Exponential and Reciprocal */
+#define X86_FEATURE_AVX512CD		( 9*32+28) /* "avx512cd" AVX-512 Conflict Detection */
+#define X86_FEATURE_SHA_NI		( 9*32+29) /* "sha_ni" SHA1/SHA256 Instruction Extensions */
+#define X86_FEATURE_AVX512BW		( 9*32+30) /* "avx512bw" AVX-512 BW (Byte/Word granular) Instructions */
+#define X86_FEATURE_AVX512VL		( 9*32+31) /* "avx512vl" AVX-512 VL (128/256 Vector Length) Extensions */
 
 /* Extended state features, CPUID level 0x0000000d:1 (EAX), word 10 */
-#define X86_FEATURE_XSAVEOPT		(10*32+ 0) /* XSAVEOPT instruction */
-#define X86_FEATURE_XSAVEC		(10*32+ 1) /* XSAVEC instruction */
-#define X86_FEATURE_XGETBV1		(10*32+ 2) /* XGETBV with ECX = 1 instruction */
-#define X86_FEATURE_XSAVES		(10*32+ 3) /* XSAVES/XRSTORS instructions */
-#define X86_FEATURE_XFD			(10*32+ 4) /* "" eXtended Feature Disabling */
+#define X86_FEATURE_XSAVEOPT		(10*32+ 0) /* "xsaveopt" XSAVEOPT instruction */
+#define X86_FEATURE_XSAVEC		(10*32+ 1) /* "xsavec" XSAVEC instruction */
+#define X86_FEATURE_XGETBV1		(10*32+ 2) /* "xgetbv1" XGETBV with ECX = 1 instruction */
+#define X86_FEATURE_XSAVES		(10*32+ 3) /* "xsaves" XSAVES/XRSTORS instructions */
+#define X86_FEATURE_XFD			(10*32+ 4) /* eXtended Feature Disabling */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
@@ -283,181 +283,181 @@
  *
  * Reuse free bits when adding new feature flags!
  */
-#define X86_FEATURE_CQM_LLC		(11*32+ 0) /* LLC QoS if 1 */
-#define X86_FEATURE_CQM_OCCUP_LLC	(11*32+ 1) /* LLC occupancy monitoring */
-#define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* LLC Total MBM monitoring */
-#define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* LLC Local MBM monitoring */
-#define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* "" LFENCE in user entry SWAPGS path */
-#define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* "" LFENCE in kernel entry SWAPGS path */
-#define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* #AC for split lock */
-#define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* "" Per-thread Memory Bandwidth Allocation */
-#define X86_FEATURE_SGX1		(11*32+ 8) /* "" Basic SGX */
-#define X86_FEATURE_SGX2		(11*32+ 9) /* "" SGX Enclave Dynamic Memory Management (EDMM) */
-#define X86_FEATURE_ENTRY_IBPB		(11*32+10) /* "" Issue an IBPB on kernel entry */
-#define X86_FEATURE_RRSBA_CTRL		(11*32+11) /* "" RET prediction control */
-#define X86_FEATURE_RETPOLINE		(11*32+12) /* "" Generic Retpoline mitigation for Spectre variant 2 */
-#define X86_FEATURE_RETPOLINE_LFENCE	(11*32+13) /* "" Use LFENCE for Spectre variant 2 */
-#define X86_FEATURE_RETHUNK		(11*32+14) /* "" Use REturn THUNK */
-#define X86_FEATURE_UNRET		(11*32+15) /* "" AMD BTB untrain return */
-#define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* "" Use IBPB during runtime firmware calls */
-#define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* "" Fill RSB on VM exit when EIBRS is enabled */
-#define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* "" SGX EDECCSSA user leaf function */
-#define X86_FEATURE_CALL_DEPTH		(11*32+19) /* "" Call depth tracking for RSB stuffing */
-#define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* "" MSR IA32_TSX_CTRL (Intel) implemented */
-#define X86_FEATURE_SMBA		(11*32+21) /* "" Slow Memory Bandwidth Allocation */
-#define X86_FEATURE_BMEC		(11*32+22) /* "" Bandwidth Monitoring Event Configuration */
-#define X86_FEATURE_USER_SHSTK		(11*32+23) /* Shadow stack support for user mode applications */
-#define X86_FEATURE_SRSO		(11*32+24) /* "" AMD BTB untrain RETs */
-#define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* "" AMD BTB untrain RETs through aliasing */
-#define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* "" Issue an IBPB only on VMEXIT */
-#define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* "" IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
-#define X86_FEATURE_ZEN2		(11*32+28) /* "" CPU based on Zen2 microarchitecture */
-#define X86_FEATURE_ZEN3		(11*32+29) /* "" CPU based on Zen3 microarchitecture */
-#define X86_FEATURE_ZEN4		(11*32+30) /* "" CPU based on Zen4 microarchitecture */
-#define X86_FEATURE_ZEN1		(11*32+31) /* "" CPU based on Zen1 microarchitecture */
+#define X86_FEATURE_CQM_LLC		(11*32+ 0) /* "cqm_llc" LLC QoS if 1 */
+#define X86_FEATURE_CQM_OCCUP_LLC	(11*32+ 1) /* "cqm_occup_llc" LLC occupancy monitoring */
+#define X86_FEATURE_CQM_MBM_TOTAL	(11*32+ 2) /* "cqm_mbm_total" LLC Total MBM monitoring */
+#define X86_FEATURE_CQM_MBM_LOCAL	(11*32+ 3) /* "cqm_mbm_local" LLC Local MBM monitoring */
+#define X86_FEATURE_FENCE_SWAPGS_USER	(11*32+ 4) /* LFENCE in user entry SWAPGS path */
+#define X86_FEATURE_FENCE_SWAPGS_KERNEL	(11*32+ 5) /* LFENCE in kernel entry SWAPGS path */
+#define X86_FEATURE_SPLIT_LOCK_DETECT	(11*32+ 6) /* "split_lock_detect" #AC for split lock */
+#define X86_FEATURE_PER_THREAD_MBA	(11*32+ 7) /* Per-thread Memory Bandwidth Allocation */
+#define X86_FEATURE_SGX1		(11*32+ 8) /* Basic SGX */
+#define X86_FEATURE_SGX2		(11*32+ 9) /* SGX Enclave Dynamic Memory Management (EDMM) */
+#define X86_FEATURE_ENTRY_IBPB		(11*32+10) /* Issue an IBPB on kernel entry */
+#define X86_FEATURE_RRSBA_CTRL		(11*32+11) /* RET prediction control */
+#define X86_FEATURE_RETPOLINE		(11*32+12) /* Generic Retpoline mitigation for Spectre variant 2 */
+#define X86_FEATURE_RETPOLINE_LFENCE	(11*32+13) /* Use LFENCE for Spectre variant 2 */
+#define X86_FEATURE_RETHUNK		(11*32+14) /* Use REturn THUNK */
+#define X86_FEATURE_UNRET		(11*32+15) /* AMD BTB untrain return */
+#define X86_FEATURE_USE_IBPB_FW		(11*32+16) /* Use IBPB during runtime firmware calls */
+#define X86_FEATURE_RSB_VMEXIT_LITE	(11*32+17) /* Fill RSB on VM exit when EIBRS is enabled */
+#define X86_FEATURE_SGX_EDECCSSA	(11*32+18) /* SGX EDECCSSA user leaf function */
+#define X86_FEATURE_CALL_DEPTH		(11*32+19) /* Call depth tracking for RSB stuffing */
+#define X86_FEATURE_MSR_TSX_CTRL	(11*32+20) /* MSR IA32_TSX_CTRL (Intel) implemented */
+#define X86_FEATURE_SMBA		(11*32+21) /* Slow Memory Bandwidth Allocation */
+#define X86_FEATURE_BMEC		(11*32+22) /* Bandwidth Monitoring Event Configuration */
+#define X86_FEATURE_USER_SHSTK		(11*32+23) /* "user_shstk" Shadow stack support for user mode applications */
+#define X86_FEATURE_SRSO		(11*32+24) /* AMD BTB untrain RETs */
+#define X86_FEATURE_SRSO_ALIAS		(11*32+25) /* AMD BTB untrain RETs through aliasing */
+#define X86_FEATURE_IBPB_ON_VMEXIT	(11*32+26) /* Issue an IBPB only on VMEXIT */
+#define X86_FEATURE_APIC_MSRS_FENCE	(11*32+27) /* IA32_TSC_DEADLINE and X2APIC MSRs need fencing */
+#define X86_FEATURE_ZEN2		(11*32+28) /* CPU based on Zen2 microarchitecture */
+#define X86_FEATURE_ZEN3		(11*32+29) /* CPU based on Zen3 microarchitecture */
+#define X86_FEATURE_ZEN4		(11*32+30) /* CPU based on Zen4 microarchitecture */
+#define X86_FEATURE_ZEN1		(11*32+31) /* CPU based on Zen1 microarchitecture */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:1 (EAX), word 12 */
-#define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* AVX VNNI instructions */
-#define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* AVX512 BFLOAT16 instructions */
-#define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* "" CMPccXADD instructions */
-#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* "" Intel Architectural PerfMon Extension */
-#define X86_FEATURE_FZRM		(12*32+10) /* "" Fast zero-length REP MOVSB */
-#define X86_FEATURE_FSRS		(12*32+11) /* "" Fast short REP STOSB */
-#define X86_FEATURE_FSRC		(12*32+12) /* "" Fast short REP {CMPSB,SCASB} */
-#define X86_FEATURE_FRED		(12*32+17) /* Flexible Return and Event Delivery */
-#define X86_FEATURE_LKGS		(12*32+18) /* "" Load "kernel" (userspace) GS */
-#define X86_FEATURE_WRMSRNS		(12*32+19) /* "" Non-serializing WRMSR */
-#define X86_FEATURE_AMX_FP16		(12*32+21) /* "" AMX fp16 Support */
-#define X86_FEATURE_AVX_IFMA            (12*32+23) /* "" Support for VPMADD52[H,L]UQ */
-#define X86_FEATURE_LAM			(12*32+26) /* Linear Address Masking */
+#define X86_FEATURE_AVX_VNNI		(12*32+ 4) /* "avx_vnni" AVX VNNI instructions */
+#define X86_FEATURE_AVX512_BF16		(12*32+ 5) /* "avx512_bf16" AVX512 BFLOAT16 instructions */
+#define X86_FEATURE_CMPCCXADD           (12*32+ 7) /* CMPccXADD instructions */
+#define X86_FEATURE_ARCH_PERFMON_EXT	(12*32+ 8) /* Intel Architectural PerfMon Extension */
+#define X86_FEATURE_FZRM		(12*32+10) /* Fast zero-length REP MOVSB */
+#define X86_FEATURE_FSRS		(12*32+11) /* Fast short REP STOSB */
+#define X86_FEATURE_FSRC		(12*32+12) /* Fast short REP {CMPSB,SCASB} */
+#define X86_FEATURE_FRED		(12*32+17) /* "fred" Flexible Return and Event Delivery */
+#define X86_FEATURE_LKGS		(12*32+18) /* Load "kernel" (userspace) GS */
+#define X86_FEATURE_WRMSRNS		(12*32+19) /* Non-serializing WRMSR */
+#define X86_FEATURE_AMX_FP16		(12*32+21) /* AMX fp16 Support */
+#define X86_FEATURE_AVX_IFMA            (12*32+23) /* Support for VPMADD52[H,L]UQ */
+#define X86_FEATURE_LAM			(12*32+26) /* "lam" Linear Address Masking */
 
 /* AMD-defined CPU features, CPUID level 0x80000008 (EBX), word 13 */
-#define X86_FEATURE_CLZERO		(13*32+ 0) /* CLZERO instruction */
-#define X86_FEATURE_IRPERF		(13*32+ 1) /* Instructions Retired Count */
-#define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* Always save/restore FP error pointers */
-#define X86_FEATURE_RDPRU		(13*32+ 4) /* Read processor register at user level */
-#define X86_FEATURE_WBNOINVD		(13*32+ 9) /* WBNOINVD instruction */
-#define X86_FEATURE_AMD_IBPB		(13*32+12) /* "" Indirect Branch Prediction Barrier */
-#define X86_FEATURE_AMD_IBRS		(13*32+14) /* "" Indirect Branch Restricted Speculation */
-#define X86_FEATURE_AMD_STIBP		(13*32+15) /* "" Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* "" Single Thread Indirect Branch Predictors always-on preferred */
-#define X86_FEATURE_AMD_PPIN		(13*32+23) /* Protected Processor Inventory Number */
-#define X86_FEATURE_AMD_SSBD		(13*32+24) /* "" Speculative Store Bypass Disable */
-#define X86_FEATURE_VIRT_SSBD		(13*32+25) /* Virtualized Speculative Store Bypass Disable */
-#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* "" Speculative Store Bypass is fixed in hardware. */
-#define X86_FEATURE_CPPC		(13*32+27) /* Collaborative Processor Performance Control */
-#define X86_FEATURE_AMD_PSFD            (13*32+28) /* "" Predictive Store Forwarding Disable */
-#define X86_FEATURE_BTC_NO		(13*32+29) /* "" Not vulnerable to Branch Type Confusion */
-#define X86_FEATURE_BRS			(13*32+31) /* Branch Sampling available */
+#define X86_FEATURE_CLZERO		(13*32+ 0) /* "clzero" CLZERO instruction */
+#define X86_FEATURE_IRPERF		(13*32+ 1) /* "irperf" Instructions Retired Count */
+#define X86_FEATURE_XSAVEERPTR		(13*32+ 2) /* "xsaveerptr" Always save/restore FP error pointers */
+#define X86_FEATURE_RDPRU		(13*32+ 4) /* "rdpru" Read processor register at user level */
+#define X86_FEATURE_WBNOINVD		(13*32+ 9) /* "wbnoinvd" WBNOINVD instruction */
+#define X86_FEATURE_AMD_IBPB		(13*32+12) /* Indirect Branch Prediction Barrier */
+#define X86_FEATURE_AMD_IBRS		(13*32+14) /* Indirect Branch Restricted Speculation */
+#define X86_FEATURE_AMD_STIBP		(13*32+15) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_AMD_STIBP_ALWAYS_ON	(13*32+17) /* Single Thread Indirect Branch Predictors always-on preferred */
+#define X86_FEATURE_AMD_PPIN		(13*32+23) /* "amd_ppin" Protected Processor Inventory Number */
+#define X86_FEATURE_AMD_SSBD		(13*32+24) /* Speculative Store Bypass Disable */
+#define X86_FEATURE_VIRT_SSBD		(13*32+25) /* "virt_ssbd" Virtualized Speculative Store Bypass Disable */
+#define X86_FEATURE_AMD_SSB_NO		(13*32+26) /* Speculative Store Bypass is fixed in hardware. */
+#define X86_FEATURE_CPPC		(13*32+27) /* "cppc" Collaborative Processor Performance Control */
+#define X86_FEATURE_AMD_PSFD            (13*32+28) /* Predictive Store Forwarding Disable */
+#define X86_FEATURE_BTC_NO		(13*32+29) /* Not vulnerable to Branch Type Confusion */
+#define X86_FEATURE_BRS			(13*32+31) /* "brs" Branch Sampling available */
 
 /* Thermal and Power Management Leaf, CPUID level 0x00000006 (EAX), word 14 */
-#define X86_FEATURE_DTHERM		(14*32+ 0) /* Digital Thermal Sensor */
-#define X86_FEATURE_IDA			(14*32+ 1) /* Intel Dynamic Acceleration */
-#define X86_FEATURE_ARAT		(14*32+ 2) /* Always Running APIC Timer */
-#define X86_FEATURE_PLN			(14*32+ 4) /* Intel Power Limit Notification */
-#define X86_FEATURE_PTS			(14*32+ 6) /* Intel Package Thermal Status */
-#define X86_FEATURE_HWP			(14*32+ 7) /* Intel Hardware P-states */
-#define X86_FEATURE_HWP_NOTIFY		(14*32+ 8) /* HWP Notification */
-#define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* HWP Activity Window */
-#define X86_FEATURE_HWP_EPP		(14*32+10) /* HWP Energy Perf. Preference */
-#define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* HWP Package Level Request */
-#define X86_FEATURE_HFI			(14*32+19) /* Hardware Feedback Interface */
+#define X86_FEATURE_DTHERM		(14*32+ 0) /* "dtherm" Digital Thermal Sensor */
+#define X86_FEATURE_IDA			(14*32+ 1) /* "ida" Intel Dynamic Acceleration */
+#define X86_FEATURE_ARAT		(14*32+ 2) /* "arat" Always Running APIC Timer */
+#define X86_FEATURE_PLN			(14*32+ 4) /* "pln" Intel Power Limit Notification */
+#define X86_FEATURE_PTS			(14*32+ 6) /* "pts" Intel Package Thermal Status */
+#define X86_FEATURE_HWP			(14*32+ 7) /* "hwp" Intel Hardware P-states */
+#define X86_FEATURE_HWP_NOTIFY		(14*32+ 8) /* "hwp_notify" HWP Notification */
+#define X86_FEATURE_HWP_ACT_WINDOW	(14*32+ 9) /* "hwp_act_window" HWP Activity Window */
+#define X86_FEATURE_HWP_EPP		(14*32+10) /* "hwp_epp" HWP Energy Perf. Preference */
+#define X86_FEATURE_HWP_PKG_REQ		(14*32+11) /* "hwp_pkg_req" HWP Package Level Request */
+#define X86_FEATURE_HFI			(14*32+19) /* "hfi" Hardware Feedback Interface */
 
 /* AMD SVM Feature Identification, CPUID level 0x8000000a (EDX), word 15 */
-#define X86_FEATURE_NPT			(15*32+ 0) /* Nested Page Table support */
-#define X86_FEATURE_LBRV		(15*32+ 1) /* LBR Virtualization support */
+#define X86_FEATURE_NPT			(15*32+ 0) /* "npt" Nested Page Table support */
+#define X86_FEATURE_LBRV		(15*32+ 1) /* "lbrv" LBR Virtualization support */
 #define X86_FEATURE_SVML		(15*32+ 2) /* "svm_lock" SVM locking MSR */
 #define X86_FEATURE_NRIPS		(15*32+ 3) /* "nrip_save" SVM next_rip save */
 #define X86_FEATURE_TSCRATEMSR		(15*32+ 4) /* "tsc_scale" TSC scaling support */
 #define X86_FEATURE_VMCBCLEAN		(15*32+ 5) /* "vmcb_clean" VMCB clean bits support */
-#define X86_FEATURE_FLUSHBYASID		(15*32+ 6) /* flush-by-ASID support */
-#define X86_FEATURE_DECODEASSISTS	(15*32+ 7) /* Decode Assists support */
-#define X86_FEATURE_PAUSEFILTER		(15*32+10) /* filtered pause intercept */
-#define X86_FEATURE_PFTHRESHOLD		(15*32+12) /* pause filter threshold */
-#define X86_FEATURE_AVIC		(15*32+13) /* Virtual Interrupt Controller */
-#define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* Virtual VMSAVE VMLOAD */
-#define X86_FEATURE_VGIF		(15*32+16) /* Virtual GIF */
-#define X86_FEATURE_X2AVIC		(15*32+18) /* Virtual x2apic */
-#define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* Virtual SPEC_CTRL */
-#define X86_FEATURE_VNMI		(15*32+25) /* Virtual NMI */
-#define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* "" SVME addr check */
+#define X86_FEATURE_FLUSHBYASID		(15*32+ 6) /* "flushbyasid" Flush-by-ASID support */
+#define X86_FEATURE_DECODEASSISTS	(15*32+ 7) /* "decodeassists" Decode Assists support */
+#define X86_FEATURE_PAUSEFILTER		(15*32+10) /* "pausefilter" Filtered pause intercept */
+#define X86_FEATURE_PFTHRESHOLD		(15*32+12) /* "pfthreshold" Pause filter threshold */
+#define X86_FEATURE_AVIC		(15*32+13) /* "avic" Virtual Interrupt Controller */
+#define X86_FEATURE_V_VMSAVE_VMLOAD	(15*32+15) /* "v_vmsave_vmload" Virtual VMSAVE VMLOAD */
+#define X86_FEATURE_VGIF		(15*32+16) /* "vgif" Virtual GIF */
+#define X86_FEATURE_X2AVIC		(15*32+18) /* "x2avic" Virtual x2apic */
+#define X86_FEATURE_V_SPEC_CTRL		(15*32+20) /* "v_spec_ctrl" Virtual SPEC_CTRL */
+#define X86_FEATURE_VNMI		(15*32+25) /* "vnmi" Virtual NMI */
+#define X86_FEATURE_SVME_ADDR_CHK	(15*32+28) /* SVME addr check */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (ECX), word 16 */
-#define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* AVX512 Vector Bit Manipulation instructions*/
-#define X86_FEATURE_UMIP		(16*32+ 2) /* User Mode Instruction Protection */
-#define X86_FEATURE_PKU			(16*32+ 3) /* Protection Keys for Userspace */
-#define X86_FEATURE_OSPKE		(16*32+ 4) /* OS Protection Keys Enable */
-#define X86_FEATURE_WAITPKG		(16*32+ 5) /* UMONITOR/UMWAIT/TPAUSE Instructions */
-#define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* Additional AVX512 Vector Bit Manipulation Instructions */
-#define X86_FEATURE_SHSTK		(16*32+ 7) /* "" Shadow stack */
-#define X86_FEATURE_GFNI		(16*32+ 8) /* Galois Field New Instructions */
-#define X86_FEATURE_VAES		(16*32+ 9) /* Vector AES */
-#define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* Carry-Less Multiplication Double Quadword */
-#define X86_FEATURE_AVX512_VNNI		(16*32+11) /* Vector Neural Network Instructions */
-#define X86_FEATURE_AVX512_BITALG	(16*32+12) /* Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
-#define X86_FEATURE_TME			(16*32+13) /* Intel Total Memory Encryption */
-#define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* POPCNT for vectors of DW/QW */
-#define X86_FEATURE_LA57		(16*32+16) /* 5-level page tables */
-#define X86_FEATURE_RDPID		(16*32+22) /* RDPID instruction */
-#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* Bus Lock detect */
-#define X86_FEATURE_CLDEMOTE		(16*32+25) /* CLDEMOTE instruction */
-#define X86_FEATURE_MOVDIRI		(16*32+27) /* MOVDIRI instruction */
-#define X86_FEATURE_MOVDIR64B		(16*32+28) /* MOVDIR64B instruction */
-#define X86_FEATURE_ENQCMD		(16*32+29) /* ENQCMD and ENQCMDS instructions */
-#define X86_FEATURE_SGX_LC		(16*32+30) /* Software Guard Extensions Launch Control */
+#define X86_FEATURE_AVX512VBMI		(16*32+ 1) /* "avx512vbmi" AVX512 Vector Bit Manipulation instructions*/
+#define X86_FEATURE_UMIP		(16*32+ 2) /* "umip" User Mode Instruction Protection */
+#define X86_FEATURE_PKU			(16*32+ 3) /* "pku" Protection Keys for Userspace */
+#define X86_FEATURE_OSPKE		(16*32+ 4) /* "ospke" OS Protection Keys Enable */
+#define X86_FEATURE_WAITPKG		(16*32+ 5) /* "waitpkg" UMONITOR/UMWAIT/TPAUSE Instructions */
+#define X86_FEATURE_AVX512_VBMI2	(16*32+ 6) /* "avx512_vbmi2" Additional AVX512 Vector Bit Manipulation Instructions */
+#define X86_FEATURE_SHSTK		(16*32+ 7) /* Shadow stack */
+#define X86_FEATURE_GFNI		(16*32+ 8) /* "gfni" Galois Field New Instructions */
+#define X86_FEATURE_VAES		(16*32+ 9) /* "vaes" Vector AES */
+#define X86_FEATURE_VPCLMULQDQ		(16*32+10) /* "vpclmulqdq" Carry-Less Multiplication Double Quadword */
+#define X86_FEATURE_AVX512_VNNI		(16*32+11) /* "avx512_vnni" Vector Neural Network Instructions */
+#define X86_FEATURE_AVX512_BITALG	(16*32+12) /* "avx512_bitalg" Support for VPOPCNT[B,W] and VPSHUF-BITQMB instructions */
+#define X86_FEATURE_TME			(16*32+13) /* "tme" Intel Total Memory Encryption */
+#define X86_FEATURE_AVX512_VPOPCNTDQ	(16*32+14) /* "avx512_vpopcntdq" POPCNT for vectors of DW/QW */
+#define X86_FEATURE_LA57		(16*32+16) /* "la57" 5-level page tables */
+#define X86_FEATURE_RDPID		(16*32+22) /* "rdpid" RDPID instruction */
+#define X86_FEATURE_BUS_LOCK_DETECT	(16*32+24) /* "bus_lock_detect" Bus Lock detect */
+#define X86_FEATURE_CLDEMOTE		(16*32+25) /* "cldemote" CLDEMOTE instruction */
+#define X86_FEATURE_MOVDIRI		(16*32+27) /* "movdiri" MOVDIRI instruction */
+#define X86_FEATURE_MOVDIR64B		(16*32+28) /* "movdir64b" MOVDIR64B instruction */
+#define X86_FEATURE_ENQCMD		(16*32+29) /* "enqcmd" ENQCMD and ENQCMDS instructions */
+#define X86_FEATURE_SGX_LC		(16*32+30) /* "sgx_lc" Software Guard Extensions Launch Control */
 
 /* AMD-defined CPU features, CPUID level 0x80000007 (EBX), word 17 */
-#define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* MCA overflow recovery support */
-#define X86_FEATURE_SUCCOR		(17*32+ 1) /* Uncorrectable error containment and recovery */
-#define X86_FEATURE_SMCA		(17*32+ 3) /* Scalable MCA */
+#define X86_FEATURE_OVERFLOW_RECOV	(17*32+ 0) /* "overflow_recov" MCA overflow recovery support */
+#define X86_FEATURE_SUCCOR		(17*32+ 1) /* "succor" Uncorrectable error containment and recovery */
+#define X86_FEATURE_SMCA		(17*32+ 3) /* "smca" Scalable MCA */
 
 /* Intel-defined CPU features, CPUID level 0x00000007:0 (EDX), word 18 */
-#define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* AVX-512 Neural Network Instructions */
-#define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* AVX-512 Multiply Accumulation Single precision */
-#define X86_FEATURE_FSRM		(18*32+ 4) /* Fast Short Rep Mov */
-#define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersect for D/Q */
-#define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* "" SRBDS mitigation MSR available */
-#define X86_FEATURE_MD_CLEAR		(18*32+10) /* VERW clears CPU buffers */
-#define X86_FEATURE_RTM_ALWAYS_ABORT	(18*32+11) /* "" RTM transaction always aborts */
-#define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* "" TSX_FORCE_ABORT */
-#define X86_FEATURE_SERIALIZE		(18*32+14) /* SERIALIZE instruction */
-#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* "" This part has CPUs of more than one type */
-#define X86_FEATURE_TSXLDTRK		(18*32+16) /* TSX Suspend Load Address Tracking */
-#define X86_FEATURE_PCONFIG		(18*32+18) /* Intel PCONFIG */
-#define X86_FEATURE_ARCH_LBR		(18*32+19) /* Intel ARCH LBR */
-#define X86_FEATURE_IBT			(18*32+20) /* Indirect Branch Tracking */
-#define X86_FEATURE_AMX_BF16		(18*32+22) /* AMX bf16 Support */
-#define X86_FEATURE_AVX512_FP16		(18*32+23) /* AVX512 FP16 */
-#define X86_FEATURE_AMX_TILE		(18*32+24) /* AMX tile Support */
-#define X86_FEATURE_AMX_INT8		(18*32+25) /* AMX int8 Support */
-#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* "" Speculation Control (IBRS + IBPB) */
-#define X86_FEATURE_INTEL_STIBP		(18*32+27) /* "" Single Thread Indirect Branch Predictors */
-#define X86_FEATURE_FLUSH_L1D		(18*32+28) /* Flush L1D cache */
-#define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* IA32_ARCH_CAPABILITIES MSR (Intel) */
-#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* "" IA32_CORE_CAPABILITIES MSR */
-#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* "" Speculative Store Bypass Disable */
+#define X86_FEATURE_AVX512_4VNNIW	(18*32+ 2) /* "avx512_4vnniw" AVX-512 Neural Network Instructions */
+#define X86_FEATURE_AVX512_4FMAPS	(18*32+ 3) /* "avx512_4fmaps" AVX-512 Multiply Accumulation Single precision */
+#define X86_FEATURE_FSRM		(18*32+ 4) /* "fsrm" Fast Short Rep Mov */
+#define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* "avx512_vp2intersect" AVX-512 Intersect for D/Q */
+#define X86_FEATURE_SRBDS_CTRL		(18*32+ 9) /* SRBDS mitigation MSR available */
+#define X86_FEATURE_MD_CLEAR		(18*32+10) /* "md_clear" VERW clears CPU buffers */
+#define X86_FEATURE_RTM_ALWAYS_ABORT	(18*32+11) /* RTM transaction always aborts */
+#define X86_FEATURE_TSX_FORCE_ABORT	(18*32+13) /* TSX_FORCE_ABORT */
+#define X86_FEATURE_SERIALIZE		(18*32+14) /* "serialize" SERIALIZE instruction */
+#define X86_FEATURE_HYBRID_CPU		(18*32+15) /* This part has CPUs of more than one type */
+#define X86_FEATURE_TSXLDTRK		(18*32+16) /* "tsxldtrk" TSX Suspend Load Address Tracking */
+#define X86_FEATURE_PCONFIG		(18*32+18) /* "pconfig" Intel PCONFIG */
+#define X86_FEATURE_ARCH_LBR		(18*32+19) /* "arch_lbr" Intel ARCH LBR */
+#define X86_FEATURE_IBT			(18*32+20) /* "ibt" Indirect Branch Tracking */
+#define X86_FEATURE_AMX_BF16		(18*32+22) /* "amx_bf16" AMX bf16 Support */
+#define X86_FEATURE_AVX512_FP16		(18*32+23) /* "avx512_fp16" AVX512 FP16 */
+#define X86_FEATURE_AMX_TILE		(18*32+24) /* "amx_tile" AMX tile Support */
+#define X86_FEATURE_AMX_INT8		(18*32+25) /* "amx_int8" AMX int8 Support */
+#define X86_FEATURE_SPEC_CTRL		(18*32+26) /* Speculation Control (IBRS + IBPB) */
+#define X86_FEATURE_INTEL_STIBP		(18*32+27) /* Single Thread Indirect Branch Predictors */
+#define X86_FEATURE_FLUSH_L1D		(18*32+28) /* "flush_l1d" Flush L1D cache */
+#define X86_FEATURE_ARCH_CAPABILITIES	(18*32+29) /* "arch_capabilities" IA32_ARCH_CAPABILITIES MSR (Intel) */
+#define X86_FEATURE_CORE_CAPABILITIES	(18*32+30) /* IA32_CORE_CAPABILITIES MSR */
+#define X86_FEATURE_SPEC_CTRL_SSBD	(18*32+31) /* Speculative Store Bypass Disable */
 
 /* AMD-defined memory encryption features, CPUID level 0x8000001f (EAX), word 19 */
-#define X86_FEATURE_SME			(19*32+ 0) /* AMD Secure Memory Encryption */
-#define X86_FEATURE_SEV			(19*32+ 1) /* AMD Secure Encrypted Virtualization */
-#define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* "" VM Page Flush MSR is supported */
-#define X86_FEATURE_SEV_ES		(19*32+ 3) /* AMD Secure Encrypted Virtualization - Encrypted State */
-#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* AMD Secure Encrypted Virtualization - Secure Nested Paging */
-#define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* "" Virtual TSC_AUX */
-#define X86_FEATURE_SME_COHERENT	(19*32+10) /* "" AMD hardware-enforced cache coherency */
-#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* AMD SEV-ES full debug state swap support */
+#define X86_FEATURE_SME			(19*32+ 0) /* "sme" AMD Secure Memory Encryption */
+#define X86_FEATURE_SEV			(19*32+ 1) /* "sev" AMD Secure Encrypted Virtualization */
+#define X86_FEATURE_VM_PAGE_FLUSH	(19*32+ 2) /* VM Page Flush MSR is supported */
+#define X86_FEATURE_SEV_ES		(19*32+ 3) /* "sev_es" AMD Secure Encrypted Virtualization - Encrypted State */
+#define X86_FEATURE_SEV_SNP		(19*32+ 4) /* "sev_snp" AMD Secure Encrypted Virtualization - Secure Nested Paging */
+#define X86_FEATURE_V_TSC_AUX		(19*32+ 9) /* Virtual TSC_AUX */
+#define X86_FEATURE_SME_COHERENT	(19*32+10) /* AMD hardware-enforced cache coherency */
+#define X86_FEATURE_DEBUG_SWAP		(19*32+14) /* "debug_swap" AMD SEV-ES full debug state swap support */
 
 /* AMD-defined Extended Feature 2 EAX, CPUID level 0x80000021 (EAX), word 20 */
-#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* "" No Nested Data Breakpoints */
-#define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* "" WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
-#define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* "" LFENCE always serializing / synchronizes RDTSC */
-#define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* "" Null Selector Clears Base */
-#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* "" Automatic IBRS */
-#define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* "" SMM_CTL MSR is not present */
+#define X86_FEATURE_NO_NESTED_DATA_BP	(20*32+ 0) /* No Nested Data Breakpoints */
+#define X86_FEATURE_WRMSR_XX_BASE_NS	(20*32+ 1) /* WRMSR to {FS,GS,KERNEL_GS}_BASE is non-serializing */
+#define X86_FEATURE_LFENCE_RDTSC	(20*32+ 2) /* LFENCE always serializing / synchronizes RDTSC */
+#define X86_FEATURE_NULL_SEL_CLR_BASE	(20*32+ 6) /* Null Selector Clears Base */
+#define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
+#define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not present */
 
-#define X86_FEATURE_SBPB		(20*32+27) /* "" Selective Branch Prediction Barrier */
-#define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* "" MSR_PRED_CMD[IBPB] flushes all branch type predictions */
-#define X86_FEATURE_SRSO_NO		(20*32+29) /* "" CPU is not affected by SRSO */
+#define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
+#define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
+#define X86_FEATURE_SRSO_NO		(20*32+29) /* CPU is not affected by SRSO */
 
 /*
  * Extended auxiliary flags: Linux defined - for features scattered in various
@@ -465,59 +465,59 @@
  *
  * Reuse free bits when adding new feature flags!
  */
-#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* AMD LBR and PMC Freeze */
-#define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* "" Clear branch history at syscall entry using SW loop */
-#define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* "" BHI_DIS_S HW control available */
-#define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* "" BHI_DIS_S HW control enabled */
-#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* "" Clear branch history at vmexit using SW loop */
+#define X86_FEATURE_AMD_LBR_PMC_FREEZE	(21*32+ 0) /* "amd_lbr_pmc_freeze" AMD LBR and PMC Freeze */
+#define X86_FEATURE_CLEAR_BHB_LOOP	(21*32+ 1) /* Clear branch history at syscall entry using SW loop */
+#define X86_FEATURE_BHI_CTRL		(21*32+ 2) /* BHI_DIS_S HW control available */
+#define X86_FEATURE_CLEAR_BHB_HW	(21*32+ 3) /* BHI_DIS_S HW control enabled */
+#define X86_FEATURE_CLEAR_BHB_LOOP_ON_VMEXIT (21*32+ 4) /* Clear branch history at vmexit using SW loop */
 
 /*
  * BUG word(s)
  */
 #define X86_BUG(x)			(NCAPINTS*32 + (x))
 
-#define X86_BUG_F00F			X86_BUG(0) /* Intel F00F */
-#define X86_BUG_FDIV			X86_BUG(1) /* FPU FDIV */
-#define X86_BUG_COMA			X86_BUG(2) /* Cyrix 6x86 coma */
+#define X86_BUG_F00F			X86_BUG(0) /* "f00f" Intel F00F */
+#define X86_BUG_FDIV			X86_BUG(1) /* "fdiv" FPU FDIV */
+#define X86_BUG_COMA			X86_BUG(2) /* "coma" Cyrix 6x86 coma */
 #define X86_BUG_AMD_TLB_MMATCH		X86_BUG(3) /* "tlb_mmatch" AMD Erratum 383 */
 #define X86_BUG_AMD_APIC_C1E		X86_BUG(4) /* "apic_c1e" AMD Erratum 400 */
-#define X86_BUG_11AP			X86_BUG(5) /* Bad local APIC aka 11AP */
-#define X86_BUG_FXSAVE_LEAK		X86_BUG(6) /* FXSAVE leaks FOP/FIP/FOP */
-#define X86_BUG_CLFLUSH_MONITOR		X86_BUG(7) /* AAI65, CLFLUSH required before MONITOR */
-#define X86_BUG_SYSRET_SS_ATTRS		X86_BUG(8) /* SYSRET doesn't fix up SS attrs */
+#define X86_BUG_11AP			X86_BUG(5) /* "11ap" Bad local APIC aka 11AP */
+#define X86_BUG_FXSAVE_LEAK		X86_BUG(6) /* "fxsave_leak" FXSAVE leaks FOP/FIP/FOP */
+#define X86_BUG_CLFLUSH_MONITOR		X86_BUG(7) /* "clflush_monitor" AAI65, CLFLUSH required before MONITOR */
+#define X86_BUG_SYSRET_SS_ATTRS		X86_BUG(8) /* "sysret_ss_attrs" SYSRET doesn't fix up SS attrs */
 #ifdef CONFIG_X86_32
 /*
  * 64-bit kernels don't use X86_BUG_ESPFIX.  Make the define conditional
  * to avoid confusion.
  */
-#define X86_BUG_ESPFIX			X86_BUG(9) /* "" IRET to 16-bit SS corrupts ESP/RSP high bits */
+#define X86_BUG_ESPFIX			X86_BUG(9) /* IRET to 16-bit SS corrupts ESP/RSP high bits */
 #endif
-#define X86_BUG_NULL_SEG		X86_BUG(10) /* Nulling a selector preserves the base */
-#define X86_BUG_SWAPGS_FENCE		X86_BUG(11) /* SWAPGS without input dep on GS */
-#define X86_BUG_MONITOR			X86_BUG(12) /* IPI required to wake up remote CPU */
-#define X86_BUG_AMD_E400		X86_BUG(13) /* CPU is among the affected by Erratum 400 */
-#define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* CPU is affected by meltdown attack and needs kernel page table isolation */
-#define X86_BUG_SPECTRE_V1		X86_BUG(15) /* CPU is affected by Spectre variant 1 attack with conditional branches */
-#define X86_BUG_SPECTRE_V2		X86_BUG(16) /* CPU is affected by Spectre variant 2 attack with indirect branches */
-#define X86_BUG_SPEC_STORE_BYPASS	X86_BUG(17) /* CPU is affected by speculative store bypass attack */
-#define X86_BUG_L1TF			X86_BUG(18) /* CPU is affected by L1 Terminal Fault */
-#define X86_BUG_MDS			X86_BUG(19) /* CPU is affected by Microarchitectural data sampling */
-#define X86_BUG_MSBDS_ONLY		X86_BUG(20) /* CPU is only affected by the  MSDBS variant of BUG_MDS */
-#define X86_BUG_SWAPGS			X86_BUG(21) /* CPU is affected by speculation through SWAPGS */
-#define X86_BUG_TAA			X86_BUG(22) /* CPU is affected by TSX Async Abort(TAA) */
-#define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* CPU may incur MCE during certain page attribute changes */
-#define X86_BUG_SRBDS			X86_BUG(24) /* CPU may leak RNG bits if not mitigated */
-#define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* CPU is affected by Processor MMIO Stale Data vulnerabilities */
-#define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* CPU is too old and its MMIO Stale Data status is unknown */
-#define X86_BUG_RETBLEED		X86_BUG(27) /* CPU is affected by RETBleed */
-#define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* EIBRS is vulnerable to Post Barrier RSB Predictions */
-#define X86_BUG_SMT_RSB			X86_BUG(29) /* CPU is vulnerable to Cross-Thread Return Address Predictions */
-#define X86_BUG_GDS			X86_BUG(30) /* CPU is affected by Gather Data Sampling */
-#define X86_BUG_TDX_PW_MCE		X86_BUG(31) /* CPU may incur #MC if non-TD software does partial write to TDX private memory */
+#define X86_BUG_NULL_SEG		X86_BUG(10) /* "null_seg" Nulling a selector preserves the base */
+#define X86_BUG_SWAPGS_FENCE		X86_BUG(11) /* "swapgs_fence" SWAPGS without input dep on GS */
+#define X86_BUG_MONITOR			X86_BUG(12) /* "monitor" IPI required to wake up remote CPU */
+#define X86_BUG_AMD_E400		X86_BUG(13) /* "amd_e400" CPU is among the affected by Erratum 400 */
+#define X86_BUG_CPU_MELTDOWN		X86_BUG(14) /* "cpu_meltdown" CPU is affected by meltdown attack and needs kernel page table isolation */
+#define X86_BUG_SPECTRE_V1		X86_BUG(15) /* "spectre_v1" CPU is affected by Spectre variant 1 attack with conditional branches */
+#define X86_BUG_SPECTRE_V2		X86_BUG(16) /* "spectre_v2" CPU is affected by Spectre variant 2 attack with indirect branches */
+#define X86_BUG_SPEC_STORE_BYPASS	X86_BUG(17) /* "spec_store_bypass" CPU is affected by speculative store bypass attack */
+#define X86_BUG_L1TF			X86_BUG(18) /* "l1tf" CPU is affected by L1 Terminal Fault */
+#define X86_BUG_MDS			X86_BUG(19) /* "mds" CPU is affected by Microarchitectural data sampling */
+#define X86_BUG_MSBDS_ONLY		X86_BUG(20) /* "msbds_only" CPU is only affected by the  MSDBS variant of BUG_MDS */
+#define X86_BUG_SWAPGS			X86_BUG(21) /* "swapgs" CPU is affected by speculation through SWAPGS */
+#define X86_BUG_TAA			X86_BUG(22) /* "taa" CPU is affected by TSX Async Abort(TAA) */
+#define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* "itlb_multihit" CPU may incur MCE during certain page attribute changes */
+#define X86_BUG_SRBDS			X86_BUG(24) /* "srbds" CPU may leak RNG bits if not mitigated */
+#define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* "mmio_stale_data" CPU is affected by Processor MMIO Stale Data vulnerabilities */
+#define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
+#define X86_BUG_RETBLEED		X86_BUG(27) /* "retbleed" CPU is affected by RETBleed */
+#define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* "eibrs_pbrsb" EIBRS is vulnerable to Post Barrier RSB Predictions */
+#define X86_BUG_SMT_RSB			X86_BUG(29) /* "smt_rsb" CPU is vulnerable to Cross-Thread Return Address Predictions */
+#define X86_BUG_GDS			X86_BUG(30) /* "gds" CPU is affected by Gather Data Sampling */
+#define X86_BUG_TDX_PW_MCE		X86_BUG(31) /* "tdx_pw_mce" CPU may incur #MC if non-TD software does partial write to TDX private memory */
 
 /* BUG word 2 */
-#define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* AMD SRSO bug */
-#define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* AMD DIV0 speculation bug */
-#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* CPU is vulnerable to Register File Data Sampling */
-#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* CPU is affected by Branch History Injection */
+#define X86_BUG_SRSO			X86_BUG(1*32 + 0) /* "srso" AMD SRSO bug */
+#define X86_BUG_DIV0			X86_BUG(1*32 + 1) /* "div0" AMD DIV0 speculation bug */
+#define X86_BUG_RFDS			X86_BUG(1*32 + 2) /* "rfds" CPU is vulnerable to Register File Data Sampling */
+#define X86_BUG_BHI			X86_BUG(1*32 + 3) /* "bhi" CPU is affected by Branch History Injection */
 #endif /* _ASM_X86_CPUFEATURES_H */
diff --git a/arch/x86/include/asm/vmxfeatures.h b/arch/x86/include/asm/vmxfeatures.h
index 266daf5..fe42067 100644
--- a/arch/x86/include/asm/vmxfeatures.h
+++ b/arch/x86/include/asm/vmxfeatures.h
@@ -9,85 +9,85 @@
 
 /*
  * Note: If the comment begins with a quoted string, that string is used
- * in /proc/cpuinfo instead of the macro name.  If the string is "",
- * this feature bit is not displayed in /proc/cpuinfo at all.
+ * in /proc/cpuinfo instead of the macro name.  Otherwise, this feature bit
+ * is not displayed in /proc/cpuinfo at all.
  */
 
 /* Pin-Based VM-Execution Controls, EPT/VPID, APIC and VM-Functions, word 0 */
-#define VMX_FEATURE_INTR_EXITING	( 0*32+  0) /* "" VM-Exit on vectored interrupts */
-#define VMX_FEATURE_NMI_EXITING		( 0*32+  3) /* "" VM-Exit on NMIs */
+#define VMX_FEATURE_INTR_EXITING	( 0*32+  0) /* VM-Exit on vectored interrupts */
+#define VMX_FEATURE_NMI_EXITING		( 0*32+  3) /* VM-Exit on NMIs */
 #define VMX_FEATURE_VIRTUAL_NMIS	( 0*32+  5) /* "vnmi" NMI virtualization */
-#define VMX_FEATURE_PREEMPTION_TIMER	( 0*32+  6) /* VMX Preemption Timer */
-#define VMX_FEATURE_POSTED_INTR		( 0*32+  7) /* Posted Interrupts */
+#define VMX_FEATURE_PREEMPTION_TIMER	( 0*32+  6) /* "preemption_timer" VMX Preemption Timer */
+#define VMX_FEATURE_POSTED_INTR		( 0*32+  7) /* "posted_intr" Posted Interrupts */
 
 /* EPT/VPID features, scattered to bits 16-23 */
-#define VMX_FEATURE_INVVPID		( 0*32+ 16) /* INVVPID is supported */
+#define VMX_FEATURE_INVVPID		( 0*32+ 16) /* "invvpid" INVVPID is supported */
 #define VMX_FEATURE_EPT_EXECUTE_ONLY	( 0*32+ 17) /* "ept_x_only" EPT entries can be execute only */
-#define VMX_FEATURE_EPT_AD		( 0*32+ 18) /* EPT Accessed/Dirty bits */
-#define VMX_FEATURE_EPT_1GB		( 0*32+ 19) /* 1GB EPT pages */
-#define VMX_FEATURE_EPT_5LEVEL		( 0*32+ 20) /* 5-level EPT paging */
+#define VMX_FEATURE_EPT_AD		( 0*32+ 18) /* "ept_ad" EPT Accessed/Dirty bits */
+#define VMX_FEATURE_EPT_1GB		( 0*32+ 19) /* "ept_1gb" 1GB EPT pages */
+#define VMX_FEATURE_EPT_5LEVEL		( 0*32+ 20) /* "ept_5level" 5-level EPT paging */
 
 /* Aggregated APIC features 24-27 */
-#define VMX_FEATURE_FLEXPRIORITY	( 0*32+ 24) /* TPR shadow + virt APIC */
-#define VMX_FEATURE_APICV	        ( 0*32+ 25) /* TPR shadow + APIC reg virt + virt intr delivery + posted interrupts */
+#define VMX_FEATURE_FLEXPRIORITY	( 0*32+ 24) /* "flexpriority" TPR shadow + virt APIC */
+#define VMX_FEATURE_APICV	        ( 0*32+ 25) /* "apicv" TPR shadow + APIC reg virt + virt intr delivery + posted interrupts */
 
 /* VM-Functions, shifted to bits 28-31 */
-#define VMX_FEATURE_EPTP_SWITCHING	( 0*32+ 28) /* EPTP switching (in guest) */
+#define VMX_FEATURE_EPTP_SWITCHING	( 0*32+ 28) /* "eptp_switching" EPTP switching (in guest) */
 
 /* Primary Processor-Based VM-Execution Controls, word 1 */
-#define VMX_FEATURE_INTR_WINDOW_EXITING ( 1*32+  2) /* "" VM-Exit if INTRs are unblocked in guest */
+#define VMX_FEATURE_INTR_WINDOW_EXITING ( 1*32+  2) /* VM-Exit if INTRs are unblocked in guest */
 #define VMX_FEATURE_USE_TSC_OFFSETTING	( 1*32+  3) /* "tsc_offset" Offset hardware TSC when read in guest */
-#define VMX_FEATURE_HLT_EXITING		( 1*32+  7) /* "" VM-Exit on HLT */
-#define VMX_FEATURE_INVLPG_EXITING	( 1*32+  9) /* "" VM-Exit on INVLPG */
-#define VMX_FEATURE_MWAIT_EXITING	( 1*32+ 10) /* "" VM-Exit on MWAIT */
-#define VMX_FEATURE_RDPMC_EXITING	( 1*32+ 11) /* "" VM-Exit on RDPMC */
-#define VMX_FEATURE_RDTSC_EXITING	( 1*32+ 12) /* "" VM-Exit on RDTSC */
-#define VMX_FEATURE_CR3_LOAD_EXITING	( 1*32+ 15) /* "" VM-Exit on writes to CR3 */
-#define VMX_FEATURE_CR3_STORE_EXITING	( 1*32+ 16) /* "" VM-Exit on reads from CR3 */
-#define VMX_FEATURE_TERTIARY_CONTROLS	( 1*32+ 17) /* "" Enable Tertiary VM-Execution Controls */
-#define VMX_FEATURE_CR8_LOAD_EXITING	( 1*32+ 19) /* "" VM-Exit on writes to CR8 */
-#define VMX_FEATURE_CR8_STORE_EXITING	( 1*32+ 20) /* "" VM-Exit on reads from CR8 */
+#define VMX_FEATURE_HLT_EXITING		( 1*32+  7) /* VM-Exit on HLT */
+#define VMX_FEATURE_INVLPG_EXITING	( 1*32+  9) /* VM-Exit on INVLPG */
+#define VMX_FEATURE_MWAIT_EXITING	( 1*32+ 10) /* VM-Exit on MWAIT */
+#define VMX_FEATURE_RDPMC_EXITING	( 1*32+ 11) /* VM-Exit on RDPMC */
+#define VMX_FEATURE_RDTSC_EXITING	( 1*32+ 12) /* VM-Exit on RDTSC */
+#define VMX_FEATURE_CR3_LOAD_EXITING	( 1*32+ 15) /* VM-Exit on writes to CR3 */
+#define VMX_FEATURE_CR3_STORE_EXITING	( 1*32+ 16) /* VM-Exit on reads from CR3 */
+#define VMX_FEATURE_TERTIARY_CONTROLS	( 1*32+ 17) /* Enable Tertiary VM-Execution Controls */
+#define VMX_FEATURE_CR8_LOAD_EXITING	( 1*32+ 19) /* VM-Exit on writes to CR8 */
+#define VMX_FEATURE_CR8_STORE_EXITING	( 1*32+ 20) /* VM-Exit on reads from CR8 */
 #define VMX_FEATURE_VIRTUAL_TPR		( 1*32+ 21) /* "vtpr" TPR virtualization, a.k.a. TPR shadow */
-#define VMX_FEATURE_NMI_WINDOW_EXITING	( 1*32+ 22) /* "" VM-Exit if NMIs are unblocked in guest */
-#define VMX_FEATURE_MOV_DR_EXITING	( 1*32+ 23) /* "" VM-Exit on accesses to debug registers */
-#define VMX_FEATURE_UNCOND_IO_EXITING	( 1*32+ 24) /* "" VM-Exit on *all* IN{S} and OUT{S}*/
-#define VMX_FEATURE_USE_IO_BITMAPS	( 1*32+ 25) /* "" VM-Exit based on I/O port */
+#define VMX_FEATURE_NMI_WINDOW_EXITING	( 1*32+ 22) /* VM-Exit if NMIs are unblocked in guest */
+#define VMX_FEATURE_MOV_DR_EXITING	( 1*32+ 23) /* VM-Exit on accesses to debug registers */
+#define VMX_FEATURE_UNCOND_IO_EXITING	( 1*32+ 24) /* VM-Exit on *all* IN{S} and OUT{S}*/
+#define VMX_FEATURE_USE_IO_BITMAPS	( 1*32+ 25) /* VM-Exit based on I/O port */
 #define VMX_FEATURE_MONITOR_TRAP_FLAG	( 1*32+ 27) /* "mtf" VMX single-step VM-Exits */
-#define VMX_FEATURE_USE_MSR_BITMAPS	( 1*32+ 28) /* "" VM-Exit based on MSR index */
-#define VMX_FEATURE_MONITOR_EXITING	( 1*32+ 29) /* "" VM-Exit on MONITOR (MWAIT's accomplice) */
-#define VMX_FEATURE_PAUSE_EXITING	( 1*32+ 30) /* "" VM-Exit on PAUSE (unconditionally) */
-#define VMX_FEATURE_SEC_CONTROLS	( 1*32+ 31) /* "" Enable Secondary VM-Execution Controls */
+#define VMX_FEATURE_USE_MSR_BITMAPS	( 1*32+ 28) /* VM-Exit based on MSR index */
+#define VMX_FEATURE_MONITOR_EXITING	( 1*32+ 29) /* VM-Exit on MONITOR (MWAIT's accomplice) */
+#define VMX_FEATURE_PAUSE_EXITING	( 1*32+ 30) /* VM-Exit on PAUSE (unconditionally) */
+#define VMX_FEATURE_SEC_CONTROLS	( 1*32+ 31) /* Enable Secondary VM-Execution Controls */
 
 /* Secondary Processor-Based VM-Execution Controls, word 2 */
 #define VMX_FEATURE_VIRT_APIC_ACCESSES	( 2*32+  0) /* "vapic" Virtualize memory mapped APIC accesses */
-#define VMX_FEATURE_EPT			( 2*32+  1) /* Extended Page Tables, a.k.a. Two-Dimensional Paging */
-#define VMX_FEATURE_DESC_EXITING	( 2*32+  2) /* "" VM-Exit on {S,L}*DT instructions */
-#define VMX_FEATURE_RDTSCP		( 2*32+  3) /* "" Enable RDTSCP in guest */
-#define VMX_FEATURE_VIRTUAL_X2APIC	( 2*32+  4) /* "" Virtualize X2APIC for the guest */
-#define VMX_FEATURE_VPID		( 2*32+  5) /* Virtual Processor ID (TLB ASID modifier) */
-#define VMX_FEATURE_WBINVD_EXITING	( 2*32+  6) /* "" VM-Exit on WBINVD */
-#define VMX_FEATURE_UNRESTRICTED_GUEST	( 2*32+  7) /* Allow Big Real Mode and other "invalid" states */
+#define VMX_FEATURE_EPT			( 2*32+  1) /* "ept" Extended Page Tables, a.k.a. Two-Dimensional Paging */
+#define VMX_FEATURE_DESC_EXITING	( 2*32+  2) /* VM-Exit on {S,L}*DT instructions */
+#define VMX_FEATURE_RDTSCP		( 2*32+  3) /* Enable RDTSCP in guest */
+#define VMX_FEATURE_VIRTUAL_X2APIC	( 2*32+  4) /* Virtualize X2APIC for the guest */
+#define VMX_FEATURE_VPID		( 2*32+  5) /* "vpid" Virtual Processor ID (TLB ASID modifier) */
+#define VMX_FEATURE_WBINVD_EXITING	( 2*32+  6) /* VM-Exit on WBINVD */
+#define VMX_FEATURE_UNRESTRICTED_GUEST	( 2*32+  7) /* "unrestricted_guest" Allow Big Real Mode and other "invalid" states */
 #define VMX_FEATURE_APIC_REGISTER_VIRT	( 2*32+  8) /* "vapic_reg" Hardware emulation of reads to the virtual-APIC */
 #define VMX_FEATURE_VIRT_INTR_DELIVERY	( 2*32+  9) /* "vid" Evaluation and delivery of pending virtual interrupts */
 #define VMX_FEATURE_PAUSE_LOOP_EXITING	( 2*32+ 10) /* "ple" Conditionally VM-Exit on PAUSE at CPL0 */
-#define VMX_FEATURE_RDRAND_EXITING	( 2*32+ 11) /* "" VM-Exit on RDRAND*/
-#define VMX_FEATURE_INVPCID		( 2*32+ 12) /* "" Enable INVPCID in guest */
-#define VMX_FEATURE_VMFUNC		( 2*32+ 13) /* "" Enable VM-Functions (leaf dependent) */
-#define VMX_FEATURE_SHADOW_VMCS		( 2*32+ 14) /* VMREAD/VMWRITE in guest can access shadow VMCS */
-#define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* "" VM-Exit on ENCLS (leaf dependent) */
-#define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* "" VM-Exit on RDSEED */
+#define VMX_FEATURE_RDRAND_EXITING	( 2*32+ 11) /* VM-Exit on RDRAND*/
+#define VMX_FEATURE_INVPCID		( 2*32+ 12) /* Enable INVPCID in guest */
+#define VMX_FEATURE_VMFUNC		( 2*32+ 13) /* Enable VM-Functions (leaf dependent) */
+#define VMX_FEATURE_SHADOW_VMCS		( 2*32+ 14) /* "shadow_vmcs" VMREAD/VMWRITE in guest can access shadow VMCS */
+#define VMX_FEATURE_ENCLS_EXITING	( 2*32+ 15) /* VM-Exit on ENCLS (leaf dependent) */
+#define VMX_FEATURE_RDSEED_EXITING	( 2*32+ 16) /* VM-Exit on RDSEED */
 #define VMX_FEATURE_PAGE_MOD_LOGGING	( 2*32+ 17) /* "pml" Log dirty pages into buffer */
-#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* "" Conditionally reflect EPT violations as #VE exceptions */
-#define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* "" Suppress VMX indicators in Processor Trace */
-#define VMX_FEATURE_XSAVES		( 2*32+ 20) /* "" Enable XSAVES and XRSTORS in guest */
+#define VMX_FEATURE_EPT_VIOLATION_VE	( 2*32+ 18) /* Conditionally reflect EPT violations as #VE exceptions */
+#define VMX_FEATURE_PT_CONCEAL_VMX	( 2*32+ 19) /* Suppress VMX indicators in Processor Trace */
+#define VMX_FEATURE_XSAVES		( 2*32+ 20) /* Enable XSAVES and XRSTORS in guest */
 #define VMX_FEATURE_MODE_BASED_EPT_EXEC	( 2*32+ 22) /* "ept_mode_based_exec" Enable separate EPT EXEC bits for supervisor vs. user */
-#define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* "" Processor Trace logs GPAs */
-#define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* Scale hardware TSC when read in guest */
-#define VMX_FEATURE_USR_WAIT_PAUSE	( 2*32+ 26) /* Enable TPAUSE, UMONITOR, UMWAIT in guest */
-#define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* "" VM-Exit on ENCLV (leaf dependent) */
-#define VMX_FEATURE_BUS_LOCK_DETECTION	( 2*32+ 30) /* "" VM-Exit when bus lock caused */
-#define VMX_FEATURE_NOTIFY_VM_EXITING	( 2*32+ 31) /* VM-Exit when no event windows after notify window */
+#define VMX_FEATURE_PT_USE_GPA		( 2*32+ 24) /* Processor Trace logs GPAs */
+#define VMX_FEATURE_TSC_SCALING		( 2*32+ 25) /* "tsc_scaling" Scale hardware TSC when read in guest */
+#define VMX_FEATURE_USR_WAIT_PAUSE	( 2*32+ 26) /* "usr_wait_pause" Enable TPAUSE, UMONITOR, UMWAIT in guest */
+#define VMX_FEATURE_ENCLV_EXITING	( 2*32+ 28) /* VM-Exit on ENCLV (leaf dependent) */
+#define VMX_FEATURE_BUS_LOCK_DETECTION	( 2*32+ 30) /* VM-Exit when bus lock caused */
+#define VMX_FEATURE_NOTIFY_VM_EXITING	( 2*32+ 31) /* "notify_vm_exiting" VM-Exit when no event windows after notify window */
 
 /* Tertiary Processor-Based VM-Execution Controls, word 3 */
-#define VMX_FEATURE_IPI_VIRT		( 3*32+  4) /* Enable IPI virtualization */
+#define VMX_FEATURE_IPI_VIRT		( 3*32+  4) /* "ipi_virt" Enable IPI virtualization */
 #endif /* _ASM_X86_VMXFEATURES_H */
diff --git a/arch/x86/kernel/cpu/mkcapflags.sh b/arch/x86/kernel/cpu/mkcapflags.sh
index 1db560e..68f5373 100644
--- a/arch/x86/kernel/cpu/mkcapflags.sh
+++ b/arch/x86/kernel/cpu/mkcapflags.sh
@@ -30,8 +30,7 @@ dump_array()
 
 		# If the /* comment */ starts with a quote string, grab that.
 		VALUE="$(echo "$i" | sed -n 's@.*/\* *\("[^"]*"\).*\*/@\1@p')"
-		[ -z "$VALUE" ] && VALUE="\"$NAME\""
-		[ "$VALUE" = '""' ] && continue
+		[ ! "$VALUE" ] && continue
 
 		# Name is uppercase, VALUE is all lowercase
 		VALUE="$(echo "$VALUE" | tr A-Z a-z)"

