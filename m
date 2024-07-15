Return-Path: <linux-tip-commits+bounces-1697-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DCF8931597
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 15:20:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF1721F22308
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 13:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E957618E749;
	Mon, 15 Jul 2024 13:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="clYYKbBm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CDD1Bhpw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6272518D4D7;
	Mon, 15 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049641; cv=none; b=mpbFALhIgNinDEFYQYj+7PKR1pDbFLEM4sa6d5v3HMI9ED2uXhXd2hr3ARC53dw2TWBCCQCa3XVOOAAsbNbB3Z/c+a334Dr/u6s+E51kFfLk750paNjLOT885lScT4XNPCkM7f+LGoJFOaJzBwZZJuQm3pl0sW5M1Lu3JQOB7MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049641; c=relaxed/simple;
	bh=k1DYAmdTbBTNNduAtLmPy1nmd5hquYuCoEVL0AEwufg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Bq88jaYQwc8eIhNxghxFjmuzoOnJvzoQZzPmRi7YkeYc2UOC+nt0P91V7X0eyCP19YGZrr7SJQ1MtAUSU5nt6KxmJKVLTbpGTxHCkMkjGqkoSYxPVGYMDV1Nnn5Mqu0/HWMXm5/t4BHkojsUIqf9rDJ6csphFZYzSubEpeXj+QQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=clYYKbBm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CDD1Bhpw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 13:20:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orBtctUvnd9aYmVyyrNUnSiC/ei5MuxCfS+vRnlM/MA=;
	b=clYYKbBmn3UiaIsnmfCKI5EHZlJZ756A1A9UhrANNOEpm/7nLJQxb8vWwGl2F/1ve0htlf
	qSb835DkMqTwzGCnmXyyv2lg74IgUKawfU3VObgtDmBN79APV4hxlMn5Fsg23zV0DyGbEm
	1BfrShZeXHGK65pUn3+g4xSxbZGq1JD4+TfcygTAwN8VRsb2nmygVW97URrf5g8PP6IoBE
	R1R+/yiBeO7Dn4Y8njpYeGNJTHDD7hMu1JBY1LTE4OVQ4fRwAkgH8FJxB51D+/ooWQsvpu
	qFpKNRt0i599/mJF4pdEEj2ndXiTaKt0dLr83d+XXzgxP6KbYqOo0fPuBNwD4Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049638;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=orBtctUvnd9aYmVyyrNUnSiC/ei5MuxCfS+vRnlM/MA=;
	b=CDD1BhpwAkitiVlRVuo1kIDdTx06bsp28RaQHYube8AXjWsoD9Ey2x/qJ4U/WuXuY0fo1i
	GXOZlp8ocOfCTeCg==
From: "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Pass #redistributor-regions to
 gic_of_setup_kvm_info()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Thomas Gleixner <tglx@linutronix.de>, Marc Zyngier <maz@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C808286a3ac08f60585ae7e2c848e0f9b3cb79cf8=2E17199?=
 =?utf-8?q?12215=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
References: =?utf-8?q?=3C808286a3ac08f60585ae7e2c848e0f9b3cb79cf8=2E171991?=
 =?utf-8?q?2215=2Egit=2Egeert+renesas=40glider=2Ebe=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172104963807.2215.15869369787526767094.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     10697eee6a6ff59207663f536dc8e8de7a4fd3e7
Gitweb:        https://git.kernel.org/tip/10697eee6a6ff59207663f536dc8e8de7a4fd3e7
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 02 Jul 2024 11:24:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:56 +02:00

irqchip/gic-v3: Pass #redistributor-regions to gic_of_setup_kvm_info()

The caller of gic_of_setup_kvm_info() already queried DT for the value
of the #redistributor-regions property.  So just pass this value,
instead of doing the DT look-up again in the callee.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/808286a3ac08f60585ae7e2c848e0f9b3cb79cf8.1719912215.git.geert+renesas@glider.be

---
 drivers/irqchip/irq-gic-v3.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index e4bc5f0..7c12d11 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -2190,11 +2190,10 @@ out_put_node:
 	of_node_put(parts_node);
 }
 
-static void __init gic_of_setup_kvm_info(struct device_node *node)
+static void __init gic_of_setup_kvm_info(struct device_node *node, u32 nr_redist_regions)
 {
 	int ret;
 	struct resource r;
-	u32 gicv_idx;
 
 	gic_v3_kvm_info.type = GIC_V3;
 
@@ -2202,12 +2201,8 @@ static void __init gic_of_setup_kvm_info(struct device_node *node)
 	if (!gic_v3_kvm_info.maint_irq)
 		return;
 
-	if (of_property_read_u32(node, "#redistributor-regions",
-				 &gicv_idx))
-		gicv_idx = 1;
-
-	gicv_idx += 3;	/* Also skip GICD, GICC, GICH */
-	ret = of_address_to_resource(node, gicv_idx, &r);
+	/* Also skip GICD, GICC, GICH */
+	ret = of_address_to_resource(node, nr_redist_regions + 3, &r);
 	if (!ret)
 		gic_v3_kvm_info.vcpu = r;
 
@@ -2297,7 +2292,7 @@ static int __init gic_of_init(struct device_node *node, struct device_node *pare
 	gic_populate_ppi_partitions(node);
 
 	if (static_branch_likely(&supports_deactivate_key))
-		gic_of_setup_kvm_info(node);
+		gic_of_setup_kvm_info(node, nr_redist_regions);
 	return 0;
 
 out_unmap_rdist:

