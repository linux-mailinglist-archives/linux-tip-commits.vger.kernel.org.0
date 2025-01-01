Return-Path: <linux-tip-commits+bounces-3158-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A22C29FF3DF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 12:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4636B161BAB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jan 2025 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E06951E231C;
	Wed,  1 Jan 2025 11:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YYqAPKo4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fiJgO8eA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D449513DDAE;
	Wed,  1 Jan 2025 11:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735731858; cv=none; b=FsSwZ8ndnEXVrNftMqgNGe/HNKWk3xNAXmVA/eOfGJxstzEZ9AQsC9kKZQ1Hvrq6vhjVVIKTIXTaZJ/4/sC/FTMamXh7lob6DL2t/c46ohKYEmueps/5Iy5DeFP0i2x5p4Usc2sqb+4CLr5hRqau5gdZzd17N1LmySS214ibegY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735731858; c=relaxed/simple;
	bh=FAS/5rFz5H8CSMBHXGdahOTZcaHB69YoaRitrJeTsUs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hyT0RTumBLYgI0YkCjXVmm8Jqo+APodc3EJBsx7t1NcUHHdVf0OwghefIrDsRBziRBi5+I0Xhdo8PKWSrDRlmMAk9mIgdheSlTb2DGJ7/dugA5GO5iOfmWhySf34OvWpFSt47DPEoepH2GNaLCUkF/GDstShsMBS3HYAb1N4iPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YYqAPKo4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fiJgO8eA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 01 Jan 2025 11:44:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1735731848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSKbfoItrQwZVqgPxCvHbYd7VYzsvxUnXJZ5bqmDctw=;
	b=YYqAPKo45VKP00n7r/41j7Eq6PvNsTC+kMyqB/NnZ8IN1AAt3mKxSuN9T48hxQsle9m3lZ
	hqEMMe/F+YOz3SNc08HcYkst3c/xl6b9/wBGLDptWgXCQ4OxBi4KDfxj4YNKwC5Y14987q
	HGgeNqQs6HhSuMWk/QyeAem5WgTkYnBIo1WJ7XHKbG3JmXeoZdFq586wHCLerCjgYW1MVU
	KeOji/PbuGma+nuyRaQ9+uqhAMCdhTzaNP/1X3hAQdCYmqdAmx6KUj3NydgFfhKR0es7dH
	kdAvMkPxWCbspL5PFJtiyDaY+mZCfDDUEK7ZwJYbixmKdwda7CZMPMTCne3ylw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1735731848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WSKbfoItrQwZVqgPxCvHbYd7VYzsvxUnXJZ5bqmDctw=;
	b=fiJgO8eAlQj9sbbNjUue0AECcu2R2ff4JFFng4m6O2iT61PCqQ7z8Et/A0vXl3qwUEYYWo
	hQ/+gaV+hnLq3MBA==
From: "tip-bot2 for Tony Luck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Break up __mcheck_cpu_apply_quirks()
Cc: Tony Luck <tony.luck@intel.com>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Sohil Mehta <sohil.mehta@intel.com>,
 Yazen Ghannam <yazen.ghannam@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241212140103.66964-5-qiuxu.zhuo@intel.com>
References: <20241212140103.66964-5-qiuxu.zhuo@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173573184840.399.13908195784016885328.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     51a12c28bb9a043e9444db5bd214b00ec161a639
Gitweb:        https://git.kernel.org/tip/51a12c28bb9a043e9444db5bd214b00ec161a639
Author:        Tony Luck <tony.luck@intel.com>
AuthorDate:    Thu, 12 Dec 2024 22:01:00 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 31 Dec 2024 11:07:05 +01:00

x86/mce: Break up __mcheck_cpu_apply_quirks()

Split each vendor specific part into its own helper function.

Signed-off-by: Tony Luck <tony.luck@intel.com>
Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Reviewed-by: Yazen Ghannam <yazen.ghannam@amd.com>
Tested-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Link: https://lore.kernel.org/r/20241212140103.66964-5-qiuxu.zhuo@intel.com
---
 arch/x86/kernel/cpu/mce/core.c | 168 +++++++++++++++++---------------
 1 file changed, 92 insertions(+), 76 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index ce6fe5e..3855ec2 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1910,101 +1910,117 @@ static void __mcheck_cpu_check_banks(void)
 	}
 }
 
-/* Add per CPU specific workarounds here */
-static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+static void apply_quirks_amd(struct cpuinfo_x86 *c)
 {
 	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
-	struct mca_config *cfg = &mca_cfg;
-
-	if (c->x86_vendor == X86_VENDOR_UNKNOWN) {
-		pr_info("unknown CPU type - not enabling MCE support\n");
-		return false;
-	}
 
 	/* This should be disabled by the BIOS, but isn't always */
-	if (c->x86_vendor == X86_VENDOR_AMD) {
-		if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
-			/*
-			 * disable GART TBL walk error reporting, which
-			 * trips off incorrectly with the IOMMU & 3ware
-			 * & Cerberus:
-			 */
-			clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
-		}
-		if (c->x86 < 0x11 && cfg->bootlog < 0) {
-			/*
-			 * Lots of broken BIOS around that don't clear them
-			 * by default and leave crap in there. Don't log:
-			 */
-			cfg->bootlog = 0;
-		}
+	if (c->x86 == 15 && this_cpu_read(mce_num_banks) > 4) {
 		/*
-		 * Various K7s with broken bank 0 around. Always disable
-		 * by default.
+		 * disable GART TBL walk error reporting, which
+		 * trips off incorrectly with the IOMMU & 3ware
+		 * & Cerberus:
 		 */
-		if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].ctl = 0;
+		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
+	}
 
