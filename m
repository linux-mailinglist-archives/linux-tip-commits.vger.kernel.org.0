Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6EB8D34D17C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Mar 2021 15:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbhC2Njh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 29 Mar 2021 09:39:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36462 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbhC2NjY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 29 Mar 2021 09:39:24 -0400
Date:   Mon, 29 Mar 2021 13:39:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617025163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLB2BNsCt+BijSiuIwiFC9FjqsqOmLqZvmmRmrZ2cs8=;
        b=CT5VgYyoO8YeSAEzGG1nMMsoA6NhiTcUCpGgSPvyEQ9BCo07w2BfM/puPOOXcnUIAEgvcN
        r4gTOC3n0bEooT6CWKFFIDE7CZBJrjDeOfEpzkke92GL9l85nvro7V86qtPCP1tCT/7wff
        gvVUZ2akGoIshvG+FQxu/JJHAfBWUxcdfsFVgynz6nni0ttjMaoRn1cu5zNs1ObsslpNYd
        OYop4LiACMFeKythEogO6pWQ1lHXNR77jREepMu/ABaY1d/CylS0wWTivX+bxBqnO5c84D
        ItsrQD8O+xLk2vxv1/BMe6fBUp2DsOarAVB+pqR35XEmzkym37Wqk1WZ3xTFvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617025163;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HLB2BNsCt+BijSiuIwiFC9FjqsqOmLqZvmmRmrZ2cs8=;
        b=uEl9uMKOwvFCCDir3eCiZpv4H5Zf+wet6fvPp2xLWR+dq9BCE7mFhTC2nSIwKiFreUXkwz
        FGvDgWJaxLnqrMAw==
From:   "tip-bot2 for Bartosz Golaszewski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irq_sim: Shrink devm_irq_domain_create_sim()
Cc:     Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210301142659.8971-1-brgl@bgdev.pl>
References: <20210301142659.8971-1-brgl@bgdev.pl>
MIME-Version: 1.0
Message-ID: <161702516235.29796.2614144333096477246.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e6d46eded43dacf6370a7ae70f927ef4692cfcab
Gitweb:        https://git.kernel.org/tip/e6d46eded43dacf6370a7ae70f927ef4692cfcab
Author:        Bartosz Golaszewski <bgolaszewski@baylibre.com>
AuthorDate:    Mon, 01 Mar 2021 15:26:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Mar 2021 15:36:00 +02:00

genirq/irq_sim: Shrink devm_irq_domain_create_sim()

The custom devres structure manages only a single pointer which can
can be achieved by using devm_add_action_or_reset() as well which
makes the code simpler.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210301142659.8971-1-brgl@bgdev.pl

---
 kernel/irq/irq_sim.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 4800660..ee40a84 100644
--- a/kernel/irq/irq_sim.c
+++ b/kernel/irq/irq_sim.c
@@ -24,10 +24,6 @@ struct irq_sim_irq_ctx {
 	struct irq_sim_work_ctx	*work_ctx;
 };
 
-struct irq_sim_devres {
-	struct irq_domain	*domain;
-};
-
 static void irq_sim_irqmask(struct irq_data *data)
 {
 	struct irq_sim_irq_ctx *irq_ctx = irq_data_get_irq_chip_data(data);
@@ -216,11 +212,11 @@ void irq_domain_remove_sim(struct irq_domain *domain)
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove_sim);
 
-static void devm_irq_domain_release_sim(struct device *dev, void *res)
+static void devm_irq_domain_remove_sim(void *data)
 {
-	struct irq_sim_devres *this = res;
+	struct irq_domain *domain = data;
 
-	irq_domain_remove_sim(this->domain);
+	irq_domain_remove_sim(domain);
 }
 
 /**
@@ -238,20 +234,17 @@ struct irq_domain *devm_irq_domain_create_sim(struct device *dev,
 					      struct fwnode_handle *fwnode,
 					      unsigned int num_irqs)
 {
-	struct irq_sim_devres *dr;
+	struct irq_domain *domain;
+	int ret;
 
-	dr = devres_alloc(devm_irq_domain_release_sim,
-			  sizeof(*dr), GFP_KERNEL);
-	if (!dr)
-		return ERR_PTR(-ENOMEM);
+	domain = irq_domain_create_sim(fwnode, num_irqs);
+	if (IS_ERR(domain))
+		return domain;
 
-	dr->domain = irq_domain_create_sim(fwnode, num_irqs);
-	if (IS_ERR(dr->domain)) {
-		devres_free(dr);
-		return dr->domain;
-	}
+	ret = devm_add_action_or_reset(dev, devm_irq_domain_remove_sim, domain);
+	if (!ret)
+		return ERR_PTR(ret);
 
-	devres_add(dev, dr);
-	return dr->domain;
+	return domain;
 }
 EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
