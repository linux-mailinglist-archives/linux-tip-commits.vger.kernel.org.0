Return-Path: <linux-tip-commits+bounces-5378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A93EAADACA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:08:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B694E79A9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35A19236431;
	Wed,  7 May 2025 09:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1TIkkMwj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MIhtwhob"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A29B235341;
	Wed,  7 May 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608849; cv=none; b=adRfr8bfrewS+xkzpwYy+upeGTyXcw/90qwSk9nkoea5axCs2xqxDQQzNOFm/E6q3eXqZdDQnSiIaWWmSGFJyH7sKAafb0EijN0iFOfKRS2xH/9zCHvuX61yF5UjwLy5fdWQM7czKgxC2WlCLSepXQdY0fCRPw9X+5RF0XUcY34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608849; c=relaxed/simple;
	bh=Bp4r5V6yY5q251q39nmPu+a1omtSiaKYBcGyHJTC+wg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DxAB2n7zwfX5zR/hT2Ps6zCRuYojWrz/D5ID6ZDMJZKTK+SEdtclE6vDgk+HDMvCB3711PrOO8ikGH3fOSuPegEUvMF2FjVAR/ehpRgKEhYdCVIoF8pILY+/nIlutt4E430ir5PWlnxsFElSqTs9X3kTEBCks9iyNK5CGxS99Bs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1TIkkMwj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MIhtwhob; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gyxv+Ga1iGJRyztjAFRJf5b/iZvLfiaHYIE+3Y5ENR4=;
	b=1TIkkMwjJN/MULjYwkMCOgr1CQ9eFH/MD1XnIYQnK5vMzMoo9VhPabj1yvkpvqAHVbfxCQ
	+2YujYq7dYtfa/r19F794yclXTrtKZh3OcsCEhRLCIUdPiUv4qKhNKalGuviD3PE/XqFRI
	0dN1c669nVA+AykUx+RTriQxzVqctThJb/8709zGgh/0al5fMPjLNODfZ7F2dtDssNhePC
	2M8WA5iQYB+x2KGXnSqn2n3oWwmDxDBpAkpA7hQs+IkYMB+WquTdxHfm9L/ASbeelZNxe0
	AAPUj7vSQVZ9KiaB6DtYDSXz2Q5a3n7iDqeSVF84s9cG6UY6q6q/tbJ3ft1jVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608845;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Gyxv+Ga1iGJRyztjAFRJf5b/iZvLfiaHYIE+3Y5ENR4=;
	b=MIhtwhobxYL+7Oid+hx1kH84cztCVFAsTPrvieDDECMZ5+17U3DVZyIS5OsMw1xNbf67GP
	yNUBTOSyuCOgq4Aw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework can_request_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.187250840@linutronix.de>
References: <20250429065422.187250840@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884462.406.8078529252375155344.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a1ceb831417b8e23bd041d3e7021e235fa845128
Gitweb:        https://git.kernel.org/tip/a1ceb831417b8e23bd041d3e7021e235fa845128
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:15 +02:00

genirq/manage: Rework can_request_irq()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

Make the return value boolean to reflect it's meaning.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.187250840@linutronix.de


---
 include/linux/irq.h |  2 +-
 kernel/irq/manage.c | 21 ++++++++-------------
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index dd5df1e..df93b23 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -700,7 +700,7 @@ extern void note_interrupt(struct irq_desc *desc, irqreturn_t action_ret);
 extern int noirqdebug_setup(char *str);
 
 /* Checks whether the interrupt can be requested by request_irq(): */
-extern int can_request_irq(unsigned int irq, unsigned long irqflags);
+extern bool can_request_irq(unsigned int irq, unsigned long irqflags);
 
 /* Dummy irq-chip implementations: */
 extern struct irq_chip no_irq_chip;
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index d1ff1e8..b6f057a 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -888,22 +888,17 @@ EXPORT_SYMBOL(irq_set_irq_wake);
  * particular irq has been exclusively allocated or is available
  * for driver use.
  */
-int can_request_irq(unsigned int irq, unsigned long irqflags)
+bool can_request_irq(unsigned int irq, unsigned long irqflags)
 {
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, 0);
-	int canrequest = 0;
-
-	if (!desc)
-		return 0;
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_GLOBAL) {
+		struct irq_desc *desc = scoped_irqdesc;
 
-	if (irq_settings_can_request(desc)) {
-		if (!desc->action ||
-		    irqflags & desc->action->flags & IRQF_SHARED)
-			canrequest = 1;
+		if (irq_settings_can_request(desc)) {
+			if (!desc->action || irqflags & desc->action->flags & IRQF_SHARED)
+				return true;
+		}
 	}
-	irq_put_desc_unlock(desc, flags);
-	return canrequest;
+	return false;
 }
 
 int __irq_set_trigger(struct irq_desc *desc, unsigned long flags)

