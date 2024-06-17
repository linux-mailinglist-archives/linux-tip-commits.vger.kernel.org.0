Return-Path: <linux-tip-commits+bounces-1424-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0ED90B2D2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:49:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FEB81C2123D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A4E31D329E;
	Mon, 17 Jun 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CYqRh9AS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aBTlFc4T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 894D61D5422;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632282; cv=none; b=uQMex7pQevvx/uZyHHj6XlKXZGt1vrObVB8GUD1Dvqn+ME2JBmzSNDJAsaNPYrC7m+VzG5ZKihly3xdPiD3Bn9s+LpqmhnD82JppQAsCz6W4XzICQ2asBIRZYNbt4tN9qo0sU3S9B1NWv1RonPEZz04j1Rg8WJHTAbYwQlqNnE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632282; c=relaxed/simple;
	bh=d2hJEculr6G5s7Zf/W2zQ1x2Grcka9UkGdpKhvkyLkQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N9LHXACj66d6hsTjUlzkJJKWLZB6o/gL14o+xpJ2YfINajb/Sn1doRz7YCL94245aY9uuS/GCTfaW0ZscuBluesROgPXXonQCyGr8G6q28exC2uw62x1hDvY1osdinIamf6i0jkyn9AeEOPqDLlu5jq9w7X6FqOG6MBAvSR3IqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CYqRh9AS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aBTlFc4T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=576B6cgAZrGku8YxUc1cuYPzEBr/0xPSJQX1TnNtIiQ=;
	b=CYqRh9ASlcid1nII4RWm7br67Ki7oiiyD3NSAhYp1iWqWygPd9qRJRcH0EtCLNQeFzIByt
	K/0oy9/+MahWDCSSHScgQlRJrvdexpHaPpd18ZLFFK69urUd9QEt1DH99KRgGiO6rjsEXz
	7nrV3VYB03HkKTdBc91T9nR+3mPtKXPtlmxUBGlcSC5d5mUC8ftk3XZ8+ADKymVd23stk0
	fhtC8aX4tnH1MdxPpMY0En3J0KZ43GhLq7ORD9xpb7Rxcx80kHioIcKmdtleWDW/rXs1aR
	9NRo8HQP9Re7oy6Oo2sX4ZMbnG1KW6Npjr/qt6SzzkXEQMswzJRRsWZ3HllfUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632273;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=576B6cgAZrGku8YxUc1cuYPzEBr/0xPSJQX1TnNtIiQ=;
	b=aBTlFc4Tz8c+Wzcxaz+LVP1lFr7HdHzvFiXe0trE/boqSjkEfJZR9X1yPtskukV/PG84z/
	HXQt1kkTfCgCr6Bw==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqdomain: Use a dedicated function to set the domain name
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-6-herve.codina@bootlin.com>
References: <20240614173232.1184015-6-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227292.10875.17947670837359700573.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     dbd56abffc6a43eb361e8033dce7a7d176f8e867
Gitweb:        https://git.kernel.org/tip/dbd56abffc6a43eb361e8033dce7a7d176f8e867
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:13 +02:00

irqdomain: Use a dedicated function to set the domain name

The interrupt domain name computation and setting is directly done in
__irq_domain_create(). This leads to a quite long __irq_domain_create()
function.

In order to simplify __irq_domain_create() and isolate the domain name
computation and setting, move the related operations to a dedicated
function.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-6-herve.codina@bootlin.com

---
 kernel/irq/irqdomain.c | 69 ++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 111052f..a7be776 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -128,27 +128,11 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
-static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
-					      unsigned int size,
-					      irq_hw_number_t hwirq_max,
-					      int direct_max,
-					      const struct irq_domain_ops *ops,
-					      void *host_data)
+static int irq_domain_set_name(struct irq_domain *domain,
+			       const struct fwnode_handle *fwnode)
 {
-	struct irqchip_fwid *fwid;
-	struct irq_domain *domain;
-
 	static atomic_t unknown_domains;
-
-	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
-		    (direct_max && (direct_max != hwirq_max))))
-		return NULL;
-
-	domain = kzalloc_node(struct_size(domain, revmap, size),
-			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
-	if (!domain)
-		return NULL;
+	struct irqchip_fwid *fwid;
 
 	if (is_fwnode_irqchip(fwnode)) {
 		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
@@ -157,10 +141,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name) {
-				kfree(domain);
-				return NULL;
-			}
+			if (!domain->name)
+				return -ENOMEM;
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
@@ -177,10 +159,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		 * the trick and is not as offensive as '\'...
 		 */
 		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name) {
-			kfree(domain);
-			return NULL;
-		}
+		if (!name)
+			return -ENOMEM;
 
 		domain->name = strreplace(name, '/', ':');
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
@@ -191,13 +171,40 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			pr_err("Invalid fwnode type for irqdomain\n");
 		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
 					 atomic_inc_return(&unknown_domains));
-		if (!domain->name) {
-			kfree(domain);
-			return NULL;
-		}
+		if (!domain->name)
+			return -ENOMEM;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
+	return 0;
+}
+
+static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
+					      unsigned int size,
+					      irq_hw_number_t hwirq_max,
+					      int direct_max,
+					      const struct irq_domain_ops *ops,
+					      void *host_data)
+{
+	struct irq_domain *domain;
+	int err;
+
+	if (WARN_ON((size && direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
+		    (direct_max && direct_max != hwirq_max)))
+		return NULL;
+
+	domain = kzalloc_node(struct_size(domain, revmap, size),
+			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
+	if (!domain)
+		return NULL;
+
+	err = irq_domain_set_name(domain, fwnode);
+	if (err) {
+		kfree(domain);
+		return NULL;
+	}
+
 	domain->fwnode = fwnode_handle_get(fwnode);
 	fwnode_dev_initialized(domain->fwnode, true);
 

