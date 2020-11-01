Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E697E2A1FBB
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgKARAQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53868 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbgKARAP (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:15 -0500
Date:   Sun, 01 Nov 2020 17:00:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kE4pz8+KsqAvmoVbl3lvfqF7l3tj8mcDsBEUnU88r0w=;
        b=RcEzwyRM0u2YNSA6aqOS87vdoUs0C5WC4SZd+3ekAXHM1E27Awm9JnOBz2/N33r3sH//bv
        WUaISZCcivI3eOT3/ETdG/AdbEV4HDKqeAd74oa6uHFV2WE0on38Fv7NC+mNz9GU8gSGAe
        l8v65EgQG6eh5u6sffir/BOyX7lppTdFPfUE9qfzW2xuXlUsvjitdONUTCiKsAZLRW3OXB
        IerktvJ6i3xuePYoCWezmldeahgiFdB6DeeVPEa7N9EqYQm3+Var/mnYy5oFJ92ERDaHLe
        OmVSx80wgfNwhfKmiG4qVL9rfch7D+RPWNq9GnMPDfSYH76x99vDV4llETqSnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kE4pz8+KsqAvmoVbl3lvfqF7l3tj8mcDsBEUnU88r0w=;
        b=OPrbg5JrCysv/KQ5QbzYHyy/DPxu845VqlR6zqnVuBbSwmd9ECo4c8Ac5gigZ/XOCRl5FB
        rVJYd0zguKe7lXDA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/mst: Make mst_intc_of_init static
Cc:     kernel test robot <lkp@intel.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160425001213.397.5589851492691203153.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     893a7cfb6b0bea650fafa43838d7f7f8f0f076bc
Gitweb:        https://git.kernel.org/tip/893a7cfb6b0bea650fafa43838d7f7f8f0f076bc
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 15 Oct 2020 22:26:26 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 15 Oct 2020 22:32:31 +01:00

irqchip/mst: Make mst_intc_of_init static

mst_intc_of_init has no external caller, so let's make it static.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-mst-intc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-mst-intc.c b/drivers/irqchip/irq-mst-intc.c
index 4be0775..143657b 100644
--- a/drivers/irqchip/irq-mst-intc.c
+++ b/drivers/irqchip/irq-mst-intc.c
@@ -154,8 +154,8 @@ static const struct irq_domain_ops mst_intc_domain_ops = {
 	.free		= irq_domain_free_irqs_common,
 };
 
-int __init
-mst_intc_of_init(struct device_node *dn, struct device_node *parent)
+static int __init mst_intc_of_init(struct device_node *dn,
+				   struct device_node *parent)
 {
 	struct irq_domain *domain, *domain_parent;
 	struct mst_intc_chip_data *cd;
