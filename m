Return-Path: <linux-tip-commits+bounces-6159-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84951B0DA00
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 14:46:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 243417AD1F3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jul 2025 12:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2409F2E424E;
	Tue, 22 Jul 2025 12:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ObF1uMc9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IySjhPS7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A779FC0B;
	Tue, 22 Jul 2025 12:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753188358; cv=none; b=r9ZwfPjb/EaV36u0bYT/22a68eVJ2PfE3w08oux9VWQ8bBe6sit3I0vxDWQZzPkDfVjvAZ9fhoNzU4ovglRfjk65nQsHzoYcbcpYojvEcw3sU6XQkNXtF/hoA5ciQ6WMovq8BT7RuPjJQg2wFvV6eefMPiwJifaFFiEZQHXirog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753188358; c=relaxed/simple;
	bh=5R4IT7GD20+EU5g/St8A2rf3XdgwQVGULFav3vVt9Lg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pqJcs2bBCoRTf0G5/DLNGwLiNgbbLAqNErKQGPHTnm2Xu91gUs9XAJaBRCijwtktimpldIPRVUMbiTYegdLMjrk9rLPnBNUfV3haS7VPy1lv5mnkdfMiEz4Yg48tmMzxGfWFGa6XJEhXAHaav4wY5ibrXRWR73NSr+4iHKb0tRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ObF1uMc9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IySjhPS7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 22 Jul 2025 12:45:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753188354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfH2HTyorkS9zjBEDInvPyl9TGwRss29Juyi41G5l3o=;
	b=ObF1uMc9uQ3SF5CLUwcdCnkaPNphZz6U/KXyuSbkodqN0jng5+9YEDka9HvGRe8BgUfuV9
	ySozRZq1ZRnxeost3PMAW+376u9Qd7bJSzfdG9r97li7a65ri19YMJeq0Xs45ZQfTwSqFi
	M92TEOOXBLwWd/mwvzMYjZpecQ9bGhFUP39G8k+gTG2mGBd2A42SjYrTufUsX3bBL5u2WI
	xboRSf486gHikM5IuGSMKaWUlc0se/dQhvJUtvLFI31KYFZvwcaz3f5CHIST4y96ChqIFS
	++cogAAtR16Ih0itmYlzo6mANxIisepW3sNux1zQm2AzfmwaU8Z8ifkh0j4cEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753188354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BfH2HTyorkS9zjBEDInvPyl9TGwRss29Juyi41G5l3o=;
	b=IySjhPS7ulrfR3YZNih0H8Y7POGAPca/cOlqF3+lh17dFl1hHcHQBwi3z9yxvh4fFuCbcQ
	un7Dvl2/tuKRDECA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Split up irq_pm_check_wakeup()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Liangyan <liangyan.peng@bytedance.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250718185312.012392426@linutronix.de>
References: <20250718185312.012392426@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175318835312.1420.11499005207479026635.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c609045abc778689ce42e8f5827a84179ace52c5
Gitweb:        https://git.kernel.org/tip/c609045abc778689ce42e8f5827a84179ac=
e52c5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 18 Jul 2025 20:54:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jul 2025 14:30:42 +02:00

genirq: Split up irq_pm_check_wakeup()

Let the calling code check for the IRQD_WAKEUP_ARMED flag to prepare for a
live lock mitigation in the edge type handler.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Liangyan <liangyan.peng@bytedance.com>
Link: https://lore.kernel.org/all/20250718185312.012392426@linutronix.de

---
 kernel/irq/chip.c      |  4 +++-
 kernel/irq/internals.h |  4 ++--
 kernel/irq/pm.c        | 16 ++++++----------
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 290244c..11ecf6c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -488,8 +488,10 @@ static bool irq_can_handle_pm(struct irq_desc *desc)
 	 * and suspended, disable it and notify the pm core about the
 	 * event.
 	 */
-	if (irq_pm_check_wakeup(desc))
+	if (unlikely(irqd_has_set(irqd, IRQD_WAKEUP_ARMED))) {
+		irq_pm_handle_wakeup(desc);
 		return false;
+	}
=20
 	/* Check whether the interrupt is polled on another CPU */
 	if (unlikely(desc->istate & IRQS_POLL_INPROGRESS)) {
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 82b0d67..0164ca4 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -277,11 +277,11 @@ static inline bool irq_is_nmi(struct irq_desc *desc)
 }
=20
 #ifdef CONFIG_PM_SLEEP
-bool irq_pm_check_wakeup(struct irq_desc *desc);
+void irq_pm_handle_wakeup(struct irq_desc *desc);
 void irq_pm_install_action(struct irq_desc *desc, struct irqaction *action);
 void irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action);
 #else
-static inline bool irq_pm_check_wakeup(struct irq_desc *desc) { return false=
; }
+static inline void irq_pm_handle_wakeup(struct irq_desc *desc) { }
 static inline void
 irq_pm_install_action(struct irq_desc *desc, struct irqaction *action) { }
 static inline void
diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
index 445912d..f739472 100644
--- a/kernel/irq/pm.c
+++ b/kernel/irq/pm.c
@@ -13,17 +13,13 @@
=20
 #include "internals.h"
=20
-bool irq_pm_check_wakeup(struct irq_desc *desc)
+void irq_pm_handle_wakeup(struct irq_desc *desc)
 {
-	if (irqd_is_wakeup_armed(&desc->irq_data)) {
-		irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
-		desc->istate |=3D IRQS_SUSPENDED | IRQS_PENDING;
-		desc->depth++;
-		irq_disable(desc);
-		pm_system_irq_wakeup(irq_desc_get_irq(desc));
-		return true;
-	}
-	return false;
+	irqd_clear(&desc->irq_data, IRQD_WAKEUP_ARMED);
+	desc->istate |=3D IRQS_SUSPENDED | IRQS_PENDING;
+	desc->depth++;
+	irq_disable(desc);
+	pm_system_irq_wakeup(irq_desc_get_irq(desc));
 }
=20
 /*

