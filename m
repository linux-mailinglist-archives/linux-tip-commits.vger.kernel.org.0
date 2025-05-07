Return-Path: <linux-tip-commits+bounces-5335-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8884DAAD99A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A5C027ADADB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 07:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 345602253EA;
	Wed,  7 May 2025 07:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCuaGIVv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wwPYkruF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CA2223DDE;
	Wed,  7 May 2025 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604678; cv=none; b=iYYyTQI1mBF3RsTdll7tGk2Ujefov7OTr3lsbZ85TLAz+cOWb+er+sovSViuuwhaSifSva96OyMCzQlNbKsrz534XBzvKYtePpGeGv2eybkdozC6C3DCzwbVWWXQVRo6ng6qr7YkF6m8Fqkl96b9SkMzBM3wTaNoTjxdQktFMKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604678; c=relaxed/simple;
	bh=8zXoGqvxhWYbOjzi3UQyE1Sujmtgmhj4dAzLCDprXIE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BQDFUZdTshG+XIa78MT6IXV/OkLFe/Ph65wPsTflmk8+6kZFvbgX6Bd74eWXGdqTu3fsp4VqA1mQA7zCZ6dRg2dsEtDu0ZyzQN89CA7oCqpE64fUfqRY6Prbkpt4cWgXt5PIoKlSP3PsrjidsMqddSeNnogxTSirvcFXTKBBxcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OCuaGIVv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wwPYkruF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:57:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+caP9Gl7crFtXe0K77fGXw57Sew6HpDe55pQs1R3lsI=;
	b=OCuaGIVvQ2jvlVaSCAEU2DfaiZ5ryfpj1537LBd0YN8fRUfxw+cUcwHDYBdABAAR0+0dgb
	BEG+0Rv426sArXP0+ZnOilfS/191SXDuomy2zskKwNB67c+F85nHmwlo6IC2hEwkKsn4bp
	hpod5OLDWwbN+ZjZ9nQkEBVM70q2i3QrweEAjTNwuxSUBVn6ez1/XnAKa54Rf08jEnjqJ5
	LSVChfOjX3R2DgMsuMqsE7qVbBELgaLxr9SC9agFzJu6gudrpJTfDNf8fgGpyX7tssa9bC
	iiDj2oi1arfIAOtasxliHiJG26MaL6j8Q6jKetYPcN/RvvQL0ZeIHdDZh5TS+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+caP9Gl7crFtXe0K77fGXw57Sew6HpDe55pQs1R3lsI=;
	b=wwPYkruFTc4bxvGE7Eg+ezOs4xWofwy/CV/DJ5keap9ge5YGOc4m8spzlbXsvlksanQJiE
	uwVoe6B70mpH72Dw==
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
Message-ID: <174660467352.406.16866694495782458429.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     e5b0222f7e5d30ba52f4f3b6a85893d9d7d7af92
Gitweb:        https://git.kernel.org/tip/e5b0222f7e5d30ba52f4f3b6a85893d9d7d7af92
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:24 +02:00

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

