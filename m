Return-Path: <linux-tip-commits+bounces-6492-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 540DEB456AE
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 13:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23DEEA444DF
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 11:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF5534A333;
	Fri,  5 Sep 2025 11:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W16y82dK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Yfakk6R2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2725346A07;
	Fri,  5 Sep 2025 11:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072454; cv=none; b=lBPS7p0SQdxMr64GNUiRG/gsUath6vrinWFKaZxmZTKaew2sommB5Yl9kxZ/3uVr1EKKwM2t1RePGaAXVBxVZXnAuWgSswWJYQoQS/FkENedwhfxSHs5u2d2mSkxkztyylFmBVBqpS2L6+p+ewJiYd5M2YPsxOrWkj2XBwGc3jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072454; c=relaxed/simple;
	bh=rYK4l/XcDW0w3/BeiOxcfrLvYq3Be3bICR2JMdkNDI0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nNATVre8v0QSt+z4MLvwlrEpgCNeJ2KL02WWu8Z5PLWoL9mUr2qldEy68RSzJdTg62lp/EFTPaxj+QxuQ1xly6O2PWOw5fdawvomT6iUU0cgnxX/KgegU+U2qUyOS3bbSKu60t2dSVVIX4QSyr8shmE55xFhHoXIuzeGW1OsTJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W16y82dK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Yfakk6R2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 11:40:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757072451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IscP2bYnCTAfte1NsaZxqEjVtleS7V09nDfISwKJWIM=;
	b=W16y82dK4VcQj/n2RAcEPLTkgUNDko6xE4IdlqkiFrEaWVFnNm/eegQoipx1EF2KPPpcYk
	S76/oYnKPB+Ij+hhZA6eTC0Zx+vkBsqSE7Bsw5gBYDIJ16jsBYB5SQrJBjRsuO0Ok0luQJ
	Ktc33Do32R8J5RzQX+f6XaPzkZ8qoV7YGck18otJq8N3Dv14tSDnABT3vlJCNw//Ho4R/5
	x3+Lcoab8tWNDkXB4thjaxOaJ+OHPtaMSo0ffT7YtrNYA4u/pINrY9r/HfW76rnPzhMCmI
	G8OABmINRrFW1O8caTL+pLdtaka1F2kyHvzfZWhacRer0ako8tZIYYz8Nw/XWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757072451;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IscP2bYnCTAfte1NsaZxqEjVtleS7V09nDfISwKJWIM=;
	b=Yfakk6R2KTgGMU7bJ1uznKEe0BsLN/zcH1VED2pDDHCXnlz2qTFoMjmBIkzPMzjlTVMxQg
	l/pd0YWi33TYlhAQ==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce/amd: Remove return value for
 mce_threshold_{create,remove}_device()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>,
 Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250624-wip-mca-updates-v4-6-236dd74f645f@amd.com>
References: <20250624-wip-mca-updates-v4-6-236dd74f645f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175707244981.1920.9955130895015118941.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     4d2161b9e8ba64076f520ec2f00eefb00722c15e
Gitweb:        https://git.kernel.org/tip/4d2161b9e8ba64076f520ec2f00eefb0072=
2c15e
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Tue, 24 Jun 2025 14:16:01=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Sep 2025 12:40:44 +02:00

x86/mce/amd: Remove return value for mce_threshold_{create,remove}_device()

The return values are not checked, so set return type to 'void'.

