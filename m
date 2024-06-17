Return-Path: <linux-tip-commits+bounces-1409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C64F290B2BB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A85471C211AB
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E2431D2A2A;
	Mon, 17 Jun 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fdFI1BlL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B0pjIbe4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32C931D2123;
	Mon, 17 Jun 2024 13:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632276; cv=none; b=FFpUWyCPOBZ4mUIsv0uGY5qmBbCZ29Eui0wIfhVvHSfygnv1+DnOnrklfUiTdnehg0LztumrdFY4Cll2dYFCnOyLV3yQW0KlSJfSAuhfWCWO8XpDa9dFaLHl7t6ZIE/Q20mSQ3O49V28Ag0t9PBA87WKT30uy5aW7c+OQ14ytgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632276; c=relaxed/simple;
	bh=xv4HBUpRsdQnUEw0EQVtATIvvVWlTkV30j+yxVmKBcQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tp0D/hp9RTNtaylTCB8eJ9i27Qw35bhrl7a+tKDT06vvJPWkwIZFBUfP5bFDNhc5dwljPN0/PIlTHfB7ak+ecSIUD8Q2pk5vz3/41ebBNhGuCxsVHM3YZeXrVdVs9YhFTbrj9lkGqhirMa3+839yp9GfnmQMYfOMLqDzM4WjbE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fdFI1BlL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B0pjIbe4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvuE6sDiSliJhMbbZbE9P3nM8kyObcUH5si50w3GRuk=;
	b=fdFI1BlLuQMqN/BJpDYIak20mXytBs6H+b9phLyft/EeJj1JoY3hA80b2H5zsuC6Lr6FvH
	bFnivXzBWt/laHQptDhXh30jMiZLtN9cenc/OphIZm4rw/23F47zXP6Yrtblbg1EifJIDh
	PJu9+wIdm3SsLAxvcxojcbXPPehmbN+oFBpYRPbt40b5C23y+cl0swdstcJjhEV5rXvXCr
	JRlGaVsPferxjw64PE0jngyuRFEIvPXd0mMX83PWjMviJgkek1UX0T7Uf3+klASeGxHMk+
	UFMi3A8D9beK3nHGGtsrAm40Xc06/O6uZh01TfqQOJPhnjjCiMfW6fL0Uqe52g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=VvuE6sDiSliJhMbbZbE9P3nM8kyObcUH5si50w3GRuk=;
	b=B0pjIbe4iOr9a8+Q7B7OK3VrgkRi6jauerAPO0XiYZMlbIhl2gWtW5Uee74kdB8JYZbI4f
	vVh020F7DKycg3CA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Convert __irq_domain_add() wrappers to
 irq_domain_instantiate()
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-18-herve.codina@bootlin.com>
References: <20240614173232.1184015-18-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226935.10875.3368510499578828426.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7c53626cd11820a11f9cb2c54c02d47fc062a265
Gitweb:        https://git.kernel.org/tip/7c53626cd11820a11f9cb2c54c02d47fc062a265
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:18 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:14 +02:00

irqdomain: Convert __irq_domain_add() wrappers to irq_domain_instantiate()

__irq_domain_add() wrappers use directly __irq_domain_add(). With the
introduction of irq_domain_instantiate(), __irq_domain_add() becomes
obsolete.

In order to fully remove __irq_domain_add(), convert wrappers to
irq_domain_instantiate()

[ tglx: Fixup struct initializers ]

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-18-herve.codina@bootlin.com

---
 include/linux/irqdomain.h | 58 ++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 8820317..33a968f 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -400,7 +400,17 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode		= of_node_to_fwnode(of_node),
+		.size		= size,
+		.hwirq_max	= size,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
@@ -409,7 +419,17 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode		= of_node_to_fwnode(of_node),
+		.hwirq_max	= max_irq,
+		.direct_max	= max_irq,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
@@ -419,7 +439,16 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, ~0, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode		= of_node_to_fwnode(of_node),
+		.hwirq_max	= ~0U,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
@@ -427,14 +456,33 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, size, size, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.size		= size,
+		.hwirq_max	= size,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, 0, ~0, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.hwirq_max	= ~0,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 extern void irq_domain_remove(struct irq_domain *host);

