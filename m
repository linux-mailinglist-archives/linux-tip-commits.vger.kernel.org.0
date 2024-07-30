Return-Path: <linux-tip-commits+bounces-1839-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6BF9410DD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 13:41:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF73A1C23249
	for <lists+linux-tip-commits@lfdr.de>; Tue, 30 Jul 2024 11:41:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24CA41A08B5;
	Tue, 30 Jul 2024 11:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aXEArmv/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eOM6magF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC46B1A01BE;
	Tue, 30 Jul 2024 11:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722339609; cv=none; b=N944QFEgQ1+bQ9+2uiGo5ql5re+vbYr0/NWbn83ncYyP1NOn7jyDU9kJzcUbqo7/I5sbAaZqklnr1lcTZi5cy/rymniJmLorsPnAzd1eQTOkzODcinhnVUcJnqgSePiXiTFYDSpCYBny1NRjVpbgt4XPcriTS4blzNgg2+uVeKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722339609; c=relaxed/simple;
	bh=PQSfRIsmghVg0p5Ywkc5JYN2in72lL0Tms0Qd62Qbac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZmLH57jYMXHvd/vf5B8FYT2+nCCmwCzMQTD3WuZ7Ol4UH4uJz5sf+V3AdvvpjyQnC6G5ZCU2vENaI8ERnEvjGnsYQIMqhjT17fP/iCwGaLNi1yl4tT0vdT70aXOWGEBrmyWKjGPvQ/3hM/DdOdc6fdRAUIfYfzsDVRMmLacMuKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aXEArmv/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eOM6magF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 30 Jul 2024 11:40:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/u/TITC/bZEHcs9goBpi3KAdIw6YSlpJnDJEatibp70=;
	b=aXEArmv/HeAt0GOfe6MkJVq3Wm3XPLPfQi87kHp9ND0e+aNBEUaL2pV92WfObksSXDN3iC
	FNoumHYa0mpbtsPHpE1NVjwrxqRv7+HNGo6OwKxwoE9h7PCLNoSHPYNbQ6xTRoBpBM8Ca3
	T7OsIXTALNbM5h1HJ/LWRHXXoN2nEI1tBIKwL8hIxDUVOAP1ACWOC+wQI56zfLKGhDXJFn
	yOPehz5wcuPv1PmfxIWdXupjqaioctHTurJhQsUXZR9cHpguYBWkBLoWUvjnF8ZeeuB1UY
	RjUEOVS7d9JfbShHJIS+StCpoZ+ZYocpLFDkq1ao7Y7jjhxFH2OIeJm/+/Ljvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722339603;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/u/TITC/bZEHcs9goBpi3KAdIw6YSlpJnDJEatibp70=;
	b=eOM6magFr2JM+ocnRGfoNhDkp3cFoQT4cU1bqI4VxtNSeZgd4dgP/TEgKsct2FBqFEUn1v
	O7zgRtmuaM/eq6Dw==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Simplify is_percpu_irq() code
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240708151801.11592-9-kabel@kernel.org>
References: <20240708151801.11592-9-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172233960288.2215.8459518329511417278.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ccef3a991b7c972cccce4aee8e62f70e3a706e78
Gitweb:        https://git.kernel.org/tip/ccef3a991b7c972cccce4aee8e62f70e3a7=
06e78
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 30 Jul 2024 13:35:46 +02:00

irqchip/armada-370-xp: Simplify is_percpu_irq() code

Simplify the code in the is_percpu_irq() function. Instead of
  if (condition)
    return true;
  return false;
simply return condition.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240708151801.11592-9-kabel@kernel.org


---
 drivers/irqchip/irq-armada-370-xp.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index b9631cc..cfd6dc8 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -201,10 +201,7 @@ static inline unsigned int msi_doorbell_end(void)
=20
 static inline bool is_percpu_irq(irq_hw_number_t irq)
 {
-	if (irq <=3D MPIC_MAX_PER_CPU_IRQS)
-		return true;
-
-	return false;
+	return irq <=3D MPIC_MAX_PER_CPU_IRQS;
 }
=20
 /*

