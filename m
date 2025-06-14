Return-Path: <linux-tip-commits+bounces-5847-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7323EAD9EDB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 20:12:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C063AE8D3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Jun 2025 18:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958F22E88BF;
	Sat, 14 Jun 2025 18:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lx++csVn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tf2EFyK3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02EE2E8893;
	Sat, 14 Jun 2025 18:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749924630; cv=none; b=WfIUzbtmRp+IGN/miVlMB7KFOvDd3gZol9B/cO3K+cBeK83EvRVSxIEPunuANfuX+pL6XMpS2QrxQq7GX+AVpRQmmncAksA+CPQ2XopGijW4dc6nejEQBbmDx6UH2kisHYjxN6TpgaEidxYGJ3Aeq3s3o2frnYk1XaqMMZk5gC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749924630; c=relaxed/simple;
	bh=TVsXtgMLh/M3YQnXCjrANL11tbtfvBnz2H2jBF3ZVOs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WnMnRB/FWBRgsZnVRTN4h9aUVQREMymeRuNRpZoivPBt24Ul7LCdfmyDqtevhpRsJwRLsqE7y5pU4A+m15/Rc5L9tuP/EBvIi3p5GH3KG3gczHEReAV6M0SQCqVTlabUmegPCsaDI0pcFAzlLGJuMIUW8cl7ieRV3Q1VjjgA4ZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lx++csVn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tf2EFyK3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Jun 2025 07:31:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749924626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mCcvBLO8NZIUwlT85SzTab0A/b1GootPrFseVJXDHw=;
	b=Lx++csVnvMRCAw9iJgFNeWpD951qEjk54A+wtfxkKbP9NM0eYht8/7q86LZVdlz77vyCTa
	Xw0MGnTtrHLp1XLgq3HW8UITaoyHV46d9U5K3NyI/awBmyhLRd/A0OfwNBi8k6C5XE4tiW
	hNQgr9YUOxfjQW0UKcgRWgt5iZVeqH8K9fsE8Xx/23Lkh3vc0r83p9mve5iHaQI1eLqpqr
	9uXN6uACVg226YILiWy+i2oMx+mimJ8owsvGoy2+blUHzgZfHDXDriDZC6VFomZXIkthPi
	FTcd5LL2hpzuAzzXspGH2j7FDa/+m2LuIBbq+HcCVi1D8RZzH+tbyjQzZz5A7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749924626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2mCcvBLO8NZIUwlT85SzTab0A/b1GootPrFseVJXDHw=;
	b=tf2EFyK3H1cUdu6Ii/6vW6Xes2ZywrIiVbdzptub0NmFdVt37ktt8ckKIokecvoGXG5pr/
	KYAZ4OIihTCMCxCw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/kconfig] x86/kconfig/defconfig: Enable CONFIG_DRM_FBDEV_EMULATION=y
Cc: Michael Kelley <mhklinux@outlook.com>, Ingo Molnar <mingo@kernel.org>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ard Biesheuvel <ardb@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 David Woodhouse <dwmw@amazon.co.uk>, "H. Peter Anvin" <hpa@zytor.com>,
 jgross@suse.com, Linus Torvalds <torvalds@linux-foundation.org>,
 Masahiro Yamada <yamada.masahiro@socionext.com>,
 Michal Marek <michal.lkml@markovi.net>, linux-kernel@vger.kernel.org,
 x86@kernel.org
In-Reply-To: =?utf-8?q?=3CSN6PR02MB4157B1676A6284ECD21E494FD490A=40SN6PR02MB?=
 =?utf-8?q?4157=2Enamprd02=2Eprod=2Eoutlook=2Ecom?= # Discussion>
References: =?utf-8?q?=3CSN6PR02MB4157B1676A6284ECD21E494FD490A=40SN6PR02M?=
 =?utf-8?q?B4157=2Enamprd02=2Eprod=2Eoutlook=2Ecom?= # Discussion>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174988630189.406.15753586837783578672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/kconfig branch of tip:

Commit-ID:     860a6f26921a56a469e03a0f74d992ee217192df
Gitweb:        https://git.kernel.org/tip/860a6f26921a56a469e03a0f74d992ee217=
192df
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 14 Jun 2025 09:10:55 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 14 Jun 2025 09:24:35 +02:00

