Return-Path: <linux-tip-commits+bounces-5416-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A70EEAADC66
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 12:26:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6E4B1C00E58
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51BE32139B0;
	Wed,  7 May 2025 10:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q56zlVXW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tqZNOqIV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E46B8210185;
	Wed,  7 May 2025 10:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746613575; cv=none; b=dpHvhIVKAqEbf4vyL4yXKrBLmit9Y5Ab98hBGji01QZTFV1viqRMFJe5KVA7qpEnoeiNsn9+YASq14jdlqMogxHPN63u9vR9alpUCuh9Qtn36CK3HcsjPpfQgD0dDHW1yhlAV5hp7ZL3XIPeBE3RDoIeghhtgHVd/n6RBTg1bZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746613575; c=relaxed/simple;
	bh=P4Rmk7zqkOBtJYnu54vJ7EQmYpq1VOIVl/jkh2k5fOU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MHcdfJF8caRq8HrnIImkhqQessKCtddQXC1hJ9bEekhGbyEZc6CtFRk+tZEOXS07nycvPv6Bymul5HECiPkur8O/uufbLNKuucPoCFZeu9VSbl5NvAyvunZfkVkAu/Jr0ntuIXA/u4J//O21WGHgt8S7ZQ2OTFtoW5k1vwaZ24w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q56zlVXW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tqZNOqIV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 10:26:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746613570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4Ug/1JYcubOrRS7mAj4HGia7t32tIksBAX3hizW9Jmk=;
	b=q56zlVXWmnxuIbINtoYihBfjcixvo370C2WXotV3EUPf6W5vLJa3W0L1eBcqHuKJNFIlDp
	DoPOT4Gj5XOlmuKteFc3KVrq7uxkfYYAhJtWRcCSRqo61ARRM7Rh65mzrvV3uYgk98or2L
	oQer3HwNr64IShyAuiJifwA1YNPT/xUKb3ESTEmB0zF5bsn9DCc7LXVoS9uD5R1UPNuYMY
	BWg8cjDW3oabBrsAXTfp8XovKbW0W99sqr+2yWXzrqSyPGP0t+Ly3uoT9pPImkBlKOI2oO
	Bti+BUB5L3fZkfeAmLdp5JMATfJzQWFbgzi/dLc8yt5/OH8LlhKcITzB5ltsAQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746613570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=4Ug/1JYcubOrRS7mAj4HGia7t32tIksBAX3hizW9Jmk=;
	b=tqZNOqIV9WrS8nbtMJfzrswvU34vUdrc2I/ZkD9zEeGHlImOFaAgnN3gWWOUuVicABgCk9
	qPzt6paNDXscGuAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: Consolidate coding style
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174661356932.406.8269713535832168901.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     b95a00df343eef56fa7489e5a2ac8308dce7e3c9
Gitweb:        https://git.kernel.org/tip/b95a00df343eef56fa7489e5a2ac8308dce7e3c9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 06 May 2025 14:22:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 12:24:05 +02:00

irqdomain: Consolidate coding style

Now that the file has been thrown through the mincer, finish the job and
consolidate the coding style.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irqdomain.h | 257 ++++++++++++++++---------------------
 1 file changed, 113 insertions(+), 144 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 1a1786d..2f6e4c9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -39,9 +39,9 @@ struct msi_parent_ops;
  * pass a device-specific description of an interrupt.
  */
 struct irq_fwspec {
-	struct fwnode_handle *fwnode;
-	int param_count;
-	u32 param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
+	struct fwnode_handle	*fwnode;
+	int			param_count;
+	u32			param[IRQ_DOMAIN_IRQ_SPEC_PARAMS];
 };
 
 /* Conversion function from of_phandle_args fields to fwspec  */
