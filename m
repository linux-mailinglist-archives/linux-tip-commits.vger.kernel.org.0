Return-Path: <linux-tip-commits+bounces-5382-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D91DAADAD4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:10:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2785503B7D
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E551E23816E;
	Wed,  7 May 2025 09:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MBV9530B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6or84AzK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A0BD230BFB;
	Wed,  7 May 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608851; cv=none; b=hnkaYQk666g+lu20YAdw50e1bTSm4b6iQupF2HoiR1IDG8x+vV8dZg76dff+g1dl5mYEnK0js1M1XFhFTBYFA6KRDwlwM9i1r3yQ0C+FEaxZL7msm+eiiF5Is9Vqg5AoD7fdDpyhX4XyRNnTIehcf190lRlRnj6MqRetyaGQ1T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608851; c=relaxed/simple;
	bh=8tvJ7O6liH5/gwoG4B5mxsaBTuY0CS7ml3J4mKykT1Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=T8yAPleVLvPvI8vvBCPYcdpuD9BinQ3+Qs5IS0rXAVdov7ppkXIJ4NJhc2akl/J9AAJSyzWbiyIriRMdwhmXynyLEqvbAXGKrNz5jn8z2e/IlwYFnXu8N2EL/zwHpts4+6yP62ymuCYdX5mpOzY+n9J90FUXW/c0p4zSMoaHmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MBV9530B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6or84AzK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcyR1wjhR65uWYGhVtlbuw8H5o65RCQJzibKYkZ5cng=;
	b=MBV9530BkN6QPD6FPR2zSHJNHcZUhNc+K2STXChTy08VzMdg36UPVcKHQXUCa7Wtk42eRs
	IsqCLNFSXpYAzzo7rjKcw6zo5Ch8inKTJQ/CUkC2oCjaTN4eZK/8CzVVrp0qCZxnjnfylH
	Y4EFyM9/vrtccgW1nq5XgHZBhaZL+r3Pi2DQ5uvYvWItQgSrWnrNmNLSXrNmH9PY61tXHp
	gZKAFdhueyRy6McuCwh2NUVV3fHvqd/8g+hQvoCoNObHCN9xVI5hESsD3h0Dkvw6KDStDy
	3O8jZB34N+U7nZs25ncE6wJ7FEhAVsEaDJXcGxk84tCO53CRr7/ntxYokJORjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PcyR1wjhR65uWYGhVtlbuw8H5o65RCQJzibKYkZ5cng=;
	b=6or84AzK2APzeKeLsJwFoCY6UwEB0iQsW0TPvAHYrh3wo6543cCo6TOE8wN0Q3FRd1rJQt
	SR1wjk+NDXjXYaCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework irq_set_vcpu_affinity()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87ikmlq0fk.ffs@tglx>
References: <87ikmlq0fk.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884738.406.3672661029013467120.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     55ac0ad22fec0c5c5a76112725804957a62f5af7
Gitweb:        https://git.kernel.org/tip/55ac0ad22fec0c5c5a76112725804957a62f5af7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 17:00:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework irq_set_vcpu_affinity()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/87ikmlq0fk.ffs@tglx

---
 kernel/irq/manage.c | 39 ++++++++++++++++-----------------------
 1 file changed, 16 insertions(+), 23 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4d08a09..c18440d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -629,32 +629,25 @@ int irq_setup_affinity(struct irq_desc *desc)
  */
 int irq_set_vcpu_affinity(unsigned int irq, void *vcpu_info)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-	struct irq_data *data;
-	struct irq_chip *chip;
-	int ret = -ENOSYS;
-
-	if (!desc)
-		return -EINVAL;
+	scoped_irqdesc_get_and_lock(irq, 0) {
+		struct irq_desc *desc = scoped_irqdesc;
+		struct irq_data *data;
+		struct irq_chip *chip;
 
-	data = irq_desc_get_irq_data(desc);
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (chip && chip->irq_set_vcpu_affinity)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
+		data = irq_desc_get_irq_data(desc);
+		do {
+			chip = irq_data_get_irq_chip(data);
+			if (chip && chip->irq_set_vcpu_affinity)
+				break;
 
-	if (data)
-		ret = chip->irq_set_vcpu_affinity(data, vcpu_info);
-	irq_put_desc_unlock(desc, flags);
+			data = irqd_get_parent_data(data);
+		} while (data);
 
-	return ret;
+		if (!data)
+			return -ENOSYS;
+		return chip->irq_set_vcpu_affinity(data, vcpu_info);
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_vcpu_affinity);
 

