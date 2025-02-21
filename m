Return-Path: <linux-tip-commits+bounces-3545-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A0C6A3EF5F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:03:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A40227A4546
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E010F202C5D;
	Fri, 21 Feb 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k5i2UHyk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXnYC/wk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 219E81FF1CB;
	Fri, 21 Feb 2025 09:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128590; cv=none; b=eWkaO1HclN1tJVOhkcPbBcDNeWANTTMkyALk04k4M2nOj3QhfV3hxOJBAcN63SO8yife5ObzyQ9lvymVpslIxU3+Gv7WZfMCtbfropoNr9D4qtG2xJxVaTKOm5cXU1yJ79Dcr7U7MoU4DXIe63ZtDmJagaVK5thkeLGZJyKHAp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128590; c=relaxed/simple;
	bh=scsiiI7RJhK+ad+lbz5D7eM64JLy6egJ0r44gC0pbfY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X+Yd1EJW13O1xYsB8EzqaqkSzUveubToDZRGKFHSVAI3TV5K+bDzFREIu78ehh4unD3WBwKDFcR0rfpUu6+iAihBfKf34tTCQ37kZ1oZdc7ytFdUuSWklhD0KH17JorIBV62nbtKAYSdD+mhUjpxEOED6iCXys+s0UzR8I3Ug7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k5i2UHyk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXnYC/wk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ2ZihQGdTOzrjA3hYUJU+i+rwRI1oZBQEu+QJ8uLXQ=;
	b=k5i2UHykujyrxSSD7mfWE7rS4X9K/1tmrFeI07ekWMgaR0tIXZvvQ9JtvRCadSax9qegyj
	bbkhAR4KmXYKSnAoPMyr4tbHZ1ZGI6iD1MlJWNnL1iYis1cYOfiQBi6WO4yeF5Kklmt2yr
	RP26darkyI8+XkwDVUpbPEVLpbKkvwPW59trGTtzjmZnWeYd9W1ig0yEzGwtM8lPOqwTRw
	BTSub4foMkuH07SS6RBini0ah6+0l/uviOwHPVXZ6eVQj9n5NDnWVJYNEB2hAu2o/eU4+S
	w4EDRufPwzbAp8qup9Ym4eLdjzSY81lz6JPKWzwHB+DcZsEec+puBHuNx2z41g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WQ2ZihQGdTOzrjA3hYUJU+i+rwRI1oZBQEu+QJ8uLXQ=;
	b=aXnYC/wklH27VDH28eovdIcAIChpDvO2LtpUzRXC1og7HsKYSPrJupelhmZbgbJhLXdNk5
	uwNEYNGlRrbEJ9BQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso/vdso2c: Remove page handling
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-16-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-16-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012858681.10177.13906017536194394520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9729dceab17bba8a122e26875f05d291b969ce7c
Gitweb:        https://git.kernel.org/tip/9729dceab17bba8a122e26875f05d291b96=
9ce7c
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:48 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:03 +01:00

x86/vdso/vdso2c: Remove page handling

The values are not used anymore.
Also the sanity checks performed by vdso2c can never trigger as they
only validate invariants already enforced by the linker script.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-16-13a4669dfc8c@=
linutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S |  4 ----
 arch/x86/entry/vdso/vdso2c.c          | 21 ---------------------
 arch/x86/entry/vdso/vdso2c.h          | 20 --------------------
 arch/x86/include/asm/vdso.h           |  6 ------
 4 files changed, 51 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index e5cecdb..ec1ac19 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -24,10 +24,6 @@ SECTIONS
 	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
 	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
=20
-	/* For compatibility with vdso2c */
-	vvar_page =3D vdso_u_data;
-	vvar_start =3D vdso_u_data;
-
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/x86/entry/vdso/vdso2c.c b/arch/x86/entry/vdso/vdso2c.c
index 90d15f2..f84e8f8 100644
--- a/arch/x86/entry/vdso/vdso2c.c
+++ b/arch/x86/entry/vdso/vdso2c.c
@@ -69,33 +69,12 @@
=20
 const char *outfilename;
=20
-/* Symbols that we need in vdso2c. */
-enum {
-	sym_vvar_start,
-	sym_vvar_page,
-	sym_pvclock_page,
-	sym_hvclock_page,
-	sym_timens_page,
-};
-
-const int special_pages[] =3D {
-	sym_vvar_page,
-	sym_pvclock_page,
-	sym_hvclock_page,
-	sym_timens_page,
-};
-
 struct vdso_sym {
 	const char *name;
 	bool export;
 };
=20
 struct vdso_sym required_syms[] =3D {
-	[sym_vvar_start] =3D {"vvar_start", true},
-	[sym_vvar_page] =3D {"vvar_page", true},
-	[sym_pvclock_page] =3D {"pvclock_page", true},
-	[sym_hvclock_page] =3D {"hvclock_page", true},
-	[sym_timens_page] =3D {"timens_page", true},
 	{"VDSO32_NOTE_MASK", true},
 	{"__kernel_vsyscall", true},
 	{"__kernel_sigreturn", true},
diff --git a/arch/x86/entry/vdso/vdso2c.h b/arch/x86/entry/vdso/vdso2c.h
index 67b3e37..78ed1c1 100644
--- a/arch/x86/entry/vdso/vdso2c.h
+++ b/arch/x86/entry/vdso/vdso2c.h
@@ -150,26 +150,6 @@ static void BITSFUNC(go)(void *raw_addr, size_t raw_len,
 		}
 	}
=20
-	/* Validate mapping addresses. */
-	for (i =3D 0; i < sizeof(special_pages) / sizeof(special_pages[0]); i++) {
-		INT_BITS symval =3D syms[special_pages[i]];
-
-		if (!symval)
-			continue;  /* The mapping isn't used; ignore it. */
-
-		if (symval % 4096)
-			fail("%s must be a multiple of 4096\n",
-			     required_syms[i].name);
-		if (symval + 4096 < syms[sym_vvar_start])
-			fail("%s underruns vvar_start\n",
-			     required_syms[i].name);
-		if (symval + 4096 > 0)
-			fail("%s is on the wrong side of the vdso text\n",
-			     required_syms[i].name);
-	}
-	if (syms[sym_vvar_start] % 4096)
-		fail("vvar_begin must be a multiple of 4096\n");
-
 	if (!image_name) {
 		fwrite(stripped_addr, stripped_len, 1, outfile);
 		return;
diff --git a/arch/x86/include/asm/vdso.h b/arch/x86/include/asm/vdso.h
index d7f6592..80be0da 100644
--- a/arch/x86/include/asm/vdso.h
+++ b/arch/x86/include/asm/vdso.h
@@ -18,12 +18,6 @@ struct vdso_image {
 	unsigned long extable_base, extable_len;
 	const void *extable;
=20
-	long sym_vvar_start;  /* Negative offset to the vvar area */
-
-	long sym_vvar_page;
-	long sym_pvclock_page;
-	long sym_hvclock_page;
-	long sym_timens_page;
 	long sym_VDSO32_NOTE_MASK;
 	long sym___kernel_sigreturn;
 	long sym___kernel_rt_sigreturn;