@@ -50,26 +50,26 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 
 /**
  * struct irq_domain_ops - Methods for irq_domain objects
- * @match: Match an interrupt controller device node to a domain, returns
- *         1 on a match
- * @select: Match an interrupt controller fw specification. It is more generic
- *	    than @match as it receives a complete struct irq_fwspec. Therefore,
- *	    @select is preferred if provided. Returns 1 on a match.
- * @map: Create or update a mapping between a virtual irq number and a hw
- *       irq number. This is called only once for a given mapping.
- * @unmap: Dispose of such a mapping
- * @xlate: Given a device tree node and interrupt specifier, decode
- *         the hardware irq number and linux irq type value.
- * @alloc: Allocate @nr_irqs interrupts starting from @virq.
- * @free: Free @nr_irqs interrupts starting from @virq.
- * @activate: Activate one interrupt in HW (@irqd). If @reserve is set, only
- *	      reserve the vector. If unset, assign the vector (called from
- *	      request_irq()).
- * @deactivate: Disarm one interrupt (@irqd).
- * @translate: Given @fwspec, decode the hardware irq number (@out_hwirq) and
- *	       linux irq type value (@out_type). This is a generalised @xlate
- *	       (over struct irq_fwspec) and is preferred if provided.
- * @debug_show: For domains to show specific data for an interrupt in debugfs.
+ * @match:	Match an interrupt controller device node to a domain, returns
+ *		1 on a match
+ * @select:	Match an interrupt controller fw specification. It is more generic
+ *		than @match as it receives a complete struct irq_fwspec. Therefore,
+ *		@select is preferred if provided. Returns 1 on a match.
+ * @map:	Create or update a mapping between a virtual irq number and a hw
+ *		irq number. This is called only once for a given mapping.
+ * @unmap:	Dispose of such a mapping
+ * @xlate:	Given a device tree node and interrupt specifier, decode
+ *		the hardware irq number and linux irq type value.
+ * @alloc:	Allocate @nr_irqs interrupts starting from @virq.
+ * @free:	Free @nr_irqs interrupts starting from @virq.
+ * @activate:	Activate one interrupt in HW (@irqd). If @reserve is set, only
+ *		reserve the vector. If unset, assign the vector (called from
+ *		request_irq()).
+ * @deactivate:	Disarm one interrupt (@irqd).
+ * @translate:	Given @fwspec, decode the hardware irq number (@out_hwirq) and
+ *		linux irq type value (@out_type). This is a generalised @xlate
+ *		(over struct irq_fwspec) and is preferred if provided.
+ * @debug_show:	For domains to show specific data for an interrupt in debugfs.
  *
  * Functions below are provided by the driver and called whenever a new mapping
  * is created or an old mapping is disposed. The driver can then proceed to
@@ -77,29 +77,29 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
  * to setup the irq_desc when returning from map().
  */
 struct irq_domain_ops {
-	int (*match)(struct irq_domain *d, struct device_node *node,
-		     enum irq_domain_bus_token bus_token);
-	int (*select)(struct irq_domain *d, struct irq_fwspec *fwspec,
-		      enum irq_domain_bus_token bus_token);
-	int (*map)(struct irq_domain *d, unsigned int virq, irq_hw_number_t hw);
-	void (*unmap)(struct irq_domain *d, unsigned int virq);
-	int (*xlate)(struct irq_domain *d, struct device_node *node,
-		     const u32 *intspec, unsigned int intsize,
-		     unsigned long *out_hwirq, unsigned int *out_type);
+	int	(*match)(struct irq_domain *d, struct device_node *node,
+			 enum irq_domain_bus_token bus_token);
+	int	(*select)(struct irq_domain *d, struct irq_fwspec *fwspec,
+			  enum irq_domain_bus_token bus_token);
+	int	(*map)(struct irq_domain *d, unsigned int virq, irq_hw_number_t hw);
+	void	(*unmap)(struct irq_domain *d, unsigned int virq);
+	int	(*xlate)(struct irq_domain *d, struct device_node *node,
+			 const u32 *intspec, unsigned int intsize,
+			 unsigned long *out_hwirq, unsigned int *out_type);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
 	/* extended V2 interfaces to support hierarchy irq_domains */
-	int (*alloc)(struct irq_domain *d, unsigned int virq,
-		     unsigned int nr_irqs, void *arg);
-	void (*free)(struct irq_domain *d, unsigned int virq,
-		     unsigned int nr_irqs);
-	int (*activate)(struct irq_domain *d, struct irq_data *irqd, bool reserve);
-	void (*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
-	int (*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
-			 unsigned long *out_hwirq, unsigned int *out_type);
+	int	(*alloc)(struct irq_domain *d, unsigned int virq,
+			 unsigned int nr_irqs, void *arg);
+	void	(*free)(struct irq_domain *d, unsigned int virq,
+			unsigned int nr_irqs);
+	int	(*activate)(struct irq_domain *d, struct irq_data *irqd, bool reserve);
+	void	(*deactivate)(struct irq_domain *d, struct irq_data *irq_data);
+	int	(*translate)(struct irq_domain *d, struct irq_fwspec *fwspec,
+			     unsigned long *out_hwirq, unsigned int *out_type);
 #endif
 #ifdef CONFIG_GENERIC_IRQ_DEBUGFS
-	void (*debug_show)(struct seq_file *m, struct irq_domain *d,
-			   struct irq_data *irqd, int ind);
+	void	(*debug_show)(struct seq_file *m, struct irq_domain *d,
+			      struct irq_data *irqd, int ind);
 #endif
 };
 
@@ -222,8 +222,7 @@ static inline struct device_node *irq_domain_get_of_node(struct irq_domain *d)
 	return to_of_node(d->fwnode);
 }
 
