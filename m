Return-Path: <linux-tip-commits+bounces-6565-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B2DCB52E5E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 12:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49BAD3A45F9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Sep 2025 10:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229FF3148DD;
	Thu, 11 Sep 2025 10:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KhCBtBCp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="x0IkqhZV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4AB313558;
	Thu, 11 Sep 2025 10:29:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757586545; cv=none; b=IIK3pm/mCQc5io+j9KfpRqRaq+YHoF68z9EH8BehRXwv5xCgHmQ2Fbzhelw5SILgG3IJPBVLYny8k3oHgpLD0tvp3CtQq2ml0u0ewunY+qO1/6dy3hxmsXfDASNLvnpn1+Uo93GnG3MczhzmCLvsX13UHyjGGW+g2RRmJMjvY5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757586545; c=relaxed/simple;
	bh=n2bTqVU6nwt8yX0pkZMnhO1ARLCkw34GieKGhBhAR1g=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=hQunWu3djb8BMlvNM2/4dUmxQlEqS+oF90JT6H/FM+qRhfySJItRY96vuK4cMxfRBfjEqyvmUQEL7beElUikmtHfKGqRM4OQk1IHtCFbxPEB0i5+ryw3SUJYSN6jclB8nss0gj89a3e7LoVLaBPkxDkcBFi2T0swZLEMjQL1LlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KhCBtBCp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=x0IkqhZV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Sep 2025 10:29:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757586541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CzEyv8wJLC8jGonZB+auAoDZ6RkNJ4CifSA+95f6Xwg=;
	b=KhCBtBCpGpxF5tQE1y0vlcZL6HdZ9RWl4aRPcYYXYlGUOhHGz/sLhJIJvyjKCU5qpsMcJU
	o6pNOOkI15cUFFxoKfWj4QH7YCB6vEv6TQJk0poKRZuMc2N9NQyJJpC3GXxXdnlOBoAXEw
	nMh7jWcul1c8IT//zGsOdDCuz9boj8bn2mUTj/qpNdmwlnnUWJfw398ZHMeWaLZoqRX4UW
	ImfY/K+LaH06by7Y+cckiy0hJebl7GRCoMws668dsUQRPStcNp5+BsKYAJ2lHW2g271rt2
	eCz2IjAkaf45hg/IVEQjQ6JThhdwXM/Bl01kw7ly9nd6F87NpfnPlyNEFXxsjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757586541;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=CzEyv8wJLC8jGonZB+auAoDZ6RkNJ4CifSA+95f6Xwg=;
	b=x0IkqhZVv1kXEGXIKDsHNvGzEsk/mzZApEshZZpRY3O7OAq39wuXIbZj1/aDcj43zWK7rB
	7T7yOzaNCWq6vmDA==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Separate global and per-CPU quirks
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175758654022.709179.2242022898721637128.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     7eee1e92684507f64ec6a75fecbd27e37174b888
Gitweb:        https://git.kernel.org/tip/7eee1e92684507f64ec6a75fecbd27e3717=
4b888
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:34=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Thu, 11 Sep 2025 12:23:14 +02:00

x86/mce: Separate global and per-CPU quirks

Many quirks are global configuration settings and a handful apply to
each CPU.

Move the per-CPU quirks to vendor init to execute them on each online
CPU. Set the global quirks during BSP-only init so they're only executed
once and early.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c   | 24 +++++++++-
 arch/x86/kernel/cpu/mce/core.c  | 85 ++++++++------------------------
 arch/x86/kernel/cpu/mce/intel.c | 18 +++++++-
 3 files changed, 65 insertions(+), 62 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 7345e24..b8aed0a 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -646,6 +646,28 @@ static void disable_err_thresholding(struct cpuinfo_x86 =
*c, unsigned int bank)
 		wrmsrq(MSR_K7_HWCR, hwcr);
 }
