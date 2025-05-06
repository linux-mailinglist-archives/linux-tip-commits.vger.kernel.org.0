Return-Path: <linux-tip-commits+bounces-5299-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD7CFAAC5F8
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37D85525182
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA9832882AF;
	Tue,  6 May 2025 13:20:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4pRbGDF6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UHpRbZBx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A27E12874E3;
	Tue,  6 May 2025 13:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537639; cv=none; b=TQeKuALbCXKYUfocvkq7462EePRfwui4wlcROoLwkgQYJ0btp5b9NDYf+ccpY3rf3i5YOohnc2gB4jyCB71WaTpsJavDI/32DCyEUYUjATF4FNiYUGqJQM25soV7zSRbN6repwcl40UZaGE1MJqbd/TTbNq8clHXzsS6HfgVOC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537639; c=relaxed/simple;
	bh=0InN82T3uAdUObow4ujbfylWYzn/FstakWwAKjzc6Hg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Kzp72T81FabH1++2e7kHp8lMea+xmBRK8L7ASSJ0eORUfKrWYAGB8j85zFb3vAzHKL8FnyQ82JHd8+LNvo06F58HsJu+gBzfizBf8dBJ46e3Qdl63C+0LAB0JpMz9DmWkHB3FRrcWnKIXlVGerh9P3zoJRofMOR37/TdD90N8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4pRbGDF6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UHpRbZBx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT5UhfNWLkfwY4GF76R3sLjj79K8aiFGdqa69P1eFbE=;
	b=4pRbGDF6Wkjppx2z0A/aoi8ElCK95ZbSzrnt+6+BtUpANXKJah1xPgdAuuZwImqjIAtWbf
	1T56gJ+ae2oSfd5Qmmw+S+/aGKSCx5YXrPPbwJTTpwxSW+3kgZfoe4J6H1xq6dEPvDY7pW
	RXf7ZBucCAmvIu66zYzKOJxo+vb54LIKrIRdGowPlqr3e8gNJoRbwHqlXyJR2jKqJY6K3y
	lgR4fr4L1nMOT3Bjuu+npgfbBRptKqhdi7xsiCBIBBnXVYzvBtppcx0XyIhdQGPq4suFYi
	/GBjbtaAkBkyYJsHwFx6J6yghTa/VMZQ4x6KZRyJed046OELXKhMoug/ooFN5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CT5UhfNWLkfwY4GF76R3sLjj79K8aiFGdqa69P1eFbE=;
	b=UHpRbZBxPD6YAilDgJ1pojasb1e29wWpzRDArYfs8gz20RdteRRaXF5p/DyQqysCrcO8F4
	emsX6HbQuOVI7rCA==
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
Message-ID: <174653763503.406.7521998310219943312.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     5a6815bbfe0d78c1475bedd32b0aaec0bab7e208
Gitweb:        https://git.kernel.org/tip/5a6815bbfe0d78c1475bedd32b0aaec0bab7e208
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:05 +02:00

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
 