-static inline void irq_domain_set_pm_device(struct irq_domain *d,
-					    struct device *dev)
+static inline void irq_domain_set_pm_device(struct irq_domain *d, struct device *dev)
 {
 	if (d)
 		d->pm_dev = dev;
@@ -239,14 +238,12 @@ enum {
 	IRQCHIP_FWNODE_NAMED_ID,
 };
 
-static inline
-struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
+static inline struct fwnode_handle *irq_domain_alloc_named_fwnode(const char *name)
 {
 	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED, 0, name, NULL);
 }
 
-static inline
-struct fwnode_handle *irq_domain_alloc_named_id_fwnode(const char *name, int id)
+static inline struct fwnode_handle *irq_domain_alloc_named_id_fwnode(const char *name, int id)
 {
 	return __irq_domain_alloc_fwnode(IRQCHIP_FWNODE_NAMED_ID, id, name,
 					 NULL);
@@ -311,23 +308,17 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
 struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
 					       const struct irq_domain_info *info);
 
-struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
-					    unsigned int size,
+struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode, unsigned int size,
 					    unsigned int first_irq,
-					    const struct irq_domain_ops *ops,
-					    void *host_data);
-struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
-					    unsigned int size,
-					    unsigned int first_irq,
-					    irq_hw_number_t first_hwirq,
-					    const struct irq_domain_ops *ops,
-					    void *host_data);
+					    const struct irq_domain_ops *ops, void *host_data);
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode, unsigned int size,
+					    unsigned int first_irq, irq_hw_number_t first_hwirq,
+					    const struct irq_domain_ops *ops, void *host_data);
 struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 					    enum irq_domain_bus_token bus_token);
 void irq_set_default_domain(struct irq_domain *domain);
 struct irq_domain *irq_get_default_domain(void);
-int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
-			   irq_hw_number_t hwirq, int node,
+int irq_domain_alloc_descs(int virq, unsigned int nr_irqs, irq_hw_number_t hwirq, int node,
 			   const struct irq_affinity_desc *affinity);
 
 extern const struct fwnode_operations irqchip_fwnode_ops;
@@ -337,12 +328,10 @@ static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
 	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
 }
 
