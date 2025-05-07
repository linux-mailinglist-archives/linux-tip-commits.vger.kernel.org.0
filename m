Return-Path: <linux-tip-commits+bounces-5448-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A55E0AAE140
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 15:51:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE1846217C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 13:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AD828C842;
	Wed,  7 May 2025 13:44:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fNfJl1p5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="I5Jm2o/1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A7128C2D7;
	Wed,  7 May 2025 13:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746625469; cv=none; b=Qe9R7sIORCovk4zZXPQNlAbNXaiQySSmYsbOvayNdLNsLBndx4bdpkAUIVT7Eoz3PrQmFwex5spVbldfcu1qPRAPQx8sZTgQPyMqs2VNtCku0GtIA5j73Zb5cq/doKUXtWG1iTx7BWqHG7NbP9dlkVViK/pNm3LYrXJK7Xbre/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746625469; c=relaxed/simple;
	bh=ufKXPIVXxRXY/5QmFDlRs9SpH3wPRRA5XprJQCQKvVY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hXML99BNwjHG+nRBDcDSHmzEE2w4ApeWA1PV2o67CMqwm01gjRZTJVG/OA9UhKuVkMkhzYIt1sB3INLzbIv5AQtZE5GdqMbZEYIGxDkgFlHRvJC6ubYrDrnyQurepkeWAp5/9YwWrOLW8N5WLyum0vL0NrLkzcEkrUjxwIIUf2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fNfJl1p5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=I5Jm2o/1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 13:44:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746625466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzG7T1arbPvQsw9hbpyRV3ZIJuUKGKcEwMIp+TDOPuk=;
	b=fNfJl1p5ScUame0/jPU/foWAh+/to70hefrfYNo4MOQqpVlasmA1dVGH2VOoVe9CBmMtvo
	NsfxfDKNfWXlsjyNiypLkzvDyXZ8WzQkMh6EBl1DVbiMub+3Wd5cVBR1x9K0tS+NCCb/yE
	xsrrQZxz3NA2IgKCWrcF/zLQLdZNxbwaNane17Kz+/8emj/BbuC/jp4kb6gZN2xOZAMVEa
	MJnAVax9tB4sYm3EiTde/PfE92isp9OwUCwgLTD11vYxA0h438lVrfW0D4q/piWxT9YKP/
	Jq5PyrfZdZRM4uPN2d4h6JEXemw/jiFKm5Po+mM3X4E60l9FPhHr2tocMFPM5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746625466;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EzG7T1arbPvQsw9hbpyRV3ZIJuUKGKcEwMIp+TDOPuk=;
	b=I5Jm2o/1PCBzhpSRt0YEUn4+uiNnXZ57udb52yL/HbxwslJ0BJesZSxxBJXCEFaeqSHTG4
	GF8JdK6QynVHpMDw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/irq-vt8500: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-22-jirislaby@kernel.org>
References: <20250319092951.37667-22-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174662546512.406.9049404596433242775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     15568ffd59d4e7d8c39286a7159880afe327216d
Gitweb:        https://git.kernel.org/tip/15568ffd59d4e7d8c39286a7159880afe327216d
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 15:36:56 +02:00

irqchip/irq-vt8500: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Split out from combo patch to avoid merge conflicts ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-22-jirislaby@kernel.org
---
 drivers/irqchip/irq-vt8500.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index 40c2cff..3b74259 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -214,10 +214,8 @@ static int __init vt8500_irq_init(struct device_node *node,
 		goto err_free;
 	}
 
-	intc->domain = irq_domain_add_linear(node,
-					     64,
-					     &vt8500_irq_domain_ops,
-					     intc);
+	intc->domain = irq_domain_create_linear(of_fwnode_handle(node), 64,
+						&vt8500_irq_domain_ops, intc);
 	if (!intc->domain) {
 		pr_err("%s: Unable to add irq domain!\n", __func__);
 		ret = -ENOMEM;

