Return-Path: <linux-tip-commits+bounces-1723-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DF34E9351C1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:41:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 696F5B23528
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EA731474AB;
	Thu, 18 Jul 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="weermHyb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/0bRynFg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1A01465AE;
	Thu, 18 Jul 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327948; cv=none; b=WHK8HmpMYG8Z4yFK+C+c0vC1VuwbFFv/AralRPaD6jQpwW2dTd7gw1EEGi5Gtt9XYuesE9UMGlNPYwfAaH9UMK9qQpTseWwsHcXGf1IFzSNwUS3vVDDcq6O1BnQ75ThyaEyczD5ofOP4gQAwnVGFuYAzsuAsdQXQxhMysPIm3xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327948; c=relaxed/simple;
	bh=ok987/txePZbXqhF7hJHDyiOM9ruFsizsOTHA/2Qdm4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aC9wnvGTm2W/oTdVXnTBcXGCymd6i8ZvTIUCP2YTG8QHv3+Czdrbrp70U6Qzealg7DTXueyQ3qENzNoa/j8/Iw2ZtY8hA+0kD+qj6wEfU02X5edELnftXI3AbQkL2Eg8cn/JejjxmQq60GcZiJOBGaCNz1rwNKqCar7ubaifq9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=weermHyb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/0bRynFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327942;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eagAw/xZooiUNSwUszxiG/VwWiDITRtFHvVdQKTUE8Y=;
	b=weermHyb9hDvFDP+oLwRcZ/LIhwHt0GMrWKac3fbDDWfrTJoU8Hx6jVlVru8boTsvG5B8Y
	F7gklthQkmgdE5mBCttE7gPi0G4Xgr+Bkz9Puk2cJ6pTUalLW+CtN2cnI77z2j62MGwTRt
	m02rYQr9EkdoLiwhknwdj1zq9C/fF4/T49gfezjG+3o9zGrjLy+sLHf/8AJwaES62DcPA8
	Li1PSrdqTEgbZv0YMsV4UPsySDZHsi6lK6n72Ns6geiKgq+Dg+COac+ZKD4pB9gkijBL8A
	1dNls2K0lSpVG7emWNQtoTj57itKflOxC8IFAHOtcZA0mTJCG6Q/HNb42an7GA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327942;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eagAw/xZooiUNSwUszxiG/VwWiDITRtFHvVdQKTUE8Y=;
	b=/0bRynFgEjOJs/gKZv04zdxUBQbW2F3DNZ0GG1SFGB4z4lGrTyVxxnKQuASmphAuvKWrSu
	TvLIILiwW7Vm/qBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142234.964056815@linutronix.de>
References: <20240623142234.964056815@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794177.2215.16129449215307848715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     8c41ccec839c622b2d1be769a95405e4e9a4cb20
Gitweb:        https://git.kernel.org/tip/8c41ccec839c622b2d1be769a95405e4e9a4cb20
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:19 +02:00

irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX

Add the bus tokens for DOMAIN_BUS_PCI_DEVICE_MSI and
DOMAIN_BUS_PCI_DEVICE_MSIX to the common child init
function.

Provide the match mask which can be used by parent domain
implementation so the bitmask based child bus token match
works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142234.964056815@linutronix.de



---
 drivers/irqchip/irq-msi-lib.c | 11 ++++++++++-
 drivers/irqchip/irq-msi-lib.h |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index ec1a10f..ef26962 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -28,6 +28,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 			       struct msi_domain_info *info)
 {
 	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+	u32 required_flags;
 
 	/* Parent ops available? */
 	if (WARN_ON_ONCE(!pops))
@@ -46,8 +47,16 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		return false;
 	}
 
+	required_flags = pops->required_flags;
+
 	/* Is the target domain bus token supported? */
 	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
+			return false;
+
+		break;
 	default:
 		/*
 		 * This should never be reached. See
@@ -63,7 +72,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	 */
 	info->flags			&= pops->supported_flags;
 	/* Enforce the required flags */
-	info->flags			|= pops->required_flags;
+	info->flags			|= required_flags;
 
 	/* Chip updates for all child bus types */
 	if (!info->chip->irq_eoi)
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
index f0706cc..525aa52 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -9,6 +9,12 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 

