Return-Path: <linux-tip-commits+bounces-5383-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EED39AADAD2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09C89A17F2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E702238C20;
	Wed,  7 May 2025 09:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YkYpXrPf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ehp4HLLv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627092367CF;
	Wed,  7 May 2025 09:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608852; cv=none; b=CO6nHjLfsPjD9TqRRJidqiQFrlf+j73uChQq9lJCY4QjJMGbqq/p0drQIDNpT2dvi9CibsUspA82csnAnuwyY8/1EVSLJNvxmxuNaPwFi5wT25MI0NquhKY26oRI75hJYsbJGIwJvE1Y139KztJrTF+lyuMJ9vRxG3a/HSBXelE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608852; c=relaxed/simple;
	bh=UWTjH9/iUg+RCZL+pUn1mX6fRMxCwItYedHy6LSKMTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sSgCHno7gPPSSLGpKIVhi5w9TJ9H73euPmDAKAGAVr3cXd1PVoNshLws09MH6JklvDAlXoc6XXI/WzgJXsM2y4kqI9gtU6CpUHYHrZygSYqH3Vyr0j1xlNaD1oBmXr8hYFztvy9vDevImtNThhE2lIDc8su+PqsTZwcWnsb2Eh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YkYpXrPf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ehp4HLLv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LF3GIy54kYwdwEZTPqMtdVQnzBGTDcZLCrrE0Tfc/E=;
	b=YkYpXrPfPUmEHODefLeRgPrTei3p1gdPM5F5VRABGHi447SHJQtFefexQWyHSxWAft2V+W
	7uNspx+e9+D2nX2jwc7LZToqmmZNPBXTuqHIR4zmn5zXM++WxQAMq4Su+u1KtDNZlM1/Jn
	O5/7QV+SU2vN1DJPkzap4EWBunueDXp941kqACBA5V3TGgFC84eEITpttkqK1I720KoUlA
	nJLwlKgLOntz2KeiO1gQ+KdAoGSnDkAFQ9PJQCfFHjeCXZd0V3KjHLHBokzBWi2qS1K+7F
	D1Zl6SGg3LXMW6y9Q37Xx2bcJGNko/MpXZrlXw2p8672tZxGq5PCgmDhvLvjbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608848;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6LF3GIy54kYwdwEZTPqMtdVQnzBGTDcZLCrrE0Tfc/E=;
	b=Ehp4HLLvDUyecuMjcLV2Bf1JOgxWuKsP2OWzp+IRj6cGWbQrOh//xcHtDOray83lDaOP1/
	0Dfva63orTAlvCAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework __irq_apply_affinity_hint()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065421.897188799@linutronix.de>
References: <20250429065421.897188799@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884804.406.7984513943448248677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7e04e5c6f6158d5528f0591cc6b3fc1a2b771a90
Gitweb:        https://git.kernel.org/tip/7e04e5c6f6158d5528f0591cc6b3fc1a2b771a90
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework __irq_apply_affinity_hint()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065421.897188799@linutronix.de


---
 kernel/irq/manage.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 81f786d..4d08a09 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -480,26 +480,24 @@ int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
 }
 EXPORT_SYMBOL_GPL(irq_force_affinity);
 
-int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m,
-			      bool setaffinity)
+int __irq_apply_affinity_hint(unsigned int irq, const struct cpumask *m, bool setaffinity)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_GLOBAL);
+	int ret = -EINVAL;
 
-	if (!desc)
-		return -EINVAL;
-	desc->affinity_hint = m;
-	irq_put_desc_unlock(desc, flags);
-	if (m && setaffinity)
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		scoped_irqdesc->affinity_hint = m;
+		ret = 0;
+	}
+
+	if (!ret && m && setaffinity)
 		__irq_set_affinity(irq, m, false);
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(__irq_apply_affinity_hint);
 
 static void irq_affinity_notify(struct work_struct *work)
 {
-	struct irq_affinity_notify *notify =
-		container_of(work, struct irq_affinity_notify, work);
+	struct irq_affinity_notify *notify = container_of(work, struct irq_affinity_notify, work);
 	struct irq_desc *desc = irq_to_desc(notify->irq);
 	cpumask_var_t cpumask;
 

