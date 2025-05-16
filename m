Return-Path: <linux-tip-commits+bounces-5615-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 46204ABA419
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:42:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E1B61C02F08
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0B86289351;
	Fri, 16 May 2025 19:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VjsMSorU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNuHzxtl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC774288C31;
	Fri, 16 May 2025 19:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424265; cv=none; b=VMFJORBdwa7ln/pVrKrb+io1YiPCCUu6hTU733WEvqb5p8pYlo5wAMw1N8eMEaIsrW+vbY9cQz7xhEFpEFYxtQEdEoOTppQmiMhp57CiOSCHaq8jXOUvH9cqvo0eNE4mezvEXh3ANLu9FoIpKsBaDoY1QvP8W7/BTLvl7jDiMF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424265; c=relaxed/simple;
	bh=jc4jP6wona0Jnsm7DubRMLW15/HePETcU2bP+0hzNZI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ONuMr9M+gpLz8bfIdvYRuzIbruojna9m6wMDwgeFMc8ypmcjkFG8TEImthYHfay4VPpL5RjawIg0k7pybpJeia5o/HFO5ne5CsuDau7xCQN1cTusmic39h+0YRBrSykE23A6EORB6TMkub35+N2TZQutCZ90Jihb/YeZkHIDto4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VjsMSorU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNuHzxtl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5CKH1F3h4fTg/94FQWh0v1MaGrzMiLsOtPsdHFswdY=;
	b=VjsMSorUqMKLKpO9pVYnzyke+wX83jhyv4HMwbhtmm9QMsQWZNgg5Kg5oi06I9dB5Bt8Y1
	PxS2g933iGrzDE2FD+Aj371pPrUhTaXGik0ksMQVxsGz4dipmUojQ51WwPbO1XZLcHLXrY
	STmGVtshQCReMZgesptBcEq6erUJMMdURljJxKUCEUNl/3Pbeaz6fwAtc0Gdyo5MMk8oq9
	PnDXLAuCiFk7sTCFBGt2ioRJZBLbTzIrg4+g239NSszkrVm/6aCkEyHHmsf+lDyOib3HHj
	gJbAJCYE8b3xvIjLb6Ri2hfW2C50ynJKVkvOk7zVpXQL+0X0EIEgecj9PahqCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424262;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G5CKH1F3h4fTg/94FQWh0v1MaGrzMiLsOtPsdHFswdY=;
	b=wNuHzxtlkgqgDz/4PSYtWyZnKgY7+tjQvoNjexhFjqyi1Crb/bYF8FHi91D96PeQMKv3Sk
	okZIIqHT52i2ydCg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] i2c: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-20-jirislaby@kernel.org>
References: <20250319092951.37667-20-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742426116.406.5580417156055824243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     3fd83ff1d9232efb0953b720086e6a9e02ecb166
Gitweb:        https://git.kernel.org/tip/3fd83ff1d9232efb0953b720086e6a9e02ecb166
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:09 +02:00

i2c: Switch to irq_domain_create_linear()

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
Link: https://lore.kernel.org/all/20250319092951.37667-20-jirislaby@kernel.org


---
 drivers/i2c/busses/i2c-cht-wc.c     | 2 +-
 drivers/i2c/muxes/i2c-mux-pca954x.c | 6 +++---
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/i2c/busses/i2c-cht-wc.c b/drivers/i2c/busses/i2c-cht-wc.c
index 26a36a6..606ac07 100644
--- a/drivers/i2c/busses/i2c-cht-wc.c
+++ b/drivers/i2c/busses/i2c-cht-wc.c
@@ -467,7 +467,7 @@ static int cht_wc_i2c_adap_i2c_probe(struct platform_device *pdev)
 		return ret;
 
 	/* Alloc and register client IRQ */
-	adap->irq_domain = irq_domain_add_linear(NULL, 1, &irq_domain_simple_ops, NULL);
+	adap->irq_domain = irq_domain_create_linear(NULL, 1, &irq_domain_simple_ops, NULL);
 	if (!adap->irq_domain)
 		return -ENOMEM;
 
diff --git a/drivers/i2c/muxes/i2c-mux-pca954x.c b/drivers/i2c/muxes/i2c-mux-pca954x.c
index db95113..5bb26af 100644
--- a/drivers/i2c/muxes/i2c-mux-pca954x.c
+++ b/drivers/i2c/muxes/i2c-mux-pca954x.c
@@ -442,9 +442,9 @@ static int pca954x_irq_setup(struct i2c_mux_core *muxc)
 
 	raw_spin_lock_init(&data->lock);
 
-	data->irq = irq_domain_add_linear(client->dev.of_node,
-					  data->chip->nchans,
-					  &irq_domain_simple_ops, data);
+	data->irq = irq_domain_create_linear(of_fwnode_handle(client->dev.of_node),
+					     data->chip->nchans,
+					     &irq_domain_simple_ops, data);
 	if (!data->irq)
 		return -ENODEV;
 