Also, move function declarations to internal.h, since these functions are
only used within the MCE subsystem.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: https://lore.kernel.org/20250624-wip-mca-updates-v4-6-236dd74f645f@amd.=
com
---
 arch/x86/include/asm/mce.h         |  6 ------
 arch/x86/kernel/cpu/mce/amd.c      | 22 ++++++++++------------
 arch/x86/kernel/cpu/mce/internal.h |  4 ++++
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/arch/x86/include/asm/mce.h b/arch/x86/include/asm/mce.h
index 6c77c03..752802b 100644
--- a/arch/x86/include/asm/mce.h
+++ b/arch/x86/include/asm/mce.h
@@ -371,15 +371,9 @@ enum smca_bank_types {
=20
 extern bool amd_mce_is_memory_error(struct mce *m);
=20
-extern int mce_threshold_create_device(unsigned int cpu);
-extern int mce_threshold_remove_device(unsigned int cpu);
-
 void mce_amd_feature_init(struct cpuinfo_x86 *c);
 enum smca_bank_types smca_get_bank_type(unsigned int cpu, unsigned int bank);
 #else
-
-static inline int mce_threshold_create_device(unsigned int cpu)		{ return 0;=
 };
-static inline int mce_threshold_remove_device(unsigned int cpu)		{ return 0;=
 };
 static inline bool amd_mce_is_memory_error(struct mce *m)		{ return false; };
 static inline void mce_amd_feature_init(struct cpuinfo_x86 *c)		{ }
 #endif
diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index 9b980ae..f429451 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -1296,12 +1296,12 @@ static void __threshold_remove_device(struct threshol=
d_bank **bp)
 	kfree(bp);
 }
=20
-int mce_threshold_remove_device(unsigned int cpu)
+void mce_threshold_remove_device(unsigned int cpu)
 {
 	struct threshold_bank **bp =3D this_cpu_read(threshold_banks);
=20
 	if (!bp)
-		return 0;
+		return;
=20
 	/*
 	 * Clear the pointer before cleaning up, so that the interrupt won't
@@ -1310,7 +1310,7 @@ int mce_threshold_remove_device(unsigned int cpu)
 	this_cpu_write(threshold_banks, NULL);
=20
 	__threshold_remove_device(bp);
-	return 0;
+	return;
 }
=20
 /**
@@ -1324,36 +1324,34 @@ int mce_threshold_remove_device(unsigned int cpu)
  * thread running on @cpu.  The callback is invoked on all CPUs which are
  * online when the callback is installed or during a real hotplug event.
  */
-int mce_threshold_create_device(unsigned int cpu)
+void mce_threshold_create_device(unsigned int cpu)
 {
 	unsigned int numbanks, bank;
 	struct threshold_bank **bp;
-	int err;
=20
 	if (!mce_flags.amd_threshold)
-		return 0;
+		return;
=20
 	bp =3D this_cpu_read(threshold_banks);
 	if (bp)
-		return 0;
+		return;
=20
 	numbanks =3D this_cpu_read(mce_num_banks);
 	bp =3D kcalloc(numbanks, sizeof(*bp), GFP_KERNEL);
 	if (!bp)
-		return -ENOMEM;
+		return;
=20
 	for (bank =3D 0; bank < numbanks; ++bank) {
 		if (!(this_cpu_read(bank_map) & BIT_ULL(bank)))
 			continue;
-		err =3D threshold_create_bank(bp, cpu, bank);
-		if (err) {
+		if (threshold_create_bank(bp, cpu, bank)) {
 			__threshold_remove_device(bp);
-			return err;
+			return;
 		}
 	}
 	this_cpu_write(threshold_banks, bp);
=20
 	if (thresholding_irq_en)
 		mce_threshold_vector =3D amd_threshold_interrupt;
-	return 0;
+	return;
 }
diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/int=
ernal.h
index b5ba598..64ac25b 100644
--- a/arch/x86/kernel/cpu/mce/internal.h
+++ b/arch/x86/kernel/cpu/mce/internal.h
@@ -265,6 +265,8 @@ void mce_prep_record_common(struct mce *m);
 void mce_prep_record_per_cpu(unsigned int cpu, struct mce *m);
=20
 #ifdef CONFIG_X86_MCE_AMD
+void mce_threshold_create_device(unsigned int cpu);
+void mce_threshold_remove_device(unsigned int cpu);
 extern bool amd_filter_mce(struct mce *m);
 bool amd_mce_usable_address(struct mce *m);
=20
@@ -293,6 +295,8 @@ static __always_inline void smca_extract_err_addr(struct =
mce *m)
 }
=20
 #else
+static inline void mce_threshold_create_device(unsigned int cpu)	{ }
+static inline void mce_threshold_remove_device(unsigned int cpu)	{ }
 static inline bool amd_filter_mce(struct mce *m) { return false; }
 static inline bool amd_mce_usable_address(struct mce *m) { return false; }
 static inline void smca_extract_err_addr(struct mce *m) { }

