Return-Path: <linux-tip-commits+bounces-6589-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24E42B5629C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 589931C20C68
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Sep 2025 18:52:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527582367A2;
	Sat, 13 Sep 2025 18:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UPT7OsL/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qty0C3ah"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 669201E8335;
	Sat, 13 Sep 2025 18:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757789552; cv=none; b=s51Gv/UMadDKUH24ka9aiyXvsNozSPpJkI9GVzOhyiNpVAKWMszWRZN57llrNoRLHCtJR10bkw44ZXbzAXgaNxY1TDW3OuNkUFQNQLRsf7Vu8ZtRNm+VXU0c+ww4m7ZD3xe6HuuMatBOsnvR6w/rWQ9v2rgwNWCqtG3e0MlfmFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757789552; c=relaxed/simple;
	bh=DbZHzNVAUX3zIGT13/nfmox8RL1EFmj5WnbyUChhup0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mnMOIIOMBrTdm98zJxtBC+HD7KW2hifZDGbM4axV94X4OoxnaS3xp16IbvEZPcrLYo1/0ZP1XMaG9tCjASlc+QDEsw3gb/zJcTh64v+BPjj0lHdl8wElN2zkr2Tjcb32ZvDNFCcpDB7wn2bcpKjccfZSqId1LItJVdsAorDStgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UPT7OsL/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qty0C3ah; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 18:52:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757789547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wQmUiOGWmfc5mwkHpj+8wBq5TkfbD29RLRa5ARg7HI8=;
	b=UPT7OsL/fD2LzPsDsa2ev7FdRiIJekDcVf1KWQabhmSpVcDuBZlbp/GrWHJPmrkFR1NLMI
	ehLhCap/R4eB4Hl9aIPuIP/QrZV35KGS6CpGETv7Ei1Cx/moFXZ0F2HU5NURDUiBmlIb7Q
	BxLL8nkDHl9mrMB6TWOfAhOr1ATmm4NuSVpidiczDDz8vi5e8hxFuCN6lYmG4Ex2SBhxls
	BP/JrmqvJ0uzmevA6lPgzmrOUbaDJEoQdliAnhuJ8Un8R1+8uttSMtVTZeecQuLb25S7Gt
	E52mAxowsXKyCK79BBh7mWiTIRgOyi+f5n5PzM9FPVCeDXh4J1+0wvlLeRL0+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757789547;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=wQmUiOGWmfc5mwkHpj+8wBq5TkfbD29RLRa5ARg7HI8=;
	b=Qty0C3ahagTNybhDJY2a8jdixQYjZjGIGpbiWJVkTfpE1+lpnct6dTVyjxq8IPhYKHsQsx
	pvCE1Vr8Rcg7NdDg==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Save and use APEI corrected threshold limit
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175778954600.709179.10822676771795205332.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     28e82d6f03b0626f78e0a2719eca9fbf43f26855
Gitweb:        https://git.kernel.org/tip/28e82d6f03b0626f78e0a2719eca9fbf43f=
26855
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 08 Sep 2025 15:40:44=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Sat, 13 Sep 2025 20:45:49 +02:00

x86/mce: Save and use APEI corrected threshold limit

The MCA threshold limit generally is not something that needs to change during
runtime. It is common for a system administrator to decide on a policy for
their managed systems.

If MCA thresholding is OS-managed, then the threshold limit must be set at
every boot. However, many systems allow the user to set a value in their BIOS.
And this is reported through an APEI HEST entry even if thresholding is not in
FW-First mode.

Use this value, if available, to set the OS-managed threshold limit.  Users
can still override it through sysfs if desired for testing or debug.

APEI is parsed after MCE is initialized. So reset the thresholding blocks
later to pick up the threshold limit.

  [ bp: Sanitize threshold limit message format:
    -mce: HEST: Corrected error threshold limit =3D 500
    +mce: HEST corrected error threshold limit: 500 ]

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250908-wip-mca-updates-v6-0-eef5d6c74b9c@amd.=
com
---
 arch/x86/include/asm/mce.h          |  6 ++++++
 arch/x86/kernel/acpi/apei.c         |  2 ++
 arch/x86/kernel/cpu/mce/amd.c       | 18 ++++++++++++++++--
 arch/x86/kernel/cpu/mce/internal.h  |  2 ++
 arch/x86/kernel/cpu/mce/threshold.c | 13 +++++++++++++
 5 files changed, 39 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 7d65881..1cfbfff 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -308,6 +308,12 @@ DECLARE_PER_CPU(struct mce, injectm);
 /* Disable CMCI/polling for MCA bank claimed by firmware */
 extern void mce_disable_bank(int bank);
