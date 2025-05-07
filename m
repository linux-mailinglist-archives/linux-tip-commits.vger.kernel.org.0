Return-Path: <linux-tip-commits+bounces-5370-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8266AADAB9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 11:07:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DE6A21BC27E3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 09:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A312230BD6;
	Wed,  7 May 2025 09:07:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="boEzdwFi";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1Wuu5TEu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A4B22128B;
	Wed,  7 May 2025 09:07:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746608843; cv=none; b=QN2PopvFgU4XEn1MWfeLr7yQYxz6aYSb3AjWHVKupBt9vUHhwSe4BqnAh1wyY2YgphPqMsXMhnqfo1b19hUtlzK5wkpH5+QqpPKSwQicz1FUKqN8dhDYvt180A5EABTslHr8WtbNjpcsBxKMPn5F+quE4e/KFuJsMmuC0aQ++fE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746608843; c=relaxed/simple;
	bh=d/Zn6c6jIMHaTKqWDpP4LvNSH+e2IlpTkIlNn8eWTLg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bhrywcfhb98OFxfb04cYRHTCTI2s0qRj4YBBk14Wz0R4duRbrBDbj7/UqlIeC2iUhpLvUWmjmtd1VsdPJCMZyORIT5LFUhanTW1yRdvduKvxbjiHuyklVGiJKkFkAamXpeLH+75NZCZeLRzqbpm5118bdx0HDYQQskb2Gg28r5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=boEzdwFi; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1Wuu5TEu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 09:07:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746608839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv+9TkXSn8D8b015guVorv/lzm1J62pAfUN2RABw5VU=;
	b=boEzdwFiDOGtow4XuE8dHx+J5xzX6T96BDy4qwNStOxfFAU5USlWshU63YMFpyfksKBttM
	pC0CeY0frCGVydEHlNqJFhk3VdBPdWBEuBiOfDUenvCR4ZnqM32H5debRR++m7pr1mTE7O
	jzNgDPDpCJeO83sPjtHsJC2ZRweL8S9KLtcmkTirzuu544yZjjkOaKGl4XtV0KPXqbtD/H
	CgK3pv9DY41R4UkROed8FC9xu8NjghPvEpkE+vRa3AZn8glZIwocuXpawA9zZLahJC0VBX
	jtUZD7Z2QfCQlNiQUQhb7+Cc0TDOoSAiPi4fdSiXwyeXcfw5XVpTgTUdqpgqUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746608839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cv+9TkXSn8D8b015guVorv/lzm1J62pAfUN2RABw5VU=;
	b=1Wuu5TEu6aEgalQPhGhYYaRntQ5oIh8kYfP/FYlVKmvMiMJcxWf8OWw3uUSeuGNZ9lq5Io
	reNbyX3B+yBjwjBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/manage: Rework irq_set_irqchip_state()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250429065422.670808288@linutronix.de>
References: <20250429065422.670808288@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660883905.406.10226361856648195028.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     193879e28be7bb26abc795e6b5096ef9fe3131cf
Gitweb:        https://git.kernel.org/tip/193879e28be7bb26abc795e6b5096ef9fe3131cf
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 29 Apr 2025 08:55:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:08:16 +02:00

genirq/manage: Rework irq_set_irqchip_state()

Use the new guards to get and lock the interrupt descriptor and tidy up the
code.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/all/20250429065422.670808288@linutronix.de


---
 kernel/irq/manage.c | 43 +++++++++++++++----------------------------
 1 file changed, 15 insertions(+), 28 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 1783c52..827edc8 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -2703,39 +2703,26 @@ EXPORT_SYMBOL_GPL(irq_get_irqchip_state);
  */
 int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which, bool val)
 {
-	struct irq_desc *desc;
-	struct irq_data *data;
-	struct irq_chip *chip;
-	unsigned long flags;
-	int err = -EINVAL;
+	scoped_irqdesc_get_and_buslock(irq, 0) {
+		struct irq_data *data = irq_desc_get_irq_data(scoped_irqdesc);
+		struct irq_chip *chip;
 
-	desc = irq_get_desc_buslock(irq, &flags, 0);
-	if (!desc)
-		return err;
+		do {
+			chip = irq_data_get_irq_chip(data);
 
-	data = irq_desc_get_irq_data(desc);
+			if (WARN_ON_ONCE(!chip))
+				return -ENODEV;
 
-	do {
-		chip = irq_data_get_irq_chip(data);
-		if (WARN_ON_ONCE(!chip)) {
-			err = -ENODEV;
-			goto out_unlock;
-		}
-		if (chip->irq_set_irqchip_state)
-			break;
-#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
-		data = data->parent_data;
-#else
-		data = NULL;
-#endif
-	} while (data);
+			if (chip->irq_set_irqchip_state)
+				break;
 
-	if (data)
-		err = chip->irq_set_irqchip_state(data, which, val);
+			data = irqd_get_parent_data(data);
+		} while (data);
 
-out_unlock:
-	irq_put_desc_busunlock(desc, flags);
-	return err;
+		if (data)
+			return chip->irq_set_irqchip_state(data, which, val);
+	}
+	return -EINVAL;
 }
 EXPORT_SYMBOL_GPL(irq_set_irqchip_state);
 

