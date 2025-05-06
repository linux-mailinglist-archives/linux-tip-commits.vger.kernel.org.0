Return-Path: <linux-tip-commits+bounces-5317-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0172AAC761
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 16:04:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 045293BBF4B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 14:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44652820BC;
	Tue,  6 May 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aRGHdycu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fpT56CkV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1584F281505;
	Tue,  6 May 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540271; cv=none; b=Q4uL4tisNYvbGyluP6Ptf/epCR4xIFUNfu0v66qy2VL4f9DIo0mpsQl2hBddOqK2sycfzBxKsf1KKXBDoh8F/U3747iwYY935Cn/MgAXpyWOS7iLuSVRhPZW7B/YZ+gKrH/viLP0y+68gKdIcAU0F6KdlL37LhcVndzRdbVi/jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540271; c=relaxed/simple;
	bh=183Yv4whGMMqTu7SqQuVBYEZrGjDNendfoAb53Sscwo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IWv0jSlbIQ8cxDyl3xMAGIBPmhPQEEpjk6G8U7Uo3+GHuxOk9ImrX157h2oXsVApKZtF4/K0KL+sFtySH/RdQS/cwlnGF1d5xeeZtql5JesWbOWNLhMV0FT149Pt9bjSFAhuOqVubTasbhgQCC4UpB0L7uAJM7AI/cVNpEuKnBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aRGHdycu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fpT56CkV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 14:04:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746540267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ektE/Bx0tnonjAotJ0LY2YfxwjzIvhTNB7TrrlOpqo=;
	b=aRGHdycuoNikwAM7MClc6zrAu/Qx8lNXaA5HVp8oT1Fg+cjOxA+ncICc4MPhl4Vv66hMQT
	bF2u+Tjoqi2CVd94f0S98WWTJgw4khZaTfCNlLR89baJ75wRk8IhkD8cEtZ5uJFrHp68Rn
	V5lXKxh5yhZzPbGkQs9rth9LP/xa6Njy82grj4XrJ6X06Cpr9YJWNNg1xK5jkkuRiAUMPC
	MC5wZARjKOVyOVBayw1aeg/r45HOabQJq6Q4fG4ZDMa0NLVSejN+EYX8u+tNPbVg4xEgOc
	j/4zZTrpLeoXHh4Rqo3s/HxpLwl2kc4kJgJn94pdq0x/CjlbrYc2BEnkHrYHgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746540267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ektE/Bx0tnonjAotJ0LY2YfxwjzIvhTNB7TrrlOpqo=;
	b=fpT56CkVCTXj4dCO3bzVcMnNG3E1UcybsxED+LEF1RRPBjWj2cbhEJApywRNbeeMb9Cp9v
	igZARV3mf6RigqAQ==
From: "tip-bot2 for Alexey Charkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-vt8500: Drop redundant copy of the
 device node pointer
Cc: Alexey Charkov <alchark@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506-vt8500-intc-updates-v2-2-a3a0606cf92d@gmail.com>
References: <20250506-vt8500-intc-updates-v2-2-a3a0606cf92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174654026693.406.15699843662832408162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     45453df7f69b0157a14478f635c99216821faeee
Gitweb:        https://git.kernel.org/tip/45453df7f69b0157a14478f635c99216821faeee
Author:        Alexey Charkov <alchark@gmail.com>
AuthorDate:    Tue, 06 May 2025 16:46:15 +04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 15:58:26 +02:00

irqchip/irq-vt8500: Drop redundant copy of the device node pointer

Inside vt8500_irq_init(), np is the same as node. Drop it.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250506-vt8500-intc-updates-v2-2-a3a0606cf92d@gmail.com

---
 drivers/irqchip/irq-vt8500.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index 9fb9d37..c88aa64 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -191,7 +191,6 @@ static int __init vt8500_irq_init(struct device_node *node,
 				  struct device_node *parent)
 {
 	int irq, i;
-	struct device_node *np = node;
 
 	if (active_cnt == VT8500_INTC_MAX) {
 		pr_err("%s: Interrupt controllers > VT8500_INTC_MAX\n",
@@ -199,7 +198,7 @@ static int __init vt8500_irq_init(struct device_node *node,
 		goto out;
 	}
 
-	intc[active_cnt].base = of_iomap(np, 0);
+	intc[active_cnt].base = of_iomap(node, 0);
 	intc[active_cnt].domain = irq_domain_add_linear(node, 64,
 			&vt8500_irq_domain_ops,	&intc[active_cnt]);
 
@@ -222,16 +221,16 @@ static int __init vt8500_irq_init(struct device_node *node,
 	active_cnt++;
 
 	/* check if this is a slaved controller */
-	if (of_irq_count(np) != 0) {
+	if (of_irq_count(node) != 0) {
 		/* check that we have the correct number of interrupts */
-		if (of_irq_count(np) != 8) {
+		if (of_irq_count(node) != 8) {
 			pr_err("%s: Incorrect IRQ map for slaved controller\n",
 					__func__);
 			return -EINVAL;
 		}
 
 		for (i = 0; i < 8; i++) {
-			irq = irq_of_parse_and_map(np, i);
+			irq = irq_of_parse_and_map(node, i);
 			enable_irq(irq);
 		}
 

