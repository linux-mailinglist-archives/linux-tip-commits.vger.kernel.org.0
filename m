Return-Path: <linux-tip-commits+bounces-5447-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B98EAAE13F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D96447BF938
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0A7228C2D4;
	Wed,  7 May 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aGNn12jc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHM9Zfmw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19228C030;
	Wed,  7 May 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625467; cv=none; b=exsOwzI0viMWssjWQMckw0zVRsJLEgWjyDvkdCYdjH/gRwn90NGkAaQQxqt//ezFVO0f9T24pxhp36xpY6t6vTbAOAOaHmOyC8v7fDYxMbjrDGfCe+H4fQbRrVwVuNCqsIAWoszZnUTCEad9TOEchYughCkniwvXg4dLGlDolYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625467; c=relaxed/simple;
	bh=O7Smy3Vk6cT3pgpifzU3pyffcSbnQRzPZ1gHVOZMmZc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mRfLMIAIekWYK6Eo8D6pATR9xmdze8lindWwEXV0C5BCYTJYi934VTWXN9SqQanMNsxrH53E2cUCw07muGSwZUh8SDgKkTWeb+kkmRU2RGMQaL0l4RwHsfz0p0OApxb9YrKcSXcUL16ArNRceQSTX8E3ToS7fFW8bUYK1G5/xBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aGNn12jc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHM9Zfmw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOOq1VaQAGEs0euZN8Nt+zV7Fb4qj5lroDV5w+Ywllg=;
	b=aGNn12jcXKq/Uh/Z0EM9SE7w50Ww3pxAkXzKuvrdV7oRSPAEm8nvFcMNyXHszWRJB0jyxA
	yeI/sOGYo8L3wgB/PFpGJ2UatujEGIiRgrFZL14sURNHAl4Qi1T75enc5zZggi14wluYeG
	Jj7V5BQ/CrVXcvvhmkmAe/SBvw8rxWFT+H5OVd+yZYspuabMogLolECbGOH+4wWRL/5BeD
	jvTnPEZJXkJH1/hAVS7iZliPfqyRFXzi4J+DdFR+WnbHfDgvyJ7m4PWeL2Lauy2aPnmzTs
	cMP8kmuYqkuDlvllfpEAM/HgAeuoZPsenb0XtIwtN8y5WoUVR5NYpbngeicZ9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625464;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OOOq1VaQAGEs0euZN8Nt+zV7Fb4qj5lroDV5w+Ywllg=;
	b=FHM9ZfmwRFrOuvxdDsxc6alYW8Lx41Zm/2/OlgFVh11127LktM5LzTpqZcXcMr9RNshlBv
	jXsmusQSv/90TWDA==
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
Message-ID: <174662546345.406.15165266149825143504.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     cecd821793e428d3bbd4a6e7f7e6980634c16539
Gitweb:        https://git.kernel.org/tip/cecd821793e428d3bbd4a6e7f7e6980634c16539
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:39 +02:00

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
 

