Return-Path: <linux-tip-commits+bounces-2704-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 469429B9E9A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6D351F23365
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B465189909;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ci/Itxw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YpUg5NlN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275D5175D37;
	Sat,  2 Nov 2024 10:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542217; cv=none; b=MP9SmyqEuk7rooBR/rOwqnU52NL4O6uNS1RwIqS8Zbv1O5fiaolXn1ED/8TWAK7VBwVASLJw0FuF0ubwIUmhvusGxMs2QJgHPvQMEd7TScWM9wgZX1GlHGTcrj1p5VxEYaPpEfpk/yoe1gnC8xypHXmZC1LTFs7elNOGxf/dx58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542217; c=relaxed/simple;
	bh=SfPWjj/xFomYc7Soq7tTZO65V1M06DaMGykp+BYdSQc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=My5P3znUC/U5UHEXc0ahxrABmV+Xpex8WaHUzlFaYbGWLR6JRLwSsNY2iRquuldwQz9m14QTc6TWZ9oHpHLkYcuGrS9r/9tvJCpkdJgLoAUgsPhv9tBBxBbKPdhfVSEqXxxzHv+e1kpwIJXsHDKa+gflFTsVal8KPLH6xuLk7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ci/Itxw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YpUg5NlN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSN/E6jSyfSN88r8pD6rNbPvOdzeE/Uw6tjUTukH4xY=;
	b=4ci/ItxwT4RMk9Jvv8G+47T/vgVhBmo55imf4iytGPaBrn/+qtpmXYViGjIlxZBD4KSaXP
	b8HvXy5M7B9klo1vslF8J0NikYTI490zIuuTiKR2+3nftTi5T0Kla3EJmsdCKqQ2cQQWoB
	gdQuEw8xh9wDDbJrwHYfgtMQZEcBR11VtsXs8CfbxkO/zPSQeDnM+yKfhC2d04+pm2OpG9
	eta0XrKTIkw/vKCvfCd5di2q/YB5Z1T1zdJiGmluK7iSBUTWtbB332zf7ftRoiUZ8H3PpR
	9ppF4Tezd45rAVACxKzo7vm9nwd3UCHUIZNb9+ICILtAQT7YQPCQyJGuv1qSlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542211;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iSN/E6jSyfSN88r8pD6rNbPvOdzeE/Uw6tjUTukH4xY=;
	b=YpUg5NlNkxPoRqrYHvV4FAIWL9bIqpXMbD40yTt7USwoKpreyjzTzdt7pK6Epp66rN0M0j
	kYegOs4u1GWzV5Cw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Access rng vdso data without vvar.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-16-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-16-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221022.3137.5448294435611814712.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     87aa4d583208b3c4fe15b92b3fdfb8ffaa188600
Gitweb:        https://git.kernel.org/tip/87aa4d583208b3c4fe15b92b3fdfb8ffaa1=
88600
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:14 +01:00

x86/vdso: Access rng vdso data without vvar.h

The vdso_rng_data is at a well-known offset in the vvar page.
Make use of this invariant to remove the usage of vvar.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-16-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S | 2 ++
 arch/x86/include/asm/vdso/getrandom.h | 8 ++++----
 arch/x86/include/asm/vvar.h           | 5 -----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index 51c0cc0..acce607 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -24,6 +24,8 @@ SECTIONS
 #include <asm/vvar.h>
 #undef EMIT_VVAR
=20
+	vdso_rng_data =3D vvar_page + __VDSO_RND_DATA_OFFSET;
+
 	pvclock_page =3D vvar_start + PAGE_SIZE;
 	hvclock_page =3D vvar_start + 2 * PAGE_SIZE;
 	timens_page  =3D vvar_start + 3 * PAGE_SIZE;
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vds=
o/getrandom.h
index d0713c8..2bf9c0e 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -8,7 +8,6 @@
 #ifndef __ASSEMBLY__
=20
 #include <asm/unistd.h>
-#include <asm/vvar.h>
=20
 /**
  * getrandom_syscall - Invoke the getrandom() syscall.
@@ -28,13 +27,14 @@ static __always_inline ssize_t getrandom_syscall(void *bu=
ffer, size_t len, unsig
 	return ret;
 }
=20
-#define __vdso_rng_data (VVAR(_vdso_rng_data))
+extern struct vdso_rng_data vdso_rng_data
+	__attribute__((visibility("hidden")));
=20
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
 {
 	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode =3D=3D=
 VDSO_CLOCKMODE_TIMENS)
-		return (void *)&__vdso_rng_data + ((void *)&timens_page - (void *)__arch_g=
et_vdso_data());
-	return &__vdso_rng_data;
+		return (void *)&vdso_rng_data + ((void *)&timens_page - (void *)__arch_get=
_vdso_data());
+	return &vdso_rng_data;
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index fe3434d..b605914 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -62,11 +62,6 @@ extern char __vvar_page;
=20
 DECLARE_VVAR(0, struct vdso_data, _vdso_data)
=20
-#if !defined(_SINGLE_DATA)
-#define _SINGLE_DATA
-DECLARE_VVAR_SINGLE(__VDSO_RND_DATA_OFFSET, struct vdso_rng_data, _vdso_rng_=
data)
-#endif
-
 #undef DECLARE_VVAR
 #undef DECLARE_VVAR_SINGLE
=20

