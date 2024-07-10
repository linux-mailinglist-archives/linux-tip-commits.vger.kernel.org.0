Return-Path: <linux-tip-commits+bounces-1673-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E692A92D6C2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:43:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9B3521F25079
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 171A0194AFE;
	Wed, 10 Jul 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IK8yMSqL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2CCYMK2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8393236;
	Wed, 10 Jul 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720629773; cv=none; b=PplTXj6ukBttbgRNlLlo03PrAUfnazS+z8pdclSKHGMGFYLC/LjyteNvL8yb0/xu4iVXK0Asb1VwKE3pyr8XTntW8VyGtQyBhjJGseJOKFlmc5RJsSHbLBXPNeXmqXXG0fdsOF3RhxDwbR4oyiU9Iz2dapOo4EOkxN3ZFC19Ces=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720629773; c=relaxed/simple;
	bh=QNqNT9hCY7isvL1GMlA4WDct8r18fjRGXrrEQtyJTyo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TCOpax6ys5hv8waAwr2moD+BWx5xAlhbi8mUooT3rsbrB40AiZSV+U6CNTufOj4FM5HGkujZiozAjJU6TKoVTkjJPBOMgRiuQf5z1iuPPjkeBXY1oTncQKgbXAQf77fqfUrL4LZtKv61zOwVzAUJnYJJDuic3IGQ+EZT6tYWSYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IK8yMSqL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2CCYMK2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:42:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720629769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XrHg5vmtutLvbviNrFaMTdQqHltkn2UY/QBa9yJQPQ=;
	b=IK8yMSqLJIzb5k+bko2uSSfzUzqTgM1JLhpXv/C6JbkJ/RLgHuUqgCGY5kjfWZMgbEkIFA
	guRFe1zDVUV/3/uRcPbK4Ws3GxGseD9Zybl40+6fi4VnT9n9s1wG/pjztzFaFrgXv9ukl5
	CVJzsJoK+MjsxZmPqnxOlW56GUGyhPFYklUKnh/8qxxifFV0Z+pm9YHtzHjBm2Dl/p2sIf
	g7W5JBnHkJxv4yfITt2YEE94uwrHS0zQ+t5w8UegH+JULruHa80TLPO3qvSlhYTUmMwTbP
	68k7aDJF3PqNiT2mwRc3PSrV5Wzvofpu4LajMyVwD5A2/Kf1qjTtcVpU9OFORw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720629769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/XrHg5vmtutLvbviNrFaMTdQqHltkn2UY/QBa9yJQPQ=;
	b=L2CCYMK2Dl65bcF7wzAxpm3i3YLDQ8ntgHiK17ZZepnMwKLu7BNngiexxPxOF0decBhYtT
	26nSRtAV1hBuucBw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/gic-v4: Always configure affinity on VPE activation
Cc: Nianyao Tang <tangnianyao@huawei.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240705093155.871070-2-maz@kernel.org>
References: <20240705093155.871070-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062976916.2215.5685048299012070437.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5ad2e910aeae9d2eaad61c8ae3adf7c721ac32e4
Gitweb:        https://git.kernel.org/tip/5ad2e910aeae9d2eaad61c8ae3adf7c721ac32e4
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 05 Jul 2024 10:31:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:40:09 +02:00

irqchip/gic-v4: Always configure affinity on VPE activation

There are currently two paths to set the initial affinity of a VPE:

 - at activation time on GICv4 without the stupid VMOVP list, and
   on GICv4.1

 - at map time for GICv4 with VMOVP list

The latter location may end-up modifying the affinity of VPE that is
currently running, making the results unpredictible.

Instead, unify the two paths, making sure to set the initial affinity only
at activation time.

Reported-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nianyao Tang <tangnianyao@huawei.com>
Link: https://lore.kernel.org/r/20240705093155.871070-2-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 047e566..8d31e4a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1810,13 +1810,9 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
 
 		for (i = 0; i < vm->nr_vpes; i++) {
 			struct its_vpe *vpe = vm->vpes[i];
-			struct irq_data *d = irq_get_irq_data(vpe->irq);
 
-			/* Map the VPE to the first possible CPU */
-			vpe->col_idx = cpumask_first(cpu_online_mask);
 			its_send_vmapp(its, vpe, true);
 			its_send_vinvall(its, vpe);
-			irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
 		}
 	}
 
@@ -4584,6 +4580,10 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	struct its_node *its;
 
+	/* Map the VPE to the first possible CPU */
+	vpe->col_idx = cpumask_first(cpu_online_mask);
+	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
+
 	/*
 	 * If we use the list map, we issue VMAPP on demand... Unless
 	 * we're on a GICv4.1 and we eagerly map the VPE on all ITSs
@@ -4592,9 +4592,6 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	if (!gic_requires_eager_mapping())
 		return 0;
 
-	/* Map the VPE to the first possible CPU */
-	vpe->col_idx = cpumask_first(cpu_online_mask);
-
 	list_for_each_entry(its, &its_nodes, entry) {
 		if (!is_v4(its))
 			continue;
@@ -4603,8 +4600,6 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 		its_send_vinvall(its, vpe);
 	}
 
-	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
-
 	return 0;
 }
 

