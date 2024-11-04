Return-Path: <linux-tip-commits+bounces-2751-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0F219BAC1B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Nov 2024 06:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D28281212
	for <lists+linux-tip-commits@lfdr.de>; Mon,  4 Nov 2024 05:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7F51885A0;
	Mon,  4 Nov 2024 05:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lZRbTCx/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A4PwGi1I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EFB1779BD;
	Mon,  4 Nov 2024 05:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730698824; cv=none; b=Kbhu1oRCE/weql+1Vs4C7YYIDcxJxdPLNX71QttGHAVjtPcdrOcwHQgLRs8xkY+vqnNbKiVNiIogEs/vGiuUcPH4+kKhV6RvGn1CwdaxWsJ1i8KVD2F+U38nI9pSaPzE0vu1RkFo4FwNrDwEzR31CDUcgALqCQHYWNbO7e+h1VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730698824; c=relaxed/simple;
	bh=KR3PQ1hYXaS7jDeoBA75bjUYrAAWwODED2bivmxQgNg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jK06Ovft5sS2/DeZR1MELeqx66+biR7MQ4SD9pGxhqtweIt3NmpEvBOCZr6ZxFiw0j8KMnjZSWjZ09vDAGhYlT3/1i4cMSCPPKdSKiPYtyYBqaCzmFbKlWkZSCpFtEJFn65X9IoA03364OYNWhUm6KzL0zF1IHggJkWjOOQFsSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lZRbTCx/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A4PwGi1I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 04 Nov 2024 05:40:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730698820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X7WElvH6uzhk8b0xGpReGyr1ofvhfFT05PZr2JJCIc=;
	b=lZRbTCx/elkhAdD0rnT1DgbawKxZdHNyHLskYlm7QnQIL+6vJvp70t0wrILPndYzTmD21V
	U/M1v23CDdIiAp1AAg02SkQBnrYCicFs56a6Ff0uV/OWqcilGVPNqbTKhba7R0Oyuks6tH
	3RP+o9uUT/9u0SKS4GFQGuzfatBsaJj/ANwy3xzVY5az0hEbnP4/IyH6aeMLUNhawXV7U1
	93pkRU8KAjfGt1jVF8FnrjNSteznZs9lp0/N7v5+RcXfUZbqnwjyUtV7VTOGDoh+D5T9sq
	+PMAz/TOzZZkBfcIK21Kt+5lqxOUs4O3AP6kkRAr86JWc3hT2FG2KWK9Z0sosg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730698820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9X7WElvH6uzhk8b0xGpReGyr1ofvhfFT05PZr2JJCIc=;
	b=A4PwGi1Iq1ZEbiWFHKvlQ1KNoTbJS6URefO4XNfqt5dDAmmdD75SUpE8cFYMlnAdg62Rm1
	YN+x/L+IqeaVh1BA==
From: "tip-bot2 for Amit Shah" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/bugs: Add support for AMD ERAPS feature
Cc: Amit Shah <amit.shah@amd.com>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241031153925.36216-2-amit@kernel.org>
References: <20241031153925.36216-2-amit@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173069881888.32228.13884134276696863606.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     b5cbd5ff79a06395a17f8f524f6f8e90dcfe42d1
Gitweb:        https://git.kernel.org/tip/b5cbd5ff79a06395a17f8f524f6f8e90dcfe42d1
Author:        Amit Shah <amit.shah@amd.com>
AuthorDate:    Thu, 31 Oct 2024 16:39:24 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 04 Nov 2024 06:20:22 +01:00

x86/bugs: Add support for AMD ERAPS feature

Remove explicit RET stuffing / filling on VMEXITs and context switches
on AMD CPUs with the ERAPS feature (Zen5).

With the Enhanced Return Address Prediction Security feature,  any
hardware TLB flush results in flushing of the RSB (aka RAP in AMD spec).
This guarantees an RSB flush across context switches.  The feature also
explicitly tags host and guest addresses - eliminating the need for
explicit flushing of the RSB on VMEXIT.

