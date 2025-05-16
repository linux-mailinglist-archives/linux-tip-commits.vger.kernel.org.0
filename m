Return-Path: <linux-tip-commits+bounces-5623-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B835CABA433
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 74DD8A27055
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E24928A402;
	Fri, 16 May 2025 19:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HVx3y//d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZWA3K+rR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 418A5289E2E;
	Fri, 16 May 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424271; cv=none; b=ZGL9HeaNoWUMu4CJN1KmwDtsIwndXhnxef74o7kLr3Lb6327bidZsJXd96BmTdDXaTXbiwpHg5DDp3iBap7bHXJ/WghbzD7cYfiVJpB35Luq+N5Kz3K3jimUMj6xOleVlDV2oSNIq+CDDgX22sxgMWtU8zJo3rqm6bqSnkJUDiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424271; c=relaxed/simple;
	bh=Vtax91LZbl5p+zVcxI6cn6PiFsS2VYLGqZP8JWLfTaQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ESCSrKdAWhW4RGIBPiB6DwrNz0DJimjQeTZs2KFgJ2MhzQ03C9vmQPHkusvyO8BgJmrxGbKrGmmSMa5ueh/HbFjo4U9t4OnscTlrLER+/dRhKTj/VTkO0JwERfNUjd8RCS+jLffh5by6cElP57GSpXiAtBVzSMJyR0CImGhFbAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HVx3y//d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZWA3K+rR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwEqs0xQb1SZuhgm+f2Ptn2NUaJ3g5SL2EMI1Usu3yE=;
	b=HVx3y//dB0154JN9x1FPC3ld3569RO25WmtxqTDQLZK8hburWrd63+hU/6uury0WrJnfN4
	0BgXWs/Ju+V4Jkfj2mQiy+d12CsqwMsEq5tNrFdFxa6bi2oiBot8hNoG2E+rrEnmTEaznL
	BFpOQoAS3BCHYMwslQj45Edn1KdIjVHg4uj8V7DdzVD0xZewveKLQHYgAXuIioKzPdodCw
	EyJsFCdMvagSKRaWH78wU3bezto70Jzho5xzitbv9XSBvF4iDUhe0GrpreP3o4kuE8kNi9
	WTh5UAzSBec+KPAxhdRqw332loBCfKYrMqLdr3CQNAIDx2a/PiBCfmTyQOnyNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424267;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KwEqs0xQb1SZuhgm+f2Ptn2NUaJ3g5SL2EMI1Usu3yE=;
	b=ZWA3K+rRieNh4w/kRD4vEumE7dUT0ZFuyRgY1Z7fKordQj6J/dzGDfq53Ej1qo13/6bOWx
	zmMphP/cOzGbitDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] irqdomain: Make irq_domain_create_hierarchy() an inline
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-13-jirislaby@kernel.org>
References: <20250319092951.37667-13-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742426654.406.16612651387409295292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     c7131b12080ad9c74eadd4f62386c8642168bec7
Gitweb:        https://git.kernel.org/tip/c7131b12080ad9c74eadd4f62386c8642168bec7
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:08 +02:00

irqdomain: Make irq_domain_create_hierarchy() an inline

There is no reason to export the function as an extra symbol. It is
simple enough and is just a wrapper to already exported functions.

Therefore, switch the exported function to an inline.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-13-jirislaby@kernel.org


---
 include/linux/irqdomain.h | 45 ++++++++++++++++++++++++++++++++------
 kernel/irq/irqdomain.c    | 41 +-----------------------------------
 2 files changed, 39 insertions(+), 47 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 91ed86f..6e9a5ec 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -591,12 +591,45 @@ void irq_domain_set_info(struct irq_domain *domain, unsigned int virq,
 			 void *handler_data, const char *handler_name);
 void irq_domain_reset_irq_data(struct irq_data *irq_data);
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
-					       unsigned int flags,
-					       unsigned int size,
-					       struct fwnode_handle *fwnode,
-					       const struct irq_domain_ops *ops,
-					       void *host_data);
+/**
+ * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
+ * @parent:	Parent irq domain to associate with the new domain
+ * @flags:	Irq domain flags associated to the domain
+ * @size:	Size of the domain. See below
+ * @fwnode:	Optional fwnode of the interrupt controller
+ * @ops:	Pointer to the interrupt domain callbacks
+ * @host_data:	Controller private data pointer
+ *
+ * If @size is 0 a tree domain is created, otherwise a linear domain.
+ *
+ * If successful the parent is associated to the new domain and the
+ * domain flags are set.
+ * Returns pointer to IRQ domain, or NULL on failure.
+ */
+static inline struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
+					    unsigned int flags,
+					    unsigned int size,
+					    struct fwnode_handle *fwnode,
+					    const struct irq_domain_ops *ops,
+					    void *host_data)
+{
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.size		= size,
+		.hwirq_max	= size,
+		.ops		= ops,
+		.host_data	= host_data,
+		.domain_flags	= flags,
+		.parent		= parent,
+	};
+	struct irq_domain *d;
+
+	if (!info.size)
+		info.hwirq_max = ~0U;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
+}
 
 static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *parent,
 					    unsigned int flags,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0eb99d2..74ad4a8 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1308,47 +1308,6 @@ void irq_domain_reset_irq_data(struct irq_data *irq_data)
 EXPORT_SYMBOL_GPL(irq_domain_reset_irq_data);
 
 #ifdef	CONFIG_IRQ_DOMAIN_HIERARCHY
-/**
- * irq_domain_create_hierarchy - Add a irqdomain into the hierarchy
- * @parent:	Parent irq domain to associate with the new domain
- * @flags:	Irq domain flags associated to the domain
- * @size:	Size of the domain. See below
- * @fwnode:	Optional fwnode of the interrupt controller
- * @ops:	Pointer to the interrupt domain callbacks
- * @host_data:	Controller private data pointer
- *
- * If @size is 0 a tree domain is created, otherwise a linear domain.
- *
- * If successful the parent is associated to the new domain and the
- * domain flags are set.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
-					    unsigned int flags,
-					    unsigned int size,
-					    struct fwnode_handle *fwnode,
-					    const struct irq_domain_ops *ops,
-					    void *host_data)
-{
-	struct irq_domain_info info = {
-		.fwnode		= fwnode,
-		.size		= size,
-		.hwirq_max	= size,
-		.ops		= ops,
-		.host_data	= host_data,
-		.domain_flags	= flags,
-		.parent		= parent,
-	};
-	struct irq_domain *d;
-
-	if (!info.size)
-		info.hwirq_max = ~0U;
-
-	d = irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-EXPORT_SYMBOL_GPL(irq_domain_create_hierarchy);
-
 static void irq_domain_insert_irq(int virq)
 {
 	struct irq_data *data;

