Return-Path: <linux-tip-commits+bounces-5374-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C4DAADAC0
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:08:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3895F1BC2888
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3202B233723;
	Wed,  7 May 2025 09:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KcKPZR+C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tl5TZHY/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7A0231A32;
	Wed,  7 May 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608846; cv=none; b=hRAxZqfeVgxpjtpuBGIyry4XzCyASJjFhNrAOhC6RjVKKUJ7qTtHWrjOHNLDYoXJfaWtleAWF/E9yRwkyz+gD4Eckiq1L2M0x51CLW4QyQ0CJ/eE1EWwS4FIRSFgmztiA5DAzyt9Erg4X786DjnCrPxu+t7WRDZNUcy5LTP8Ixc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608846; c=relaxed/simple;
	bh=VseXMh3+cLrW4Prn55JVaSUhZ8YQAfNN9hBEHxJu7Bg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=txLbs821igpeGTyC6hB/Z23Iv00sUtHNc7YTILlOPrU9UVqbtO5C624msHYJgv3rUcN5g9n95Fxd8nOevIFD2a81vO67FlvVpop1s04ECfOi/v2jeS1kDqadCUcIZp9BguMieEyK70V9FLunXtaOg8V/g/e6mPlTgqTXkX4ephI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KcKPZR+C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tl5TZHY/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cqw7SUnNplVgAuadVPxDz1yH6M3C1eULxIorz+X0koY=;
	b=KcKPZR+CfXlVsB/xUM4e88dfdVpK193pFRajiHM5L/Id8WPQGYILqCINnYIKex/Xf63Ece
	uFZR4zEGtlg5oRITRxDqKQHJzBcuXgRHuGvpmu0Mg8urDQBOqBKvvoePKWRBV6Bye5a7/m
	QI7yuVz0jfQ5+5WocIeOtHdOCqkcv8Q/q0tzjjwIaBx3uLk5YgLnmk7nmRdWJBmaHLdoi9
	yx1j0SijhdMO+wneEj0znHVTzgBg9WiYvIdqL3xVi4L5AcEphZYXARqozyGnYR+tsICpjg
	Df8/P+PAJ6EuHJ7r57JRLhpisETBmw8ayueFkxTeGD4B/lvVH5PZ3AKr6ApC6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608842;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Cqw7SUnNplVgAuadVPxDz1yH6M3C1eULxIorz+X0koY=;
	b=tl5TZHY/ZkzqZhGnQEXIThxAaqEbG30L13x+C7r8owVVTY2MMcDui8VBaq8Tjiflv9fOnX
	Vp1zrtKuhIe7ncDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework disable_percpu_irq()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.435932527@linutronix.de>
References: <20250429065422.435932527@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660884190.406.3211629336669672757.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8e3f672b1949d58462e23abdc41c039a82e685fd
Gitweb:        https://git.kernel.org/tip/8e3f672b1949d58462e23abdc41c039a82e685fd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:47 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:16 +02:00

genirq/manage: Rework disable_percpu_irq()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.435932527@linutronix.de


---
 kernel/irq/manage.c | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 3a491c7..a57e952 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2330,15 +2330,8 @@ EXPORT_SYMBOL_GPL(irq_percpu_is_enabled);
 
 void disable_percpu_irq(unsigned int irq)
 {
-	unsigned int cpu = smp_processor_id();
-	unsigned long flags;
-	struct irq_desc *desc = irq_get_desc_lock(irq, &flags, IRQ_GET_DESC_CHECK_PERCPU);
-
-	if (!desc)
-		return;
-
-	irq_percpu_disable(desc, cpu);
-	irq_put_desc_unlock(desc, flags);
+	scoped_irqdesc_get_and_lock(irq, IRQ_GET_DESC_CHECK_PERCPU)
+		irq_percpu_disable(scoped_irqdesc, smp_processor_id());
 }
 EXPORT_SYMBOL_GPL(disable_percpu_irq);
 

