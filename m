Return-Path: <linux-tip-commits+bounces-6488-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49E87B456A6
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 13:40:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E831F1898086
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Sep 2025 11:41:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A3513451D6;
	Fri,  5 Sep 2025 11:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HrLdoUoz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dERcJ76N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E8B2F60C4;
	Fri,  5 Sep 2025 11:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757072450; cv=none; b=j9iHUwdO2eEW2TBx+EJhpyU5JTeOMby1/XjWFg72R16m/9OA9tzl4PUXrT3KoLTQiJcdwfExYiHAr1wl7QBxDg0OZq/oAVDmttG7DJAtjvTxdLbbgUrxqf6d8H3MlscaTfmbMmHQ9N+3lkq4aOEP3JXxBWSeTCJv0fJHeBz5YBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757072450; c=relaxed/simple;
	bh=9Dzt6Bz7PjriJuglPUkzheC4OM+ZaWN8rXYtKraQ37I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XdSGxQTPNGKd3+9bVw9hk6MpuqLDwRlSskMn1OwkV2MN0JFgypJIr3Xvoe65ubqlmfj+9uK+nb6OHJrjOlUkEhrKOyJIwco1eskTqOPpMNlxiLvoR8CF/AqiVf7e9RgppVVE+g0ZKRjwcSkrmQ1Iu1P3CUGPIdNO0TYr1yT0e9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HrLdoUoz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dERcJ76N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Sep 2025 11:40:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757072446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3gQip8tDvRK8+TRjh4puFHpI1VdaH0YtN+PZv9GhuE=;
	b=HrLdoUoz+b384XXnWN5i+EQzLlFx8NOA+rl8I5zWbnveswUfUMu48qyKVo4Ytma/atSt1v
	8THumAcX7nCeYXPU3/xr0GKFaGrmI9HucVAzp7W9f115AAxKo1bxliC/AL5CEF7MEj+Uro
	T6GbweOYeNBjeuiZZdovt+/dKl33FZ07vsYgY/bB4dcTQPKRBTckz73sNHpqdfDDfeuLLJ
	Kaw8irEnnrG6KS25L6W21sPNK9O3inrVLFUF44b+RSG8AfC5OZKvy8VVWnlv8r/qpkdNEX
	tkq1sq3oZgTUzPMiiERi4X843pjmsOmL9PhLoNNQg7OqH4W7wXZha/WopE/9Gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757072446;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a3gQip8tDvRK8+TRjh4puFHpI1VdaH0YtN+PZv9GhuE=;
	b=dERcJ76NW6E/eDL0VHEIE2cpPnX1qEy2gCrbjxXkBXBrq+zngMqPgSpSrZKFpOjrMncJDT
	po3cY4QdNc752RCw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Remove __mcheck_cpu_init_early()
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
 Tony Luck <tony.luck@intel.com>, Nikolay Borisov <nik.borisov@suse.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250825-wip-mca-updates-v5-6-865768a2eef8@amd.com>
References: <20250825-wip-mca-updates-v5-6-865768a2eef8@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175707244484.1920.7598135746151621462.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     9f34032ec0deef58bd0eb7475f1981adfa998648
Gitweb:        https://git.kernel.org/tip/9f34032ec0deef58bd0eb7475f1981adfa9=
98648
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Mon, 25 Aug 2025 17:33:03=20
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 05 Sep 2025 12:43:44 +02:00

x86/mce: Remove __mcheck_cpu_init_early()

The __mcheck_cpu_init_early() function was introduced so that some
vendor-specific features are detected before the first MCA polling event done
in __mcheck_cpu_init_generic().

Currently, __mcheck_cpu_init_early() is only used on AMD-based systems and
additional code will be needed to support various system configurations.

However, the current and future vendor-specific code should be done during
vendor init. This keeps all the vendor code in a common location and
simplifies the generic init flow.

Move all the __mcheck_cpu_init_early() code into mce_amd_feature_init().

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Tested-by: Tony Luck <tony.luck@intel.com>
Link: https://lore.kernel.org/20250825-wip-mca-updates-v5-6-865768a2eef8@amd.=
com
---
 arch/x86/kernel/cpu/mce/amd.c  |  4 ++++
 arch/x86/kernel/cpu/mce/core.c | 14 --------------
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/amd.c b/arch/x86/kernel/cpu/mce/amd.c
index e9b9be2..aa13c93 100644
--- a/arch/x86/kernel/cpu/mce/amd.c
+++ b/arch/x86/kernel/cpu/mce/amd.c
@@ -653,6 +653,10 @@ void mce_amd_feature_init(struct cpuinfo_x86 *c)
 	u32 low =3D 0, high =3D 0, address =3D 0;
 	int offset =3D -1;
=20
+	mce_flags.overflow_recov =3D cpu_feature_enabled(X86_FEATURE_OVERFLOW_RECOV=
);
+	mce_flags.succor	 =3D cpu_feature_enabled(X86_FEATURE_SUCCOR);
+	mce_flags.smca		 =3D cpu_feature_enabled(X86_FEATURE_SMCA);
+	mce_flags.amd_threshold	 =3D 1;
=20
 	for (bank =3D 0; bank < this_cpu_read(mce_num_banks); ++bank) {
 		if (mce_flags.smca)
diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 311876e..0326fbb 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -2034,19 +2034,6 @@ static bool __mcheck_cpu_ancient_init(struct cpuinfo_x=
86 *c)
 	return false;
 }
=20
-/*
- * Init basic CPU features needed for early decoding of MCEs.
- */
-static void __mcheck_cpu_init_early(struct cpuinfo_x86 *c)
-{
-	if (c->x86_vendor =3D=3D X86_VENDOR_AMD || c->x86_vendor =3D=3D X86_VENDOR_=
HYGON) {
-		mce_flags.overflow_recov =3D !!cpu_has(c, X86_FEATURE_OVERFLOW_RECOV);
-		mce_flags.succor	 =3D !!cpu_has(c, X86_FEATURE_SUCCOR);
-		mce_flags.smca		 =3D !!cpu_has(c, X86_FEATURE_SMCA);
-		mce_flags.amd_threshold	 =3D 1;
-	}
-}
-
 static void mce_centaur_feature_init(struct cpuinfo_x86 *c)
 {
 	struct mca_config *cfg =3D &mca_cfg;
@@ -2285,7 +2272,6 @@ void mcheck_cpu_init(struct cpuinfo_x86 *c)
=20
 	mca_cfg.initialized =3D 1;
=20
-	__mcheck_cpu_init_early(c);
 	__mcheck_cpu_init_generic();
 	__mcheck_cpu_init_vendor(c);
 	__mcheck_cpu_init_prepare_banks();

