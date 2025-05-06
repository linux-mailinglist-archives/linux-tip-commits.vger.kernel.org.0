Return-Path: <linux-tip-commits+bounces-5314-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8C8AAC75B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 16:04:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E4AC1899439
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 14:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 343A7281341;
	Tue,  6 May 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vj+sQJr6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="esCQUuE+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64278280A56;
	Tue,  6 May 2025 14:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540269; cv=none; b=cy+CjNUHbWd0ZBYFD2dMGCMj9oaRlWXeGVHvlqchPDct4AEKDaHKb8LP4hwNqLC26ikhc+oR7D9Ju426meIagJWJ7dv/YmLAkUPqG9dxOBZctEVdaOwoklmqOtP8e/FxPgf3cVB984mtMyU8BgYer7DeU5s3X9Zd9i9P6gxgjcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540269; c=relaxed/simple;
	bh=i7aKFftOdmkSra+c7TEmIa21fgCA/demdDtk4+utLp4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SO9euowBwK09dZsZBewk3mmJC8VjitlxaigkZNZb86Z7MlcissOGxSURgDePEzRq5gXBe3JScLq9pmaK+9KFq5eR5463RTv5GoH6i1djd8yfz1anKhLyxs5BKKh5zjHaXGBImPi8fpBbqSKL5DMQmUvYig7p9wg5bM/8ENpFQyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vj+sQJr6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=esCQUuE+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 14:04:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746540265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiiOnUKUvWsrO0K8NWkqVuhH/nhb424KbdufbNNwl+I=;
	b=Vj+sQJr6bb61a1QwjqxgQbrtxtNsyReEB/6z3R5aqZ+y7mMs7MKO+/5g6QS9SuWblCnUpa
	7ZIXe8e8VKo3nOp0g/5p7Y07OKIIEePGmXhoSGjMaeaJE3C0QjOGyxor9dhF1jtRQadNLT
	rPgp2/Z18x+S0UEsNWNLEN8iIzPJhl3I5k5D1sfbKshk+7jwdI1+FwS7sxWGpeStbro1A/
	a6ySxSX06+H1efLWmv77eST5njGet+SBIcVXkonP93wvACGJehqtD6Uy55ETFFTtPQer2P
	H8ANMM3/jChylbosuHq+SDWoKF0raZZBv2KeMCbzm1cWvM1ndbz6dyc+LYzuPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746540265;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uiiOnUKUvWsrO0K8NWkqVuhH/nhb424KbdufbNNwl+I=;
	b=esCQUuE+PYPKxwzBsUBHtVLyRfQXGDMkh8yvWJeBIVLAN0qAE2NVVSZZKZlqXiGFjO7TQ5
	5g6F0sbE/qwKcSBA==
From: "tip-bot2 for Alexey Charkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-vt8500: Use fewer global variables and
 add error handling
Cc: Alexey Charkov <alchark@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506-vt8500-intc-updates-v2-5-a3a0606cf92d@gmail.com>
References: <20250506-vt8500-intc-updates-v2-5-a3a0606cf92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174654026461.406.12839748148881380454.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     99ad153fbd22fcf7c2bdd774d08fc4bf70029fa6
Gitweb:        https://git.kernel.org/tip/99ad153fbd22fcf7c2bdd774d08fc4bf70029fa6
Author:        Alexey Charkov <alchark@gmail.com>
AuthorDate:    Tue, 06 May 2025 16:46:18 +04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 15:58:27 +02:00

irqchip/irq-vt8500: Use fewer global variables and add error handling

Controller private data doesn't really need to be in a global
statically allocated array - kzalloc it per controller instead,
keeping only one pointer to the primary controller global.

While at that, also add proper error return statuses in the init
path and respective cleanup of resources on errors.

Signed-off-by: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250506-vt8500-intc-updates-v2-5-a3a0606cf92d@gmail.com

---
 drivers/irqchip/irq-vt8500.c | 48 ++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index 15134cb..40c2cff 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -64,9 +64,6 @@ struct vt8500_irq_data {
 	struct irq_domain	*domain;	/* Domain for this controller */
 };
 
-/* Global variable for accessing io-mem addresses */
-static struct vt8500_irq_data intc[VT8500_INTC_MAX];
-static u32 active_cnt = 0;
 /* Primary interrupt controller data */
 static struct vt8500_irq_data *primary_intc;
 
@@ -203,49 +200,54 @@ static void vt8500_handle_irq_chained(struct irq_desc *desc)
 static int __init vt8500_irq_init(struct device_node *node,
 				  struct device_node *parent)
 {
-	int irq, i;
+	struct vt8500_irq_data *intc;
+	int irq, i, ret = 0;
 
-	if (active_cnt == VT8500_INTC_MAX) {
-		pr_err("%s: Interrupt controllers > VT8500_INTC_MAX\n",
-								__func__);
-		goto out;
-	}
-
-	intc[active_cnt].base = of_iomap(node, 0);
-	intc[active_cnt].domain = irq_domain_add_linear(node, 64,
-			&vt8500_irq_domain_ops,	&intc[active_cnt]);
+	intc = kzalloc(sizeof(*intc), GFP_KERNEL);
+	if (!intc)
+		return -ENOMEM;
 
-	if (!intc[active_cnt].base) {
+	intc->base = of_iomap(node, 0);
+	if (!intc->base) {
 		pr_err("%s: Unable to map IO memory\n", __func__);
-		goto out;
+		ret = -ENOMEM;
+		goto err_free;
 	}
 
-	if (!intc[active_cnt].domain) {
+	intc->domain = irq_domain_add_linear(node,
+					     64,
+					     &vt8500_irq_domain_ops,
+					     intc);
+	if (!intc->domain) {
 		pr_err("%s: Unable to add irq domain!\n", __func__);
-		goto out;
+		ret = -ENOMEM;
+		goto err_unmap;
 	}
 
-	vt8500_init_irq_hw(intc[active_cnt].base);
+	vt8500_init_irq_hw(intc->base);
 
 	pr_info("vt8500-irq: Added interrupt controller\n");
 
-	active_cnt++;
-
 	/* check if this is a chained controller */
 	if (of_irq_count(node) != 0) {
 		for (i = 0; i < of_irq_count(node); i++) {
 			irq = irq_of_parse_and_map(node, i);
 			irq_set_chained_handler_and_data(irq, vt8500_handle_irq_chained,
-							 &intc[active_cnt]);
+							 intc);
 		}
 
 		pr_info("vt8500-irq: Enabled slave->parent interrupts\n");
 	} else {
-		primary_intc = &intc[active_cnt];
+		primary_intc = intc;
 		set_handle_irq(vt8500_handle_irq);
 	}
-out:
 	return 0;
+
+err_unmap:
+	iounmap(intc->base);
+err_free:
+	kfree(intc);
+	return ret;
 }
 
 IRQCHIP_DECLARE(vt8500_irq, "via,vt8500-intc", vt8500_irq_init);

