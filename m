Return-Path: <linux-tip-commits+bounces-4979-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D3D12A88704
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 17:25:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D11A31674A2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Apr 2025 15:25:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973FB42A92;
	Mon, 14 Apr 2025 15:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WppRh4Bd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LFX7jvGf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACEAF1FDD;
	Mon, 14 Apr 2025 15:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744644336; cv=none; b=jA0i2nAjsh0KNysu1ugiznqxSIwOAX2Gq1je6MrSeneOl83I3O1IgSc8YVed2M6iBA19/CLC+R/eO5Rkz9OTuS3m/Yruzwr6OpcOaQ9PLOZmXGJoennnACq3cd0wZs+d5b/xtdTEyc/aXN7vAB2vZaJmEnuk8UZNwTXesJmHFsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744644336; c=relaxed/simple;
	bh=y6yz8eG3xQ0fyYP9YIopaUmz0nDdVPc/Jh3OkNzxgjk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UEWwZzQyR1tFE+xylTBL1ghu+JZjz+ex2nszbXBej9SRonhsW+xXiEMiR1tS7CZs8IBj1TThomGSDUkJfFsw2FwQ3rkarLtTDvocsKhhZS7M+OVEA8R73X+1hOV3rAWjlP13808kvz5798LGhBXoGcwtDSvv3zXMovmHMr+PhjY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WppRh4Bd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LFX7jvGf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Apr 2025 15:25:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744644326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qJxCJxTPme5lnrRdpPFvQmpJRRGWDgVC5HggM5lAIE=;
	b=WppRh4Bdcs2YKhzvuWoHWv1Bq+DEFjc392xHciOstQHmnZ44+swFS93hrdYG4k4/Z/qRd1
	0zfDbrmq2vWuDVWD9dD95Ov+lLTCmY5ptFxznJyCntBfHDTi0R02u9umUZO2pASk3VLigK
	sF9ZLuJryidUut5YDBbcALq3PnaW2uII6fHZv/VjGrficuEr0HS4Ebq2n6E4w63zELZGi/
	37cANqgmdf/1UXv9jgwH22Auua50x/qf23+sT5D3EGTC9r/FkL65fhsJkMHFcArYzUPTTM
	5K0CEJVhKZEKH9zOb8Yea+JslpjQLwOjlo9YVKRFbiZAqDxyheI8cpBRI9pTmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744644326;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3qJxCJxTPme5lnrRdpPFvQmpJRRGWDgVC5HggM5lAIE=;
	b=LFX7jvGf+DmdoHdPHCQSgdHct1yrwcil80yr/K3JMjqdvQalNpBviaNdHin4cEabEuof0H
	N0wRcAYk6yhguxAg==
From: "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/bugs: Remove X86_BUG_MMIO_UNKNOWN
Cc: "Borislav Petkov (AMD)" <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>,
 Andrew Cooper <andrew.cooper3@citrix.com>,
 David Kaplan <david.kaplan@amd.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Josh Poimboeuf <jpoimboe@redhat.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250414150951.5345-1-bp@kernel.org>
References: <20250414150951.5345-1-bp@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174464432010.31282.9076437983406164205.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     dd86a1d013e0c94fedd060514b9e7be2988ef320
Gitweb:        https://git.kernel.org/tip/dd86a1d013e0c94fedd060514b9e7be2988ef320
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Mon, 14 Apr 2025 17:09:51 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 14 Apr 2025 17:15:27 +02:00

x86/bugs: Remove X86_BUG_MMIO_UNKNOWN

Whack this thing because:

- the "unknown" handling is done only for this vuln and not for the
  others

- it doesn't do anything besides reporting things differently. It
  doesn't apply any mitigations - it is simply causing unnecessary
  complications to the code which don't bring anything besides
  maintenance overhead to what is already a very nasty spaghetti pile

- all the currently unaffected CPUs can also be in "unknown" status so
  there's no need for special handling here

so get rid of it.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andrew Cooper <andrew.cooper3@citrix.com>
Cc: David Kaplan <david.kaplan@amd.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Link: https://lore.kernel.org/r/20250414150951.5345-1-bp@kernel.org
---
 arch/x86/include/asm/cpufeatures.h       |  2 +-
 arch/x86/kernel/cpu/bugs.c               | 12 +-----------
 arch/x86/kernel/cpu/common.c             |  5 -----
 tools/arch/x86/include/asm/cpufeatures.h |  2 +-
 4 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm/cpufeatures.h
index 6c2c152..e8f8d43 100644
--- a/arch/x86/include/asm/cpufeatures.h
+++ b/arch/x86/include/asm/cpufeatures.h
@@ -519,7 +519,7 @@
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* "itlb_multihit" CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* "srbds" CPU may leak RNG bits if not mitigated */
 #define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* "mmio_stale_data" CPU is affected by Processor MMIO Stale Data vulnerabilities */
