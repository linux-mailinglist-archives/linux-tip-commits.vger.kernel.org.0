Return-Path: <linux-tip-commits+bounces-6754-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E924EBA1996
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 105F64C1055
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:38:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F72332CF82;
	Thu, 25 Sep 2025 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h/oHVkLa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yWS1gAfq"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BAEA32C321;
	Thu, 25 Sep 2025 21:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836020; cv=none; b=puxR2CE132yg0gLrOPhRSvnOX7q4XbazCMjiRn+Zh68kEoLXPAY3fgoD/qeDuFAf/e25zSKDUBNN6DP5NjPujNQQRttg+pMu7jylyCI75lYb3HmQyzL3/O90CGb2fS/U3RI6U3JtbOJHifXwoVtQDMDrOl5lYPQn9fZg2Pvekkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836020; c=relaxed/simple;
	bh=389C1W1YkDZQhpCkmhZCWm3oGD3tcgKbvvXuO5oHw6c=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=VmXs+P20uhqaPzKwr5u7ENcy4t9pneVZZ0p7N7ZyDYPR5Iooj3yONkBcApZgoWSkIhmIa38BOPxivHFz5LTjJSPv4K9nAaF/xnKUsPTHHGlb0CemDtZ4uqIpD4/aj9u7/8XokjrNWqi/Wi683Ez7Wq9GraRYD/hFtYuQTYPFbsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h/oHVkLa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yWS1gAfq; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XI1DvksrzJAPQ1N6ofo3wp8Ml8uH77Vei3nF3jLclDI=;
	b=h/oHVkLaHqEpTa9o0EOyidct2WNHem3VzHVG4jXRgCpV7mWhS/s4up4v8jGgm8C5NpwUfB
	NYhnRjrgj2zbYQyONxvrw5OiKh11KshwVcrvCE93ErvETCO/ikz1+dFBujf/g9nwgaGs8X
	Ent58zC1lKa3yw9Ve7u63R8AkwmEo2MJh2POs3aNzeNKNtz9Ja+UVjQaCennriHkkYGmRD
	fqW2XvqGmwHf/srqnQl6uYMdF+uRP0NRJ72Di54kYEnRjWFYEs7hdjhdme5XJxWqAOn0MY
	Y0XYTNGIzUupsDCr/NnGRv8p5xRblVQ0ji7BYrfRjPWRJwczfTIcNblDYk6Yzw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836015;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XI1DvksrzJAPQ1N6ofo3wp8Ml8uH77Vei3nF3jLclDI=;
	b=yWS1gAfqKT7PH3NyxNf6yNtHyf6XVgtKBK0rgpyLX8xZVRC6y/iJkjyDZ4mktowB6ZRXkw
	YvChWZC4iK/LzDAw==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Pass the cpu
 number as parameter
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601427.709179.4816661210666485950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     995ebf16043392d131bd22ed8484c9c952bfb45f
Gitweb:        https://git.kernel.org/tip/995ebf16043392d131bd22ed8484c9c952b=
fb45f
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:23 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:28:50 +02:00

clocksource/drivers/vf-pit: Pass the cpu number as parameter

In order to initialize the timer with a cpumask tied to a cpu, let's
pass it as a parameter instead of hardwiring it in the init function.

No functional changes intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-6-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-vf-pit.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index 6a5f940..9f3b72b 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -147,7 +147,7 @@ static irqreturn_t pit_timer_interrupt(int irq, void *dev=
_id)
 }
=20
 static int __init pit_clockevent_init(struct pit_timer *pit, void __iomem *b=
ase,
-				      unsigned long rate, int irq)
+				      unsigned long rate, int irq, unsigned int cpu)
 {
 	/*
 	 * The channels 0 and 1 can be chained to build a 64-bit
@@ -163,7 +163,7 @@ static int __init pit_clockevent_init(struct pit_timer *p=
it, void __iomem *base,
 	BUG_ON(request_irq(irq, pit_timer_interrupt, IRQF_TIMER | IRQF_IRQPOLL,
 			   "VF pit timer", &pit->ced));
=20
-	pit->ced.cpumask =3D cpumask_of(0);
+	pit->ced.cpumask =3D cpumask_of(cpu);
 	pit->ced.irq =3D irq;
=20
 	pit->ced.name =3D "VF pit timer";
@@ -221,6 +221,6 @@ static int __init pit_timer_init(struct device_node *np)
 	if (ret)
 		return ret;
=20
-	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq);
+	return pit_clockevent_init(&pit_timer, timer_base, clk_rate, irq, 0);
 }
 TIMER_OF_DECLARE(vf610, "fsl,vf610-pit", pit_timer_init);

