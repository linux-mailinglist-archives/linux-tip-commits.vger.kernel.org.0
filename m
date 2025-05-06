Return-Path: <linux-tip-commits+bounces-5298-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C141AAC5F6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DC4B505F33
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C78A528750D;
	Tue,  6 May 2025 13:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="V/R345Vf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sr68wtjI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5ADE286D5E;
	Tue,  6 May 2025 13:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537638; cv=none; b=jiEuK8MaTP6gzdtg3VqKEtQXuJ1rIIMJ79jeI3EetenNUg7BCtmoc1jfPzMancmcm5UahK0D4HA/AmTLiZvVvFfIcR+kkqYARU/R5Cjj2IFOysXflsqUx9YgTxb4/cqo/Iw2LxrmAl6trRf4bl1ZbbO8fQFNY3H73Ccu7H+Xmv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537638; c=relaxed/simple;
	bh=UwEJBH1M1Wb/9hfS/OoNSCKvc50JkRlPIIS+eHLd85w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HMraKzwa3IHQ+FqOdwK53UJ7hq6fm7SWUSsDpfz+tT2mtPcJFHCAK5luwoYgSDpLZbnvoy/0OpYSgYqg6D1uqhTZYCioJg8TxkTLCmHY3sOySeWiuITtN1hhX7FCHYUplBImmwzAAKrhVx7KlxnYYB3kse2bzx73z8dikcpOhIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=V/R345Vf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sr68wtjI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNZrtxDmELwqwVHtzITJlJcXq/TKmWJ5EsOwTfJqNr8=;
	b=V/R345VfB53B3/FMm54W/JAG60MGt9FOIlYLn6bWL3yhETEt9dVwXR38Vxj74UULzFY9oi
	Ete6N2cn/5TnzvJmdGFVJWt+3cawuB2sAKs4XQ4naq7gCD34kyUt5JMKp8XF7t8mGOYO+v
	aw8icJvDj+uJVDxHAqY1H0cNX2sCvcyXQwggAnN8b5X7X8/QZeNAmneEEWCyZmj1NNxkK2
	sxpKTmVJLtZkOolk71sjTSXAH4Gb4IXdWM9vsr8ttmhMpfdDvTZd0PIuTfgyZ+EHXM6Bnx
	S/UMlJXPjBadT1Dl/p65K9ZjXRylCadK8Oxky8ePdiU26TLCR5RD1LyVPxQEhw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537635;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pNZrtxDmELwqwVHtzITJlJcXq/TKmWJ5EsOwTfJqNr8=;
	b=Sr68wtjIuliLL2t0N5eI/gvwZHE4CkDGmjOc3ZC/fDhrLKDI9S+Cl+NdfbL299TJsRTzti
	ysaQSJ+jVNqIYEBg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] iio: Switch to irq_domain_create_simple()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-21-jirislaby@kernel.org>
References: <20250319092951.37667-21-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653763435.406.6086948006437938550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     344471d8f3bd78cbc8fecbc94be6fff6e490cc29
Gitweb:        https://git.kernel.org/tip/344471d8f3bd78cbc8fecbc94be6fff6e490cc29
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:05 +02:00

iio: Switch to irq_domain_create_simple()

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
Link: https://lore.kernel.org/all/20250319092951.37667-21-jirislaby@kernel.org

---
 drivers/iio/adc/stm32-adc-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 0914148..bd34589 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -421,9 +421,10 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 			return priv->irq[i];
 	}
 
-	priv->domain = irq_domain_add_simple(np, STM32_ADC_MAX_ADCS, 0,
-					     &stm32_adc_domain_ops,
-					     priv);
+	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
+						STM32_ADC_MAX_ADCS, 0,
+						&stm32_adc_domain_ops,
+						priv);
 	if (!priv->domain) {
 		dev_err(&pdev->dev, "Failed to add irq domain\n");
 		return -ENOMEM;