=20
+static void amd_apply_cpu_quirks(struct cpuinfo_x86 *c)
+{
+	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
+
+	/* This should be disabled by the BIOS, but isn't always */
+	if (c->x86 =3D=3D 15 && this_cpu_read(mce_num_banks) > 4) {
+		/*
+		 * disable GART TBL walk error reporting, which
+		 * trips off incorrectly with the IOMMU & 3ware
+		 * & Cerberus:
+		 */
+		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
+	}
+
+	/*
+	 * Various K7s with broken bank 0 around. Always disable
+	 * by default.
+	 */
+	if (c->x86 =3D=3D 6 && this_cpu_read(mce_num_banks))
+		mce_banks[0].ctl =3D 0;
+}
+
 /* cpu init entry point, called from mce.c with preempt off */
 void mce_amd_feature_init(struct cpuinfo_x86 *c)
 {
@@ -653,6 +675,8 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low =3D 0, high =3D 0, address =3D 0;
 	int offset =3D -1;
=20
+	amd_apply_cpu_quirks(c);
+
 	mce_flags.amd_threshold	 =3D 1;
=20
 	for (bank =3D 0; bank < this_cpu_read(mce_num_banks); ++bank) {
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 515942c..7fd86c8 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1807,8 +1807,9 @@ static void __mcheck_cpu_mce_banks_init(void)
 		struct mce_bank *b =3D &mce_banks[i];
=20
 		/*
-		 * Init them all, __mcheck_cpu_apply_quirks() is going to apply
-		 * the required vendor quirks before
+		 * Init them all by default.
+		 *
+		 * The required vendor quirks will be applied before
 		 * __mcheck_cpu_init_prepare_banks() does the final bank setup.
 		 */
 		b->ctl =3D -1ULL;
@@ -1880,20 +1881,8 @@ static void __mcheck_cpu_init_prepare_banks(void)
 	}
 }
