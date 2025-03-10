Return-Path: <linux-tip-commits+bounces-4102-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 82D5FA58EFE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 10:06:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417B63AB076
	for <lists+linux-tip-commits@lfdr.de>; Mon, 10 Mar 2025 09:06:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7DF224B0E;
	Mon, 10 Mar 2025 09:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Exx7efPT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e2ZE6Glk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 058E22248B8;
	Mon, 10 Mar 2025 09:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741597574; cv=none; b=udtGItobfxEaHXVGxNGKVNZy+/JoTmmpFVWvS7KTcbAh27CZNtTgAf06uk6Vwnt2/abpYF9advZR/4hs3jYinrPlW75jJgI2y8fkn3n1FmrDPa1Eq5lcYXWc/NA5/kGbrzPCmyCQh/8zun8yVUymGuk+KOHndKnrjdI2FYpyWKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741597574; c=relaxed/simple;
	bh=iOWGkRjFFddBIAycRMahXNq96e0vLW0EL8aSFSEP84U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U3C9lhKnzcAvcXR1XD+jD66JNF2EATYG4S1mTUUY0Iq/kgxhchM8xcGFRcYW72AxLjtnCxbtoXqX0JGBJJ5DXkvlOv/2Rjy8wURf003xdfC5/xKG0vCQT/ATwYeI851kGmrKCbQ0Uj8zH116i9EWTO+Scmmf1RWTX5OretX5YCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Exx7efPT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e2ZE6Glk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 10 Mar 2025 09:06:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741597570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4wJ2sIIwhcOUGs9JobgLwt71IeiDW1faKbkzASGaqg=;
	b=Exx7efPTPBA/1qGA7ZZmr1Of4UgysTdqflWKMKkRq/Jfgov+A7FFF3fdw1bGAClLBo2eb9
	lRe41/nFv545AdKPkXS8qTK1zSKNX3Ke3oXpqKVTOsmRNNWlhxMl4PQk4g4SKF6hSFEdrq
	c6PbdpwCJWvVScLky0rGd+1nUEQMyjnqTCdooGe8XmP6Ut2lJSiEsHhqi/1HIsBSvHx662
	dH7kri4qb6n0YyAtSHFq6Osg/tdJv5Bxj6s0+d+v+fgrRmtG3ifQB8LqTa42X0vs42InEg
	OgBJvuDLD3e7NaF/Uvr1oaBEzrjIKKm7a162aFzTGJAXu9W5BKBDBOvpi/bQRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741597570;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W4wJ2sIIwhcOUGs9JobgLwt71IeiDW1faKbkzASGaqg=;
	b=e2ZE6Glk/jeEsZKd1wbYo3CPHyrVA/5zcH9NErBQWXIU1eGu5KHgXrtDiSY4CvDstyCzMD
	7zOaqmqpfxJcf9Aw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Remove extern from function declarations
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250115085409.1629787-2-jirislaby@kernel.org>
References: <20250115085409.1629787-2-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174159756975.14745.11627303933338941071.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     aa4a1d5b198314e9ef02844d0f9426efd5127f74
Gitweb:        https://git.kernel.org/tip/aa4a1d5b198314e9ef02844d0f9426efd5127f74
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 15 Jan 2025 09:53:50 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 10 Mar 2025 10:01:20 +01:00

irqdomain: Remove extern from function declarations

'extern' is not needed for function declarations. So remove it from
irqdomain.h. Note that the declarations are now unified as some had
'extern' and some did not.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250115085409.1629787-2-jirislaby@kernel.org

---
 include/linux/irqdomain.h | 140 ++++++++++++++++++-------------------
 1 file changed, 71 insertions(+), 69 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e432b6a..5c0ec33 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -350,13 +350,13 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					    irq_hw_number_t first_hwirq,
 					    const struct irq_domain_ops *ops,
 					    void *host_data);
-extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
-						   enum irq_domain_bus_token bus_token);
-extern void irq_set_default_host(struct irq_domain *host);
-extern struct irq_domain *irq_get_default_host(void);
-extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
-				  irq_hw_number_t hwirq, int node,
-				  const struct irq_affinity_desc *affinity);
+struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
+					    enum irq_domain_bus_token bus_token);
+void irq_set_default_host(struct irq_domain *host);
+struct irq_domain *irq_get_default_host(void);
+int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
+			   irq_hw_number_t hwirq, int node,
+			   const struct irq_affinity_desc *affinity);
 
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 {
@@ -370,8 +370,8 @@ static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
 	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
 }
 
-extern void irq_domain_update_bus_token(struct irq_domain *domain,
-					enum irq_domain_bus_token bus_token);
+void irq_domain_update_bus_token(struct irq_domain *domain,
+				 enum irq_domain_bus_token bus_token);
 
 static inline
 struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
@@ -454,7 +454,7 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 	return IS_ERR(d) ? NULL : d;
 }
 
-extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
+unsigned int irq_create_direct_mapping(struct irq_domain *host);
 #endif
 
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
@@ -507,19 +507,19 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 	return IS_ERR(d) ? NULL : d;
 }
 
-extern void irq_domain_remove(struct irq_domain *host);
+void irq_domain_remove(struct irq_domain *host);
 
