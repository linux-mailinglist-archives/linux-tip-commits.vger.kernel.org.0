Return-Path: <linux-tip-commits+bounces-2485-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8506E9A1350
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 22:07:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2ECEC282DEB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Oct 2024 20:07:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E371E21B44C;
	Wed, 16 Oct 2024 20:04:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rZbQgeAs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kTvAODhM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5DC216A37;
	Wed, 16 Oct 2024 20:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729109066; cv=none; b=jpJf7N53o2BJ7wEnhTl/B0Ky61hM35nZMDx34Q1lU5CnfVqaZ6Y0DR4Oi5h9cf53KKtDMUAm8V9J4hIBHVlZ/on7TRyQncoT6aLWsaG5IP5Pu0ykExzYIrf61ZaJK8+HhdS1eN3VsrhecXWLq3tLM7g/JqaaipYJWVK13IOtl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729109066; c=relaxed/simple;
	bh=UK6MPYZVhwuLRCWyE2FnOBV4jlTzkpgjx3p8PHGkVnU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dqAEnd+UfJ86N1Umsbs3gCyWTDfgbgqygLrKldQfgUEA87wM736pZEC/TT/0m84cLCezKqhGPhioIVm9JHSV4B5/Er4v/t663BJCLIGJhtj9hGZV1sfD3WKoGmLkpFRg/GhzdGAv9v4P3VfeO9vnjI71ch3bJoaEYp8ceDufrfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rZbQgeAs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kTvAODhM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Oct 2024 20:04:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729109063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNzIyLYfKW0xfJqAvyP1q+APSC36ZTlfSkzxycUy4QQ=;
	b=rZbQgeAsKwr/1hpt3YBw925LOaZMrnxyjF8EFEl4bYprtN8y18+GYw6Z2zSLulPbW0BC9j
	kPr/Z+6dZ72A+Nq2Df+hoDHQVcCrrKupuXgMV+k+cwB4XyNZNt0VWR98h9jEfZh6FAoJOW
	sal6gV6nVHm+wExijYdxMPmf9X5Zl4wa5l1zbF0cOMvR/vEk3RBNyGAbbWfe63i0cUhLzz
	GAx8dPWkqUxNWQ82/qR2xC8Z+uCGwG2kWImRyo1P+bvX7q6WqHMgU1kBDEJXADJqTNVZsf
	AVteFaeV9S4SHGfBXTVPnVEWQjq3AKviehBlg8b0Jdvi5NAhsS2kaCG0B7zbKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729109063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NNzIyLYfKW0xfJqAvyP1q+APSC36ZTlfSkzxycUy4QQ=;
	b=kTvAODhMw7jc9kI7LwL0npVWl+X2SiuxW6WAhwy5c+iPwXzRzrlktIatyN8t54oRHOfc71
	Z2l8u6jOQ5AttJCA==
From: "tip-bot2 for Bart Van Assche" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] hpet: Switch to irq_get_nr_irqs()
Cc: Bart Van Assche <bvanassche@acm.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241015190953.1266194-8-bvanassche@acm.org>
References: <20241015190953.1266194-8-bvanassche@acm.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172910906284.1442.3277212678221194167.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ce1fa22a659dad1a14ae9ede2063e5bc6c9a86fb
Gitweb:        https://git.kernel.org/tip/ce1fa22a659dad1a14ae9ede2063e5bc6c9a86fb
Author:        Bart Van Assche <bvanassche@acm.org>
AuthorDate:    Tue, 15 Oct 2024 12:09:38 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Oct 2024 21:56:57 +02:00

hpet: Switch to irq_get_nr_irqs()

Use the irq_get_nr_irqs() function instead of the global variable
'nr_irqs'. Prepare for changing 'nr_irqs' from an exported global
variable into a variable with file scope.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241015190953.1266194-8-bvanassche@acm.org

---
 drivers/char/hpet.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/char/hpet.c b/drivers/char/hpet.c
index e904e47..48fe96a 100644
--- a/drivers/char/hpet.c
+++ b/drivers/char/hpet.c
@@ -162,6 +162,7 @@ static irqreturn_t hpet_interrupt(int irq, void *data)
 
 static void hpet_timer_set_irq(struct hpet_dev *devp)
 {
+	const unsigned int nr_irqs = irq_get_nr_irqs();
 	unsigned long v;
 	int irq, gsi;
 	struct hpet_timer __iomem *timer;

