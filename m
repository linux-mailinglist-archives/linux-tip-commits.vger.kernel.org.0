Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D932A34E658
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Mar 2021 13:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231701AbhC3LdP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 30 Mar 2021 07:33:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43456 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231797AbhC3LdD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 30 Mar 2021 07:33:03 -0400
Date:   Tue, 30 Mar 2021 11:33:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617103982;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4/2nlxsMomEvg9JuDd4W2YFX1avZb4XMJbsTvN9egk=;
        b=ATlwZNFwH1kmQptuIRM2XteVbTKLOSaYudUpCHyDJdbxIwY0lvoOgVdzciiiMF9mQqdloy
        cO/9PLyRvqwRLP2+78wQo279HiZpASqaWZKsjxMN9Gdw6xYTHVlmPahtgcBCsUamVWjNiW
        0N8GaamjJtBrrMb4o34tn2p21gqVWl63JriWMhEsm/txkfauQBkyPhIV2Smqr7p2ZiJFkZ
        cFGPbpA4TtcfKNaoDuOqTORFrxk13SbkTDP1ov/drgrWZWCu8KV3mZGdz2PfqNyD6PQpJF
        Lf+jve7HMuG2fdd9cJ5SfPQj2hwce6rDqJqi4Oh8OwzwCFz/MgCanHbqv48aHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617103982;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=j4/2nlxsMomEvg9JuDd4W2YFX1avZb4XMJbsTvN9egk=;
        b=hA/VseL1J/ImvIQKsAeCXyTaK+N3PQuC+DLkooPU6BCMLQIwk3IMelbbk96MWsxWAjLYQ2
        xWjJTdKsYy1bHGDw==
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
Message-ID: <161710398186.29796.10468614076924838440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     883ccef355b910398b99dfaf96d40557479a7e9b
Gitweb:        https://git.kernel.org/tip/883ccef355b910398b99dfaf96d40557479a7e9b
Author:        Bartosz Golaszewski <bgolaszewski@baylibre.com>
AuthorDate:    Mon, 01 Mar 2021 15:26:59 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Mar 2021 13:21:27 +02:00

genirq/irq_sim: Shrink devm_irq_domain_create_sim()

The custom devres structure manages only a single pointer which can
can be achieved by using devm_add_action_or_reset() as well which
makes the code simpler.

[ tglx: Fixed return value handling - found by smatch ]

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210301142659.8971-1-brgl@bgdev.pl
---
 kernel/irq/irq_sim.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/irq_sim.c b/kernel/irq/irq_sim.c
index 4800660..6e935d4 100644
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
+	if (ret)
+		return ERR_PTR(ret);
 
-	devres_add(dev, dr);
-	return dr->domain;
+	return domain;
 }
 EXPORT_SYMBOL_GPL(devm_irq_domain_create_sim);
