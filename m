Return-Path: <linux-tip-commits+bounces-2715-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF009B9EAF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:12:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B800C1C20BD0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E45119CD01;
	Sat,  2 Nov 2024 10:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVceNzHd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXG8tMSm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A642E189BB3;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542221; cv=none; b=NQWqWUC+HfpeANlSmcKHzmKMn26KgI3S3u02Srzyie+SFhFbnyvThBPnjL1foaozcivMvWGxfqsHTMBFr7RYF312zgV8RXRQj2AmxF4PUUH267Kz9oAqE/RO9m+5n1QaYAQckk1YNuE0VGNsbGtioBa/JmBCfdditdymlBf4qrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542221; c=relaxed/simple;
	bh=3eNU8Xu4azUhtwnh8dCV/tI5IXsKF/E77fZhkkk2I+w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ollq9Dsh7efywLxES56P1pFz6HVdyizF9A48vqJbNVjbcEfF/gKbqZObESjYSSMICtCGhufX5btot8FgnrjCegK+3lui/p89t1hTLEl3FUDmHXm7lUrqu9s7TXzrrzPcdVtWRyuq3T0owum67dSYpsHOHW/fYFb25dCjE9nRXxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NVceNzHd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXG8tMSm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znj4TohaapfLw2MtyjLr6EJ7PiOcbTYF6hjFKWI/UBY=;
	b=NVceNzHd8U4iRPyd/BJQY+ck83RTUfdIMR5BNJREIkOJOW42OScpzMuk7kXRXhx/cDGJwf
	k06byRMHpWlno/SN1oOuV2kJiu9lK5NG0IJFfb5hXZiJhV83KihcpiSgRfZpS5BX9J3CyH
	5V9wQ9omUQrJx9eaEuoSzF15phZFOxJkJo1jDYqVBYNeLf0BThxmLftqa9od25+CGAcVUF
	2LznZcNkpYCMFR7OXvtLkJQEYRZsEk63RjXRC7euUw0qqcW8HIe8aIYkz1gVxFHwmR7F9Q
	RnslkntQMq6vz+SOwT+RELcOMkqeuKEQEqNVsl/yKMbeLFGEIMYSuOpZaomAaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542216;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=znj4TohaapfLw2MtyjLr6EJ7PiOcbTYF6hjFKWI/UBY=;
	b=LXG8tMSmC/5EFDCt3LwEPZJ0EPehPVqPOznfL5YP711CjeC0XJg4IhVXszzFgGejPR3y8T
	4d/36Q7x5Dom/VAQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] LoongArch: vDSO: Use vdso/datapage.h to access vDSO data
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-8-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-8-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221591.3137.12862213323173933341.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ad49e5b31c0cbb0ae692a5dad3bca685196f53d6
Gitweb:        https://git.kernel.org/tip/ad49e5b31c0cbb0ae692a5dad3bca685196=
f53d6
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:13 +01:00

LoongArch: vDSO: Use vdso/datapage.h to access vDSO data

vdso/datapage.h provides symbols and functions to ease the access to
shared vDSO data from both the kernel and the vDSO.
Make use of it to simplify the current code and also prepare for further
changes unifying the vDSO data storage between architectures.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-8-b64f0842d51=
2@linutronix.de

---
 arch/loongarch/include/asm/vdso/getrandom.h    |  3 +--
 arch/loongarch/include/asm/vdso/gettimeofday.h |  4 ++--
 arch/loongarch/include/asm/vdso/vdso.h         | 18 +-----------------
 arch/loongarch/kernel/asm-offsets.c            |  9 +++++++++-
 arch/loongarch/vdso/vdso.lds.S                 |  8 +++++++-
 arch/loongarch/vdso/vgetcpu.c                  |  2 +-
 6 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/inc=
lude/asm/vdso/getrandom.h
index 02f3677..e80f3c4 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -30,8 +30,7 @@ static __always_inline ssize_t getrandom_syscall(void *_buf=
fer, size_t _len, uns
=20
 static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
 {
-	return (const struct vdso_rng_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGE=
S_START *
-	       PAGE_SIZE + offsetof(struct loongarch_vdso_data, rng_data));
+	return &_loongarch_data.rng_data;
 }
=20
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/=
include/asm/vdso/gettimeofday.h
index 89e6b22..7eb3f04 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -91,14 +91,14 @@ static inline bool loongarch_vdso_hres_capable(void)
=20
 static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
 {
-	return (const struct vdso_data *)get_vdso_data();
+	return _vdso_data;
 }
=20
 #ifdef CONFIG_TIME_NS
 static __always_inline
 const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
 {
-	return (const struct vdso_data *)(get_vdso_data() + VVAR_TIMENS_PAGE_OFFSET=
 * PAGE_SIZE);
+	return _timens_data;
 }
 #endif
 #endif /* !__ASSEMBLY__ */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/=
asm/vdso/vdso.h
index e31ac74..1c183a9 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -48,23 +48,7 @@ enum vvar_pages {
=20
 #define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
=20
-static inline unsigned long get_vdso_base(void)
-{
-	unsigned long addr;
-
-	__asm__(
-	" la.pcrel %0, _start\n"
-	: "=3Dr" (addr)
-	:
-	:);
-
-	return addr;
-}
-
-static inline unsigned long get_vdso_data(void)
-{
-	return get_vdso_base() - VVAR_SIZE;
-}
+extern struct loongarch_vdso_data _loongarch_data __attribute__((visibility(=
"hidden")));
=20
 #endif /* __ASSEMBLY__ */
=20
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-=
offsets.c
index bee9f7a..049c5c3 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -14,6 +14,7 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 #include <asm/ftrace.h>
+#include <vdso/datapage.h>
=20
 static void __used output_ptreg_defines(void)
 {
@@ -321,3 +322,11 @@ static void __used output_kvm_defines(void)
 	OFFSET(KVM_GPGD, kvm, arch.pgd);
 	BLANK();
 }
+
+static void __used output_vdso_defines(void)
+{
+	COMMENT("LoongArch vDSO offsets.");
+
+	DEFINE(__VVAR_PAGES, VVAR_NR_PAGES);
+	BLANK();
+}
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 6b441bd..160cfae 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -3,6 +3,8 @@
  * Author: Huacai Chen <chenhuacai@loongson.cn>
  * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
  */
+#include <asm/page.h>
+#include <generated/asm-offsets.h>
=20
 OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
=20
@@ -10,7 +12,11 @@ OUTPUT_ARCH(loongarch)
=20
 SECTIONS
 {
-	PROVIDE(_start =3D .);
+	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
+#ifdef CONFIG_TIME_NS
+	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
+#endif
+	PROVIDE(_loongarch_data =3D _vdso_data + 2 * PAGE_SIZE);
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 9e445be..0db5125 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -21,7 +21,7 @@ static __always_inline int read_cpu_id(void)
=20
 static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
 {
-	return (struct vdso_pcpu_data *)(get_vdso_data() + VVAR_LOONGARCH_PAGES_STA=
RT * PAGE_SIZE);
+	return _loongarch_data.pdata;
 }
=20
 extern

