Return-Path: <linux-tip-commits+bounces-1701-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289539315A1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 15:21:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48AD41C20EDB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 13:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B4BD18EA75;
	Mon, 15 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ByNtUpxy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h1dWV3rc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269C18D4D3;
	Mon, 15 Jul 2024 13:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049643; cv=none; b=O831N046WgpzXvdaPR2YNsdSrVxcsEwVXG235b2ALIKk5a+9hbeYPyDgXIsKeXBHsQIvnwMjGgp87+7s8kN+Xnu7Rh4QcPXWUIXZ7Bec5Rwm3sKMf7c/EzNq6+5iVyzEb4Vz9x4G5zLxDT2lQw/+KUNoZ9y78d5uREHHFWsFsWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049643; c=relaxed/simple;
	bh=jFx/jvDTyoJvwJ5Qc+UjnShHzIQg2+DxP2CaphLW/Mw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tj5WCaZB+JaZCy5M3fGJiTFbekq23lp383DuFVBd4cb/F/Qeb0/le1GUwFVRshaPFvEDttfjMI7OgIYfA8Uz2l9iMf3Aquz7yp7jUjKIwCZGkZHcYQMppLyjjjpTNnpzm4vnkyJaQaqAHnq3opZRbZ7i7O0QvpV9w7sQuXioi5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ByNtUpxy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h1dWV3rc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 13:20:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Enng/pmwpFJhlBipYRnYrsRX+YbOXxbKc4C5kZPj80k=;
	b=ByNtUpxyYotqd7ArRdmQl08OqEpPiE7WuBV3WDx9QxIvcP/GG8FV58G0xrgGyZmSflrWZ6
	E7xQ5wWQDmpbK5uYi44WFuMeUKgmhflR2/zbn+vqLNveRIESpCSMV15lhKfabgOQUSW8l1
	d6TOpOyBZ+stY8JIH9jT9JdZv34kTF03gIVxat+ZVtNa0Rd9isTdzwgFxZvbiwP+uMGzoS
	qpNVvDUuGSOVGfPEHWI0z+aTcfrQhAOkP4mLHEmBxgVkgPakzDPS79zZJixEJW/aXScX5u
	kRbbbdxlF9OCiijLuze/q+5psAQ6L5spsy8EA485ft0vBQxODpBI1cZygY2XDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049637;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Enng/pmwpFJhlBipYRnYrsRX+YbOXxbKc4C5kZPj80k=;
	b=h1dWV3rcfIAthZ6Zo44ia0JopKNck7kD1DyUA2bOm3sz0RIYxEZ8vmGw9lo4yMc3tTBkVl
	x3ssAzYuvw+nyTBg==
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
Message-ID: <172104963630.2215.3926446462144476498.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b7b377332b96a38bc98928d7ec2674c77a95fcb3
Gitweb:        https://git.kernel.org/tip/b7b377332b96a38bc98928d7ec2674c77a95fcb3
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Fri, 12 Jul 2024 08:41:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:56 +02:00

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

