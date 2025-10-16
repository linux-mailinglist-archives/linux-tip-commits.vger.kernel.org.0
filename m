Return-Path: <linux-tip-commits+bounces-6858-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 58AD9BE284F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 26DE24FE93C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7B3731DD86;
	Thu, 16 Oct 2025 09:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Of4FiYW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Zm3P9iJT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D7B31B11F;
	Thu, 16 Oct 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608330; cv=none; b=cior343JDrWynzbJFAlE+eBIOWDT4JXToZ2SBzapw0h4HBk3vBAgulK8nyfqqMmhzKLIdhdyjrqxylKB1J/QkUOGvFcX2k7oVBZzfQlhtenkUkKV6xAbsednPcqeL8zBtyzf12p8UTo7nmFyN2k9+QEZTNHR1S1GxlDl+YHw4XM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608330; c=relaxed/simple;
	bh=BVcRDyoBiRwRTF7pPoFHaURuNqu3GskoKG3+HmeB3Ag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m+kl+E7O8E1K4Tv8WLxXsSZ3Yr6ZW/3UvZG8k0Wx4kDP69YZHdoMc3r3Qdik0J1lCfM6Y74V/UfZ0S1Jo/0/RTiNyM8EWFp5YwQdp4TLlgD1fubmKsy36HW6LT2HYOKFbhkq0c50njRReNVZottiuxL/5zGBnyVjQKcbFYY0wZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Of4FiYW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Zm3P9iJT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6m4Co0vqzw5peN2ZEDi/y91/bN+TYl6GZWfvAqzVi2g=;
	b=1Of4FiYWs5v9RjAUnP8xDM5R0KRpy0aO8R9pQw2Jf6x+wCu5GgusIH81gneuxqavqGcbj8
	jBc3IUsG4TBfqBc5IMsZvFiPvrCxRdk1+DuV0kE6yzB7UITrVnWID1zYcGQy6xi0QFCvB8
	YFxqpPa50NMPgg/VCYfVoWLIspQBtJJXdPjwniU2UzJ55b0y0uJ7xUrJqqlBbS+59kuq2i
	AAj85xySjZlOR//cBSFP3GRvvbEEjuaniTYcAEnUnV/B1Yn45F5ZHR42MF4suEii4vrbxn
	d/e5zVLG8kEh/rgnrk9thVCzWOCJ8sFHH+ndFJnEPL9NlDFc7ijfuHodPX+Gfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608303;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6m4Co0vqzw5peN2ZEDi/y91/bN+TYl6GZWfvAqzVi2g=;
	b=Zm3P9iJTJ8mO5S5eX+Jc9Brq+0a1lqeOIdq3AVXGScSIJd9rYI9F5HIqSODrzPVDteFT1Q
	osuJ5fErGfLL0JAw==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-bcm7038-l1: Fix section mismatch
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-4-johan@kernel.org>
References: <20251013094611.11745-4-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060830163.709179.18286081525366601027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     e9db5332caaf4789ae3bafe72f61ad8e6e0c2d81
Gitweb:        https://git.kernel.org/tip/e9db5332caaf4789ae3bafe72f61ad8e6e0=
c2d81
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:30:37 +02:00

irqchip/irq-bcm7038-l1: Fix section mismatch

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callback must not live in init.

Fixes: c057c799e379 ("irqchip/irq-bcm7038-l1: Switch to IRQCHIP_PLATFORM_DRIV=
ER")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/irqchip/irq-bcm7038-l1.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7038-l1.c b/drivers/irqchip/irq-bcm7038-l=
1.c
index 04fac0c..eda33bd 100644
--- a/drivers/irqchip/irq-bcm7038-l1.c
+++ b/drivers/irqchip/irq-bcm7038-l1.c
@@ -219,9 +219,8 @@ static int bcm7038_l1_set_affinity(struct irq_data *d,
 }
 #endif
=20
-static int __init bcm7038_l1_init_one(struct device_node *dn,
-				      unsigned int idx,
-				      struct bcm7038_l1_chip *intc)
+static int bcm7038_l1_init_one(struct device_node *dn, unsigned int idx,
+			       struct bcm7038_l1_chip *intc)
 {
 	struct resource res;
 	resource_size_t sz;
@@ -395,8 +394,7 @@ static const struct irq_domain_ops bcm7038_l1_domain_ops =
=3D {
 	.map			=3D bcm7038_l1_map,
 };
=20
-static int __init bcm7038_l1_of_init(struct device_node *dn,
-			      struct device_node *parent)
+static int bcm7038_l1_of_init(struct device_node *dn, struct device_node *pa=
rent)
 {
 	struct bcm7038_l1_chip *intc;
 	int idx, ret;

