Return-Path: <linux-tip-commits+bounces-2319-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1427898DF80
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 17:44:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCCEA282782
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Oct 2024 15:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBE2D1D1307;
	Wed,  2 Oct 2024 15:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nD2Y6SWx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jNa3QQUx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9491D0F45;
	Wed,  2 Oct 2024 15:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727883825; cv=none; b=mgA5IZqNgPrRNapwWe1apmRwm8+PBukU6/9P6Igl2acrrLY1pvVqoL02rlE9fchUvePRtlwq1rAzTMm3x1xRn7AVKcRtaxUBZ476M54LZgI9Xo8cdGKcFus1qeCVnyKxArvh9HdY8d6awwnjdZAbDnM3nzdpvcylWbgUfFaSOkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727883825; c=relaxed/simple;
	bh=6XB4lb4RFLpE5a6+B5g8Fs52XpaNhhz0k3LKyxKIg4k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sgoUnxxW0ezDBZHZMQXgiLkeFqbjIc7KrhDOYI5uTAduvijLCexBrkOAqZA7Ptq0LZUFBFELL2Koq089xrjy3nL1chmhlpqJHrIm8ngEQpYBEhiClnknMb1xqBxxRKVZTZoLq2y6WUf+HXWCw1ik1DOThGMC6vRONTC13/+pELQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nD2Y6SWx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jNa3QQUx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 02 Oct 2024 15:43:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727883821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8Ut3Em3PIIbiVW5S9YOAMX/zV7GUK+KUPupBG8cwso=;
	b=nD2Y6SWxrPPmw3R/7Qxv7trIWgUuJPdyxYVDTXqRhkG0zl33nqA4lm6crygQtvAwFN+2Eu
	eMPKk004XyPdq+65lSTf6HFRfm3e4yn1yHSZYphSSgGcRRwFp3oqNtX/05BeiRXmX1ceTO
	H9qiko1U9q4SWmctuzlNlcjPmd3bbuAtKbmXJSlRKYAr6+O1J87TdW69HG0VA0Qd8w0W4Z
	t/95sxM2Pe5fxbwTfj+Nd7CkNEEmkKJDfSZME2i+UJPYd+dzNZTK6+zjsVFitHk3q5PISi
	Qnp9SOX6KlQ6wT9wyUMZykeWCHHLKRy+O7yvuxanlAipJ2u6Brj/AX9Hex5Sbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727883821;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Q8Ut3Em3PIIbiVW5S9YOAMX/zV7GUK+KUPupBG8cwso=;
	b=jNa3QQUxKo8uZ0jqDaHOEg8a9Q556xznlDsFXHLrywI7r8UBVblqKOWBEMRWqHkRicL9dm
	ASINhW4x89qqJODA==
From: "tip-bot2 for Sergey Matsievskiy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/urgent] irqchip/ocelot: Comment sticky register clearing code
Cc: Sergey Matsievskiy <matsievskiysv@gmail.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240925184416.54204-3-matsievskiysv@gmail.com>
References: <20240925184416.54204-3-matsievskiysv@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172788382045.1442.5590525664628051613.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     7f1f78b903c933617cbd352f9eafe9e3644f3b92
Gitweb:        https://git.kernel.org/tip/7f1f78b903c933617cbd352f9eafe9e3644f3b92
Author:        Sergey Matsievskiy <matsievskiysv@gmail.com>
AuthorDate:    Wed, 25 Sep 2024 21:44:16 +03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Oct 2024 15:11:07 +02:00

irqchip/ocelot: Comment sticky register clearing code

Add comment to the sticky register clearing code.

Signed-off-by: Sergey Matsievskiy <matsievskiysv@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240925184416.54204-3-matsievskiysv@gmail.com

---
 drivers/irqchip/irq-mscc-ocelot.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index c19ab37..3dc745b 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -84,6 +84,12 @@ static void ocelot_irq_unmask(struct irq_data *data)
 	u32 val;
 
 	irq_gc_lock(gc);
+	/*
+	 * Clear sticky bits for edge mode interrupts.
+	 * Serval has only one trigger register replication, but the adjacent
+	 * register is always read as zero, so there's no need to handle this
+	 * case separately.
+	 */
 	val = irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 0)) |
 		irq_reg_readl(gc, ICPU_CFG_INTR_INTR_TRIGGER(p, 1));
 	if (!(val & mask))

