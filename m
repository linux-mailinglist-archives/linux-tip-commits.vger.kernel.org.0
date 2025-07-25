Return-Path: <linux-tip-commits+bounces-6204-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ACDCB11C79
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:34:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 872FFAE1A9A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E1072E9EC0;
	Fri, 25 Jul 2025 10:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gssSULd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9LLExSow"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38222E7178;
	Fri, 25 Jul 2025 10:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439509; cv=none; b=Cmzamd51sxFR1or9Cxq6cfGr4P/fkPSiKIuZhr5rex/yGFAoX27iTqnX7SNvCeY1ehYCQsDy3idGCn1pKszRypZmH4GQPQLsgNFVSXs4TbAzh0l+/i+IZUGbI4XNtX2KYaRC/fR9y8FjtE1Ps/4Gn4G7ATpIb+pDREVkZuJZE/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439509; c=relaxed/simple;
	bh=/DOEIxyt4RAY70E47UFybyQWSzVtdb65MpLjpjczhlw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=c1Zy4keOixd25q2c0MehzWXV1WqauRC/D4WmpQIAn4IUjZtU04n8uxhM1apmd1S4fMFEf+/aNfedj616PNR+iqKLNreUUVfwS6PgG+SnonOBal21bcsyKVyaj1qvV0bPkF0hp8XfuYsEErv3LkF1yuG+pVrubOp2cC4Zr8ZoHhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gssSULd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9LLExSow; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqGKlHHd+GwrOj+mchnq2PVQc8sjicTLqvKJojMnd7I=;
	b=2gssSULdrfpu3ocbcbLyAUD5gAAavn/sqzU4G7HfJ6UzbbUyXP1d8ygp7uOoqztpo+yp3/
	sxbtFtnKM0qiBNNWCvg2pyZ17C+46QUS1I9IrgHxDxkB3ziontDYz3v4cFhuhi1ZBAVWZi
	XrAA+4cTWtp7RJ8K3RALCcUGGqRXz6lCw7/avb3Dx3tE+4obixihh0jkw8uNqMXo1BKmRJ
	jf5TO0LaC7MTPaHdFYYL1cjugoRpb6eGURLose8ei9DoCXTJPP2sZrFLJTg1AF8bhiuEqH
	K1d4zU+IiwpES8vZ/yfPXP/FNlkuLq2LB6J1ZNa5vPG0t9QyEX3pSldDxYH+mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439506;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qqGKlHHd+GwrOj+mchnq2PVQc8sjicTLqvKJojMnd7I=;
	b=9LLExSowVeHDlNOfTiUgJ7jyzO5zo+G+LPYxkDRLxmFK0AzmgUN/IgFV0oUHhUsTRDvC7m
	jK6X3IXlQ3e6vIBA==
From: "tip-bot2 for Will McVicker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] of/irq: Export of_irq_count() for modules
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Youngmin Nam <youngmin.nam@samsung.com>,
 Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>,
 "Rob Herring (Arm)" <robh@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250620181719.1399856-2-willmcvicker@google.com>
References: <20250620181719.1399856-2-willmcvicker@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343950475.1420.4492109262821874023.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     8de1de5a3a8d42975953382068fb5195e9d6e6c6
Gitweb:        https://git.kernel.org/tip/8de1de5a3a8d42975953382068fb5195e9d=
6e6c6
Author:        Will McVicker <willmcvicker@google.com>
AuthorDate:    Fri, 20 Jun 2025 11:17:04 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 12:05:10 +02:00

of/irq: Export of_irq_count() for modules

Need to export of_irq_count() in preparation for modularizing the Exynos
MCT driver which uses this API for setting up the timer IRQs.

Signed-off-by: Will McVicker <willmcvicker@google.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Youngmin Nam <youngmin.nam@samsung.com>
Reviewed-by: Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane=
.org>
Reviewed-by: Youngmin Nam <youngmin.nam@samsung.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/r/20250620181719.1399856-2-willmcvicker@google.=
com
---
 drivers/of/irq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/irq.c b/drivers/of/irq.c
index f8ad79b..5adda1d 100644
--- a/drivers/of/irq.c
+++ b/drivers/of/irq.c
@@ -519,6 +519,7 @@ int of_irq_count(struct device_node *dev)
=20
 	return nr;
 }
+EXPORT_SYMBOL_GPL(of_irq_count);
=20
 /**
  * of_irq_to_resource_table - Fill in resource table with node's IRQ info

