Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE3CD2C8608
	for <lists+linux-tip-commits@lfdr.de>; Mon, 30 Nov 2020 14:57:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727386AbgK3N47 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 30 Nov 2020 08:56:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48874 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726318AbgK3N47 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 30 Nov 2020 08:56:59 -0500
Date:   Mon, 30 Nov 2020 13:56:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606744577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wOc56v3Po34nSJCF8myJonWEzsvj5LWUJzUmKQLEWls=;
        b=cjHhI9u45ddxYWLUKYui0ZZmMco8cPeBG2+FtU+CrzG/l5LUV79JsY3c33PNTU7MvKeD4R
        wW/ZS5eMfgHkqX4MONYzV1HrJbDDSnGitAh9FRDTFI2bXaIzTxJAqOnad3CF6xKVP9HIaN
        ssR+x7EHeVskI4Jp1JRQ+ATKpj6QYs2k5roNJSWGR9JvQnLuxxUu5qodXEKpXvIfLn5ifu
        m3HSy8l4vlTDQfO3607Hz5qdZsr9QSLHy0Mos7e1WByoDIgB9BaD7phM4k27buCwvFv/JG
        kfhCyOL8dsnofthGxAtUboxJDM8EMik58rDJ02WLsTvcnm3pNsPhFMdxmeyu6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606744577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wOc56v3Po34nSJCF8myJonWEzsvj5LWUJzUmKQLEWls=;
        b=t2nWVJ6k7qsrqrKkb9DwM2lFOuEtSyvAPURVtPLFbGDwRhVbSbFph9AznRiux445ZKML1i
        TXuDNfM8Y7CyXnCg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Don't try to free an interrupt that
 has no mapping
Cc:     Marc Zyngier <maz@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201129135551.396777-1-maz@kernel.org>
References: <20201129135551.396777-1-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <160674457627.3364.6530359983188105313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4615fbc3788ddc8e7c6d697714ad35a53729aa2c
Gitweb:        https://git.kernel.org/tip/4615fbc3788ddc8e7c6d697714ad35a53729aa2c
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 29 Nov 2020 13:55:51 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 30 Nov 2020 14:50:21 +01:00

genirq/irqdomain: Don't try to free an interrupt that has no mapping

When an interrupt allocation fails for N interrupts, it is pretty
common for the error handling code to free the same number of interrupts,
no matter how many interrupts have actually been allocated.

This may result in the domain freeing code to be unexpectedly called
for interrupts that have no mapping in that domain. Things end pretty
badly.

Instead, add some checks to irq_domain_free_irqs_hierarchy() to make sure
that thiss does not follow the hierarchy if no mapping exists for a given
interrupt.

Fixes: 6a6544e520abe ("genirq/irqdomain: Remove auto-recursive hierarchy support")
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201129135551.396777-1-maz@kernel.org

---
 kernel/irq/irqdomain.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 3d7463f..30a7887 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1381,8 +1381,15 @@ static void irq_domain_free_irqs_hierarchy(struct irq_domain *domain,
 					   unsigned int irq_base,
 					   unsigned int nr_irqs)
 {
-	if (domain->ops->free)
-		domain->ops->free(domain, irq_base, nr_irqs);
+	unsigned int i;
+
+	if (!domain->ops->free)
+		return;
+
+	for (i = 0; i < nr_irqs; i++) {
+		if (irq_domain_get_irq_data(domain, irq_base + i))
+			domain->ops->free(domain, irq_base + i, 1);
+	}
 }
 
 int irq_domain_alloc_irqs_hierarchy(struct irq_domain *domain,