x86/kconfig/defconfig: Enable CONFIG_DRM_FBDEV_EMULATION=3Dy

Michael Kelley reported that the x86 defconfig *almost* works
well on Hyper-V guests out of box, with the exception of
console support:

 > I built and tested a Hyper-V guest with defconfig. The Hyper-V storage
 > and keyboard drivers are pulled in automatically. [...]
 >
 > But the Linux console for each Hyper-V guest is a synthetic graphics
 > console, and that didn't work with the DRM_HYPERV driver. Missing
 > the console pretty much kills any usefulness. DRM doesn't have
 > Linux console support, so it needs CONFIG_DRM_FBDEV_EMULATION
 > to be set, and defconfig doesn't have it.

So enable CONFIG_DRM_FBDEV_EMULATION.

Also enable the dependent CONFIG_FRAMEBUFFER_CONSOLE_ROTATION option
(disabled by default), as all major Linux distros have it enabled,
probably as an sysadmin quality-of-life option:

	.config.distro.debian.x86_32:     CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
	.config.distro.fedora.generic:    CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
	.config.distro.opensuse.default:  CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
	.config.distro.rhel.generic:      CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
	.config.distro.ubuntu:            CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy

There's no measurable build time impact within ~1% stddev:

  # before:         33.759 +- 0.286 seconds time elapsed  ( +-  0.85% )
  # after:          33.593 +- 0.314 seconds time elapsed  ( +-  0.94% )

Suggested-by: Michael Kelley <mhklinux@outlook.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: David Woodhouse <dwmw@amazon.co.uk>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: J=C3=BCrgen Gro=C3=9F <jgross@suse.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Michal Marek <michal.lkml@markovi.net>
Cc: linux-kernel@vger.kernel.org
Link: https://lore.kernel.org/r/SN6PR02MB4157B1676A6284ECD21E494FD490A@SN6PR0=
2MB4157.namprd02.prod.outlook.com # Discussion
---
 arch/x86/configs/i386_defconfig   | 2 ++
 arch/x86/configs/x86_64_defconfig | 3 +++
 2 files changed, 5 insertions(+)

diff --git a/arch/x86/configs/i386_defconfig b/arch/x86/configs/i386_defconfig
index aeba958..39a660d 100644
--- a/arch/x86/configs/i386_defconfig
+++ b/arch/x86/configs/i386_defconfig
@@ -239,8 +239,10 @@ CONFIG_AGP=3Dy
 CONFIG_AGP_AMD64=3Dy
 CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
+CONFIG_DRM_FBDEV_EMULATION=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_DRM_HYPERV=3Dy
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
 CONFIG_SOUND=3Dy
 CONFIG_SND=3Dy
 CONFIG_SND_HRTIMER=3Dy
diff --git a/arch/x86/configs/x86_64_defconfig b/arch/x86/configs/x86_64_defc=
onfig
index c20100d..b5dc26f 100644
--- a/arch/x86/configs/x86_64_defconfig
+++ b/arch/x86/configs/x86_64_defconfig
@@ -116,6 +116,7 @@ CONFIG_ANON_VMA_NAME=3Dy
 CONFIG_USERFAULTFD=3Dy
 CONFIG_LRU_GEN=3Dy
 CONFIG_LRU_GEN_ENABLED=3Dy
+# CONFIG_DAMON is not set
 CONFIG_NET=3Dy
 CONFIG_PACKET=3Dy
 CONFIG_XFRM_USER=3Dy
@@ -248,8 +249,10 @@ CONFIG_AGP=3Dy
 CONFIG_AGP_AMD64=3Dy
 CONFIG_AGP_INTEL=3Dy
 CONFIG_DRM=3Dy
+CONFIG_DRM_FBDEV_EMULATION=3Dy
 CONFIG_DRM_VIRTIO_GPU=3Dy
 CONFIG_DRM_HYPERV=3Dy
+CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
 CONFIG_SOUND=3Dy
 CONFIG_SND=3Dy
 CONFIG_SND_HRTIMER=3Dy

