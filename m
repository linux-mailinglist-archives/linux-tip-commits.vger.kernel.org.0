Return-Path: <linux-tip-commits+bounces-5293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA28AAC5E5
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DA4F3B1E31
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 944B7286886;
	Tue,  6 May 2025 13:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gjWofrER";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dYS+TOLr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69222857FD;
	Tue,  6 May 2025 13:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537634; cv=none; b=FfJwNfu+7tGTERufAOBH8nHLt26BjUMbVegCAyrfNVhBonXWC6TPuY9CjYZ2QTEGoPGmWIXW4fyweYzpAYPdUQqDmqr4pqlu8U4JiKg33huN3V9fTKRhSAolmw+be+m6B5OxBKL36RyQ7g76Ci2msQSsV/iv9mBJGpHpaHnHxPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537634; c=relaxed/simple;
	bh=KxpEPSl2KigB3j+YL8uR7OgafSoVRpXjjqfn6zXAdX0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e4Vx3RikUlKiwQK7ObRfL+jE2hnLYnKv3l3oof8jCzoy/sYfKT/TZBm0uldTKzpbEBhHL+zhYylMOsBayew8FptYkJjVS7xBBY9y7immenyA6tUp/gc2ItoXV91bXcrvsqscq2W0DiKlkJpPJM9dqvyrNrJLF/p1QmSfDEFdLB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gjWofrER; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dYS+TOLr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBjeB8sA8qPPP/e6xke9vSkYI12vcoDYxz6n2ciJpc0=;
	b=gjWofrERLDhM1bZvZ6AaCMSXghhFMFmrbEt4UrK3oqUExdkBGkFRLJ3TKMxakCPgA9BWeN
	/DV8NHWvJ0QT6MixDOUfWKxXGthpnJYrcBmEFUxYU3stF4CJxvHy0onf2iLW5noXteklB2
	yyVucp0/Q4n+QD0D8C8j1Yi9kQBzg2JJSRDKWiR3pUydiU7qORjzZhlCBmYqwM9RTUIUHz
	RGX4hjwA3b2X8OFaOD1+lS2dNoWDFzOqro92M7qOynYIoKfnE4DpCJKUmXJY/3De/YH2eT
	cREe1ZtaG3XawQwMF8KZQjGlBmagQGv39O2wdsww92zeP+l3nW3rT1I/nzIPnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537631;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IBjeB8sA8qPPP/e6xke9vSkYI12vcoDYxz6n2ciJpc0=;
	b=dYS+TOLr1Lj8r8nwFnP5KwvISim0rKPg2eGH5thTcDNxSjWqB40s2w6DI/IhLPBcne5qHT
	D8BKKK4XATwMaNDQ==
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
Message-ID: <174653763022.406.6923562167165893308.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     ae619cab900f362dabc847a999c9e82dacdeb533
Gitweb:        https://git.kernel.org/tip/ae619cab900f362dabc847a999c9e82dacdeb533
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:19 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:06 +02:00

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