-void irq_domain_update_bus_token(struct irq_domain *domain,
-				 enum irq_domain_bus_token bus_token);
+void irq_domain_update_bus_token(struct irq_domain *domain, enum irq_domain_bus_token bus_token);
 
-static inline
-struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
-					    enum irq_domain_bus_token bus_token)
+static inline struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
+							  enum irq_domain_bus_token bus_token)
 {
 	struct irq_fwspec fwspec = {
 		.fwnode = fwnode,
@@ -370,9 +359,9 @@ static inline struct irq_domain *irq_find_host(struct device_node *node)
 
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
 static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *fwnode,
-					 unsigned int max_irq,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
+							 unsigned int max_irq,
+							 const struct irq_domain_ops *ops,
+							 void *host_data)
 {
 	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
@@ -391,17 +380,17 @@ unsigned int irq_create_direct_mapping(struct irq_domain *domain);
 
 /**
  * irq_domain_create_linear - Allocate and register a linear revmap irq_domain.
- * @fwnode: pointer to interrupt controller's FW node.
- * @size: Number of interrupts in the domain.
- * @ops: map/unmap domain callbacks
- * @host_data: Controller private data pointer
+ * @fwnode:	pointer to interrupt controller's FW node.
+ * @size:	Number of interrupts in the domain.
+ * @ops:	map/unmap domain callbacks
+ * @host_data:	Controller private data pointer
  *
  * Returns: Newly created irq_domain
  */
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
-					 unsigned int size,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
+							  unsigned int size,
+							  const struct irq_domain_ops *ops,
+							  void *host_data)
 {
 	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
@@ -416,8 +405,8 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 }
 
 static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fwnode,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
+							const struct irq_domain_ops *ops,
+							void *host_data)
 {
 	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
@@ -432,22 +421,19 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 
 void irq_domain_remove(struct irq_domain *domain);
 
-int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
-			 irq_hw_number_t hwirq);
-void irq_domain_associate_many(struct irq_domain *domain,
-			       unsigned int irq_base,
+int irq_domain_associate(struct irq_domain *domain, unsigned int irq, irq_hw_number_t hwirq);
+void irq_domain_associate_many(struct irq_domain *domain, unsigned int irq_base,
 			       irq_hw_number_t hwirq_base, int count);
 
-unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
-					 irq_hw_number_t hwirq,
+unsigned int irq_create_mapping_affinity(struct irq_domain *domain, irq_hw_number_t hwirq,
 					 const struct irq_affinity_desc *affinity);
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 void irq_dispose_mapping(unsigned int virq);
 
 /**
  * irq_create_mapping - Map a hardware interrupt into linux irq space
- * @domain: domain owning this hardware interrupt or NULL for default domain
- * @hwirq: hardware irq number in that domain space
+ * @domain:	domain owning this hardware interrupt or NULL for default domain
+ * @hwirq:	hardware irq number in that domain space
  *
  * Only one mapping per hardware interrupt is permitted.
  *
@@ -456,8 +442,7 @@ void irq_dispose_mapping(unsigned int virq);
  *
  * Returns: Linux irq number or 0 on error
  */
-static inline unsigned int irq_create_mapping(struct irq_domain *domain,
-					      irq_hw_number_t hwirq)
+static inline unsigned int irq_create_mapping(struct irq_domain *domain, irq_hw_number_t hwirq)
 {
 	return irq_create_mapping_affinity(domain, hwirq, NULL);
 }
@@ -468,8 +453,8 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 
 /**
  * irq_resolve_mapping - Find a linux irq from a hw irq number.
- * @domain: domain owning this hardware interrupt
- * @hwirq: hardware irq number in that domain space
+ * @domain:	domain owning this hardware interrupt
+ * @hwirq:	hardware irq number in that domain space
  *
  * Returns: Interrupt descriptor
  */
@@ -481,8 +466,8 @@ static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
 
 /**
  * irq_find_mapping() - Find a linux irq from a hw irq number.
- * @domain: domain owning this hardware interrupt
- * @hwirq: hardware irq number in that domain space
+ * @domain:	domain owning this hardware interrupt
+ * @hwirq:	hardware irq number in that domain space
  *
  * Returns: Linux irq number or 0 if not found
  */
@@ -501,14 +486,14 @@ extern const struct irq_domain_ops irq_domain_simple_ops;
 
 /* stock xlate functions */
 int irq_domain_xlate_onecell(struct irq_domain *d, struct device_node *ctrlr,
-			const u32 *intspec, unsigned int intsize,
-			irq_hw_number_t *out_hwirq, unsigned int *out_type);
+			     const u32 *intspec, unsigned int intsize,
+			     irq_hw_number_t *out_hwirq, unsigned int *out_type);
 int irq_domain_xlate_twocell(struct irq_domain *d, struct device_node *ctrlr,
-			const u32 *intspec, unsigned int intsize,
-			irq_hw_number_t *out_hwirq, unsigned int *out_type);
+			     const u32 *intspec, unsigned int intsize,
+			     irq_hw_number_t *out_hwirq, unsigned int *out_type);
 int irq_domain_xlate_onetwocell(struct irq_domain *d, struct device_node *ctrlr,
-			const u32 *intspec, unsigned int intsize,
-			irq_hw_number_t *out_hwirq, unsigned int *out_type);
+				const u32 *intspec, unsigned int intsize,
+				irq_hw_number_t *out_hwirq, unsigned int *out_type);
 int irq_domain_xlate_twothreecell(struct irq_domain *d, struct device_node *ctrlr,
 				  const u32 *intspec, unsigned int intsize,
 				  irq_hw_number_t *out_hwirq, unsigned int *out_type);
