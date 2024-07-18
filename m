Return-Path: <linux-tip-commits+bounces-1707-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2064B9351A6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3B2828385C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:39:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2651D145339;
	Thu, 18 Jul 2024 18:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SUY5dufw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oXwkTbJS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDC842045;
	Thu, 18 Jul 2024 18:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327941; cv=none; b=V5M23zQYTMPEb0AA1KNp6huosQxbefiohAJrCkSyDVYGjHSae0BS1Ba7mWvFMcJoJpYiXGpi66LVYAs578qDihO5GMqxQQIN7ihd2ejSGX6QcnlxmofseR+0myZMmU0Xg0cYZX1/w7c0+us2pTT518hoDsKCZ46K4eTamGJKZPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327941; c=relaxed/simple;
	bh=bo/qiW923niAFPcAErPrZxCJiCrY0I+nt+FDwNjiAr4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BUY2C7FiVsgTEJ7/SKSLWrmNy9wGL6R4O05pXaTtmqVHEgU7JAclhRqzvzyi78onTOKFN+yWEo0EXk/5BKnzoiyrmUqDWTTtRBFOTCxMboxfmPZQX0/rXxj9oDS8D305fzK+eWgrP2rTdoP8D+VkG5IbJeHca7AsuCPa2e27s3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SUY5dufw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oXwkTbJS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:38:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKa+pZogmcMEH9PHSfe+3XvoQwjDiXyuNUSrBGdjhV8=;
	b=SUY5dufw6i8gpF9TM5cAjGp2bdLC58fUCoQo8qbDgB8oOA8KW/C5LaGWb+5nMLKMuNLvsb
	fyqCCJa/hT8aKjjQ267VsBO2/ngJ2YykjI3TW59AoAQitWxVXNw8c3SKQjtDl/QlLy3NWt
	6/FXOB4ygv8UQ0wtf/Q0X2QzAZ7Q9EAwrvQn7sQ8DkQYx5xv5+OSR4W/3dCCHyrJNpdojc
	lbsRZlOciTTiHfsznBj6BzjAp9UFOyEwgA4tsT878bEzFFpKlKeTR7xslYqTo34WMdmtz3
	EfU4boEEnDt3wVYYAAaASSSyhUenzMMyelVVB48fiHbwHlUl3SXcfZL0IDkhyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327937;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sKa+pZogmcMEH9PHSfe+3XvoQwjDiXyuNUSrBGdjhV8=;
	b=oXwkTbJS3+Duq/oVbt7IVv5N53LnF8PuiwEuc535FBC6TLta0Lo+tLOf29U3zE78FUv1u6
	HOhZNx4/ZBkS86BA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v3-its: Correctly fish out the DID for
 platform MSI
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240718075804.2245733-1-maz@kernel.org>
References: <20240718075804.2245733-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132793701.2215.17163734190084832644.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     c9b4f313f6b83ac80e9d51845d092c32513efdb4
Gitweb:        https://git.kernel.org/tip/c9b4f313f6b83ac80e9d51845d092c32513efdb4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 18 Jul 2024 08:58:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:34:46 +02:00

irqchip/gic-v3-its: Correctly fish out the DID for platform MSI

Similarly to PCI where msi-map/msi-mask are used to compute the full RID
(aka DID in ITS speak), use the msi-parent as the discovery mechanism,
since there is no way a device can generally express its ID.

However, since switching to a per-device MSI domain model, the domain
passed to its_pmsi_prepare() is the wrong one, and points to the device's
instead of the ITS'. Bad.

Use the parent domain instead, which is the ITS domain.

Fixes: 80b63cc1cc146 ("irqchip/gic-v3-its: Switch platform MSI to MSI parent")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240718075804.2245733-1-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 2f3fc59..e150365 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -134,7 +134,7 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	int ret;
 
 	if (dev->of_node)
-		ret = of_pmsi_get_dev_id(domain, dev, &dev_id);
+		ret = of_pmsi_get_dev_id(domain->parent, dev, &dev_id);
 	else
 		ret = iort_pmsi_get_dev_id(dev, &dev_id);
 	if (ret)

