Return-Path: <linux-tip-commits+bounces-5435-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17026AAE11B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:47:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81E719A1CA6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD5028B41F;
	Wed,  7 May 2025 13:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WmV1DgzL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9p3wI4D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11B728B3E8;
	Wed,  7 May 2025 13:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625459; cv=none; b=DTjnj34or0eiZlsuRx5hOfxwqVjw1b418YLJLlLHU75KZZV3Az7y1b+86ijUUCZTNv4UITf73uogb0O+QEXr+/ggL9ZtL7dn/bw2gdmjpBPy6Gr+TxOOcJ6qeVWdjNiVVCb/5TEYJnVkkMYNcsKxZnN3Xd88Ht2ATfkO6QTWFec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625459; c=relaxed/simple;
	bh=jJMVzkaIQ4RZdCKL0Y1fqjHpiL8u+ITmp4m5o3NUYMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BrwiAAaxb6fzuzqwrdPNK/JBcpmtp0o/u2b7VQyoMYOMT7B+Cr6QqMnvNOBcrTY6v/Erd4njjIdSTulLxrybQ61X8kiSXmNJauNf8cGzlxR9pxpScSDphWCHTrfT/WLzGQw7bak16AL7JBaJBcnlP/j4RLb1hHCfuSo5MBftVq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WmV1DgzL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9p3wI4D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GctvKyjyLkiDSub8Q24O/osvhuXG2Ka1YQZXDxPL82o=;
	b=WmV1DgzLwzU+2pGTnCa+2ADwj8j7rKBz60p8jOvZ5cT9Uv1Ldvx6dZ1KvGtQh8F4MvUU1q
	3tj7Sje0Pa07TR9dgafMKopT4NfX5Trddi9lU4YHkhFIF82AsNye6p+xPEXmitvTla8Rcj
	6v8d/h/cTys2FVIdDAfGg8kGGmQeezoQqB84A4kHaGfOcW+ok2h/QgqL4zll/xQKATPlky
	GD6O1Z/h4FWiozC1JYOABRWHjzLXnt2AJ8LJg62/zJ/BpY4NUSA+kTf55CsLu77gR0M2mi
	apxKf3soNQe/GfmNJ+oqyyq0dJch3b6j/ha+zyrTLA6X/g6OzSJH0UcKVZSlZw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GctvKyjyLkiDSub8Q24O/osvhuXG2Ka1YQZXDxPL82o=;
	b=n9p3wI4DqSbHxSgDmvth7yAx3BJjudja8PVoohJZALXJK7KBiCOwOZ1sjm01EhXmfeh3wY
	JxGqPZflcObrcGBg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] soc: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-35-jirislaby@kernel.org>
References: <20250319092951.37667-35-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662545557.406.15471160903822126401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     327da7eb6770337d1de81c971748536a59ea794a
Gitweb:        https://git.kernel.org/tip/327da7eb6770337d1de81c971748536a59ea794a
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:40 +02:00

soc: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Christophe Leroy <christophe.leroy@csgroup.eu> # For soc/fsl
Link: https://lore.kernel.org/all/20250319092951.37667-35-jirislaby@kernel.org


---
 drivers/soc/dove/pmu.c     | 4 ++--
 drivers/soc/fsl/qe/qe_ic.c | 4 ++--
 drivers/soc/qcom/smp2p.c   | 2 +-
 drivers/soc/qcom/smsm.c    | 2 +-
 drivers/soc/tegra/pmc.c    | 5 +++--
 5 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 6202dbc..cfc0efa 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -274,8 +274,8 @@ static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)
 	writel(0, pmu->pmc_base + PMC_IRQ_MASK);
 	writel(0, pmu->pmc_base + PMC_IRQ_CAUSE);
 
-	domain = irq_domain_add_linear(pmu->of_node, NR_PMU_IRQS,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_create_linear(of_fwnode_handle(pmu->of_node), NR_PMU_IRQS,
+					  &irq_generic_chip_ops, NULL);
 	if (!domain) {
 		pr_err("%s: unable to add irq domain\n", name);
 		return -ENOMEM;
diff --git a/drivers/soc/fsl/qe/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
index 77bf0e8..e4b6ff2 100644
--- a/drivers/soc/fsl/qe/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -446,8 +446,8 @@ static int qe_ic_init(struct platform_device *pdev)
 		high_handler = NULL;
 	}
 
-	qe_ic->irqhost = irq_domain_add_linear(node, NR_QE_IC_INTS,
-					       &qe_ic_host_ops, qe_ic);
+	qe_ic->irqhost = irq_domain_create_linear(of_fwnode_handle(node), NR_QE_IC_INTS,
+						  &qe_ic_host_ops, qe_ic);
 	if (qe_ic->irqhost == NULL) {
 		dev_err(dev, "failed to add irq domain\n");
 		return -ENODEV;
diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
index a3e88ce..8c8878b 100644
--- a/drivers/soc/qcom/smp2p.c
+++ b/drivers/soc/qcom/smp2p.c
@@ -399,7 +399,7 @@ static int qcom_smp2p_inbound_entry(struct qcom_smp2p *smp2p,
 				    struct smp2p_entry *entry,
 				    struct device_node *node)
 {
-	entry->domain = irq_domain_add_linear(node, 32, &smp2p_irq_ops, entry);
+	entry->domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &smp2p_irq_ops, entry);
 	if (!entry->domain) {
 		dev_err(smp2p->dev, "failed to add irq_domain\n");
 		return -ENOMEM;
diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
index e803ea3..021e9d1 100644
--- a/drivers/soc/qcom/smsm.c
+++ b/drivers/soc/qcom/smsm.c
@@ -456,7 +456,7 @@ static int smsm_inbound_entry(struct qcom_smsm *smsm,
 		return ret;
 	}
 
-	entry->domain = irq_domain_add_linear(node, 32, &smsm_irq_ops, entry);
+	entry->domain = irq_domain_create_linear(of_fwnode_handle(node), 32, &smsm_irq_ops, entry);
 	if (!entry->domain) {
 		dev_err(smsm->dev, "failed to add irq_domain\n");
 		return -ENOMEM;
diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index 51b9d85..e0d67bf 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2500,8 +2500,9 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 	pmc->irq.irq_set_type = pmc->soc->irq_set_type;
 	pmc->irq.irq_set_wake = pmc->soc->irq_set_wake;
 
-	pmc->domain = irq_domain_add_hierarchy(parent, 0, 96, pmc->dev->of_node,
-					       &tegra_pmc_irq_domain_ops, pmc);
+	pmc->domain = irq_domain_create_hierarchy(parent, 0, 96,
+						  of_fwnode_handle(pmc->dev->of_node),
+						  &tegra_pmc_irq_domain_ops, pmc);
 	if (!pmc->domain) {
 		dev_err(pmc->dev, "failed to allocate domain\n");
 		return -ENOMEM;

