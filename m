Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99BBD1564E5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Feb 2020 15:58:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727562AbgBHO6M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 8 Feb 2020 09:58:12 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:42055 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727509AbgBHO6L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 8 Feb 2020 09:58:11 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1j0RYb-0003Ak-0Q; Sat, 08 Feb 2020 15:58:05 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AA6841C1F88;
        Sat,  8 Feb 2020 15:58:04 +0100 (CET)
Date:   Sat, 08 Feb 2020 14:58:04 -0000
From:   "tip-bot2 for Zenghui Yu" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/gic-v4.1: Drop 'tmp' in
 inherit_vpe_l1_table_from_rd()
Cc:     Zenghui Yu <yuzenghui@huawei.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200206075711.1275-5-yuzenghui@huawei.com>
References: <20200206075711.1275-5-yuzenghui@huawei.com>
MIME-Version: 1.0
Message-ID: <158117388446.411.15070311927912948896.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     4bccf1d715fe8f5fe10bd6202c8caa0ae6104cd2
Gitweb:        https://git.kernel.org/tip/4bccf1d715fe8f5fe10bd6202c8caa0ae6104cd2
Author:        Zenghui Yu <yuzenghui@huawei.com>
AuthorDate:    Thu, 06 Feb 2020 15:57:09 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 08 Feb 2020 10:01:33 

irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()

The variable 'tmp' in inherit_vpe_l1_table_from_rd() is actually
not needed, drop it.

Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200206075711.1275-5-yuzenghui@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index ae4e7b3..8405ebd 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2415,14 +2415,12 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 
 	for_each_possible_cpu(cpu) {
 		void __iomem *base = gic_data_rdist_cpu(cpu)->rd_base;
-		u32 tmp;
 
 		if (!base || cpu == smp_processor_id())
 			continue;
 
 		val = gic_read_typer(base + GICR_TYPER);
-		tmp = compute_common_aff(val);
-		if (tmp != aff)
+		if (aff != compute_common_aff(val))
 			continue;
 
 		/*
