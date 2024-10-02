Return-Path: <linux-tip-commits+bounces-2313-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 219F798DF75
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:43:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCF9F2817C0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E8C1D0BB0;
	Wed,  2 Oct 2024 15:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Mqt/wYq/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vYLrLWcW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5AE1D014D;
	Wed,  2 Oct 2024 15:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883822; cv=none; b=RnZndJIfJ9DxdRIC4BOV3GNjOWKmQXE7rd+E/+Qhz0h3+JDpbVPEPn9CBMC3njGP1LNuUTtq+sxBxw2clZbDnrWBuY2jM0MOqcEv7O5NJdarHpWovHtqdZIJMJyS4idMm871wmAyOLf1gpOtH3lfDLBsX0eVIKE6TfxpcvuS0FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883822; c=relaxed/simple;
	bh=lB6PMNGEyqGCw++D35DI7Lcl+MrS5Lvqz+OovRQEo7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rAFQDBAN1wekFrxVyAbqWxkZCGM5MI5kG5PbEPNkzQLa9bvVbpBm8VRfE97NUwDNhogASBD3HGCOD4lswzTd/zBExJKBFSNH48A0Bi3RrbAQQazSV77/xD00yzkUgZbEL0VmJegvLMNwkODDgtcnO1kO5c7X7XoIpOjr0WEfOVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Mqt/wYq/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vYLrLWcW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:43:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0De16IgTJImd2Zig5PRX9D+3XYVJZnWbM1U2zhvZx2A=;
	b=Mqt/wYq/TJ8RXsSan2yyOzR4g4q0cZ5y1zCSV+JbogR+l/UaXdXRZQHARNnoeuAXJTfQ1p
	rXoSJsLto52FbjMys5QRxbETODaxFNPGl8yADSiCTe+z1nDxcUr94Z/Maewp7N1gogpne+
	C87iBVuNPp2hvcSbZFT8izWqJ+d31r6crWxaNP8y1L8+60UsePsjhJSwOk85KTioZINV6Q
	c36KW/OjEJZB2Ms8RytMFFLC1PaQEMxSmqx/ceyLkUtgnjgtwUvoBkQgpaTAgMZyp4afUQ
	LhsW3sm6cELPuGkRWdcNJelzJijAKvHPq6mwzyeGeygC8rk/OYcrPhH1hNgl0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883818;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0De16IgTJImd2Zig5PRX9D+3XYVJZnWbM1U2zhvZx2A=;
	b=vYLrLWcWKuLWg/qe13pg5rmdBXf/THfc26Jnxr9EHHVRwBFFnJGq0nPR/d3YUIM5/Gwe+2
	jFArUpnFpMo815BQ==
From: "tip-bot2 for Hari Prasath" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/atmel-aic5: Add support for sam9x7 aic
Cc: Hari Prasath <Hari.PrasathGE@microchip.com>,
 Varshini Rajendran <varshini.rajendran@microchip.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Nicolas Ferre <nicolas.ferre@microchip.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240903064252.49530-1-varshini.rajendran@microchip.com>
References: <20240903064252.49530-1-varshini.rajendran@microchip.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788381812.1442.14556273855604118914.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e408b0131644b0b3e7ab880aad905ca0c8ca8ad0
Gitweb:        https://git.kernel.org/tip/e408b0131644b0b3e7ab880aad905ca0c8ca8ad0
Author:        Hari Prasath <Hari.PrasathGE@microchip.com>
AuthorDate:    Tue, 03 Sep 2024 12:12:52 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:36:47 +02:00

irqchip/atmel-aic5: Add support for sam9x7 aic

Add support for the Advanced interrupt controller(AIC) chip in the sam9x7.

Signed-off-by: Hari Prasath <Hari.PrasathGE@microchip.com>
Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
Link: https://lore.kernel.org/all/20240903064252.49530-1-varshini.rajendran@microchip.com

---
 drivers/irqchip/irq-atmel-aic5.c |  9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index c0f55dc..e98c287 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -319,6 +319,7 @@ static const struct of_device_id aic5_irq_fixups[] __initconst = {
 	{ .compatible = "atmel,sama5d3", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "atmel,sama5d4", .data = sama5d3_aic_irq_fixup },
 	{ .compatible = "microchip,sam9x60", .data = sam9x60_aic_irq_fixup },
+	{ .compatible = "microchip,sam9x7", .data = sam9x60_aic_irq_fixup },
 	{ /* sentinel */ },
 };
 
@@ -405,3 +406,11 @@ static int __init sam9x60_aic5_of_init(struct device_node *node,
 	return aic5_of_init(node, parent, NR_SAM9X60_IRQS);
 }
 IRQCHIP_DECLARE(sam9x60_aic5, "microchip,sam9x60-aic", sam9x60_aic5_of_init);
+
+#define NR_SAM9X7_IRQS		70
+
+static int __init sam9x7_aic5_of_init(struct device_node *node, struct device_node *parent)
+{
+	return aic5_of_init(node, parent, NR_SAM9X7_IRQS);
+}
+IRQCHIP_DECLARE(sam9x7_aic5, "microchip,sam9x7-aic", sam9x7_aic5_of_init);

