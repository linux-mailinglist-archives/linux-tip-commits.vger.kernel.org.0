Return-Path: <linux-tip-commits+bounces-4670-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C7BA7C273
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 19:34:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B97217AAE2
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Apr 2025 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BDF4214A80;
	Fri,  4 Apr 2025 17:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R1XwWgpL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lVsib2HQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C4F71F03CD;
	Fri,  4 Apr 2025 17:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743788044; cv=none; b=s/Cr0zQ6/BqlAb37CgHVIcqUQHQZ+1kqsXNZQVsh4nQHMguOs+xqJUVc105Htjirfgv+eB9fbGgyCTYNu3BCAN1u3I4v/sfLQHoyoDwZzGjS2G7N0kzRbgQbeOzoB8LqzIZRsEdOKnayB4T3hi+C1htfI2Fmjrg1i4/sObskGyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743788044; c=relaxed/simple;
	bh=3VVxYNxBsXKKuO1sMQCAFftAfB8QZBypJ1cFZwM/d8M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hz9pkCeuYSANeCnH92L6QTlHYcLnxrkpEeCjtq769FAncjeVBmyW8nJBYVii+1z0WrG0aD14d1/elrExbMJErXYRwzsoBvDsnirSPQ9nefgwBo4n1OuJ8FgCjPSRryKOlmkwTliJL68MDq/Wn2jtyEnyuT2WbbsLobxivYuMN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R1XwWgpL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lVsib2HQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 04 Apr 2025 17:33:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1743788040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXMA8eoJj9gk7H2qv2Ok4jCcrEKHdOSPSGNAd9HBvyQ=;
	b=R1XwWgpLlnYJJnUnm1aH9X7eZDD9BxlXM1NK/drmrNsmSJ5qlQ9ZXYEl6YpQdp+kV/vTTG
	EQAbH1oGDvqeaTkYDHl9tA/F7EptRqk32eYsXAfuQ2+gcy8RgYpy+j5tHubleBUnpC47VE
	3SeeI2Mi4zsZZrQBq5tJQwiOt2+aKTg9cwYUiWh084e/b+VVmlOSiJkCRjnPxWQ0RI6GvF
	RjxWX18ycj+gByn7kxc1JVndPMyu9aHkfd4+Yu9RpFAGG5f91tXB643DkmFm+Uq9Ai6i12
	EaCKz+ViEn5FKQZLuHpD9Z9pFZC4feO2KnzCIqAtUyPmy0+MGwfPu8SiEQD/lA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1743788040;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RXMA8eoJj9gk7H2qv2Ok4jCcrEKHdOSPSGNAd9HBvyQ=;
	b=lVsib2HQLXjaaFgz6XjeZAE/eKr5ToBaYutb9q5eK1koZSYQewbVxFFWzCbOVdzjcdUz+u
	8Kgih3MEYHrpugCQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/cleanups] irqdomain: Stop using 'host' for domain
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-5-jirislaby@kernel.org>
References: <20250319092951.37667-5-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174378803674.31282.6043186873705051413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/cleanups branch of tip:

Commit-ID:     4ac8868604758be9295aff58e968d7548b499504
Gitweb:        https://git.kernel.org/tip/4ac8868604758be9295aff58e968d7548b499504
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:28:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 04 Apr 2025 19:26:45 +02:00

irqdomain: Stop using 'host' for domain

It is confusing to see 'host' and 'domain' to be used as 'domain'. Given
this header is all about domains, switch the remaining 'host' uses to
'domain'.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-5-jirislaby@kernel.org

---
 include/linux/irqdomain.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e9ab95f..bb71111 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -72,7 +72,7 @@ void of_phandle_args_to_fwspec(struct device_node *np, const u32 *args,
 
 /**
  * struct irq_domain_ops - Methods for irq_domain objects
- * @match: Match an interrupt controller device node to a host, returns
+ * @match: Match an interrupt controller device node to a domain, returns
  *         1 on a match
  * @select: Match an interrupt controller fw specification. It is more generic
  *	    than @match as it receives a complete struct irq_fwspec. Therefore,
@@ -454,7 +454,7 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 	return IS_ERR(d) ? NULL : d;
 }
 
-unsigned int irq_create_direct_mapping(struct irq_domain *host);
+unsigned int irq_create_direct_mapping(struct irq_domain *domain);
 #endif
 
 static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node,
@@ -507,7 +507,7 @@ static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fw
 	return IS_ERR(d) ? NULL : d;
 }
 
-void irq_domain_remove(struct irq_domain *host);
+void irq_domain_remove(struct irq_domain *domain);
 
 int irq_domain_associate(struct irq_domain *domain, unsigned int irq,
 			 irq_hw_number_t hwirq);
@@ -515,16 +515,16 @@ void irq_domain_associate_many(struct irq_domain *domain,
 			       unsigned int irq_base,
 			       irq_hw_number_t hwirq_base, int count);
 
-unsigned int irq_create_mapping_affinity(struct irq_domain *host,
+unsigned int irq_create_mapping_affinity(struct irq_domain *domain,
 					 irq_hw_number_t hwirq,
 					 const struct irq_affinity_desc *affinity);
 unsigned int irq_create_fwspec_mapping(struct irq_fwspec *fwspec);
 void irq_dispose_mapping(unsigned int virq);
 
-static inline unsigned int irq_create_mapping(struct irq_domain *host,
+static inline unsigned int irq_create_mapping(struct irq_domain *domain,
 					      irq_hw_number_t hwirq)
 {
-	return irq_create_mapping_affinity(host, hwirq, NULL);
+	return irq_create_mapping_affinity(domain, hwirq, NULL);
 }
 
 struct irq_desc *__irq_resolve_mapping(struct irq_domain *domain,

