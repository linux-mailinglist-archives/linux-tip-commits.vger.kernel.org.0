Return-Path: <linux-tip-commits+bounces-2732-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C47E9B9FA3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:52:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 197DCB21802
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:52:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 291501A0BF1;
	Sat,  2 Nov 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y+NyfHWK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FvylnG7O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493CD19923A;
	Sat,  2 Nov 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548223; cv=none; b=STNal4Bsq4UciJsyybQ2an7ka4CMwirEu/pwejppI13tUyHa9VzVmWFIoHy7RUcBJiQV3L6jYszI7xrB7VEbFfpxvobMUFarxCLPQ78IPLANlmL5sAIgK55QeElm7b+CVsVTbYgCOe9gOFnSJDOdTsAYUdsfChEc5ZQIKiG8CAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548223; c=relaxed/simple;
	bh=PXNsNtDuDjGAJG8NE7H4kVY3o6BjY1vIV1c87pNYGzM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AVr62olEvrpBaY13YhOog+eLNdrBO5drg2hR/AxC03YpWq5MJ8YuTCg0LbdsJYKfC5RGQ0eEmVPqmjvQuguXdXszNYPMctS23m93MuuBbl+TItw91U4MYk+JbUIC+Ea9LYfbkLH8MIGtx3dcmnqnozYkJLMuOpSmWD1yI2pUYWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y+NyfHWK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FvylnG7O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G26/tUUaSrqAoWgRNacGbG52MBMYXlBNUwxY6ts0ST8=;
	b=Y+NyfHWK5bCrh85fxTWfwOc4wPD6vw+IjCtVhQYrmOtQTqjjKUVAoAZMGdnZmS3OV6cc+A
	TAW3IQF15KqgEFQNzxMLIOo8kmOZ155EaG5iH6lIrkla9kL30HOq1wDbapJnU2XnjVOap0
	O0DbKApo6tMcVFNFxL7pXuWt6JjcvppsfxtUnkn0bo0qdgTpjoeJOjYMBC4XNS1+bdpLv6
	WnFIp+vSJXql1j9ptkadOT21JdUZeyP2uU0HYbwWekSA58JZd8hPgXcuZIiZnkZkHXLm50
	Tgp9uBkOHMT87RplOJ43gJjQD2NKcKMixEt9pAfy9dnDQQoXDuYUcRjRQ/m81Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G26/tUUaSrqAoWgRNacGbG52MBMYXlBNUwxY6ts0ST8=;
	b=FvylnG7OUFYjZAitYBHj1d+l+RPfe0VBurQSvkbNuchTUBKUyAiZhPW0BYbXysOqgNEfSX
	3rB6i9Deh4iFjMAQ==
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
Message-ID: <173054821884.3137.15416544130743372612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7d4acbae2aca16eb269ade9078b7ebad729e27ea
Gitweb:        https://git.kernel.org/tip/7d4acbae2aca16eb269ade9078b7ebad729=
e27ea
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:20 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:34 +01:00

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

