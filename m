Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7D55C28A8BF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388624AbgJKR6U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40246 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388517AbgJKR5s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:48 -0400
Date:   Sun, 11 Oct 2020 17:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cPxcCGgSdi0yXrlbno8ZztE0a8BhHGAVtmiJGOdsnY=;
        b=E1ubES5watpi8zuKQvHEVz9GEc6bOLZIQO/ID97628jesg3E7jO1v5o7cnfRa2cYtJeH4D
        N7DvMeI02jHarCXgADjALfNaW9xArMz9x/RrF7NAIalYw2en5KKyWO1VbGEC0VKgZ/h2qV
        y6CWppliUtrLTmHmt0LcOPYSLJLA490OnaoxMRZddIbOpuepYwB8WUM1eWD7g7WB5yIVCA
        DLKyKDnxYssbizaXP8fbe1PWnMJQkBjJMhZ0rpQC6t4sFYq3yeVjLscaDIHnLVJk18qZ70
        vhKzfGLPQvJQWn92Q87owvEep+mViwz/Cs2tT9uoqb9QPkM1JJni7su74Ryytw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3cPxcCGgSdi0yXrlbno8ZztE0a8BhHGAVtmiJGOdsnY=;
        b=Reeb+K7zVjdJrsV+WlmI++ByJR8qHeWQe+ccFiIjL493qWA/KrOqlrNp9u0jfYod1+l+fq
        gCyeBehYFTgzp6AQ==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ti-sci-inta: Fix unsigned comparison to zero
Cc:     YueHaibing <yuehaibing@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826035430.21060-1-yuehaibing@huawei.com>
References: <20200826035430.21060-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <160243906578.7002.9555002535149424880.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4c9b1bfaa5039fee650f4de514a8e70ae976fc2f
Gitweb:        https://git.kernel.org/tip/4c9b1bfaa5039fee650f4de514a8e70ae976fc2f
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Wed, 26 Aug 2020 11:54:30 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 15:30:00 +01:00

irqchip/ti-sci-inta: Fix unsigned comparison to zero

ti_sci_inta_xlate_irq() return -ENOENT on fail, p_hwirq
should be int type.

Fixes: 5c4b585d2910 ("irqchip/ti-sci-inta: Add support for INTA directly connecting to GIC")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Lokesh Vutla <lokeshvutla@ti.com>
Link: https://lore.kernel.org/r/20200826035430.21060-1-yuehaibing@huawei.com
---
 drivers/irqchip/irq-ti-sci-inta.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-inta.c b/drivers/irqchip/irq-ti-sci-inta.c
index d4e9760..05bf94b 100644
--- a/drivers/irqchip/irq-ti-sci-inta.c
+++ b/drivers/irqchip/irq-ti-sci-inta.c
@@ -175,8 +175,8 @@ static struct ti_sci_inta_vint_desc *ti_sci_inta_alloc_parent_irq(struct irq_dom
 	struct irq_fwspec parent_fwspec;
 	struct device_node *parent_node;
 	unsigned int parent_virq;
-	u16 vint_id, p_hwirq;
-	int ret;
+	int p_hwirq, ret;
+	u16 vint_id;
 
 	vint_id = ti_sci_get_free_resource(inta->vint);
 	if (vint_id == TI_SCI_RESOURCE_NULL)
