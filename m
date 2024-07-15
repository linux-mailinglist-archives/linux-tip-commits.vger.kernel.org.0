Return-Path: <linux-tip-commits+bounces-1703-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33F6B9315A5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 15:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2C24280BFE
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 13:22:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3707218F2CE;
	Mon, 15 Jul 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CW13fKi7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iMG+trpp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82418EA89;
	Mon, 15 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049645; cv=none; b=d8yjLqq8bRitYH7mtnVJOXQZammNDzS4yNTH6AkIMjjgZdUCuO0ifSFE+zhbOTpk7sYdiMElnfSFz1WkLLZxl8bK31I82Sl3EBW51GsJnjmErxt6n1vW7K96P8LFPiAzPFnuVBO21syx6R6aU3kmNBbAqd4VGV5XImaj2uRPxZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049645; c=relaxed/simple;
	bh=Juzd7U15omI1y1GQuqH+2Y9eOfSuxCABoSbuUkDIHwQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BRoHNTgBPt8cf1EYxqQYZGzTFogZ4s2TrpMk7p3LWlD030B8e53Ww80fdWDxmtc4R8TPfcwFijX4sjoBp12OC6xq11PgYDRZuvTtcAXgaEcM/s2a3MLGe4yrsJfOP/zb/jcks7y4GJHgBVJeq2tkZ3CG8Ol++xqOW+NQUwBILe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CW13fKi7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iMG+trpp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Jul 2024 13:20:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721049639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3fCGzW1mJCNbJNHQNXtfiAXFkWp0WCKWD/N9RJlVeg=;
	b=CW13fKi7rfdwP7ZLNEVvvNG52Krh/Zy/Rmhvl5Ii7F+D1g5H1Kz0be2q8GQenFEbtY75bn
	C74PuyXjqx7SYVMHcHoxfPGU126Lz2Z4FPyprsVv6Pn9qbZNiF2gxA+vExQIaKiFXjkK38
	0RGe2hSi1NnEDVgGmqOaOgj1shHg5nXN5e5C/iUywNVum3HDI5kIoNbiuTpn4w+P821kG+
	nBJObZ4l6V8YhITSEQa/ExfN32sNPk2XgjrvT39KjiBY3QdFgEg/bwdT0XZYg5OZovGpHl
	iclk0i3cLuapep3ieg/o/6JZfFiPRRgc/gXJJgCfCaCU3/lDQDcc12FgcQkdKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T3fCGzW1mJCNbJNHQNXtfiAXFkWp0WCKWD/N9RJlVeg=;
	b=iMG+trppHdoY+9WWDn6WaO6JFAwuKDjlpMLVnmsg1kvHaNBAQbePiOVSfyCoP4s2utsWM6
	tsM9k2FcnkjE4TAQ==
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
Message-ID: <172104963949.2215.3384096776536486261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7d2c2048a86477461f7bc75d064579ed349472bc
Gitweb:        https://git.kernel.org/tip/7d2c2048a86477461f7bc75d064579ed349472bc
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 05 Jul 2024 10:31:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:55 +02:00

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
index af5297e..387ac5a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1809,13 +1809,9 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
 
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
 
@@ -4582,6 +4578,10 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	struct its_vpe *vpe = irq_data_get_irq_chip_data(d);
 	struct its_node *its;
 
+	/* Map the VPE to the first possible CPU */
+	vpe->col_idx = cpumask_first(cpu_online_mask);
+	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
+
 	/*
 	 * If we use the list map, we issue VMAPP on demand... Unless
 	 * we're on a GICv4.1 and we eagerly map the VPE on all ITSs
@@ -4590,9 +4590,6 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 	if (!gic_requires_eager_mapping())
 		return 0;
 
-	/* Map the VPE to the first possible CPU */
-	vpe->col_idx = cpumask_first(cpu_online_mask);
-
 	list_for_each_entry(its, &its_nodes, entry) {
 		if (!is_v4(its))
 			continue;
@@ -4601,8 +4598,6 @@ static int its_vpe_irq_domain_activate(struct irq_domain *domain,
 		its_send_vinvall(its, vpe);
 	}
 
-	irq_data_update_effective_affinity(d, cpumask_of(vpe->col_idx));
-
 	return 0;
 }
 

