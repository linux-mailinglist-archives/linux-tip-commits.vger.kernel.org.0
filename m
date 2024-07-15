Return-Path: <linux-tip-commits+bounces-1704-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCFD19315A6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 15:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C4DF1F220A6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Jul 2024 13:22:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5758018F2D6;
	Mon, 15 Jul 2024 13:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="06KSUMWC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Cfyws/G0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6379E18EA82;
	Mon, 15 Jul 2024 13:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721049645; cv=none; b=BJ8HEwqdMkOg7YPejN+ZBx95pDWfQWseIhf086ZS9ZEL+RG+lj+e4Biqpr89F/3AnbqIkPIZWhDcCN1mplc8CLMZCwkMju7VExHiXf9zZjX5MfacKUNfNj3tQQZX01iS2OrJc4iJg7qKphXEUc5GmTqca+D2WXefiD6RUiTxhpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721049645; c=relaxed/simple;
	bh=qHqR82Pt8gzJ8HdkvGXZYcZB18DqKdtAFVCvXipNghc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VQf2nqH0qA0snWRXGJSsQi9/X4GWUvPL7h5o2azrJM8IY8YWzFrcnc0sSVCvTu5VA6h+AIZg7OJ72/xB7FXs8K9ho+rGIjoXY3ckLU8OuQArkUDs8K9NMpYOhpuvQvtTJgAArTmJi/IT+QiP3Fn7Fdcp8aFAvBmAS3dmRgxvo/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=06KSUMWC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Cfyws/G0; arc=none smtp.client-ip=193.142.43.55
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
	bh=LsXPtY6doh9KW5wQFanbr+8gfkEVpvPYtzoZwhDh814=;
	b=06KSUMWCxmXxvOF+HSJeHx2TG69lKKK7cEWEJbGD+7TDHPALnIairkpzE9xVE1FYUV6lKd
	tTIR4fsB7UxfdZT2E+Fl5+teoHs21RkHGnuVMC5gogfvZLGhcTZN8r3S+hjmWNu4tBE2Km
	Ta5zYUU7y4TcBzXmn7vwGp7JcDSpoimp5j5XwH8flewzx1dYyp/Fb3s0H0KazadgZcx516
	/MuwVOj9bJYfdEkJw9pB0NHkdIDd2AssbZ4lTHtJ4FyiFbFo0sOvRUwwq6oAljcwOqa+74
	L6H1aHvSIdwCBVN/LkaomsmcLWq3sYKpRC3VZiOrrBOUocooe4W9pbJWeujD1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721049639;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LsXPtY6doh9KW5wQFanbr+8gfkEVpvPYtzoZwhDh814=;
	b=Cfyws/G0DKxlSAmYJwHnXQUA51GiVmYDppUL0k+WzI0IexQ9cRVmTge6Svg7vOCAar1Hep
	BD5MinivJS66dmDA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/gic-v4: Substitute vmovp_lock for a per-VM lock
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Nianyao Tang <tangnianyao@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240705093155.871070-3-maz@kernel.org>
References: <20240705093155.871070-3-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172104963922.2215.13164083133636616928.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f0eb154c39471bf881422e8ac23e4c037289ece9
Gitweb:        https://git.kernel.org/tip/f0eb154c39471bf881422e8ac23e4c037289ece9
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Fri, 05 Jul 2024 10:31:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Jul 2024 15:13:55 +02:00

irqchip/gic-v4: Substitute vmovp_lock for a per-VM lock

vmovp_lock is abused in a number of cases to serialise updates
to vlpi_count[] and deal with map/unmap of a VM to ITSs.

Instead, provide a per-VM lock and revisit the use of vlpi_count[]
so that it is always wrapped in this per-VM vmapp_lock.

