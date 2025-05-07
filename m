Return-Path: <linux-tip-commits+bounces-5353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00115AAD972
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:03:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F23201BC41D6
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F3F230270;
	Wed,  7 May 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rr/WU/CP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q6bs6Eb/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00EB221287;
	Wed,  7 May 2025 07:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604691; cv=none; b=X17paCiq6KfQW0NJPfbrOdsmVrs086g/bth3mKdieg5Zs9PIEEZh55jviymqCzJCn1RzKpxHnz1vcS9qvn0LYq5+bTqRsc93DQKZC/059u1uvYy28jcu4QzjQA8ThVARPDeuEo8YWIU8YqH1j9W453AQIxhkKql6RLKF9Yu6gHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604691; c=relaxed/simple;
	bh=H3GNoRkAoJdRz92SofN4cwkplkGxnGGTlEhMXLUXIoY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PGacc3BwYFzidrGn+rxVjbibTk80lqhO8TrF+fnI244CPGAAxnggHcTvJVrNJNklR4OGyPY/aGh2figFB63JTEHRKVkVvZ+qHTyeNlt+dfWvXJFJOf5Nt5LfI4DfJwVYSJIcKFJoKKbX/HvxsKkx9usiT69iw3sEXdnf8VWQPbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rr/WU/CP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q6bs6Eb/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Otax1LhBUlXZfinQAImZ5jCMkLZX30iK7jCRKnN65C4=;
	b=rr/WU/CPcZW0oOnfIhF1p1Y5c9EhzE6UmliUOMFvMcLForMLG9jGk1ZLcMacxL9ZV/NL5T
	nfsf6ln5WcQOOPGZwU9PS3iVUs+Of+I2UZdZKcbrz3Gs5E0t8uR/E/ctU9mCrg7dvxR+Jt
	zgiMK7hyavfkl7Lk/ZWLIfRGyECditXxxLCvSfASSYe8rcGOvCAhgWtoCxTnjdZl276G6o
	JsC2ifntTl5xHlm6E9GypJti+WkQS/pKY4zC43uRV/kLDNOyA55riVQ5Z7bWit4O87TsQW
	lBP7dhahkpbW5GKPCOFNSNG79Eb+p4OrkJiZdtk1LmcQvf0iUhsJ8zS/fHfFRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Otax1LhBUlXZfinQAImZ5jCMkLZX30iK7jCRKnN65C4=;
	b=q6bs6Eb/B6YL1+O/oRuNZREwMZa9jlFHIVXUPeuOkPCIwttiPL1oCwIYicjC5M+uVCigmb
	GAL1cEJAzHMNEiBg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] memory: omap-gpmc: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-24-jirislaby@kernel.org>
References: <20250319092951.37667-24-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660468716.406.15571309505739529351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     f83433cfaf96a75cc8a272ca67bbcb00752030ae
Gitweb:        https://git.kernel.org/tip/f83433cfaf96a75cc8a272ca67bbcb00752030ae
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:23 +02:00

memory: omap-gpmc: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-24-jirislaby@kernel.org

---
 drivers/memory/omap-gpmc.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/memory/omap-gpmc.c b/drivers/memory/omap-gpmc.c
index 53f1888..d5bf324 100644
--- a/drivers/memory/omap-gpmc.c
+++ b/drivers/memory/omap-gpmc.c
@@ -1455,10 +1455,8 @@ static int gpmc_setup_irq(struct gpmc_device *gpmc)
 	gpmc->irq_chip.irq_unmask = gpmc_irq_unmask;
 	gpmc->irq_chip.irq_set_type = gpmc_irq_set_type;
 
-	gpmc_irq_domain = irq_domain_add_linear(gpmc->dev->of_node,
-						gpmc->nirqs,
-						&gpmc_irq_domain_ops,
-						gpmc);
+	gpmc_irq_domain = irq_domain_create_linear(of_fwnode_handle(gpmc->dev->of_node),
+						   gpmc->nirqs, &gpmc_irq_domain_ops, gpmc);
 	if (!gpmc_irq_domain) {
 		dev_err(gpmc->dev, "IRQ domain add failed\n");
 		return -ENODEV;

