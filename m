Return-Path: <linux-tip-commits+bounces-1681-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91B7892EB6B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Jul 2024 17:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4CA0A2835A5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Jul 2024 15:16:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9194A16C69B;
	Thu, 11 Jul 2024 15:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nOStm/wt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9+hY5+mD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A0FB2F46;
	Thu, 11 Jul 2024 15:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720710970; cv=none; b=sRFdprCvnJ4leGsNdf+yzGf4pW6bCmSefMyPx4mwR9LrFR945NHy03rmhcNMMnmDCLQDZFGqQmKJj/ihGVf+8u0xFIIzV82HwdXtjDXymrK5VAAkqTTc0GsIFsu3oGavvzhu36BQsjkSMG95dCi2XBCMf3nXeEhLCOPX9+Ey4FM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720710970; c=relaxed/simple;
	bh=XER4affaoxXJ4XP8yq7gbg1fMLWlgiulfAIv8QZ5S60=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tEb/MpZ9HbA3ccytOUZ0/9lcm0X6j56Z6sr3F5n/nGqvSepUdF4ZFJaugDfWxsYOr56gvkaSCFUYW1h/Smfx72azMpg6Ka00q+6g6pB5OQCYJa16mWqiz4va6W3qetcu1h+VWrDqjPFxAGnBGMMhvt3BKgOZrFxlSy1bfgSk8UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nOStm/wt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9+hY5+mD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 11 Jul 2024 15:16:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720710967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93RfNDYG6fiD1LI3E/9qh9JPnMLb8HcdK9CDBN7BESo=;
	b=nOStm/wtdhTGJNuMkf5x73QhErncVRNxeNHAuWRukDXbKYnCR1TuvTfzaKe56J5+USH/id
	fn/JigyshxRJ5XcC7FOVsbWmR0uIsuoh1F01Pn8XrND11LSgnGBDyKPp8sEaFEekCPcaEC
	8NJ0WsUtH1ZIiJZH7mYEnYnRV7HjR4UQthiHFZSDjsDBshLok8Ikl23Qlsnf/cBAQDqb8j
	qSXld/Xd+0D/4x09j5OPkhjjTr6SyTwaXRZiuxG/ASzdQzrqvkfYVX2rEpdkCV0WKOZSih
	Wl/6nANOVeJBVwgWw7AiorSsO5kfIC8R/05RG5JeZCotb4Weu+Uxt0/NwEv3hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720710967;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=93RfNDYG6fiD1LI3E/9qh9JPnMLb8HcdK9CDBN7BESo=;
	b=9+hY5+mDUYZQNJvGeu9JRkUn985R3WJb8Dg2UvUjJwxCGvHIeBNol49FhD314DUA9MF1x5
	ieiEEQN4ta1y0ICg==
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
Message-ID: <172071096553.2215.15804715660858922520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1265db582c7449edee41e29068b236c474a354a0
Gitweb:        https://git.kernel.org/tip/1265db582c7449edee41e29068b236c474a354a0
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Tue, 02 Jul 2024 11:24:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 11 Jul 2024 16:54:31 +02:00

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

