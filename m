Return-Path: <linux-tip-commits+bounces-3266-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B99B1A13521
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 09:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 574C77A037C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Jan 2025 08:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 394B0194C75;
	Thu, 16 Jan 2025 08:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ldwt/mgw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6zYHAZ5L"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07B3148314;
	Thu, 16 Jan 2025 08:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737015453; cv=none; b=tPf0d6HcKNQ9QkSkDXgUZ32l7GU/EUjHsvphcZsTkMiqJcvNZ4HDpyA4az03voI056Gunwev7QC4ElnwOdmQCwR2/IkT3XnOcsFrnL0WIibZ2YlSFM/AcdhAvlCCmPSq/SyxPNyc61N1b89b9R+Qxfw/gTBo3lFseXD/38I4FKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737015453; c=relaxed/simple;
	bh=q4rN83L2OCeSApcBBE7XwcoO4y4EnalMK7WBQMKZaMA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b8joa1HrLjdvVDcG7XZSmubhhgCq38Vzv3Qj3K4mL3mj7jiqxIrk1FOPC33mI25lgzuuWxai6g8YGQWI8MkVHRdVbtmKRIa8jWV1S0X9HbyDxUdpLDXy3y9o8GxFAIvVKUEAbDyQ8Rpp/vQA0TZdzj+xqbEE5y0AesCI4YbE07I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ldwt/mgw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6zYHAZ5L; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Jan 2025 08:17:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737015449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jbwcl6he1xtA7HSBUEE4isZFN0BucyEmpZkb8CNJZi4=;
	b=Ldwt/mgwFRQYcnuRHnkmkUcfXMEcCYBSjWgB5ifNK9LW92kxsrqyOvexGpQK4o18qfAr+f
	6HOhMryotjLd+1UWsPkwTZJyWYyFQ8wImjgWMBJADuRpDuKRH+pd57sVPr4JEiCkeedPj3
	iFqHjsqr9M8qbvQkwFxe6eO4jBEYZvNKfm9A+9vhY1hQqgI6bO2vG1d3A0/y0aRtnR6ess
	JgZ/AkCubhFY9gxLBRo/6m6Eqk73b+k6a8WoHw3EXDwlGEBuTF05IMU+FTNLN4aG7buvmQ
	UUVrqV5tEXZbZX4Ug0vQ+Njg16sNtstojAQ1piTSOj0jl8/662r42+GAIP9F9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737015449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jbwcl6he1xtA7HSBUEE4isZFN0BucyEmpZkb8CNJZi4=;
	b=6zYHAZ5LDfon7ALNp4k6+r02u8KwEtPXi/VmZNuiRfixVwigwlxzNEa8XzPUtJNedkVaHX
	26y55rNRiBqWXwBA==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/generic_chip: Export irq_gc_mask_disable_and_ack_set()
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250116005920.626822-1-linux@treblig.org>
References: <20250116005920.626822-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173701544816.31546.9902237848481107658.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a4b3990e01df169334ff2695d2fe494eda63a297
Gitweb:        https://git.kernel.org/tip/a4b3990e01df169334ff2695d2fe494eda63a297
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Thu, 16 Jan 2025 00:59:20 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Jan 2025 09:10:17 +01:00

genirq/generic_chip: Export irq_gc_mask_disable_and_ack_set()

The recent conversion of brcmstb_l2_mask_and_ack() to
irq_gc_mask_disable_and_ack_set() missed that the driver can be built as a
module, but the generic function is not exported.

Add the missing export.

[ tglx: Converted it to a fix ]

Fixes: dd1f17a9faf5 ("irqchip/irq-brcmstb-l2: Replace brcmstb_l2_mask_and_ack() by generic function")
Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250116005920.626822-1-linux@treblig.org
---
 kernel/irq/generic-chip.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 32ffcbb..c4a8bca 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -162,6 +162,7 @@ void irq_gc_mask_disable_and_ack_set(struct irq_data *d)
 	irq_reg_writel(gc, mask, ct->regs.ack);
 	irq_gc_unlock(gc);
 }
+EXPORT_SYMBOL_GPL(irq_gc_mask_disable_and_ack_set);
 
 /**
  * irq_gc_eoi - EOI interrupt