=20
+#ifdef CONFIG_X86_MCE_THRESHOLD
+void mce_save_apei_thr_limit(u32 thr_limit);
+#else
+static inline void mce_save_apei_thr_limit(u32 thr_limit) { }
+#endif /* CONFIG_X86_MCE_THRESHOLD */
+
 /*
  * Exception handler
  */
diff --git a/arch/x86/kernel/acpi/apei.c b/arch/x86/kernel/acpi/apei.c
index 0916f00..e21419e 100644
--- a/arch/x86/kernel/acpi/apei.c
+++ b/arch/x86/kernel/acpi/apei.c
@@ -19,6 +19,8 @@ int arch_apei_enable_cmcff(struct acpi_hest_header *hest_hd=
r, void *data)
 	if (!cmc->enabled)
 		return 0;
=20
+	mce_save_apei_thr_limit(cmc->notify.error_threshold_value);
+
 	/*
 	 * We expect HEST to provide a list of MC banks that report errors
 	 * in firmware first mode. Otherwise, return non-zero value to
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index b895559..9b74608 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -489,6 +489,18 @@ static void threshold_restart_bank(unsigned int bank, bo=
ol intr_en)
 	}
 }
=20
+/* Try to use the threshold limit reported through APEI. */
+static u16 get_thr_limit(void)
+{
+	u32 thr_limit =3D mce_get_apei_thr_limit();
+
+	/* Fallback to old default if APEI limit is not available. */
+	if (!thr_limit)
+		return THRESHOLD_MAX;
+
+	return min(thr_limit, THRESHOLD_MAX);
+}
+
 static void mce_threshold_block_init(struct threshold_block *b, int offset)
 {
 	struct thresh_restart tr =3D {
@@ -497,7 +509,7 @@ static void mce_threshold_block_init(struct threshold_blo=
ck *b, int offset)
 		.lvt_off		=3D offset,
 	};
=20
-	b->threshold_limit		=3D THRESHOLD_MAX;
+	b->threshold_limit		=3D get_thr_limit();
 	threshold_restart_block(&tr);
 };
=20
@@ -1071,7 +1083,7 @@ static int allocate_threshold_blocks(unsigned int cpu, =
struct threshold_bank *tb
 	b->address		=3D address;
 	b->interrupt_enable	=3D 0;
 	b->interrupt_capable	=3D lvt_interrupt_supported(bank, high);
-	b->threshold_limit	=3D THRESHOLD_MAX;
+	b->threshold_limit	=3D get_thr_limit();
=20
 	if (b->interrupt_capable) {
 		default_attrs[2] =3D &interrupt_enable.attr;
@@ -1082,6 +1094,8 @@ static int allocate_threshold_blocks(unsigned int cpu, =
struct threshold_bank *tb
=20
 	list_add(&b->miscj, &tb->miscj);
=20
+	mce_threshold_block_init(b, (high & MASK_LVTOFF_HI) >> 20);
+
 	err =3D kobject_init_and_add(&b->kobj, &threshold_ktype, tb->kobj, get_name=
(cpu, bank, b));
 	if (err)
 		goto out_free;
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/int=
ernal.h
index 9920ee5..a31cf98 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -67,6 +67,7 @@ void mce_track_storm(struct mce *mce);
 void mce_inherit_storm(unsigned int bank);
 bool mce_get_storm_mode(void);
 void mce_set_storm_mode(bool storm);
+u32  mce_get_apei_thr_limit(void);
 #else
 static inline void cmci_storm_begin(unsigned int bank) {}
 static inline void cmci_storm_end(unsigned int bank) {}
@@ -74,6 +75,7 @@ static inline void mce_track_storm(struct mce *mce) {}
 static inline void mce_inherit_storm(unsigned int bank) {}
 static inline bool mce_get_storm_mode(void) { return false; }
 static inline void mce_set_storm_mode(bool storm) {}
+static inline u32  mce_get_apei_thr_limit(void) { return 0; }
 #endif
=20
 /*
diff --git a/arch/x86/kernel/cpu/mce/threshold.c b/arch/x86/kernel/cpu/mce/th=
reshold.c
index 4514459..a35ced9 100644
--- a/arch/x86/kernel/cpu/mce/threshold.c
+++ b/arch/x86/kernel/cpu/mce/threshold.c
@@ -13,6 +13,19 @@
=20
 #include "internal.h"
=20
+static u32 mce_apei_thr_limit;
+
+void mce_save_apei_thr_limit(u32 thr_limit)
+{
+	mce_apei_thr_limit =3D thr_limit;
+	pr_info("HEST corrected error threshold limit: %u\n", thr_limit);
+}
+
+u32 mce_get_apei_thr_limit(void)
+{
+	return mce_apei_thr_limit;
+}
+
 static void default_threshold_interrupt(void)
 {
 	pr_err("Unexpected threshold interrupt at vector %x\n",