The BTC_NO feature in AMD CPUs ensures RET predictions do not speculate
from outside the RSB. Together, the BTC_NO and ERAPS features ensure no
flushing or stuffing of the RSB is necessary anymore.

Feature documented in AMD PPR 57238.

  [ bp: Massage commit message. ]

Signed-off-by: Amit Shah <amit.shah@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20241031153925.36216-2-amit@kernel.org
---
 Documentation/admin-guide/hw-vuln/spectre.rst |  5 +--
 arch/x86/include/asm/cpufeatures.h            |  1 +-
 arch/x86/include/asm/nospec-branch.h          | 11 ++++++-
 arch/x86/kernel/cpu/bugs.c                    | 36 ++++++++++++------
 4 files changed, 40 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/hw-vuln/spectre.rst b/Documentation/admin-guide/hw-vuln/spectre.rst
index 132e0bc..647c10c 100644
--- a/Documentation/admin-guide/hw-vuln/spectre.rst
+++ b/Documentation/admin-guide/hw-vuln/spectre.rst
@@ -417,9 +417,10 @@ The possible values in this file are:
 
   - Return stack buffer (RSB) protection status:
 
-  =============   ===========================================
+  =============   ========================================================
   'RSB filling'   Protection of RSB on context switch enabled
-  =============   ===========================================
+  'ERAPS'         Hardware RSB flush on context switches + guest/host tags
+  =============   ========================================================
 
   - EIBRS Post-barrier Return Stack Buffer (PBRSB) protection status:
 
diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 05e985c..7f78212 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -457,6 +457,7 @@
 #define X86_FEATURE_AUTOIBRS		(20*32+ 8) /* Automatic IBRS */
 #define X86_FEATURE_NO_SMM_CTL_MSR	(20*32+ 9) /* SMM_CTL MSR is not present */
 
+#define X86_FEATURE_ERAPS		(20*32+24) /* Enhanced RAP / RSB / RAS Security */
 #define X86_FEATURE_SBPB		(20*32+27) /* Selective Branch Prediction Barrier */
 #define X86_FEATURE_IBPB_BRTYPE		(20*32+28) /* MSR_PRED_CMD[IBPB] flushes all branch type predictions */
 #define X86_FEATURE_SRSO_NO		(20*32+29) /* CPU is not affected by SRSO */
diff --git a/arch/x86/include/asm/nospec-branch.h b/arch/x86/include/asm/nospec-branch.h
index ff5f1ec..d7587b4 100644
--- a/arch/x86/include/asm/nospec-branch.h
+++ b/arch/x86/include/asm/nospec-branch.h
@@ -117,6 +117,17 @@
  * We define a CPP macro such that it can be used from both .S files and
  * inline assembly. It's possible to do a .macro and then include that
  * from C via asm(".include <asm/nospec-branch.h>") but let's not go there.
+ *
+ * AMD CPUs with the ERAPS feature may have a larger default RSB.  These CPUs
+ * use the default number of entries on a host, and can optionally (based on
+ * hypervisor setup) use 32 (old) or the new default in a guest.  The number
+ * of default entries is reflected in CPUID 8000_0021:EBX[23:16].
+ *
+ * With the ERAPS feature, RSB filling is not necessary anymore: the RSB is
+ * auto-cleared on a TLB flush (i.e. a context switch).  Adapting the value of
+ * RSB_CLEAR_LOOPS below for ERAPS would change it to a runtime variable
+ * instead of the current compile-time constant, so leave it as-is, as this
+ * works for both older CPUs, as well as newer ones with ERAPS.
  */
 
 #define RETPOLINE_THUNK_SIZE	32
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d191542..3825779 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1811,9 +1811,6 @@ static void __init spectre_v2_select_mitigation(void)
 	 *    speculated return targets may come from the branch predictor,
 	 *    which could have a user-poisoned BTB or BHB entry.
 	 *
