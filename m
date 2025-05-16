Return-Path: <linux-tip-commits+bounces-5602-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1061DABA3F9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:40:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C7C97B64C5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1A5B283FFD;
	Fri, 16 May 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l6mfsIts";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r/DsBd01"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B836F283CA3;
	Fri, 16 May 2025 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424254; cv=none; b=Ja6CJtbfi2kLSFos2FnnNk/2mlg6X7+MbpQPWd0sAhDWi5O1dvTlzus/ET5eY+ldr44zuY3/RxCKUm19tm66r2gRaSn2uiPbxRai11ioWHnTOnPyy8C+3RptmhXaVtqwOeWPf3zt56gP9/18Ped6UEvpEfJYoSe8t6YTLLX/I1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424254; c=relaxed/simple;
	bh=8dosCyTZ10loKkALlzU8ZgSR4WkUEZZtX7RYjcac1zo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ikXchcc4E8ISnT/S576c2mNfx3SvwtG775zjwwiSjqTjnMiT8DEaHePr13jNXSQh6ei9wu5xd2T5QlXXewEYM3MsXOJLS+MVDa+Xcbfw59FXTCFczGeJ1tRnaxyi3EOY/dxvLTX48WNZFWdY2au5NniVjZhXNhRT6a+sN31kzEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l6mfsIts; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r/DsBd01; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjkfB8BR74xBkbnXJw3JcuQd+eIOy01QxmwbTuQwKiY=;
	b=l6mfsItsqU7hTfqDAue1c6Gs4bhhW6NdwWxf+/HVkcfp5g5XawBt9jcjJH9acsZ3+u8TB1
	OyYZ0t4L1KQnzXbufwEsZYgkplV4DCFUkx4hqqQmR6S4S90yGMS6WSJKG9BCch3EuHW8aC
	k1e98jGQrHYAY7p5zhJ3Py+3NDluIo2H+xoZLiMa1AXzIXNu2ilVWhTK5zMlj4PWUq4zNI
	iUMaAdt0j1lf9C95dW+HYCe/A6tquofsXNncrBVpA5hLfYnbgqurL0i7tnwkH0CTIEqvxE
	hYCLIdzTRZJSPCKn0eK3GdoZYzK7YcdRdsDI4k8gNcBt1+p+1740K1iMaXN2Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424251;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qjkfB8BR74xBkbnXJw3JcuQd+eIOy01QxmwbTuQwKiY=;
	b=r/DsBd01o/YYf0Sntt0dJ01Vq6RP+tnJYPk3sT5C4o6uYeQ9eqpIaLdGlYhb3TTiMtMvJY
	+Ehtn7QN9w8GdRAw==
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
Message-ID: <174742425052.406.16841182000504533304.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     6e4e30d70a91c04ccd563b3127486a736ddf0f3c
Gitweb:        https://git.kernel.org/tip/6e4e30d70a91c04ccd563b3127486a736ddf0f3c
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:11 +02:00

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

