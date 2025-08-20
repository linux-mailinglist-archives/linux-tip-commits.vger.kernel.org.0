Return-Path: <linux-tip-commits+bounces-6301-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 00E8CB2E2C5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 18:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AEAC165C9F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Aug 2025 16:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1934E32778E;
	Wed, 20 Aug 2025 16:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tp3rSuev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SPoWI5mm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86A7C57C9F;
	Wed, 20 Aug 2025 16:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755709101; cv=none; b=qy8IQoBcXWOiPrq4Bt++k9Q5e+73IvmTnDQmas7TMPORbYmho3PZiEwTx/F+Eqmn/+sYUU9HpZL/UgAJM5MgYR7K4ySyglDRt1u5RqGoGV6onL8SSpY208vfMSU7nlXomuv0gDeMJaDrXxloMkDvvSwYWVuX7BttJZ8q4Ahzu7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755709101; c=relaxed/simple;
	bh=zFit5RnosLTRx8J5sxAPztAFATI0JhtRZhWuAE2Kmxg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fi5q4nvrxqG7Ji85zH5f3xhPw3gMHSrt+eem7s39kJmlml1hpMZBT0dEj1fFW6I5j4HVONPvaZPfe3yl6OipMBSamxMwscX7fjcbFWnwJGVkrFoXm5JYKgOsRrRtebigIm5JZfMAtAaOTFtFRcPNpCO9VhRurxdPatHg+Uhf0Lo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tp3rSuev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SPoWI5mm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 20 Aug 2025 16:58:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755709097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXtuvnYgySowG7Wg0s3LkLu/Mt9yJWpNfUfy0OEXynM=;
	b=Tp3rSuev+ZxIhJOU6ssdOEXSesIYLIe72y+Hz6Qm41VNUhgpPmpcxa7JQGXdH7Yx57aSUq
	AEEuVSKcQ3vTl4sUiRNHojHafd0MFwYXv1UBY76XR2SitvodQRpKvcHD50IcCzcCIzPJaW
	ax5J5spiMe8aH9m4vvNdzduCDCfuVo/ntHiiZS3GXd5C5g7UeJnpejTBUmRFzeoCSJ9e0u
	iisTnY9nJPh5Mn6fl+Y/Kes7K9RRcDmBLFlD7pTOHPFH7/lqSsdLvJp+fz9L4dS4UXC066
	fylOva0p9/Et8RP02ORiGP3nLdHEE3Zj+HuGuHnLNti5zKI7+4hzim+i0lFaYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755709097;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nXtuvnYgySowG7Wg0s3LkLu/Mt9yJWpNfUfy0OEXynM=;
	b=SPoWI5mm5Jhtt5TSooGCCotrOrA10gRHzQLWTnANs900mP747vbARppCcXASHup0TlxjvI
	mrd9ZielIvAUscAg==
From: "tip-bot2 for Lukas Bulwahn" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cleanups] x86/kconfig: Drop unused and needless config X86_64_SMP
Cc: Lukas Bulwahn <lukas.bulwahn@redhat.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250723071211.622802-1-lukas.bulwahn@redhat.com>
References: <20250723071211.622802-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175570909600.1420.10792869791326478252.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     03777dbd8c9d825fc6f792e4e85be9e4ce4c7f8f
Gitweb:        https://git.kernel.org/tip/03777dbd8c9d825fc6f792e4e85be9e4ce4=
c7f8f
Author:        Lukas Bulwahn <lukas.bulwahn@redhat.com>
AuthorDate:    Wed, 23 Jul 2025 09:12:11 +02:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 20 Aug 2025 18:34:56 +02:00

x86/kconfig: Drop unused and needless config X86_64_SMP

As part of

  38a4968b3190 ("x86/percpu/64: Remove INIT_PER_CPU macros"),

the only use of the config option X86_64_SMP in the kernel tree is removed. As
this config option X86_64_SMP is just equivalent to X86_64 && SMP, the source
code in the tree just uses that expression in the few places where needed. No=
te
further that this option cannot be explicitly enabled or disabled when
configuring the kernel build configuration.

Drop this needless and unused config option. No functional change.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/20250723071211.622802-1-lukas.bulwahn@redhat.com
---
 arch/x86/Kconfig | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..2eb3bb6 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -410,10 +410,6 @@ config HAVE_INTEL_TXT
 	def_bool y
 	depends on INTEL_IOMMU && ACPI
=20
-config X86_64_SMP
-	def_bool y
-	depends on X86_64 && SMP
-
 config ARCH_SUPPORTS_UPROBES
 	def_bool y
=20

