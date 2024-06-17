Return-Path: <linux-tip-commits+bounces-1419-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F7F90B2CD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBECC285295
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C4831D5CE0;
	Mon, 17 Jun 2024 13:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1qHQeKA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uEQq+fKD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E561D3364;
	Mon, 17 Jun 2024 13:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632280; cv=none; b=mdreSmpbeSFQh1FSrFcwM68Phl87ONXw8/r5wPF3Ri3j07Pd+LimL37wp46OSGNd6vh1vXvvQBx/R4pFC976qAokuje5ugXbvC+Mp5c0G0mRMPXoBgWd2/jBhxpD9lx7XeC9DFb5OJKubTT90H3aHpBe+KIuVoKA8lqF04Z4F5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632280; c=relaxed/simple;
	bh=dhDkwz8qdBSQrJq04vW3TUfBGcQMz834a6TdEV0dGoo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VMc3+ZUEpGa5yiIcR/yXANjQhEyHthPZgag9h9Ra9LFFVt6jSd0g6+HHPax7PB/t12dow/37fV3YVDvO2HS05Gcc5lqtQdFsBeXvC9QUf2JFfk9pczYxRAhaezbKOohmyUwlj+HWpVa/1hThEnigSKpUZGcdblvh6yn0kKXb+L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1qHQeKA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uEQq+fKD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqu0o5FSPIf0yV2SEMsSA6mOpMKIcUSbKd1eXyiGbCc=;
	b=c1qHQeKAIMzdylGKCClL8htVQ0gE+30dOgfVLRCJR1OCXEwKOqh15QeUAbrgFHN3ou7alP
	J3vTA/cpRe9p5jn66TRQolfyT6qK90I8QVdwnsQEjAzDvulJ4tJz4AXoa07z13OwHadXjg
	cwIKs2wsNIffAj0D7c2JT1U64KGnrq8IEWoqWLCdRowosAXzd05O5tjtubr0aZdrK2cxQX
	5Tt6jzVPEa20v1GmwnAR8aNsXfbM3Y3lfRHqN42Yw5gj0RF9hnaX/Xb5xT4BWGehFBicWY
	Li7AxtJ3EN/8kyZl1qfNy7nTLrsfP4LC9h1ZGZtXUxJdUFLmsjCmUOgK4FBkdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xqu0o5FSPIf0yV2SEMsSA6mOpMKIcUSbKd1eXyiGbCc=;
	b=uEQq+fKD/D50M9YChfNryMXBsMvOniB9DaePnCAyvgPFUMOUAaXaxoYRNu2oDF4x8To/xk
	AxZs542dBAlBdNBA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Handle additional domain flags in
 irq_domain_instantiate()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-8-herve.codina@bootlin.com>
References: <20240614173232.1184015-8-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227229.10875.11863294387065920396.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     757398541c30a5e898169763b43f08dab71ea3bd
Gitweb:        https://git.kernel.org/tip/757398541c30a5e898169763b43f08dab71ea3bd
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:13 +02:00

irqdomain: Handle additional domain flags in irq_domain_instantiate()

In order to use irq_domain_instantiate() from several places such as
irq_domain_create_hierarchy(), irq_domain_instantiate() needs to handle
additional domain flags.

Add the required infrastructure.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-8-herve.codina@bootlin.com

---
 include/linux/irqdomain.h | 2 ++
 kernel/irq/irqdomain.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a3b43e3..4683b66 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -260,6 +260,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
 /**
  * struct irq_domain_info - Domain information structure
  * @fwnode:		firmware node for the interrupt controller
+ * @domain_flags:	Additional flags to add to the domain flags
  * @size:		Size of linear map; 0 for radix mapping only
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
@@ -269,6 +270,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  */
 struct irq_domain_info {
 	struct fwnode_handle			*fwnode;
+	unsigned int				domain_flags;
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0eda48f..26ad1ea 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -263,6 +263,8 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	domain->flags |= info->domain_flags;
+
 	__irq_domain_publish(domain);
 
 	return domain;