-extern int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
-					irq_hw_number_t hwirq);
-extern void irq_domain_associate_many(struct irq_domain *domain,
-				      unsigned int irq_base,
-				      irq_hw_number_t hwirq_base, int count);
+int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
+			 irq_hw_number_t hwirq);
+void irq_domain_associate_many(struct irq_domain *domain,
+			       unsigned int irq_base,
+			       irq_hw_number_t hwirq_base, int count);
 
-extern unsigned int irq_create_mapping_affinity(struct irq_domain *host,
-				      irq_hw_number_t hwirq,
-				      const struct irq_affinity_desc *affinity);
-extern unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
-extern void irq_dispose_mapping(unsigned int virq);
+unsigned int irq_create_mapping_affinity(struct irq_domain *host,
+					 irq_hw_number_t hwirq,
+					 const struct irq_affinity_desc *affinity);
+unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
+void irq_dispose_mapping(unsigned int virq);
 
 static inline unsigned int irq_create_mapping(struct irq_domain *host,
 					      irq_hw_number_t hwirq)
@@ -527,9 +527,9 @@ static inline unsigned int irq_create_mapping(struct irq_domain *host,
 	return irq_create_mapping_affinity(host, hwirq, NULL);
 }
 
-extern struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
-					      irq_hw_number_t hwirq,
-					      unsigned int *irq);
+struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
+				       irq_hw_number_t hwirq,
+				       unsigned int *irq);
 
 static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
 						   irq_hw_number_t hwirq)
@@ -587,19 +587,21 @@ int irq_reserve_ipi(struct irq_domain *domain, const struct cpumask *dest);
 int irq_destroy_ipi(unsigned int irq, const struct cpumask *dest);
 
 /* V2 interfaces to support hierarchy IRQ domains. */
-extern struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
-						unsigned int virq);
-extern void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
-				irq_hw_number_t hwirq,
-				const struct irq_chip *chip,
-				void *chip_data, irq_flow_handler_t handler,
-				void *handler_data, const char *handler_name);
-extern void irq_domain_reset_irq_data(struct irq_data *irq_data);
+struct irq_data *irq_domain_get_irq_data(struct irq_domain *domain,
+					 unsigned int virq);
+void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
+			 irq_hw_number_t hwirq,
+			 const struct irq_chip *chip,
+			 void *chip_data, irq_flow_handler_t handler,
+			 void *handler_data, const char *handler_name);
+void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-extern struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
-			unsigned int flags, unsigned int size,
-			struct fwnode_handle *fwnode,
-			const struct irq_domain_ops *ops, void *host_data);
+struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
+					       unsigned int flags,
+					       unsigned int size,
+					       struct fwnode_handle *fwnode,
+					       const struct irq_domain_ops *ops,
+					       void *host_data);
 
 static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
 					    unsigned int flags,
@@ -613,13 +615,13 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 					   ops, host_data);
 }
 
-extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
-				   unsigned int nr_irqs, int node, void *arg,
-				   bool realloc,
-				   const struct irq_affinity_desc *affinity);
-extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
-extern int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
-extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
+int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
+			    unsigned int nr_irqs, int node, void *arg,
+			    bool realloc,
+			    const struct irq_affinity_desc *affinity);
+void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
+int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
+void irq_domain_deactivate_irq(struct irq_data *irq_data);
 
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
@@ -628,32 +630,32 @@ static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 				       NULL);
 }
 
-extern int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
-					   unsigned int irq_base,
-					   unsigned int nr_irqs, void *arg);
-extern int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
-					 unsigned int virq,
-					 irq_hw_number_t hwirq,
-					 const struct irq_chip *chip,
-					 void *chip_data);
-extern void irq_domain_free_irqs_common(struct irq_domain *domain,
-					unsigned int virq,
-					unsigned int nr_irqs);
-extern void irq_domain_free_irqs_top(struct irq_domain *domain,
-				     unsigned int virq, unsigned int nr_irqs);
-
-extern int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg);
-extern int irq_domain_pop_irq(struct irq_domain *domain, int virq);
-
-extern int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
-					unsigned int irq_base,
-					unsigned int nr_irqs, void *arg);
-
-extern void irq_domain_free_irqs_parent(struct irq_domain *domain,
-					unsigned int irq_base,
-					unsigned int nr_irqs);
-
-extern int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
+int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
+				    unsigned int irq_base,
+				    unsigned int nr_irqs, void *arg);
+int irq_domain_set_hwirq_and_chip(struct irq_domain *domain,
+				  unsigned int virq,
+				  irq_hw_number_t hwirq,
+				  const struct irq_chip *chip,
+				  void *chip_data);
+void irq_domain_free_irqs_common(struct irq_domain *domain,
+				 unsigned int virq,
+				 unsigned int nr_irqs);
+void irq_domain_free_irqs_top(struct irq_domain *domain,
+			      unsigned int virq, unsigned int nr_irqs);
+
+int irq_domain_push_irq(struct irq_domain *domain, int virq, void *arg);
+int irq_domain_pop_irq(struct irq_domain *domain, int virq);
+
+int irq_domain_alloc_irqs_parent(struct irq_domain *domain,
+				 unsigned int irq_base,
+				 unsigned int nr_irqs, void *arg);
+
+void irq_domain_free_irqs_parent(struct irq_domain *domain,
+				 unsigned int irq_base,
+				 unsigned int nr_irqs);
+
+int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
 					   unsigned int virq);
 
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)

