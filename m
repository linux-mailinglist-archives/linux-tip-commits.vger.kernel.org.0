Return-Path: <linux-tip-commits+bounces-5278-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C5F7DAAC5C3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:22:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0B1C1BA2B07
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D380D283691;
	Tue,  6 May 2025 13:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NQfskCNu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LXjErX5U"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB475280003;
	Tue,  6 May 2025 13:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537624; cv=none; b=F3yas5L+WFbjJP5f/nhZSYBbuMAN6xRoZloF379ioGtcV/e+w5IaDx4VVrw9dByHUbzt0lG4ukC2Op5OYfyZfZbbq4e9lKpi0KPFpLtilTJR7EOM+z5riIz8MTmnb/Zxltg1Fu4CmGiFO8okSIEP6Ojyj2IDNurgrt2kHwvILFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537624; c=relaxed/simple;
	bh=9BQnlG9r7L8LlF/nWLcrF3KnHo7h9v/Ly4jpwcE20y4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WeXgg4/GPPWZUyHp8jgTj73MhAfZ8vOP1NX7AYrWLgJsVF5ZcsC3SXF5GxpM8qAhIhE1JytZ9hOlf85TrrnA0Qf5xYQdagJJfA2BnDhN/VSDBxxCmt9g+AHRqYkuGrCR50nb+YDZmTCLpmfmGzVRtyS4AA+6lkBhl1GgNn/6kFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NQfskCNu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LXjErX5U; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDykFev4WBmezQvT5u5hRV+rxU1xyc4pp6N2QyGl1gI=;
	b=NQfskCNujP/AUyM+UyrbaoaIU0lhJOk6C79+rPKIMp89Q2VZP06zx4r8aRZeNCuJCcSd+O
	51Ms4C6fe/YW6yy+RJA/w2So/O672AXmEdUllv6vwHWyxY6v2n4c93ggSBNjBA3ZDuJyri
	1GefPoriLj2Mm8DPK2wAHkBT//Q5xudQSGvPlBCtqXqh30dAW5IRkenPr8XoAh7TDnYpzy
	4VP9KEjBYolYTanYFtPb/yValTXtXgTauHidip1yiR7gfgyGaabcFmQqefrk5cfzLRq0T3
	N0sa1aQAbQgyWtXUbVJR/S6SEmnbTScZev2Mn3zLnaDM3Gb+EekWQUwH7/FSIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537620;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DDykFev4WBmezQvT5u5hRV+rxU1xyc4pp6N2QyGl1gI=;
	b=LXjErX5UqA8ISQ7aacP2uPZeohFZXGrWm8fPUZD3KjtdD0u2ePsrfvpMA228D8N55+qGbi
	GzsqTlZsXjzlafDQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] irqchip/armada-370-xp: Switch to irq_find_mapping()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-47-jirislaby@kernel.org>
References: <20250319092951.37667-47-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653762010.406.2387950127198118151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     cfe07876012ce9c50d646286a60698f4bc210f2d
Gitweb:        https://git.kernel.org/tip/cfe07876012ce9c50d646286a60698f4bc210f2d
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:08 +02:00

irqchip/armada-370-xp: Switch to irq_find_mapping()

irq_linear_revmap() is deprecated, so remove all its uses and supersede
them by an identical call to irq_find_mapping().

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-47-jirislaby@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index e516129..67b672a 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -546,7 +546,7 @@ static void mpic_reenable_percpu(struct mpic *mpic)
 {
 	/* Re-enable per-CPU interrupts that were enabled before suspend */
 	for (irq_hw_number_t i = 0; i < MPIC_PER_CPU_IRQS_NR; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq || !irq_percpu_is_enabled(virq))
@@ -740,7 +740,7 @@ static void mpic_resume(void)
 
 	/* Re-enable interrupts */
 	for (irq_hw_number_t i = 0; i < mpic->domain->hwirq_max; i++) {
-		unsigned int virq = irq_linear_revmap(mpic->domain, i);
+		unsigned int virq = irq_find_mapping(mpic->domain, i);
 		struct irq_data *d;
 
 		if (!virq)

