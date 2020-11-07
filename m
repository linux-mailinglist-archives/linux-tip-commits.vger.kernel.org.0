Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47E432AA62D
	for <lists+linux-tip-commits@lfdr.de>; Sat,  7 Nov 2020 16:14:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728373AbgKGPOR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 7 Nov 2020 10:14:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41828 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgKGPN5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 7 Nov 2020 10:13:57 -0500
Date:   Sat, 07 Nov 2020 15:13:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604762034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Tj9RNhsAJTSJwXzPoZ/sI5NPbaHnZIhss2QTrtoJKs=;
        b=zl2PQynwnrPWfq5I/r1IJOKLRMTlB8HaWmWp8r81Z+CRfbJ8xDqjoAYCy5QHrilo4YnfCk
        wgk3DgidtbNev0KcBKR+MdwZjpakfDTNLsLcYhGpcFhSGGBRyH4i5eK8BwM3sLMhCJb4M6
        CfGBGsFRmw9JW8Syk/vvPvxZ2pkpGgjzxnboCEEKApjGIrRIbycl5msdJ2Rz1dk8zrJFz3
        hgHEzWMNqNlLtcQNK/jXHmct+YW5RTTBrOCcG6tVhh87DuO1uNMpRA+mF56djmDoiQJE83
        uyj5e8ib4qvhG2q5IkAIrJ8t2dBiGqqd3DJq2e3OEgwb/+A2CpuLtmQlPgzK/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604762034;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Tj9RNhsAJTSJwXzPoZ/sI5NPbaHnZIhss2QTrtoJKs=;
        b=Gx7lXV4i9ryxjkmjf0jOuB3cd+85KKEPeZTmYM6qszHbXOgtbR+dliSscWx11d4LvCGVn3
        Q4tIJKCmbG+G4mDA==
From:   "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Introduce irq_domain_create_legacy() API
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201030165919.86234-5-andriy.shevchenko@linux.intel.com>
References: <20201030165919.86234-5-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160476203408.11244.13364106797492580734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b6e95788fde8c9bc9da729102085dd36a5a0cda6
Gitweb:        https://git.kernel.org/tip/b6e95788fde8c9bc9da729102085dd36a5a0cda6
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Fri, 30 Oct 2020 18:59:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 07 Nov 2020 11:33:46 +01:00

irqdomain: Introduce irq_domain_create_legacy() API

Introduce irq_domain_create_legacy() API which is functional equivalent
to the existing irq_domain_add_legacy(), but takes a pointer to the struct
fwnode_handle as a parameter.

This is useful for non OF systems.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Link: https://lore.kernel.org/r/20201030165919.86234-5-andriy.shevchenko@linux.intel.com

---
 Documentation/core-api/irq/irq-domain.rst |  6 ++++++
 include/linux/irqdomain.h                 |  6 ++++++
 kernel/irq/irqdomain.c                    | 17 ++++++++++++++---
 3 files changed, 26 insertions(+), 3 deletions(-)

diff --git a/Documentation/core-api/irq/irq-domain.rst b/Documentation/core-api/irq/irq-domain.rst
index 096db12..a77c24c 100644
--- a/Documentation/core-api/irq/irq-domain.rst
+++ b/Documentation/core-api/irq/irq-domain.rst
@@ -147,6 +147,7 @@ Legacy
 	irq_domain_add_simple()
 	irq_domain_add_legacy()
 	irq_domain_add_legacy_isa()
+	irq_domain_create_legacy()
 
 The Legacy mapping is a special case for drivers that already have a
 range of irq_descs allocated for the hwirqs.  It is used when the
@@ -185,6 +186,11 @@ that the driver using the simple domain call irq_create_mapping()
 before any irq_find_mapping() since the latter will actually work
 for the static IRQ assignment case.
 
+irq_domain_add_legacy() and irq_domain_create_legacy() are functionally
+equivalent, except for the first argument is different - the former
+accepts an Open Firmware specific 'struct device_node', while the latter
+accepts a more general abstraction 'struct fwnode_handle'.
+
 Hierarchy IRQ domain
 --------------------
 
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index d21f75d..77bf7d8 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -271,6 +271,12 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 irq_hw_number_t first_hwirq,
 					 const struct irq_domain_ops *ops,
 					 void *host_data);
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					    unsigned int size,
+					    unsigned int first_irq,
+					    irq_hw_number_t first_hwirq,
+					    const struct irq_domain_ops *ops,
+					    void *host_data);
 extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
 extern bool irq_domain_check_msi_remap(void);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 831526f..9c9cb88 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -351,16 +351,27 @@ struct irq_domain *irq_domain_add_legacy(struct device_node *of_node,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
+	return irq_domain_create_legacy(of_node_to_fwnode(of_node), size,
+					first_irq, first_hwirq, ops, host_data);
+}
+EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+
+struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
+					 unsigned int size,
+					 unsigned int first_irq,
+					 irq_hw_number_t first_hwirq,
+					 const struct irq_domain_ops *ops,
+					 void *host_data)
+{
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(of_node_to_fwnode(of_node), first_hwirq + size,
-				  first_hwirq + size, 0, ops, host_data);
+	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
 	if (domain)
 		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
 
 	return domain;
 }
-EXPORT_SYMBOL_GPL(irq_domain_add_legacy);
+EXPORT_SYMBOL_GPL(irq_domain_create_legacy);
 
 /**
  * irq_find_matching_fwspec() - Locates a domain for a given fwspec
