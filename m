Return-Path: <linux-tip-commits+bounces-1412-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1C190B446
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 17:28:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C95ACB3C85A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 943C91D3374;
	Mon, 17 Jun 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pucnGY6T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9iZP1r2S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C72E1D215D;
	Mon, 17 Jun 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632277; cv=none; b=OsgU4uxW09IsCzRJY4fbMDqY6U8tDHGzp+Oct5q4fMQC6/jPaI8FzS1pEFUd8hNfw/EdgRLkpamIx6DY6LSB7vlYUUobLziVjf6UbBvRmSevFEId+ReB1Qj7Ds0Jp4LY7nm1aUwZi1VZKsZ0hdGe80twoYJaiD/v4v0GhK7dvD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632277; c=relaxed/simple;
	bh=YJp3MWtD/FGqWjD6J1O4JloYjPAHvk1hz3xLf2ahtH0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J9Nr1sMnj5MjrMibsX+h73nI8JORZRuWcA9VzQDD/7pjxikTolTgC8nB3WR7kop34Qfq1XpQAcD8g2y56AZ+VGEPbmVe7Sy1ZqxSgFTOtnX81kqR7vGsulbGx1ZxM1O2ur1b5C7O6uwQ5/iZbOTH8bDqKi7WgdGozBXT29atDK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pucnGY6T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9iZP1r2S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5+kZ0H1j3dQ6QaMpbs3VrBSRNI7zW83aCdHCZXAUDg=;
	b=pucnGY6TDvxqhmy+yboAxOtg7uF4LFyx3xUm8KIdRyKPMxEFa7pkUC7J8TjVZVVRFo5QIX
	6h435diOF5FUg1En9gHK7sqS87+EBWBAXTEScfgLBlkAVbOlNUUGnSUcSiUNO1lotGDA47
	eQ9uNc4K6ckvV9l3PbY6Eey+Vt605l4qqMreKyidOC03JMoZl3VHBJ1+Z2HmSNNTtHJHkO
	SxwdLHyYSrEeNxP5nJLuT+otXLRjmAU1B1ndOvcj6r6FF/ugniwykKlWP/Db/xlvLkXA3L
	HRjhzD02tTLCvMeO6Pn3/NYUTCue2ATCwItinC5lpkGTf76seRFKZNVGuaayhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a5+kZ0H1j3dQ6QaMpbs3VrBSRNI7zW83aCdHCZXAUDg=;
	b=9iZP1r2S/fCAWUzUhuwDJxMktSsGco6pafb6MM921QLLvmTyMc7DqQyGDcAsqiFJgM9kLy
	ZqNlmCQxztqoT5DQ==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Convert domain creation functions to
 irq_domain_instantiate()
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-19-herve.codina@bootlin.com>
References: <20240614173232.1184015-19-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226909.10875.4590561687027411709.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     2ada5ed6ecac06e32defe39b15b33e9a6b004413
Gitweb:        https://git.kernel.org/tip/2ada5ed6ecac06e32defe39b15b33e9a6b004413
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:19 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:15 +02:00

irqdomain: Convert domain creation functions to irq_domain_instantiate()

Domain creation functions use __irq_domain_add(). With the introduction
of irq_domain_instantiate(), __irq_domain_add() becomes obsolete.

In order to fully remove __irq_domain_add(), convert domain
creation function to irq_domain_instantiate()

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-19-herve.codina@bootlin.com

---
 kernel/irq/irqdomain.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 4d2a403..c9b076c 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -442,10 +442,17 @@ struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.size		= size,
+		.hwirq_max	= size,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(fwnode, size, size, 0, ops, host_data);
-	if (!domain)
+	domain = irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
 		return NULL;
 
 	if (first_irq > 0) {
@@ -498,11 +505,20 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
+	struct irq_domain_info info = {
+		.fwnode		= fwnode,
+		.size		= first_hwirq + size,
+		.hwirq_max	= first_hwirq + size,
+		.ops		= ops,
+		.host_data	= host_data,
+	};
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
-	if (domain)
-		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
+	domain = irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
+		return NULL;
+
+	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
 
 	return domain;
 }

