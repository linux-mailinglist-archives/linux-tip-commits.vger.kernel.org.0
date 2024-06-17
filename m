Return-Path: <linux-tip-commits+bounces-1417-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6777290B2C6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB89A283CC9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:48:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E2821D5412;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MSoYC6Gh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/JaNrO9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7F03200119;
	Mon, 17 Jun 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632279; cv=none; b=eo86xlQYt+4X/OwYsbY/3+Ta1oUsqj+Qrhf55JJC6y5lUnh4HFgWrLaPHTVaS0fw0c9b3C9QyqS0QYxjXIXsJsZ3m3PtAWFFrC82jcI6I7anj3byQxvMlDiEsWB/CSuugytCfw6qvQYkIGC+sXSGHUl3O5+PoA2w3W89L48CO2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632279; c=relaxed/simple;
	bh=qSUPl29VZGhKqstpe0V2fLCcXdwmGAXysBML+IwQy5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LBw6vQHmxKN07XsmUmKGOWm09d1kAJMfaR16UOtPgG3dM6cC/1X2v8/n4uyFhVtmbQMlwqbfJjKroe1DnN8g57ZU5f2GGTEtek28HAYygH8Mgl/Hp2llAs+qfBOLPLJQiHPJP/xD4b4+h5QkI9DfodQSskHvQsKjJbj93I+lOm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MSoYC6Gh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/JaNrO9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1rz4o6ULH+ucCrftt45u13rEZx/lg0c6RgzwSShz4k=;
	b=MSoYC6Ghxd/WLF+XspP5257/skrwLn8r1NCPZ4fwIrIBfzhvBI6ZV0Or7AjkML4TObqpml
	RaQSL4LIfhjzQKBXmre0f1sCBnjzB9RMEFvoUmyG9QAWOro6IIYOCmCIO6VOK1XSM0YEtZ
	bDMPUVVn0iol/2P2TJkhdH0JgQSkt4wE9SOiIYK+RVK7wMnaxwWJllQ9sbBfSXQnZ5xzZu
	kGxrTvWVrUf5D7BPvfTV6bDqn2mOlpG6InyogF/r2KlwB2jUX/k7uP01hNJ40Nl3lv9kGd
	YAufXtMDUwqZfd/ZufHTxdggpCYjCbSi5hZI6bGxV0ueLdQz/JpdWd5jeIb1+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632271;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W1rz4o6ULH+ucCrftt45u13rEZx/lg0c6RgzwSShz4k=;
	b=V/JaNrO9GU5i7dBY7L+54hu474epx4TS95E/OQfrip9K17rbefclYVK0P1aamjCsUWyCaI
	BgIBb3bASI2/5hDQ==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqdomain: Make __irq_domain_create() return an error code
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-11-herve.codina@bootlin.com>
References: <20240614173232.1184015-11-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227141.10875.12415644003575440270.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     80f6abe0d39bc6ccf353290067ff589653ff922c
Gitweb:        https://git.kernel.org/tip/80f6abe0d39bc6ccf353290067ff589653ff922c
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:13 +02:00

irqdomain: Make __irq_domain_create() return an error code

__irq_domain_create() can fail for several reasons. When it fails it
returns a NULL pointer and so filters out the exact failure reason.
The only user of __irq_domain_create() is irq_domain_instantiate() which
can return a PTR_ERR value. On __irq_domain_create() failure, it uses an
arbitrary error code.

Rather than using this arbitrary error value, make __irq_domain_create()
return is own error code and use that one.

[ tglx: Remove the pointless ERR_CAST. domain is a valid return pointer ]

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-11-herve.codina@bootlin.com

---
 kernel/irq/irqdomain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8dc0007..fe7bba6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -187,17 +187,17 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	if (WARN_ON((info->size && info->direct_max) ||
 		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && info->direct_max) ||
 		    (info->direct_max && info->direct_max != info->hwirq_max)))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	domain = kzalloc_node(struct_size(domain, revmap, info->size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(info->fwnode)));
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	err = irq_domain_set_name(domain, info->fwnode);
 	if (err) {
 		kfree(domain);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	domain->fwnode = fwnode_handle_get(info->fwnode);
@@ -260,8 +260,8 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	struct irq_domain *domain;
 
 	domain = __irq_domain_create(info);
-	if (!domain)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(domain))
+		return domain;
 
 	domain->flags |= info->domain_flags;
 

