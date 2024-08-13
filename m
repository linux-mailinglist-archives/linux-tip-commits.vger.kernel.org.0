Return-Path: <linux-tip-commits+bounces-2034-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29058950042
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 10:47:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A7FADB23EAF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Aug 2024 08:47:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48CD113B294;
	Tue, 13 Aug 2024 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i+uuIi/u";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Sgx4Vzk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8616139D05;
	Tue, 13 Aug 2024 08:47:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723538849; cv=none; b=B2xnqzaL9bc59hCu8wN5uTKiqClLkCXfBt37DnTRlF68aOk0gWlTrY5cf+FhqjVaBxI62wRAqDLdYUO8rxmQDb2NLrXZjUILwXBgDiPUuRi4eBesVG98UkdPvV9TY5pUeGveYuRn7GB2P2HIgpOS6xJG08Y5QVUE2NWX3vLsiJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723538849; c=relaxed/simple;
	bh=QFt6cA9V5XHosef2t0llppVEFUX6eU0vAsKCjWxN5Bc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iPvLBLRdzBSJl84Zj2WuUGrwPidRjBz/2RzvYI+jmtJg1r6juIJX8gmMIqbmnYSEpOeI8f+5tazlUmzwkrqSfyOBkkMyIvsQNfR3zvucYUvBBPjYzZK9sYgLt8aF6V3bH4HFJ9OdPZ15m0cbESsvwgoYmoNjqwIHLmqsBKjyObM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i+uuIi/u; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Sgx4Vzk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Aug 2024 08:47:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723538846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2mba2zbe5vCCRYVXnwJow2HUP/rdS4F1DZj0LQhiv8=;
	b=i+uuIi/uU0RsLAYmSDpzEG+k++dhKN+/2R5HKYlCyLv7dtwCGR0noxBXuTHH7WBlEkOR8n
	3fPjVjfCPp7ozRxWIRFbIn1tH8oVx48L8xUhM8Gr0QXhEi3/SrvNMygciYBDjWZDmep05Z
	Q6/dximIIQL+R87pFDdCqrAHHRTLB5FSi7bUhLzyAgNKuKkuS+/esgm26FwFsMnCNG0tKE
	afUT4qWAfRpk6JveP/Ws9iHLQ+VRujdG2kv83mRLrhG7ay8ey+HjgUVEHBjMI62bIoJfEM
	/MNojR3+H8UGpqYw5X0m6PWQio2APsHdRquOPop/+ttvaCy5m5NF9866FzMrGg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723538846;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2mba2zbe5vCCRYVXnwJow2HUP/rdS4F1DZj0LQhiv8=;
	b=1Sgx4Vzkxx0KEpf1p2S7F/FClqmLsFvy0A9KqpIRWe02JPg5rNULzrZCBEScnsl1raKnmt
	d/bzvV/5TaZaTqAQ==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Clarify checks for bus_token
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240812193101.1266625-2-andriy.shevchenko@linux.intel.com>
References: <20240812193101.1266625-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172353884572.2215.16761185917267853525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c0ece64497992473aabbcbb007e2afecc8d750a2
Gitweb:        https://git.kernel.org/tip/c0ece64497992473aabbcbb007e2afecc8d750a2
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Mon, 12 Aug 2024 22:29:39 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 13 Aug 2024 10:40:09 +02:00

irqdomain: Clarify checks for bus_token

The code uses if (bus_token) and if (bus_token == DOMAIN_BUS_ANY).

Since bus_token is an enum, the latter is more robust against changes.

Convert all !bus_token checks to explicitely check for DOMAIN_BUS_ANY.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240812193101.1266625-2-andriy.shevchenko@linux.intel.com

---
 kernel/irq/irqdomain.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 01001eb..18d253e 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -130,8 +130,10 @@ EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
 static int alloc_name(struct irq_domain *domain, char *base, enum irq_domain_bus_token bus_token)
 {
-	domain->name = bus_token ? kasprintf(GFP_KERNEL, "%s-%d", base, bus_token) :
-				   kasprintf(GFP_KERNEL, "%s", base);
+	if (bus_token == DOMAIN_BUS_ANY)
+		domain->name = kasprintf(GFP_KERNEL, "%s", base);
+	else
+		domain->name = kasprintf(GFP_KERNEL, "%s-%d", base, bus_token);
 	if (!domain->name)
 		return -ENOMEM;
 
@@ -146,8 +148,10 @@ static int alloc_fwnode_name(struct irq_domain *domain, const struct fwnode_hand
 	const char *suf = suffix ? : "";
 	char *name;
 
-	name = bus_token ? kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token) :
-			   kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
+	if (bus_token == DOMAIN_BUS_ANY)
+		name = kasprintf(GFP_KERNEL, "%pfw-%s", fwnode, suf);
+	else
+		name = kasprintf(GFP_KERNEL, "%pfw-%s%s%d", fwnode, suf, sep, bus_token);
 	if (!name)
 		return -ENOMEM;
 
@@ -166,11 +170,13 @@ static int alloc_unknown_name(struct irq_domain *domain, enum irq_domain_bus_tok
 	static atomic_t unknown_domains;
 	int id = atomic_inc_return(&unknown_domains);
 
-	domain->name = bus_token ? kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token) :
-				   kasprintf(GFP_KERNEL, "unknown-%d", id);
-
+	if (bus_token == DOMAIN_BUS_ANY)
+		domain->name = kasprintf(GFP_KERNEL, "unknown-%d", id);
+	else
+		domain->name = kasprintf(GFP_KERNEL, "unknown-%d-%d", id, bus_token);
 	if (!domain->name)
 		return -ENOMEM;
+
 	domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	return 0;
 }
@@ -200,7 +206,7 @@ static int irq_domain_set_name(struct irq_domain *domain, const struct irq_domai
 			return alloc_name(domain, fwid->name, bus_token);
 		default:
 			domain->name = fwid->name;
-			if (bus_token)
+			if (bus_token != DOMAIN_BUS_ANY)
 				return alloc_name(domain, fwid->name, bus_token);
 		}
 

