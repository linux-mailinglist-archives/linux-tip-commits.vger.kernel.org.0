Return-Path: <linux-tip-commits+bounces-6445-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9C9CB43732
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282875A269F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:32:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FB92F8BF8;
	Thu,  4 Sep 2025 09:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G0X+au8c";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Q1ghajR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BEB82F83CF;
	Thu,  4 Sep 2025 09:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978341; cv=none; b=S/FiVgfmiKUT/Nqvq7VsIW8owPVjstrTv3rqV2mY2Y4WzEbbY4xARKiiolZsq9k/bSbngAHjRWR59V9dWPWiP+n5aQgI/AAKIToDxEtid4fSRsSsCUyGlUkEfzT59EGxELRYnLCa7bEHreqh+ASUiuh0gDqHIejO353B/IOhnUc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978341; c=relaxed/simple;
	bh=j9ZWIawIrwUxEo2pkEAZ8GEkTXhrEzNyid5/XIL5vrY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U+klqh8nnwpbdmvyg1KVxXocu1fPZ5k08oOupQ6WvNxHu8LzlVGbBBaIKZ4PhyT+n+TvufUqGK8G/2vjFOxdthZ72Lxi0qvRS652ELVB17f/RAdNUIUdVyVsZEFUycctynLuetr6nl5KfPTneAX9QdHMUBFrx8Y414yfGRf04xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G0X+au8c; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Q1ghajR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXU2aOFVPZ8IRKCB+1nH2sYMaVvZsjpGt6AdToPZ7so=;
	b=G0X+au8cBmV9wUKhrCEMxZmDet5zsPCYCmnZuk3mOwK3sgARW2kdT8RI6dEmg6P5oIVc6L
	Uns4HQGZUD1fA5/Oqdn+FDkwlGPxXUWpoDPKgMEk2zQiDx7iCEGbTvzovZMVRsetPwWD67
	hPQ2AE5VXiLtBNgo45Y2IWlczt1Utge/fCz5bq8VqfaD54F/0DHmCgnPZ20xxP8t+A8bfM
	nC9BC+yrJmMBa81/3tLs1CeP/qVFnscr5oiAB1gbege6Iphj8KTHh1er8O5BWp9c4H959n
	FZLkHMp1wGgMoJ5Ce27fUOKnGyMbKSh6H/GUuaY3hgrXaMiYrHojGDIHOIcI6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978338;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXU2aOFVPZ8IRKCB+1nH2sYMaVvZsjpGt6AdToPZ7so=;
	b=1Q1ghajRnXi1yH7tstUc9tU5INFyr2rswfXjeMJAeFykQZJCJ6Z1gWEjXxlbSpzwS8p5dM
	tmLS6xHcv8DDb1DQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Drop kconfig GENERIC_COMPAT_VDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-8-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-8-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697833712.1920.15646710571537809457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bb5bc7bfab06b9a6a2ccecba6dc40783fe9b4231
Gitweb:        https://git.kernel.org/tip/bb5bc7bfab06b9a6a2ccecba6dc40783fe9=
b4231
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:50 +02:00

vdso: Drop kconfig GENERIC_COMPAT_VDSO

This configuration is never used.

Remove it.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-8-d9b65750e49f@li=
nutronix.de

---
 arch/arm64/Kconfig | 1 -
 lib/vdso/Kconfig   | 5 -----
 2 files changed, 6 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfac..5c61b19 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1782,7 +1782,6 @@ config COMPAT_VDSO
 	bool "Enable vDSO for 32-bit applications"
 	depends on !CPU_BIG_ENDIAN
 	depends on (CC_IS_CLANG && LD_IS_LLD) || "$(CROSS_COMPILE_COMPAT)" !=3D ""
-	select GENERIC_COMPAT_VDSO
 	default y
 	help
 	  Place in the process address space of 32-bit applications an
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 76157c2..2594dd7 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -12,11 +12,6 @@ config GENERIC_GETTIMEOFDAY
 	  Each architecture that enables this feature has to
 	  provide the fallback implementation.
=20
-config GENERIC_COMPAT_VDSO
-	bool
-	help
-	  This config option enables the compat VDSO layer.
-
 config GENERIC_VDSO_TIME_NS
 	bool
 	help

