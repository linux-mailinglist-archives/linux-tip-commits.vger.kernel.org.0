Return-Path: <linux-tip-commits+bounces-1426-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E9E9390B2D4
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942CB1F239BC
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5244D1D6E2D;
	Mon, 17 Jun 2024 13:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wKsfrooz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GH5JtHxh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D171D542E;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632282; cv=none; b=AqDnNa1ls5Cn7BJCcd1pq2N/eBYilCAmRyzU/qeodT1x00pYMvVVd1koxXzCPG4hLSo7zxy8GZMBytYTX8WPaihQMfmgeW8sII0rgA2qo+eMGkeaM5gPfVl4tgLfb0xRKTHJCEXPkW6O+d3K0otLkQz4wZT65G1BWhKHnOHN3GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632282; c=relaxed/simple;
	bh=4HgadTau/iVzDNAAuXN13V7BbWCUXTtqG5scDOWsxP4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QyBuP2D5jmtdFt9GzNG9eI+dD0MOxbepvftCeJ10GdwtP4xm3ZjTmUzEIRXGZ2PTOLUHLViXsuz7kab4zfZKxV9c4PQt/wBA9LF4zB/f7B1PchktWg9D6S6hx7pPX3fpRHzSZfMjuoVWepW65Ys8ZghJv85gr+FbDjxlla3GABQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wKsfrooz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GH5JtHxh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UehL95PsUdhhKI5mdnM9CwmrTADH6kRWf12xLuOu4mU=;
	b=wKsfroozw+67CQLxgja6C8o4yZombnj0R1J8u+0ud/w0ApbjxQMxoVksVSIsV42BSWW5B7
	2tkgqQs6nU2fRSHVY3HIBsd6vJWUs0Bt/pOxYG2D0Pf4EP8AgveJzD9DvmptQ3PL4IP+Fv
	t4kssvWwn4JdSSBF9hUOqM6oiGEUXirXJUit8GC6iTD47XaHonPC9BzPIW9eRjt9Vf//TO
	FT4LT1qSuKkwWmtn+HEDZFiIKTZ0s1ikCUHOEV1Ad8KFhR9CJapWbnO+Bt1RgFuhsFetLT
	gAFRnX14AXdGXbI6AZFjXCs9jJNWXVYizJljmKNVJApoHGs68A4zOkWIFZbBwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632275;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UehL95PsUdhhKI5mdnM9CwmrTADH6kRWf12xLuOu4mU=;
	b=GH5JtHxhgUgNr/jeflONOjYvKmiPfiJhKrYlA2rwz5UsD6QZvT4UWVw0wTZFyWqhrdM+pX
	WhU65vsXX64XKzCA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Introduce irq_domain_free()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-2-herve.codina@bootlin.com>
References: <20240614173232.1184015-2-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227514.10875.17056658925123094494.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     89b37541ca38954f8ac01c2ca25405b140cfc8eb
Gitweb:        https://git.kernel.org/tip/89b37541ca38954f8ac01c2ca25405b140cfc8eb
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:12 +02:00

irqdomain: Introduce irq_domain_free()

In preparation of the introduction of the irq domain instantiation,
introduce irq_domain_free() to avoid code duplication on later
modifications.

This new function is an extraction of the current operations performed
to free the irq domain. No functional change intended.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-2-herve.codina@bootlin.com

---
 kernel/irq/irqdomain.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7b4d580..40b631b 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -238,6 +238,15 @@ static void __irq_domain_publish(struct irq_domain *domain)
 	pr_debug("Added domain %s\n", domain->name);
 }
 
+static void irq_domain_free(struct irq_domain *domain)
+{
+	fwnode_dev_initialized(domain->fwnode, false);
+	fwnode_handle_put(domain->fwnode);
+	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+		kfree(domain->name);
+	kfree(domain);
+}
+
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @fwnode: firmware node for the interrupt controller
@@ -293,12 +302,7 @@ void irq_domain_remove(struct irq_domain *domain)
 	mutex_unlock(&irq_domain_mutex);
 
 	pr_debug("Removed domain %s\n", domain->name);
-
-	fwnode_dev_initialized(domain->fwnode, false);
-	fwnode_handle_put(domain->fwnode);
-	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
-		kfree(domain->name);
-	kfree(domain);
+	irq_domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove);
 

