Return-Path: <linux-tip-commits+bounces-6854-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id F1AEEBE2840
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:52:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 59BCD4FDDED
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE33631CA54;
	Thu, 16 Oct 2025 09:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0+8Bppqt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xsIupgbV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36CF631A576;
	Thu, 16 Oct 2025 09:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760608322; cv=none; b=bFsnnNQRo6MBfsL53w7FuTXFb5qVIWWDAa8iN0J9gCXjUKt5B8mQrDLJwcXUZueYEbe+aPwSjsoLbF9UYim02cbZR5EXXsHuHB2GnS7UeIgzWrA1vz4uXd2gif3rlI/OiI9FczFRtAfDxIjsD7fTRas9SHGW3E6Z3M81PkXlvAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760608322; c=relaxed/simple;
	bh=3UnTQYPU/rg//aB5OWgHbwsIbIKhmuuf4Mla+Khloqo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Tgf3Kh8XcX6Pn6RMWnkTt3eufWpk4NQuzWCV1DKBp9suqh6BW6wiIZoEsd+x1CkEF2nRHYTZ0Y24n8gJQh1hnHysXyv6NwES3oE4IAlsi8+VBRBQxabnXAwpAqWqQvfWAp5S9v683y3pZF+SJfrDlAimn02SvanBcdnMmuD4POM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0+8Bppqt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xsIupgbV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:51:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760608296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUkr8OHgeYd1a+iteSJxVfwklY4IDjBDTiuXnHKcvOE=;
	b=0+8BppqtMlSZUtGX+W6sLB62Se8Mc95J544RqPXyBOtX4LDcRu47iFQC3JVEA8vxuYMCrJ
	uE8ViXkm1GlsbJ3sg6YYWFZJO+MrwWECBXS+pEe0IrqFvgm+buTmsL6L+a0ywRt5UMcXDh
	9g9kdLEszKyDaNm4q1Vf0K3wj2EIKlAnvZPrVf2oDK2fyrSLIj2fAmPbilWgDcPyLGXBJh
	eTE5RgIxvqV6WnM3OQjd8je6nhRCCUhn0Gqs9s8to260ow+sJxzT4joemN1QrJ5C0SE/tX
	mK9G8EoI26WDrJ8uVj2/AFMsIESFGW18IZfe4LJ+2XY9f0luAicU9QIrVXeViQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760608296;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vUkr8OHgeYd1a+iteSJxVfwklY4IDjBDTiuXnHKcvOE=;
	b=xsIupgbVL+0d/5Mj+dR3P+E772ced7YK+P9+xHYL1Y8IYar+iZb3XIw0dTQi/WGoWV80DI
	shSuw1X4MqcOF3CA==
From: "tip-bot2 for Johan Hovold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/starfive-jh8100: Fix section mismatch
Cc: Johan Hovold <johan@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Changhuang Liang <changhuang.liang@starfivetech.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251013094611.11745-9-johan@kernel.org>
References: <20251013094611.11745-9-johan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060829544.709179.10444851952024536944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f798bdb9aa81c425184f92e3d0b44d3b53d10da7
Gitweb:        https://git.kernel.org/tip/f798bdb9aa81c425184f92e3d0b44d3b53d=
10da7
Author:        Johan Hovold <johan@kernel.org>
AuthorDate:    Mon, 13 Oct 2025 11:46:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 16 Oct 2025 11:30:38 +02:00

irqchip/starfive-jh8100: Fix section mismatch

Platform drivers can be probed after their init sections have been
discarded so the irqchip init callback must not live in init.

Fixes: e4e535036173 ("irqchip: Add StarFive external interrupt controller")
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Changhuang Liang <changhuang.liang@starfivetech.com>
---
 drivers/irqchip/irq-starfive-jh8100-intc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-starfive-jh8100-intc.c b/drivers/irqchip/irq=
-starfive-jh8100-intc.c
index 2460798..117f2c6 100644
--- a/drivers/irqchip/irq-starfive-jh8100-intc.c
+++ b/drivers/irqchip/irq-starfive-jh8100-intc.c
@@ -114,8 +114,7 @@ static void starfive_intc_irq_handler(struct irq_desc *de=
sc)
 	chained_irq_exit(chip, desc);
 }
=20
-static int __init starfive_intc_init(struct device_node *intc,
-				     struct device_node *parent)
+static int starfive_intc_init(struct device_node *intc, struct device_node *=
parent)
 {
 	struct starfive_irq_chip *irqc;
 	struct reset_control *rst;

