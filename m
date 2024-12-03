Return-Path: <linux-tip-commits+bounces-2963-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 527A99E1A3A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 12:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8E97160163
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 11:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEE591E3DC8;
	Tue,  3 Dec 2024 11:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nKXqKo1g";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qOtDCDvD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14CBC1E0E12;
	Tue,  3 Dec 2024 11:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733223736; cv=none; b=ZP7gNjMYr5lOMNjOx0XF2fkka16Xa2wg7UCSPNz88NV4Nwhvq+3ov6EommvfguGxLiploA1jEfewwgkB7t+ujVIhHCh6gyQ3LZmIloAc5vG6tve432NcOtjKgW1VHHbzNaRJst9wcJ+P/3ADJ+GfVxRBvHF8eRysSUFMnf1Z+dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733223736; c=relaxed/simple;
	bh=5yPxr2VZfPis1R02zXstCZw0Uo2xr2AioB/uKcIPVtw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=C9aAMV1CfX757wJG79F1VarqsaHVMg074R/RQ735h8ZbTjD1VlacylfNItmqxM9r/QmqSd31eBVfCzLH3PHUAq1rT+rY5jz/CQz70FT3pnfocZC6vJElqDu2E+X8pKwbJ25Dya3cqsBPU+Ioh8fyztY5gP7tRqEznUxktt5d8qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nKXqKo1g; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qOtDCDvD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 11:02:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733223733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lb0cipFtRfqzHnqJN5acCYX8iY0ekq9Pppx3G0TjpIE=;
	b=nKXqKo1gZY9G/zyTb7nbGMB8DwGqI2oSedH+8u7wp4vkoZfJzxuB/k1KKZsJvxVDzHMoJB
	WX56GudtzJlgcc46D62o3I14s5Ubbxnh3hW14fUljWYG4DmTh8+QGKMqR6RFbc62OZfUt4
	nxdTaM7bxQy+0tT6G5hyobhX0lhegpuS/lZ/8Y6EisGq2J/mgDi9RiY37N4qz+ueZ1ZIQL
	Itsfken+qB5cSJmsSLMx0R1fN+uM5+ziIuaVQ+zXEYaktlcC2EYBec8jj9NzA0EveXR6Mg
	4cEYFMkDsjOFfLyzaNqw2/guOs35IE1SDJEQBqHr3OZO6L77btJ5H3Rlt/E4kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733223733;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Lb0cipFtRfqzHnqJN5acCYX8iY0ekq9Pppx3G0TjpIE=;
	b=qOtDCDvDnYRSqEyQNHgiK0nQtGMOrg+6WQm+/N+cZxgK22NZVA+zZsoWb01sXNAg8hLV1t
	72ZPwMwLTpENFxAw==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Move irq_thread_fn() further up in the code
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241119104339.2112455-2-andriy.shevchenko@linux.intel.com>
References: <20241119104339.2112455-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322373258.412.8440796108563687060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6f8b79683dfb37ee0661cf4c13a72f024c29f65c
Gitweb:        https://git.kernel.org/tip/6f8b79683dfb37ee0661cf4c13a72f024c29f65c
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Tue, 19 Nov 2024 12:42:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 03 Dec 2024 11:59:10 +01:00

genirq: Move irq_thread_fn() further up in the code

In a preparation to reuse irq_thread_fn() move it further up in the
code. No functional change intended.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241119104339.2112455-2-andriy.shevchenko@linux.intel.com

---
 kernel/irq/manage.c | 35 ++++++++++++++++-------------------
 1 file changed, 16 insertions(+), 19 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index f0803d6..230f470 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1182,45 +1182,42 @@ out_unlock:
 }
 
 /*
- * Interrupts which are not explicitly requested as threaded
- * interrupts rely on the implicit bh/preempt disable of the hard irq
- * context. So we need to disable bh here to avoid deadlocks and other
- * side effects.
+ * Interrupts explicitly requested as threaded interrupts want to be
+ * preemptible - many of them need to sleep and wait for slow busses to
+ * complete.
  */
-static irqreturn_t
-irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
+static irqreturn_t irq_thread_fn(struct irq_desc *desc,	struct irqaction *action)
 {
-	irqreturn_t ret;
+	irqreturn_t ret = action->thread_fn(action->irq, action->dev_id);
 
-	local_bh_disable();
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_disable();
-	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
-	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
-		local_irq_enable();
-	local_bh_enable();
 	return ret;
 }
 
 /*
- * Interrupts explicitly requested as threaded interrupts want to be
- * preemptible - many of them need to sleep and wait for slow busses to
- * complete.
+ * Interrupts which are not explicitly requested as threaded
+ * interrupts rely on the implicit bh/preempt disable of the hard irq
+ * context. So we need to disable bh here to avoid deadlocks and other
+ * side effects.
  */
-static irqreturn_t irq_thread_fn(struct irq_desc *desc,
-		struct irqaction *action)
+static irqreturn_t irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 {
 	irqreturn_t ret;
 
+	local_bh_disable();
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_disable();
 	ret = action->thread_fn(action->irq, action->dev_id);
 	if (ret == IRQ_HANDLED)
 		atomic_inc(&desc->threads_handled);
 
 	irq_finalize_oneshot(desc, action);
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT))
+		local_irq_enable();
+	local_bh_enable();
 	return ret;
 }
 

