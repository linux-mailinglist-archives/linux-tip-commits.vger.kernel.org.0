Return-Path: <linux-tip-commits+bounces-3340-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A39C7A299BA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 20:07:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A6CA716A008
	for <lists+linux-tip-commits@lfdr.de>; Wed,  5 Feb 2025 19:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71931FFC48;
	Wed,  5 Feb 2025 19:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JlhCmcxJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a21+q+A4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8991FECD5;
	Wed,  5 Feb 2025 19:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738782456; cv=none; b=LH56/gmbW9JNGrD42xFkCw4nRK756liPrR7142NfMc3c7HDytRI6i4IrKpSpA4Ozc2i24bieMhcnG6Lv9niZGpUGROnlbweKh8NCo78RpMF1cKuqbPYvNQfNDIEtHbWbgNg9X/xlBcwQBXdbOPTvI2vSYFEM064K2zr89LdEG7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738782456; c=relaxed/simple;
	bh=sxjJdU9NfhDAUVr0dSengVAlyIrIevB3Q8AEGvDuocc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=u0GS159GhtNdruk1krNySBr8899zx2Y2eTiOH3j4S6f2iK5tQT7l/emGmLwg1HEcvnUw+Z+W1TVR1+owDse5KwjDSniVMUPROtzA2J34mSqExOH0++D6rCPVmRircACHcuRQuqW+ImBfaq/YMB7Te1DxyhoFsrmCKX6qO2uvQzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JlhCmcxJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a21+q+A4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 05 Feb 2025 19:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1738782453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7TZ3w7mk1NOH04vQkmb1QDXY8tkMR/qOVaf9+HX6xPo=;
	b=JlhCmcxJKOgiefm1ebEIdqQbDGmjgu77QY8x8y2iONlJnj2b5+KRO/jNo87Bq10CyKld8T
	PH+rQl7EkhhNljRBzBsdToU4BrlUQkfV4ZFVp6alY0KPDs69gYxkS8ByEF0FCF+rXOx0t5
	sswdSaXdU9pXa5cjQHYhcVm0+Gl4DtT9ZwXVeVadBIWt6FBGgeY8HtTZGr3AGC8WVvRnh/
	8gzqZDsHiQK+9pyM72xf/d2pkN7446tg5OhC8L2t6vklRhNu9j0bDrEvYQL8YDDNPWlTET
	jPq4gLTFkuVXCgnBpNAJk97Bbj4VW3PiLB5l69tIrvq0LgEcgXikj19qW/ms1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1738782453;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=7TZ3w7mk1NOH04vQkmb1QDXY8tkMR/qOVaf9+HX6xPo=;
	b=a21+q+A4aOS8ixNYZHDlHhtxRVsR5DngEAtRpJ5tXf38c488CUmoRfFgDQawSd+KcPIlnD
	z5e2E5yu/TMGmpCw==
From: "tip-bot2 for Patryk Wlazlyn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/smp: Allow calling mwait_play_dead with an arbitrary hint
Cc: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>,
 Artem Bityutskiy <artem.bityutskiy@linux.intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173878245281.10177.5554029700851820138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     a7dd183f0b3848c056bbeed78ef5d5c52fe94d83
Gitweb:        https://git.kernel.org/tip/a7dd183f0b3848c056bbeed78ef5d5c52fe94d83
Author:        Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
AuthorDate:    Wed, 05 Feb 2025 17:52:08 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Wed, 05 Feb 2025 10:44:52 -08:00

x86/smp: Allow calling mwait_play_dead with an arbitrary hint

Introduce a helper function to allow offlined CPUs to enter idle states
with a specific MWAIT hint. The new helper will be used in subsequent
patches by the acpi_idle and intel_idle drivers.

No functional change intended.

Signed-off-by: Patryk Wlazlyn <patryk.wlazlyn@linux.intel.com>
Signed-off-by: Artem Bityutskiy <artem.bityutskiy@linux.intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Gautham R. Shenoy <gautham.shenoy@amd.com>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/all/20250205155211.329780-2-artem.bityutskiy%40linux.intel.com
---
 arch/x86/include/asm/smp.h |  3 +-
 arch/x86/kernel/smpboot.c  | 88 +++++++++++++++++++------------------
 2 files changed, 50 insertions(+), 41 deletions(-)

diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index ca073f4..80f8bfd 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -114,6 +114,7 @@ void wbinvd_on_cpu(int cpu);
 int wbinvd_on_all_cpus(void);
 
 void smp_kick_mwait_play_dead(void);
