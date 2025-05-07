Return-Path: <linux-tip-commits+bounces-5372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BC95AADABD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:07:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8CAC4E3A77
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF368231A55;
	Wed,  7 May 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="avx5x/mp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lBsqylXg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202292309B2;
	Wed,  7 May 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608844; cv=none; b=I/6A7cFt2G6I6ebRHUd86Tqz5LnPGAO98UQAOYljFBjR0sAWndwDUz+0o1USklVRMLOrRqOwAWTtIt4QtwKU3/HDo+0AGazGrGng9w5InLiOI02lhpvxmhqHdEGDx5SlpKefhWvfJHpvosDDgYJ3lWdS0qxHcvBvZx4fITbEChw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608844; c=relaxed/simple;
	bh=GK13TAsB8VvT1bhIWiQvl6dPDaCI+p++IrJGnZWPsjA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VIrf+nLKg4ZWhhe9X6nI7F5ImHuTL4Vnt3WvtDC0N7A6URq9DfpHdBBg2quvegjm8qy4rlsRC/j333wCZui+3+O4wh8Wrd0q1gFVdLc+JPQt0QD0eIk4ddt0QU4dqNK6aLVJJiQ5v8BTRNUS6DJpMkolxUHApp0gjlNLG2bLuto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=avx5x/mp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lBsqylXg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+IsVrSR5SZM1px4x5XOKa7zTqOVkc98CpYWsqIr8jY=;
	b=avx5x/mpJ5gKEYFcF4S3vapCCaP2Z1wNhKcBpbrJIWYTZqZehxtpfwzHyL4IgprI3byxUt
	RD4C1TkoRdFzZnVDugh+LXe89q+Jkif777Q/4MjWmNevVUj8kHLXkJcLVkoLFsr3TQTYMq
	n9cDD22O6LBsdSLoFbehDTy0USUSq/IrVygAyyFUEXLCwM8iiQsGdqyAW1y4/FCB5NtgQ5
	WXXqGvcUYiTmkmYWygIV9qgNVdF5rkXVN//kEoqONAwP2GTPXXfEY8D8iRbEPRGDxOS2CP
	lcJB378qky8O5Q8mjW071qVXfQ7NX5eQMvPanZKQoVWk/QIKVv7q0lB5crqisA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f+IsVrSR5SZM1px4x5XOKa7zTqOVkc98CpYWsqIr8jY=;
	b=lBsqylXgK7QJFmFI23UDPWDgmiADb3LnOMROa+AHQN42XkwDJNZZ/3ECa6KFjwZ3hEBeZx
	NxU/Hf7o5tp8YbBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework teardown_percpu_nmi()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.552884529@linutronix.de>
References: <20250429065422.552884529@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884054.406.16843173029528935949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5fec6d5cd24a35f5b03612dd02975e3be1b788b8
Gitweb:        https://git.kernel.org/tip/5fec6d5cd24a35f5b03612dd02975e3be1b788b8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:50 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:16 +02:00

genirq/manage: Rework teardown_percpu_nmi()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.552884529@linutronix.de


---
 kernel/irq/manage.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index c6472b1..fd5fcf3 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2634,22 +2634,13 @@ int prepare_percpu_nmi(unsigned int irq)
  */
 void teardown_percpu_nmi(unsigned int irq)
 {
-	unsigned long flags;
-	struct irq_desc *desc;
-
 	WARN_ON(preemptible());
 
-	desc = irq_get_desc_lock(irq, &flags,
-				 IRQ_GET_DESC_CHECK_PERCPU);
-	if (!desc)
-		return;
-
-	if (WARN_ON(!irq_is_nmi(desc)))
-		goto out;
-
-	irq_nmi_teardown(desc);
-out:
-	irq_put_desc_unlock(desc, flags);
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU) {
+		if (WARN_ON(!irq_is_nmi(scoped_irqdesc)))
+			return;
+		irq_nmi_teardown(scoped_irqdesc);
+	}
 }
 
 static int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which, bool *state)

