Return-Path: <linux-tip-commits+bounces-5612-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7621AABA412
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:42:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A7B81896C07
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D294288522;
	Fri, 16 May 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="D/mpMwfv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Gq3IgL6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 967962868A8;
	Fri, 16 May 2025 19:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424262; cv=none; b=Evx3ixa26BePgXHD4g3qx5GKYxibRiRkDjhMWRO/KrJcgDCnBHl2JX8gDB6hU3yKqE3l48g3OZ7GCWbscM5ngKWsxNKDWaNsW7XMwwetdukosIN1yJCpxtkXLBpWjY4NvfLvAjYTU1hb4IzdWuXM1K6xfgG0xaDYSbRdGCsh02M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424262; c=relaxed/simple;
	bh=Fm8c5NYzq8vqnxL8rFX3cv0ZnNTRI0uj6ImksI5Nlms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tD/tqeW+OXVub/lTlChUdAC+Gka94U6+i9RXvuQKVp3haD5adfsdlzLJfPQk2j2KAiJMDcBhEByHMsgtRJCnn0jKfrdv6lxBio06NJd9ukaSnUM/qoJAsW6Y7PaCkzeeLKw/mT9norjd2X0ofMjUOjyt1Cm1oaD8tPQRZ8Y9vNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=D/mpMwfv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Gq3IgL6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV8PqvXwVDdCxscxqNYzzN242pse0zIcKMhYWsVrBVM=;
	b=D/mpMwfvUHDHV8wctKug9IwyvTaJabfo0tJDburKpSAVy/mRtiEwauEjPcinZ60tj1XRKG
	S8QcTlvedE6kvOrklZvlJKRkSvD9zQUBBIEpsxbKybFgzU7mSmwT4FSRaTqe9tJ816PSqI
	TzLn4cD/XI5ogqV3fU2IJVZL0EWvpka/yd3apAGAAekcNu1MWCP0E/1x1WoCHcrAMsm9qZ
	fpLt9FkshDH3+zcW+YatvFwdZMl9HmDj188wEKADhfTyoZ6ColZKd/zM4dH2ACro4KPWXf
	bYwAO7HQexj788nREWWuakODfAK7apW8FV/gazPJRgYLR/6UvTx+YXET6VSVSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424258;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tV8PqvXwVDdCxscxqNYzzN242pse0zIcKMhYWsVrBVM=;
	b=1Gq3IgL6ocUV+UOHeKVAJI4i0ZhsaLWcwtj+0UKJbymeVraJDH6iJpraHA2IycNNIRhTGF
	cbJAc3GCXyYZQuCQ==
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
Message-ID: <174742425798.406.16155397487700389607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     8529e33bfe98f613dbb6f8e9ad6b94b501b36c98
Gitweb:        https://git.kernel.org/tip/8529e33bfe98f613dbb6f8e9ad6b94b501b36c98
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:10 +02:00

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

