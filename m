Return-Path: <linux-tip-commits+bounces-5286-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F999AAC5D7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05C8D5251F4
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E43284B5B;
	Tue,  6 May 2025 13:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dVBm90dn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="geii/a+L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF67C28466E;
	Tue,  6 May 2025 13:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537630; cv=none; b=X+DCLM1UfUKfwPToPuXOEFrJ4K4z68NJMFDRPttdrj7qxPzU3X1yVSAl+t90CaP1cmKzaGhLiQz8w9V0fQZ0+e8Imdyw320o1D2Tmq4RZ5dSsOidNxCyOKPtNocl87sD9Lge8ceYUo4xXmAtw6uoFlOdMk2yHDM1Vg2UpGS+7tM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537630; c=relaxed/simple;
	bh=jP6TmN5YpXYXp2IwpXOSRvDT4dvp21D90yu+icCVu9s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l+XnhyCjLQHPaSneVMTu0VZz10AxYvqpQxltvtFlHIV7sKYMNq1pS4VAb6ZWRvWNX8qrgbe+xIj+mTNQiN30Yx2g+mhJuRR/leGxyfS80CL4XYNXgkAyuaiqjDOY7tmMapXQPkl9etf8MM6WaV9Cghx/fW0+1jqIfzuzEn7pqGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dVBm90dn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=geii/a+L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw5/b8+PA/ZAn4q8j8HkoYx5nRrawdi4SvZNdLTisaA=;
	b=dVBm90dnokr2rk5YLu3QuEjmd1gUNI471VIg/bw+eeGc4nlXmpcrzW2NO8edoFwQ+tmCAx
	aLEXin20QjXtFXngXwBDyz56Yd9YA4qXiZ+izVoxf1GO8xtukPimgv4utQH6QUGCwcWJ9M
	oxG+O8A+9iuVFr3Q9Yti6G1xII06o5H5NPAChZgJnsnWwzxtN7jBwECmiYSGePdBss/0zE
	6JlZFBYWHT5/ub4CmW17q9LPABs+ok7zlkAV/zojzZ7BZgNl1uH55ROe460TkNUwmF8t0b
	Cdygz01iqJ/kWSOC8JhY3U8wubR/SYHAe2DGEbh0y+5d05r39MYphHgYLp/82A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537626;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mw5/b8+PA/ZAn4q8j8HkoYx5nRrawdi4SvZNdLTisaA=;
	b=geii/a+L+9wyXose0NGaTFFi1ojyJDF1y+DjhIk2CbfhQYyGSCV4x7HRPMVmBSfjjCzdhe
	q5VbJh33rbiHVTCg==
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
Message-ID: <174653762552.406.6024074035322576146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     8669b2840ef4a797bb38e248f1ab8d9c2b0d1d4f
Gitweb:        https://git.kernel.org/tip/8669b2840ef4a797bb38e248f1ab8d9c2b0d1d4f
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:07 +02:00

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

