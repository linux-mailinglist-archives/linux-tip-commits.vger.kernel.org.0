Return-Path: <linux-tip-commits+bounces-5411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFD7AADB0B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 08A4A7B8C60
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:13:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8097253923;
	Wed,  7 May 2025 09:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rbkJGiS/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FANItMEU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796952505AC;
	Wed,  7 May 2025 09:07:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608871; cv=none; b=ULWFhLQfgqPXAxYrJo8o5Xhs7XJupJ0q8c+mNSfIpwl7HDWnuzeZyCxHRHoUoCZILkpCBgaVHuxHVodt/CLEEs9tGLSoFtCM340ZK0d5IJnvs0n218W/ouaMY5GRrEA8kmsvuZ+W42iVy5voF63hBuVJaFA2AgLbBfTjfzuZtTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608871; c=relaxed/simple;
	bh=dQQC7XKTFKFyPRaHrPKEAxr4h1+5KAku0jMVZOW+4Mw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QsIOFEQm1S5+BfwNg7IyyGH79/tGt34frjeXENLid+E8ttrsnAQKyUnLhVAyLdDQGz07eMNHQoRZ03N7qnGHHr4TLXx69LdFKb1lTZjZ4vxDqwz+FR6/D54lt5+wnSAI3ALSHAnY/UOLoLnqIpexlPNX7dNYc2u1NgI/y8rR40A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rbkJGiS/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FANItMEU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwXOkP+ejpf7ZsW/MaM097ZPBs+igHNpksMhpsID03Q=;
	b=rbkJGiS/VJ192d0zzVHQgYTIxRM1ReP7Wt1LpuKqjyLL/WKVUvBU/5uq0VKZkNr2QNolMn
	JA8tlP2QqP/b+pVIfRWb7absbO1lcXr/J/bKDMucojtkAhTYXqinZ7yS34UD3hqdmyTy8R
	k2XgGMnxA9l4fEojInwAmDZJmNqKGlEWWbZiL5L7/ZoTYb+3YedO/yrjcDuet0K8+Uny8x
	J2oQtwXCRpVySWmradODzbu7GL8SzD4erxunBQGRmo0IuCVg+OBjm8VnVEeKLjUW8EaDoh
	/ETUjyusQ9oA4UJliHUL/LBRkJirduwGgh3ru8Q7Inxhxt+kAuzWk53p6ysATQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608867;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NwXOkP+ejpf7ZsW/MaM097ZPBs+igHNpksMhpsID03Q=;
	b=FANItMEUHIWf/Woennc0I8idckQeXOd2hAkTv5990oiZnmAzXaTXPN9E+zmEBwiSduKY3l
	TE/igUJvo1VWoYDQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/autoprobe: Switch to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065420.188866381@linutronix.de>
References: <20250429065420.188866381@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660886707.406.9801059554818258345.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e80618b27a008839e3b61c1efa0b915b155f2a8d
Gitweb:        https://git.kernel.org/tip/e80618b27a008839e3b61c1efa0b915b155f2a8d
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:54:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:11 +02:00

genirq/autoprobe: Switch to lock guards

Convert all lock/unlock pairs to guards.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065420.188866381@linutronix.de


---
 kernel/irq/autoprobe.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/kernel/irq/autoprobe.c b/kernel/irq/autoprobe.c
index ae60cae..d0af8a8 100644
--- a/kernel/irq/autoprobe.c
+++ b/kernel/irq/autoprobe.c
@@ -43,18 +43,16 @@ unsigned long probe_irq_on(void)
 	 * flush such a longstanding irq before considering it as spurious.
 	 */
 	for_each_irq_desc_reverse(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			/*
 			 * Some chips need to know about probing in
 			 * progress:
 			 */
 			if (desc->irq_data.chip->irq_set_type)
-				desc->irq_data.chip->irq_set_type(&desc->irq_data,
-							 IRQ_TYPE_PROBE);
+				desc->irq_data.chip->irq_set_type(&desc->irq_data, IRQ_TYPE_PROBE);
 			irq_activate_and_startup(desc, IRQ_NORESEND);
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 
 	/* Wait for longstanding interrupts to trigger. */
@@ -66,13 +64,12 @@ unsigned long probe_irq_on(void)
 	 * happened in the previous stage, it may have masked itself)
 	 */
 	for_each_irq_desc_reverse(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (!desc->action && irq_settings_can_probe(desc)) {
 			desc->istate |= IRQS_AUTODETECT | IRQS_WAITING;
 			if (irq_activate_and_startup(desc, IRQ_NORESEND))
 				desc->istate |= IRQS_PENDING;
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 
 	/*
@@ -84,18 +81,16 @@ unsigned long probe_irq_on(void)
 	 * Now filter out any obviously spurious interrupts
 	 */
 	for_each_irq_desc(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
-
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (desc->istate & IRQS_AUTODETECT) {
 			/* It triggered already - consider it spurious. */
 			if (!(desc->istate & IRQS_WAITING)) {
 				desc->istate &= ~IRQS_AUTODETECT;
 				irq_shutdown_and_deactivate(desc);
-			} else
-				if (i < 32)
-					mask |= 1 << i;
+			} else if (i < 32) {
+				mask |= 1 << i;
+			}
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 
 	return mask;
@@ -121,7 +116,7 @@ unsigned int probe_irq_mask(unsigned long val)
 	int i;
 
 	for_each_irq_desc(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (desc->istate & IRQS_AUTODETECT) {
 			if (i < 16 && !(desc->istate & IRQS_WAITING))
 				mask |= 1 << i;
@@ -129,7 +124,6 @@ unsigned int probe_irq_mask(unsigned long val)
 			desc->istate &= ~IRQS_AUTODETECT;
 			irq_shutdown_and_deactivate(desc);
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 	mutex_unlock(&probing_active);
 
@@ -160,8 +154,7 @@ int probe_irq_off(unsigned long val)
 	struct irq_desc *desc;
 
 	for_each_irq_desc(i, desc) {
-		raw_spin_lock_irq(&desc->lock);
-
+		guard(raw_spinlock_irq)(&desc->lock);
 		if (desc->istate & IRQS_AUTODETECT) {
 			if (!(desc->istate & IRQS_WAITING)) {
 				if (!nr_of_irqs)
@@ -171,7 +164,6 @@ int probe_irq_off(unsigned long val)
 			desc->istate &= ~IRQS_AUTODETECT;
 			irq_shutdown_and_deactivate(desc);
 		}
-		raw_spin_unlock_irq(&desc->lock);
 	}
 	mutex_unlock(&probing_active);
 