@@ -525,12 +510,9 @@ int irq_reserve_ipi(struct irq_domain *domain, const struct cpumask *dest);
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
 
 /* V2 interfaces to support hierarchy IRQ domains. */
-struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
-					 unsigned int virq);
-void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-			 irq_hw_number_t hwirq,
-			 const struct irq_chip *chip,
-			 void *chip_data, irq_flow_handler_t handler,
+struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain, unsigned int virq);
+void irq_domain_set_info(struct irq_domain *domain, unsigned int virq, irq_hw_number_t hwirq,
+			 const struct irq_chip *chip, void *chip_data, irq_flow_handler_t handler,
 			 void *handler_data, const char *handler_name);
 void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
@@ -551,11 +533,10 @@ void irq_domain_reset_irq_data(struct irq_data *irq_data);
  * Returns: A pointer to IRQ domain, or %NULL on failure.
  */
 static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
-					    unsigned int flags,
-					    unsigned int size,
-					    struct fwnode_handle *fwnode,
-					    const struct irq_domain_ops *ops,
-					    void *host_data)
+							     unsigned int flags, unsigned int size,
+							     struct fwnode_handle *fwnode,
+							     const struct irq_domain_ops *ops,
+							     void *host_data)
 {
 	const struct irq_domain_info info = {
 		.fwnode		= fwnode,
@@ -571,9 +552,8 @@ static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *
 	return IS_ERR(d) ? NULL : d;
 }
 
-int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
-			    unsigned int nr_irqs, int node, void *arg,
-			    bool realloc,
+int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base, unsigned int nr_irqs,
+			    int node, void *arg, bool realloc,
 			    const struct irq_affinity_desc *affinity);
 void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
@@ -588,37 +568,29 @@ void irq_domain_deactivate_irq(struct irq_data *irq_data);
  *
  * See __irq_domain_alloc_irqs()' documentation.
  */
-static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
-			unsigned int nr_irqs, int node, void *arg)
+static inline int irq_domain_alloc_irqs(struct irq_domain *domain, unsigned int nr_irqs,
+					int node, void *arg)
 {
-	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
-				       NULL);
+	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false, NULL);
 }
 
