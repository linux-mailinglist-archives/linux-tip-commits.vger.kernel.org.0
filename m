Return-Path: <linux-tip-commits+bounces-2027-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 149E994D858
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 23:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 874E51F22ABA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 21:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC571684BB;
	Fri,  9 Aug 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tJRYBj7n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n/8S+fIY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F26015F303;
	Fri,  9 Aug 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238083; cv=none; b=HsNNVdyHhZIVAzk151lEcdqqVIaGYrBr6PTRxzjNkCvqbjnNR1vZDq6CkEcQ2yKbE1t6m2nW+Ot4yEzClr6XH8YICHMZgn0FNGQVsnAZY7gWBnCTRY1tG+7fj2mM2OLbhpG0jBRrESDzmD7imQ2xEIyIJzYVx9ASCec15oRqD6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238083; c=relaxed/simple;
	bh=U6a3iEviCwG3zeipYN3iYiHJFK4yUVFhMC9cJf851nY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IrA++3/cbXXf9H15acONur7O/t3nXVy+QIc2k/O1bKXilb0cmUmloNWbFJDSduDhOw9g2vf/Fkm4CElqQwrcAolaaKFzQra1PZnPuKaZ7Z5BwdlqZWatEXckENMU9QsD6ZojBfBLgzE6OOBnsXniUosbTLyBEYFPvovnnOl1bbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tJRYBj7n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n/8S+fIY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Aug 2024 21:14:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723238079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtBtOxQsiuXWhnafuv1qJ+irIIkBvu7FL+YS0Ejs9TY=;
	b=tJRYBj7n+INvQyk93tWzVrN202B0WXlbR1pHMY5wcBEavdrs99fLGkB5IpJRt1m4gWHrGg
	ct++3hB3LwcOZ/6Ep7UfecV/vqiouWt7xgOB6fL/y2XZ68N3LfMkFIkvyaqyN2HOs6R90r
	FVGEWvlt8erdxL32q5zEIdliGU44PJInUtIm/lXM564x3963JJKbHYVeJ4HAUbd5UvMsDs
	HhBlZ+n78o4adXEaIA/fl9TlqgmkTVmNJRBgtzVD8mKv5vfd7R7XO4koahz8lVwc61zxc5
	qvFUEhu2kskmLXYTuNS+RFdg7DkIRxpovmgOQ9Z0O6VnDmOvoBelIrQLiWK+9Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723238079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RtBtOxQsiuXWhnafuv1qJ+irIIkBvu7FL+YS0Ejs9TY=;
	b=n/8S+fIY+VsSNqIwci3fUUXbGO3lwNh5OU1lPXLOnpKdhIGdgkM6ppgx1mkQPe9a7wUyYL
	ZuzqonLbjesbBoDw==
From: "tip-bot2 for Matti Vaittinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Simplify simple and legacy domain creation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <mazziesaccount@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: =?utf-8?q?=3C32d07bd79eb2b5416e24da9e9e8fe5955423dcf9=2E17231?=
 =?utf-8?q?20028=2Egit=2Emazziesaccount=40gmail=2Ecom=3E?=
References: =?utf-8?q?=3C32d07bd79eb2b5416e24da9e9e8fe5955423dcf9=2E172312?=
 =?utf-8?q?0028=2Egit=2Emazziesaccount=40gmail=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172323807933.2215.4880681701763617418.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     70114e7f7585ef078c2b7033ee14218f95f55e22
Gitweb:        https://git.kernel.org/tip/70114e7f7585ef078c2b7033ee14218f95f55e22
Author:        Matti Vaittinen <mazziesaccount@gmail.com>
AuthorDate:    Thu, 08 Aug 2024 15:34:02 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 09 Aug 2024 22:37:54 +02:00

irqdomain: Simplify simple and legacy domain creation

irq_domain_create_simple() and irq_domain_create_legacy() use
__irq_domain_instantiate(), but have extra handling of allocating interrupt
descriptors and associating interrupts in them. Some of that is duplicated.

There are also call sites which have conditonals to invoke different
interrupt domain creator functions, where one of them is usually
irq_domain_create_legacy(). Alternatively they associate the interrupts for
the legacy case after creating the domain.

Moving the extra logic of irq_domain_create_simple()/legacy() into
__irq_domain_instantiate() allows to consolidate that.