This reduces the potential contention on a concurrent VMOVP command,
and paves the way for subsequent VPE locking that holding vmovp_lock
actively prevents due to the lock ordering.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Nianyao Tang <tangnianyao@huawei.com>
Link: https://lore.kernel.org/r/20240705093155.871070-3-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its.c   | 27 ++++++++++++---------------
 include/linux/irqchip/arm-gic-v4.h |  8 ++++++++
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 387ac5a..215c7ab 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1317,7 +1317,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 {
 	struct its_cmd_desc desc = {};
 	struct its_node *its;
-	unsigned long flags;
 	int col_id = vpe->col_idx;
 
 	desc.its_vmovp_cmd.vpe = vpe;
@@ -1330,6 +1329,12 @@ static void its_send_vmovp(struct its_vpe *vpe)
 	}
 
 	/*
+	 * Protect against concurrent updates of the mapping state on
+	 * individual VMs.
+	 */
+	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
+
+	/*
 	 * Yet another marvel of the architecture. If using the
 	 * its_list "feature", we need to make sure that all ITSs
 	 * receive all VMOVP commands in the same order. The only way
@@ -1337,8 +1342,7 @@ static void its_send_vmovp(struct its_vpe *vpe)
 	 *
 	 * Wall <-- Head.
 	 */
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
-
+	guard(raw_spinlock)(&vmovp_lock);
 	desc.its_vmovp_cmd.seq_num = vmovp_seq_num++;
 	desc.its_vmovp_cmd.its_list = get_its_list(vpe->its_vm);
 
@@ -1353,8 +1357,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 		desc.its_vmovp_cmd.col = &its->collections[col_id];
 		its_send_single_vcommand(its, its_build_vmovp_cmd, &desc);
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
 
 static void its_send_vinvall(struct its_node *its, struct its_vpe *vpe)
@@ -1791,12 +1793,10 @@ static bool gic_requires_eager_mapping(void)
 
 static void its_map_vm(struct its_node *its, struct its_vm *vm)
 {
-	unsigned long flags;
-
 	if (gic_requires_eager_mapping())
 		return;
 
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
+	guard(raw_spinlock_irqsave)(&vm->vmapp_lock);
 
 	/*
 	 * If the VM wasn't mapped yet, iterate over the vpes and get
@@ -1814,19 +1814,15 @@ static void its_map_vm(struct its_node *its, struct its_vm *vm)
 			its_send_vinvall(its, vpe);
 		}
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
 
 static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
 {
-	unsigned long flags;
-
 	/* Not using the ITS list? Everything is always mapped. */
 	if (gic_requires_eager_mapping())
 		return;
 
-	raw_spin_lock_irqsave(&vmovp_lock, flags);
+	guard(raw_spinlock_irqsave)(&vm->vmapp_lock);
 
 	if (!--vm->vlpi_count[its->list_nr]) {
 		int i;
@@ -1834,8 +1830,6 @@ static void its_unmap_vm(struct its_node *its, struct its_vm *vm)
 		for (i = 0; i < vm->nr_vpes; i++)
 			its_send_vmapp(its, vm->vpes[i], false);
 	}
-
-	raw_spin_unlock_irqrestore(&vmovp_lock, flags);
 }
 
 static int its_vlpi_map(struct irq_data *d, struct its_cmd_info *info)
@@ -3942,6 +3936,8 @@ static void its_vpe_invall(struct its_vpe *vpe)
 {
 	struct its_node *its;
 
+	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
+
 	list_for_each_entry(its, &its_nodes, entry) {
 		if (!is_v4(its))
 			continue;
@@ -4547,6 +4543,7 @@ static int its_vpe_irq_domain_alloc(struct irq_domain *domain, unsigned int virq
 	vm->db_lpi_base = base;
 	vm->nr_db_lpis = nr_ids;
 	vm->vprop_page = vprop_page;
+	raw_spin_lock_init(&vm->vmapp_lock);
 
 	if (gic_rdists->has_rvpeid)
 		irqchip = &its_vpe_4_1_irq_chip;
diff --git a/include/linux/irqchip/arm-gic-v4.h b/include/linux/irqchip/arm-gic-v4.h
index 2c63375..ecabed6 100644
--- a/include/linux/irqchip/arm-gic-v4.h
+++ b/include/linux/irqchip/arm-gic-v4.h
@@ -25,6 +25,14 @@ struct its_vm {
 	irq_hw_number_t		db_lpi_base;
 	unsigned long		*db_bitmap;
 	int			nr_db_lpis;
+	/*
+	 * Ensures mutual exclusion between updates to vlpi_count[]
+	 * and map/unmap when using the ITSList mechanism.
+	 *
+	 * The lock order for any sequence involving the ITSList is
+	 * vmapp_lock -> vpe_lock ->vmovp_lock.
+	 */
+	raw_spinlock_t		vmapp_lock;
 	u32			vlpi_count[GICv4_ITS_LIST_MAX];
 };
 

