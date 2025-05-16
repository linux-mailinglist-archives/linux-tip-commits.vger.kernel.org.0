Return-Path: <linux-tip-commits+bounces-5572-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBDEAB999E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 12:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84637189CC18
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 10:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A080233727;
	Fri, 16 May 2025 10:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nnj6qnh3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kprxCpJg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 224B12222D1;
	Fri, 16 May 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389742; cv=none; b=R0RvvFjows8YfkYTXDlpq/Y6uhRUF4m+1FU6DeESY4vjK5nuvEtTY9WvB8EnnBtW5R1zk0eSkISuBak2BFXFUp+E/KpIoiCifMQn7k33MzYE3XIlFuYFs3ibRIxlaQVJmRjyXed7KD/5f+f3wOyg+qY5T+8It783ZYWvU0gQT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389742; c=relaxed/simple;
	bh=eluKHMo6kCvBNzAtELPZVi4ooCydwQ63Rv/EKlaMOCA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DbqyX6jAYd9zPOpcJwvM0FHI6feJ/9jpoUCrj1bUuv3QdHd2Hc9nnq/H25ufXdmBctDEuq3cwr2dioxEcZQDAXrwvec7sQ9433h5LQlJ6rycXd30gA9NskYqenZ5cXNk2qMdamwvBQEWMXYaqm0elnroruluxCoYrgPFlt4NvWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nnj6qnh3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kprxCpJg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 10:02:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747389738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuzZDvomqhuZfGOaDp3VtRoRbKFdDc/bBTWmnhCkO5s=;
	b=nnj6qnh3dC/25YzHCTFPFq1L4bq/J75wsdckq2e2k0M4ERhhUj4d58JOpchZtrK6RZB2s4
	/BBnrcaX8nA4eGV+3qzLcXOfWZuO62TCk1uZJcnf7l/oZBtoT5a1BCTxqMvtKP9tn46hJq
	uUMQBq5b425NM4WXyItOp/KUWZ+DZlTaV4AtpLt/KqLU22Zu3yMOZ7eb5dSUrBAuCEEbYc
	1V0aSB2rFy7gq5HTgWDYkQ4guOR2OuZBV5woEX/WITlwzqDFsLE8A+W7tFfah4+2R9Ji2T
	AHlhx/3zkAi0UC9BBihYwfcpd5Jixo2jYWA4lDx4Jzw7xnO9Qo+XeaOjd2jC5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747389738;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CuzZDvomqhuZfGOaDp3VtRoRbKFdDc/bBTWmnhCkO5s=;
	b=kprxCpJgiBb3mXD/g40r5TM4SL+unkY2mLJMY6b48PDJdJByUXxMfsd2vlULvu7jmTW2c7
	TaZcUWxJR88IM9CQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] genirq/msi: Move prepare() call to per-device allocation
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513163144.2215824-4-maz@kernel.org>
References: <20250513163144.2215824-4-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738973725.406.10977203030895255334.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     1396e89e09f00deb816e5f4a176d71d554922292
Gitweb:        https://git.kernel.org/tip/1396e89e09f00deb816e5f4a176d71d554922292
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 17:31:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 May 2025 12:36:41 +02:00

genirq/msi: Move prepare() call to per-device allocation

The current device MSI infrastructure is subtly broken, as it will issue an
.msi_prepare() callback into the MSI controller driver every time it needs
to allocate an MSI. That's pretty wrong, as the contract (or unwarranted
assumption, depending who you ask) between the MSI controller and the core
code is that .msi_prepare() is called exactly once per device.

This leads to some subtle breakage in some MSI controller drivers, as it
gives the impression that there are multiple endpoints sharing a bus
identifier (RID in PCI parlance, DID for GICv3+). It implies that whatever
allocation the ITS driver (for example) has done on behalf of these devices
cannot be undone, as there is no way to track the shared state. This is
particularly bad for wire-MSI devices, for which .msi_prepare() is called
for each input line.

To address this issue, move the call to .msi_prepare() to take place at the
point of irq domain allocation, which is the only place that makes
sense. The msi_alloc_info_t structure is made part of the
msi_domain_template, so that its life-cycle is that of the domain as well.

