Return-Path: <linux-tip-commits+bounces-4090-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BEE2A57ACA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:56:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 952AD16BBB0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B196C1FC0E3;
	Sat,  8 Mar 2025 13:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rj6MsDal";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wmA2Xj8H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E41E832D;
	Sat,  8 Mar 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441509; cv=none; b=PqJ1sy3Sins+CK3vqAn3R2XKLkAxq2BT2XBbOi0C8WP1lTyqf30NyLD7r3uq+IP1yGLWClxR7ED2pG6a9wwSkUpwXGFptv/8+FUohHFVa+2fwMdEaIA2zVRghd866DwtZPyKPYHiLJLG950qWDXdUHPqukdmERQo47/F1vgVSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441509; c=relaxed/simple;
	bh=syeurhr32aruv2Jl52eslCKwe0pgyczLqP8fT8mV0po=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=elZwTrrPUJ91SBE5butRYQl9t91V3odkcAcF3nZhOUXcZvBPvMLlfFfM89+q5YbCKfKGAT8kt/16mV2pbsZyoWPeNEn+b8JI1J3VpLLs05jbCfHBflbpPXlYbLuuSuELMSOXQGX7pu6YqD/4OdRtdOPG1f58GFHTCXGA0+Cfc6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rj6MsDal; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wmA2Xj8H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxO25XUCGnE8DKA/8sSgYHJ4Q2AjITR5L/EkP2HhzRM=;
	b=rj6MsDalPSXGROiBiT8IUAbOKXKSr1f0hHdrVWqGFU/NzYeGpGjAD2YM9SZ/KvEfiK105i
	E+wxz1vTHh61OFrCxZEHnnyZKpb9A8sTYCgAuS16M633DSNAVpb4Bz1Q+9BzyofexWCwy1
	Uk+KZk85xbAYg/wLWMm8BiaATp4cY6YTUdaRzmNxyS7/qWfaijMJ+vxuHHqiOptSH2RmcE
	k3PezxV4N2ZqFs7bAauY3gjezFe1/ZlXSKNdIPubsdmwIjnJIjOLfYQl7jurnVYvY5kSlj
	lelYwJL4afdHJCW2dFy2XdltTC8YZViG5yHCtaVqFw+p1qTEQpaik/HILYjjIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441505;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bxO25XUCGnE8DKA/8sSgYHJ4Q2AjITR5L/EkP2HhzRM=;
	b=wmA2Xj8Hbx4cUM/z2g/Xh+lT2+JqlW9yyH1US5BaIpK6PicRyx9zvpjzFyyXV0oU2gbZ5l
	I/XUO4g4A8KWPFAg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] arm64: Make asm/cache.h compatible with vDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-2-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-2-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150526.14745.1686118958467952818.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     b69b47a6b5f67ac1074e0a6baac7f07bdc3dceed
Gitweb:        https://git.kernel.org/tip/b69b47a6b5f67ac1074e0a6baac7f07bdc3=
dceed
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:39 +01:00

arm64: Make asm/cache.h compatible with vDSO

asm/cache.h can be used during the vDSO build through vdso/cache.h.
Not all definitions in it are compatible with the vDSO, especially the
compat vDSO.

Hide the more complex definitions from the vDSO build.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-2-c1b5c69a166f@linut=
ronix.de

---
 arch/arm64/include/asm/cache.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/cache.h b/arch/arm64/include/asm/cache.h
index 06a4670..99cd654 100644
--- a/arch/arm64/include/asm/cache.h
+++ b/arch/arm64/include/asm/cache.h
@@ -35,7 +35,7 @@
 #define ARCH_DMA_MINALIGN	(128)
 #define ARCH_KMALLOC_MINALIGN	(8)
=20
-#ifndef __ASSEMBLY__
+#if !defined(__ASSEMBLY__) && !defined(BUILD_VDSO)
=20
 #include <linux/bitops.h>
 #include <linux/kasan-enabled.h>
@@ -118,6 +118,6 @@ static inline u32 __attribute_const__ read_cpuid_effectiv=
e_cachetype(void)
 	return ctr;
 }
=20
-#endif	/* __ASSEMBLY__ */
+#endif /* !defined(__ASSEMBLY__) && !defined(BUILD_VDSO) */
=20
 #endif

