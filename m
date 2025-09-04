Return-Path: <linux-tip-commits+bounces-6450-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82C17B4373C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20F911C800C3
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07A912FC01F;
	Thu,  4 Sep 2025 09:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XtxJTMQX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y82EEzXG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 423072F745B;
	Thu,  4 Sep 2025 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978347; cv=none; b=K0JPw0Y/CbMl6ZCFdd1sQWjITOB1Jjx4GFFgsh/K9Nyv1BdF8ECbPbvbHNvc1+oF+ra/1lQzqgHMxGHqoIRFf36O7WAmiJ4/rwzvMXtibSMWCyVRfXKpG8dVkbZQbIfQM4TCEDdgdlaeHDId5nAOgJ88IzuBcwIT3KbwVbIeVSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978347; c=relaxed/simple;
	bh=/yRhxcwptzSg2p+unnDmQ3ubjYRVbV04Z+3UkqvPW3A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j702Q+Z3YQ1bjH+ke2eqSgeFMdtmpj9EW4NtDYj75ZU4X0RGLUTZ393mF4p1EnQ7D5bjTcFIOEe2RJlfck80lBm53ublSW7JLUBsnrn6XLXtYdMyFqslWMqvBwRfM14y4p7s1+KlZHeS1NRGi/VvmymgIrFHegG/pBbdurcEh9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XtxJTMQX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=y82EEzXG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeOsfpc1Z2O47hU4HMjjSxNI3al6MI15fJrl/H18+Pw=;
	b=XtxJTMQXlZ+O4/0teNAmVarZBISf7qgLbzMoC7Ql/sCDNTBwTG+CWuoodrOBd+IukDSZy1
	iIX5yJS0+kCh5YWsrSGAfUY9BuOYD29oDA/gTweK2wB0zCQ4IW76igRNuSMaYrqNvIHitn
	ZPvd08geLV2C7XU6U/lgbadsCFQyZtozoOA73oOkA6Dy91/20UzlTpuwgsgsMUpoIamoQJ
	zvt1eT6bTCVpLsdCZrQmm+GDsqUrIG+Hbf/d91s1REr/FV1Mvp0BStj9CWop3NWouRJa2F
	4eU8wN1M2pW5JuYlCVd0yraBJQ2op8iNYoMTaTxmq9e381LX9xCfiEPUGRFMZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978344;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QeOsfpc1Z2O47hU4HMjjSxNI3al6MI15fJrl/H18+Pw=;
	b=y82EEzXGDXPk2SUGlXr3/g/HfglaOvQbBfu7ZekK2TGiTSL2aV6K/GdSlaSUikhmFyZbEG
	tOGrsE/KMr1lYdDQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Move ENABLE_COMPAT_VDSO from core to arm64
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-3-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-3-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697834296.1920.4325497444444100529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7d298d25ce81251068bb4ea1d92813ec764a9fec
Gitweb:        https://git.kernel.org/tip/7d298d25ce81251068bb4ea1d92813ec764=
a9fec
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:49 +02:00

vdso: Move ENABLE_COMPAT_VDSO from core to arm64

The ENABLE_COMAPT_VDSO symbol is only used by arm64 and only for the
time-related functionality. There should be no new users, so it doesn't
need to be in the generic vDSO code.

Move the logic into arm64 architecture-specific code and replace the
explicit define by the standard '#ifdef __aarch64__'.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-3-d9b65750e49f@li=
nutronix.de

---
 arch/arm64/include/asm/vdso/compat_barrier.h      | 7 +++----
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 6 +++---
 arch/arm64/include/asm/vdso/gettimeofday.h        | 8 ++++++++
 arch/arm64/kernel/vdso32/Makefile                 | 1 -
 include/vdso/datapage.h                           | 4 ----
 5 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_barrier.h b/arch/arm64/includ=
e/asm/vdso/compat_barrier.h
index 3ac35f4..6d75e03 100644
--- a/arch/arm64/include/asm/vdso/compat_barrier.h
+++ b/arch/arm64/include/asm/vdso/compat_barrier.h
@@ -7,11 +7,10 @@
=20
 #ifndef __ASSEMBLY__
 /*
- * Warning: This code is meant to be used with
- * ENABLE_COMPAT_VDSO only.
+ * Warning: This code is meant to be used from the compat vDSO only.
  */
-#ifndef ENABLE_COMPAT_VDSO
-#error This header is meant to be used with ENABLE_COMPAT_VDSO only
+#ifdef __arch64__
+#error This header is meant to be used with from the compat vDSO only
 #endif
=20
 #ifdef dmb
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index d60ea7a..7d1a116 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -2,8 +2,8 @@
 /*
  * Copyright (C) 2018 ARM Limited
  */
-#ifndef __ASM_VDSO_GETTIMEOFDAY_H
-#define __ASM_VDSO_GETTIMEOFDAY_H
+#ifndef __ASM_VDSO_COMPAT_GETTIMEOFDAY_H
+#define __ASM_VDSO_COMPAT_GETTIMEOFDAY_H
=20
 #ifndef __ASSEMBLY__
=20
@@ -163,4 +163,4 @@ static inline bool vdso_clocksource_ok(const struct vdso_=
clock *vc)
=20
 #endif /* !__ASSEMBLY__ */
=20
-#endif /* __ASM_VDSO_GETTIMEOFDAY_H */
+#endif /* __ASM_VDSO_COMPAT_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/=
asm/vdso/gettimeofday.h
index da1ab87..c59e841 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -5,6 +5,8 @@
 #ifndef __ASM_VDSO_GETTIMEOFDAY_H
 #define __ASM_VDSO_GETTIMEOFDAY_H
=20
+#ifdef __aarch64__
+
 #ifndef __ASSEMBLY__
=20
 #include <asm/alternative.h>
@@ -96,4 +98,10 @@ static __always_inline const struct vdso_time_data *__arch=
_get_vdso_u_time_data(
=20
 #endif /* !__ASSEMBLY__ */
=20
+#else /* !__aarch64__ */
+
+#include "compat_gettimeofday.h"
+
+#endif /* __aarch64__ */
+
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/kernel/vdso32/Makefile b/arch/arm64/kernel/vdso32/Mak=
efile
index f2dfdc7..230fdc2 100644
--- a/arch/arm64/kernel/vdso32/Makefile
+++ b/arch/arm64/kernel/vdso32/Makefile
@@ -59,7 +59,6 @@ VDSO_CAFLAGS +=3D -DDISABLE_BRANCH_PROFILING
 VDSO_CAFLAGS +=3D -march=3Darmv8-a
=20
 VDSO_CFLAGS :=3D $(VDSO_CAFLAGS)
-VDSO_CFLAGS +=3D -DENABLE_COMPAT_VDSO=3D1
 # KBUILD_CFLAGS from top-level Makefile
 VDSO_CFLAGS +=3D -Wall -Wundef -Wstrict-prototypes -Wno-trigraphs \
                -fno-strict-aliasing -fno-common \
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 0253303..0b1982f 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -196,11 +196,7 @@ enum vdso_pages {
  * - clock_gettime_fallback(): fallback for clock_gettime.
  * - clock_getres_fallback(): fallback for clock_getres.
  */
-#ifdef ENABLE_COMPAT_VDSO
-#include <asm/vdso/compat_gettimeofday.h>
-#else
 #include <asm/vdso/gettimeofday.h>
-#endif /* ENABLE_COMPAT_VDSO */
=20
 #else /* !__ASSEMBLY__ */
=20

