Return-Path: <linux-tip-commits+bounces-3246-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7B5FA11ED4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 11:04:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78BBE3A8E44
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:04:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C226A20F07E;
	Wed, 15 Jan 2025 10:04:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S7nMAYq+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1fFTUET9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED22D1E7C32;
	Wed, 15 Jan 2025 10:04:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736935457; cv=none; b=VpGUPaLN2dwIGGB2blGemnm1HiGi55FU2Od7IbnUBOhUjzRV+f2lfwA/bZAVN4mRgsCHJBEktOXiGzuwnM1snhuvfLTJdPPgjotHqFklVdEIMSPiOviPUwaP1rhW/haPfQBzG2iWBs1dzJnQTGxT2f3uYJOo9+Cpud38m1ki1ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736935457; c=relaxed/simple;
	bh=w1p2DoC+mH0z6hC7Aaqvy5IxQUArPov4fFMnCkh4o5g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qQPMp5EbaiDFtoBwLr9ue1wuBbcTA2/pahVbH1yF+V0aCM1YngaIP2NawwR5ASgh1QBgBk1s9BetfCe/EzqxrqyT05WKaEnUhpV8FMQnrDoiZi9W05Pk+9EpzLmhVc9GrtahmwcJdCXNmKSEWXiZgrs2eTWqYFrwVb2E3pKQ8q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S7nMAYq+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1fFTUET9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 10:04:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736935454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIMKpfXiOIvvvgja1tF6+S4Wq3T2+HIXt7J+DMpAyAQ=;
	b=S7nMAYq++bxb460IbRp7bQXWahY7VWopVY4yv2mVjv3iPmwiVbK8Ucc1zGGejXGWhg+ODY
	17B+L9gSBBxXFup7OjISoRyzzxRges0wUtSoCnncKzDS35UhAtynaLKDm5elBQDUStM+KH
	asn6AcGb/IH08K3iFvTjOxpL9pKJqyTskradFy170sQMZW+q47FefGpp6G+T1CXdYo9MDO
	JC9H8CliIb/Sdqix9zatf++dVfDYJ0nG3HJC5bTw7bWSe1F6aytvrGcOUH7OQiBFCmcky5
	fl80cw08YLJIMqkrCB7IczdnJeydCXXGWOQLrK5qXuaRLUW2kliakZQRMncFKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736935454;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIMKpfXiOIvvvgja1tF6+S4Wq3T2+HIXt7J+DMpAyAQ=;
	b=1fFTUET9ga1w43H2VjLXZ2QqaLevJIM5wXUzEPf/6/tJZ+65fmlbjIdvxU0BRV+8GBk0KE
	U5VdTyvS9p2wVkAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Provide IRQCHIP_MOVE_DEFERRED
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241210103335.500314436@linutronix.de>
References: <20241210103335.500314436@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693545349.31546.14751091560216620111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a648eb3a3f79e9736a59b28783700c2c691db419
Gitweb:        https://git.kernel.org/tip/a648eb3a3f79e9736a59b28783700c2c691db419
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 10 Dec 2024 11:34:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 10:56:22 +01:00

genirq: Provide IRQCHIP_MOVE_DEFERRED

The logic of GENERIC_PENDING_IRQ is backwards for historical reasons. Most
interrupt controllers allow to move the interrupt from arbitrary
contexts. If GENERIC_PENDING_IRQ is enabled by an architecture to support a
chip, which requires the affinity change to happen in interrupt context,
all other chips have to be marked with IRQF_MOVE_PCNTXT.

That's tedious and there is no real good reason for the extra flags in the
irq descriptor and the irq data status fields. In fact the decision whether
interrupts can be moved in arbitrary context or not is a property of the
interrupt chip.

To simplify adoption for RISC-V provide a new mechanism which is enabled
via a config switch and allows to add a flag to irq_chip::flags to request
that interrupt affinity changes are deferred. Setting the top level chip of
an interrupt evaluates the flag and maps it into the existing logic.

The config switch and the various PCNTXT flags are temporary until x86 is
converted over to this scheme. This intermediate step also allows trivial
backporting of the mechanism to plug the affinity change race of various
RISC-V interrupt controllers.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241210103335.500314436@linutronix.de

