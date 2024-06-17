Return-Path: <linux-tip-commits+bounces-1410-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB5290B2BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:47:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3C681C211E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F4CE1D336B;
	Mon, 17 Jun 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l0lbaUT2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ppkrKpHc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D79251D2143;
	Mon, 17 Jun 2024 13:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632276; cv=none; b=cQPJExMqxqhLNYFz4dpbMB9Zj9T0kJqkJVEBxZUQNCsAB7I+e8rEeS3Gg9SYwJsgW47PYkGzxtcQKgtzZiBK/QXj1PI62wYxO+5qLFvn1VFiEJg/KRInzF9d1Ya00EAPeswBaJ5fibPW+04/VuFlGwkXNFpkFQMkHPvfwlGccVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632276; c=relaxed/simple;
	bh=aIWOxPyrclCHUSZFHjjfOg17LorjxL5Ybm8iEf+FIiA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EqYXXtBU6klp8bkJJQedfXOe++ZvinkspMBb+9gJ3Z1HPTx5ye5rnwrlkM2d0PMAk0LijStqDqjMjkV72qbkp31NkESvAsICg0DpnDkTg1QnySbuwoaMhEWQssGzBR9tMrlulVNaaASF6MjI4HBZ1b1HxDgRLpOEDfFBH+N9SME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l0lbaUT2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ppkrKpHc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbJuImiQL14atZu6nkH3B43GoOmP/JouFj2L480vYvc=;
	b=l0lbaUT23RCq/1/mpQ5aSi6+p4D6O9oiZBoioB6HcSeqbM6dkB882l4Pdi0Jmex7hcANFl
	9BqIAbgq0s6Y72oQkxASVJOhbJvfSKbKfE399Ur44xUVGR3jWnBBrS78degrW5GV+KA5kw
	wyHqsJfU3rH/IomtVjH75oKKtKlbuRazdoP1DBolxXtUhSnJ1t66dTlJ43JL7rDeobO582
	EspxTp3NckU/klWK1ZavnlTRLenNQ0rC4CfJQ8j5egSd2yfXH59/1RcwlzVxkLdWsbZJSq
	SL99wMtt4kZ6O9N5Lhz0WgT42L8Y0o+FTgeYUN9nlnprQOF54WYkUSlTrEw3EQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xbJuImiQL14atZu6nkH3B43GoOmP/JouFj2L480vYvc=;
	b=ppkrKpHcz4q2GBVgf3ZUanJA2D7ErEhB7X+j7KCOXdCx7+X4PpeHD7RbuVV56KK+HUitkA
	1MaH8Syx77rSU9Ag==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Add support for generic irq chips creation
 before publishing a domain
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-16-herve.codina@bootlin.com>
References: <20240614173232.1184015-16-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226991.10875.17604078909094762074.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e6f67ce32e8e6dcbadf42dc435fbc9002cabf1f9
Gitweb:        https://git.kernel.org/tip/e6f67ce32e8e6dcbadf42dc435fbc9002cabf1f9
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:14 +02:00

irqdomain: Add support for generic irq chips creation before publishing a domain

The current API functions create an irq_domain and also publish this
newly created to domain. Once an irq_domain is published, consumers can
request IRQ in order to use them.

Some interrupt controller drivers have to perform some more operations
with the created irq_domain in order to have it ready to be used.
For instance:
   - Allocate generic irq chips with irq_alloc_domain_generic_chips()
   - Retrieve the generic irq chips with irq_get_domain_generic_chip()
   - Initialize retrieved chips: set register base address and offsets,
     set several hooks such as irq_mask, irq_unmask, ...

With the newly introduced irq_domain_alloc_generic_chips(), an interrupt
controller driver can use the irq_domain_chip_generic_info structure and
set the init() hook to perform its generic chips initialization.

In order to avoid a window where the domain is published but not yet
ready to be used, handle the generic chip creation (i.e the
irq_domain_alloc_generic_chips() call) before the domain is published.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-16-herve.codina@bootlin.com

---
 include/linux/irqdomain.h |  9 +++++++++
 kernel/irq/irqdomain.c    | 14 +++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2c927ed..5540b22 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -210,6 +210,9 @@ enum {
 	/* Irq domain is a MSI device domain */
 	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
 
+	/* Irq domain must destroy generic chips when removed */
+	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -259,6 +262,9 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+
+struct irq_domain_chip_generic_info;
+
 /**
  * struct irq_domain_info - Domain information structure
  * @fwnode:		firmware node for the interrupt controller
@@ -270,6 +276,8 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @dgc_info:		Geneneric chip information structure pointer used to
+ *			create generic chips for the domain if not NULL.
  * @init:		Function called when the domain is created.
  *			Allow to do some additional domain initialisation.
  * @exit:		Function called when the domain is destroyed.
@@ -290,6 +298,7 @@ struct irq_domain_info {
 	 */
 	struct irq_domain			*parent;
 #endif
+	struct irq_domain_chip_generic_info	*dgc_info;
 	int					(*init)(struct irq_domain *d);
 	void					(*exit)(struct irq_domain *d);
 };
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index a0324d8..4d2a403 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -292,16 +292,25 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	}
 #endif
 
+	if (info->dgc_info) {
+		err = irq_domain_alloc_generic_chips(domain, info->dgc_info);
+		if (err)
+			goto err_domain_free;
+	}
+
 	if (info->init) {
 		err = info->init(domain);
 		if (err)
-			goto err_domain_free;
+			goto err_domain_gc_remove;
 	}
 
 	__irq_domain_publish(domain);
 
 	return domain;
 
+err_domain_gc_remove:
+	if (info->dgc_info)
+		irq_domain_remove_generic_chips(domain);
 err_domain_free:
 	irq_domain_free(domain);
 	return ERR_PTR(err);
@@ -369,6 +378,9 @@ void irq_domain_remove(struct irq_domain *domain)
 
 	mutex_unlock(&irq_domain_mutex);
 
+	if (domain->flags & IRQ_DOMAIN_FLAG_DESTROY_GC)
+		irq_domain_remove_generic_chips(domain);
+
 	pr_debug("Removed domain %s\n", domain->name);
 	irq_domain_free(domain);
 }

