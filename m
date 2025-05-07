Return-Path: <linux-tip-commits+bounces-5423-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35FCBAAE109
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 70AF84E2FAA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:44:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1181F289823;
	Wed,  7 May 2025 13:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P2Ktnm5A";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hcNqDCE3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1790428935D;
	Wed,  7 May 2025 13:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625451; cv=none; b=KkcmJ0PPRGOx8VCQWYp/NRdgC4iGZ++mltA1q0C26LjA79+JLdK0TtzhiyC614t20jNMdCgm+ykRKo6kZF2EHHxEN80aSx6P3hVe3jpAwXOOyIkF5EEDCg4QUiHktEbvOj8TN+PpXp7FFofdl1Thom1UnRPsaFEJ9+tZ0+0tCYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625451; c=relaxed/simple;
	bh=D9olVRbPfnyFlsnL4E6lPRoMCtw6dC3ZlfS60U7MqI4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EGxW4/8Byohf6zq5klLyIvbPHUIZRqGronNaJ+0s9pKxh86Fd4rkDlA8bX2WWsrZApuwDCri44e8dpvaetam9QVNKZ3PiCEFgV29LFR1UgIlr1y0fgx6t15oWlMQFlSNulVBmOyPYWxw+Ucx2aPcZBaeyBqc5vlWDOwVOb/Lj0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P2Ktnm5A; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hcNqDCE3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASkO7eO7dYY7HOoGsp55h2RyH5IWrZnOrzX2rgZxzSY=;
	b=P2Ktnm5AiibYbwm7zyuJVETgM0LXsKm2W46kU0dmL+loFeCswX+qEcqQGr12VOsXr1b0CO
	zvXfYCKetTMVp+0Ouajp4am66RbDqabCMV3G88vfPDNW1tvlaGEjCDZmVLmBjwTbKJvkBP
	yOy9mwAV1QEBcSqlDdrUMwGKTIMl7ime4Cxmf4xHKwOHS2+ZJPg2ozGIxPkGJR2TWo2Feg
	aspPtRpMw/7G08Zr1cqIC7B5YCTXyUkDZdtztjLN66xTaDuLNRncp8NCrlE4ITL0wc4RsL
	sb/lbumqPGrJpiIuLJJ8nSGfPhdRroRqNaTCAhGiEWC5HSJS+av4Dq1moZ8nig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625447;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ASkO7eO7dYY7HOoGsp55h2RyH5IWrZnOrzX2rgZxzSY=;
	b=hcNqDCE36UyIA/f0P17FQJ0RWICO33xX0lIHZSKY5rhCllX9tNbfBh267/BPfAtcSu0uXX
	FmdG44Yp31VZBHCQ==
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
Message-ID: <174662544667.406.9304218481343750925.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     ece27dde1fe1a70f9b0e791e168ec823d62e455a
Gitweb:        https://git.kernel.org/tip/ece27dde1fe1a70f9b0e791e168ec823d62e455a
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:42 +02:00

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

