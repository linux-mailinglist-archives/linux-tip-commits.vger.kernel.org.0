Return-Path: <linux-tip-commits+bounces-5307-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E27BAAC60B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:29:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD4583AA943
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:26:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B374288CA5;
	Tue,  6 May 2025 13:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xh5rVEFo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+cr1T1op"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B93F288534;
	Tue,  6 May 2025 13:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537644; cv=none; b=bgdKcZLWPeC7FL8H2PRzBudthG/xjCPdFrPMzACy4XM4fQuL5lLCwTagyBmh4tV0dfAfNlywrd8ZLnW9NThvfIHy30ugPjEeu46qM9v3VG8B0IrxyiE4au/TY4Qjn+Yl8XsTvT6LAvmR6H72FkZOF+6lEB++a9Mhdir3fCnUZGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537644; c=relaxed/simple;
	bh=OL9JHlLXkVmmKqYFOSJTU58ahXC9PEwzmTsgOH6D1rY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=r5sD/hrTjYGBwL4X0vmwjm3NSY5gV8dlwJaPcfRgdM2DCQ7kQLwcaW0jWutcYaEVhvThXxyTa6BhWi84yK9ycO1+nuyV+DsO+QrcYp51nK0FhdVYdmUX/q7iVFfpykzZX1hGkB6AB205QSowVlQYy8lUlVEndKaejUftBHtdgio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xh5rVEFo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+cr1T1op; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4574t3eHX8m+72hGMBnVrvD+x9Cd42MDSth1Fl18bE=;
	b=Xh5rVEFogmaLu5xnrNx804l0Kcn9hwm6io+vX84Hmm4CZApiMwRqXNPBW6RvW4tzMIXmN6
	0H3L2tNjaj0bu4VL2CjikdOnzlWFKwyTharuMVoJpJbedIogKi39Ca+CrPLFI2gr/HPeg/
	vI2ABIWvJ5FVg1PhP8wH+NWmgo6iwZYHZmQt7gzmReZoAPovgw+bpemwFHRol9VK2OvywJ
	mS/rWPaxeSDivf9zlns5WoZdRamQt0ua9/QwSSY6Cf712QeV8bqwYta5QrHT0j1l1h8VQC
	GKuLctDSd3YKyemT7GPv6xYegnHWccc7CUqsSHUITnKCkcwYK9faCqSE5zKLpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537640;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H4574t3eHX8m+72hGMBnVrvD+x9Cd42MDSth1Fl18bE=;
	b=+cr1T1opm+MCl8iHYZSC37DYb1f6yhOOwwjkpbD2bN3CXE42Jw2ihSWqK1pcdyZo/P6B0x
	TNSGCUpRK7GqXgAw==
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
Message-ID: <174653763997.406.9485714517011367638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     91453f6c42314c831c89c70ad20ebe68d886dc50
Gitweb:        https://git.kernel.org/tip/91453f6c42314c831c89c70ad20ebe68d886dc50
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:04 +02:00

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

