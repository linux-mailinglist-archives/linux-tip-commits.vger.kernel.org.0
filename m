Return-Path: <linux-tip-commits+bounces-5285-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3709AAC5CD
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 647F91C20867
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D3ED284B42;
	Tue,  6 May 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l8/rhDTU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TO1/nfi7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCB283FF3;
	Tue,  6 May 2025 13:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537629; cv=none; b=PmATIW+kdXx1vM5unja/EzLyxn1ZtKZaQsmK0abPlLkocy8NbUPu//bJoPmQZSq7rlxgeTwObX/l89B96zR5gnwu2bQwfXxAdYZUuULKXTXODwFwd3i7toHMWX0wLh+QPR4rzRLbk8OwxPBuO0cOVd6aU6/5SsQk+5CKoCKn3y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537629; c=relaxed/simple;
	bh=TXiPladwXzUiKBTajy7N/0YiYVe8QEgDPpCFNfxjewk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Waos6kUUW7FsoWlheLCo6vENMPQVUGXqyeiyvb3s/VWKKqvaWwhmmUujrTiFeliSZM+R5gjSkZcubR/JLiCYjppN5w/H756+bggrEVTnw9rG4hMgbp4iqLshQGQlc8BHewVVQQwM0Jjh0JdIyUX2MZ1V+pCsKUCQ0JOgXZpWkWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l8/rhDTU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TO1/nfi7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs+j75kWmDaoqr7sMlTZvuHx83j1/yQXPt8JaHxgDag=;
	b=l8/rhDTUn+OxYj2lGSmG2dmFw6pIUR9uFZHHKvfKybzkCWyyjaGXTJgPZ91NG+jzgGXUzb
	jukhBQDB/TTIoYLwuw3CjpHZj133eevj/fA5HPDPokccVWjX0rXCNTW+AT5f74yL7TOveg
	fNMq6hSTIylqqHirxcqa6OpRRk9ySLJhA2Drzu8RZCsuJ24Y+fPCyUzE+G8BtIs9fX/Cgy
	6X+Zdvbj/aNRoawoVcQRCaI/Fwgi2dNNz4As1WfK1NW1Y/Wto83/bN40nh2pWqlaEd6CIK
	YQb7w7rJlyivGoYbya6AGZYK6uOw+AeoG7tTfWWZQ1LpBbMev3H5fquZn+WDrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537625;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zs+j75kWmDaoqr7sMlTZvuHx83j1/yQXPt8JaHxgDag=;
	b=TO1/nfi7REE1DtX59Wir4y53SyWifsVX1mQ/YGRgHkqK1c/tmN/MICop0F9T0djDskNWaU
	Ry592dfNbp9z3iDA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] thermal: Switch to irq_domain_create_linear()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-39-jirislaby@kernel.org>
References: <20250319092951.37667-39-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653762483.406.16842771657994935456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     02ca56b022b20db9adf3ece846b6b103b829855e
Gitweb:        https://git.kernel.org/tip/02ca56b022b20db9adf3ece846b6b103b829855e
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:31 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:07 +02:00

thermal: Switch to irq_domain_create_linear()

irq_domain_add_linear() is going away as being obsolete now. Switch to
the preferred irq_domain_create_linear(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fixed up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-39-jirislaby@kernel.org

---
 drivers/thermal/qcom/lmh.c       | 3 ++-
 drivers/thermal/tegra/soctherm.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
index d2d4926..991d157 100644
--- a/drivers/thermal/qcom/lmh.c
+++ b/drivers/thermal/qcom/lmh.c
@@ -209,7 +209,8 @@ static int lmh_probe(struct platform_device *pdev)
 	}
 
 	lmh_data->irq = platform_get_irq(pdev, 0);
-	lmh_data->domain = irq_domain_add_linear(np, 1, &lmh_irq_ops, lmh_data);
+	lmh_data->domain = irq_domain_create_linear(of_fwnode_handle(np), 1, &lmh_irq_ops,
+						    lmh_data);
 	if (!lmh_data->domain) {
 		dev_err(dev, "Error adding irq_domain\n");
 		return -EINVAL;
diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
index 2c5ddf0..926f105 100644
--- a/drivers/thermal/tegra/soctherm.c
+++ b/drivers/thermal/tegra/soctherm.c
@@ -1234,7 +1234,7 @@ static int soctherm_oc_int_init(struct device_node *np, int num_irqs)
 	soc_irq_cdata.irq_chip.irq_set_type = soctherm_oc_irq_set_type;
 	soc_irq_cdata.irq_chip.irq_set_wake = NULL;
 
-	soc_irq_cdata.domain = irq_domain_add_linear(np, num_irqs,
+	soc_irq_cdata.domain = irq_domain_create_linear(of_fwnode_handle(np), num_irqs,
 						     &soctherm_oc_domain_ops,
 						     &soc_irq_cdata);
 

