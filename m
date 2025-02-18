Return-Path: <linux-tip-commits+bounces-3398-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88364A39688
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 10:09:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22011176105
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:04:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2527122D7BB;
	Tue, 18 Feb 2025 09:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BubPV88K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bSzjEyPJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F3BB22D4F0;
	Tue, 18 Feb 2025 09:03:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739869439; cv=none; b=bhjUnHOXPD1koOXqhn/GqsaDDcbjlEtTHPfWv6fu/BXvtGK2ShQwyja40UmwmJhnF7rC4CW6I+aTRS78Ek5QGL/qog4BVlr5R8VWjZUxO8NNmguswylvM5j8tP65cym1HCH+pjuy4EyAekZodtYmpxIcVm5dWtX+fEQoGXt9BEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739869439; c=relaxed/simple;
	bh=N2KeRYtp/cIiPIJp5NR4WJdPIy8ipfp3Jn4SgdCXUb0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YUNVw+1jXRg/i6SsSdnpqv5jha0iuWC4vxDfy3XtlR22QTULpyTRQBiXGizmRtD/uEGaszYKrGPuCDz/2DZBWVyUHh5cqa0OGG/ZzjcXc2Jd9VQoZtMI/YhmPwiOSwa+K/GcWVB1Q7tyK+uwqN3QsYqYSKeh6HN8MXothmVI/hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BubPV88K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bSzjEyPJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 09:03:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739869435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULI5gyTZ/Hxkjid/EGyckD8YhgblvPNJuNOO6f5Cexo=;
	b=BubPV88KWECEXsT/f0F+3KY5t1R80b6+YUuLZPefmtPujUtc+TEm/EyooQK3XDDUtHCZJL
	Rn8hxC/23kQmKoarV6V4ScdbeHn6aorWKGjN7t39urR2tsvSN1n6ynLrEkIJqEOxPhXwMX
	59PXNUxC58cKEvNw1BpRBlYkrnVDEWksgI9CQ0FKg15y8McvGjlP1Brj/nJNfzuOQWg+Sm
	mNyZvd47VGcikskJ77Cfxqa0FJwOV4dXowFdljAVTzQ185FLrPdpJFiSBjz7PtIC0U9j2u
	/VsxnRO6e9neyZXokVHvqSJblWLVmI1pD/tknzskgiRPNVNld6m9pBROtVj7eA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739869435;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ULI5gyTZ/Hxkjid/EGyckD8YhgblvPNJuNOO6f5Cexo=;
	b=bSzjEyPJkVtXR3GlEgTp3R0WZ/s1Q0Tc9OlWGI13vmBsiufVdixaJk5Yh/ZiYhJLRitL/K
	d1Phyb/Ly196rjBw==
From: "tip-bot2 for Anup Patel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] genirq: Introduce irq_can_move_in_process_context()
Cc: Anup Patel <apatel@ventanamicro.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250217085657.789309-6-apatel@ventanamicro.com>
References: <20250217085657.789309-6-apatel@ventanamicro.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986943528.10177.13292434775859832792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     01cbc389161fe5a679cc87cc8011a41342e94aaf
Gitweb:        https://git.kernel.org/tip/01cbc389161fe5a679cc87cc8011a41342e94aaf
Author:        Anup Patel <apatel@ventanamicro.com>
AuthorDate:    Mon, 17 Feb 2025 14:26:51 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:51:01 +01:00

genirq: Introduce irq_can_move_in_process_context()

Interrupt controller drivers which enable CONFIG_GENERIC_PENDING_IRQ
require to know whether an interrupt can be moved in process context or not
to decide whether they need to invoke the work around for non-atomic MSI
updates or not.

This information can be retrieved via irq_can_move_pcntxt(). That helper
requires access to the top-most interrupt domain data, but the driver which
requires this is usually further down in the hierarchy.

Introduce irq_can_move_in_process_context() which retrieves that
information from the top-most interrupt domain data.

[ tglx: Massaged change log ]

Signed-off-by: Anup Patel <apatel@ventanamicro.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250217085657.789309-6-apatel@ventanamicro.com
---
 include/linux/irq.h    |  2 ++
 kernel/irq/migration.c | 10 ++++++++++
 2 files changed, 12 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 56f6583..dd5df1e 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -615,6 +615,7 @@ extern int irq_affinity_online_cpu(unsigned int cpu);
 #endif
 
 #if defined(CONFIG_SMP) && defined(CONFIG_GENERIC_PENDING_IRQ)
+bool irq_can_move_in_process_context(struct irq_data *data);
 void __irq_move_irq(struct irq_data *data);
 static inline void irq_move_irq(struct irq_data *data)
 {
@@ -623,6 +624,7 @@ static inline void irq_move_irq(struct irq_data *data)
 }
 void irq_move_masked_irq(struct irq_data *data);
 #else
+static inline bool irq_can_move_in_process_context(struct irq_data *data) { return true; }
 static inline void irq_move_irq(struct irq_data *data) { }
 static inline void irq_move_masked_irq(struct irq_data *data) { }
 #endif
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index e110300..147cabb 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -127,3 +127,13 @@ void __irq_move_irq(struct irq_data *idata)
 	if (!masked)
 		idata->chip->irq_unmask(idata);
 }
+
+bool irq_can_move_in_process_context(struct irq_data *data)
+{
+	/*
+	 * Get the top level irq_data in the hierarchy, which is optimized
+	 * away when CONFIG_IRQ_DOMAIN_HIERARCHY is disabled.
+	 */
+	data = irq_desc_get_irq_data(irq_data_to_desc(data));
+	return irq_can_move_pcntxt(data);
+}

