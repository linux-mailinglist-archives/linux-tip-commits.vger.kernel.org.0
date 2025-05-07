Return-Path: <linux-tip-commits+bounces-5409-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F951AADB06
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:14:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8D237B2C1F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8103D25179F;
	Wed,  7 May 2025 09:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cHt0HGHn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s9ay7RVG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 029D124BCEA;
	Wed,  7 May 2025 09:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608870; cv=none; b=OCkb6qqCb0x3JMPVMEs7ZjA0T5/VYQpnGT5q6SUu9bC6coE7Pm8OgAetjoiVk4y7Y0dbxsSGDFU495zsCR2WeUBLrR8XUTATcnf8gDdq+b5Qkf+TgAvGAxP4FAHYzwTIooAVayA2VSDHlM4MSP+rRuSdFxGZm5oHzyN3DLP97QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608870; c=relaxed/simple;
	bh=9mbMpiOqTGAMfouuLbdGlvFnaQVdOLN924bn/Ago4Wg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C8XQdtTVFxrAVV3GVO9vkh+QlWFVr36TT+/3UfPSx7a0UoBgk4K5cPgoYkcl89CCMhKFnuLLSYcxGlxHiDK/mhz2nYaZ7KPZnQM5VZObX9kAWlQLIWxGXoVTedpmHJN2QJPKwM61DehamZ2SZ7p77uSV1xMVa3NRR6lALhixZNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cHt0HGHn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s9ay7RVG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7IHuXO3I35yYSaFLLBd3g8nSPAFJKoJxTI4IyY+dzI=;
	b=cHt0HGHncLqMMCSQ9TsGcdlGdaJtJp3hgN2EejF0a6At3bNqamstZwEdMtkZHYwcgdN1zC
	LkLOAUIPjt5bGwdXQrbuI+9ORPKuznBVZbwhdQr+YP5VHxWGEMAuRQgcfSIEbqBJhtu4Y2
	gmPM4AYWNn9ygAg8JYcir4fMGjN9wCtORu7KEXoR4EODHiS2gYlPKZWm2O45ZFevK+QzGt
	Zq2YX4t9J4aFtPrlGZWvv6nZDEGLtVm+nj91BroHW4IdM//RScrW4XZGqXPZ/dKjZTk2Nj
	/zCVz2lBSMN7ECUfh3xJC3hsusnJ+jQWldqrCto0IW7uW4w1d7OBCHZq0Hr4zg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608866;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N7IHuXO3I35yYSaFLLBd3g8nSPAFJKoJxTI4IyY+dzI=;
	b=s9ay7RVGjLJrbbTXlxeVEduxwVpFiNN4w8vaSO8suPzUVEqBAFkTNmS4ZuamC69IBw4VbQ
	NyUcy6EOkE4eOtCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/resend: Switch to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.312487167@linutronix.de>
References: <20250429065420.312487167@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886573.406.5468656845246012068.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4bcdf07467fab54a5dfbb0fb8546b5e59c87c497
Gitweb:        https://git.kernel.org/tip/4bcdf07467fab54a5dfbb0fb8546b5e59c87c497
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:54:55 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:11 +02:00

genirq/resend: Switch to lock guards

Convert all lock/unlock pairs to guards and tidy up the code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.312487167@linutronix.de


---
 kernel/irq/resend.c | 50 ++++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 29 deletions(-)

diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index 1b7fa72..ca9cc1b 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -30,18 +30,17 @@ static DEFINE_RAW_SPINLOCK(irq_resend_lock);
  */
 static void resend_irqs(struct tasklet_struct *unused)
 {
-	struct irq_desc *desc;
-
-	raw_spin_lock_irq(&irq_resend_lock);
+	guard(raw_spinlock_irq)(&irq_resend_lock);
 	while (!hlist_empty(&irq_resend_list)) {
-		desc = hlist_entry(irq_resend_list.first, struct irq_desc,
-				   resend_node);
+		struct irq_desc *desc;
+
+		desc = hlist_entry(irq_resend_list.first, struct irq_desc,  resend_node);
 		hlist_del_init(&desc->resend_node);
+
 		raw_spin_unlock(&irq_resend_lock);
 		desc->handle_irq(desc);
 		raw_spin_lock(&irq_resend_lock);
 	}
-	raw_spin_unlock_irq(&irq_resend_lock);
 }
 
 /* Tasklet to handle resend: */
@@ -75,19 +74,18 @@ static int irq_sw_resend(struct irq_desc *desc)
 	}
 
 	/* Add to resend_list and activate the softirq: */
-	raw_spin_lock(&irq_resend_lock);
-	if (hlist_unhashed(&desc->resend_node))
-		hlist_add_head(&desc->resend_node, &irq_resend_list);
-	raw_spin_unlock(&irq_resend_lock);
+	scoped_guard(raw_spinlock, &irq_resend_lock) {
+		if (hlist_unhashed(&desc->resend_node))
+			hlist_add_head(&desc->resend_node, &irq_resend_list);
+	}
 	tasklet_schedule(&resend_tasklet);
 	return 0;
 }
 
 void clear_irq_resend(struct irq_desc *desc)
 {
-	raw_spin_lock(&irq_resend_lock);
+	guard(raw_spinlock)(&irq_resend_lock);
 	hlist_del_init(&desc->resend_node);
-	raw_spin_unlock(&irq_resend_lock);
 }
 
 void irq_resend_init(struct irq_desc *desc)
@@ -172,30 +170,24 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
  */
 int irq_inject_interrupt(unsigned int irq)
 {
-	struct irq_desc *desc;
-	unsigned long flags;
-	int err;
+	int err = -EINVAL;
 
 	/* Try the state injection hardware interface first */
 	if (!irq_set_irqchip_state(irq, IRQCHIP_STATE_PENDING, true))
 		return 0;
 
 	/* That failed, try via the resend mechanism */
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return -EINVAL;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	/*
-	 * Only try to inject when the interrupt is:
-	 *  - not NMI type
-	 *  - activated
-	 */
-	if (irq_is_nmi(desc) || !irqd_is_activated(&desc->irq_data))
-		err = -EINVAL;
-	else
-		err = check_irq_resend(desc, true);
-
-	irq_put_desc_busunlock(desc, flags);
+		/*
+		 * Only try to inject when the interrupt is:
+		 *  - not NMI type
+		 *  - activated
+		 */
+		if (!irq_is_nmi(desc) && irqd_is_activated(&desc->irq_data))
+			err = check_irq_resend(desc, true);
+	}
 	return err;
 }
 EXPORT_SYMBOL_GPL(irq_inject_interrupt);

