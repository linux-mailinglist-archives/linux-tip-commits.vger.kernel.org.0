Return-Path: <linux-tip-commits+bounces-6769-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6682BA19DE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0686E1C82562
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 122DB33086D;
	Thu, 25 Sep 2025 21:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DOxYbY36";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9M+djvOT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5245B3233E3;
	Thu, 25 Sep 2025 21:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836038; cv=none; b=oSxWJBIXyH0uNegef6XkP3bTug+1tO/+mgnz47l+8+HzvVaoSOp/MSrgl285OBthIvKlU0OKYVMsSlyxQefSqGGh7okUa1HEHyxOAqPG9BJKtyEoRRAdb2ZEP3wAy4Om00wf2PmB5P7YE8F1HfhSN8sWLBe1qQMqORI5fftafQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836038; c=relaxed/simple;
	bh=o9QJpBKeJAW4HmkQh9rb6eJZD3A7ytv3Ef0KOy9BG8A=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=gemaRn7mPDzDY3exle9cU6A1q+Xz1FazBf7XK38vR/bui4YJuGojHGBrgwWkWC0VENbi801ideu88z1E14tjRSOxy2SKjLcWb9pziIPPF36r6zDt17uK0F37hZ6wpY49L2Bc3maA5ihXJLSZKlu0PnhBVwGkOcJVfP5UCJYbbys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DOxYbY36; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9M+djvOT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cAE8pTxRGRHGZnpImjXGPW1ObURvjQfDI7iLfL/ixes=;
	b=DOxYbY36DB8eWlN3j42cLBAinNw+2LDwkB53AMoPV75Wvum6pnjQ1vXSUD9rmXAikQTHA9
	/nyc+JYIFz+Fw/9ZfgxjVNTWn7SKRS8USbUsH5U7CJAiREoSyKbWCIXPI75QVd/5gKnjZD
	EbesglRk7wKRvQH0OCOACvnE0hOTOGImxQTgWeh5EYJ9gKy0yDrgrDb1TGO75ovoLE/qWM
	yXQRR/VKt6eEf/YSD73QvQCJ19K7jzzYAZWpo+mxGtI0Ne4apRwmZiXg97L0kv8PYOOTfX
	9DUcIA1XaXCehS8+3GecnH7hzqsKzxOk+RaFG0gflQTVex69Ri3fWDvJRKcOGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836035;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cAE8pTxRGRHGZnpImjXGPW1ObURvjQfDI7iLfL/ixes=;
	b=9M+djvOT0qat79qsQr8gQuDMAGg11511in0y9nCeMw+PTaPxBivZ6jMcTEMzOcuvJVDksJ
	QqpRK7d42KybJICg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/cs5535: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603385.709179.10113230638776505878.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     eea65574e259f812e84080d56eca51f1a1889f8c
Gitweb:        https://git.kernel.org/tip/eea65574e259f812e84080d56eca51f1a18=
89f8c
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:50 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:52:23 +02:00

clocksource/drivers/cs5535: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with the clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
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

