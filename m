Return-Path: <linux-tip-commits+bounces-5366-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D92CAAD9C0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:11:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E4C6987416
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED59237713;
	Wed,  7 May 2025 07:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FiJR5WmE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FeSbPFt8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89ED1236437;
	Wed,  7 May 2025 07:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604701; cv=none; b=uiAWee4d1I2wx1XZqdShhmgENUVpmHgRmMeAC0zfhUsGoTpjpOx+E22jFEH3xYwLUDM5Jeyb/FbHpeqx7dxEaxi2Hm2rPWgoPk9ipi/gPOyTcYcX0HtV7Ibs7nrXixQ/AxncMFCxdZZ/JXkWPnd8QvCnp6T5KT+Dv7DLO4WmuAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604701; c=relaxed/simple;
	bh=A8XPBit9Y19LBX4xJAU2DahEGD1LlhXxT6ryImta9t8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TdenHlTIdbO4Thol28INBzCwlom6TYGYniFzaWRIEQ56Z2UEW0uJWPVX0JsxPCTAKRSKHIBOcTftiQIP02FvGSFO7vk8aPgazjCftga057q+SwvlQQjJ9GBSRAZ9DTKUXdnI+qunZGOjs10F35+WiJtmEmEvksoPJWMe3syXI8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FiJR5WmE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FeSbPFt8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toq1R205doZcLDqGJB9dtZx+O9DBZwoSS8fLl7JX39w=;
	b=FiJR5WmE5ZpsDMSJM0GDFYmEee1ans92dN2N6GyXhWQVQ4GECw1Q0CEbdqWtvpolMxMTGb
	fNjxMOGrhFDRU0jH7FMHBTY+yuhV0lKIv2D1uhP27spD8Yl+dx2owqp/Xz6/T79WtAF1xZ
	hIvSJLBJrHmA/VtgkVqwx6BzYvV4+vDosUdH0KuLunVLCPTKj/WY4bawrj80t2mmmOWep0
	SQwUgWp/wEkVCIxuJvucLy20JTY7dW5InqoDTiMTM1bRtAkNCv0rXv/qtBLVdfIiKiLqVp
	hsoiGU4LKFqD+v56SnoV43mIoW04t1X0Uz2kCnuew7x29vj4haROhXiS+N9tlg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604696;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=toq1R205doZcLDqGJB9dtZx+O9DBZwoSS8fLl7JX39w=;
	b=FeSbPFt8WEFdrePWDUiALwfK/+WjywWqampsYPxEe8gl0CibaT3OSSb4pITCav+DUhTEDK
	OfRlyZvxJA5NgaAw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] irqdomain: Drop of_node_to_fwnode()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-12-jirislaby@kernel.org>
References: <20250319092951.37667-12-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660469573.406.11807489949266801684.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     64e4d65310656fac554ebfdeac14fa198605206f
Gitweb:        https://git.kernel.org/tip/64e4d65310656fac554ebfdeac14fa198605206f
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:21 +02:00

irqdomain: Drop of_node_to_fwnode()

All uses of of_node_to_fwnode() in non-irqdomain code were changed to
"officially" defined of_fwnode_handle(). Therefore, the former can be
dropped along with the last uses in the irqdomain code.

Due to merge logistics the inline cannot be dropped immediately. Move it to
a deprecated section, which will be removed during the merge window.

[ tglx: Handle merge logistics ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-12-jirislaby@kernel.org

---
 include/linux/irqdomain.h | 23 ++++++++++++-----------
 kernel/irq/irqdomain.c    |  4 ++--
 2 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index df7e927..91ed86f 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -358,11 +358,6 @@ int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
 			   irq_hw_number_t hwirq, int node,
 			   const struct irq_affinity_desc *affinity);
 
-static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
-{
-	return node ? &node->fwnode : NULL;
-}
-
 extern const struct fwnode_operations irqchip_fwnode_ops;
 
 static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
@@ -387,7 +382,7 @@ struct irq_domain *irq_find_matching_fwnode(struct fwnode_handle *fwnode,
 static inline struct irq_domain *irq_find_matching_host(struct device_node *node,
 							enum irq_domain_bus_token bus_token)
 {
-	return irq_find_matching_fwnode(of_node_to_fwnode(node), bus_token);
+	return irq_find_matching_fwnode(of_fwnode_handle(node), bus_token);
 }
 
 static inline struct irq_domain *irq_find_host(struct device_node *node)
@@ -407,7 +402,7 @@ static inline struct irq_domain *irq_domain_add_simple(struct device_node *of_no
 						       const struct irq_domain_ops *ops,
 						       void *host_data)
 {
-	return irq_domain_create_simple(of_node_to_fwnode(of_node), size, first_irq, ops, host_data);
+	return irq_domain_create_simple(of_fwnode_handle(of_node), size, first_irq, ops, host_data);
 }
 
 /**
@@ -423,7 +418,7 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 void *host_data)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_node_to_fwnode(of_node),
+		.fwnode		= of_fwnode_handle(of_node),
 		.size		= size,
 		.hwirq_max	= size,
 		.ops		= ops,
@@ -442,7 +437,7 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 					 void *host_data)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_node_to_fwnode(of_node),
+		.fwnode		= of_fwnode_handle(of_node),
 		.hwirq_max	= max_irq,
 		.direct_max	= max_irq,
 		.ops		= ops,
@@ -462,7 +457,7 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 void *host_data)
 {
 	struct irq_domain_info info = {
-		.fwnode		= of_node_to_fwnode(of_node),
+		.fwnode		= of_fwnode_handle(of_node),
 		.hwirq_max	= ~0U,
 		.ops		= ops,
 		.host_data	= host_data,
@@ -611,7 +606,7 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 					    void *host_data)
 {
 	return irq_domain_create_hierarchy(parent, flags, size,
-					   of_node_to_fwnode(node),
+					   of_fwnode_handle(node),
 					   ops, host_data);
 }
 
@@ -755,6 +750,12 @@ static inline void msi_device_domain_free_wired(struct irq_domain *domain, unsig
 }
 #endif
 
+/* Deprecated functions. Will be removed in the merge window */
+static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
+{
+	return node ? &node->fwnode : NULL;
+}
+
 #else /* CONFIG_IRQ_DOMAIN */
 static inline void irq_dispose_mapping(unsigned int virq) { }
 static inline struct irq_domain *irq_find_matching_fwnode(
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index b294c3f..0eb99d2 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -502,7 +502,7 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return irq_domain_create_legacy(of_node_to_fwnode(of_node), size,
+	return irq_domain_create_legacy(of_fwnode_handle(of_node), size,
 					first_irq, first_hwirq, ops, host_data);
 }
 EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
@@ -885,7 +885,7 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 {
 	int i;
 
-	fwspec->fwnode = of_node_to_fwnode(np);
+	fwspec->fwnode = of_fwnode_handle(np);
 	fwspec->param_count = count;
 
 	for (i = 0; i < count; i++)

