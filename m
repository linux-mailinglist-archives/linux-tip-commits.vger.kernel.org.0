Return-Path: <linux-tip-commits+bounces-5445-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DB2AAE136
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1882C7BF0BE
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D702228C2B0;
	Wed,  7 May 2025 13:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="28aDnfF8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rJCSa68t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37F628C00A;
	Wed,  7 May 2025 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625466; cv=none; b=rzZhLbwBvSALEeS0B/NOB7hv6rhhTV+c9De/EefCXS/52ZTQkpmGYrwdsS/bRLGGg2YSHvApc5WJbpHi3a+DZM/ub7eydgmQKUV+hglDcdDFu5KUlVASkHFLYKhhCVRlF2FOZKatzCz0kZheb4XYO8whqNfIHUwZnZECHqG7r+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625466; c=relaxed/simple;
	bh=svTLjdmXjlGrN1k0P/+0aTFbHph6nw6ZPyLMphCJzjs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RGjADTpWOyVxbTFPvZ2knD8U9ptNXdUg8UEwNp7Y98XJcTgX2C3NjINt2LW68sDpq8Xv+UObjMHkpsfkc1jumuXn1bQhRy7BnAqjwQdCYlpU/BzHcLXuxZPAUzYHszWroldDH524FXyYt4hvICkY+70QBSpPUekaII7VFWs/Khg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=28aDnfF8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rJCSa68t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2Rm8B+9JWw2H7MCMqEwxT7sAT1ot8Qjk8yCLVpN/Ko=;
	b=28aDnfF8H0fhTRKZy+YeFKMBuploLTNRXLQA5VV0gywBB8NrO1YteKQlLZd2Ll7AuaBSmF
	J+DF8ObLVSdSctIdoD4DgqPfM8lQ5GYZEEPmtMZa48iKXAn1Bpipl5iFQGu+BDVi3+TBmK
	Pe7KMcGvw4BLhJbagtGH6MsgUa1e3EdDqNdsYE3RUtjS6bC1ljPcZ9AQ8BymFJhtf29hz1
	yAM+QWyP/QKN+vhpQKIH2Aqyu3f5mpQ8mu7Vu/ASNNwRLfpWIh+tDmjuE+a+fhzphvAJCv
	FVEMpkZToXYx+UrmThGOGL5nsl+Vje5NxZbk0MwPdxZR1cQztOGm8wTrlrxMww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625463;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c2Rm8B+9JWw2H7MCMqEwxT7sAT1ot8Qjk8yCLVpN/Ko=;
	b=rJCSa68t8mY3A2LEesxltuq4E+mM9wApmwIjfJOem7SlkR88iZaq2eKwYsn3oQM8ZMIpa6
	Hq7KcWe0ULAH8YBA==
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
Message-ID: <174662546271.406.1016772177816099129.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     091b1d92f80753dd0b473fa4dbc510b65c8722ff
Gitweb:        https://git.kernel.org/tip/091b1d92f80753dd0b473fa4dbc510b65c8722ff
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:39:39 +02:00

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

