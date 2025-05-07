Return-Path: <linux-tip-commits+bounces-5354-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EC76AAD9A9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:08:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C455E3B2C28
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EB232309B2;
	Wed,  7 May 2025 07:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2KIiMqCg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ujYs7w6X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DBE61DF25C;
	Wed,  7 May 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604692; cv=none; b=NH7UyTAUYJy9BjBxMtyY5/A4Zr+SZ/G5Y6nlC5GBDApOjmeRUceTDJEgkbUbMoSVTInwKE8z6ln2ZFtF+J4jl1VR4PGNfL1Nc6CZmeCsw89pNrXVevxl4rx8qiyza43NMeUQJCLSNhvBrNgPstF2Ub/dWost4ohrRz7EfboHWfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604692; c=relaxed/simple;
	bh=zI281knNbWJr59+0lG9F3BAA8Wm7iUSlPMNIAVsj+ms=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=p4eV3hedRjJpAAJknFW1or1oKVjqZsDklhX0dMXt0XAs7lyyPgKiumLNKaxKjl6CWoKKLmGCezjBQY4GvFOWhdCFl6boynV0Y3CV43LxGDd86f67qBBO8sWK8sMO2LvbjLLoszjcJ0bAHPiOc8168EIY8a+AaedYCBDH5qFhvg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2KIiMqCg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ujYs7w6X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vklIST99MGFTiWRSwYJAuQVwpiQr1GP0ddTuobJOn68=;
	b=2KIiMqCgyFB6k4Kik7CUvqEVvJxaXShxsWmCIbOJnHmtJno4mqtqeG9+SK5euPfJIjRIic
	MsUzKAiuZ8dtsr6RCb8xWAX4vg7c5e8mDGBb6Kmh8cuEdgvm+CKxbDw2kTmnpjTsHrtVnO
	spKeEpAwLKlPnrLFb+Q1tqFlr2338ZhzTlhDOSj4KvBTh5Vzgq34V2lndoR7chqG7WzDQD
	YoGyNy5LF+P34CFg9Iexyi8ojDDedNS5STvCn3QkAQi7ncpw97GPE/mbZmW+9kPwZKGHxJ
	tJlYsgEieFuFA59eM7JJ8TGf2nVhsf8R76qV4MkdUfopuz/tQwl6Q0iBjiih1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604688;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vklIST99MGFTiWRSwYJAuQVwpiQr1GP0ddTuobJOn68=;
	b=ujYs7w6Xwz842VMLYNP7hyIVJGqK/MESFZMIe5zmVQTx8O5PnD7T7BWlWuS9HTpBj6l84l
	tX/ZmV93qPf0+/AQ==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/cleanups] mailbox: qcom-ipcc: Switch to irq_domain_create_tree()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-23-jirislaby@kernel.org>
References: <20250319092951.37667-23-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660468784.406.14361628430139004078.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     3b585e8bc3cc73bf7d24efbd87e0a0d519f8a19c
Gitweb:        https://git.kernel.org/tip/3b585e8bc3cc73bf7d24efbd87e0a0d519f8a19c
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:22 +02:00

mailbox: qcom-ipcc: Switch to irq_domain_create_tree()

irq_domain_add_tree() is going away as being obsolete now. Switch to
the preferred irq_domain_create_tree(). That differs in the first
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
Link: https://lore.kernel.org/all/20250319092951.37667-23-jirislaby@kernel.org

---
 drivers/mailbox/qcom-ipcc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mailbox/qcom-ipcc.c b/drivers/mailbox/qcom-ipcc.c
index 0b17a38..ea44ffb 100644
--- a/drivers/mailbox/qcom-ipcc.c
+++ b/drivers/mailbox/qcom-ipcc.c
@@ -312,8 +312,8 @@ static int qcom_ipcc_probe(struct platform_device *pdev)
 	if (!name)
 		return -ENOMEM;
 
-	ipcc->irq_domain = irq_domain_add_tree(pdev->dev.of_node,
-					       &qcom_ipcc_irq_ops, ipcc);
+	ipcc->irq_domain = irq_domain_create_tree(of_fwnode_handle(pdev->dev.of_node),
+						  &qcom_ipcc_irq_ops, ipcc);
 	if (!ipcc->irq_domain)
 		return -ENOMEM;
 

