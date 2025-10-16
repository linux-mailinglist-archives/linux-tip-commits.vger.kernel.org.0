Return-Path: <linux-tip-commits+bounces-6943-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 44240BE4562
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 17:48:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D969B5076E8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 15:48:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCA6536997A;
	Thu, 16 Oct 2025 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNGS1m77";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/yggq+oR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195673570C9;
	Thu, 16 Oct 2025 15:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629604; cv=none; b=S0dDeEBHJ5OIkmPGy/yOS8NJrykRCV8nm/1viFpfd4VnIfKPDUn8iojKhXqB2w/CMCXuK2NYTwSrPPY3nWg88l1C6nCuIyx82tjrkjbGrmYqTKwRWk7ng8YfFlIVAhqr5qxClI6mF7UEvMK+67T9cfMrRLt14HpKBFV2A+7OEgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629604; c=relaxed/simple;
	bh=NIzlOMia77kM28PaJCUNl+KHsaZskWdJ7xyFi3Ql2ns=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nUYOEvYuLI6Mxq41cj02C2v+VGlm/M+jEqP/pKTt7kBMvmSf7pD2Z9Ir4ikycLoN4HxNcRb2zR9ClX/EqghDV+MNXvsAo1xATGfTYqZIvqVz2KJxaNaIYn/EE2UiCAK1N8imesdMCGOayX+9V30OOV546Vjb5fEUblNx15p/DPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNGS1m77; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/yggq+oR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 15:46:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760629601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bluq1/HbKnHKNLul20BPo4/Vrobado3iLOpw5+4vut4=;
	b=fNGS1m77EmGEuboNoLl0Jf9nPLmGCOROS2FUmLLLjO6pzLWzfSeV0eDWYYbN4p8nC0wu4r
	QC0zNWC14en0dPKpEOMkz0RNtILjadkDAF/zR7liT59XIxyHbGGLQE4JO4DqyeRetxtKaJ
	wELsEroUlNJ5FFi3+vsE9/34l+xCL9XhY671A7Og0qWSgPCr0cqvkv9/l9sJlJJfifz8TI
	EGOIwKiMtoE5nuWfnZ+SOl3KXoD7DxhMeVD67bomOY11ib2dHFz/xXEthc2F/fFsWHqcLy
	EfOuT/O2mS/REP1jSfIrRvPK4+XxExuzNpwVZNd7NnuBc0z1IWHVi/Gj+N6l8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760629601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bluq1/HbKnHKNLul20BPo4/Vrobado3iLOpw5+4vut4=;
	b=/yggq+oRStc7DSxPiwbMQo67I+5YJ54tx7Vzs61+QKqDuqvDnGqahJ55TpXjkNz9rWl2QN
	V4cOxO9h13UbrfCA==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip: Enable compile testing of Broadcom drivers
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013095027.12102-1-johan@kernel.org>
References: <20251013095027.12102-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176062960023.709179.10267586622907156622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     8ef82975cf742a3b5adb066ae9ac04fdc14b1941
Gitweb:        https://git.kernel.org/tip/8ef82975cf742a3b5adb066ae9ac04fdc14=
b1941
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:50:27 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 17:26:34 +02:00

irqchip: Enable compile testing of Broadcom drivers

There seems to be nothing preventing the Broadcom drivers from being
compile tested so enable that for wider build coverage.

Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/irqchip/Kconfig | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a61c6dc..9b71537 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -151,7 +151,7 @@ config BCM6345_L1_IRQ
=20
 config BCM7038_L1_IRQ
 	tristate "Broadcom STB 7038-style L1/L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
@@ -159,14 +159,14 @@ config BCM7038_L1_IRQ
=20
 config BCM7120_L2_IRQ
 	tristate "Broadcom STB 7120-style L2 interrupt controller driver"
-	depends on ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN
=20
 config BRCMSTB_L2_IRQ
 	tristate "Broadcom STB generic L2 interrupt controller driver"
-	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
+	depends on ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC || COMPILE_TEST
 	default ARCH_BCM2835 || ARCH_BRCMSTB || BMIPS_GENERIC
 	select GENERIC_IRQ_CHIP
 	select IRQ_DOMAIN

