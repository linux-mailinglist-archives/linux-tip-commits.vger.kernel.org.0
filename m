Return-Path: <linux-tip-commits+bounces-5545-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E080AB895C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 16:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2A0E4E1023
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 May 2025 14:24:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E1E1C7013;
	Thu, 15 May 2025 14:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iCeLAdUm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o6kxXhIi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 341341DDE9;
	Thu, 15 May 2025 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747319095; cv=none; b=KlLq0WvBFjcE9Yo54S9RvoFbtlurhyUd/TV7Iyqc57xO4sZEGo4W1IXDA2JLq3f39/C8OuXnppR8Kf0yGGK+qfYet3TetA5dclttCGrPaPHGO7zpvzlj/V4yUnxhCl1b1+XGjEiAlLP+G47ra03b+mbhVF+ju+fxwLtwp8RKvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747319095; c=relaxed/simple;
	bh=nugiOVkU9q7pmMOHqrMucKXr7l28Ja+0TeX764IHk2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QIvrw+dbAJ8PonxyV1PYi3k4ZUmZyFCXA2fE0+TrzBza89rruhFu+Sf6IRVft45vaFFZMoq04XnNNsVnhdnDeyGZ2KOa9UISqCyT+KU8Xq37yupm6nP8o9jDqFG05ufmr81hXzzqQCtKQvdsuzMsoVdHP1V43B7CFaK6WpEuGDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iCeLAdUm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o6kxXhIi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 May 2025 14:24:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747319091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTcd3ggXOqjDZA4BHfMHZIhuYZm2KO68V+YyTiS7o70=;
	b=iCeLAdUmAz83/JPOpQ+35xog2r+ZPocqYuiQq1N6fJGJMGzkZ/pPwx3jvheXLEZWqfnkLv
	N8XuFCZajLcl+FIUd822tNPp1Xv3/eJU0byVno99aRkGd8qwrWWLzubri3r29f92WdChm2
	qnwcwSqn1RH5SMqkPq28pWDSLF9i+lvlOyWFHMdqeO82it+Re4m5gyzGMOZgbyxhE3pf7T
	jX01nyK4RPWEehPPi5b9dkDsBXsS0coxcmOzUXt6qUfCccaaIxaA2WOAbsiGFjjuAcOd1r
	DiC6l4eKrZvOyZnW3qb4J5rVl+7riqpUSADypdRHwuIiUxsv9sfUEuVln6Rldw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747319091;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KTcd3ggXOqjDZA4BHfMHZIhuYZm2KO68V+YyTiS7o70=;
	b=o6kxXhIi4I0kS6yxyUBMZdI71FiQXOb4d7s97LuOrOVxbSxWxsyOcaGqIK9ZY/7yIWAqqu
	jjuBAOBQ4eXXXwCg==
From: "tip-bot2 for Nianyao Tang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/gic-v4.1: Use local 4_1 ITS to generate VSGI
Cc: Marc Zyngier <maz@kernel.org>, Nianyao Tang <tangnianyao@huawei.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250515145359.2795959-1-tangnianyao@huawei.com>
References: <20250515145359.2795959-1-tangnianyao@huawei.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174731908989.406.16619601921771846708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f1a3fac4095c7bc0b30e2aa9921c232af8faeae0
Gitweb:        https://git.kernel.org/tip/f1a3fac4095c7bc0b30e2aa9921c232af8faeae0
Author:        Nianyao Tang <tangnianyao@huawei.com>
AuthorDate:    Thu, 15 May 2025 14:53:59 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 May 2025 16:19:22 +02:00

irqchip/gic-v4.1: Use local 4_1 ITS to generate VSGI

On multi-node GICv4.1 system, VSGI senders always use one certain 4_1 ITS,
because find_4_1_its() returns the first its_node in the list, regardless of
which node the VSGI sender is on. This brings guest VSGI performance drop
when VM is not running on the same node as this returned ITS.

On a 2-socket environment, each with one ITS and 32 cpu, GICv4.1 enabled,
4U8G guest, 4 vcpu is running on same socket.

  When the VM is on socket0, kvm-unit-tests ipi_hw result is 850ns.
  When the VM is on socket1, it is 750ns.

The reason is that the VSGI sender always uses the last reported ITS (that
on socket1) to inject VSGI. The access from a CPU to a other-socket ITS
will cost 100ns more compared to an access to the local ITS.

Using the local ITS results in a 12% reduction in IPI latency.

Modify find_4_1_its() to return the first per-CPU local_4_1_its, which is
initialized when the VPE table is inherited from the ITS or from another
CPU.  If it fails to find a local 4_1 ITS, it returns any 4_1 ITS like
before.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Nianyao Tang <tangnianyao@huawei.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/all/20250515145359.2795959-1-tangnianyao@huawei.com
---
 drivers/irqchip/irq-gic-v3-its.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 0115ad6..81a44ce 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -125,6 +125,8 @@ struct its_node {
 	int			vlpi_redist_offset;
 };
 
+static DEFINE_PER_CPU(struct its_node *, local_4_1_its);
+
 #define is_v4(its)		(!!((its)->typer & GITS_TYPER_VLPIS))
 #define is_v4_1(its)		(!!((its)->typer & GITS_TYPER_VMAPP))
 #define device_ids(its)		(FIELD_GET(GITS_TYPER_DEVBITS, (its)->typer) + 1)
@@ -2778,6 +2780,7 @@ static u64 inherit_vpe_l1_table_from_its(void)
 		}
 		val |= FIELD_PREP(GICR_VPROPBASER_4_1_SIZE, GITS_BASER_NR_PAGES(baser) - 1);
 
+		*this_cpu_ptr(&local_4_1_its) = its;
 		return val;
 	}
 
@@ -2815,6 +2818,7 @@ static u64 inherit_vpe_l1_table_from_rd(cpumask_t **mask)
 		gic_data_rdist()->vpe_l1_base = gic_data_rdist_cpu(cpu)->vpe_l1_base;
 		*mask = gic_data_rdist_cpu(cpu)->vpe_table_mask;
 
+		*this_cpu_ptr(&local_4_1_its) = *per_cpu_ptr(&local_4_1_its, cpu);
 		return val;
 	}
 
@@ -4180,7 +4184,7 @@ static struct irq_chip its_vpe_irq_chip = {
 
 static struct its_node *find_4_1_its(void)
 {
-	static struct its_node *its = NULL;
+	struct its_node *its = *this_cpu_ptr(&local_4_1_its);
 
 	if (!its) {
 		list_for_each_entry(its, &its_nodes, entry) {

