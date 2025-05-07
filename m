Return-Path: <linux-tip-commits+bounces-5443-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D45AAE130
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753A017B52C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3197C72620;
	Wed,  7 May 2025 13:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TWFKCh4M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KzbcfdTy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F39428BA88;
	Wed,  7 May 2025 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625465; cv=none; b=X3GBBfpGea41CwylFdxhMcstbFDZiyA0kcCMkqITcR0GK/qCMowPfIumeeVPTE7qAPOTySRSpRj5MAH1TReALy6aoDbQXnnEJ6L2wmpntl348kmTjQ6GyfkC7zyi/R6IrKN5l7sD/wXknQMXeEqPtbMu4HWsFEWkUeQljdiUMVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625465; c=relaxed/simple;
	bh=MfV4KPpzEb/KhXvHOv0vUkgN1XpZEQJIlIQl6wzOVwE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V7VZIAJpJrDFv4rXtkVf0hdhJZX2rNvRI7U4OkTGTuYczRybAfpDcWhRSQrMqVgj1okOCOgG+pWILnz0EQCGAf0RQoQfU+9sK7W4m93wXeK3eQWxetgZ/16VYH11J5GfE+jVCnF+iQMI+voYiswDQJPOqdhPUVyyzieVEnRljSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TWFKCh4M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KzbcfdTy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmLO1Y0HligdquhY4Yl7zT0kI+ngaT42a5x5cPYVKwc=;
	b=TWFKCh4MCh5wPZ6zFxDVDhUPT/aJJFvLWhxCo+/brSfL0v7x4m2qy9eiYnf4xMQqRLByzB
	mBAAzHRo8EU5/woEQFp6FiMt0D1NDiFg5C+2hp42Hnmzfy6Vp+LI6N+rUcHHVWOfeitSLF
	82eusPcEkIe4b35lVxKTcz46L3mGe6aMhivdKZbTLcawVV9f4H1+T6eiVEctvgY9C3hhlf
	oQc6WrrIHau0X3lHRJD6JrE/Tx34oLLDAdxs2NwLgf5ECvulFOaLffyAEUJWLSzFQt4AIH
	Yt+RZ3rPvTJirmrDWNoDxTTVZ/gLsd5yxADr1AwecClLNWFqL4DVm2UeHy9fpg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625461;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kmLO1Y0HligdquhY4Yl7zT0kI+ngaT42a5x5cPYVKwc=;
	b=KzbcfdTyWuo7X2pXz3sb6kVzZicxRlfXgGM4F31F+z7pjM05wIPqKz+hSbPvB5qG2bzk0E
	2/i7L3AKTx/6BXAg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] misc: hi6421-spmi-pmic: Switch to
 irq_domain_create_simple()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-27-jirislaby@kernel.org>
References: <20250319092951.37667-27-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662546064.406.10574880489465225971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     357f043f36b179e80dbbed3654a8098342589734
Gitweb:        https://git.kernel.org/tip/357f043f36b179e80dbbed3654a8098342589734
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:39 +02:00

misc: hi6421-spmi-pmic: Switch to irq_domain_create_simple()

irq_domain_add_simple() is going away as being obsolete now. Switch to
the preferred irq_domain_create_simple(). That differs in the first
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
Link: https://lore.kernel.org/all/20250319092951.37667-27-jirislaby@kernel.org


---
 drivers/misc/hi6421v600-irq.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/misc/hi6421v600-irq.c b/drivers/misc/hi6421v600-irq.c
index 69ee4f3..187c5bc 100644
--- a/drivers/misc/hi6421v600-irq.c
+++ b/drivers/misc/hi6421v600-irq.c
@@ -254,8 +254,9 @@ static int hi6421v600_irq_probe(struct platform_device *pdev)
 	if (!priv->irqs)
 		return -ENOMEM;
 
-	priv->domain = irq_domain_add_simple(np, PMIC_IRQ_LIST_MAX, 0,
-					     &hi6421v600_domain_ops, priv);
+	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
+						PMIC_IRQ_LIST_MAX, 0,
+						&hi6421v600_domain_ops, priv);
 	if (!priv->domain) {
 		dev_err(dev, "Failed to create IRQ domain\n");
 		return -ENODEV;

