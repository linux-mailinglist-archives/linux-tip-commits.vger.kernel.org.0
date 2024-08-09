Return-Path: <linux-tip-commits+bounces-2028-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA45894D85A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 23:14:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237E71F22896
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Aug 2024 21:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC9FA16A921;
	Fri,  9 Aug 2024 21:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3W8SyokD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w79TDSRn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F1FF224EA;
	Fri,  9 Aug 2024 21:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723238083; cv=none; b=q2mwIcSD+xok2EFAetPG1E299kBkgf6YpACN02I2qtcoeTrmTcZUOBlIh2CHg4zOFpydP1u7yKQ1Ja/gQrEfg/cA9O+FBHNlO2+0jDJTfUCZMrsKwDCf8gOJhlPu2OvDxOyY27tcmAel0uOHoS+DAqAnbbpL3wV7t0VXik7fYjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723238083; c=relaxed/simple;
	bh=yFMtPylTUpNIoZdoTmnRCMDexbKH3+xBNPWZ21tt/bc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HUzEPbm5dZOqqAwnR4nOvObnR5dc0B9SWEzq+ZzLFdb8vAVUWwJN+WNpcGg0FUtP7AIkFIlOC4GCZYcotRuhfqcLclZCEOjYxp6knQOhAIOP3uRliiuBEob4L3lXOlBtuNzk58ZyaaofT0CV/IRQmG/Cxiopcm7xFSJIhH6uzN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3W8SyokD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w79TDSRn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 09 Aug 2024 21:14:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723238079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDq9nIdzosuh0JeYSHFwEOoDvDL14cD9nEciyKtn0PU=;
	b=3W8SyokD4cI0Z0kZ/tfLv40lK0rhYouOB2Lo1z0hjHzY4u6OU0UpTiJH43jYFNKuefGf+G
	zuVRW0YAIv4dW1re18gy6TdBtKG10F1nS1q0TU814m/ekwoWEAPa4PtjNQWJhGLOZft78K
	iw4CAItZv1lscEMs5SoFkepRINiOcC8sMfF5gUM14kgJuFgYC6Gg04/oyK8LpKIgCD4Ai4
	6oUpJsG0wuXb98qsVeSRhbF5wTMeTwpZcntz1BPPVTFzpAawIMJC4+F07Btq7QEE2C2hY4
	oB37pijrBJABWSvIsL9fxe/Xw16P/ROJf65VDaznalAZOt7pKdknbHyF/3SBzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723238079;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDq9nIdzosuh0JeYSHFwEOoDvDL14cD9nEciyKtn0PU=;
	b=w79TDSRnZ+1ag6741/eRgqPCR0to39BvmYoRLBXSjBBfcSs9NgeknZrRKyq557Vvyt7j9E
	D0iOSpMIFm+0HEAA==
From: "tip-bot2 for Matti Vaittinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Allow giving name suffix for domain
Cc: Matti Vaittinen <mazziesaccount@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <871q2yvk5x.ffs@tglx>
References: <871q2yvk5x.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172323807846.2215.16980541649812681615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1e7c05292531e5b6bebe409cd531ed4ec0b2ff56
Gitweb:        https://git.kernel.org/tip/1e7c05292531e5b6bebe409cd531ed4ec0b2ff56
Author:        Matti Vaittinen <mazziesaccount@gmail.com>
AuthorDate:    Thu, 08 Aug 2024 22:23:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 09 Aug 2024 22:37:54 +02:00

irqdomain: Allow giving name suffix for domain

Devices can provide multiple interrupt lines. One reason for this is that
a device has multiple subfunctions, each providing its own interrupt line.
Another reason is that a device can be designed to be used (also) on a
system where some of the interrupts can be routed to another processor.

A line often further acts as a demultiplex for specific interrupts
and has it's respective set of interrupt (status, mask, ack, ...)
registers.

Regmap supports the handling of these registers and demultiplexing
interrupts, but the interrupt domain code ends up assigning the same name
for the per interrupt line domains. This causes a naming collision in the
debugFS code and leads to confusion, as /proc/interrupts shows two separate
interrupts with the same domain name and hardware interrupt number.

Instead of adding a workaround in regmap or driver code, allow giving a
name suffix for the domain name when the domain is created.

Add a name_suffix field in the irq_domain_info structure and make
irq_domain_instantiate() use this suffix if it is given when a domain is
created.

[ tglx: Adopt it to the cleanup patch and fixup the invalid NULL return ]

Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/871q2yvk5x.ffs@tglx

---
 include/linux/irqdomain.h |  3 +++
 kernel/irq/irqdomain.c    | 30 +++++++++++++++++++++++-------
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index bfcffa2..e432b6a 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -295,6 +295,8 @@ struct irq_domain_chip_generic_info;
  * @virq_base:		The first Linux interrupt number for legacy domains to
  *			immediately associate the interrupts after domain creation
  * @bus_token:		Domain bus token
+ * @name_suffix:	Optional name suffix to avoid collisions when multiple
+ *			domains are added using same fwnode
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  * @dgc_info:		Geneneric chip information structure pointer used to
@@ -313,6 +315,7 @@ struct irq_domain_info {
 	unsigned int				hwirq_base;
 	unsigned int				virq_base;
 	enum irq_domain_bus_token		bus_token;
+	const char				*name_suffix;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 72ab601..01001eb 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -140,11 +140,14 @@ static int alloc_name(struct irq_domain *domain, char *base, enum irq_domain_bus
 }
 
 static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
-			     enum irq_domain_bus_token bus_token)
+			     enum irq_domain_bus_token bus_token, const char *suffix)
 {
-	char *name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
-				 kasprintf(GFP_KERNEL, "%pfw", fwnode);
+	const char *sep = suffix ? "-" : "";
+	const char *suf = suffix ? : "";
+	char *name;
 
+	name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token) :
+			   kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
 	if (!name)
 		return -ENOMEM;
 
@@ -172,12 +175,25 @@ static int alloc_unknown_name(struct irq_domain *domain, enum irq_domain_bus_tok
 	return 0;
 }
 
-static int irq_domain_set_name(struct irq_domain *domain, const struct fwnode_handle *fwnode,
-			       enum irq_domain_bus_token bus_token)
+static int irq_domain_set_name(struct irq_domain *domain, const struct irq_domain_info *info)
 {
+	enum irq_domain_bus_token bus_token = info->bus_token;
+	const struct fwnode_handle *fwnode = info->fwnode;
+
 	if (is_fwnode_irqchip(fwnode)) {
 		struct irqchip_fwid *fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
 
+		/*
+		 * The name_suffix is only intended to be used to avoid a name
+		 * collision when multiple domains are created for a single
+		 * device and the name is picked using a real device node.
+		 * (Typical use-case is regmap-IRQ controllers for devices
+		 * providing more than one physical IRQ.) There should be no
+		 * need to use name_suffix with irqchip-fwnode.
+		 */
+		if (info->name_suffix)
+			return -EINVAL;
+
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
@@ -189,7 +205,7 @@ static int irq_domain_set_name(struct irq_domain *domain, const struct fwnode_ha
 		}
 
 	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) || is_software_node(fwnode)) {
-		return alloc_fwnode_name(domain, fwnode, bus_token);
+		return alloc_fwnode_name(domain, fwnode, bus_token, info->name_suffix);
 	}
 
 	if (domain->name)
@@ -215,7 +231,7 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	err = irq_domain_set_name(domain, info->fwnode, info->bus_token);
+	err = irq_domain_set_name(domain, info);
 	if (err) {
 		kfree(domain);
 		return ERR_PTR(err);

