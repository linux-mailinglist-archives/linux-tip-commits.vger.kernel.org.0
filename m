Return-Path: <linux-tip-commits+bounces-1328-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D7498D7EC7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 11:34:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 250B628690E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Jun 2024 09:34:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8451886658;
	Mon,  3 Jun 2024 09:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6oKI/oD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+EmMLdLj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566985C7F;
	Mon,  3 Jun 2024 09:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717407015; cv=none; b=HsZJAEmfGc5sGCm2liC3BzhRiZRB1FEqLSuDxxBz33UM4k9+UnqKvU9e7tK56SicnkEZknSqwQkw2XzhPfDrJKkbkSyBOHueTsMfb5UHbHn/Bbv/tbT6xe4CRU++/kWaMEEz2hHb2PPSs9wjSU+qIshnPWu+ouVQS7FdbqSQk68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717407015; c=relaxed/simple;
	bh=yZGpd5u3l3lMVQG8iE8/TbABQQuAlad31356bld+Y9I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZFwNAe1sgJJ/RYKEyuJoacamhez8TzO3dWcwk4tuP63+JCclang+0+yR/3fCzcGkYmm0Yn/AIEqgd4EaZy4HFZfYp5ALzwQnJMk0kUN3ztFUTfbtV/yxihIKxXO2kRpNSHk9WGDg6tWwck0RKYIBpxF7Yt2oo8QTO0zXSB8poak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6oKI/oD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+EmMLdLj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Jun 2024 09:30:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHytbiUN8X8CpFsms4hh7FIVTLToKkddHrZ8kB4ikHE=;
	b=N6oKI/oDda3MqDw/uzEm9ult8/umtaH+xbXxUvJJhfVtM6z8RttpY8Zb85Ve24OpULKueh
	VX5RPJTBFxwmNqgKuJ3SnlX2OLnXAhYR2KWMOcKOlfZlS15y8HxVMZ14kRddyBMmXkEs5c
	gmYcN+9LposZ0SvrvMWsZZxtqTex3+SWwlGpSeB70rh2obj9cfcTTptvENyoEzgFXQK3rU
	A+xo4jrYQURW+p1I4z6mfL333ECiV14TvCnn9WzQ1lhOFS7lymPgWiKrUYdGHHH9Ob+90A
	7cQjUuDz08UCGKhSfFytQg86u48HCLku5QkID3puVPBeZuiX+n15NcF4V0fMpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1717407009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iHytbiUN8X8CpFsms4hh7FIVTLToKkddHrZ8kB4ikHE=;
	b=+EmMLdLjBNLenLHfpbuMBtz+z0k1kFN/x/WppT21j8loBPC+esfFl29NkBcmo/YASWFski
	NajB5NVXsZZ8MDCA==
From: "tip-bot2 for Lakshmi Sowjanya D" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/core] x86/tsc: Provide ART base clock information for TSC
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Christopher S. Hall" <christopher.s.hall@intel.com>,
 Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240513103813.5666-3-lakshmi.sowjanya.d@intel.com>
References: <20240513103813.5666-3-lakshmi.sowjanya.d@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171740700928.10875.14755603550947818962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3a52886c8f972c3a5b70bfec330c71817cd7fc63
Gitweb:        https://git.kernel.org/tip/3a52886c8f972c3a5b70bfec330c71817cd7fc63
Author:        Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
AuthorDate:    Mon, 13 May 2024 16:08:03 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Jun 2024 11:18:50 +02:00

x86/tsc: Provide ART base clock information for TSC

The core code provides a new mechanism to allow conversion between ART and
TSC. This allows to replace the x86 specific ART/TSC conversion functions.

Prepare for removal by filling in the base clock conversion information for
ART and associating the base clock to the TSC clocksource.

The existing conversion functions will be removed once the usage sites are
converted over to the new model.

[ tglx: Massaged change log ]

Co-developed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Co-developed-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Christopher S. Hall <christopher.s.hall@intel.com>
Signed-off-by: Lakshmi Sowjanya D <lakshmi.sowjanya.d@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240513103813.5666-3-lakshmi.sowjanya.d@intel.com

---
 arch/x86/kernel/tsc.c           | 42 ++++++++++++++++++--------------
 include/linux/clocksource_ids.h |  1 +-
 2 files changed, 25 insertions(+), 18 deletions(-)

diff --git a/arch/x86/kernel/tsc.c b/arch/x86/kernel/tsc.c
index 06b1707..d1888db 100644
--- a/arch/x86/kernel/tsc.c
+++ b/arch/x86/kernel/tsc.c
@@ -50,9 +50,9 @@ int tsc_clocksource_reliable;
 
 static int __read_mostly tsc_force_recalibrate;
 
