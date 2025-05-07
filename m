Return-Path: <linux-tip-commits+bounces-5364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0979AAD988
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:05:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1BD01C2253F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E61A2367AC;
	Wed,  7 May 2025 07:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c5ncab5L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VgxcGzRO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92A9223535F;
	Wed,  7 May 2025 07:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604700; cv=none; b=Xri75icKknehxj/Es+OjMDwppZvKXwa2jwCkvHKhzkgXiHuH0xLYj30fUdHsJrXmdblg0S+I9Xk7W1R19enJnQZTGpWIKVTLlyePDsVFo+vIx04DOt6lNFL20aV7ggqrWBD/ugr74nyCsE3DgnnaV4Rt4/iAXRhyRaZVjOE1avA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604700; c=relaxed/simple;
	bh=iPiB7fnUx17WULm1HehJx3YBTOaobVrYG7iKWbFfHzE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j3zjS0yCJanVrXujFMogDCaWfV08OO4NIVuqc8BxqhnMZuMBuryY58CtQlhKjVZ4bxePMoBEYJrNsep2Im9z9mAAnDDslejYJKbekP3GNZLgBHeN4q8vBdXCX4ihqTX6RR6XZzCuE4vbCoa2Jeo46h8ge+NFvpVZfFLJRKdepNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c5ncab5L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VgxcGzRO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0/BkMXVyFUAsx4kaOmJIj9kJ0qxQrfDYzm5EV0u238=;
	b=c5ncab5LWRdkZ7/ORXPLPyu/uAku/fW2n8LqDmlb0h8KXhuZ2keGQZJ1ovccUfEI3N7RbI
	pgymgJxKLV9FKN0192N+Kpeysp6XsocXb2+JHiTiw5QlX2l3LGtB+5a4sYc5gPXTkUDmDZ
	GC8KF2g3DTRkD69XjoqLm5EN1F8Vg/eqp7EVajmvZUBWbEt7HToAbT0DibLUiGz0lcQ65b
	LROkS4cW0ihYzS4GD870/KIcF41uD1U/3f0P8toiUpzixaEmilwmBHU50UoW9AzUzxBJ93
	YG695XqxsMFGLzTko7kzdMyJe3kdRWds2Iq915B53YzXkvoczeCZXqxBayQYsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604695;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r0/BkMXVyFUAsx4kaOmJIj9kJ0qxQrfDYzm5EV0u238=;
	b=VgxcGzROu58RTa+MI5RVccPWVnAfc8k3VIPbcx93/ohRKSAjFOk/cN/gghrkE/Ky6PLAbx
	DFApUW+84Ul4W6AQ==
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
Message-ID: <174660469504.406.12443181542346195506.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     0b8018a1333cbccf37dceb2054be1c5db78eb953
Gitweb:        https://git.kernel.org/tip/0b8018a1333cbccf37dceb2054be1c5db78eb953
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:21 +02:00

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

