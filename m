Return-Path: <linux-tip-commits+bounces-1696-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE5E593051F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:24:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BBF61F2273B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:24:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56F0B73501;
	Sat, 13 Jul 2024 10:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKebb/f0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PnSOB1iT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6976E5ED;
	Sat, 13 Jul 2024 10:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720866271; cv=none; b=W8t97KJSAiCYjzVpwQ+Fa78kQJerbTFHeLQ8kTDXkLu8I4BWdQ0BWy+wfS5jZOIZ01FQ/9JQh7VANDE3Yny65jeVKJ4RLd3dqvZqq7bbwS1ksfFCSYn3TN3cpRKYfz5ptztLTUCH/4GWHpSzjpsElNeujRdyOBvha7DzY5PY28A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720866271; c=relaxed/simple;
	bh=JROmg2uwjAUcz7x31TyoZnkuZR4GEvRrn3+mqCnW3aE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rwUyzCLLeWjnpE18W8iwyI8iBQ8BPU23BcAvQp7O/dWl7fco1LUfRaZpbPmf6Il9CBRdyaSmRn+qabuMxRt3V+RBc868qThCO7Rq/INsXy2V7Ymees3H22T5QcoPryOskMTwrRZaqc+aio3KyWYkLZHhe66WK3xqize0nbsBGQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKebb/f0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PnSOB1iT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:24:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720866268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVvby70wZCJMiBcmusZlrkZp6QoSzB/Na6AcDXb/ZDI=;
	b=hKebb/f0BL2kYGklVNzV3gJkqTGvUVcyjNZ8GcHGzGuTZRn27dYvmgWlU3lsN+c+iei+G3
	SqAPUzPNHlfJgP+4auBO54hJregj9KquSSxK4zwPYVkzxHJmsCqGPK3oWwnJFquNG3U7ul
	obfgHwFd44YutgP5sRobsVh+kzZPv0GmWS267vXfRq+GxMRXpqmDLyk08bXdCMopyu6QDa
	0BZTY4/nZln4nbX+fh03M8zWr3dBG4jKmSRH9JocXIq1cexElBBuqlKWENoTM+4fcB2m46
	m6yoK2iCPrqq5rekw+5Jg6dLo46ou1SifyGlvV3TH2538c3uByEkk4FojKt6mQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720866268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVvby70wZCJMiBcmusZlrkZp6QoSzB/Na6AcDXb/ZDI=;
	b=PnSOB1iTLlQwZbubUQQjC41mTl0vSdg29A77a4LPkBbZNq2uimUti9UjW1VQrzAYScXcma
	eHDQlqRuIrvhz3DQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqdomain: Fix the kernel-doc and plug it into Documentation
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, Randy Dunlap <rdunlap@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240712064148.157040-1-jirislaby@kernel.org>
References: <20240712064148.157040-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086626756.2215.4270635826321080340.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8ca1d93bba1fde64236fc44eecb80ce6993be115
Gitweb:        https://git.kernel.org/tip/8ca1d93bba1fde64236fc44eecb80ce6993be115
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Fri, 12 Jul 2024 08:41:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 13 Jul 2024 12:14:21 +02:00

irqdomain: Fix the kernel-doc and plug it into Documentation

There were several undocumented fields in structs irq_domain_ops and
irq_domain_info. Document them.

irq_domain_ops::revmap_size contained "[]" in the description, which is not
allowed in sphinx. Remove that.

Finally, plug the whole header (irqdomain.h) into genericirq.rst, so that
the docs is autogenerated and hyperlinks to these structure are created.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Randy Dunlap <rdunlap@infradead.org>
Reviewed-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20240712064148.157040-1-jirislaby@kernel.org
---
 Documentation/core-api/genericirq.rst |  2 ++
 include/linux/irqdomain.h             | 20 +++++++++++++++++++-
 2 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/Documentation/core-api/genericirq.rst b/Documentation/core-api/genericirq.rst
index 4a46063..7a27663 100644
--- a/Documentation/core-api/genericirq.rst
+++ b/Documentation/core-api/genericirq.rst
@@ -410,6 +410,8 @@ which are used in the generic IRQ layer.
 .. kernel-doc:: include/linux/interrupt.h
    :internal:
 
+.. kernel-doc:: include/linux/irqdomain.h
+
 Public Functions Provided
 =========================
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 02cd486..de6105f 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -74,11 +74,24 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
  * struct irq_domain_ops - Methods for irq_domain objects
  * @match: Match an interrupt controller device node to a host, returns
  *         1 on a match
+ * @select: Match an interrupt controller fw specification. It is more generic
+ *	    than @match as it receives a complete struct irq_fwspec. Therefore,
+ *	    @select is preferred if provided. Returns 1 on a match.
  * @map: Create or update a mapping between a virtual irq number and a hw
  *       irq number. This is called only once for a given mapping.
  * @unmap: Dispose of such a mapping
  * @xlate: Given a device tree node and interrupt specifier, decode
  *         the hardware irq number and linux irq type value.
+ * @alloc: Allocate @nr_irqs interrupts starting from @virq.
+ * @free: Free @nr_irqs interrupts starting from @virq.
+ * @activate: Activate one interrupt in HW (@irqd). If @reserve is set, only
+ *	      reserve the vector. If unset, assign the vector (called from
+ *	      request_irq()).
+ * @deactivate: Disarm one interrupt (@irqd).
+ * @translate: Given @fwspec, decode the hardware irq number (@out_hwirq) and
+ *	       linux irq type value (@out_type). This is a generalised @xlate
+ *	       (over struct irq_fwspec) and is preferred if provided.
+ * @debug_show: For domains to show specific data for an interrupt in debugfs.
  *
  * Functions below are provided by the driver and called whenever a new mapping
  * is created or an old mapping is disposed. The driver can then proceed to
@@ -131,6 +144,9 @@ struct irq_domain_chip_generic;
  * Optional elements:
  * @fwnode:	Pointer to firmware node associated with the irq_domain. Pretty easy
  *		to swap it for the of_node via the irq_domain_get_of_node accessor
+ * @bus_token:	@fwnode's device_node might be used for several irq domains. But
+ *		in connection with @bus_token, the pair shall be unique in a
+ *		system.
  * @gc:		Pointer to a list of generic chips. There is a helper function for
  *		setting up one or more generic chips for interrupt controllers
  *		drivers using the generic chip library which uses this pointer.
@@ -144,7 +160,9 @@ struct irq_domain_chip_generic;
  * @exit:	Function called when the domain is destroyed
  *
  * Revmap data, used internally by the irq domain code:
- * @revmap_size:	Size of the linear map table @revmap[]
+ * @hwirq_max:		Top limit for the HW irq number. Especially to avoid
+ *			conflicts/failures with reserved HW irqs. Can be ~0.
+ * @revmap_size:	Size of the linear map table @revmap
  * @revmap_tree:	Radix map tree for hwirqs that don't fit in the linear map
  * @revmap:		Linear table of irq_data pointers
  */

