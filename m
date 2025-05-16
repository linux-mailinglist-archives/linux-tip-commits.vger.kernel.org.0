Return-Path: <linux-tip-commits+bounces-5613-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA90ABA417
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:42:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71967504505
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:41:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4D88288537;
	Fri, 16 May 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAiBlTTk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TFaE9ynO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1149B2868A7;
	Fri, 16 May 2025 19:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424262; cv=none; b=la5woCXAxm9Z/qmiGE+GnChsqzqhIal3PmtlKsarTSAq4RooWWa4PE10I7uIE+ITDzQLVFUVJ+jc2HDQh6OdOekr9pCcHpCoVWM/WLrVbFWxJoHMm2FzCqP3jVA2occRUdz62HOGhkgJxMjieXOcWy2HF6bWXzjPXk5Az6ZMJpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424262; c=relaxed/simple;
	bh=ryRZ7vL0bSKDdyF8Ze6B9flcfr9QS61eqRsOawiT+jw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=txe7RFpSx16+JnaUo3rmklhEsmvgdtM2Kr5PaTmAomAvn9rscuFhvJXG6hP1Zs+DYZ8ubaGGE3y/eaJ7PqbBZPfxJnT0fn4AA+0Nc4SDM8G4onVTdPhTwbxDTOjfKrGKSvsJbijm2HiyShCIZ6yHW9Akocbb59rG7ui/OH4HbME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tAiBlTTk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TFaE9ynO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hth9fYLnIHqiL0MzhXJxOIfi5ZLTPfqy3vHq9yYrkU=;
	b=tAiBlTTkRy/OgcVKeeTYYAYsq2Bne7JOsALqwFCjayJ7jLgXdZbhB1lfp7Xczj1dUXViaa
	K+bRMZOE78a85cAJmSlqRwPqKO+fdJcql/EeY8uk2QKWWV7OR62i631tnIRzOFg8aFYUq7
	H4lX8HYMu+M+3FY2i1XiznP4dODpxcjFi56fD2ZZvfj7ZmP3pahEh4+3m+jJZjjgbsBaov
	o4DKkraMyq9azGJinUC18ztKVl4V5WHSWXznwiBTVGzdpOwIj1lJ/aezzaJDLoD2rrdGuw
	QG1b3/tepvQgGw+HORbygiZzMDRA8s1OE1H/ZhbG6hvT2Yc8lDyiSa7wRXc+KA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424259;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/hth9fYLnIHqiL0MzhXJxOIfi5ZLTPfqy3vHq9yYrkU=;
	b=TFaE9ynOhTYL0qwyDN3QSTeM6Yti+b4c+YQXuasZyJ1hch0XPRe1fatGYXbd77Hv1oaN77
	x764ULliPOi1atBw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] mailbox: qcom-ipcc: Switch to irq_domain_create_tree()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-23-jirislaby@kernel.org>
References: <20250319092951.37667-23-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742425874.406.14599028015022014870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     b9a7f080e72bb44fe04a4e877077213c854b914a
Gitweb:        https://git.kernel.org/tip/b9a7f080e72bb44fe04a4e877077213c854b914a
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:09 +02:00

mailbox: qcom-ipcc: Switch to irq_domain_create_tree()

irq_domain_add_tree() is going away as being obsolete now. Switch to
the preferred irq_domain_create_tree(). That differs in the first
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
Link: https://lore.kernel.org/all/20250319092951.37667-23-jirislaby@kernel.org



---
 drivers/mailbox/qcom-ipcc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 0b17a38..ea44ffb 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -312,8 +312,8 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
-	ipcc->irq_domain = irq_domain_add_tree(pdev->dev.of_node,
-					       &qcom_ipcc_irq_ops, ipcc);
+	ipcc->irq_domain = irq_domain_create_tree(of_fwnode_handle(pdev->dev.of_node),
+						  &qcom_ipcc_irq_ops, ipcc);
 	if (!ipcc->irq_domain)
 		return -ENOMEM;
 

