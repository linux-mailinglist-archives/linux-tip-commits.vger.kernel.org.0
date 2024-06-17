Return-Path: <linux-tip-commits+bounces-1425-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8FD90B610
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 18:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2856CB2F745
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ED381D6E24;
	Mon, 17 Jun 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xrofQSMb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/n1V96s"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A8C1D5432;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632282; cv=none; b=JZP8BFnsfRPSWqmISvn+E0OlwAelbjLVAVQFqB+d3+eCR53AxgWxSL/OIEVLvmxg124X3byDmFmSQuAugvPhJNSlBek3KcGU6nJj9CrMO8mKUgVBk5JQyU+FqrILzmIWBf+a+Jc8iJLtzlYeFrwTZaNvZC/usibK+kS65WSvNj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632282; c=relaxed/simple;
	bh=BuUt1JHbtP5wUi+IvtuWR6CWJskc2G63YbAG6SyXTGs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=COZiZlyCtsaG1AiTPCfiuYwAPGwyVB0hdVpF+E8LXC4RzQg4oZ+MmPouIYNxb0YmHoE5EjZyizJWbfVYNWXuwCAaLM9EjrY5oCjKV5F3xaJ3vk+/YKBJo4HlMCHXm8MrrNBjMrP1q2Unig06C6bo8AWXnGwCF04D9dw8b++BcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xrofQSMb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/n1V96s; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHhMRyCMug25ENcxmuthGUUWZdySm7pVbEGEDEs3naw=;
	b=xrofQSMbq/1D3BlqRvnZ4NJnipS/Og+P5CVfyxDRYVgow21OJ3sH5E0ShoobIeGnJ3gmqh
	rJZk9ZQSgAfpwOJFshCXuTm2PfS8q25WMrGIJS0GJ12wmcOmE9fbza7N3IU9yenboBlUE0
	SuJcIz06q6b8NpsTL3RZcLBWWin5gDsz/sgLAnO7MtjRq8pSudLMnCQdYEfts8zP89fkMC
	SbjJp2rDV54H+2FCADvmvw/dO545kJPXLpsZmcMs6+OshN0G8r3/StgHnGYZ789N9wA5jx
	L2OlGTR2IpjcqseXcpCOzbmLXKVRrLllzqysQxp0wCgq/0C+P+oIL7bEps0ySg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHhMRyCMug25ENcxmuthGUUWZdySm7pVbEGEDEs3naw=;
	b=h/n1V96spajLDlijh2tkZE1k0+bf0FalKIKLYyJr0QXl16LmaIp6PvWCM/0loH5LHfnAzX
	8Obd0AMS0ZB6vOCg==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Introduce irq_domain_instantiate()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-3-herve.codina@bootlin.com>
References: <20240614173232.1184015-3-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227418.10875.1828171038044089465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     299d623f5c9ab48e53255cf6b510627f1ef26dfe
Gitweb:        https://git.kernel.org/tip/299d623f5c9ab48e53255cf6b510627f1ef26dfe
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:13 +02:00

irqdomain: Introduce irq_domain_instantiate()

The existing irq_domain_add_*() functions used to instantiate an IRQ
domain are wrappers built on top of __irq_domain_add() and describe the
domain properties using a bunch of parameters.

Adding more parameters and wrappers to hide new parameters in the
existing code lead to more and more code without any relevant value and
without any flexibility.

Introduce irq_domain_instantiate() where the interrupt domain properties
are given using a irq_domain_info structure instead of the bunch of
parameters to allow flexibility and easy evolution.

irq_domain_instantiate() performs the same operation as the one done by
__irq_domain_add(). For compatibility reason with existing code, keep
__irq_domain_add() but convert it to irq_domain_instantiate().

[ tglx: Fixed up struct initializer coding style ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-3-herve.codina@bootlin.com

---
 include/linux/irqdomain.h | 21 ++++++++++++++++++++-
 kernel/irq/irqdomain.c    | 39 +++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 21ecf58..ab8939c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -257,6 +257,27 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+/**
+ * struct irq_domain_info - Domain information structure
+ * @fwnode:		firmware node for the interrupt controller
+ * @size:		Size of linear map; 0 for radix mapping only
+ * @hwirq_max:		Maximum number of interrupts supported by controller
+ * @direct_max:		Maximum value of direct maps;
+ *			Use ~0 for no limit; 0 for no direct mapping
+ * @ops:		Domain operation callbacks
+ * @host_data:		Controller private data pointer
+ */
+struct irq_domain_info {
+	struct fwnode_handle			*fwnode;
+	unsigned int				size;
+	irq_hw_number_t				hwirq_max;
+	int					direct_max;
+	const struct irq_domain_ops		*ops;
+	void					*host_data;
+};
+
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
+
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 40b631b..111052f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -248,6 +248,27 @@ static void irq_domain_free(struct irq_domain *domain)
 }
 
 /**
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+
+	domain = __irq_domain_create(info->fwnode, info->size, info->hwirq_max,
+				     info->direct_max, info->ops, info->host_data);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	__irq_domain_publish(domain);
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(irq_domain_instantiate);
+
+/**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @fwnode: firmware node for the interrupt controller
  * @size: Size of linear map; 0 for radix mapping only
@@ -265,14 +286,18 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
 {
-	struct irq_domain *domain;
-
-	domain = __irq_domain_create(fwnode, size, hwirq_max, direct_max,
-				     ops, host_data);
-	if (domain)
-		__irq_domain_publish(domain);
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.size		= size,
+		.hwirq_max	= hwirq_max,
+		.direct_max	= direct_max,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
+	struct irq_domain *d;
 
-	return domain;
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 EXPORT_SYMBOL_GPL(__irq_domain_add);
 