=20
-static void apply_quirks_amd(struct cpuinfo_x86 *c)
+static void amd_apply_global_quirks(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
-
-	/* This should be disabled by the BIOS, but isn't always */
-	if (c->x86 =3D=3D 15 && this_cpu_read(mce_num_banks) > 4) {
-		/*
-		 * disable GART TBL walk error reporting, which
-		 * trips off incorrectly with the IOMMU & 3ware
-		 * & Cerberus:
-		 */
-		clear_bit(10, (unsigned long *)&mce_banks[4].ctl);
-	}
-
 	if (c->x86 < 0x11 && mca_cfg.bootlog < 0) {
 		/*
 		 * Lots of broken BIOS around that don't clear them
@@ -1903,13 +1892,6 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 	}
=20
 	/*
-	 * Various K7s with broken bank 0 around. Always disable
-	 * by default.
-	 */
-	if (c->x86 =3D=3D 6 && this_cpu_read(mce_num_banks))
-		mce_banks[0].ctl =3D 0;
-
-	/*
 	 * overflow_recov is supported for F15h Models 00h-0fh
 	 * even though we don't have a CPUID bit for it.
 	 */
@@ -1920,26 +1902,13 @@ static void apply_quirks_amd(struct cpuinfo_x86 *c)
 		mce_flags.zen_ifu_quirk =3D 1;
 }
=20
-static void apply_quirks_intel(struct cpuinfo_x86 *c)
+static void intel_apply_global_quirks(struct cpuinfo_x86 *c)
 {
-	struct mce_bank *mce_banks =3D this_cpu_ptr(mce_banks_array);
-
 	/* Older CPUs (prior to family 6) don't need quirks. */
 	if (c->x86_vfm < INTEL_PENTIUM_PRO)
 		return;
=20
 	/*
-	 * SDM documents that on family 6 bank 0 should not be written
-	 * because it aliases to another special BIOS controlled
-	 * register.
-	 * But it's not aliased anymore on model 0x1a+
-	 * Don't ignore bank 0 completely because there could be a
-	 * valid event later, merely don't write CTL0.
-	 */
-	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
-		mce_banks[0].init =3D false;
-
-	/*
 	 * All newer Intel systems support MCE broadcasting. Enable
 	 * synchronization with a one second timeout.
 	 */
@@ -1964,7 +1933,7 @@ static void apply_quirks_intel(struct cpuinfo_x86 *c)
 		mce_flags.skx_repmov_quirk =3D 1;
 }
=20
-static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
+static void zhaoxin_apply_global_quirks(struct cpuinfo_x86 *c)
 {
 	/*
 	 * All newer Zhaoxin CPUs support MCE broadcasting. Enable
@@ -1976,29 +1945,6 @@ static void apply_quirks_zhaoxin(struct cpuinfo_x86 *c)
 	}
 }
=20
-/* Add per CPU specific workarounds here */
-static void __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
-{
-	struct mca_config *cfg =3D &mca_cfg;
-
-	switch (c->x86_vendor) {
-	case X86_VENDOR_AMD:
-		apply_quirks_amd(c);
-		break;
-	case X86_VENDOR_INTEL:
-		apply_quirks_intel(c);
-		break;
-	case X86_VENDOR_ZHAOXIN:
-		apply_quirks_zhaoxin(c);
-		break;
-	}
-
-	if (cfg->monarch_timeout < 0)
-		cfg->monarch_timeout =3D 0;
-	if (cfg->bootlog !=3D 0)
-		cfg->panic_timeout =3D 30;
-}
-
 static bool __mcheck_cpu_ancient_init(struct cpuinfo_x86 *c)
 {
 	if (c->x86 !=3D 5)
@@ -2256,6 +2202,23 @@ void mca_bsp_init(struct cpuinfo_x86 *c)
=20
 	if (cap & MCG_SER_P)
 		mca_cfg.ser =3D 1;
+
+	switch (c->x86_vendor) {
+	case X86_VENDOR_AMD:
+		amd_apply_global_quirks(c);
+		break;
+	case X86_VENDOR_INTEL:
+		intel_apply_global_quirks(c);
+		break;
+	case X86_VENDOR_ZHAOXIN:
+		zhaoxin_apply_global_quirks(c);
+		break;
+	}
+
+	if (mca_cfg.monarch_timeout < 0)
+		mca_cfg.monarch_timeout =3D 0;
+	if (mca_cfg.bootlog !=3D 0)
+		mca_cfg.panic_timeout =3D 30;
 }
=20
 /*
@@ -2275,8 +2238,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
=20
 	__mcheck_cpu_cap_init();
=20
-	__mcheck_cpu_apply_quirks(c);
-
 	if (!mce_gen_pool_init()) {
 		mca_cfg.disabled =3D 1;
 		pr_emerg("Couldn't allocate MCE records pool!\n");
diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
index 9b149b9..4655223 100644
--- a/arch/x86/kernel/cpu/mce/intel.c
+++ b/arch/x86/kernel/cpu/mce/intel.c
@@ -468,8 +468,26 @@ static void intel_imc_init(struct cpuinfo_x86 *c)
 	}
 }
=20
+static void intel_apply_cpu_quirks(struct cpuinfo_x86 *c)
+{
+	/*
+	 * SDM documents that on family 6 bank 0 should not be written
+	 * because it aliases to another special BIOS controlled
+	 * register.
+	 * But it's not aliased anymore on model 0x1a+
+	 * Don't ignore bank 0 completely because there could be a
+	 * valid event later, merely don't write CTL0.
+	 *
+	 * Older CPUs (prior to family 6) can't reach this point and already
+	 * return early due to the check of __mcheck_cpu_ancient_init().
+	 */
+	if (c->x86_vfm < INTEL_NEHALEM_EP && this_cpu_read(mce_num_banks))
+		this_cpu_ptr(mce_banks_array)[0].init =3D false;
+}
+
 void mce_intel_feature_init(struct cpuinfo_x86 *c)
 {
+	intel_apply_cpu_quirks(c);
 	intel_init_cmci();
 	intel_init_lmce();
 	intel_imc_init(c);