Finally, the msi_info::alloc_data field is made to point at this allocation
tracking structure, ensuring that it is carried around the block.

This is all pretty straightforward, except for the non-device-MSI
leftovers, which still have to call .msi_prepare() at the old spot. One
day...

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513163144.2215824-4-maz@kernel.org

---
 include/linux/msi.h |  2 ++
 kernel/irq/msi.c    | 35 +++++++++++++++++++++++++++++++----
 2 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index 63c2300..f4b94cc 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -516,12 +516,14 @@ struct msi_domain_info {
  * @chip:	Interrupt chip for this domain
  * @ops:	MSI domain ops
  * @info:	MSI domain info data
+ * @alloc_info:	MSI domain allocation data (architecture specific)
  */
 struct msi_domain_template {
 	char			name[48];
 	struct irq_chip		chip;
 	struct msi_domain_ops	ops;
 	struct msi_domain_info	info;
+	msi_alloc_info_t	alloc_info;
 };
 
 /*
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 00f4d87..1098f26 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -59,7 +59,8 @@ struct msi_ctrl {
 static void msi_domain_free_locked(struct device *dev, struct msi_ctrl *ctrl);
 static unsigned int msi_domain_get_hwsize(struct device *dev, unsigned int domid);
 static inline int msi_sysfs_create_group(struct device *dev);
-
+static int msi_domain_prepare_irqs(struct irq_domain *domain, struct device *dev,
+				   int nvec, msi_alloc_info_t *arg);
 
 /**
  * msi_alloc_desc - Allocate an initialized msi_desc
@@ -1023,6 +1024,7 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	bundle->info.ops = &bundle->ops;
 	bundle->info.data = domain_data;
 	bundle->info.chip_data = chip_data;
+	bundle->info.alloc_data = &bundle->alloc_info;
 
 	pops = parent->msi_parent_ops;
 	snprintf(bundle->name, sizeof(bundle->name), "%s%s-%s",
@@ -1061,11 +1063,18 @@ bool msi_create_device_irq_domain(struct device *dev, unsigned int domid,
 	if (!domain)
 		return false;
 
+	domain->dev = dev;
+	dev->msi.data->__domains[domid].domain = domain;
+
+	if (msi_domain_prepare_irqs(domain, dev, hwsize, &bundle->alloc_info)) {
+		dev->msi.data->__domains[domid].domain = NULL;
+		irq_domain_remove(domain);
+		return false;
+	}
+
 	/* @bundle and @fwnode_alloced are now in use. Prevent cleanup */
 	retain_and_null_ptr(bundle);
 	retain_and_null_ptr(fwnode_alloced);
-	domain->dev = dev;
-	dev->msi.data->__domains[domid].domain = domain;
 	return true;
 }
 
@@ -1232,6 +1241,24 @@ static int msi_init_virq(struct irq_domain *domain, int virq, unsigned int vflag
 	return 0;
 }
 
+static int populate_alloc_info(struct irq_domain *domain, struct device *dev,
+			       unsigned int nirqs, msi_alloc_info_t *arg)
+{
+	struct msi_domain_info *info = domain->host_data;
+
+	/*
+	 * If the caller has provided a template alloc info, use that. Once
+	 * all users of msi_create_irq_domain() have been eliminated, this
+	 * should be the only source of allocation information, and the
+	 * prepare call below should be finally removed.
+	 */
+	if (!info->alloc_data)
+		return msi_domain_prepare_irqs(domain, dev, nirqs, arg);
+
+	*arg = *info->alloc_data;
+	return 0;
+}
+
 static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain,
 				   struct msi_ctrl *ctrl)
 {
@@ -1244,7 +1271,7 @@ static int __msi_domain_alloc_irqs(struct device *dev, struct irq_domain *domain
 	unsigned long idx;
 	int i, ret, virq;
 
-	ret = msi_domain_prepare_irqs(domain, dev, ctrl->nirqs, &arg);
+	ret = populate_alloc_info(domain, dev, ctrl->nirqs, &arg);
 	if (ret)
 		return ret;
 

