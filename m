Return-Path: <linux-tip-commits+bounces-2735-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDDA9B9FA8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3662B1C20A7B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:52:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507A71AB50B;
	Sat,  2 Nov 2024 11:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmNAc+nR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kjIKpM80"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652361A3042;
	Sat,  2 Nov 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548225; cv=none; b=WQqr5T3sAjOX/0SXbFq+oH2i1QsnpLj6ekxS8LDUeXFxCUDlBh5ft9rjB5NJtSB58d0PNmeDgAdy0vMjcQHdNf2UEiV3VmT75Ink/smZ1Dtjr1KfNXqSD4Vied7gsAle7pPSxXmQlQwJwaL/0HYakLx5uYLiNXFXJfkvxvExhz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548225; c=relaxed/simple;
	bh=n/ZuZ21Z8BAaSzADmd3fjBl0x6jCs6D1r8mll0jj2Es=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YfZ/UuD2hxtqVl/F9fk2BH/8BR2OpSOX6XHAXDUZ3W+90wRQya+MwSH4C9vugngBvND5k/GWn9k6gxj0LIal1d1NdHJc5cLEACWrmcDGfl2tSLcFRcDhd6cs4BTM+L/zxR8EzgoMKi8YECe0JhGTif9j5orUdGCvd+oD10npAeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmNAc+nR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kjIKpM80; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wPlq0ndLGWFSHgLbHa/rQrt0VVYJPYwNzGNk1uOdcU=;
	b=QmNAc+nRLzUUbkK/gPzBc3TSwLmRgwNpdvhtlKWwj+im9No17aYuTA0ij69R/i5BTvoSRK
	w/KrH27wuKCB0HD0gvCBxmRsQI2Ds/3ifiOyuPGvU9D97NwmTwfCXXXIPztrHeVeut4NcG
	7jFM7LpwrIbFFJyv0SM2WgqT//L5R8AD+SGhNzMxnVbMDPhSiuQ4896nJdnluQI7f4HiuL
	FUt1C4Bv9Zt/Lvd0qvf6BZGmecEhRKWRksY4qqrvIE57BaY6+sA9KTZYHHJCD/5h8YLn6p
	jo9mgYw5NgEYowLLteK13V3FYMiqem2f2kAcKnyhP1sWdiOFioGDPK97AJddnA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wPlq0ndLGWFSHgLbHa/rQrt0VVYJPYwNzGNk1uOdcU=;
	b=kjIKpM80cHZzbJX30TP4uebywPStKjryy7WUpP0h2V3hdolOFz0M/3IVrRx5rm2+6MYXT3
	EfOWA0VjnN2ASaAA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Access timens vdso data without vvar.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-15-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-15-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054822091.3137.16845283982212981168.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     59b7761638a3f299750c04f431f2b4e1bea9465c
Gitweb:        https://git.kernel.org/tip/59b7761638a3f299750c04f431f2b4e1bea=
9465c
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:34 +01:00

x86/vdso: Access timens vdso data without vvar.h

The vdso_data is at the start of the timens page.
Make use of this invariant to remove the usage of vvar.h.
This also matches the logic for the pvclock and hvclock pages.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-15-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S    | 6 ------
 arch/x86/include/asm/vdso/getrandom.h    | 2 +-
 arch/x86/include/asm/vdso/gettimeofday.h | 6 ++++--
 3 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index bafa73f..51c0cc0 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -28,12 +28,6 @@ SECTIONS
 	hvclock_page =3D vvar_start + 2 * PAGE_SIZE;
 	timens_page  =3D vvar_start + 3 * PAGE_SIZE;
=20
-#undef _ASM_X86_VVAR_H
-	/* Place all vvars in timens too at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) timens_ ## name =3D timens_page + offset;
-#include <asm/vvar.h>
-#undef EMIT_VVAR
-
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vds=
o/getrandom.h
index ecdcdbc..d0713c8 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -33,7 +33,7 @@ static __always_inline ssize_t getrandom_syscall(void *buff=
er, size_t len, unsig
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
 {
 	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode =3D=3D=
 VDSO_CLOCKMODE_TIMENS)
-		return (void *)&__vdso_rng_data + ((void *)&__timens_vdso_data - (void *)_=
_arch_get_vdso_data());
+		return (void *)&__vdso_rng_data + ((void *)&timens_page - (void *)__arch_g=
et_vdso_data());
 	return &__vdso_rng_data;
 }
=20
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index b2d2df0..1e61161 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -21,7 +21,9 @@
 #include <clocksource/hyperv_timer.h>
=20
 #define __vdso_data (VVAR(_vdso_data))
-#define __timens_vdso_data (TIMENS(_vdso_data))
+
+extern struct vdso_data timens_page
+	__attribute__((visibility("hidden")));
=20
 #define VDSO_HAS_TIME 1
=20
@@ -61,7 +63,7 @@ extern struct ms_hyperv_tsc_page hvclock_page
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
 {
-	return __timens_vdso_data;
+	return &timens_page;
 }
 #endif
=20

