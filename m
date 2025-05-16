Return-Path: <linux-tip-commits+bounces-5573-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 19196AB999F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23AAD4E1E22
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BF3A23505C;
	Fri, 16 May 2025 10:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uRr7Qu9l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KGeXA877"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73D18233159;
	Fri, 16 May 2025 10:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389743; cv=none; b=gmphRxqESgqagxHP+fuNznq/8psmbZzi+zD1wyPEuFTuTihgADrkvN9oxfYqql1TJHLZ7ij18t6iYZcNRu4oC+bVB9v1dli+tjGXeOJA3QGOGKWq7J0dRCtjRcze6YF8CsChTDXIzGsOE5MZ3TzKQNg7x+TIuXAAePza3zvS2jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389743; c=relaxed/simple;
	bh=POT3/ARw8CZNImRu6cSb6dfx9z05W9sH1VxYnnjoDmg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RqmLUbo0KIuqotAU6twW6XKPBF9KKBngN2zWXIH3xXLIZe63e94YKz+LJGcCYTvm5JWDLn44BL0PCvCZOAOzThzFlLhkroVYrLqk98b1cGZmJXmPt2vyiz26bD1wAgexELQQNXDD2eJ71ZMFpSLok1eYV9fCFt+JgidkMOgRPlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uRr7Qu9l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KGeXA877; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 10:02:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747389739;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soz40sqw1VYB3Y1tnkxsfAHN8G757uOiEiMfGYkCA14=;
	b=uRr7Qu9lXZB0ZZeu2RuSnj1Cjb6fbVJYrk7l6lc8iLDlNa1d4McL3jJ0kySiMLzubJaQO5
	WYE9vz/ojlSE/sCeSaXRnTT56nLQbdgLEx9T4yR6f2vpTqsO+D9tDYfu36h0mD5Y5kg9hW
	5jZt8dzp1NCnZfw/ETcCz1vGGTj3z78VEvW/ASaDvYkHYi4HL0FqRA63qQ1Dn2AxwqZWtP
	TRdIxi3ntHrxVqCkd1+D2ZDRDREjVyYKmVYthlp3bUK/5Mw+arcCtoqPiVpTzUXjbeXYV5
	coo+xEUEFPX46AP2thuhH6IAAYQEJ+3r1kHICKnC600/qV0EAvEKJoS5wT74ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747389739;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=soz40sqw1VYB3Y1tnkxsfAHN8G757uOiEiMfGYkCA14=;
	b=KGeXA877J87cxO/K4mQbP7Z4/MD0QqTODT3YYL/VfER0G3ktrzdVFG4M33nijSi63prGIQ
	vdnbt9eM7K2c5rBA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v3-its: Implement .msi_teardown() callback
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513163144.2215824-3-maz@kernel.org>
References: <20250513163144.2215824-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738973829.406.14237643898316030412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     713335b6ee29f0045737a1ddfc685bc6040d4baf
Gitweb:        https://git.kernel.org/tip/713335b6ee29f0045737a1ddfc685bc6040d4baf
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 17:31:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 May 2025 12:36:41 +02:00

irqchip/gic-v3-its: Implement .msi_teardown() callback

The ITS driver currently nukes the structure representing an endpoint
device translating via an ITS on freeing the last LPI allocated for it.

That's an unfortunate state of affair, as it is pretty common for a driver
to allocate a single MSI, do something clever, teardown this MSI, and
reallocate a whole bunch of them. The NVME driver does exactly that,
amongst others.

What happens in that case is that the core code is accidentaly issuing
another .msi_prepare() call, even if it shouldn't.  This luckily cancels
the above behaviour and hides the problem.

In order to fix the core code, start by implementing the new
.msi_teardown() callback. Nothing calls it yet, so a side effect is that
the its_dev structure will not be freed and that the DID will stay
mapped. Not a big deal, and this will be solved in following patches.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513163144.2215824-3-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 10 ++++-
 drivers/irqchip/irq-gic-v3-its.c            | 46 ++++++++++----------
 kernel/irq/msi.c                            |  3 +-
 3 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 68f9ba4..9587366 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -167,6 +167,14 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 					  dev, nvec, info);
 }
 
