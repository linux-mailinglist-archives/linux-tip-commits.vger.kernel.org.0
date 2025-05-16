Return-Path: <linux-tip-commits+bounces-5570-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 84166AB999A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 12:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF5A4189C73D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 10:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 698D622F38E;
	Fri, 16 May 2025 10:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0hEYGTWJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b7toz3Rt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B689A381C4;
	Fri, 16 May 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747389740; cv=none; b=QI9WMCqj2r7PD2MhwNe25iKxMolE0+JoLLlH3XMB/DJpQ7rS4b+bbQlb1L5hEB5DL7exJ7gEP8MfDSF+Iy1DH9aMSVYYmDgsg8YH1/1PXQG3SPLrWAXP2IZ7BJizTiFPqXyiyUFNenywtwzDoRU3ppiX5ySRpdSx/sDw2aOiIBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747389740; c=relaxed/simple;
	bh=Zo0mLYI7PTasv5NS4tt2CBRcfHw3mgF8eIsR/STkXhc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qbrISeZcXXAnxwU4G5Nqmb/RpesV8K4bA5NeUF5rmp9IBQw2BWnfsL63dNRjlZNiWp/JvuXhhyCaQg/AqpYC70ERwjBG3ha9u65CFALeHQBxwkImH6NbAQDSZsFfsnILIxgH+QZD0Y6+zRKkl3xR9uCHsBavaTlNzFhnoW8L8yg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0hEYGTWJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b7toz3Rt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 10:02:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747389736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVdEFOPePVWP+XNE68ekxQwWLaXcQrvLw9VJVNSpv9w=;
	b=0hEYGTWJ/6G7vDoTnzT5xU0diyLrGGKNtrizQJT2TnlDWErP49qzL2A7v3RiINs8sDAw1a
	Apy0jWAxc5BnDcYSyoSH78pNWs0KIhSqtjFedK/C4tsTIsH7KCT5pBV98iCSJcofsCUMk7
	+FgpN8nJ14tzEqf2bm12TgguMYZrZKNlPlDzcxTAL/MDfwBfw39HJGGW2EaGri9RMDGzz8
	Ctm1yFgTLJIG2xSR6S0mlb6eztM1uQEz0GZWzq6bE8LN6E2jJ78a/03HQUmgsF0i9ewHXM
	hr9hoUx8GqsN38jmdRUMUv6w0UG5evYYobT7IftktsA00LOVJxQKP4ObDdFndw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747389736;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gVdEFOPePVWP+XNE68ekxQwWLaXcQrvLw9VJVNSpv9w=;
	b=b7toz3Rt9PTp8kgOlY6ff/01ske56Fju00x2K8+D3XEj+QawwpdJyZCgIr9tCeYkdXQ3gV
	CO7FaBN24t6w/FAg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/gic-v3-its: Use allocation size from the prepare call
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513163144.2215824-6-maz@kernel.org>
References: <20250513163144.2215824-6-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174738973542.406.15298612282594894247.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7dd20bf2f010430b75b109e4d4101cd1616afba3
Gitweb:        https://git.kernel.org/tip/7dd20bf2f010430b75b109e4d4101cd1616afba3
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 17:31:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 14 May 2025 12:36:42 +02:00

irqchip/gic-v3-its: Use allocation size from the prepare call

Now that .msi_prepare() gets called at the right time and not
with semi-random parameters, remove the ugly hack that tried
to fix up the number of allocated vectors.

It is now correct by construction.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513163144.2215824-6-maz@kernel.org

---
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 9587366..6a5f64f 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -68,17 +68,6 @@ static int its_pci_msi_prepare(struct irq_domain *domain, struct device *dev,
 	info->scratchpad[0].ul = pci_msi_domain_get_msi_rid(domain->parent, pdev);
 
 	/*
-	 * @domain->msi_domain_info->hwsize contains the size of the
-	 * MSI[-X] domain, but vector allocation happens one by one. This
-	 * needs some thought when MSI comes into play as the size of MSI
-	 * might be unknown at domain creation time and therefore set to
-	 * MSI_MAX_INDEX.
-	 */
-	msi_info = msi_get_domain_info(domain);
-	if (msi_info->hwsize > nvec)
-		nvec = msi_info->hwsize;
-
-	/*
 	 * Always allocate a power of 2, and special case device 0 for
 	 * broken systems where the DevID is not wired (and all devices
 	 * appear as DevID 0). For that reason, we generously allocate a
@@ -151,14 +140,6 @@ static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 	/* ITS specific DeviceID, as the core ITS ignores dev. */
 	info->scratchpad[0].ul = dev_id;
 
-	/*
-	 * @domain->msi_domain_info->hwsize contains the size of the device
-	 * domain, but vector allocation happens one by one.
-	 */
-	msi_info = msi_get_domain_info(domain);
-	if (msi_info->hwsize > nvec)
-		nvec = msi_info->hwsize;
-
 	/* Allocate at least 32 MSIs, and always as a power of 2 */
 	nvec = max_t(int, 32, roundup_pow_of_two(nvec));
 

