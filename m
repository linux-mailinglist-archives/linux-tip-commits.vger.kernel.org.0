Return-Path: <linux-tip-commits+bounces-5371-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA76AADABA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 23E389A166F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:07:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA8623182E;
	Wed,  7 May 2025 09:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XyTodnN0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lIJf268k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30A230981;
	Wed,  7 May 2025 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608843; cv=none; b=fnsCoAV8bZS4j5O2FTs9oqRaHLWojlOi2jtSlFaXfRawcbK119D1CWmlic7pbKqnwlX5KXSofTwS03548uW3bWdfVDxsZyihEJN7eanhmS4mbuh4642w6PIk8eNVTd0b8ajMp4Dc2yLxJFRxGEq9d+xqq8OBPhlwfZJ9t90ztHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608843; c=relaxed/simple;
	bh=ZEXphWKfrkKb9K9P+nvFS0OspolGL9JnRct82NmOluQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RjScEewIMtp0xO8UZpVa7zvUSz73O07tPIBiBsH4NZvu92HfJwdjbbPZbwPnFbyntSSmMC8JmysSttc3XTJmIfOV+MFNaScTFxvTfDIDH7UebC3nvyIEmv34JgvjvPwLPPh7q2wWKd+DvIBSZKRX5fXChWufaEjbEXuYIlOmodk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XyTodnN0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lIJf268k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUi0DHATVJKax4znhDN/hx83y6maPsjCIfA1+3TxHgw=;
	b=XyTodnN0fzrawpb9GrpOvVyZcvyWgQEmFesT3c5qfKPGFXgzPfZhhUAZ7QQhc5nZFf7Ph4
	HLtabeaGn1dopAWbwr76cfo1CeQ/aqJ5H406fRinh4TgBcL1L2wUrszbXWbnta945W602+
	ivS0KO3yBW0H6P/bRmRKsw8c7ch6bxmCTspLldoYWWoKm4m92VBVeubyhkJebzch/Aw7dn
	k8sektEZLyPnP7iSVm+H8CBO/7HDqGJjw+dx5QitxvMrvitXZsSJBU2OWovsW2XX6vGyCB
	0MdprwJpeL6Qukq3b2VH//AoonyrfVVJBJX/ORBCwcq3HzxnWpGlWG6t+tmZYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uUi0DHATVJKax4znhDN/hx83y6maPsjCIfA1+3TxHgw=;
	b=lIJf268kNmOMJnQgkSJW3eFk0fQg4OgRrvnmXn1pwA1+l4txqEddlvPQ9fCYMLANwiaXD4
	x6vobxph/KFrCzBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework irq_get_irqchip_state()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.612184618@linutronix.de>
References: <20250429065422.612184618@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660883980.406.4109849283258238676.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     782249a997472acec7e8d8f04177750192712a19
Gitweb:        https://git.kernel.org/tip/782249a997472acec7e8d8f04177750192712a19
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:52 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:16 +02:00

genirq/manage: Rework irq_get_irqchip_state()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.612184618@linutronix.de


---
 kernel/irq/manage.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fd5fcf3..1783c52 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2678,24 +2678,14 @@ static int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state
  * This function should be called with preemption disabled if the interrupt
  * controller has per-cpu registers.
  */
-int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
-			  bool *state)
+int irq_get_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool *state)
 {
-	struct irq_desc *desc;
-	struct irq_data *data;
-	unsigned long flags;
-	int err = -EINVAL;
-
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return err;
-
-	data = irq_desc_get_irq_data(desc);
-
-	err = __irq_get_irqchip_state(data, which, state);
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
 
-	irq_put_desc_busunlock(desc, flags);
-	return err;
+		return __irq_get_irqchip_state(data, which, state);
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
 

