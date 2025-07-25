Return-Path: <linux-tip-commits+bounces-6209-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D0860B11C82
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94EA64E17AB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76EF2EBDD6;
	Fri, 25 Jul 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rhrVvtC4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rtBmhtZY"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F152EBB80;
	Fri, 25 Jul 2025 10:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439515; cv=none; b=k4sGJWivBRaW53cv9M7bwUS+9oOxsp/kNOTj8d9yje7TsZUzbvBU84uLCOGg36EzzOyLUHSOGKqPeXvlJqiE+G43PYx48cYzYoaBcteD0eBIyBld1CNa2+3BYZRGAxh30+t5YE2tHOHNh8L/Yq+epTY7a5xS7hBE4IH9olposYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439515; c=relaxed/simple;
	bh=Dh4pWqG5E/qhJ5H4g4bjNEyKYRq7ksiMK2fVg4Z6bAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AjvILUcTFM1/Ko7aZ06p15OfGtHIHML8WfG0OCLeu9hHV/WixkMCzP/9nVi8HBkc+6mpXpsph6WJjzkbIzgbjqS6FU+2+u94T6X1Nm+K+iPnFuIqHcNAmdc0/njjb7ZR+g7Hm2twmXWeBHxNoWSyNiSdQBTRHSIA0qDZ1hVEc8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rhrVvtC4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rtBmhtZY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5T6HfQr9CJm8+OTTaV/BfU2pJ6bcFI6pvTXGHXM6yQ=;
	b=rhrVvtC4h+38qVAR15+8/9AbzhScVBciwZavMyRuxq4KA17x5oQm4QyGYTGPzgQt9/vhhP
	7XWqw0h4MMTNhGTmYollsOGeaOHxe40YrO9/XqSbKTDNiDrcTYPfXUP3a5zaycMjhrktir
	RkW0TrCFeI+UioDbyIl/m47e4W1UyDnypcoRuTeNPFiMuD2DmGyX/1SHNNRv6ds1uRN+vp
	s/HlSDOgNEkyaHBCaQHaLQaQRTto3U5NrEzV1tvCF6GlHUgXb7v/xG5O2ArFHnRdPFouiC
	NxwSWz4BfKZFYnlHWyXxr/hukAOPahTzAbNX0jqCEwe/3Y8m3nbOhGMa1FVl1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439512;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R5T6HfQr9CJm8+OTTaV/BfU2pJ6bcFI6pvTXGHXM6yQ=;
	b=rtBmhtZYwrC+NnRwcY4JYg7hzM/Rok8scqJY0hwR8BgmDa6nQar479GApxptkC3PCl5ILe
	7ip4CVSaQuAmoYAA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/cs5535: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-7-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-7-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343951163.1420.12437468970723093021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     667b41e7364742120484ed5cca73d7cd77f3b10e
Gitweb:        https://git.kernel.org/tip/667b41e7364742120484ed5cca73d7cd77f=
3b10e
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:50 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:43:38 +02:00

clocksource/drivers/cs5535: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-7-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-cs5535.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-cs5535.c b/drivers/clocksource/timer-c=
s5535.c
index d47acfe..8af666c 100644
--- a/drivers/clocksource/timer-cs5535.c
+++ b/drivers/clocksource/timer-cs5535.c
@@ -101,6 +101,7 @@ static struct clock_event_device cs5535_clockevent =3D {
 	.tick_resume =3D mfgpt_shutdown,
 	.set_next_event =3D mfgpt_next_event,
 	.rating =3D 250,
+	.owner =3D THIS_MODULE,
 };
=20
 static irqreturn_t mfgpt_tick(int irq, void *dev_id)

