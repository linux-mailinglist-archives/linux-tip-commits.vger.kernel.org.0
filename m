Return-Path: <linux-tip-commits+bounces-6545-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D377B508BA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Sep 2025 00:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E2373B355A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 22:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3942265CA6;
	Tue,  9 Sep 2025 22:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iapk+F4k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="llp0eEqC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B68451DDC33;
	Tue,  9 Sep 2025 22:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757455827; cv=none; b=Qk36LMpKoeJYDkFeVyq8hui05Q6U0BdlQvm07WbiJZy+Br2YEj/VE+VmZSoI5UtIdDieShCOtcHM0oN4P4mTCU9hJVlBUxVuNhgkhIa4sfsW8U6cq/qYTEKtIqf3K06x5ha+HUBXwOeSDsITtCi/Ki+BPCaVK9R16nIzIWEupLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757455827; c=relaxed/simple;
	bh=ABHj5e8kb5++h/Z8f89+QmkiXI9fQYWM4MvUjHJQr/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BdhFI//9ji1PURkvQje+diyiXmtzkPtsQAwnbNl/B0z8nPcMpSS80xEj6hYXBgw0kajEVf1v1EyFDw2WNnmDXXhfaXf/17ZhooocsYEZ/wIsEtX1xaDHNkbik70CmCMZsoh0Uqds0Oaljfa8ZqtPjQQwNAzBHiJJbuaS6EBQtlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iapk+F4k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=llp0eEqC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 22:10:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757455820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7hj1423Dyvjjl2rVIgjpHUbk2Ysgh+GgeiSplhAYfg=;
	b=iapk+F4k2+Ag8yhzJo9jWVTl5188Cs3N351Ia9ytwTCrr6Cr8U5qtUwtrUaxGgIBZaQo/b
	Vyf/twFJokOmyVMbdM74QcWyDFx8mdqUowHoxNNmKQawoTuni6KEGs6WU6kfn3F+7zU7o2
	c2BSHI2KkUrJDfP7LPLUPtX2Y6OY78tlv75V5EUYzBfV/5r+jEZ9NEDTf1Yx1grd1iLOuF
	UQFrCxgZzl46MmVXiiwhaqlfikNGreocXAqe2afixIQtlq34INvSBGO/zmYFtchUzsrnM1
	HmHQKWfkZrglUnoqPINTn1BhmElDQowcA2NjLG9Qh1yMJDahnjhQcRzlykRbXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757455820;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=t7hj1423Dyvjjl2rVIgjpHUbk2Ysgh+GgeiSplhAYfg=;
	b=llp0eEqCpDuIag9Qm9i6NcFsQBEtGHq0XrWj8PCF45BAdQqhvkxh8BF70hxYlqaiLFvHR/
	z5zxdjAWu+2BNJAA==
From: "tip-bot2 for Ming Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-pch-lpc: Use legacy domain for
 PCH-LPC IRQ controller
Cc: Ming Wang <wangming01@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250909125840.638418-1-wangming01@loongson.cn>
References: <20250909125840.638418-1-wangming01@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175745581874.684698.8207169683376366959.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c33c43f71bda362b292a6e57ac41b64342dc87b3
Gitweb:        https://git.kernel.org/tip/c33c43f71bda362b292a6e57ac41b64342d=
c87b3
Author:        Ming Wang <wangming01@loongson.cn>
AuthorDate:    Tue, 09 Sep 2025 20:58:40 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 22:37:57 +02:00

irqchip/loongson-pch-lpc: Use legacy domain for PCH-LPC IRQ controller

On certain Loongson platforms, drivers attempting to request a legacy
ISA IRQ directly via request_irq() (e.g., IRQ 4) may fail. The
virtual IRQ descriptor is not fully initialized and lacks a valid irqchip.

This issue does not affect ACPI-enumerated devices described in DSDT,
as their interrupts are properly mapped via the GSI translation path.
This indicates the LPC irqdomain itself is functional but is not correctly
handling direct VIRQ-to-HWIRQ mappings.

The root cause is the use of irq_domain_create_linear(). This API sets
up a domain for dynamic, on-demand mapping, typically triggered by a GSI
request. It does not pre-populate the mappings for the legacy VIRQ range
(0-15). Consequently, if no ACPI device claims a specific GSI
(e.g., GSI 4), the corresponding VIRQ (e.g., VIRQ 4) is never mapped to
the LPC domain. A direct call to request_irq(4, ...) then fails because
the kernel cannot resolve this VIRQ to a hardware interrupt managed by
the LPC controller.

The PCH-LPC interrupt controller is an i8259-compatible legacy device
that requires a deterministic, static 1-to-1 mapping for IRQs 0-15 to
support legacy drivers.

Fix this by replacing irq_domain_create_linear() with
irq_domain_create_legacy(). This API is specifically designed for such
controllers. It establishes the required static 1-to-1 VIRQ-to-HWIRQ
mapping for the entire legacy range (0-15) immediately upon domain
creation. This ensures that any VIRQ in this range is always resolvable,
making direct calls to request_irq() for legacy IRQs function correctly.

Signed-off-by: Ming Wang <wangming01@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/irqchip/irq-loongson-pch-lpc.c |  9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-pch-lpc.c b/drivers/irqchip/irq-loo=
ngson-pch-lpc.c
index 2d4c3ec..912bf50 100644
--- a/drivers/irqchip/irq-loongson-pch-lpc.c
+++ b/drivers/irqchip/irq-loongson-pch-lpc.c
@@ -200,8 +200,13 @@ int __init pch_lpc_acpi_init(struct irq_domain *parent,
 		goto iounmap_base;
 	}
=20
-	priv->lpc_domain =3D irq_domain_create_linear(irq_handle, LPC_COUNT,
-					&pch_lpc_domain_ops, priv);
+	/*
+	 * The LPC interrupt controller is a legacy i8259-compatible device,
+	 * which requires a static 1:1 mapping for IRQs 0-15.
+	 * Use irq_domain_create_legacy to establish this static mapping early.
+	 */
+	priv->lpc_domain =3D irq_domain_create_legacy(irq_handle, LPC_COUNT, 0, 0,
+						    &pch_lpc_domain_ops, priv);
 	if (!priv->lpc_domain) {
 		pr_err("Failed to create IRQ domain\n");
 		goto free_irq_handle;

