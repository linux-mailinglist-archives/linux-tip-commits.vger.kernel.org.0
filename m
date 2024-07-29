Return-Path: <linux-tip-commits+bounces-1774-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 467E993F1B7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 730291C21CA5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE9E14601D;
	Mon, 29 Jul 2024 09:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="g0X9UmNs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCSUWEfA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1041459E6;
	Mon, 29 Jul 2024 09:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246592; cv=none; b=RA+7W+VCqlTx2m81NTOxmVl3J+O/PKnYow8EqbC/omu0X3I1TjZXTF5Bf5V+UQ8jzBNgk0uVRRKzQJ4hMEti1ydcKEI5RiQZz9M9OxqRj2Q6D6JB3bkotxdLwfd6qlD2HX6i3EzrKtBr0Kcq/g/YDHiSKuYqmBrWozHhZrBy7Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246592; c=relaxed/simple;
	bh=3RBv6eo9vU6SO+QXTRYMO5sGZTtItxzF3qnOG96UJjc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PAr74WETed9qdiZBp8SOQRXFE8Who5SnAOWk74q5TYeDtMCUEdJ+0K8vWRZWW4DFmPodcJ19dNG8EJxKGOlN9ZJDNZXIxMaY4sQ/7BZy5gsXa+wOU1UqVWqegEBWb9jOh3u1+cjFXmepdzqkncAAMka7Wd/5yIvHsvmZogkfyi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=g0X9UmNs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCSUWEfA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xgX3XxwvBwDJXLU/W4MKGVPheKWELcCk37kTukOcvA=;
	b=g0X9UmNspFvPQVTck59y1ZFKtOXwIBH/Zw3maXndnwcvqSHGMLGu2mziv/CP5cthMfykjh
	g/WFv530n3PwbpOj9y94M1W1MRGXY8IqQ0K6X6LKS2H9vBta7F6/TAYKnpguNZMLSEWxux
	mH00ONkngv8SklpN8AIFGw/zgGc82rX8smvk8jhGNhG8UaTAnG3VkuSEc2xcqr38mB8tma
	Hnk9WbFYMtx0JeMs1SV3G8qD86Ip6u1narpFntjpNNhZw208kuBfhGC5M/drUBdHU9TES2
	0KpsOyIMzbmyO2TKJH1fcd0iJ1WweEH9Sqe0OYF53SS0BuIkwdSZnnvO0PtWCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9xgX3XxwvBwDJXLU/W4MKGVPheKWELcCk37kTukOcvA=;
	b=iCSUWEfA+zuzQjd2Y2odOB6xGQdGKM79CFgJc5JvWV9/kLRWnoi+/HCwWRMn80qHIMjwlW
	PxXiULEDsyCeuXAw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Use BIT() and GENMASK() macros
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, x86@kernel.org, linux-kernel@vger.kernel.org,
 maz@kernel.org
In-Reply-To: <20240708151801.11592-5-kabel@kernel.org>
References: <20240708151801.11592-5-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658704.2215.13748374301568914524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3587a763f2faf0fe4004d5103e573f0700f89e50
Gitweb:        https://git.kernel.org/tip/3587a763f2faf0fe4004d5103e573f0700f=
89e50
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:21 +02:00

irqchip/armada-370-xp: Use BIT() and GENMASK() macros

Use the BIT() and GENMASK() macros where appropriate.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://lore.kernel.org/all/20240708151801.11592-5-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 427ba5f..18aca9b 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -121,7 +121,7 @@
 #define ARMADA_370_XP_INT_SET_ENABLE		(0x30)
 #define ARMADA_370_XP_INT_CLEAR_ENABLE		(0x34)
 #define ARMADA_370_XP_INT_SOURCE_CTL(irq)	(0x100 + irq*4)
-#define ARMADA_370_XP_INT_SOURCE_CPU_MASK	0xF
+#define ARMADA_370_XP_INT_SOURCE_CPU_MASK	GENMASK(3, 0)
 #define ARMADA_370_XP_INT_IRQ_FIQ_MASK(cpuid)	((BIT(0) | BIT(8)) << cpuid)
=20
 /* Registers relative to per_cpu_int_base */
@@ -132,18 +132,18 @@
 #define ARMADA_370_XP_INT_SET_MASK		(0x48)
 #define ARMADA_370_XP_INT_CLEAR_MASK		(0x4C)
 #define ARMADA_370_XP_INT_FABRIC_MASK		(0x54)
-#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	(1 << cpu)
+#define ARMADA_370_XP_INT_CAUSE_PERF(cpu)	BIT(cpu)
=20
 #define ARMADA_370_XP_MAX_PER_CPU_IRQS		(28)
=20
 /* IPI and MSI interrupt definitions for IPI platforms */
 #define IPI_DOORBELL_START			(0)
 #define IPI_DOORBELL_END			(8)
-#define IPI_DOORBELL_MASK			0xFF
+#define IPI_DOORBELL_MASK			GENMASK(7, 0)
 #define PCI_MSI_DOORBELL_START			(16)
 #define PCI_MSI_DOORBELL_NR			(16)
 #define PCI_MSI_DOORBELL_END			(32)
-#define PCI_MSI_DOORBELL_MASK			0xFFFF0000
+#define PCI_MSI_DOORBELL_MASK			GENMASK(31, 16)
=20
 /* MSI interrupt definitions for non-IPI platforms */
 #define PCI_MSI_FULL_DOORBELL_START		0
@@ -415,7 +415,7 @@ static void armada_370_xp_ipi_send_mask(struct irq_data *=
d,
=20
 	/* Convert our logical CPU mask into a physical one. */
 	for_each_cpu(cpu, mask)
-		map |=3D 1 << cpu_logical_map(cpu);
+		map |=3D BIT(cpu_logical_map(cpu));
=20
 	/*
 	 * Ensure that stores to Normal memory are visible to the

