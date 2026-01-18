Return-Path: <linux-tip-commits+bounces-8048-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1354ED393BC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:03:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 116F6300C155
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:03:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 669E12DB783;
	Sun, 18 Jan 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2kpar0E2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="atRNXWeo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8021772A;
	Sun, 18 Jan 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730582; cv=none; b=tehop7+ke3KUdwF5UzlbxCRfiRpLimyTvGMJwSCQgy/0fpK+NqCNRqeCrqfjFDHxSSrp4jmkMZG07pXP+KZhpWp57q+TzRpPVOLHtplX1Y74Udhp8bdkIk9uHw7/f5h/okqxrAcHstjZvoj0rS4MpjLVlMhkfPKO9406QXO5Uls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730582; c=relaxed/simple;
	bh=5FKu8E/eEQg3tecHGXUzShaEmoB86z+3TsHj5b+eBCE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aFUzmDl+65umKX9KYjnKauGqJfk7MeAdDo/OX1Y1OH0QEeUBVExIoDEfngktveN4GgizptxWn0+wnnHo5OMl1gs7jT4Pd365m/bZmyGM8OUiofMOXoUmqW81jqRQJ5ACuUBXa5pKRo4bIL2wXV2W1jX72q7kWx8ey1fsnmEPVGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2kpar0E2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=atRNXWeo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:02:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VyK/s8/j6Xr3xCE7eoMSiARchdfEtSBJNw7GWbhwrso=;
	b=2kpar0E2nm8Ccb7fic7FIx1NBuOGJLJ+1VvhwRyVpoxLp++h4rABzNhJJy4/4nGQAXJCeC
	IPoZZMTDnpEQTGyPjMegAOjVe28DHYT0BxFSEjd/DA2mEKa7ds4QRbLolkI5u88sLQ0ERm
	x9kGs7RdSmaJDjB3DsXUH09yFepmv8tYM7fXLK0995Iq4psSYv1+dp3l+fGq3E/S1ProJb
	aLFslKtpcWewmT9188sMGrAbohGir896nifMTNm+TiRb8GzGWL+kX6P4U3AILPCiNLfFCI
	9RFJPk+Im00qAiBa9il+E3iOzMv5SkK0ECgdFkZNT7tyoFwTgNABz0eAHYBTvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730579;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VyK/s8/j6Xr3xCE7eoMSiARchdfEtSBJNw7GWbhwrso=;
	b=atRNXWeoYcsb49YGfbqilF/5H62awaBb52Fg+zCte12JOUQTH7LRmLL109NOHeaCkRikCS
	F+3JRpx8bk/caMAg==
From: "tip-bot2 for Huacai Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip: Allow LoongArch irqchip drivers on both
 32BIT/64BIT
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Huacai Chen <chenhuacai@loongson.cn>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113085940.3344837-8-chenhuacai@loongson.cn>
References: <20260113085940.3344837-8-chenhuacai@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873057832.510.17515217903802025640.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     03e1c81f05240354921b15806e6b8db5f75198c1
Gitweb:        https://git.kernel.org/tip/03e1c81f05240354921b15806e6b8db5f75=
198c1
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:40 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 19:32:02 +01:00

irqchip: Allow LoongArch irqchip drivers on both 32BIT/64BIT

All LoongArch irqchip drivers are adjusted, allow them to be built on both
32BIT and 64BIT platforms.

Co-developed-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113085940.3344837-8-chenhuacai@loongson.cn
---
 drivers/irqchip/Kconfig | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 118d0c1..f07b00d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -706,7 +706,7 @@ config IRQ_LOONGARCH_CPU
=20
 config LOONGSON_LIOINTC
 	bool "Loongson Local I/O Interrupt Controller"
-	depends on MACH_LOONGSON64
+	depends on MACH_LOONGSON64 || LOONGARCH
 	default y
 	select IRQ_DOMAIN
 	select GENERIC_IRQ_CHIP
@@ -716,7 +716,6 @@ config LOONGSON_LIOINTC
 config LOONGSON_EIOINTC
 	bool "Loongson Extend I/O Interrupt Controller"
 	depends on LOONGARCH
-	depends on MACH_LOONGSON64
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	select GENERIC_IRQ_CHIP
@@ -734,7 +733,7 @@ config LOONGSON_HTPIC
=20
 config LOONGSON_HTVEC
 	bool "Loongson HyperTransport Interrupt Vector Controller"
-	depends on MACH_LOONGSON64
+	depends on MACH_LOONGSON64 || LOONGARCH
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	help
@@ -742,7 +741,7 @@ config LOONGSON_HTVEC
=20
 config LOONGSON_PCH_PIC
 	bool "Loongson PCH PIC Controller"
-	depends on MACH_LOONGSON64
+	depends on MACH_LOONGSON64 || LOONGARCH
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	select IRQ_FASTEOI_HIERARCHY_HANDLERS
@@ -751,7 +750,7 @@ config LOONGSON_PCH_PIC
=20
 config LOONGSON_PCH_MSI
 	bool "Loongson PCH MSI Controller"
-	depends on MACH_LOONGSON64
+	depends on MACH_LOONGSON64 || LOONGARCH
 	depends on PCI
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
@@ -763,7 +762,7 @@ config LOONGSON_PCH_MSI
 config LOONGSON_PCH_LPC
 	bool "Loongson PCH LPC Controller"
 	depends on LOONGARCH
-	depends on MACH_LOONGSON64
+	depends on MACH_LOONGSON64 || LOONGARCH
 	default MACH_LOONGSON64
 	select IRQ_DOMAIN_HIERARCHY
 	help

