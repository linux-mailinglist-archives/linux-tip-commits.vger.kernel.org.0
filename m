Return-Path: <linux-tip-commits+bounces-2714-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BBF0E9B9EAC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2C181C20B77
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D88AD199EA2;
	Sat,  2 Nov 2024 10:10:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Qoadgs9a";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kQ/VWACt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B788E189BBB;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542220; cv=none; b=rT7K5pBEaLS+d37HlWQ27CVmklFVICy10ZNeis7xi+8wsM5m74jLaUJC4uqRwS2k+O4HzmyF+YxKrkJ4D2KNmQF8bVuGSObk+ffFiucr4D0lpQkenQdEix7SP3wbDVKgpkA5JdFwU0oFyNDXa8tI7QpSOcm2tt3gMWELBFIUKXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542220; c=relaxed/simple;
	bh=FKPIosf8xtuOoKodkWw05qPdrgoVqBnw6BgM2jH91lo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M9/3TDErlZWnGe860YFrWy296OZSoPDFcmy/w1Ris2ouuTtjOsphSqp1C9DDJTkhM39NsnbQ9sLKfV9T1/yBaiV9xFhFoQ/DmAYR42q5+dF7keXNrx31VdCSOC2rIylZjWmcCb6oJNPmwWod3cl35cUzVr77qYpzo73sKPNLtKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Qoadgs9a; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kQ/VWACt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz3bT5StdqH45zjPESwv3uxQZd2kUNPA4Pmi6MpOhYw=;
	b=Qoadgs9aVEudwWmLtR4INKd6kOEw58t4N+JKoJMwedr+WAvTIH2ZSKHh6/C9+htEZD53Mv
	OJ2sJqdpx1C+UjmYNG0p0VINW4ZhyJH+3CONEGdSk2lYifO7kmBiEc9xFUjpZBpxGcalqB
	1Q4EgjAPus2hM7Muqb2VlUURLGQuaLGOdgHji2AlLZ0VRaWzmZ/RFbVS9zsO+0XG3fkCDR
	ztIeyiwb0SVVaEMuC5HZmF6ecC0tzgTvHLFRzyPji85A5jF2/jKJk0yyyndJIT4wpReidI
	SwBJa9DHlPYEBlFW65/w0qEhH++DfMbLVu4JIERtJQ1jpHyqsdRaLfbW952Zzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542217;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cz3bT5StdqH45zjPESwv3uxQZd2kUNPA4Pmi6MpOhYw=;
	b=kQ/VWACt81/aQ2/x3gEd0/AaBpDDn1/oN2TEWP/70T2DZxLbWxZ80dFNdwYY54TRkFq18l
	aS8VlvUE5gUJWiBg==
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
Message-ID: <173054221657.3137.3008336509327987270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     91bd576bd33e06791937b858452aad74ea2524de
Gitweb:        https://git.kernel.org/tip/91bd576bd33e06791937b858452aad74ea2=
524de
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:13 +01:00

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