Introduce hwirq_base and virq_base members in the irq_domain_info
structure, which allows to transport the required information and add the
conditional interrupt descriptor allocation and interrupt association into
__irq_domain_instantiate().

This reduces irq_domain_create_legacy() and irq_domain_create_simple() to
trivial wrappers which fill in the info structure and allows call sites
which must support the legacy case along with more modern mechanism to
select the domain type via the parameters of the info struct.

[ tglx: Massaged change log ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/32d07bd79eb2b5416e24da9e9e8fe5955423dcf9.1723120028.git.mazziesaccount@gmail.com
---
 include/linux/irqdomain.h |  5 +++-
 kernel/irq/irqdomain.c    | 74 +++++++++++++++++++++-----------------
 2 files changed, 46 insertions(+), 33 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index de6105f..bfcffa2 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -291,6 +291,9 @@ struct irq_domain_chip_generic_info;
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
+ * @hwirq_base:		The first hardware interrupt number (legacy domains only)
+ * @virq_base:		The first Linux interrupt number for legacy domains to
+ *			immediately associate the interrupts after domain creation
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
@@ -307,6 +310,8 @@ struct irq_domain_info {
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
+	unsigned int				hwirq_base;
+	unsigned int				virq_base;
 	enum irq_domain_bus_token		bus_token;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index cea8f68..7625e42 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -267,13 +267,20 @@ static void irq_domain_free(struct irq_domain *domain)
 	kfree(domain);
 }
 
-/**
- * irq_domain_instantiate() - Instantiate a new irq domain data structure
- * @info: Domain information pointer pointing to the information for this domain
- *
- * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
- */
-struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+static void irq_domain_instantiate_descs(const struct irq_domain_info *info)
+{
+	if (!IS_ENABLED(CONFIG_SPARSE_IRQ))
+		return;
+
+	if (irq_alloc_descs(info->virq_base, info->virq_base, info->size,
+			    of_node_to_nid(to_of_node(info->fwnode))) < 0) {
+		pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
+			info->virq_base);
+	}
+}
+
+static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_info *info,
+						   bool cond_alloc_descs)
 {
 	struct irq_domain *domain;
 	int err;
@@ -306,6 +313,15 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 
 	__irq_domain_publish(domain);
 
+	if (cond_alloc_descs && info->virq_base > 0)
+		irq_domain_instantiate_descs(info);
+
+	/* Legacy interrupt domains have a fixed Linux interrupt number */
+	if (info->virq_base > 0) {
+		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base,
+					  info->size - info->hwirq_base);
+	}
+
 	return domain;
 
 err_domain_gc_remove:
@@ -315,6 +331,17 @@ err_domain_free:
 	irq_domain_free(domain);
 	return ERR_PTR(err);
 }
+
+/**
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+{
+	return __irq_domain_instantiate(info, false);
+}
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
 /**
@@ -413,28 +440,13 @@ struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 		.fwnode		= fwnode,
 		.size		= size,
 		.hwirq_max	= size,
+		.virq_base	= first_irq,
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *domain;
-
-	domain = irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
+	struct irq_domain *domain = __irq_domain_instantiate(&info, true);
 
-	if (first_irq > 0) {
-		if (IS_ENABLED(CONFIG_SPARSE_IRQ)) {
-			/* attempt to allocated irq_descs */
-			int rc = irq_alloc_descs(first_irq, first_irq, size,
-						 of_node_to_nid(to_of_node(fwnode)));
-			if (rc < 0)
-				pr_info("Cannot allocate irq_descs @ IRQ%d, assuming pre-allocated\n",
-					first_irq);
-		}
-		irq_domain_associate_many(domain, first_irq, 0, size);
-	}
-
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_simple);
 
@@ -476,18 +488,14 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 		.fwnode		= fwnode,
 		.size		= first_hwirq + size,
 		.hwirq_max	= first_hwirq + size,
+		.hwirq_base	= first_hwirq,
+		.virq_base	= first_irq,
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *domain;
+	struct irq_domain *domain = irq_domain_instantiate(&info);
 
-	domain = irq_domain_instantiate(&info);
-	if (IS_ERR(domain))
-		return NULL;
-
-	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
-
-	return domain;
+	return IS_ERR(domain) ? NULL : domain;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
 

