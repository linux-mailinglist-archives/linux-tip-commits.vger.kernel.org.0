Return-Path: <linux-tip-commits+bounces-2709-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB83D9B9EA3
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25AA1F2383B
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5020F18A6AE;
	Sat,  2 Nov 2024 10:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NOmSOpTK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1vc86Um"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED6B185936;
	Sat,  2 Nov 2024 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542219; cv=none; b=Lruswlsi2wnjJ1gP8AEbyHvmF8B3ve7xUsKlaZ9yi5FyWJlENlCor1YXqIiGB95EQ1ipF516qI2BTkz2KPLBVot3kone/Ya6eFEqjsZDGUdxYzCKi5y3DLD7AiC9TeTL0bvKHykHkUeprJAzdaoDntDJLQiuLHg+YCQmLTGbAh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542219; c=relaxed/simple;
	bh=zeyIaR9edrmiE5mavmT4vEyH+yMm08zBSJqNl4k90TQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NerSX8wNyh4ALMMCrvEEFSKvXll8b3m1iRdoRu5vxx2Hz7iQUxiUQKjG8/2dPMEnuWimyTAvYzVKevlvIB/YZXkAuXjllsFGWEuC+y5Vl9CPbHmTe8cqErME2FAn/VCHDx6xCeQU682ADPJwqmaI6wJK3xHJyx4FSa8VWjlk0jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NOmSOpTK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i1vc86Um; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lChjraYIgUe7EnHTCDjD0FUHyL+3hOUgicMoY+ziLwo=;
	b=NOmSOpTKaLd7tJ9jbNZKFi1QRR+x7ATCNrJcbJO23P/zrJhJCS6k6KA1iyxOpOaIm1TKkG
	97Bz9ZX8EUygKHIauC9CRtLw29OAadZQ+hLgsw2TvrnlgsEjICigCpkisCZ9LdJeN6zXBR
	m4Sv0JtZ2YZr5fNC/FG4qtkQsH4HFq7lOPqulwkw42xpRBCnMWZ/hvOPAfqnMNqgfrDGPz
	LmEMfvtLesourOdY7FQaq2Tjgg7B/4Ehm0uZDDieb/h/TT1wuK0Wk6NYaPw8Qixd0++bUK
	bX6Kx7wEuI/Ktqfw77bSxFOLOb0dLfuP7lH8j6IQbwkNDQKUKqQDAleVp6D11A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lChjraYIgUe7EnHTCDjD0FUHyL+3hOUgicMoY+ziLwo=;
	b=i1vc86UmTcVwNaViLZoI9LjknaUs8lV4E+8wl9tav3iCplGYLzoyHJ1H2qU1zouFA9+N3Q
	WAWdu0MThkO+DJDQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Access rng data from kernel without vvar
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-13-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-13-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054221269.3137.16548319497100022693.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     a91ed80e570892b0df6702e8664e89ff8a6964b1
Gitweb:        https://git.kernel.org/tip/a91ed80e570892b0df6702e8664e89ff8a6=
964b1
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:14 +01:00

x86/vdso: Access rng data from kernel without vvar

Remove the usage of the vvar _vdso_rng_data from the kernel-space code,
as the x86 vvar machinery is about to be removed.
The definition of the structure is unnecessary, as the data lives in a
page pre-allocated by the linker anyways.
The vdso user-space access to the rng data will be switched soon.

DEFINE_VVAR_SINGLE() is now unused. It will be removed later togehter
with the rest of vvar.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-13-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vma.c            | 1 -
 arch/x86/include/asm/vdso/vsyscall.h | 2 +-
 arch/x86/include/asm/vvar.h          | 4 +++-
 3 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index b8fed8b..8437906 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -39,7 +39,6 @@ struct vdso_data *arch_get_vdso_data(void *vvar_page)
 #undef EMIT_VVAR
=20
 DEFINE_VVAR(struct vdso_data, _vdso_data);
-DEFINE_VVAR_SINGLE(struct vdso_rng_data, _vdso_rng_data);
=20
 unsigned int vclocks_used __read_mostly;
=20
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index a1f916b..ce8d5c8 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -21,7 +21,7 @@ struct vdso_data *__x86_get_k_vdso_data(void)
 static __always_inline
 struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
 {
-	return &_vdso_rng_data;
+	return (void *)&__vvar_page + __VDSO_RND_DATA_OFFSET;
 }
 #define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
=20
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index 01e60e0..fe3434d 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,6 +19,8 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
=20
+#define __VDSO_RND_DATA_OFFSET  640
+
 #ifdef EMIT_VVAR
 /*
  * EMIT_VVAR() is used by the kernel linker script to put vvars in the
@@ -62,7 +64,7 @@ DECLARE_VVAR(0, struct vdso_data, _vdso_data)
=20
 #if !defined(_SINGLE_DATA)
 #define _SINGLE_DATA
-DECLARE_VVAR_SINGLE(640, struct vdso_rng_data, _vdso_rng_data)
+DECLARE_VVAR_SINGLE(__VDSO_RND_DATA_OFFSET, struct vdso_rng_data, _vdso_rng_=
data)
 #endif
=20
 #undef DECLARE_VVAR

