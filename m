Return-Path: <linux-tip-commits+bounces-7441-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C2D91C78366
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 10:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 5DA2A348E62
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Nov 2025 09:45:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D513126CC;
	Fri, 21 Nov 2025 09:45:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YgfLZmUO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YyQz4AOV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1C982D7D2E;
	Fri, 21 Nov 2025 09:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763718347; cv=none; b=curEyvJj5I7/3KXgDqZaImaHVFxvjR6B46wM8WpkSCc30T9bH/ZdokpzEC3Pi13/HyTEgMAUxmMHADOQ9z1oqlEKepmuTBHOQk/smAKZtM1K+6lrNL72smo1it4S8e6VtijVZi/CUfO+Juv4gesmvwsgVb2A6JIcBvWOuC0YHag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763718347; c=relaxed/simple;
	bh=7oGHtS660W31E9J0E7lA4/Q0tc9AVJlB0rbq3G/m/4I=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=K9L554kAjrvS6CXw3h1Hcamo9PWoj2RmmjVwHuV20BX8sO9kxOM3N0R7Zj+5Qor+yB2XFGSyt15yVNFE21eKEP8EVq5FcYtCdpPEd/EX1qyKCuBTIYZQc8hI0tBXbfrs+pEX7+cCxG2I5PQ7prbI6iAK2yuZdbyVeUiyL28aXsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YgfLZmUO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YyQz4AOV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Nov 2025 09:45:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763718344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GmWkdMZbZQC8eOYD16oez/nVgKQAvX2tRgA+z70vHDk=;
	b=YgfLZmUO3YTSolIkptKD4nZivsT7kyEcCpGePfVK8sbQo3PZMJBoD8YiVSglz2r97jtot+
	RvvVCf6Ggt/cbMHoF9FwF1i5sRs+MTp/gz56CZlGVhUFR/ZrZk7AaiIDTdBkOql94WJP63
	QddVVKTY4tDuV7RKaAaHO3/WiKbrL/Dz86xW6LYRoMnOwsrIHJ+eXRA3+KmXBWGOZ57HpG
	o1gFjOS591kYYCRckarOmjqyCIynEtS3J1HsMXjFNDUJhUdr2OdqrXwy3xNXt9DlB2cd7t
	pe+xTDVb0CeeSP3n4XXuA8UkY3fevfrRHbxw2eLCV+Q9c50PUkza5+GWMubC1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763718344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GmWkdMZbZQC8eOYD16oez/nVgKQAvX2tRgA+z70vHDk=;
	b=YyQz4AOVZUNB68R8oznqR8jlbJ2nwecyrJxK4ezrDuLzlfaZ8xx6ZUSkFZek03c1Xrbq9L
	wgiF9EwpNlU28UCA==
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
Message-ID: <176371834309.498.1028273246220204758.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     eeb3f76d73baed4c8ecc883e1eaafba3cb8aae1d
Gitweb:        https://git.kernel.org/tip/eeb3f76d73baed4c8ecc883e1eaafba3cb8=
aae1d
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 04 Nov 2025 14:55:45=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 21 Nov 2025 10:32:28 +01:00

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

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20251104-wip-mca-updates-v8-0-66c8eacf67b9@amd.=
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
index 940d1a0..af6e9b5 100644
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
index b0e00ec..4cf16fa 100644
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
index f4a0076..eebaa63 100644
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

