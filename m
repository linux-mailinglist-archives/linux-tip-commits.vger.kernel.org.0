Return-Path: <linux-tip-commits+bounces-5590-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE76ABA3E7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:38:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DB3E1BA7D49
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D41C280310;
	Fri, 16 May 2025 19:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4yvKz+6i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C1uAfGW6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EC827FD74;
	Fri, 16 May 2025 19:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424245; cv=none; b=EBCMNewirM3GQ836cBEdxrKqEEmMyDo21iYowaZH5EhqaugS2tzVYysxW+gERtObrnDaZbhtl2/bEyTqi53gTYL1pOBz1I3I4rg0hN76uUxTPn4vFQZi+CAMihXjeTndavYC/2O95FmQq6HZa6/kC0ccr56KFnGOeiIaFsZXk50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424245; c=relaxed/simple;
	bh=Q0oY7+9XJrtC+URr7HA1rX7pN2Rfx8IEav8R8nmqGbU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bjaW72gWwLtQ05HskcIm8ewiYlloNCU5cxgv+F1LtAmudO+3gqaFJ1TjlMckp8lIPQJaITQoQu4PQLBOCAiqe61tDKiaC1p2f40JGBlcDPXMslX0vHI5bFOSygdwu1IRbFW5oto65tw9CJ1H0Yq1UPcutwMsEiaa2HIiqGC9CJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4yvKz+6i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C1uAfGW6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4mc/pEhqL4t1vLI/ZHQn6D0AZVwfgUIW9uzQ8N8Fho=;
	b=4yvKz+6iGNoe700lXuKp5gsx/d0+gEBGjFKwuJt4blFG92Tnt8dVjMSgN+cDJl8ZzXKP5o
	Jc6r8a5mat3aXY/XjyiM7sleWgop8uwvV/VzqylgoL4jgfuXpCE9EAFayROrd3VulfopOd
	eN2weGQYkRB6PXuwStULIXUiVdgBVudVG20UB41i6minQg+qHbYnoZV18hTSj2PhQe5CUS
	Y8aZOMVHwVNn6nojuAr1dp/l+Kod8LQ/P82WKH4YuMGyLM66hz/ixXuWSa+nrCHeQLAJ4t
	Tzxosp1Pu+ZX1i+iyxBSwnUQpJVAaIdJRui45XIMP95o3mSh4SsebfjhwIOCqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V4mc/pEhqL4t1vLI/ZHQn6D0AZVwfgUIW9uzQ8N8Fho=;
	b=C1uAfGW6Y4SXBzjAYn6CIFdhNyez+MdxhR6zmLJ7zuoX1OzjJWThPwSyg1M92rvbLjtGKp
	l9g+YUGPsM+2jtAQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: Improve kernel-docs of functions
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-53-jirislaby@kernel.org>
References: <20250319092951.37667-53-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742424083.406.17126324272027738421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     2272a78b3f4a7a1621f00ac6e9c9232d12b7ff01
Gitweb:        https://git.kernel.org/tip/2272a78b3f4a7a1621f00ac6e9c9232d12b7ff01
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:13 +02:00

irqdomain: Improve kernel-docs of functions

Many of irqdomain.h's functions are referenced in Documentation/ but are
not properly documented. Therefore, document these.

And use "Returns:" tag consistently, so that it is properly generated in
the resulting docs.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-53-jirislaby@kernel.org




---
 include/linux/irqdomain.h | 42 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 66a26df..a70e2ba 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -411,6 +411,15 @@ static inline struct irq_domain *irq_domain_create_nomap(struct fwnode_handle *f
 unsigned int irq_create_direct_mapping(struct irq_domain *domain);
 #endif
 
+/**
+ * irq_domain_create_linear - Allocate and register a linear revmap irq_domain.
+ * @fwnode: pointer to interrupt controller's FW node.
+ * @size: Number of interrupts in the domain.
+ * @ops: map/unmap domain callbacks
+ * @host_data: Controller private data pointer
+ *
+ * Returns: Newly created irq_domain
+ */
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
 					 unsigned int size,
 					 const struct irq_domain_ops *ops,
@@ -457,6 +466,18 @@ unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 void irq_dispose_mapping(unsigned int virq);
 
+/**
+ * irq_create_mapping - Map a hardware interrupt into linux irq space
+ * @domain: domain owning this hardware interrupt or NULL for default domain
+ * @hwirq: hardware irq number in that domain space
+ *
+ * Only one mapping per hardware interrupt is permitted.
+ *
+ * If the sense/trigger is to be specified, set_irq_type() should be called
+ * on the number returned from that call.
+ *
+ * Returns: Linux irq number or 0 on error
+ */
 static inline unsigned int irq_create_mapping(struct irq_domain *domain,
 					      irq_hw_number_t hwirq)
 {
@@ -467,6 +488,13 @@ struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,
 				       irq_hw_number_t hwirq,
 				       unsigned int *irq);
 
+/**
+ * irq_resolve_mapping - Find a linux irq from a hw irq number.
+ * @domain: domain owning this hardware interrupt
+ * @hwirq: hardware irq number in that domain space
+ *
+ * Returns: Interrupt descriptor
+ */
 static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
 						   irq_hw_number_t hwirq)
 {
@@ -477,6 +505,8 @@ static inline struct irq_desc *irq_resolve_mapping(struct irq_domain *domain,
  * irq_find_mapping() - Find a linux irq from a hw irq number.
  * @domain: domain owning this hardware interrupt
  * @hwirq: hardware irq number in that domain space
+ *
+ * Returns: Linux irq number or 0 if not found
  */
 static inline unsigned int irq_find_mapping(struct irq_domain *domain,
 					    irq_hw_number_t hwirq)
@@ -539,7 +569,8 @@ void irq_domain_reset_irq_data(struct irq_data *irq_data);
  *
  * If successful the parent is associated to the new domain and the
  * domain flags are set.
- * Returns pointer to IRQ domain, or NULL on failure.
+ *
+ * Returns: A pointer to IRQ domain, or %NULL on failure.
  */
 static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 					    unsigned int flags,
@@ -570,6 +601,15 @@ void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 int irq_domain_activate_irq(struct irq_data *irq_data, bool early);
 void irq_domain_deactivate_irq(struct irq_data *irq_data);
 
+/**
+ * irq_domain_alloc_irqs - Allocate IRQs from domain
+ * @domain:	domain to allocate from
+ * @nr_irqs:	number of IRQs to allocate
+ * @node:	NUMA node id for memory allocation
+ * @arg:	domain specific argument
+ *
+ * See __irq_domain_alloc_irqs()' documentation.
+ */
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {

