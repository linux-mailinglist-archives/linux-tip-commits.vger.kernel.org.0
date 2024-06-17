Return-Path: <linux-tip-commits+bounces-1406-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AF9690B2B7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:46:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 037131C23424
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2F9A1D191F;
	Mon, 17 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2GU6Cm+H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tgwm/tPB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 957C71D18EA;
	Mon, 17 Jun 2024 13:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632273; cv=none; b=Vrvl+n7Kme+bpTdl/O0ZHVvtpQozOzKeYkM6sM+tW7kMYGhAvYZnuPCtWPlDh1zVaHU72zKQq+H9iW9xcWQDiRc61GrjAjRxNazVDLMUYP05cl/2MTlTpGxXc9FahCE+dYFiuAG4vfhc4qe581HlcU49P1fP4mE4aIXvRJRb8xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632273; c=relaxed/simple;
	bh=Pm4faYVykkcXdU+VaMOQQ94QueMr8h7aGqbVVgZr+8k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WAuw/0kKw0Y2xH6d3pm43Z/xtEv57W2VomG/bj6vFUoC6bYjmlyr1vPfNl4TP9e1wWJE0/f+33lx6YfBy4c+yGVYwXQSgOKxksoyRNU8hCt21NCqRE/2cGY8GQoV3Sjv+YV2a78nUuPD2c5ahJTf+7fHoHd0tM0SwmKBpC1obu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2GU6Cm+H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tgwm/tPB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vahR3jsS8CtTwwY5H5t42TcBcOkT6KsvbxVrMSiUt7I=;
	b=2GU6Cm+H4G3rs9zjDLgq0gjfuQ/yUyD04paScA9Ot/qX9TLgPaWpoe8JQ7SstAszuxnN8x
	QYKhNw4XndpJ6te0BW/+RuWsX5eHE17qS0GyIYLxiRidmwhD+0p5YnwQ/SvXX6OaJJ0jHr
	MDxliUW2KwNAq0D5UCSH5ZXbA/zLtFKYdZH9lk6SPc1U9UU1HCfoxxN9OeY4dCKjDbE9SN
	DiigC/AW+lVGFlvtPiKaQiE2ggGPR02cVO72uO6fTuDLi1rNI5FkjrbJzhh2A0tB8vi5RA
	6RgRFlyLu8nNNyo1f600oH9DeQWtZPoTGmc8A+aVuxoCrbed4Mws26lPvKij3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vahR3jsS8CtTwwY5H5t42TcBcOkT6KsvbxVrMSiUt7I=;
	b=tgwm/tPBmTVhTIMHAqoV1T/ID+cUer3idrGHAj5tB1v14q/ZpCMUJMmF1X0iQ6XeD+l0Jl
	s8vP6Gz4Cdykp5Bw==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Remove __irq_domain_add()
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-21-herve.codina@bootlin.com>
References: <20240614173232.1184015-21-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226851.10875.3080035403553714457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0b4b172b760efabf8a77ea17644d333fbb444d39
Gitweb:        https://git.kernel.org/tip/0b4b172b760efabf8a77ea17644d333fbb444d39
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:21 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:15 +02:00

irqdomain: Remove __irq_domain_add()

__irq_domain_add() has been replaced by irq_domain_instanciate() and so,
it is no more used.

Simply remove it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-21-herve.codina@bootlin.com

---
 include/linux/irqdomain.h |  6 +-----
 kernel/irq/irqdomain.c    | 33 ---------------------------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 33a968f..02cd486 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -184,7 +184,7 @@ enum {
 	/* Irq domain is hierarchical */
 	IRQ_DOMAIN_FLAG_HIERARCHY	= (1 << 0),
 
-	/* Irq domain name was allocated in __irq_domain_add() */
+	/* Irq domain name was allocated internally */
 	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 1),
 
 	/* Irq domain is an IPI domain with virq per cpu */
@@ -307,10 +307,6 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
 struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
 					       const struct irq_domain_info *info);
 
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data);
 struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index c9b076c..91eaf6b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -318,39 +318,6 @@ err_domain_free:
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
 /**
- * __irq_domain_add() - Allocate a new irq_domain data structure
- * @fwnode: firmware node for the interrupt controller
- * @size: Size of linear map; 0 for radix mapping only
- * @hwirq_max: Maximum number of interrupts supported by controller
- * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
- *              direct mapping
- * @ops: domain callbacks
- * @host_data: Controller private data pointer
- *
- * Allocates and initializes an irq_domain structure.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
-{
-	struct irq_domain_info info = {
-		.fwnode		= fwnode,
-		.size		= size,
-		.hwirq_max	= hwirq_max,
-		.direct_max	= direct_max,
-		.ops		= ops,
-		.host_data	= host_data,
-	};
-	struct irq_domain *d;
-
-	d = irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-EXPORT_SYMBOL_GPL(__irq_domain_add);
-
-/**
  * irq_domain_remove() - Remove an irq domain.
  * @domain: domain to remove
  *

