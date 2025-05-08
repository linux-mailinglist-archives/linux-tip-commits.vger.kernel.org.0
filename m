Return-Path: <linux-tip-commits+bounces-5492-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D921AB0171
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 19:28:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2C4D1BC0789
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 17:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93C0E2798ED;
	Thu,  8 May 2025 17:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G96+aU6E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TyrNtoju"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DFB9284662;
	Thu,  8 May 2025 17:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746725234; cv=none; b=H28YVmYD9Kt2Ltf/rSqjnlGXnoPHoO05iyQpi6N1b7jiqJT+Qa3Eut9csZWlIZs8TdJ5JSsXPS3Lvt+Wa21ROaMVME57rNCaaJYpAFMa8OPvkn471XmZxngGuXdmvHZp00TF3IyLnVRKVaFd1vNpi99uZpj1IRjDfPK7bBmsuwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746725234; c=relaxed/simple;
	bh=TMr2EZn3Dy99vtzTWc+amUpVz+O4noXXEnSB5lK7Juw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ANWjQxI4ceSKxD8WOufA13b6ITz3KFIFR6NJCjyaDfJahSi/5SsaQgO0qEfp7k0vMvMp/CqcZtdvdiHrHvWRhUF+OEF+TKGd0MvV4HcHxhJWWQVRdzgxgsDzo7CkVJhAYPKe8rrJ3UQRYEec+lZ56TkncqJ6maLUgRv1iArAKu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G96+aU6E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TyrNtoju; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 17:27:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746725230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoXTJixuzXYKccg1bIeQrdQ0D8BAKohPClXOIolOMzA=;
	b=G96+aU6EEbnY5iDY/PqKosmgyD3SoWFO+mJf/nTwt0YiRfdXgYPf8wEpCxcLo+JSw916pV
	XYUzN1OsPB4CQqLxtHoGroel8CjCi/jRxfXRREBZ8VpaMq9CryL2ENENkeiPn9mcnfdWe4
	GlMS5HGJBGIlGxuPSFdrwN/PBlUjLif8sAwCvqiZmhRVTsfzcm6+8HX01nOMGLxmEpGJ/D
	hLfao/BDREfUe8N7SKarQs5tWsgTygp+8L57+W+OuKdgJORxj5R8v/BZ/jIDNpZRsmNd8k
	aYbQZtvkA+nx0eRG0wBsvIIRa90S1lnyp6ogLtvtgDsomOtTb5x0nDZskELsiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746725230;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YoXTJixuzXYKccg1bIeQrdQ0D8BAKohPClXOIolOMzA=;
	b=TyrNtojuCfhYNTt9VuJMjbFhkqLSUs/EDJJyP/ZcKeBnWjgDNS4OiVv86jEb6ogbS0WDdY
	BGxOBJ69ddyVe+CA==
From: "tip-bot2 for Frank Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v3-its: Add support for device tree
 msi-map and msi-mask
Cc: Frank Li <Frank.Li@nxp.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250414-ep-msi-v18-5-f69b49917464@nxp.com>
References: <20250414-ep-msi-v18-5-f69b49917464@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174672522967.406.10710032891656618225.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     f1680d9081e161925c3aca81231ee867c95890b0
Gitweb:        https://git.kernel.org/tip/f1680d9081e161925c3aca81231ee867c95890b0
Author:        Frank Li <Frank.Li@nxp.com>
AuthorDate:    Mon, 14 Apr 2025 14:30:59 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 17:49:24 +02:00

irqchip/gic-v3-its: Add support for device tree msi-map and msi-mask

Some platform devices create child devices dynamically and require the
parent device's msi-map to map device IDs to actual sideband information.

A typical use case is using ITS as a PCIe Endpoint Controller(EPC)'s
doorbell function, where PCI hosts send TLP memory writes to the EP
controller. The EP controller converts these writes to AXI transactions
and appends platform-specific sideband information.

EPC's DTS will provide such information by msi-map and msi-mask. A
simplified dts as

pcie-ep@10000000 {
	...
	msi-map = <0 &its 0xc 8>;
                          ^^^ 0xc is implement defined sideband information,
			      which append to AXI write transaction.
	           ^ 0 is function index.

	msi-mask = <0x7>
}

Check msi-map if msi-parent missed to keep compatility with existing systems.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250414-ep-msi-v18-5-f69b49917464@nxp.com
---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index bdb04c8..68f9ba4 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -118,6 +118,14 @@ static int of_pmsi_get_dev_id(struct irq_domain *domain, struct device *dev,
 		index++;
 	} while (!ret);
 
+	if (ret) {
+		struct device_node *np = NULL;
+
+		ret = of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &np, dev_id);
+		if (np)
+			of_node_put(np);
+	}
+
 	return ret;
 }
 

