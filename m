Return-Path: <linux-tip-commits+bounces-5396-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCEA0AADAEF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:12:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBDCE1C04F00
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:12:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E31E241696;
	Wed,  7 May 2025 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leuj+9HZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qi+aj5+P"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C99231822;
	Wed,  7 May 2025 09:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608861; cv=none; b=V8dyhbuk7c63KzlxUJb6VjZOC9KnR4VwiGUr6byNjZT1bqOL/XxSLUA5Yd9LQ9jB786g9nI7mzmro7bv+Inf+n47nCv2M8IS52A9V2PEXLIvmVcv7wRtVcQvsHy8xOz2FMp/uRIb3eDLdVCx4EJKy0JQ2OP0na3RuUcNxsJVndw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608861; c=relaxed/simple;
	bh=M0tWVbVCFznQaKn2at3WCKEvoHiOWpDIH12/bb3atDM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rLXiABK2NRTFjiUy+ixtoO4wAZqvgWJySyfOk/BWsIsqrpJeEbgVq+fa60Tf6Co9lWZlYVEk8JJ0E5s+Uari/pp91SeAe+3SvoMgQf8uV2yR+6Z0cFSTjrC1GHzP0WcMOuhvSwS7711NN5gXkA6+iGXTcEHmtk5mEuLxQrs9r+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=leuj+9HZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qi+aj5+P; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHspYVPP0wQxHydvScLW4vuysFZkFh3kxi2e3advaRA=;
	b=leuj+9HZIJXdtzRIO2dVCX9PsQqKFrPKijxYvVxYOAOKy7L25XHZOh+XfITS+WAJyARNjp
	/Nmlg664hOLcF2WuH0NWvEAUHXSYAghOm2s3GYZ+L0SaIxp63iYc3FWXC1cqohS0rJrx/x
	ibVr75dAJVMEOsZeJAi8tD28T/6jokO5A9pWdWGnskw2cWiCMdIbm88HuBMA4zeVZml3Fk
	cweP30jYIg4O/0a2bA98VfBKEiZ4NGWrdQc/tL6tfNgGV/OmowqTkhrykzLC8azNkVhg94
	leetRiBsZZrpTn/YsiF9v0pJngU7cHeiveJN9L9/LY4byeFkAC6R8iVuxu4zPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608857;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YHspYVPP0wQxHydvScLW4vuysFZkFh3kxi2e3advaRA=;
	b=qi+aj5+PwjmuX7KIiQdFg2ldZHXopI2KjOtF9i6GJQssv7iLspjHxQB53QFQOJeMmC6xJM
	QgV0iyI34XT9XpDg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework handle_fasteoi_ack_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.105015800@linutronix.de>
References: <20250429065421.105015800@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885682.406.15109688124642876678.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2beb01cbb75e5849b6ebc15917c7dd3e46264b48
Gitweb:        https://git.kernel.org/tip/2beb01cbb75e5849b6ebc15917c7dd3e46264b48
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:13 +02:00

genirq/chip: Rework handle_fasteoi_ack_irq()

Use the new helpers to decide whether the interrupt should be handled and
switch the descriptor locking to guard().

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.105015800@linutronix.de


---
 kernel/irq/chip.c | 39 +++++++++++++--------------------------
 1 file changed, 13 insertions(+), 26 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6c33679..2b60542 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -1106,53 +1106,40 @@ void irq_cpu_offline(void)
 
 #ifdef CONFIG_IRQ_FASTEOI_HIERARCHY_HANDLERS
 /**
- *	handle_fasteoi_ack_irq - irq handler for edge hierarchy
- *	stacked on transparent controllers
+ * handle_fasteoi_ack_irq - irq handler for edge hierarchy stacked on
+ *			    transparent controllers
  *
- *	@desc:	the interrupt description structure for this irq
+ * @desc:	the interrupt description structure for this irq
  *
- *	Like handle_fasteoi_irq(), but for use with hierarchy where
- *	the irq_chip also needs to have its ->irq_ack() function
- *	called.
+ * Like handle_fasteoi_irq(), but for use with hierarchy where the irq_chip
+ * also needs to have its ->irq_ack() function called.
  */
 void handle_fasteoi_ack_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = desc->irq_data.chip;
 
-	raw_spin_lock(&desc->lock);
-
-	if (!irq_can_handle_pm(desc))
-		goto out;
+	guard(raw_spinlock)(&desc->lock);
 
-	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+	if (!irq_can_handle_pm(desc)) {
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
+	}
 
-	/*
-	 * If its disabled or no action available
-	 * then mask it and get out of here:
-	 */
-	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
-		desc->istate |= IRQS_PENDING;
+	if (unlikely(!irq_can_handle_actions(desc))) {
 		mask_irq(desc);
-		goto out;
+		cond_eoi_irq(chip, &desc->irq_data);
+		return;
 	}
 
 	kstat_incr_irqs_this_cpu(desc);
 	if (desc->istate & IRQS_ONESHOT)
 		mask_irq(desc);
 
-	/* Start handling the irq */
 	desc->irq_data.chip->irq_ack(&desc->irq_data);
 
 	handle_irq_event(desc);
 
 	cond_unmask_eoi_irq(desc, chip);
-
-	raw_spin_unlock(&desc->lock);
-	return;
-out:
-	if (!(chip->flags & IRQCHIP_EOI_IF_HANDLED))
-		chip->irq_eoi(&desc->irq_data);
-	raw_spin_unlock(&desc->lock);
 }
 EXPORT_SYMBOL_GPL(handle_fasteoi_ack_irq);
 

