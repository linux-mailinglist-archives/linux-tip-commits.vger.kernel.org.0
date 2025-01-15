Return-Path: <linux-tip-commits+bounces-3210-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC49AA11D1C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F3AF168E0A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:16:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBFFF1EEA3D;
	Wed, 15 Jan 2025 09:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8O16qMQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2NInqX67"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3E41ACE12;
	Wed, 15 Jan 2025 09:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932584; cv=none; b=rvUFKjzZG65GLNCQEnMTvRVuTgBmkGFwHOp7p2PYUpRVhnVRuXEATeb+AYLXwIatnzvk38ZJATK2nIvqZZlWbQT0EuEWzx3v6/0q8KqM3PGK7RHvibIQTodSf1oPbJieUCZ5LcYkBNKJs0yYMwPzIys1wvJQmUYxiCmzh8VgMT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932584; c=relaxed/simple;
	bh=0UmGpx/CESQTaeVt3jfYbB6Q//i/UlnxgM+ty+xfgz4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kTXOvnV/Bz4OZkeKxnKduiJTiKToc4F9OVS+iakvn2Q5SkXnrbjIWyRCP1Avy30WWkzE+pvodIu/hPWQWAjRKuLaUQn9JaEglhWf60WbaQhSsy2Fhzw+IQucwxuqmgJm3xf06bsHA48bTGwlXu4qwq1l5txaN5Q+t2g7EnTRFX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X8O16qMQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2NInqX67; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPXWz34x0aKgLtiNOHXEvG6/SYqhXl1KqF3gTsf33hw=;
	b=X8O16qMQ5MGK1snVWBmkjMa06F8uSByHPIRyGhuLL8c21jpa6ab/U2kJHHzeWzogrdXQYj
	qm7XFlm+4awWs+C1ITNE2USp/NjqkI+X9RFEP8Tkh2iUFXcfHckMRo6N4D4FhxOXJybPMO
	L62h+KpAlZmdpFyK6iY6gL4ah1GDGRNQv/n8kAy/XNmNTTCFgkzpLAG1d/Puyl6LlyO3HV
	szdE8u4kUA+62J+rxxGp3laJpN6W/wGA71H8hl62VZBy6CMqC5KyK+oPXVHB1pRo7Nneq2
	fIQznYXHYg+msnZFZfYHhtQJYyO+n48TVLmQhYfSyJPzKVbACmfZEhKgHWpZEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fPXWz34x0aKgLtiNOHXEvG6/SYqhXl1KqF3gTsf33hw=;
	b=2NInqX67M7KpTsqtOqKIzr6ABjSw6WEMoR86+hVV70stgNn6xmCBpX8DggcUL6AJVPtLS6
	Z79p2GcxSPcZkBAw==
From: "tip-bot2 for Nicolas Frayer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ti-sci-inta : Add module build support
Cc: Nicolas Frayer <nfrayer@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241224-timodules-v4-2-c5e010f58e2c@baylibre.com>
References: <20241224-timodules-v4-2-c5e010f58e2c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257461.31546.10072460065072682437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b8b26ae398c4577893a4c43195dba0e75af6e33f
Gitweb:        https://git.kernel.org/tip/b8b26ae398c4577893a4c43195dba0e75af6e33f
Author:        Nicolas Frayer <nfrayer@baylibre.com>
AuthorDate:    Tue, 24 Dec 2024 20:36:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:54:29 +01:00

irqchip/ti-sci-inta : Add module build support

Add module build support in Kconfig for the TI SCI interrupt aggregator
driver. The driver's default build is built-in and it also depends on
ARCH_K3 as the driver uses some 64 bit ops and should only be built for
64-bit platforms.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/all/20241224-timodules-v4-2-c5e010f58e2c@baylibre.com
---
 arch/arm64/Kconfig.platforms      | 1 -
 drivers/irqchip/Kconfig           | 3 ++-
 drivers/irqchip/irq-ti-sci-inta.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index eda592a..0200725 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -135,7 +135,6 @@ config ARCH_K3
 	select SOC_TI
 	select TI_MESSAGE_MANAGER
 	select TI_SCI_PROTOCOL
-	select TI_SCI_INTA_IRQCHIP
 	select TI_K3_SOCINFO
 	help
 	  This enables support for Texas Instruments' K3 multicore SoC
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6f1b7d2..fb22f27 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -545,8 +545,9 @@ config TI_SCI_INTR_IRQCHIP
 	  TI System Controller, say Y here. Otherwise, say N.
 
 config TI_SCI_INTA_IRQCHIP
-	bool
+	tristate "TI SCI INTA Interrupt Controller"
 	depends on TI_SCI_PROTOCOL
+	depends on ARCH_K3 || (COMPILE_TEST && ARM64)
 	select IRQ_DOMAIN_HIERARCHY
 	select TI_SCI_INTA_MSI_DOMAIN
 	help
diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index b83f5cb..a887efb 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -743,3 +743,4 @@ module_platform_driver(ti_sci_inta_irq_domain_driver);
 
 MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ti.com>");
 MODULE_DESCRIPTION("K3 Interrupt Aggregator driver over TI SCI protocol");
+MODULE_LICENSE("GPL");

