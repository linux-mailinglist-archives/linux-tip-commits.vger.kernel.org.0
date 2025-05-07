Return-Path: <linux-tip-commits+bounces-5403-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF57BAADAFD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:13:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 558EF9A1C6C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA4D247295;
	Wed,  7 May 2025 09:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0ZVELQ9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="il5slJ83"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C76243956;
	Wed,  7 May 2025 09:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608866; cv=none; b=LjeHgbTmhOIZw535DzAog6z0ooXwRpVargNAS5LIKynHKtStjZP87Qh7Thlj8HR7PYCMqrHmpTAL7Q/bxSdNZke8hPqocNSqC6uH2qVuWJ23Ks6GsuS3M1G4AgS80OgSCZvPEGjxSXl9uhgiYVdtSIdvna7YEvNHQPzlFVpHmhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608866; c=relaxed/simple;
	bh=FdGJsRQnVCQT4imaqZluNeyENZA8CanbqWoAso1o8W8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KrZy2JL7cVLDj3r8fmZF6wXYCtOBt9Lo4lfBD0Xu5wsojwt1Db7Q0JkGhVuTVh4zi4DD1GGsh/Lq1q6QuMsYLE75sVmM6o+9eOp9+OEATf+Uu1r2vSFlr+G9Dz3OBq4IK7RLMnz0XDpJ1aXhmHoTC7GA0arDEb0idN9J/5Zz1XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0ZVELQ9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=il5slJ83; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr9suflJxUZ3IKoVGoGbZ/lPblJ7Pk8+aEwGqtcySS0=;
	b=U0ZVELQ9O1I96hOKfp4Os4hQJBB1qCJAaEAfIS0/IcoEIRC/mzb35CGgeyzqvwXirSTjyA
	QYc8iJuDoNEUBDDuqzVinP1sw3vGSLshJqNbBIVHtQLXL8/jJdoReo/zd7nZ8Y+P0D7ufV
	1Q4wg4KuyDE9jfsCsF61NMmb7nhrtfdd2hi2T0psiW2RgOgV6dk/AK7Bi8utdG9qo0Kf5U
	opBrRY8+StoDPYOTriszHSXrOZU3MavmBpcwzmbvdut6GkjAfRq9fdW7gkKfrp/wdNpJsT
	PLkaf6/rcnQhuwlhiwVh5ZQgmVgMS1yPvpQphhRyvAFfueyi3j0jEj3BSc1Ynw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608862;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kr9suflJxUZ3IKoVGoGbZ/lPblJ7Pk8+aEwGqtcySS0=;
	b=il5slJ83h1llPzIRBSnF+d3OavDetFRIfFSzJBrMTDHYyPr4M1DoJBb2kR15x8qfWgKaqD
	dKeqZJhpWUSDgiAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/chip: Prepare for code reduction
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.682547546@linutronix.de>
References: <20250429065420.682547546@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886169.406.2265141124694933160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a6d8d0d12e1942a9403a0e79c87c161aa801d1a7
Gitweb:        https://git.kernel.org/tip/a6d8d0d12e1942a9403a0e79c87c161aa801d1a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:04 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:12 +02:00

genirq/chip: Prepare for code reduction

The interrupt flow handlers have similar patterns to decide whether to
handle an interrupt or not.

Provide common helper functions to allow removal of duplicated code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.682547546@linutronix.de


---
 kernel/irq/chip.c | 35 +++++++++++++++++++++++++++--------
 1 file changed, 27 insertions(+), 8 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 36cf1b0..4b4ce38 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -499,7 +499,7 @@ static bool irq_check_poll(struct irq_desc *desc)
 	return irq_wait_for_poll(desc);
 }
 
-static bool irq_may_run(struct irq_desc *desc)
+static bool irq_can_handle_pm(struct irq_desc *desc)
 {
 	unsigned int mask = IRQD_IRQ_INPROGRESS | IRQD_WAKEUP_ARMED;
 
@@ -524,6 +524,25 @@ static bool irq_may_run(struct irq_desc *desc)
 	return irq_check_poll(desc);
 }
 
+static inline bool irq_can_handle_actions(struct irq_desc *desc)
+{
+	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
+
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
+		desc->istate |= IRQS_PENDING;
+		return false;
+	}
+	return true;
+}
+
+static inline bool irq_can_handle(struct irq_desc *desc)
+{
+	if (!irq_can_handle_pm(desc))
+		return false;
+
+	return irq_can_handle_actions(desc);
+}
+
 /**
  *	handle_simple_irq - Simple and software-decoded IRQs.
  *	@desc:	the interrupt description structure for this irq
@@ -539,7 +558,7 @@ void handle_simple_irq(struct irq_desc *desc)
 {
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -574,7 +593,7 @@ void handle_untracked_irq(struct irq_desc *desc)
 {
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -630,7 +649,7 @@ void handle_level_irq(struct irq_desc *desc)
 	raw_spin_lock(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -695,7 +714,7 @@ void handle_fasteoi_irq(struct irq_desc *desc)
 	 * can arrive on the new CPU before the original CPU has completed
 	 * handling the previous one - it may need to be resent.
 	 */
-	if (!irq_may_run(desc)) {
+	if (!irq_can_handle_pm(desc)) {
 		if (irqd_needs_resend_when_in_progress(&desc->irq_data))
 			desc->istate |= IRQS_PENDING;
 		goto out;
@@ -790,7 +809,7 @@ void handle_edge_irq(struct irq_desc *desc)
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 
-	if (!irq_may_run(desc)) {
+	if (!irq_can_handle_pm(desc)) {
 		desc->istate |= IRQS_PENDING;
 		mask_ack_irq(desc);
 		goto out_unlock;
@@ -1166,7 +1185,7 @@ void handle_fasteoi_ack_irq(struct irq_desc *desc)
 
 	raw_spin_lock(&desc->lock);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
@@ -1218,7 +1237,7 @@ void handle_fasteoi_mask_irq(struct irq_desc *desc)
 	raw_spin_lock(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (!irq_may_run(desc))
+	if (!irq_can_handle_pm(desc))
 		goto out;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);