-	 *    AMD has it even worse: *all* returns are speculated from the BTB,
-	 *    regardless of the state of the RSB.
-	 *
 	 *    When IBRS or eIBRS is enabled, the "user -> kernel" attack
 	 *    scenario is mitigated by the IBRS branch prediction isolation
 	 *    properties, so the RSB buffer filling wouldn't be necessary to
@@ -1821,6 +1818,15 @@ static void __init spectre_v2_select_mitigation(void)
 	 *
 	 *    The "user -> user" attack scenario is mitigated by RSB filling.
 	 *
+	 *    AMD CPUs without the BTC_NO bit may speculate return targets
+	 *    from the BTB. CPUs with BTC_NO do not speculate return targets
+	 *    from the BTB, even on RSB underflow.
+	 *
+	 *    The ERAPS CPU feature (which implies the presence of BTC_NO)
+	 *    adds an RSB flush each time a TLB flush happens (i.e., on every
+	 *    context switch).  So, RSB filling is not necessary for this
+	 *    attack type with ERAPS present.
+	 *
 	 * 2) Poisoned RSB entry
 	 *
 	 *    If the 'next' in-kernel return stack is shorter than 'prev',
@@ -1831,17 +1837,24 @@ static void __init spectre_v2_select_mitigation(void)
 	 *    eIBRS.
 	 *
 	 *    The "user -> user" scenario, also known as SpectreBHB, requires
-	 *    RSB clearing.
+	 *    RSB clearing on processors without ERAPS.
 	 *
 	 * So to mitigate all cases, unconditionally fill RSB on context
-	 * switches.
-	 *
-	 * FIXME: Is this pointless for retbleed-affected AMD?
+	 * switches when ERAPS is not present.
 	 */
-	setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
-	pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
+	if (!boot_cpu_has(X86_FEATURE_ERAPS)) {
+		setup_force_cpu_cap(X86_FEATURE_RSB_CTXSW);
+		pr_info("Spectre v2 / SpectreRSB mitigation: Filling RSB on context switch\n");
 
-	spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+		/*
+		 * For guest -> host (or vice versa) RSB poisoning scenarios,
+		 * determine the mitigation mode here.  With ERAPS, RSB
+		 * entries are tagged as host or guest - ensuring that neither
+		 * the host nor the guest have to clear or fill RSB entries to
+		 * avoid poisoning, skip RSB filling at VMEXIT in that case.
+		 */
+		spectre_v2_determine_rsb_fill_type_at_vmexit(mode);
+	}
 
 	/*
 	 * Retpoline protects the kernel, but doesn't protect firmware.  IBRS
@@ -2839,7 +2852,7 @@ static ssize_t spectre_v2_show_state(char *buf)
 	    spectre_v2_enabled == SPECTRE_V2_EIBRS_LFENCE)
 		return sysfs_emit(buf, "Vulnerable: eIBRS+LFENCE with unprivileged eBPF and SMT\n");
 
-	return sysfs_emit(buf, "%s%s%s%s%s%s%s%s\n",
+	return sysfs_emit(buf, "%s%s%s%s%s%s%s%s%s\n",
 			  spectre_v2_strings[spectre_v2_enabled],
 			  ibpb_state(),
 			  boot_cpu_has(X86_FEATURE_USE_IBRS_FW) ? "; IBRS_FW" : "",
@@ -2847,6 +2860,7 @@ static ssize_t spectre_v2_show_state(char *buf)
 			  boot_cpu_has(X86_FEATURE_RSB_CTXSW) ? "; RSB filling" : "",
 			  pbrsb_eibrs_state(),
 			  spectre_bhi_state(),
+			  boot_cpu_has(X86_FEATURE_ERAPS) ? "; ERAPS hardware RSB flush" : "",
 			  /* this should always be at the end */
 			  spectre_v2_module_string());
 }

