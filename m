Return-Path: <linux-tip-commits+bounces-5609-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD4F3ABA411
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:41:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A67C45054B7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1E58286432;
	Fri, 16 May 2025 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+VyN89C";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zfo7P2vR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1919A2857E0;
	Fri, 16 May 2025 19:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424259; cv=none; b=HxRGf9q/vgIuD7FZku7XEKHAsIKfb49SULLO90nvoOPHAoVzbF7kXBj6sdi5AUyBLD9acZ0+k+5dD2/sSFgWW5gM1lnvAWvoL61YP3W+brD3lguKMHvHl4L0Hz87qf+fQQjE3t+YzQMm2HANNU4+CWBUZDeNpVhypPvp7CtFqwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424259; c=relaxed/simple;
	bh=DYsuNiPNF2AzEWN/MaQJWJNzuvfa/wGBcFPzelGaGC4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hebouS9sp2UcvRJHaUKEvFsflvWuxvcOhNort/UXYn4a9TTHAdnq03xgbzSQdFTNOnubPFatWWPn8fHvux+m7Yi4Q3YWJr/eWkEO/nIST8KY16mXsfdrD/cqskYu+1Dho+aZAq0Tl7/FijbD7bOFF2Gafk5xfv8MlYepwykR+Hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+VyN89C; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zfo7P2vR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDbY3fVREdigPbvWeW1LZgNsIyGxuPkSu7cT8NPLFnI=;
	b=r+VyN89CyeYDugJYwwaWKlOcnVIgUsOwsyViR5IbQ2hV+SdecCbLDUDQI3cgznbwdNk5yb
	J4+eZhOKDu1o+NlXyI3lNOD24l150Nn2cTHkKtaZoZ3K+NeMAYRy0R0oGTdH/pkZqlZnGv
	KyULSzoH8Qc/W/40xqryZ5+CkqKeYBLybeWncHonwPNypcjaeB0IQxnLQ24TvKDC/zvRIv
	q8WFD7tqBAPmSdiO7jQIoQjROPX0T4FfSkZjfjWqvzgAxEB3zgRUwoU/e1UGHYLW2X3M8s
	kE0e5G3Hzh90WYaB59pCApw2r4yQejQ3Tw8vgkhRuVIGA79CxNL2fF4hJ6VyZQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424256;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JDbY3fVREdigPbvWeW1LZgNsIyGxuPkSu7cT8NPLFnI=;
	b=zfo7P2vRUCrRLgf4/0Pe06aI4qB9iRfQQB0pNbqooVBVQAtLrihA4ZwFLbf12YXU0b2VRa
	jwezhlndrbB0PiDA==
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
Message-ID: <174742425574.406.3405042439327116449.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     d8566886f2387cdb3562c4b69f91d0f0eec672c0
Gitweb:        https://git.kernel.org/tip/d8566886f2387cdb3562c4b69f91d0f0eec672c0
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:10 +02:00

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