+	if (c->x86 < 0x11 && mca_cfg.bootlog < 0) {
 		/*
-		 * overflow_recov is supported for F15h Models 00h-0fh
-		 * even though we don't have a CPUID bit for it.
+		 * Lots of broken BIOS around that don't clear them
+		 * by default and leave crap in there. Don't log:
 		 */
-		if (c->x86 == 0x15 && c->x86_model <= 0xf)
-			mce_flags.overflow_recov = 1;
+		mca_cfg.bootlog = 0;
+	}
 
-		if (c->x86 >= 0x17 && c->x86 <= 0x1A)
-			mce_flags.zen_ifu_quirk = 1;
+	/*
+	 * Various K7s with broken bank 0 around. Always disable
+	 * by default.
+	 */
+	if (c->x86 == 6 && this_cpu_read(mce_num_banks) > 0)
+		mce_banks[0].ctl = 0;
 
-	}
+	/*
+	 * overflow_recov is supported for F15h Models 00h-0fh
+	 * even though we don't have a CPUID bit for it.
+	 */
+	if (c->x86 == 0x15 && c->x86_model <= 0xf)
+		mce_flags.overflow_recov = 1;
 
-	if (c->x86_vendor == X86_VENDOR_INTEL) {
-		/*
-		 * SDM documents that on family 6 bank 0 should not be written
-		 * because it aliases to another special BIOS controlled
-		 * register.
-		 * But it's not aliased anymore on model 0x1a+
-		 * Don't ignore bank 0 completely because there could be a
-		 * valid event later, merely don't write CTL0.
-		 */
+	if (c->x86 >= 0x17 && c->x86 <= 0x1A)
+		mce_flags.zen_ifu_quirk = 1;
+}
 
-		if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].init = false;
+static void apply_quirks_intel(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks = this_cpu_ptr(mce_banks_array);
 
-		/*
-		 * All newer Intel systems support MCE broadcasting. Enable
-		 * synchronization with a one second timeout.
-		 */
-		if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
-			cfg->monarch_timeout < 0)
-			cfg->monarch_timeout = USEC_PER_SEC;
+	/*
+	 * SDM documents that on family 6 bank 0 should not be written
+	 * because it aliases to another special BIOS controlled
+	 * register.
+	 * But it's not aliased anymore on model 0x1a+
+	 * Don't ignore bank 0 completely because there could be a
+	 * valid event later, merely don't write CTL0.
+	 */
+	if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
+		mce_banks[0].init = false;
 
-		/*
-		 * There are also broken BIOSes on some Pentium M and
-		 * earlier systems:
-		 */
-		if (c->x86 == 6 && c->x86_model <= 13 && cfg->bootlog < 0)
-			cfg->bootlog = 0;
+	/*
+	 * All newer Intel systems support MCE broadcasting. Enable
+	 * synchronization with a one second timeout.
+	 */
+	if ((c->x86 > 6 || (c->x86 == 6 && c->x86_model >= 0xe)) &&
+	    mca_cfg.monarch_timeout < 0)
+		mca_cfg.monarch_timeout = USEC_PER_SEC;
+
+	/*
+	 * There are also broken BIOSes on some Pentium M and
+	 * earlier systems:
+	 */
+	if (c->x86 == 6 && c->x86_model <= 13 && mca_cfg.bootlog < 0)
+		mca_cfg.bootlog = 0;
 
-		if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
-			mce_flags.snb_ifu_quirk = 1;
+	if (c->x86_vfm == INTEL_SANDYBRIDGE_X)
+		mce_flags.snb_ifu_quirk = 1;
 
-		/*
-		 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
-		 * rep movs.
-		 */
-		if (c->x86_vfm == INTEL_SKYLAKE_X)
-			mce_flags.skx_repmov_quirk = 1;
+	/*
+	 * Skylake, Cascacde Lake and Cooper Lake require a quirk on
+	 * rep movs.
+	 */
+	if (c->x86_vfm == INTEL_SKYLAKE_X)
+		mce_flags.skx_repmov_quirk = 1;
+}
+
+static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
+{
+	/*
+	 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
+	 * synchronization with a one second timeout.
+	 */
+	if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
+		if (mca_cfg.monarch_timeout < 0)
+			mca_cfg.monarch_timeout = USEC_PER_SEC;
 	}
+}
 
-	if (c->x86_vendor == X86_VENDOR_ZHAOXIN) {
-		/*
-		 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
-		 * synchronization with a one second timeout.
-		 */
-		if (c->x86 > 6 || (c->x86_model == 0x19 || c->x86_model == 0x1f)) {
-			if (cfg->monarch_timeout < 0)
-				cfg->monarch_timeout = USEC_PER_SEC;
-		}
+/* Add per CPU specific workarounds here */
+static bool __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
+{
+	struct mca_config *cfg = &mca_cfg;
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_UNKNOWN:
+		pr_info("unknown CPU type - not enabling MCE support\n");
+		return false;
+	case X86_VENDOR_AMD:
+		apply_quirks_amd(c);
+		break;
+	case X86_VENDOR_INTEL:
+		apply_quirks_intel(c);
+		break;
+	case X86_VENDOR_ZHAOXIN:
+		apply_quirks_zhaoxin(c);
+		break;
 	}
 
 	if (cfg->monarch_timeout < 0)

