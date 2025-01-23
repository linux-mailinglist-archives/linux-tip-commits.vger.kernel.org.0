Return-Path: <linux-tip-commits+bounces-3282-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A59DA1A28B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 12:06:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B90516027B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 23 Jan 2025 11:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EF0020DD4B;
	Thu, 23 Jan 2025 11:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hiY4aWIg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zRH4qnvj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A1961C5F14;
	Thu, 23 Jan 2025 11:06:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737630397; cv=none; b=Zen6X5xnXVLjNTG/ygOd+RWRGfLeLqQoQog11lG74CgOcmPGOtL5EQOLuv5CYEe91XrNhlhmDuoHeVJ9QZEuKFRzWMuPbUQ6tFtf2xA0uQ6Uo9cnhlyDOIxDZid2wwI5fwNJZYSY0FvZ/Mvl+TPacWDuMzaWNZjHxvDy36AdGU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737630397; c=relaxed/simple;
	bh=v+fyTVmMat6OuOwGmkGWkCihGzu7kkeCQ0GBhUmXIbI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CR+/68ZwrYvrveJBYiUhgwiL2HoRJnTzUY+JWwj2bqVeGd184lwY5mMmHgZYd7JaSUWAJ8BiYuPbo30HyEROTzdgIVW5cjG+znrKmpswwUqy+m+6b4ACbfv+c7D0//jF9U0ESrt7UaGauhS84nWENWQYluLJyVxjQ2LLRr9Btso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hiY4aWIg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zRH4qnvj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 23 Jan 2025 11:06:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737630394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JrefHQQeQ/RHmOhf20mjDHgP3PbzG2NbxXNuJDFGBQY=;
	b=hiY4aWIgNghbwXkIMYJ35K8+Onn9/DgM4OToJX+WDrZyioe+PLIEMI70FgbH4P93yxIsvL
	hMcfL74n1evQlKl6kFJ2rXZBqjHyceD/XT4N+uVPaLdnWm7IpoQnPUENCqmLqEbe23dfeK
	PHEJwhGM9MJ2t5K6bL9RrZHphwylxOeNperlfu0fCalm2BTuK4YUfJBTdfbsTE+riK265m
	cr6/LxQs5Zcd8O94KSejbyXvvAVcHTCUZ27WUYfsEIUafAmOeIWLgJbBkuh8zh4ukPWWjS
	bT0V7N8KXCwuusTxjZO59o0kwIRVj0BHi6TECtnRV5vpk3Uw2aZSbRh5MopcSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737630394;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JrefHQQeQ/RHmOhf20mjDHgP3PbzG2NbxXNuJDFGBQY=;
	b=zRH4qnvjyZodbS/M2GfxK/ecQBPSDPZFVe+qjG4k9NcqH79erL+h3HzjdFIUTLdcv7Z/J6
	s2O65s0Q71+qirBQ==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/lan966x-oic: Make CONFIG_LAN966X_OIC depend
 on CONFIG_MCHP_LAN966X_PCI
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, Herve Codina <herve.codina@bootlin.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C28e8a605e72ee45e27f0d06b2b71366159a9c782=2E17373?=
 =?utf-8?q?83314=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C28e8a605e72ee45e27f0d06b2b71366159a9c782=2E173738?=
 =?utf-8?q?3314=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173763039244.31546.13090162359958685271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e06c9e3682f58fbeb632b7b866bb4fe66a4a4b42
Gitweb:        https://git.kernel.org/tip/e06c9e3682f58fbeb632b7b866bb4fe66a4a4b42
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Mon, 20 Jan 2025 15:35:02 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 23 Jan 2025 11:59:10 +01:00

irqchip/lan966x-oic: Make CONFIG_LAN966X_OIC depend on CONFIG_MCHP_LAN966X_PCI

The Microchip LAN966x outband interrupt controller is only present on
Microchip LAN966x SoCs, and only used in PCI endpoint mode.  Hence add a
dependency on MCHP_LAN966X_PCI, to prevent asking the user about this
driver when configuring a kernel without Microchip LAN966x PCIe support.

Fixes: 3e3a7b35332924c8 ("irqchip: Add support for LAN966x OIC")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Herve Codina <herve.codina@bootlin.com>
Link: https://lore.kernel.org/all/28e8a605e72ee45e27f0d06b2b71366159a9c782.1737383314.git.geert+renesas@glider.be

---
 drivers/irqchip/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index be063bf..c11b996 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -169,6 +169,7 @@ config IXP4XX_IRQ
 
 config LAN966X_OIC
 	tristate "Microchip LAN966x OIC Support"
+	depends on MCHP_LAN966X_PCI || COMPILE_TEST
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
 	help

