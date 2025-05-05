Return-Path: <linux-tip-commits+bounces-5241-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEE6AA949F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 15:36:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 09C1F173894
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 May 2025 13:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D69191F74;
	Mon,  5 May 2025 13:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hKCTVi5Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="84OK2RdA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEF524C62;
	Mon,  5 May 2025 13:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746452181; cv=none; b=u46pkb1qCc0jTegLwbJrp3215HJvrG0x8sXhzZFw58AXH/2rZXO3zODxvYeLK0TpR403GYPYDSMXguPvgSQCg/zX0OQ6NOkNqOMBiZyi+RyfCHKMGvy/4GecKWClg/vo4lnn0VsAbJ7YhN7ZIe4kwVx/WsYeZlgp/rq5dln5p/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746452181; c=relaxed/simple;
	bh=uOJBODAAKPuFa4Z8nueJ1234uRbOUbVAkLthri4BfYY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KkNWpfC1D7tPJ+4tiZY8/s8gqVsEh1/z/y+iRb3mgJJY1ZYGb30sfuHWHJt6AOdlMiLmnjLVFm+I1IsGxYd0OvsuUQBKcLGoZEoC5xzk7BbaQWrwZCfiHA6a947WTOn1bWF04QIFijFmidls02bvNyE3QqLapeNsnVQ6LspmfcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hKCTVi5Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=84OK2RdA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 May 2025 13:36:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746452177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Bd2rSTkmVaU7j5jj/A5Uc+IFo+zPwqwgYaQTycNbHM=;
	b=hKCTVi5Q0N5KIMdDMzr/8yfZi0PFpKcktGAVsZO23Xy3MojgFjtbn5VeCVG0DtzZn2+PaY
	wq4lE0/ApOSrnf1zNh/S3ZmTaVCKSyStFGtsXeyppPkGPs+i7PO9L8j7Qx7WOfKFlP4Tsu
	aK5i5EFrVa4GfIypq/NGg4dOsy8UkEvviXJkg+rwQISHK3ZrwI8+MlZLIMiZUixrBtL/e5
	3b3n5xYZis28Vr10nhAZVdOSfMJwe3UbtNZM1Cll9mUIrmFRnGz3FwMPKTmOTY4lcT8Nbh
	szy2zFAhstEkHRpEjzv2MZpv2nUjr0k1koVASZ91PJmOfh9/HsqNNQ33LwT23Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746452177;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/Bd2rSTkmVaU7j5jj/A5Uc+IFo+zPwqwgYaQTycNbHM=;
	b=84OK2RdAATnKV2KeAWD1R6ErEz+/SCEIWnlMktgN5p2JXU2FGZCHLAxt1zxFhlNVxQCGzE
	Sby1dWwHy2y1J8Ag==
From: "tip-bot2 for Andy Shevchenko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdesc: Decrease indentation level in
 __irq_get_desc_lock()
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250416114122.2191820-2-andriy.shevchenko@linux.intel.com>
References: <20250416114122.2191820-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174645217211.22196.13632864206682410292.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e5032ead8599affac5d8b816ea3c9d63ebeec6b4
Gitweb:        https://git.kernel.org/tip/e5032ead8599affac5d8b816ea3c9d63ebeec6b4
Author:        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
AuthorDate:    Wed, 16 Apr 2025 14:40:33 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 May 2025 15:24:06 +02:00

genirq/irqdesc: Decrease indentation level in __irq_get_desc_lock()

There is a conditional that covers all the code for the entire function.
Invert it and decrease indentation level. This also helps for further
changes to be clearer and tidier.

[ tglx: Removed line breaks ]

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250416114122.2191820-2-andriy.shevchenko@linux.intel.com
---
 kernel/irq/irqdesc.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 4bcc6ff..5b3aee2 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -896,27 +896,27 @@ unsigned int irq_get_next_irq(unsigned int offset)
 	return irq_find_at_or_after(offset);
 }
 
-struct irq_desc *
-__irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
-		    unsigned int check)
+struct irq_desc *__irq_get_desc_lock(unsigned int irq, unsigned long *flags, bool bus,
+				     unsigned int check)
 {
-	struct irq_desc *desc = irq_to_desc(irq);
+	struct irq_desc *desc;
 
-	if (desc) {
-		if (check & _IRQ_DESC_CHECK) {
-			if ((check & _IRQ_DESC_PERCPU) &&
-			    !irq_settings_is_per_cpu_devid(desc))
-				return NULL;
-
-			if (!(check & _IRQ_DESC_PERCPU) &&
-			    irq_settings_is_per_cpu_devid(desc))
-				return NULL;
-		}
+	desc = irq_to_desc(irq);
+	if (!desc)
+		return NULL;
+
+	if (check & _IRQ_DESC_CHECK) {
+		if ((check & _IRQ_DESC_PERCPU) && !irq_settings_is_per_cpu_devid(desc))
+			return NULL;
 
-		if (bus)
-			chip_bus_lock(desc);
-		raw_spin_lock_irqsave(&desc->lock, *flags);
+		if (!(check & _IRQ_DESC_PERCPU) && irq_settings_is_per_cpu_devid(desc))
+			return NULL;
 	}
+
+	if (bus)
+		chip_bus_lock(desc);
+	raw_spin_lock_irqsave(&desc->lock, *flags);
+
 	return desc;
 }
 