+static void its_msi_teardown(struct irq_domain *domain, msi_alloc_info_t *info)
+{
+	struct msi_domain_info *msi_info;
+
+	msi_info = msi_get_domain_info(domain->parent);
+	msi_info->ops->msi_teardown(domain->parent, info);
+}
+
 static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 				  struct irq_domain *real_parent, struct msi_domain_info *info)
 {
@@ -190,6 +198,7 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		 * %MSI_MAX_INDEX.
 		 */
 		info->ops->msi_prepare = its_pci_msi_prepare;
+		info->ops->msi_teardown = its_msi_teardown;
 		break;
 	case DOMAIN_BUS_DEVICE_MSI:
 	case DOMAIN_BUS_WIRED_TO_MSI:
@@ -198,6 +207,7 @@ static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		 * size is also known at domain creation time.
 		 */
 		info->ops->msi_prepare = its_pmsi_prepare;
+		info->ops->msi_teardown = its_msi_teardown;
 		break;
 	default:
 		/* Confused. How did the lib return true? */
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index fd6e7c1..a77f11e 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3620,8 +3620,33 @@ out:
 	return err;
 }
 
+static void its_msi_teardown(struct irq_domain *domain, msi_alloc_info_t *info)
+{
+	struct its_device *its_dev = info->scratchpad[0].ptr;
+
+	guard(mutex)(&its_dev->its->dev_alloc_lock);
+
+	/* If the device is shared, keep everything around */
+	if (its_dev->shared)
+		return;
+
+	/* LPIs should have been already unmapped at this stage */
+	if (WARN_ON_ONCE(!bitmap_empty(its_dev->event_map.lpi_map,
+				       its_dev->event_map.nr_lpis)))
+		return;
+
+	its_lpi_free(its_dev->event_map.lpi_map,
+		     its_dev->event_map.lpi_base,
+		     its_dev->event_map.nr_lpis);
+
+	/* Unmap device/itt, and get rid of the tracking */
+	its_send_mapd(its_dev, 0);
+	its_free_device(its_dev);
+}
+
 static struct msi_domain_ops its_msi_domain_ops = {
 	.msi_prepare	= its_msi_prepare,
+	.msi_teardown	= its_msi_teardown,
 };
 
 static int its_irq_gic_domain_alloc(struct irq_domain *domain,
@@ -3722,7 +3747,6 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 {
 	struct irq_data *d = irq_domain_get_irq_data(domain, virq);
 	struct its_device *its_dev = irq_data_get_irq_chip_data(d);
-	struct its_node *its = its_dev->its;
 	int i;
 
 	bitmap_release_region(its_dev->event_map.lpi_map,
@@ -3736,26 +3760,6 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		irq_domain_reset_irq_data(data);
 	}
 
-	mutex_lock(&its->dev_alloc_lock);
-
-	/*
-	 * If all interrupts have been freed, start mopping the
-	 * floor. This is conditioned on the device not being shared.
-	 */
-	if (!its_dev->shared &&
-	    bitmap_empty(its_dev->event_map.lpi_map,
-			 its_dev->event_map.nr_lpis)) {
-		its_lpi_free(its_dev->event_map.lpi_map,
-			     its_dev->event_map.lpi_base,
-			     its_dev->event_map.nr_lpis);
-
-		/* Unmap device/itt */
-		its_send_mapd(its_dev, 0);
-		its_free_device(its_dev);
-	}
-
-	mutex_unlock(&its->dev_alloc_lock);
-
 	irq_domain_free_irqs_parent(domain, virq, nr_irqs);
 }
 
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 7f0dfe0..00f4d87 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -795,8 +795,7 @@ static int msi_domain_ops_prepare(struct irq_domain *domain, struct device *dev,
 	return 0;
 }
 
-static void msi_domain_ops_teardown(struct irq_domain *domain,
-				    msi_alloc_info_t *arg)
+static void msi_domain_ops_teardown(struct irq_domain *domain, msi_alloc_info_t *arg)
 {
 }
 