-#define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
+/* unused, was #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* "retbleed" CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* "eibrs_pbrsb" EIBRS is vulnerable to Post Barrier RSB Predictions */
 #define X86_BUG_SMT_RSB			X86_BUG(29) /* "smt_rsb" CPU is vulnerable to Cross-Thread Return Address Predictions */
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 4386aa6..a91a1ca 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -428,7 +428,6 @@ static const char * const mmio_strings[] = {
 static void __init mmio_select_mitigation(void)
 {
 	if (!boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA) ||
-	     boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN) ||
 	     cpu_mitigations_off()) {
 		mmio_mitigation = MMIO_MITIGATION_OFF;
 		return;
@@ -591,8 +590,6 @@ out:
 		pr_info("TAA: %s\n", taa_strings[taa_mitigation]);
 	if (boot_cpu_has_bug(X86_BUG_MMIO_STALE_DATA))
 		pr_info("MMIO Stale Data: %s\n", mmio_strings[mmio_mitigation]);
-	else if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		pr_info("MMIO Stale Data: Unknown: No mitigations\n");
 	if (boot_cpu_has_bug(X86_BUG_RFDS))
 		pr_info("Register File Data Sampling: %s\n", rfds_strings[rfds_mitigation]);
 }
@@ -2819,9 +2816,6 @@ static ssize_t tsx_async_abort_show_state(char *buf)
 
 static ssize_t mmio_stale_data_show_state(char *buf)
 {
-	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		return sysfs_emit(buf, "Unknown: No mitigations\n");
-
 	if (mmio_mitigation == MMIO_MITIGATION_OFF)
 		return sysfs_emit(buf, "%s\n", mmio_strings[mmio_mitigation]);
 
@@ -3006,7 +3000,6 @@ static ssize_t cpu_show_common(struct device *dev, struct device_attribute *attr
 		return srbds_show_state(buf);
 
 	case X86_BUG_MMIO_STALE_DATA:
-	case X86_BUG_MMIO_UNKNOWN:
 		return mmio_stale_data_show_state(buf);
 
 	case X86_BUG_RETBLEED:
@@ -3075,10 +3068,7 @@ ssize_t cpu_show_srbds(struct device *dev, struct device_attribute *attr, char *
 
 ssize_t cpu_show_mmio_stale_data(struct device *dev, struct device_attribute *attr, char *buf)
 {
-	if (boot_cpu_has_bug(X86_BUG_MMIO_UNKNOWN))
-		return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_UNKNOWN);
-	else
-		return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_STALE_DATA);
+	return cpu_show_common(dev, attr, buf, X86_BUG_MMIO_STALE_DATA);
 }
 
 ssize_t cpu_show_retbleed(struct device *dev, struct device_attribute *attr, char *buf)
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 12126ad..4ada55f 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1402,15 +1402,10 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	 * Affected CPU list is generally enough to enumerate the vulnerability,
 	 * but for virtualization case check for ARCH_CAP MSR bits also, VMM may
 	 * not want the guest to enumerate the bug.
-	 *
-	 * Set X86_BUG_MMIO_UNKNOWN for CPUs that are neither in the blacklist,
-	 * nor in the whitelist and also don't enumerate MSR ARCH_CAP MMIO bits.
 	 */
 	if (!arch_cap_mmio_immune(x86_arch_cap_msr)) {
 		if (cpu_matches(cpu_vuln_blacklist, MMIO))
 			setup_force_cpu_bug(X86_BUG_MMIO_STALE_DATA);
-		else if (!cpu_matches(cpu_vuln_whitelist, NO_MMIO))
-			setup_force_cpu_bug(X86_BUG_MMIO_UNKNOWN);
 	}
 
 	if (!cpu_has(c, X86_FEATURE_BTC_NO)) {
diff --git a/tools/arch/x86/include/asm/cpufeatures.h b/tools/arch/x86/include/asm/cpufeatures.h
index 9e3fa79..e88500d 100644
--- a/tools/arch/x86/include/asm/cpufeatures.h
+++ b/tools/arch/x86/include/asm/cpufeatures.h
@@ -508,7 +508,7 @@
 #define X86_BUG_ITLB_MULTIHIT		X86_BUG(23) /* "itlb_multihit" CPU may incur MCE during certain page attribute changes */
 #define X86_BUG_SRBDS			X86_BUG(24) /* "srbds" CPU may leak RNG bits if not mitigated */
 #define X86_BUG_MMIO_STALE_DATA		X86_BUG(25) /* "mmio_stale_data" CPU is affected by Processor MMIO Stale Data vulnerabilities */
-#define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) /* "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
+/* unused, was #define X86_BUG_MMIO_UNKNOWN		X86_BUG(26) * "mmio_unknown" CPU is too old and its MMIO Stale Data status is unknown */
 #define X86_BUG_RETBLEED		X86_BUG(27) /* "retbleed" CPU is affected by RETBleed */
 #define X86_BUG_EIBRS_PBRSB		X86_BUG(28) /* "eibrs_pbrsb" EIBRS is vulnerable to Post Barrier RSB Predictions */
 #define X86_BUG_SMT_RSB			X86_BUG(29) /* "smt_rsb" CPU is vulnerable to Cross-Thread Return Address Predictions */

