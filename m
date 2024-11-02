Return-Path: <linux-tip-commits+bounces-2734-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A62CD9B9FA7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:52:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D3981F2138E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A42F189B83;
	Sat,  2 Nov 2024 11:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TaRXrsBq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1O3B1YlU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA155170822;
	Sat,  2 Nov 2024 11:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548224; cv=none; b=cLRkR3dlWJt1v8fmHVYtdeaTHRcn6fFa4tYHfWVrlUTj0OrJxDeR6M7/rLl2LFYaiCfmOcHbjRO9R5ppwQ9My294d+lnaiQhpGUTBDIm3t5Xejlt38hi2QZyKKievjSow829AdNwItwAO2RLFRdICJS/s3DGugOmo0tx6yXDSxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548224; c=relaxed/simple;
	bh=kH6uhtXHCAXq3FamjT+2/SZ009bilYcOZRx6yLqIm5M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PNHxg66Cyn10RQUD5lppzOUdiLa+CvJxoSDE1SNIZwTJC2aIEc3TGZ34gQZeYcUPVxCNsOgZBj6KgYYJEB195BIZZPSZVncz+1/KqiqdouXawWuedeO8iSn4NRyGKP4yFNkdEqd/R0qeDC6H+vRJcxXk238MXy4gWpGvxor6Log=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TaRXrsBq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1O3B1YlU; arc=none smtp.client-ip=193.142.43.55
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
	bh=AN6ZhkymZiqYNl2QqUuVLrv7+z9sVuuJTa9jrSfywbc=;
	b=TaRXrsBqE+yuWr3fvp984RS1htFyMdIzVXr3bWkk5HhOtOYJrBMK5wY6ELfiiDLK/mdQQg
	B2wRoHai8YgCWH0FMni/av2lIstKZQGkMgN73I/NSSgbBzSsuYZHH2y2oH/qCKmCq9eKac
	cLtFehPStiSzKXVh5HTM73u6VA6SKP6C3siY6n1oF4U/UovqdJCE/703ngkmfhK6+kVWiO
	H1iWLFNMZhreAOf920gvmZ1P6eQ/EkGrJfWcyriEjqb8uSOXpsOneCnlTaqdUXbni+fILl
	7CE4ukYcO5K5o7QVdX+e1ed54zA5xdl+bgQ6cLlxbyo/I+Qa5FcNTJUgxxuOng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548221;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AN6ZhkymZiqYNl2QqUuVLrv7+z9sVuuJTa9jrSfywbc=;
	b=1O3B1YlU6UtWRKW8VeHqBqn5ESMxKvw8rvVyEhZtaMLbFQoFAeB5jLdQLYZxrsfUvozLoS
	Gqa2ytF/hmrqyyAw==
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
Message-ID: <173054822020.3137.3720813213021613578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     c3a190d425916e84bbda65873f9fc27ce4b82893
Gitweb:        https://git.kernel.org/tip/c3a190d425916e84bbda65873f9fc27ce4b=
82893
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:34 +01:00

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

