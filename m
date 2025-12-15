Return-Path: <linux-tip-commits+bounces-7707-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7366BCBFFAF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 22:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0AA330A7566
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 21:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 953873254B6;
	Mon, 15 Dec 2025 21:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BtMBIEFv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OclQ6wEW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC98732AAC3;
	Mon, 15 Dec 2025 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765834034; cv=none; b=jJ59RNHVmdoTbJn93bbqHEPDJbj8eLdQDmFt6qsud2AWYpbaJablYDBwekOObjWLj3/QwE6egUxBnVilMyibqVobvCP8KgCVSoLAs/6Ea0L+y+iJQ2qmM2749eebi6puv5qN6fm6xHYdwajkt1M3VudfjlVJqhK3el9MHLCiAYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765834034; c=relaxed/simple;
	bh=aQM4Wu+h/+uPVggadrThxNOVkiKbtFTM46tAEmcDRZA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GmSU1MR9NBD9+A/uIKuaHPaK64C3gWkk0RrBptatnGQw1JBJjUaf1I6V4nckPNfOZYcIgyeOCos5Bwpd8QDcNx/v/DIdg06wi2RBkwxH3uz6ptwkTF/KHKDBkuF3Wg46eMr8wq/h39L/z/OLiv1qOXO6csY5hObL4fwFF2WfuWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BtMBIEFv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OclQ6wEW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 21:27:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765834030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2NfNa905F/EZ1Zf6QQMF5XOUWvvTX9evOIXmBxdUhw=;
	b=BtMBIEFv3gofCbcNtcAEXWekl+feG+H98Qe1PGhTDFvNURdZr1g4K3mqCTTO9pNQT1vwRy
	ioy5dpI0d0khQf7ossz70XCmi9Sw95MCkpsc2faI9HcT30tPhIb0JAgIDjwF28XaCzD14H
	VVcQw6fUAbRRFVEcoaZPvrOCv3F4tx3xABdJbEd8I/cHhRl44u9XbLFaHWhmVsuwTgMUq8
	pJ60o+DfGCgOdCLcUO4WOFB32vDnAygstGPRnbyOF2OMMCoJDdcmDrz/cORNAqa5cKvRCU
	tcfkUDOoQnjz1jVUdoC66ynGrgwJczfRV0D5538UZ1mvmap9tRQgm61oyn/w5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765834030;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=O2NfNa905F/EZ1Zf6QQMF5XOUWvvTX9evOIXmBxdUhw=;
	b=OclQ6wEW+6erdodSOuU11L6FTEOJ/5ITZjVZtm+zDLpQuHmBl3qNwt0j3ezOB+TCKwPxC1
	ubVK8NwZ6JnQmBDA==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove setup_percpu_irq()
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251210082242.360936-7-maz@kernel.org>
References: <20251210082242.360936-7-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176583402822.510.8899777163415819947.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     dbcc728e185f8c27fcafa1408ff63fe38c7dc72d
Gitweb:        https://git.kernel.org/tip/dbcc728e185f8c27fcafa1408ff63fe38c7=
dc72d
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 10 Dec 2025 08:22:42=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 22:20:51 +01:00

genirq: Remove setup_percpu_irq()

setup_percpu_irq() was always a bad kludge, and should have never
been there the first place. Now that the last users are gone,
remove it for good.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251210082242.360936-7-maz@kernel.org
---
 include/linux/irq.h |  3 ---
 kernel/irq/manage.c | 30 ------------------------------
 2 files changed, 33 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4a9f1d7..67ea759 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -595,9 +595,6 @@ enum {
=20
 #define IRQ_DEFAULT_INIT_FLAGS	ARCH_IRQ_INIT_FLAGS
=20
-struct irqaction;
-extern int setup_percpu_irq(unsigned int irq, struct irqaction *new);
-
 #ifdef CONFIG_DEPRECATED_IRQ_CPU_ONOFFLINE
 extern void irq_cpu_online(void);
 extern void irq_cpu_offline(void);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4d0b326..bc2d36b 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2448,36 +2448,6 @@ void free_percpu_nmi(unsigned int irq, void __percpu *=
dev_id)
 	kfree(__free_percpu_irq(irq, dev_id));
 }
=20
-/**
- * setup_percpu_irq - setup a per-cpu interrupt
- * @irq:	Interrupt line to setup
- * @act:	irqaction for the interrupt
- *
- * Used to statically setup per-cpu interrupts in the early boot process.
- */
-int setup_percpu_irq(unsigned int irq, struct irqaction *act)
-{
-	struct irq_desc *desc =3D irq_to_desc(irq);
-	int retval;
-
-	if (!desc || !irq_settings_is_per_cpu_devid(desc))
-		return -EINVAL;
-
-	retval =3D irq_chip_pm_get(&desc->irq_data);
-	if (retval < 0)
-		return retval;
-
-	if (!act->affinity)
-		act->affinity =3D cpu_online_mask;
-
-	retval =3D __setup_irq(irq, desc, act);
-
-	if (retval)
-		irq_chip_pm_put(&desc->irq_data);
-
-	return retval;
-}
-
 static
 struct irqaction *create_percpu_irqaction(irq_handler_t handler, unsigned lo=
ng flags,
 					  const char *devname, const cpumask_t *affinity,

