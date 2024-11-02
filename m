Return-Path: <linux-tip-commits+bounces-2702-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6BB39B9E98
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77A7B28241A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BEAF17B51A;
	Sat,  2 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZraDVrda";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+2jrLOQf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D0E172BCC;
	Sat,  2 Nov 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542217; cv=none; b=lMn0o3Mx+oCPszsUz2XKi4nLcp5OzmgUcDMEVM5oXJb6wjDTOo0NT1Trx9DcAgT4YcXyPxf00UqmVKGNLge1hP/Uo0fP7pMw7RegQw/nSFvpKUStqPmFpPyVpNPOzAWpvOX7hvyA4JMNhKQA0+8MByamTCOkKAB1qBla34PdHCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542217; c=relaxed/simple;
	bh=FZjGtJKwNihcR7HR3tSb744VIkPfskslDeEBqhoUhXQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SlipkzIx63KbIQZXc3aTgBflPBhGG240vG6Tcw2zhl0pL7GjQOHI/tcHIKXyRel9BvJXqbh9VEUysv8R9PPXUN5rKVddARcxqQ5Eb+7Vs0Cw84hJpezu5e1+FK57vX1GGDQLyLlYmerslGj6HuWW3zT8sVyZvYVDfbZAW6vfJGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZraDVrda; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+2jrLOQf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZ1nTymzRlEffeBcZ9bd+Ehl+zD7mR4kwA+3tXwrUNQ=;
	b=ZraDVrdaKDmOmBWeoS82ZO7GtSRH+6xLG+HNDPus/XqS8dAKCHIVUGZclPQzewB3OX8hye
	KRcSfQmbeBi5eeNFt0QZrmYD7nXk0sse3a8Z/wrwBqfRtiuwfNEPAJ7SWg922XsGZZWUDR
	cCtxl2+SzcwKOD/sWCR+Vh+BPpo87ZMpCDwaN2c/UVO3vOKmjfdjvyXlnkXdh85ETi/fkm
	LsWgUEiFmOajoKB0+jn8t14nEoCu/9NLkKk/ss4WFlbYtmIIciq+hWzWnCJnNpq7DzlbCd
	0RqOWlEJZudRnSe0C+yqhoyxGyWKlY79zu/7ZIoEkryml+SlcH8+cdhCgO0aWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rZ1nTymzRlEffeBcZ9bd+Ehl+zD7mR4kwA+3tXwrUNQ=;
	b=+2jrLOQfjfGlJCuoLF915AJinaXgxFDOB7/ZTkfDgEI88Sf8Hw7X+1S5CnVLecPWVwFCWD
	R1v03w2YQHvbguCQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Access vdso data without vvar.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-18-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-18-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220886.3137.317036954226833114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     90b1b043df741c8184dfe3c9c37260d770268393
Gitweb:        https://git.kernel.org/tip/90b1b043df741c8184dfe3c9c37260d7702=
68393
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:15 +01:00

x86/vdso: Access vdso data without vvar.h

The vdso_data is at the start of the vvar page.
Make use of this invariant to remove the usage of vvar.h.
This also matches the logic for the timens data.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-18-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S    | 5 -----
 arch/x86/include/asm/vdso/gettimeofday.h | 6 +++---
 2 files changed, 3 insertions(+), 8 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index c7e194b..9e602c0 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -20,11 +20,6 @@ SECTIONS
 	vvar_start =3D . - 4 * PAGE_SIZE;
 	vvar_page  =3D vvar_start;
=20
-	/* Place all vvars at the offsets in asm/vvar.h. */
-#define EMIT_VVAR(name, offset) vvar_ ## name =3D vvar_page + offset;
-#include <asm/vvar.h>
-#undef EMIT_VVAR
-
 	vdso_rng_data =3D vvar_page + __VDSO_RND_DATA_OFFSET;
=20
 	pvclock_page =3D vvar_start + PAGE_SIZE;
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index 1e61161..375a34b 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -14,13 +14,13 @@
=20
 #include <uapi/linux/time.h>
 #include <asm/vgtod.h>
-#include <asm/vvar.h>
 #include <asm/unistd.h>
 #include <asm/msr.h>
 #include <asm/pvclock.h>
 #include <clocksource/hyperv_timer.h>
=20
-#define __vdso_data (VVAR(_vdso_data))
+extern struct vdso_data vvar_page
+	__attribute__((visibility("hidden")));
=20
 extern struct vdso_data timens_page
 	__attribute__((visibility("hidden")));
@@ -277,7 +277,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
=20
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return __vdso_data;
+	return &vvar_page;
 }
=20
 static inline bool arch_vdso_clocksource_ok(const struct vdso_data *vd)

