Return-Path: <linux-tip-commits+bounces-5619-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFEEAABA41E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:43:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D3602188EA91
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D615289831;
	Fri, 16 May 2025 19:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XZaCDF0+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EBAnsSTd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C226280011;
	Fri, 16 May 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424268; cv=none; b=MZyFy+yP9TNvuuzVvvtMeGdNWjHSjKXXdN/tO3iIQqKubApJBZlvOOIzgZRKurHS0sElg9hF4Qk5AUxDFvWovf2+fshvJ+zoHVDFWvM9kbHiHhCZ5ETpLFiKB0GuzTUPYlGaGYPVEDrIz3lcl3qXivQJDaa1DEb2msbZpXPUhvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424268; c=relaxed/simple;
	bh=oqXnf41YTqdJE15C3JHyjI8Bwql61nJSiR60XuXCrIw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cv8ZeGxALg99EKVXpuRy+k/Fp/i91oLp0lTY9ziX9M8Pm0Ene/iPXcrgOBZm4CzxemwGP3nM3bEriWJjyEIWNNKK+QEQ/xmWEqjmFHqP+4t5/s6g0oboRYMX6IMNEfXjfhoAZjG/e7L0YOZ3ihvryxzRyZv3qHAdLCzpsD0cwAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XZaCDF0+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EBAnsSTd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MbT/ls+pKwQASxjukDTEHirLxSzkZzQEuKEwSI+6so=;
	b=XZaCDF0+ufGoHVx8DycozJEvVybemAaXCxQDN55t87YIISfdLeHwzJ/uTxsMq5sg+uL/CA
	7r2JG3VqhGyN1naMccvk5OaMGQaQw8TrBnga6kMbn0jMKkKg1e/ge7TKZgDvk59smUb1h4
	mYbLRTt8DePB0h6qQK8K2KrhcfCPd8B2WeKmIjbQ9LsYZBJOtLX0kNuyjXYPe5PNEstTid
	r48M9UgnpfBVwbtayfM3INfP25dGdKOg3XaojvdsHO+p+bQpbFZNwD+OUhKpL+WGAzvYev
	LioJn2zMHodWFBSplnA0GXN+Js3KYYGBXJyMHDzHljW5YxFHd8jIEhgRr4JyvA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/MbT/ls+pKwQASxjukDTEHirLxSzkZzQEuKEwSI+6so=;
	b=EBAnsSTdI8yQNmFH+4TdPDTl+TFCIYI0ZyIvR036Fw/Pgcyar0HdJFlWcDTp/takpO9ZH9
	rZbti4YcFo5HCiAw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] EDAC/altera: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-17-jirislaby@kernel.org>
References: <20250319092951.37667-17-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742426347.406.10833310190101547010.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     6be00e43351e61ff9985d7a6fbd0c61414a26b57
Gitweb:        https://git.kernel.org/tip/6be00e43351e61ff9985d7a6fbd0c61414a26b57
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:09 +02:00

EDAC/altera: Switch to irq_domain_create_linear()

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
Link: https://lore.kernel.org/all/20250319092951.37667-17-jirislaby@kernel.org


---
 drivers/edac/altera_edac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/edac/altera_edac.c b/drivers/edac/altera_edac.c
index 3e971f9..47cea64 100644
--- a/drivers/edac/altera_edac.c
+++ b/drivers/edac/altera_edac.c
@@ -2130,8 +2130,8 @@ static int altr_edac_a10_probe(struct platform_device *pdev)
 	edac->irq_chip.name = pdev->dev.of_node->name;
 	edac->irq_chip.irq_mask = a10_eccmgr_irq_mask;
 	edac->irq_chip.irq_unmask = a10_eccmgr_irq_unmask;
-	edac->domain = irq_domain_add_linear(pdev->dev.of_node, 64,
-					     &a10_eccmgr_ic_ops, edac);
+	edac->domain = irq_domain_create_linear(of_fwnode_handle(pdev->dev.of_node),
+						64, &a10_eccmgr_ic_ops, edac);
 	if (!edac->domain) {
 		dev_err(&pdev->dev, "Error adding IRQ domain\n");
 		return -ENOMEM;

