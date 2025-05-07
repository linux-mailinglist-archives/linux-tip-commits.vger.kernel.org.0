Return-Path: <linux-tip-commits+bounces-5386-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA1CAADAD9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30EA61BC2CC8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:10:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13C6023A99D;
	Wed,  7 May 2025 09:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4kTG9q55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gsvrmK9M"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F3F239E66;
	Wed,  7 May 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608854; cv=none; b=Q8ZSWRei+8z/iuceiOa4jdH4IcARogfCVoTkSZ0YrtLYJE9VP3sLZWXDCpRGECBpPLbnaZnpZAtJdJm5kEUx1Dq/8LhMokuz1f4Tgx64mDGoeQIwNaCB95x2gRi4WEWrE9g3S2AktJZ7Bogs6LTsr7kOhBH/FT6C4RAS1SJI59k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608854; c=relaxed/simple;
	bh=E2TA6cQDsDr4F7QKDQoUkyBbK2FxnbjPHcrG3ZfWYhI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LdqF59Z1nvCCrDqnmL+KaBLRod8z63VJ9xE0uDyjAVclSsQVHKx3IcGSgk9VM0Bdf2urJX9pBMhYsGMmT7HHkI6Ue+IN6SykItlu94W4IPYnJyf2V3dwM4FiDHVqH9nmGqiulkdU4oad8fVDruNQ7TzA2TlwnLLvo/5yysKFpjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4kTG9q55; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gsvrmK9M; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaD+BeMZS2o6OGWk7nRmko+gSuoqw+tLnu75CFAWOt8=;
	b=4kTG9q55qTgmJb0wTQMpKFcd2ryir1WIABvmUNuq1DUKyujmaloVjfn8f9cFWqi3GFE0Pr
	Alo7oQj32ZVkh+G7iCxwfi172MF7PnE0NYifKhJf3EwRrkZrfZo9lHDMPxxTtG5R0t7uxC
	52Y64bpdjc2YObgfrDoFtu0r9fDfbpkTtaXTzPRNsgxm2zYz3ZluBJfe4PNKvgeGXNYc2p
	MTlHKwLxulvI9HB506bLVzoRpISsv8XfV73bfF1Pn0+ukk3vNUNY7kqWkPLQmeGpWEVKSL
	4573bC1QZbRSmEIPP8C7HGtzxXldvtL4go3q/P/ivMxfediHdDEZSJ4Vxl5HRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DaD+BeMZS2o6OGWk7nRmko+gSuoqw+tLnu75CFAWOt8=;
	b=gsvrmK9MGz0JeYuQtyUB4ycyK8Gygu+lST7NSLuwFAQEYJ3diCcBPoDwzS6D4BPhSau9ae
	ajpU3el2pvl2AnAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Rework irq_modify_status()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.650454052@linutronix.de>
References: <20250429065421.650454052@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660885074.406.6422595959115709592.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     95a3645893bceb18475c3bea4afaf47d23d11ab6
Gitweb:        https://git.kernel.org/tip/95a3645893bceb18475c3bea4afaf47d23d11ab6
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:14 +02:00

genirq/chip: Rework irq_modify_status()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Fixup the kernel doc comment while at it.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.650454052@linutronix.de


---
 kernel/irq/chip.c | 50 +++++++++++++++++++++-------------------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 7f1c640..865cf74 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -972,38 +972,34 @@ EXPORT_SYMBOL_GPL(irq_set_chip_and_handler_name);
 
 void irq_modify_status(unsigned int irq, unsigned long clr, unsigned long set)
 {
-	unsigned long flags, trigger, tmp;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-
-	if (!desc)
-		return;
-
-	/*
-	 * Warn when a driver sets the no autoenable flag on an already
-	 * active interrupt.
-	 */
-	WARN_ON_ONCE(!desc->depth && (set & _IRQ_NOAUTOEN));
-
-	irq_settings_clr_and_set(desc, clr, set);
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
+		unsigned long trigger, tmp;
+		/*
+		 * Warn when a driver sets the no autoenable flag on an already
+		 * active interrupt.
+		 */
+		WARN_ON_ONCE(!desc->depth && (set & _IRQ_NOAUTOEN));
 
-	trigger = irqd_get_trigger_type(&desc->irq_data);
+		irq_settings_clr_and_set(desc, clr, set);
 
-	irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
-		   IRQD_TRIGGER_MASK | IRQD_LEVEL);
-	if (irq_settings_has_no_balance_set(desc))
-		irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
-	if (irq_settings_is_per_cpu(desc))
-		irqd_set(&desc->irq_data, IRQD_PER_CPU);
-	if (irq_settings_is_level(desc))
-		irqd_set(&desc->irq_data, IRQD_LEVEL);
+		trigger = irqd_get_trigger_type(&desc->irq_data);
 
-	tmp = irq_settings_get_trigger_mask(desc);
-	if (tmp != IRQ_TYPE_NONE)
-		trigger = tmp;
+		irqd_clear(&desc->irq_data, IRQD_NO_BALANCING | IRQD_PER_CPU |
+			   IRQD_TRIGGER_MASK | IRQD_LEVEL);
+		if (irq_settings_has_no_balance_set(desc))
+			irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
+		if (irq_settings_is_per_cpu(desc))
+			irqd_set(&desc->irq_data, IRQD_PER_CPU);
+		if (irq_settings_is_level(desc))
+			irqd_set(&desc->irq_data, IRQD_LEVEL);
 
-	irqd_set(&desc->irq_data, trigger);
+		tmp = irq_settings_get_trigger_mask(desc);
+		if (tmp != IRQ_TYPE_NONE)
+			trigger = tmp;
 
-	irq_put_desc_unlock(desc, flags);
+		irqd_set(&desc->irq_data, trigger);
+	}
 }
 EXPORT_SYMBOL_GPL(irq_modify_status);
 

