Return-Path: <linux-tip-commits+bounces-8063-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8DF0D3955B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 14:42:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B7D1730060FB
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 13:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E60A331A7B;
	Sun, 18 Jan 2026 13:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="feiz7Orv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BC1fLv9G"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B04B32ED2F;
	Sun, 18 Jan 2026 13:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768743722; cv=none; b=Sr+8FKWYOMElGkU+ivMMP8hNTOra9w7OYXlX2v3f/tzfNqReoEBID9K5ARUEC3EyO4oTZWtq//2qTS8eRwaoT7PR/zd5oke3yI97UxzvrHb9HKgaOT0tEzo79p9ljzlYHZcLD/FwgOp2XasLgTEtzFNp3FMI/ivTmR6cb2zNPYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768743722; c=relaxed/simple;
	bh=ENlhxGWRP0lFaV2/m1PEzBOdBNijnvkAbGwUHdV2lYM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SX69SowE+1ha3inQw33yoHY+3QqKgnpiO+Uv2Af+oL3OF1TqDkND100ru/qf37KBDHE/x7EUS9i4SOVfsFTyakVxI2HVJasq1S+rvLq3nQHC8N3K3mLOope/O6fdVxsLrmUhi0I+gqAso1lu49po1edOoj1xYhOX+mDjqFze59o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=feiz7Orv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BC1fLv9G; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 13:41:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768743713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELugA0PjwXHRyuLKvb7p6fHAXR4OmgQWpC6PCpCl7g0=;
	b=feiz7Orvua6JLBR1Na3vyqgZQKMTojaOy84DGaN4nNjj4Kv7W3+rq0wt6Nzx1+oekMiyDb
	MGzHMrq1+/kJoC24HT9i6Edpfu+QLvHBhk5vRM5g8prELE0bp5dN0wYENWG6vLJdHVcrAV
	dPErV+KQEGYh7D+auS3Air22sj+0XwjIPb3R/NnaODHgtnp83HA7F0waszD1Bkgp1uG2yM
	9jl50MXQI7/DjHOh+Lb7YagoaxPq73Cx0BYLW99EQT7ZkUal4//xvN/WZqHa5b7sxOOgbJ
	QGrT8NeEubqaxOsaDszZQ8v0BrBECth9dC/prdeMvtXZmC/y5DuHKe+VYd9G7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768743713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ELugA0PjwXHRyuLKvb7p6fHAXR4OmgQWpC6PCpCl7g0=;
	b=BC1fLv9GRhL4FGc9yFFayL18RL8vvgp5QURwTScSdD/dF4YATItBLthLJySdFYfiBtLybC
	ADqt0nAbWlOTSxBA==
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
Message-ID: <176874371212.510.656649007794856988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     a34d398c83a4a4bc00513c00f6eecc34267f834f
Gitweb:        https://git.kernel.org/tip/a34d398c83a4a4bc00513c00f6eecc34267=
f834f
Author:        Huacai Chen <chenhuacai@loongson.cn>
AuthorDate:    Tue, 13 Jan 2026 16:59:40 +08:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 14:39:18 +01:00

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