+void mwait_play_dead(unsigned int eax_hint);
 
 void native_smp_send_reschedule(int cpu);
 void native_send_call_func_ipi(const struct cpumask *mask);
@@ -164,6 +165,8 @@ static inline struct cpumask *cpu_llc_shared_mask(int cpu)
 {
 	return (struct cpumask *)cpumask_of(0);
 }
+
+static inline void mwait_play_dead(unsigned int eax_hint) { }
 #endif /* CONFIG_SMP */
 
 #ifdef CONFIG_DEBUG_NMI_SELFTEST
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index c10850a..8aad14e 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -1258,47 +1258,9 @@ void play_dead_common(void)
 	local_irq_disable();
 }
 
-/*
- * We need to flush the caches before going to sleep, lest we have
- * dirty data in our caches when we come back up.
- */
-static inline void mwait_play_dead(void)
+void __noreturn mwait_play_dead(unsigned int eax_hint)
 {
 	struct mwait_cpu_dead *md = this_cpu_ptr(&mwait_cpu_dead);
-	unsigned int eax, ebx, ecx, edx;
-	unsigned int highest_cstate = 0;
-	unsigned int highest_subcstate = 0;
-	int i;
-
-	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
-	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
-		return;
-	if (!this_cpu_has(X86_FEATURE_MWAIT))
-		return;
-	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
-		return;
-
-	eax = CPUID_LEAF_MWAIT;
-	ecx = 0;
-	native_cpuid(&eax, &ebx, &ecx, &edx);
-
-	/*
-	 * eax will be 0 if EDX enumeration is not valid.
-	 * Initialized below to cstate, sub_cstate value when EDX is valid.
-	 */
-	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
-		eax = 0;
-	} else {
-		edx >>= MWAIT_SUBSTATE_SIZE;
-		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
-			if (edx & MWAIT_SUBSTATE_MASK) {
-				highest_cstate = i;
-				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
-			}
-		}
-		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
-			(highest_subcstate - 1);
-	}
 
 	/* Set up state for the kexec() hack below */
 	md->status = CPUDEAD_MWAIT_WAIT;
@@ -1319,7 +1281,7 @@ static inline void mwait_play_dead(void)
 		mb();
 		__monitor(md, 0, 0);
 		mb();
-		__mwait(eax, 0);
+		__mwait(eax_hint, 0);
 
 		if (READ_ONCE(md->control) == CPUDEAD_MWAIT_KEXEC_HLT) {
 			/*
@@ -1342,6 +1304,50 @@ static inline void mwait_play_dead(void)
 }
 
 /*
+ * We need to flush the caches before going to sleep, lest we have
+ * dirty data in our caches when we come back up.
+ */
+static inline void mwait_play_dead_cpuid_hint(void)
+{
+	unsigned int eax, ebx, ecx, edx;
+	unsigned int highest_cstate = 0;
+	unsigned int highest_subcstate = 0;
+	int i;
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		return;
+	if (!this_cpu_has(X86_FEATURE_MWAIT))
+		return;
+	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
+		return;
+
+	eax = CPUID_LEAF_MWAIT;
+	ecx = 0;
+	native_cpuid(&eax, &ebx, &ecx, &edx);
+
+	/*
+	 * eax will be 0 if EDX enumeration is not valid.
+	 * Initialized below to cstate, sub_cstate value when EDX is valid.
+	 */
+	if (!(ecx & CPUID5_ECX_EXTENSIONS_SUPPORTED)) {
+		eax = 0;
+	} else {
+		edx >>= MWAIT_SUBSTATE_SIZE;
+		for (i = 0; i < 7 && edx; i++, edx >>= MWAIT_SUBSTATE_SIZE) {
+			if (edx & MWAIT_SUBSTATE_MASK) {
+				highest_cstate = i;
+				highest_subcstate = edx & MWAIT_SUBSTATE_MASK;
+			}
+		}
+		eax = (highest_cstate << MWAIT_SUBSTATE_SIZE) |
+			(highest_subcstate - 1);
+	}
+
+	mwait_play_dead(eax);
+}
+
+/*
  * Kick all "offline" CPUs out of mwait on kexec(). See comment in
  * mwait_play_dead().
  */
@@ -1391,7 +1397,7 @@ void native_play_dead(void)
 	play_dead_common();
 	tboot_shutdown(TB_SHUTDOWN_WFS);
 
-	mwait_play_dead();
+	mwait_play_dead_cpuid_hint();
 	if (cpuidle_play_dead())
 		hlt_play_dead();
 }

