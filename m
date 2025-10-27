Return-Path: <linux-tip-commits+bounces-7003-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 062FCC0F59A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC210463872
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47224313522;
	Mon, 27 Oct 2025 16:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GT2M9acb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4jgOTaJ2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CFA312819;
	Mon, 27 Oct 2025 16:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582658; cv=none; b=gn3dTjhe1+3hFAcaqiF3XMwUdynQhJvPjoHfhG4zyh8Pmp8MLnp6J5+DgzcUDNSOVpQeglkIH8xGtjtGkZPjtVtYOmZD/biWCDKsVhXblzwNlyXv9BLbpff8uqYcsLbRZZkvuS5950Y/wMb+4MBt4LGb7xxrzuVV/WuT1XrQYro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582658; c=relaxed/simple;
	bh=Mi2IQ7I+tqD9e3nmjgYntHsdU654kQYA+4qcVMdvEzg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RujF9muPoDL3J806/YSvKweR08K/gxouLxvXs02WB1whaDGmAIYEMSZYTIfgbRyNf/yAlViwYO3uoRL3azTSghYan/YDnPDk925Bo40s9OrzX7UFGuB/ktxQXqFU6cEllM0ohyq4BbEW1NeCXTlkWPM6gQoAPX8ZvFP+NBtteus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GT2M9acb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4jgOTaJ2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx52hvNIQa2Zcpm3BzQoEFqx7WCyHqmZ5BI0mf4uHXM=;
	b=GT2M9acbfnGY88ZpnwIqR370PNz8BuUKlX+WTpYd2/oS1FLOii9a1QVb+AF560saUxoz+Q
	a9/VeP+0O4mP9FNmLkBDED303/arvj432t/Xlw5/EYjFk/dRgiHpX69Ov33sx19UYAKBqL
	A6wnlHmoivLpMrcPeowJuqDj9C2/yO0IXZrQZsTrYwLfDcHfutTkhjw1yc6JVCHGKNyDN6
	/dzNbdTiR9RYrkC1Kg4gtkPXjmEK7adXOW5RH00ThVypP+Xc6m27usQx9LEnba0vTm2MqL
	U1bXoznut5qbW2IaSYWdjb848xDX5eCsDg+zMhnBM/4oV+QESfWHe+mIiOsY/w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582655;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lx52hvNIQa2Zcpm3BzQoEFqx7WCyHqmZ5BI0mf4uHXM=;
	b=4jgOTaJ2617VPiHGbX6mkLKbXxoXFnEby1lwWRxly/SiJs6FwD4bkeK2HufIQEp5ZJohJo
	u/swWknv9jeqlYCw==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Kill irq_{g,s}et_percpu_devid_partition()
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-25-maz@kernel.org>
References: <20251020122944.3074811-25-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265388.2601451.6543902782462338565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ee2d50a9f524ae829d1a8ec296d7a0170e7b8ade
Gitweb:        https://git.kernel.org/tip/ee2d50a9f524ae829d1a8ec296d7a0170e7=
b8ade
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:37 +01:00

genirq: Kill irq_{g,s}et_percpu_devid_partition()

These two helpers do not have any user anymore, and can be removed,
together with the affinity field kept in the irqdesc structure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-25-maz@kernel.org
---
 include/linux/irq.h     |  4 ----
 include/linux/irqdesc.h |  1 -
 kernel/irq/irqdesc.c    | 24 +-----------------------
 3 files changed, 1 insertion(+), 28 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index b728c18..4a9f1d7 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -718,10 +718,6 @@ static inline void irq_set_chip_and_handler(unsigned int=
 irq,
 }
=20
 extern int irq_set_percpu_devid(unsigned int irq);
-extern int irq_set_percpu_devid_partition(unsigned int irq,
-					  const struct cpumask *affinity);
-extern int irq_get_percpu_devid_partition(unsigned int irq,
-					  struct cpumask *affinity);
=20
 extern void
 __irq_set_handler(unsigned int irq, irq_flow_handler_t handle, int is_chaine=
d,
diff --git a/include/linux/irqdesc.h b/include/linux/irqdesc.h
index fd091c3..37e0b5b 100644
--- a/include/linux/irqdesc.h
+++ b/include/linux/irqdesc.h
@@ -82,7 +82,6 @@ struct irq_desc {
 	int			threads_handled_last;
 	raw_spinlock_t		lock;
 	struct cpumask		*percpu_enabled;
-	const struct cpumask	*percpu_affinity;
 #ifdef CONFIG_SMP
 	const struct cpumask	*affinity_hint;
 	struct irq_affinity_notify *affinity_notify;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index db714d3..6acf268 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -879,8 +879,7 @@ void __irq_put_desc_unlock(struct irq_desc *desc, unsigne=
d long flags, bool bus)
 		chip_bus_sync_unlock(desc);
 }
=20
-int irq_set_percpu_devid_partition(unsigned int irq,
-				   const struct cpumask *affinity)
+int irq_set_percpu_devid(unsigned int irq)
 {
 	struct irq_desc *desc =3D irq_to_desc(irq);
=20
@@ -892,31 +891,10 @@ int irq_set_percpu_devid_partition(unsigned int irq,
 	if (!desc->percpu_enabled)
 		return -ENOMEM;
=20
-	desc->percpu_affinity =3D affinity ? : cpu_possible_mask;
-
 	irq_set_percpu_devid_flags(irq);
 	return 0;
 }
=20
-int irq_set_percpu_devid(unsigned int irq)
-{
-	return irq_set_percpu_devid_partition(irq, NULL);
-}
-
-int irq_get_percpu_devid_partition(unsigned int irq, struct cpumask *affinit=
y)
-{
-	struct irq_desc *desc =3D irq_to_desc(irq);
-
-	if (!desc || !desc->percpu_enabled)
-		return -EINVAL;
-
-	if (affinity)
-		cpumask_copy(affinity, desc->percpu_affinity);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(irq_get_percpu_devid_partition);
-
 void kstat_incr_irq_this_cpu(unsigned int irq)
 {
 	kstat_incr_irqs_this_cpu(irq_to_desc(irq));

