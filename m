Return-Path: <linux-tip-commits+bounces-2743-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0A679B9FB8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:54:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18B7F28194D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:54:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B921B0F10;
	Sat,  2 Nov 2024 11:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rCN60n2L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5wQMUFw8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DFD71AF0A4;
	Sat,  2 Nov 2024 11:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548230; cv=none; b=H67ctuTcMMJ7mVAJt3YUJIO7EHgsfAxKP7yRtb+xgm7Q52ZIOfjqRzMotqFEM2+HgLUiZL7j0fwKfecpKDI7Zn8bOX8jgvIiroObt44P01ljep6ROgE5UYodYMCzVsQwv+cKRbaJR88KWmxuLqM8e221h0uCsgYpoEiutKlK344=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548230; c=relaxed/simple;
	bh=1l9zEuFGgtzzbzmOWN0Cs8fqv4gepBUQ9BxG7xFpUww=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YC4391+dad3+/G9chZI43ca+MuOtdiGYUhkgw//IGx409N8b0yVI+VE2x696cH+eGKURl5EViDNMqL+Eq1QKwxX7xRUcI1dWs2r+iWsg2ECK/VLioRXnEECkTOIG7diLUqWI1dn/59a4oDdvCSmKLggp6MedXCduPQnhvbGa+E4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rCN60n2L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5wQMUFw8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jauhjieIeYu/geyaJfS0ebXSObRlLXnZYOq/6PQtaM=;
	b=rCN60n2L3FwFuTKlV3A+DnwVwiBGwQ0f5uf4xmEoVx3kgQKZqbwJRfdfJqFw8/BmvLmVfm
	R1aLwqCoigeIh4rZaZPZa1aedspNahJgXl5BCKDkElUkf8AG6xcIPwubMADrOVc+ibEOvl
	Rblmyg3hy4l4to8x17Lpmn8yxe4KnQlmD7w7+HtozjrF6Azejdg8/xXXTgU599Gwhg7UKH
	DHcgkw2Mtbz/ajU/23zJd2wdZf1q7WAzt1ws1SF3YbBoaeVxOcSQiL1DXaSt1EpChmCPVN
	gW2AH5YPKyhSDF5pQ9F4BmPDQQXgVgPfdir3gilmjbTL45p2zU4Mlz2BlppiSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5jauhjieIeYu/geyaJfS0ebXSObRlLXnZYOq/6PQtaM=;
	b=5wQMUFw8iTd9qsKUwCjkTazYH7VWnnZjONKwOPL3apwVDnp4S8IwSvmz6N9ebecuN08KSD
	4QCv70HW/XRGG/Bg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] ARM: vdso: Remove assembly for datapage access
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-7-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-7-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054822675.3137.4490550265684382864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     2bb79470e5c87f211d05f0dd1c7a4291c9b7e1a4
Gitweb:        https://git.kernel.org/tip/2bb79470e5c87f211d05f0dd1c7a4291c9b=
7e1a4
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:33 +01:00

ARM: vdso: Remove assembly for datapage access

vdso/datapage.h provides a hidden declaration for _vdso_data.
When using it the compiler will automatically generate PC-relative
accesses which avoids the need for a custom assembly-based accessor.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-7-b64f0842d51=
2@linutronix.de

---
 arch/arm/include/asm/vdso/gettimeofday.h |  4 +---
 arch/arm/vdso/Makefile                   |  2 +-
 arch/arm/vdso/datapage.S                 | 16 ----------------
 arch/arm/vdso/vdso.lds.S                 |  3 ++-
 4 files changed, 4 insertions(+), 21 deletions(-)
 delete mode 100644 arch/arm/vdso/datapage.S

diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/=
vdso/gettimeofday.h
index 2134cbd..592d3d0 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -15,8 +15,6 @@
=20
 #define VDSO_HAS_CLOCK_GETRES		1
=20
-extern struct vdso_data *__get_datapage(void);
-
 static __always_inline int gettimeofday_fallback(
 				struct __kernel_old_timeval *_tv,
 				struct timezone *_tz)
@@ -139,7 +137,7 @@ static __always_inline u64 __arch_get_hw_counter(int cloc=
k_mode,
=20
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return __get_datapage();
+	return _vdso_data;
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/arm/vdso/Makefile b/arch/arm/vdso/Makefile
index 01067a2..8a306bb 100644
--- a/arch/arm/vdso/Makefile
+++ b/arch/arm/vdso/Makefile
@@ -5,7 +5,7 @@ include $(srctree)/lib/vdso/Makefile
=20
 hostprogs :=3D vdsomunge
=20
-obj-vdso :=3D vgettimeofday.o datapage.o note.o
+obj-vdso :=3D vgettimeofday.o note.o
=20
 # Build rules
 targets :=3D $(obj-vdso) vdso.so vdso.so.dbg vdso.so.raw vdso.lds
diff --git a/arch/arm/vdso/datapage.S b/arch/arm/vdso/datapage.S
deleted file mode 100644
index 9cd73b7..0000000
--- a/arch/arm/vdso/datapage.S
+++ /dev/null
@@ -1,16 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/linkage.h>
-#include <asm/asm-offsets.h>
-
-	.align 2
-.L_vdso_data_ptr:
-	.long	_start - . - VDSO_DATA_SIZE
-
-ENTRY(__get_datapage)
-	.fnstart
-	adr	r0, .L_vdso_data_ptr
-	ldr	r1, [r0]
-	add	r0, r0, r1
-	bx	lr
-	.fnend
-ENDPROC(__get_datapage)
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 165d1d2..9bfa0f5 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -11,6 +11,7 @@
  */
=20
 #include <linux/const.h>
+#include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
=20
@@ -19,7 +20,7 @@ OUTPUT_ARCH(arm)
=20
 SECTIONS
 {
-	PROVIDE(_start =3D .);
+	PROVIDE(_vdso_data =3D . - VDSO_DATA_SIZE);
=20
 	. =3D SIZEOF_HEADERS;
=20

