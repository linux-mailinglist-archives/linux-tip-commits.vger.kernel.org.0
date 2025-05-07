Return-Path: <linux-tip-commits+bounces-5384-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D693DAADAD5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11B277AAB36
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A39123958C;
	Wed,  7 May 2025 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="URWJss8h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="il2eLNWX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E9C237163;
	Wed,  7 May 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608852; cv=none; b=MkWj/KafZH9OjIUdKlXXXeIZJayDcVwsC0CciCPLH2uE6KVOGTvaEa78lx+fGpNJ4MWDYWjW/MN6XiOfJbWUu1S1pz1cwaBr3/O6rPUsrTYUJkfNxzH6N185FfEHFpUV9LWt/UC3ASjs0FWFKesCMrLjgxzptqjK/vnn9YD9nIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608852; c=relaxed/simple;
	bh=PsHshVm7OrCFWxoXpESXNwiao4xdCkBjbdxwRx2G3FI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WZLq2myVZK9to5+X8LqKgl5LRaUTh4oyrbL5sJkwLhLlf4rAjFqqRn79kGNAfYEq3htwpVyYPbqQCLU4dowg/5v+SLWHpDv2SEySeAEfuSaGJAg4GELxK4+ZEC9aYoL4vrWyWZ1QnyigQPMrI6TND6aS/zVyLeU+Jl/3wAsanM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=URWJss8h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=il2eLNWX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0NUmveqHFuaOc4cnfRAJ5DBVX8GNtUbqSqP5qdViT4=;
	b=URWJss8hek4WDP/jYW8buBDtEnk9l3RMsmdP4HinDG+lf3dEeyPJTLEshkaqbRbwfw+qI+
	GT31/0aaXpOClXb8yTVWTGiDE7ozEFKDpL9lja1NOoH3ZDXz8PwL9hOAIonUy9mR2wAcaK
	9HiIjIGMy4wjrUmRLNU8h30GQXOg8RHgMvQkh8ZcbGdA3GcgjGCYQtkqXSuSlF9Pa94P/q
	xxILQlvO+k/NIYmK34vYzVpF429HmNJ58gRuLlg7oC4jWkaeY4+sUnUieSj1rT4olNod/3
	C9pH4w82lqyIi6X8SrX968bpG0Ttp2RDaUzW9mcURoqqfv4eIYzAOZJ4OUEvrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608849;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a0NUmveqHFuaOc4cnfRAJ5DBVX8GNtUbqSqP5qdViT4=;
	b=il2eLNWX0HhHOrP1FG7nUXEGMaUm3I96nIMjK6gSFiPei8VXdSuCUzD8FlPlGtBC7gYUz+
	OUIddMq2fJL14OBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework irq_update_affinity_desc()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.830357569@linutronix.de>
References: <20250429065421.830357569@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884871.406.57443594446226884.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b0561582ea1eaa4d778b2baed18b0cc2b48674bb
Gitweb:        https://git.kernel.org/tip/b0561582ea1eaa4d778b2baed18b0cc2b48674bb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:32 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework irq_update_affinity_desc()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.830357569@linutronix.de


---
 kernel/irq/manage.c | 68 ++++++++++++++++++--------------------------
 1 file changed, 28 insertions(+), 40 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 8b4b960..81f786d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -395,14 +395,8 @@ int irq_set_affinity_locked(struct irq_data *data, const struct cpumask *mask,
  * an interrupt which is already started or which has already been configured
  * as managed will also fail, as these mean invalid init state or double init.
  */
-int irq_update_affinity_desc(unsigned int irq,
-			     struct irq_affinity_desc *affinity)
+int irq_update_affinity_desc(unsigned int irq, struct irq_affinity_desc *affinity)
 {
-	struct irq_desc *desc;
-	unsigned long flags;
-	bool activated;
-	int ret = 0;
-
 	/*
 	 * Supporting this with the reservation scheme used by x86 needs
 	 * some more thought. Fail it for now.
@@ -410,44 +404,38 @@ int irq_update_affinity_desc(unsigned int irq,
 	if (IS_ENABLED(CONFIG_GENERIC_IRQ_RESERVATION_MODE))
 		return -EOPNOTSUPP;
 
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return -EINVAL;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
+		bool activated;
 
-	/* Requires the interrupt to be shut down */
-	if (irqd_is_started(&desc->irq_data)) {
-		ret = -EBUSY;
-		goto out_unlock;
-	}
-
-	/* Interrupts which are already managed cannot be modified */
-	if (irqd_affinity_is_managed(&desc->irq_data)) {
-		ret = -EBUSY;
-		goto out_unlock;
-	}
+		/* Requires the interrupt to be shut down */
+		if (irqd_is_started(&desc->irq_data))
+			return -EBUSY;
 
-	/*
-	 * Deactivate the interrupt. That's required to undo
-	 * anything an earlier activation has established.
-	 */
-	activated = irqd_is_activated(&desc->irq_data);
-	if (activated)
-		irq_domain_deactivate_irq(&desc->irq_data);
-
-	if (affinity->is_managed) {
-		irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
-		irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
-	}
+		/* Interrupts which are already managed cannot be modified */
+		if (irqd_affinity_is_managed(&desc->irq_data))
+			return -EBUSY;
+		/*
+		 * Deactivate the interrupt. That's required to undo
+		 * anything an earlier activation has established.
+		 */
+		activated = irqd_is_activated(&desc->irq_data);
+		if (activated)
+			irq_domain_deactivate_irq(&desc->irq_data);
 
-	cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
+		if (affinity->is_managed) {
+			irqd_set(&desc->irq_data, IRQD_AFFINITY_MANAGED);
+			irqd_set(&desc->irq_data, IRQD_MANAGED_SHUTDOWN);
+		}
 
-	/* Restore the activation state */
-	if (activated)
-		irq_domain_activate_irq(&desc->irq_data, false);
+		cpumask_copy(desc->irq_common_data.affinity, &affinity->mask);
 
-out_unlock:
-	irq_put_desc_busunlock(desc, flags);
-	return ret;
+		/* Restore the activation state */
+		if (activated)
+			irq_domain_activate_irq(&desc->irq_data, false);
+		return 0;
+	}
+	return -EINVAL;
 }
 
 static int __irq_set_affinity(unsigned int irq, const struct cpumask *mask,

