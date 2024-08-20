Return-Path: <linux-tip-commits+bounces-2087-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4BFA958B0A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 17:21:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A87541C203DB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 15:21:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA27193075;
	Tue, 20 Aug 2024 15:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="liAjFguZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0KAWR2KY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7FA192B6D;
	Tue, 20 Aug 2024 15:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724167272; cv=none; b=DFO0LRec/eRVlCCZITfryts0OqnDE39iWHsqgCQAvR0Kb09ECkv4GdBt5Lelsj6vWo01yfaiSSHF0TE8N+uamMellkrJSIneGePSfXYE3gsbrH9YvW4JdQyEd0dAHeYGO69ALLt1eSYHJFLoXbtS+rHCwn66vqXq9iCDSsPUqW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724167272; c=relaxed/simple;
	bh=S/H9H0WfLJDs+JPvbnXZJoRhkJJ/7UJSreUcd1ENgWU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hj0a2rI1WT33MrabxibwyMZtoiZztDYBDaKa5IzJ76FOd264XJp3xMlPDS8Bp7ATAxinQLPgl0Yok6K0it7pKbfFhogJcnJSkTH6zhC9X59LIlBYfKh09w2TPnMaR9uukkr8329IawHJvEP7dG7UKxJpI2FRTv3fpZDICu+qbCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=liAjFguZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0KAWR2KY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 15:21:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724167268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6P1syShkVDT1h/ntN9wYmw+nTYVqvJScS27YF5TqL8=;
	b=liAjFguZrLQpLMFnSuxphUDRwn01CMEj2u5fYuD4lb/PxPkaIVBrCKw9zRoEmMNmNYjyxB
	DBcbhPRGNXHONBP1fyEu0h0T3iceUWH+WMtzd0D4SRfQiEZP7tjAIjcSOmKFTRYUf4HnPI
	xGkQtIY25vZiZUeA7N2zqwzuZROavf21oDJ9dB+PCfBobF3dFg73sTCeX0bc9tvkGJG49U
	/YkVP/mhcl+KWJ97ly0cmx6sytdYgG94kprvfMBkmZTmZpWB5zZBslVP+tMwAXgXwvaal9
	cDJMACy8+g5yZlJjT7+CRWzOSFsC1qYvMHxEfDyqyLVaygcm+neEiWA7TQIsIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724167268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=V6P1syShkVDT1h/ntN9wYmw+nTYVqvJScS27YF5TqL8=;
	b=0KAWR2KY2Ct0B8/EATDE3nHwIUEc0h3rBupswBXwVYLzJBOCzWV4ljQWlGydvLiBUHzrHL
	5YaXETvS6f9BXWAQ==
From: "tip-bot2 for Matti Vaittinen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqdomain: Always associate interrupts for legacy domains
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <c3379142-10bc-4f14-b8ac-a46927aeac38@gmail.com>
References: <c3379142-10bc-4f14-b8ac-a46927aeac38@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172416726820.2215.8921397905891328952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     24d02c4e53e2f02da16b2ae8a1bc92553110ca25
Gitweb:        https://git.kernel.org/tip/24d02c4e53e2f02da16b2ae8a1bc92553110ca25
Author:        Matti Vaittinen <mazziesaccount@gmail.com>
AuthorDate:    Tue, 13 Aug 2024 14:34:27 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2024 17:12:43 +02:00

irqdomain: Always associate interrupts for legacy domains

The unification of irq_domain_create_legacy() missed the fact that
interrupts must be associated even when the Linux interrupt number provided
in the first_irq argument is 0.

This breaks all call sites of irq_domain_create_legacy() which supply 0 as
the first_irq argument.

Enforce the association for legacy domains in __irq_domain_instantiate() to
cure this.

[ tglx: Massaged it slightly. ]

Fixes: 70114e7f7585 ("irqdomain: Simplify simple and legacy domain creation")
Reported-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Signed-off-by Matti Vaittinen <mazziesaccount@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Link: https://lore.kernel.org/all/c3379142-10bc-4f14-b8ac-a46927aeac38@gmail.com
---
 kernel/irq/irqdomain.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 1acc530..5df8780 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -306,7 +306,7 @@ static void irq_domain_instantiate_descs(const struct irq_domain_info *info)
 }
 
 static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_info *info,
-						   bool cond_alloc_descs)
+						   bool cond_alloc_descs, bool force_associate)
 {
 	struct irq_domain *domain;
 	int err;
@@ -342,8 +342,12 @@ static struct irq_domain *__irq_domain_instantiate(const struct irq_domain_info 
 	if (cond_alloc_descs && info->virq_base > 0)
 		irq_domain_instantiate_descs(info);
 
-	/* Legacy interrupt domains have a fixed Linux interrupt number */
-	if (info->virq_base > 0) {
+	/*
+	 * Legacy interrupt domains have a fixed Linux interrupt number
+	 * associated. Other interrupt domains can request association by
+	 * providing a Linux interrupt number > 0.
+	 */
+	if (force_associate || info->virq_base > 0) {
 		irq_domain_associate_many(domain, info->virq_base, info->hwirq_base,
 					  info->size - info->hwirq_base);
 	}
@@ -366,7 +370,7 @@ err_domain_free:
  */
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 {
-	return __irq_domain_instantiate(info, false);
+	return __irq_domain_instantiate(info, false, false);
 }
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
@@ -470,7 +474,7 @@ struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *domain = __irq_domain_instantiate(&info, true);
+	struct irq_domain *domain = __irq_domain_instantiate(&info, true, false);
 
 	return IS_ERR(domain) ? NULL : domain;
 }
@@ -519,7 +523,7 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 		.ops		= ops,
 		.host_data	= host_data,
 	};
-	struct irq_domain *domain = irq_domain_instantiate(&info);
+	struct irq_domain *domain = __irq_domain_instantiate(&info, false, true);
 
 	return IS_ERR(domain) ? NULL : domain;
 }

