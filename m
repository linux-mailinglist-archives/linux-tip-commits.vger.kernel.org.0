Return-Path: <linux-tip-commits+bounces-6451-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 073E4B43742
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:34:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EDA7C583B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09D732FC877;
	Thu,  4 Sep 2025 09:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EXgvRwMZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zpbaycnc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4549F2FC00C;
	Thu,  4 Sep 2025 09:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978348; cv=none; b=gkUuMRoLUDocy1b3umthJEgRlEPBIgmp4yBpGj4r1PqNG9XtxCT/xmnOgNeLcwhI/am7h9SwH62H5QEDvwqlcUOnf//rmbm5DynpA/sJCMhPvwvLmOHwX8fRWOjl0GTRxlHUfWyLDKyvXguBbAlv/3ou0lLPTFTfAQdKMijPrXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978348; c=relaxed/simple;
	bh=5DwCjgrSTs7nsYL0uHv8sGlLFfm/tIYmpt+Kzs5RuJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kNN6PgeoYpDw89KBAgPuV0nqSj3492EREzLq/0xE4BktDRIfSxdJdxPo6WTms7GOQ8aOrbSwVGBNYsd8or4NqGY5S8rDz0h9xL0nrTCuwNCu26uYl8KXHQVeSdcGevAS4jFrTCGXhGJBjet5Pbn9EklfQ5UitBbHcZV9CCWzPZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EXgvRwMZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zpbaycnc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFofBIrKycZMuEheSD09F7Wfv0BeJ5dFaNxWl0d1DL8=;
	b=EXgvRwMZ+IHYKJRbX7wBCabdKvVYUkdo2GMmhHdtHgVpsnSUYzW4yOVw+BnqJRE+SSjvcs
	iKupeXg+ZzQEQPrQe/2D0wZHA8dsO5udCwRYsiITPzgxbLW89Z+wDzA3DHB1GYaGHvxq+3
	bx7W/koMm8MzPZq6emCi2BtkB2r4JgQBqc+RjO0y/GY+X88bdRlqxpnnnrRo7IqjHdN9hR
	OoJIcadn1+x8tu+gPIdRo9UqQFPrXoQ2yfC0ZVSgfySxgzQZh1a+1TIWZl62vf2sxqBX0U
	r+HsR9Itkmnf8ccHfuvIFDTVvp2SVKfD/GQybPlyuJSsOSXskYOsj9wPuye7dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978345;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lFofBIrKycZMuEheSD09F7Wfv0BeJ5dFaNxWl0d1DL8=;
	b=zpbaycncypVuQa6XqZHJOU9RYf71oAr8funX93xEh8pNY1C4rbLq4iFvBPJC9i5y2oiavL
	fkOpzcSsjThf2uCw==
From: "tip-bot2 for Rasmus Villemoes" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] ARM: VDSO: Remove cntvct_ok global variable
Cc: Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-2-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-2-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697834421.1920.24648452759851137.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     39f1ee1299c9bab9c87dc3087b9f82f346b8190b
Gitweb:        https://git.kernel.org/tip/39f1ee1299c9bab9c87dc3087b9f82f346b=
8190b
Author:        Rasmus Villemoes <linux@rasmusvillemoes.dk>
AuthorDate:    Tue, 26 Aug 2025 08:17:05 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:49 +02:00

ARM: VDSO: Remove cntvct_ok global variable

The cntvct_ok variable has not had any external user since commit
c7a18100bdff ("lib/vdso: Avoid highres update if clocksource is not
VDSO capable").

It also only has one user in vdso.c, once during init, so rather than
having the caller of patch_vdso() initialize cntvct_ok, just call
cntvct_functional() directly and avoid the global variable entirely.

Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-2-d9b65750e49f@li=
nutronix.de

---
 arch/arm/include/asm/vdso/vsyscall.h |  2 --
 arch/arm/kernel/vdso.c               | 10 +++-------
 2 files changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso=
/vsyscall.h
index 4e7226a..ff1c729 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -7,8 +7,6 @@
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
=20
-extern bool cntvct_ok;
-
 static __always_inline
 void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 {
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 325448f..e38a304 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -54,11 +54,9 @@ struct elfinfo {
 	char		*dynstr;	/* ptr to .dynstr section */
 };
=20
-/* Cached result of boot-time check for whether the arch timer exists,
- * and if so, whether the virtual counter is useable.
+/* Boot-time check for whether the arch timer exists, and if so,
+ * whether the virtual counter is usable.
  */
-bool cntvct_ok __ro_after_init;
-
 static bool __init cntvct_functional(void)
 {
 	struct device_node *np;
@@ -159,7 +157,7 @@ static void __init patch_vdso(void *ehdr)
 	 * want programs to incur the slight additional overhead of
 	 * dispatching through the VDSO only to fall back to syscalls.
 	 */
-	if (!cntvct_ok) {
+	if (!cntvct_functional()) {
 		vdso_nullpatch_one(&einfo, "__vdso_gettimeofday");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime");
 		vdso_nullpatch_one(&einfo, "__vdso_clock_gettime64");
@@ -197,8 +195,6 @@ static int __init vdso_init(void)
 	vdso_total_pages =3D VDSO_NR_PAGES; /* for the data/vvar pages */
 	vdso_total_pages +=3D text_pages;
=20
-	cntvct_ok =3D cntvct_functional();
-
 	patch_vdso(vdso_start);
=20
 	return 0;