-static u32 art_to_tsc_numerator;
-static u32 art_to_tsc_denominator;
-static u64 art_to_tsc_offset;
+static struct clocksource_base art_base_clk = {
+	.id    = CSID_X86_ART,
+};
 static bool have_art;
 
 struct cyc2ns {
@@ -1074,7 +1074,7 @@ core_initcall(cpufreq_register_tsc_scaling);
  */
 static void __init detect_art(void)
 {
-	unsigned int unused[2];
+	unsigned int unused;
 
 	if (boot_cpu_data.cpuid_level < ART_CPUID_LEAF)
 		return;
@@ -1089,13 +1089,14 @@ static void __init detect_art(void)
 	    tsc_async_resets)
 		return;
 
-	cpuid(ART_CPUID_LEAF, &art_to_tsc_denominator,
-	      &art_to_tsc_numerator, unused, unused+1);
+	cpuid(ART_CPUID_LEAF, &art_base_clk.denominator,
+	      &art_base_clk.numerator, &art_base_clk.freq_khz, &unused);
 
-	if (art_to_tsc_denominator < ART_MIN_DENOMINATOR)
+	art_base_clk.freq_khz /= KHZ;
+	if (art_base_clk.denominator < ART_MIN_DENOMINATOR)
 		return;
 
-	rdmsrl(MSR_IA32_TSC_ADJUST, art_to_tsc_offset);
+	rdmsrl(MSR_IA32_TSC_ADJUST, art_base_clk.offset);
 
 	/* Make this sticky over multiple CPU init calls */
 	setup_force_cpu_cap(X86_FEATURE_ART);
@@ -1303,13 +1304,13 @@ struct system_counterval_t convert_art_to_tsc(u64 art)
 {
 	u64 tmp, res, rem;
 
-	rem = do_div(art, art_to_tsc_denominator);
+	rem = do_div(art, art_base_clk.denominator);
 
-	res = art * art_to_tsc_numerator;
-	tmp = rem * art_to_tsc_numerator;
+	res = art * art_base_clk.numerator;
+	tmp = rem * art_base_clk.numerator;
 
-	do_div(tmp, art_to_tsc_denominator);
-	res += tmp + art_to_tsc_offset;
+	do_div(tmp, art_base_clk.denominator);
+	res += tmp + art_base_clk.offset;
 
 	return (struct system_counterval_t) {
 		.cs_id	= have_art ? CSID_X86_TSC : CSID_GENERIC,
@@ -1356,7 +1357,6 @@ struct system_counterval_t convert_art_ns_to_tsc(u64 art_ns)
 }
 EXPORT_SYMBOL(convert_art_ns_to_tsc);
 
-
 static void tsc_refine_calibration_work(struct work_struct *work);
 static DECLARE_DELAYED_WORK(tsc_irqwork, tsc_refine_calibration_work);
 /**
@@ -1458,8 +1458,10 @@ out:
 	if (tsc_unstable)
 		goto unreg;
 
-	if (boot_cpu_has(X86_FEATURE_ART))
+	if (boot_cpu_has(X86_FEATURE_ART)) {
 		have_art = true;
+		clocksource_tsc.base = &art_base_clk;
+	}
 	clocksource_register_khz(&clocksource_tsc, tsc_khz);
 unreg:
 	clocksource_unregister(&clocksource_tsc_early);
@@ -1484,8 +1486,10 @@ static int __init init_tsc_clocksource(void)
 	 * the refined calibration and directly register it as a clocksource.
 	 */
 	if (boot_cpu_has(X86_FEATURE_TSC_KNOWN_FREQ)) {
-		if (boot_cpu_has(X86_FEATURE_ART))
+		if (boot_cpu_has(X86_FEATURE_ART)) {
 			have_art = true;
+			clocksource_tsc.base = &art_base_clk;
+		}
 		clocksource_register_khz(&clocksource_tsc, tsc_khz);
 		clocksource_unregister(&clocksource_tsc_early);
 
@@ -1509,10 +1513,12 @@ static bool __init determine_cpu_tsc_frequencies(bool early)
 
 	if (early) {
 		cpu_khz = x86_platform.calibrate_cpu();
-		if (tsc_early_khz)
+		if (tsc_early_khz) {
 			tsc_khz = tsc_early_khz;
-		else
+		} else {
 			tsc_khz = x86_platform.calibrate_tsc();
+			clocksource_tsc.freq_khz = tsc_khz;
+		}
 	} else {
 		/* We should not be here with non-native cpu calibration */
 		WARN_ON(x86_platform.calibrate_cpu != native_calibrate_cpu);
diff --git a/include/linux/clocksource_ids.h b/include/linux/clocksource_ids.h
index a4fa343..2bb4d8c 100644
--- a/include/linux/clocksource_ids.h
+++ b/include/linux/clocksource_ids.h
@@ -9,6 +9,7 @@ enum clocksource_ids {
 	CSID_X86_TSC_EARLY,
 	CSID_X86_TSC,
 	CSID_X86_KVM_CLK,
+	CSID_X86_ART,
 	CSID_MAX,
 };
 

