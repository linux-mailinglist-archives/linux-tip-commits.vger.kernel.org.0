Return-Path: <linux-tip-commits+bounces-2082-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 59D4A958AAD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 17:05:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6125B2494A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Aug 2024 15:04:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C12917753;
	Tue, 20 Aug 2024 15:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Owz2vAyv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DykgZ1iU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833261917D6;
	Tue, 20 Aug 2024 15:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724166209; cv=none; b=PG87n/HrNQb0i3tKN0GeZ1fXwBtx11gVZ+CemMnW3z9VA3dGvdoj9ny0GdkUBKg0enDFwMEvjPcZ0QDOQ1m8WQV9IvocAXgp/tezU9rSFf0KlHBFBxC3h5+ZJ6x6Q8Vm05aTI9i6l8V3XUoFupf+gBaBWHHkXjHTJtOcFxnd+mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724166209; c=relaxed/simple;
	bh=SvKPJLsSh8SLNpciqP8cfM3T3jud1Wtkeh76PkKKV9k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jaS+GtFhiFijzXPmSewmJKVbMy9tXCgbpWGcirx3+69O7e3bLPIw7MGP+vFYLdwb+RHJj67DXyyEiXRGuGYBSjO2w3hssQp0VpDKYfMBFSR9hxxV6RkKPid91f9vIWb/7OUyKhTPDbcwnIAetz7Fcb2RtlRUWu+1PIV2H69XlTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Owz2vAyv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DykgZ1iU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 20 Aug 2024 15:03:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1724166203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhAQ+33ISkReijvwpXRSiczamuSS/S9mmVUuFg13Ca0=;
	b=Owz2vAyvnfV7TTmFPbSaKKOzYeHOAHls31uc78uxZ6e9Ri4hiXFfVSR+Q7d0IEClMaSbF0
	5RQwMXrEEz6VapjfjvYMrSCiGEnscwAiZxEodbBKqAhhYuW6vCPkDAlra4+n/xOdJEtQ3Q
	hdQ4xLecfz+S7Fyl0ZkHjwpUaMZbSYKMk9Y1AQB2MwTS3sdFd17h/3G7O8VZLOkVouKnZn
	PjxUOt/dymGF5XxyX586z5oNPTLtKslDr21LivSA7qwfdu8W9nnB2xdUkvVdpPhorNn8jZ
	DWhGRKFEf3k4kGK7tm33Q6Yl1usFhDdEPUAX5bsr/MswMahTLCr+BTKXKMX/MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1724166203;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LhAQ+33ISkReijvwpXRSiczamuSS/S9mmVUuFg13Ca0=;
	b=DykgZ1iUyHIipO5jVrHmG1TIkkJ0SPy2vuqk+04RNfPiSwTM6WmyIm/vrCwC3ZETbdff2e
	QrKVI42rYb2e0gAQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/gic-v4: Fix ordering between vmapp and vpe locks
Cc: Zhou Wang <wangzhou1@hisilicon.com>, Marc Zyngier <maz@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240818171625.3030584-1-maz@kernel.org>
References: <20240818171625.3030584-1-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172416620321.2215.13811930689456787433.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f97fd458763a4801d04dbb4a79d9ca6282d293ec
Gitweb:        https://git.kernel.org/tip/f97fd458763a4801d04dbb4a79d9ca6282d293ec
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 18 Aug 2024 18:16:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2024 16:57:13 +02:00

irqchip/gic-v4: Fix ordering between vmapp and vpe locks

The recently established lock ordering mandates that the per-VM
vmapp_lock is acquired before taking the per-VPE lock.

As it turns out, its_vpe_set_affinity() takes the VPE lock, and
then calls into its_send_vmovp(), which itself takes the vmapp
lock. Obviously, this is a lock order violation.

As its_send_vmovp() is only called from its_vpe_set_affinity(),
hoist the vmapp locking from the former into the latter, restoring
the expected order.

Fixes: f0eb154c39471 ("irqchip/gic-v4: Substitute vmovp_lock for a per-VM lock")
Reported-by: Zhou Wang <wangzhou1@hisilicon.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240818171625.3030584-1-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3-its.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 9b34596..fdec478 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -1330,12 +1330,6 @@ static void its_send_vmovp(struct its_vpe *vpe)
 	}
 
 	/*
-	 * Protect against concurrent updates of the mapping state on
-	 * individual VMs.
-	 */
-	guard(raw_spinlock_irqsave)(&vpe->its_vm->vmapp_lock);
-
-	/*
 	 * Yet another marvel of the architecture. If using the
 	 * its_list "feature", we need to make sure that all ITSs
 	 * receive all VMOVP commands in the same order. The only way
@@ -3824,7 +3818,14 @@ static int its_vpe_set_affinity(struct irq_data *d,
 	 * protect us, and that we must ensure nobody samples vpe->col_idx
 	 * during the update, hence the lock below which must also be
 	 * taken on any vLPI handling path that evaluates vpe->col_idx.
+	 *
+	 * Finally, we must protect ourselves against concurrent updates of
+	 * the mapping state on this VM should the ITS list be in use (see
+	 * the shortcut in its_send_vmovp() otherewise).
 	 */
+	if (its_list_map)
+		raw_spin_lock(&vpe->its_vm->vmapp_lock);
+
 	from = vpe_to_cpuid_lock(vpe, &flags);
 	table_mask = gic_data_rdist_cpu(from)->vpe_table_mask;
 
@@ -3854,6 +3855,9 @@ out:
 	irq_data_update_effective_affinity(d, cpumask_of(cpu));
 	vpe_to_cpuid_unlock(vpe, flags);
 
+	if (its_list_map)
+		raw_spin_unlock(&vpe->its_vm->vmapp_lock);
+
 	return IRQ_SET_MASK_OK_DONE;
 }
 

