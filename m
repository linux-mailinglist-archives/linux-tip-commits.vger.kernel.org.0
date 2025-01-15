Return-Path: <linux-tip-commits+bounces-3212-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3992FA11D1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:16:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48287188B576
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:16:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51751EEA4F;
	Wed, 15 Jan 2025 09:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rUEwoGGc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NG+CWmJt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3031EEA22;
	Wed, 15 Jan 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932585; cv=none; b=uK2RhMnB93W2RgF46umgskCUgUITQe/KfLf/fIB/doZ4lBZEZOagk6FnwT8beUkxGohO4br9W1HU7IYy6Za7Nbbn2opLzPbyV8btH6WgAB6R2+Wi5IxUtsiuUIy6BLBwbDk3TP++dbpwKGQpP7iatne9iPRGE8MlgWveI/U38d8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932585; c=relaxed/simple;
	bh=rLt31M0ukx5/PtPFST1x/IKDBDbci1d0nK+LVN2lMas=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=usaaswmb2Gjn3vRtMpadTyv7CkbaYYA6oO5gNE2N6Rzckyt/MKsa88BXpdHNuBUmO6HV73ubZ5a98WXz9siOFUq0/MaVa1SXuX1DllI4sCeDUmlVRsnL0Yd4KlDbLLzimpQAg7kjPmdSv2V9BN/Mquofdh85DtmmIq2IaCVDhdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rUEwoGGc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NG+CWmJt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjcRZWfEv1xxovh3r6tT97+riK7nONWgf5aslwhVqPQ=;
	b=rUEwoGGcZpVJ+VrupCuNJHKHymcNZ1TuDqcQXq0hyqxSUs5MvPIiCCiXJQLQb4QjgedzIn
	jKlx+6HQJxrIiWB8ZQpMoMuacZIUXGyMUQAftd7kjQUaIUszLnaxNg7hU9w0vhAY5Dc+Xo
	qdMjjmK8vAJJHCr08ITLcmpUwDIKkZBAZHRqoZB1zRCh+kRvXT0smyc5YSDgftFdSZYKyb
	yJagl67dskafrfosV2E4Ij8FpDynm4YZD66XtqzFSog5cMXOQP2yYQIQ0tGiHWvTbhjGSL
	/2M4JrNAHxasxzJ2lChwPkrCc477P2x35WZiKy2ODhRsCMZmx3ioLEU4azu0xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932575;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjcRZWfEv1xxovh3r6tT97+riK7nONWgf5aslwhVqPQ=;
	b=NG+CWmJtFfFKN2O30E/By2gWx2f4MOPRxWhI9854tFYEDL8uw3muUmHjq5Ld9hZF0ot+/F
	wIzsuqjmeMUcQuAg==
From: "tip-bot2 for Nicolas Frayer" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ti-sci-intr: Add module build support
Cc: Nicolas Frayer <nfrayer@baylibre.com>,
 Guillaume La Roque <glaroque@baylibre.com>,
 Thomas Gleixner <tglx@linutronix.de>, Nishanth Menon <nm@ti.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241224-timodules-v4-1-c5e010f58e2c@baylibre.com>
References: <20241224-timodules-v4-1-c5e010f58e2c@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257510.31546.14913996482333441326.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2d95ffaecbc2a29cf4a0fa8e63ce99ded7184991
Gitweb:        https://git.kernel.org/tip/2d95ffaecbc2a29cf4a0fa8e63ce99ded7184991
Author:        Nicolas Frayer <nfrayer@baylibre.com>
AuthorDate:    Tue, 24 Dec 2024 20:36:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:54:29 +01:00

irqchip/ti-sci-intr: Add module build support

Add module build support in Kconfig for the TI SCI interrupt router
driver. This driver depends on the TI sci firmware driver which aready
supports module build.

Signed-off-by: Nicolas Frayer <nfrayer@baylibre.com>
Signed-off-by: Guillaume La Roque <glaroque@baylibre.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Nishanth Menon <nm@ti.com>
Link: https://lore.kernel.org/all/20241224-timodules-v4-1-c5e010f58e2c@baylibre.com
---
 arch/arm64/Kconfig.platforms      | 1 -
 drivers/irqchip/Kconfig           | 3 ++-
 drivers/irqchip/irq-ti-sci-intr.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig.platforms b/arch/arm64/Kconfig.platforms
index 370a9d2..eda592a 100644
--- a/arch/arm64/Kconfig.platforms
+++ b/arch/arm64/Kconfig.platforms
@@ -135,7 +135,6 @@ config ARCH_K3
 	select SOC_TI
 	select TI_MESSAGE_MANAGER
 	select TI_SCI_PROTOCOL
-	select TI_SCI_INTR_IRQCHIP
 	select TI_SCI_INTA_IRQCHIP
 	select TI_K3_SOCINFO
 	help
diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 55d7122..6f1b7d2 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -534,8 +534,9 @@ config LS1X_IRQ
 	  Support for the Loongson-1 platform Interrupt Controller.
 
 config TI_SCI_INTR_IRQCHIP
-	bool
+	tristate "TI SCI INTR Interrupt Controller"
 	depends on TI_SCI_PROTOCOL
+	depends on ARCH_K3 || COMPILE_TEST
 	select IRQ_DOMAIN_HIERARCHY
 	help
 	  This enables the irqchip driver support for K3 Interrupt router
diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index c027cd9..b49a731 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -303,3 +303,4 @@ module_platform_driver(ti_sci_intr_irq_domain_driver);
 
 MODULE_AUTHOR("Lokesh Vutla <lokeshvutla@ticom>");
 MODULE_DESCRIPTION("K3 Interrupt Router driver over TI SCI protocol");
+MODULE_LICENSE("GPL");