---
 include/linux/irq.h  |  2 ++
 kernel/irq/Kconfig   |  4 ++++
 kernel/irq/chip.c    | 18 +++++++++++++++---
 kernel/irq/debugfs.c |  1 +
 4 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 25f51bf..6e02154 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -567,6 +567,7 @@ struct irq_chip {
  *                                    in the suspend path if they are in disabled state
  * IRQCHIP_AFFINITY_PRE_STARTUP:      Default affinity update before startup
  * IRQCHIP_IMMUTABLE:		      Don't ever change anything in this chip
+ * IRQCHIP_MOVE_DEFERRED:	      Move the interrupt in actual interrupt context
  */
 enum {
 	IRQCHIP_SET_TYPE_MASKED			= (1 <<  0),
@@ -581,6 +582,7 @@ enum {
 	IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND	= (1 <<  9),
 	IRQCHIP_AFFINITY_PRE_STARTUP		= (1 << 10),
 	IRQCHIP_IMMUTABLE			= (1 << 11),
+	IRQCHIP_MOVE_DEFERRED			= (1 << 12),
 };
 
 #include <linux/irqdesc.h>
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 875f25e..5432418 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -31,6 +31,10 @@ config GENERIC_IRQ_EFFECTIVE_AFF_MASK
 config GENERIC_PENDING_IRQ
 	bool
 
+# Deduce delayed migration from top-level interrupt chip flags
+config GENERIC_PENDING_IRQ_CHIPFLAGS
+	bool
+
 # Support for generic irq migrating off cpu before the cpu is offline.
 config GENERIC_IRQ_MIGRATION
 	bool
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 271e913..7989da2 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -47,6 +47,13 @@ int irq_set_chip(unsigned int irq, const struct irq_chip *chip)
 		return -EINVAL;
 
 	desc->irq_data.chip = (struct irq_chip *)(chip ?: &no_irq_chip);
+
+	if (IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS) && chip) {
+		if (chip->flags & IRQCHIP_MOVE_DEFERRED)
+			irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		else
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
 	irq_put_desc_unlock(desc, flags);
 	/*
 	 * For !CONFIG_SPARSE_IRQ make the irq show up in
@@ -1114,16 +1121,21 @@ void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 	trigger = irqd_get_trigger_type(&desc->irq_data);
 
 	irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
-		   IRQD_TRIGGER_MASK | IRQD_LEVEL | IRQD_MOVE_PCNTXT);
+		   IRQD_TRIGGER_MASK | IRQD_LEVEL);
 	if (irq_settings_has_no_balance_set(desc))
 		irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
 	if (irq_settings_is_per_cpu(desc))
 		irqd_set(&desc->irq_data, IRQD_PER_CPU);
-	if (irq_settings_can_move_pcntxt(desc))
-		irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
 	if (irq_settings_is_level(desc))
 		irqd_set(&desc->irq_data, IRQD_LEVEL);
 
+	/* Keep this around until x86 is converted over */
+	if (!IS_ENABLED(CONFIG_GENERIC_PENDING_IRQ_CHIPFLAGS)) {
+		irqd_clear(&desc->irq_data, IRQD_MOVE_PCNTXT);
+		if (irq_settings_can_move_pcntxt(desc))
+			irqd_set(&desc->irq_data, IRQD_MOVE_PCNTXT);
+	}
+
 	tmp = irq_settings_get_trigger_mask(desc);
 	if (tmp != IRQ_TYPE_NONE)
 		trigger = tmp;
diff --git a/kernel/irq/debugfs.c b/kernel/irq/debugfs.c
index c6ffb97..975eb8d 100644
--- a/kernel/irq/debugfs.c
+++ b/kernel/irq/debugfs.c
@@ -53,6 +53,7 @@ static const struct irq_bit_descr irqchip_flags[] = {
 	BIT_MASK_DESCR(IRQCHIP_SUPPORTS_NMI),
 	BIT_MASK_DESCR(IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND),
 	BIT_MASK_DESCR(IRQCHIP_IMMUTABLE),
+	BIT_MASK_DESCR(IRQCHIP_MOVE_DEFERRED),
 };
 
 static void

