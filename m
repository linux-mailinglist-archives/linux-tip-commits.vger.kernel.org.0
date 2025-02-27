Return-Path: <linux-tip-commits+bounces-3704-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BFBBA47A8A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 11:42:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35FF03B178D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 10:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A58ED22A80B;
	Thu, 27 Feb 2025 10:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hAspTydZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZbD22b2O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 835E2227EBF;
	Thu, 27 Feb 2025 10:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740652936; cv=none; b=idrBC98ZsK/68zYxRZNbRkhfMcC+YyaviYaxTeeNpbyuBjVp6I/LDHZIBeONydaSSgBjDq3NdqGGSo2AdKy1GZXGmiD8izgARGlctIFd6uzsWdtBYunXxItwxKtvvt3U6vvjWKOBysZXW/0RVEw0suZst3CG8TeAeQn+NsRyApE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740652936; c=relaxed/simple;
	bh=vifOECyumKzNn0344YceHp3ga6qjJykneirBe7VAug0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=JYZ+IHwYzwxwq+OKBzIr+AXqLZM9cjZhxfGMmX7+9lMiFKsDzZZr1N9q6383BEVYtzpm4WA//jy/PPWKQ9SsRYWpCPk/wrnjOTB/G/h2r2n0/EV70EcGfElRRPr69ukKdPT2dNG3Zd7o0uCgsitjyngg509AeXMrif/0wc1Jk7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hAspTydZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZbD22b2O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 10:42:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740652931;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgn1n1sfeOAH2DkruypZgQjMWbuQzoUn8QS+pQ/btKM=;
	b=hAspTydZgSrUKoXBNqoDoaAQln6tX2nBKEYB/ZLvo7qR0IHAYMllgefFacRZcJJ6qvDdzr
	pEEmObXyzMjy+xYDAYuNNVJGjFyCbf82cBnKzuoHz0uzKWCXDetxtvWkQGhvkGig8B4I3j
	d9pSIMw3Cg32BvVs5uLlwd3Y0vJfY7TysRkB6IBzApiWRDGD/rwFyoR5EPgaPib1QT5zI6
	mcaJOU+q4wNI4tepImppe5/9mZOoUF3tFtseO+3WOYeaOD1sNr1MKpoLWo3ToSPZkfk8mJ
	CFjw4hAl3ETU1nDcoZrEtFFiuBZHd/BMNEKYPb1JxBLw3KA55ffMFbQGmptj7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740652931;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hgn1n1sfeOAH2DkruypZgQjMWbuQzoUn8QS+pQ/btKM=;
	b=ZbD22b2OIeRZs7lVhxF6DwTshNKvKjP84rkyJTyG+Q5q6QPb6ypT9WNugjjWtJ4XXD8P54
	XSRpSQVRU4VY15BQ==
From: "tip-bot2 for Arnd Bergmann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/cpu: Document CONFIG_X86_INTEL_MID as 64-bit-only
Cc: Arnd Bergmann <arnd@arndb.de>, Ingo Molnar <mingo@kernel.org>,
 Andy Shevchenko <andy@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226213714.4040853-9-arnd@kernel.org>
References: <20250226213714.4040853-9-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174065293024.10177.14667547423310651198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     ca5955dd5f08727605723b60767fbf2cc3d54046
Gitweb:        https://git.kernel.org/tip/ca5955dd5f08727605723b60767fbf2cc3d54046
Author:        Arnd Bergmann <arnd@arndb.de>
AuthorDate:    Wed, 26 Feb 2025 22:37:12 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 11:22:07 +01:00

x86/cpu: Document CONFIG_X86_INTEL_MID as 64-bit-only

The X86_INTEL_MID code was originally introduced for the 32-bit
Moorestown/Medfield/Clovertrail platform, later the 64-bit
Merrifield/Moorefield variants were added, but the final Morganfield
14nm platform was canceled before it hit the market.

To help users understand what the option actually refers to, update the
help text, and add a dependency on 64-bit kernels.

