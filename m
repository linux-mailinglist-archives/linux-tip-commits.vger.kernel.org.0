Return-Path: <linux-tip-commits+bounces-2026-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6590094D857
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 23:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E1641C2159D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 21:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F29A01684B0;
	Fri,  9 Aug 2024 21:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yKY270Qi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xBpykJDL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2AE160860;
	Fri,  9 Aug 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238082; cv=none; b=lB2lnxtPoQjQU4i2HJrccEs74cajEJ3pTSMroEwPX8A5tX0pLGG5orJQr8CUIhqlD5fCBHYScViKUiTWiOE0GrNs4aiuvpV7FXCasXQ+fk2R45mUm7LylkT/JSM1AVeFh5M6fzeS53tWruJDi1osTqgsoW6JS00g+/GCWvXsVLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238082; c=relaxed/simple;
	bh=iOGMmqMFT6jalMSrFHeMpKhyPUhgBbeCr99TQ1IauPs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FfN6lP03d6s4oVxhJu92Vrhx3ak7YR3OlDfCMtYgdaG2CJ1+5+reiWDD7p6rse52FAIT2fDbOHa7+RP6XQPpnBgDvwYLdIoMbTDDUVDzUmkPZyZkQJNJ77qRMUJaxN1d2jYGbxm/5dTj9bUs2LreLxJ6v8Cot0HBH6Rw/ypS3Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yKY270Qi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xBpykJDL; arc=none smtp.client-ip=193.142.43.55
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
	bh=LaOAAwYWUMK7TRiCzhE0dzWv1M+4M2kYpBUiSSHIaZw=;
	b=yKY270QiFD7I0yYMoIGNAMQU4pC6GxyC+heJS7HSgLCujUii3dfJkBiJI1p83nzFN/mm6i
	Wvrg/oxqRI9zmuzHnBYVvEqQ0KdlfaajC7ugpRBfcKD0jUUAIt/sfITthPn2309hcEebVp
	au1DyO+OSyUEufF8UjvOnIgO2dGdkWLNGoLY8Y29+doUzuNFa7hCKQjnZILfh4lZ/YeDXv
	DDOq7OoM8VyONwBBgzRfSMNkm76BxY0vDnCkJU0NiWAbKuq5dcnFYYXEJ4gDS66jS9Aj1U
	Haczw3P5dEzh94EvAxKm192YWPPGCiTQk01g7qIvXpvsJhepL6khsueT3kdi2g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723238079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LaOAAwYWUMK7TRiCzhE0dzWv1M+4M2kYpBUiSSHIaZw=;
	b=xBpykJDL2wNaNpx9+kLC471MvJ9m7qWMyJlTFY5PaWPDn7PSg38sFlFeMXETxoSW6FUlZk
	zLJFpDYU9sFbbCDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Cleanup domain name allocation
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Matti Vaittinen <mazziesaccount@gmail.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <874j7uvkbm.ffs@tglx>
References: <874j7uvkbm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172323807905.2215.15647999136649709715.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1bf2c92829274e7c815d06d7b3196a967ff70917
Gitweb:        https://git.kernel.org/tip/1bf2c92829274e7c815d06d7b3196a967ff70917
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 08 Aug 2024 22:19:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 09 Aug 2024 22:37:54 +02:00

irqdomain: Cleanup domain name allocation

irq_domain_set_name() is truly unreadable gunk. Clean it up before adding
more.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Matti Vaittinen <mazziesaccount@gmail.com>
Link: https://lore.kernel.org/all/874j7uvkbm.ffs@tglx

---
 kernel/irq/irqdomain.c | 106 ++++++++++++++++++++--------------------
 1 file changed, 55 insertions(+), 51 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7625e42..72ab601 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -128,72 +128,76 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
-static int irq_domain_set_name(struct irq_domain *domain,
-			       const struct fwnode_handle *fwnode,
-			       enum irq_domain_bus_token bus_token)
+static int alloc_name(struct irq_domain *domain, char *base, enum irq_domain_bus_token bus_token)
+{
+	domain->name = bus_token ? kasprintf(GFP_KERNEL, "%s-%d", base, bus_token) :
+				   kasprintf(GFP_KERNEL, "%s", base);
+	if (!domain->name)
+		return -ENOMEM;
+
+	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
+			     enum irq_domain_bus_token bus_token)
+{
+	char *name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
+				 kasprintf(GFP_KERNEL, "%pfw", fwnode);
+
+	if (!name)
+		return -ENOMEM;
+
+	/*
+	 * fwnode paths contain '/', which debugfs is legitimately unhappy
+	 * about. Replace them with ':', which does the trick and is not as
+	 * offensive as '\'...
+	 */
+	domain->name = strreplace(name, '/', ':');
+	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int alloc_unknown_name(struct irq_domain *domain, enum irq_domain_bus_token bus_token)
 {
 	static atomic_t unknown_domains;
-	struct irqchip_fwid *fwid;
+	int id = atomic_inc_return(&unknown_domains);
+
+	domain->name = bus_token ? kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token) :
+				   kasprintf(GFP_KERNEL, "unknown-%d", id);
 
+	if (!domain->name)
+		return -ENOMEM;
+	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	return 0;
+}
+
+static int irq_domain_set_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
+			       enum irq_domain_bus_token bus_token)
+{
 	if (is_fwnode_irqchip(fwnode)) {
-		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
+		struct irqchip_fwid *fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
 
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->name = bus_token ?
-					kasprintf(GFP_KERNEL, "%s-%d",
-						  fwid->name, bus_token) :
-					kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name)
-				return -ENOMEM;
-			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-			break;
+			return alloc_name(domain, fwid->name, bus_token);
 		default:
 			domain->name = fwid->name;
-			if (bus_token) {
-				domain->name = kasprintf(GFP_KERNEL, "%s-%d",
-							 fwid->name, bus_token);
-				if (!domain->name)
-					return -ENOMEM;
-				domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-			}
-			break;
+			if (bus_token)
+				return alloc_name(domain, fwid->name, bus_token);
 		}
-	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
-		   is_software_node(fwnode)) {
-		char *name;
 
-		/*
-		 * fwnode paths contain '/', which debugfs is legitimately
-		 * unhappy about. Replace them with ':', which does
-		 * the trick and is not as offensive as '\'...
-		 */
-		name = bus_token ?
-			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
-			kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name)
-			return -ENOMEM;
-
-		domain->name = strreplace(name, '/', ':');
-		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) || is_software_node(fwnode)) {
+		return alloc_fwnode_name(domain, fwnode, bus_token);
 	}
 
-	if (!domain->name) {
-		if (fwnode)
-			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name = bus_token ?
-				kasprintf(GFP_KERNEL, "unknown-%d-%d",
-					  atomic_inc_return(&unknown_domains),
-					  bus_token) :
-				kasprintf(GFP_KERNEL, "unknown-%d",
-					  atomic_inc_return(&unknown_domains));
-		if (!domain->name)
-			return -ENOMEM;
-		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
-	}
+	if (domain->name)
+		return 0;
 
-	return 0;
+	if (fwnode)
+		pr_err("Invalid fwnode type for irqdomain\n");
+	return alloc_unknown_name(domain, bus_token);
 }
 
 static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info)

