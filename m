Return-Path: <linux-tip-commits+bounces-5525-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF82FAB5786
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 16:48:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16B533BF043
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 May 2025 14:48:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5D21ACE0C;
	Tue, 13 May 2025 14:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e8wW2Uds";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="B+GL6UFr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2182D1AAA11;
	Tue, 13 May 2025 14:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747147694; cv=none; b=DrY07xXpRCkLsuIxOYef0K9XXS6k6S9sSlZujvELMYEW7dXONOt3LNOWjXQqJSsWMfbRP9NrxyigUFk61+H+cMyKAGYwMTTQc7SQzgalhyOnDzx1t7wf9ENYNYfnI/hC75NyefzJEYxdjLLZ3jPnQFAHr04nz8enHN4HGhhN8j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747147694; c=relaxed/simple;
	bh=205BCaVyRSbsSNhGQ3cxijmFDYnWUV7MVkki1g9g31Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Aj86A37jGyIYKUkf+mGCRtO/DeK4zxQGcV4lsnslOOEtqUD+yBN7/OVTvHKtGGEZDpmrRC87Bieug6gcSkoNc0gJvOfLQTDIGVEPLj5HpGlNHyJ3p3NjlGzvAgXvhFHLktLsU0N5F7P38/7R1055jimtsFYjp6IulHjs/PdZqnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e8wW2Uds; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=B+GL6UFr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 May 2025 14:48:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747147691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RpmFky+as3SuKb/nyMveDZHkNzuVClsmrv99R6AQnI=;
	b=e8wW2UdsV4GJ3FJDpLtIMMUb+xDTo1PBVj/Aa2NmRbnzyHgAPvflVd8sOrcbaLfOxYyKA7
	uldLtfneX4WFkBOiArLURxlOGm9xrXYc5M4EoXmK2zvD940XYbHK/jmtVqpZlnyrVZRBYJ
	1GfCa0SOzP3YtJ2Z3m6nb5fjAeEg05BeS0B63vCuuDuv0IiicJJcf8bxcpRXXx0e+OHXQc
	7PSgXngtB6mgw0VhBOgb+QLlVMaNnHz4QVzB8XBOheAscwmnLHobod9VjB7PmeZ+ug/j7n
	0QX+Aly5Dkx9SpRGiRdUxam0cuktSEBWaN1An+C/smEdV8QP+99hwASQ8Ci5kA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747147691;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2RpmFky+as3SuKb/nyMveDZHkNzuVClsmrv99R6AQnI=;
	b=B+GL6UFrn/3qKggTgoU0TuwPX+WN4zNTwKHhl84TL/ozl6RYAh0d8IPqge6AlfhPTzWskT
	yCz2Np8TLfqsMjBA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/econet-en751221: Switch to of_fwnode_handle()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250513084739.2611747-1-jirislaby@kernel.org>
References: <20250513084739.2611747-1-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174714769007.406.11853381142097219255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     96a8cb6d28cebd51a286fe4a8782dc8492813ac4
Gitweb:        https://git.kernel.org/tip/96a8cb6d28cebd51a286fe4a8782dc8492813ac4
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Tue, 13 May 2025 10:47:39 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 May 2025 16:39:03 +02:00

irqchip/econet-en751221: Switch to of_fwnode_handle()

of_node_to_fwnode() is an irqdomain's reimplementation of the
"officially" defined of_fwnode_handle(). The former is in the process of
being removed, so use the latter instead.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513084739.2611747-1-jirislaby@kernel.org

---
 drivers/irqchip/irq-econet-en751221.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-econet-en751221.c b/drivers/irqchip/irq-econet-en751221.c
index fd65dfe..d83d5eb 100644
--- a/drivers/irqchip/irq-econet-en751221.c
+++ b/drivers/irqchip/irq-econet-en751221.c
@@ -286,7 +286,7 @@ static int __init econet_intc_of_init(struct device_node *node, struct device_no
 
 	econet_mask_all();
 
-	domain = irq_domain_create_linear(of_node_to_fwnode(node), IRQ_COUNT,
+	domain = irq_domain_create_linear(of_fwnode_handle(node), IRQ_COUNT,
 					  &econet_domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: Failed to add irqdomain\n", node);