Ferry confirmed that all the hardware can run 64-bit kernels these days,
but is still testing 32-bit kernels on the Intel Edison board, so this
remains possible, but is guarded by a CONFIG_EXPERT dependency now,
to gently push remaining users towards using CONFIG_64BIT.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Andy Shevchenko <andy@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20250226213714.4040853-9-arnd@kernel.org
---
 arch/x86/Kconfig | 50 +++++++++++++++++++++++++++--------------------
 1 file changed, 29 insertions(+), 21 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 73eeaf2..acd4d73 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -549,12 +549,12 @@ config X86_EXTENDED_PLATFORM
 		RDC R-321x SoC
 		SGI 320/540 (Visual Workstation)
 		STA2X11-based (e.g. Northville)
-		Moorestown MID devices
 
 	  64-bit platforms (CONFIG_64BIT=y):
 		Numascale NumaChip
 		ScaleMP vSMP
 		SGI Ultraviolet
+		Merrifield/Moorefield MID devices
 
 	  If you have one of these systems, or if you want to build a
 	  generic distribution kernel, say Y here - otherwise say N.
@@ -599,8 +599,31 @@ config X86_UV
 	  This option is needed in order to support SGI Ultraviolet systems.
 	  If you don't have one of these, you should say N here.
 
-# Following is an alphabetically sorted list of 32 bit extended platforms
-# Please maintain the alphabetic order if and when there are additions
+config X86_INTEL_MID
+	bool "Intel Z34xx/Z35xx MID platform support"
+	depends on X86_EXTENDED_PLATFORM
+	depends on X86_PLATFORM_DEVICES
+	depends on PCI
+	depends on X86_64 || (EXPERT && PCI_GOANY)
+	depends on X86_IO_APIC
+	select I2C
+	select DW_APB_TIMER
+	select INTEL_SCU_PCI
+	help
+	  Select to build a kernel capable of supporting 64-bit Intel MID
+	  (Mobile Internet Device) platform systems which do not have
+	  the PCI legacy interfaces.
+
+	  The only supported devices are the 22nm Merrified (Z34xx)
+	  and Moorefield (Z35xx) SoC used in the Intel Edison board and
+	  a small number of Android devices such as the Asus Zenfone 2,
+	  Asus FonePad 8 and Dell Venue 7.
+
+	  If you are building for a PC class system or non-MID tablet
+	  SoCs like Bay Trail (Z36xx/Z37xx), say N here.
+
+	  Intel MID platforms are based on an Intel processor and chipset which
+	  consume less power than most of the x86 derivatives.
 
 config X86_GOLDFISH
 	bool "Goldfish (Virtual Platform)"
@@ -610,6 +633,9 @@ config X86_GOLDFISH
 	  for Android development. Unless you are building for the Android
 	  Goldfish emulator say N here.
 
+# Following is an alphabetically sorted list of 32 bit extended platforms
+# Please maintain the alphabetic order if and when there are additions
+
 config X86_INTEL_CE
 	bool "CE4100 TV platform"
 	depends on PCI
@@ -625,24 +651,6 @@ config X86_INTEL_CE
 	  This option compiles in support for the CE4100 SOC for settop
 	  boxes and media devices.
 
-config X86_INTEL_MID
-	bool "Intel MID platform support"
-	depends on X86_EXTENDED_PLATFORM
-	depends on X86_PLATFORM_DEVICES
-	depends on PCI
-	depends on X86_64 || (PCI_GOANY && X86_32)
-	depends on X86_IO_APIC
-	select I2C
-	select DW_APB_TIMER
-	select INTEL_SCU_PCI
-	help
-	  Select to build a kernel capable of supporting Intel MID (Mobile
-	  Internet Device) platform systems which do not have the PCI legacy
-	  interfaces. If you are building for a PC class system say N here.
-
-	  Intel MID platforms are based on an Intel processor and chipset which
-	  consume less power than most of the x86 derivatives.
-
 config X86_INTEL_QUARK
 	bool "Intel Quark platform support"
 	depends on X86_32

