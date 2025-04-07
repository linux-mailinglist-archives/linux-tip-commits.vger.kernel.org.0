Return-Path: <linux-tip-commits+bounces-4722-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C09A7D6DE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:54:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6CD818839E1
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:54:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD98022A1E1;
	Mon,  7 Apr 2025 07:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zSJI+XLK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qRxDc2RR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064C92288E3;
	Mon,  7 Apr 2025 07:53:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012437; cv=none; b=NYRO0QWJtJMSV80febsK7sEV/J0t98K9nRETcQ6GQqOj8F1XryxDWxRKhqo/9Lg+yoAEBN6VvyDLvXuMopoBu6gsN0Y0Auq1GqazeUIXFOkwpIqFFG0w7D6t9XRkG20oCTVB0qNb7W+TsMSknXANe+1pL/Y1DmtB9YSlwDb7/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012437; c=relaxed/simple;
	bh=XY+Ifi72Of5QaaNfkouN4q7jrWNs8gcAg3+Z9YpjCyw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ceKsPewrLj7D7eT5cokPXcryeswZa81evMtYKnuSq6CFKDlG4UCOIntFEOyoVgSoaXlS1cvLqJVJcu9U4hRC9rLKOJo660AIX+8dVQ5eFUyTtWu2OLScBOjMOgfNAMn55cfPgVksD9zhaScKPKF2gp/mgw1dbito8biot3mR27E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zSJI+XLK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qRxDc2RR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744012433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVt18rSYNmX8MA9tzkgca2OI7mPY8D4CVW+Hwm9q2B4=;
	b=zSJI+XLKt+VbzEBK19i4Gsi5+Ykh5vdKnLxAXJLEZ474J/1Q3+ULhZOBCtXOPenOYBR9Ed
	zHPaEwzSLOHXx8MVrUAMGjQUzcDAbjjHvGJgjks0224YqwyobK3fruYUH21C4Dzqut6jjc
	THBPGiS1sCoediXdMPOlz17q5ZLD5439ilXoD0sEQegB/3EuLPlk1G4Kmq8dsA2Vtog8FP
	KH7lNHSUq3xVY5mzrSLmfLbElgoq7BlPpTYY0xUJDXqXw5+SXlSxIsikdHN5gubrU99A2m
	LhgzE93oj+b6K8mRCDqJ61QHePOC38pMmXR2PcED+y+TwF3mlBg06szuqUONqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744012433;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MVt18rSYNmX8MA9tzkgca2OI7mPY8D4CVW+Hwm9q2B4=;
	b=qRxDc2RRXSmy7lDf5Sq3RlKU0+ChUVQn9eZFk24wI+MXqkFjG6kcAXPTSyE3NWaGPBmKfl
	Pev2IbINlBsGxDBA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] soc: dove: Convert generic irqchip locking to guard()
Cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Lunn <andrew@lunn.ch>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313142524.137040686@linutronix.de>
References: <20250313142524.137040686@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401243190.31282.15872492945691322223.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b54bd5a29b428afff4a37c7b6e1df67e43c327c3
Gitweb:        https://git.kernel.org/tip/b54bd5a29b428afff4a37c7b6e1df67e43c327c3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 15:31:21 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:43:19 +02:00

soc: dove: Convert generic irqchip locking to guard()

Conversion was done with Coccinelle. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250313142524.137040686@linutronix.de

---
 drivers/soc/dove/pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/soc/dove/pmu.c b/drivers/soc/dove/pmu.c
index 6202dbc..795802b 100644
--- a/drivers/soc/dove/pmu.c
+++ b/drivers/soc/dove/pmu.c
@@ -257,10 +257,9 @@ static void pmu_irq_handler(struct irq_desc *desc)
 	 * So, let's structure the code so that the window is as small as
 	 * possible.
 	 */
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	done &= readl_relaxed(base + PMC_IRQ_CAUSE);
 	writel_relaxed(done, base + PMC_IRQ_CAUSE);
-	irq_gc_unlock(gc);
 }
 
 static int __init dove_init_pmu_irq(struct pmu_data *pmu, int irq)