-int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
-				  unsigned int virq,
-				  irq_hw_number_t hwirq,
-				  const struct irq_chip *chip,
+int irq_domain_set_hwirq_and_chip(struct irq_domain *domain, unsigned int virq,
+				  irq_hw_number_t hwirq, const struct irq_chip *chip,
 				  void *chip_data);
-void irq_domain_free_irqs_common(struct irq_domain *domain,
-				 unsigned int virq,
+void irq_domain_free_irqs_common(struct irq_domain *domain, unsigned int virq,
 				 unsigned int nr_irqs);
-void irq_domain_free_irqs_top(struct irq_domain *domain,
-			      unsigned int virq, unsigned int nr_irqs);
+void irq_domain_free_irqs_top(struct irq_domain *domain, unsigned int virq, unsigned int nr_irqs);
 
 int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg);
 int irq_domain_pop_irq(struct irq_domain *domain, int virq);
 
-int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
-				 unsigned int irq_base,
+int irq_domain_alloc_irqs_parent(struct irq_domain *domain, unsigned int irq_base,
 				 unsigned int nr_irqs, void *arg);
 
-void irq_domain_free_irqs_parent(struct irq_domain *domain,
-				 unsigned int irq_base,
+void irq_domain_free_irqs_parent(struct irq_domain *domain, unsigned int irq_base,
 				 unsigned int nr_irqs);
 
-int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
-					   unsigned int virq);
+int irq_domain_disconnect_hierarchy(struct irq_domain *domain, unsigned int virq);
 
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
@@ -627,8 +599,7 @@ static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 
 static inline bool irq_domain_is_ipi(struct irq_domain *domain)
 {
-	return domain->flags &
-		(IRQ_DOMAIN_FLAG_IPI_PER_CPU | IRQ_DOMAIN_FLAG_IPI_SINGLE);
+	return domain->flags & (IRQ_DOMAIN_FLAG_IPI_PER_CPU | IRQ_DOMAIN_FLAG_IPI_SINGLE);
 }
 
 static inline bool irq_domain_is_ipi_per_cpu(struct irq_domain *domain)
@@ -657,14 +628,13 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 }
 
 #else	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
-static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
-			unsigned int nr_irqs, int node, void *arg)
+static inline int irq_domain_alloc_irqs(struct irq_domain *domain, unsigned int nr_irqs,
+					int node, void *arg)
 {
 	return -1;
 }
 
-static inline void irq_domain_free_irqs(unsigned int virq,
-					unsigned int nr_irqs) { }
+static inline void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs) { }
 
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
@@ -704,8 +674,7 @@ static inline bool irq_domain_is_msi_device(struct irq_domain *domain)
 #endif	/* CONFIG_IRQ_DOMAIN_HIERARCHY */
 
 #ifdef CONFIG_GENERIC_MSI_IRQ
-int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
-				  unsigned int type);
+int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq, unsigned int type);
 void msi_device_domain_free_wired(struct irq_domain *domain, unsigned int virq);
 #else
 static inline int msi_device_domain_alloc_wired(struct irq_domain *domain, unsigned int hwirq,
@@ -727,8 +696,8 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 }
 
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
+						     const struct irq_domain_ops *ops,
+						     void *host_data)
 {
 	struct irq_domain_info info = {
 		.fwnode		= of_fwnode_handle(of_node),
@@ -743,9 +712,9 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 }
 
 static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_node,
-					 unsigned int size,
-					 const struct irq_domain_ops *ops,
-					 void *host_data)
+						       unsigned int size,
+						       const struct irq_domain_ops *ops,
+						       void *host_data)
 {
 	struct irq_domain_info info = {
 		.fwnode		= of_fwnode_handle(of_node),
@@ -762,8 +731,8 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
-static inline struct irq_domain *irq_find_matching_fwnode(
-	struct fwnode_handle *fwnode, enum irq_domain_bus_token bus_token)
+static inline struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
+							  enum irq_domain_bus_token bus_token)
 {
 	return NULL;
 }

