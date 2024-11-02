Return-Path: <linux-tip-commits+bounces-2706-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5569B9E9F
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:11:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0221F1F23506
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71290189BA3;
	Sat,  2 Nov 2024 10:10:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2Vum7r35";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PCrTSIId"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9757117334E;
	Sat,  2 Nov 2024 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542218; cv=none; b=VM2m+0DXM3qJbxpW/wM5eLqncsimogfshKuKCQNcv8lKgFaHsd/qQSl483BEj96AL05I9LmHDBZeJ25GGp3rvH12iT/ASdabZcimfZQXQykt/akaXcv0YcE3RhdOMBSTzZI66LAJaavga5qD8hHXubm/E3pj19R4gNrJpojt0qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542218; c=relaxed/simple;
	bh=Z0r5mDS1O8cG8wLPF0r7UvrJTOl9RttXFuuwDbxHSm0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d5WDRFlkrJprF7uzJGvp9hbhJFar4sWarnh7v4TjKxL+HBn6tlZmsfmLaVev9cseU2eIAnNWHDNXmZiCKXo4fxlailTRUXBT0ehcXJtu7/890PMulLlOhy7TsfFfEzR5zk/lbNu5r58ZGSl3JUM49+TeA3Zg2Q6QVJprIe5ybiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2Vum7r35; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PCrTSIId; arc=none smtp.client-ip=193.142.43.55
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
	bh=WDLqgrs4ye60av10Q9G3h7kLjXcmGZ4n1Uqy89vlvlo=;
	b=2Vum7r35wBS4+hWozpp6RPp7TJUczbxjheQyk4mCQwWSbIt+PVAiPWDyzIrxyBAtFTDCrh
	Zrzz8JjLpX/gmpNIA80t6zMLhw9i69XCKphA1oaf4s9369/iRmRmih4VuFZ1v2Q8KRsYDg
	qu3T4dXBIRgAepqmUKPZNpR2ARRvt9hErKXlGWLqw55OQveZQ/I/TAB2hbs9cf5bq5kOhG
	dS0FFlUualE/U7CN/09QP8Gw+V3EVgA4d78YrfVCIudSTJ3Hh8XHSH0o+uCDgrGjUuXQ+C
	xQ9TrU2CAg5kM/CVA+s+KXorSzPgMuJZDVeubpamcvwoU4eVl2LMu0hEGc8LZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542209;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WDLqgrs4ye60av10Q9G3h7kLjXcmGZ4n1Uqy89vlvlo=;
	b=PCrTSIIdLwYj2MXmsKm0Py/EeJs/012PHN9V+z5oIq0QBPBaOkRRZeMgGh313pTgk0sWrx
	FCZQcOC2qLe7ClBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Delete vvar.h
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-19-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-19-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220820.3137.14790734515673146742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9c2632421d563e51fcddc47cf56c966f6dc6c4bd
Gitweb:        https://git.kernel.org/tip/9c2632421d563e51fcddc47cf56c966f6dc=
6c4bd
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:15 +01:00

x86/vdso: Delete vvar.h

All users have been removed.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-19-b64f0842d5=
12@linutronix.de

---
 arch/x86/include/asm/vvar.h | 66 +------------------------------------
 1 file changed, 66 deletions(-)
 delete mode 100644 arch/x86/include/asm/vvar.h

diff --git a/arch/x86/include/asm/vvar.h b/arch/x86/include/asm/vvar.h
deleted file mode 100644
index d95cf92..0000000
--- a/arch/x86/include/asm/vvar.h
+++ /dev/null
@@ -1,66 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * vvar.h: Shared vDSO/kernel variable declarations
- * Copyright (c) 2011 Andy Lutomirski
- *
- * A handful of variables are accessible (read-only) from userspace
- * code in the vsyscall page and the vdso.  They are declared here.
- * Some other file must define them with DEFINE_VVAR.
- *
- * In normal kernel code, they are used like any other variable.
- * In user code, they are accessed through the VVAR macro.
- *
- * These variables live in a page of kernel data that has an extra RO
- * mapping for userspace.  Each variable needs a unique offset within
- * that page; specify that offset with the DECLARE_VVAR macro.  (If
- * you mess up, the linker will catch it.)
- */
-
-#ifndef _ASM_X86_VVAR_H
-#define _ASM_X86_VVAR_H
-
-#ifdef EMIT_VVAR
-/*
- * EMIT_VVAR() is used by the kernel linker script to put vvars in the
- * right place. Also, it's used by kernel code to import offsets values.
- */
-#define DECLARE_VVAR(offset, type, name) \
-	EMIT_VVAR(name, offset)
-#define DECLARE_VVAR_SINGLE(offset, type, name) \
-	EMIT_VVAR(name, offset)
-
-#else
-
-extern char __vvar_page;
-
-#define DECLARE_VVAR(offset, type, name)				\
-	extern type vvar_ ## name[CS_BASES]				\
-	__attribute__((visibility("hidden")));				\
-	extern type timens_ ## name[CS_BASES]				\
-	__attribute__((visibility("hidden")));				\
-
-#define DECLARE_VVAR_SINGLE(offset, type, name)				\
-	extern type vvar_ ## name					\
-	__attribute__((visibility("hidden")));				\
-
-#define VVAR(name) (vvar_ ## name)
-#define TIMENS(name) (timens_ ## name)
-
-#define DEFINE_VVAR(type, name)						\
-	type name[CS_BASES]						\
-	__attribute__((section(".vvar_" #name), aligned(16))) __visible
-
-#define DEFINE_VVAR_SINGLE(type, name)					\
-	type name							\
-	__attribute__((section(".vvar_" #name), aligned(16))) __visible
-
-#endif
-
-/* DECLARE_VVAR(offset, type, name) */
-
-DECLARE_VVAR(0, struct vdso_data, _vdso_data)
-
-#undef DECLARE_VVAR
-#undef DECLARE_VVAR_SINGLE
-
-#endif

