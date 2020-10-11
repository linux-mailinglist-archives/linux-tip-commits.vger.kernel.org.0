Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAC8B28A8C0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgJKR6b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388518AbgJKR5r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC1DC0613D2;
        Sun, 11 Oct 2020 10:57:47 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nuA9yPmW+AM30j9wVeq18M7ezL6cMjkDFqsu3JXLtYY=;
        b=QkxiWVLozevQhngGHenblDp+abDkqVj1r8bivwmrQTg7V3G0gG5SD905NGaQVAFwblcdbF
        OIDKri0EdGH0bahVQV2h4XLPEhR5g9C6Pmcz11Jqh45FCLCGRA9L9O/EE4uC6kOUBKAan3
        ib4g8BPv8IvJObQdH0Nh2fQHd4jqQLvOrM9Ql3CjisDegoQct2zmBnJGqteTyb7mMBUteq
        t6myLCgMMLfZhRtqr1aYBaYAtI8nmJUefY2nJqRduoMWy4lzyNClrEUq9tL3OPmqVkwVPe
        ER47uDBzj3ww67oF4LhA9c02QBHJIScp0eR4gsZk7b2C5MjNpetDe7gXyQqHpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nuA9yPmW+AM30j9wVeq18M7ezL6cMjkDFqsu3JXLtYY=;
        b=7PqV4M/Ouy6InVuYRfd3476ZPDi3QOMryYRuOaE8mw4GKcT1TVlSV7JzrBB0HOt4zTgr0s
        7D0X8FVtVQ1aglBw==
From:   "tip-bot2 for YueHaibing" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/ti-sci-intr: Fix unsigned comparison to zero
Cc:     YueHaibing <yuehaibing@huawei.com>, Marc Zyngier <maz@kernel.org>,
        Lokesh Vutla <lokeshvutla@ti.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826035321.18620-1-yuehaibing@huawei.com>
References: <20200826035321.18620-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Message-ID: <160243906530.7002.8301252740397767336.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8ddf1905a904ca86d71ca1c435e4b0b2a0b70df8
Gitweb:        https://git.kernel.org/tip/8ddf1905a904ca86d71ca1c435e4b0b2a0b70df8
Author:        YueHaibing <yuehaibing@huawei.com>
AuthorDate:    Wed, 26 Aug 2020 11:53:21 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 15:30:00 +01:00

irqchip/ti-sci-intr: Fix unsigned comparison to zero

ti_sci_intr_xlate_irq() return -ENOENT on fail, p_hwirq
should be int type.

Fixes: a5b659bd4bc7 ("irqchip/ti-sci-intr: Add support for INTR being a parent to INTR")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Acked-by: Lokesh Vutla <lokeshvutla@ti.com>
Link: https://lore.kernel.org/r/20200826035321.18620-1-yuehaibing@huawei.com
---
 drivers/irqchip/irq-ti-sci-intr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-intr.c
index cbc1758..85a72b5 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -137,8 +137,8 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
 	struct ti_sci_intr_irq_domain *intr = domain->host_data;
 	struct device_node *parent_node;
 	struct irq_fwspec fwspec;
-	u16 out_irq, p_hwirq;
-	int err = 0;
+	int p_hwirq, err = 0;
+	u16 out_irq;
 
 	out_irq = ti_sci_get_free_resource(intr->out_irqs);
 	if (out_irq == TI_SCI_RESOURCE_NULL)
