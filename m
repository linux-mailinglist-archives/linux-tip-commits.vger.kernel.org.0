Return-Path: <linux-tip-commits+bounces-2733-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 840759B9FA5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:52:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CB451F22047
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAFF217DFF5;
	Sat,  2 Nov 2024 11:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wHRtrpfq";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/LKdRpyI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0450219DF7A;
	Sat,  2 Nov 2024 11:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548223; cv=none; b=jF6CxVn+KCFxptMlr3idyk+6QGULlFbZnTxA12FevXTW98Xy8bhDwFSVAjr20ohd93LJwFxLoTHYZcMEOw1HmuzbCDZj5ZaIGk8j2155rjuKcgfNBIXsPKARqckAxIwyuc1IwTVCG29AbOY02VGQ6Hd0cnNfu02DAauwEyW72l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548223; c=relaxed/simple;
	bh=YwGBDAZ3SZrdSGj6qApKtVXyEWP5VQrYg/Ocwnus36A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cg1znOtvo81dIHkf9aEeo4Vhh+PDKi98oR8eLArvTVV+OIIzy/5qj1elxLJiYOaTkJ5nrdZfvXPeeyuZsvGDbifAv7IBg41X7MpLSboy+PIQDgmnGYs3IfHbmD/A6d0oW4ODZ4Y/mmPyIBoCU/I6hoe3//lOP7hTycQiYoKTf+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wHRtrpfq; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/LKdRpyI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hx+zEPlC5Df5sTdoz0bFOCE6lc0UJ1ePJDBcXz0Jx4M=;
	b=wHRtrpfqbOQn5GU96I/jMkDKzQZJKtBW4bQnIXomRDtt+rk2gSmZSdNcDbzG2WPW77LF0H
	u9HEtb+LejqEjUB6vQaHCaD23XlfLNyl4nO43q4tRvGyfmvBjgTzI0jXYIpNXJmvYsiueM
	jFA5L+3vAfLW1fM3OXVz4jjBlzeAwze28xr2EMvzEE0JjSHwz72HpgtEvBhGhPJ8wL3hFH
	lYrdDo5+E1v6M65BKMiA8IFeYSrbbCsPe39+LQsuSsdv41ych+4TVJP12bqnD0lgpQRnNG
	ocp8/kk5UN1zHhKTY9K5TPvuB1OU/VGIxNNBxwz4mK4cKs2ZMoR5baolzFlOVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hx+zEPlC5Df5sTdoz0bFOCE6lc0UJ1ePJDBcXz0Jx4M=;
	b=/LKdRpyI3FwaAyNeIKW0e7frbxm5IX9Wo9cftDSqQLmVd1OjdnK1HsUqZ+phw7QI1h6Cqz
	aJWdLd6dsUeF/JAw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Move the rng offset to vsyscall.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-17-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-17-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054821953.3137.10202197621191126796.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     75ceb49add376f3a37e96a278bdedc029afd0716
Gitweb:        https://git.kernel.org/tip/75ceb49add376f3a37e96a278bdedc029af=
d0716
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:34 +01:00

x86/vdso: Move the rng offset to vsyscall.h

vvar.h will go away, so move the last useful bit into vsyscall.h.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-17-b64f0842d5=
12@linutronix.de

---
 arch/x86/entry/vdso/vdso-layout.lds.S | 1 +
 arch/x86/include/asm/vdso/vsyscall.h  | 3 ++-
 arch/x86/include/asm/vvar.h           | 2 --
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index acce607..c7e194b 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,5 +1,6 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
+#include <asm/vdso/vsyscall.h>
=20
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index aac7d2b..6a933f0 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,11 +2,12 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
+#define __VDSO_RND_DATA_OFFSET  640
+
 #ifndef __ASSEMBLY__
=20
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
-#include <asm/vvar.h>
=20
 extern struct vdso_data *vdso_data;
=20
diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
index b605914..d95cf92 100644
--- a/arch/x86/include/asm/vvar.h
+++ b/arch/x86/include/asm/vvar.h
@@ -19,8 +19,6 @@
 #ifndef _ASM_X86_VVAR_H
 #define _ASM_X86_VVAR_H
=20
-#define __VDSO_RND_DATA_OFFSET  640
-
 #ifdef EMIT_VVAR
 /*
  * EMIT_VVAR() is used by the kernel linker script to put vvars in the

