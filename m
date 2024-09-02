Return-Path: <linux-tip-commits+bounces-2145-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C78F89683FA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2024 12:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A4E0B22A77
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2024 10:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4228A13D24C;
	Mon,  2 Sep 2024 10:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JRqXN7q7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AeYWcDLQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567391311B6;
	Mon,  2 Sep 2024 10:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725271364; cv=none; b=qUpwibdShRUdB8Cf3YqplKfkzOD/TALFhZBpfKoh3cswGDbT/u+5fKVXgnLYCZxiuv3lxdd0CWXqCjGA6jQUOtq4yyu7ojP/h677x6Sh11fCn0vX+xNNm/dg4yDd5XZ8su7ZktJvMizpxex2FB9e/mpRRDg1q6Sg+kDhYTwBdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725271364; c=relaxed/simple;
	bh=d2hU7rnuo7gfy/3r7euyZcgH8SeIvYVEG6GREuEUjCs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=au81SHCiKAekvBHYXS3H7DVm1S3sgawvfA1V/0oBZGxpOZ5vf+tnH8+Vg8pPWSyOGIH2eGRNtPWmTVSU0MCH/DBDnT0kiJ6BEAgY7ND8KpXw9T9ECt3rp4UIeG1XRazBO/N4Tz0z+R9iYF+yCqnShZV+ap8qYt3iALHFXQQ7PTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JRqXN7q7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AeYWcDLQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Sep 2024 10:02:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3X6ciucGm5K2x2QxsPaUDIpCdAEx6UjMmjD2riYUOI=;
	b=JRqXN7q7jV56rOLdwBP9zeLMeP5LSAODb0E9JXqoyJ9UrNsSkFZU9NuH7gqvxki/5KaTMr
	75PXVEUQ09J7YHH0p4+d0f2S+6TScDxwHmiYtf0Fq+tLzfDIaYLWHaH4kVKaUUjsKL/XTg
	hbYaFz0fg6S6urz5a9V/EfYCwme0EPLXXi33lTKjKfchegqOPg54XHll05pij/WjgKcFJH
	ncYNVgoSdtadG/P1slbIjVh0/wNxG8eqjZCkTzdyhrpxIiXO6WgHl3FOHrULPJALoQhHlJ
	Jv/PMT/xVvxvm5MUihD52pXxcM9ZYymc/w1OS39yTrEh14VwYUYQndJowwn1mg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725271360;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x3X6ciucGm5K2x2QxsPaUDIpCdAEx6UjMmjD2riYUOI=;
	b=AeYWcDLQ0wHN0ihDvBdqXP+r4ikKHpS3uMzjBzPCctUPn1VXDnM9usiiySvLhWOV94YbCz
	xo+x+a31nFV2dsCQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/timer-of: Remove percpu irq
 related code
Cc: Uros Bizjak <ubizjak@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240819100335.2394751-1-daniel.lezcano@linaro.org>
References: <20240819100335.2394751-1-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172527136025.2215.3702618846115407763.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     471ef0b5a8aaca4296108e756b970acfc499ede4
Gitweb:        https://git.kernel.org/tip/471ef0b5a8aaca4296108e756b970acfc49=
9ede4
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 19 Aug 2024 12:03:35 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 02 Sep 2024 10:04:15 +02:00

clocksource/drivers/timer-of: Remove percpu irq related code

GCC's named address space checks errors out with:

drivers/clocksource/timer-of.c: In function =E2=80=98timer_of_irq_exit=E2=80=
=99:
drivers/clocksource/timer-of.c:29:46: error: passing argument 2 of
=E2=80=98free_percpu_irq=E2=80=99 from pointer to non-enclosed address space
  29 |                 free_percpu_irq(of_irq->irq, clkevt);
     |                                              ^~~~~~
In file included from drivers/clocksource/timer-of.c:8:
./include/linux/interrupt.h:201:43: note: expected =E2=80=98__seg_gs void *=
=E2=80=99
but argument is of type =E2=80=98struct clock_event_device *=E2=80=99
 201 | extern void free_percpu_irq(unsigned int, void __percpu *);
     |                                           ^~~~~~~~~~~~~~~
drivers/clocksource/timer-of.c: In function =E2=80=98timer_of_irq_init=E2=80=
=99:
drivers/clocksource/timer-of.c:74:51: error: passing argument 4 of
=E2=80=98request_percpu_irq=E2=80=99 from pointer to non-enclosed address spa=
ce
  74 |                                    np->full_name, clkevt) :
     |                                                   ^~~~~~
./include/linux/interrupt.h:190:56: note: expected =E2=80=98__seg_gs void *=
=E2=80=99
but argument is of type =E2=80=98struct clock_event_device *=E2=80=99
 190 |                    const char *devname, void __percpu *percpu_dev_id)

Sparse warns about:

timer-of.c:29:46: warning: incorrect type in argument 2 (different address sp=
aces)
timer-of.c:29:46:    expected void [noderef] __percpu *
timer-of.c:29:46:    got struct clock_event_device *clkevt
timer-of.c:74:51: warning: incorrect type in argument 4 (different address sp=
aces)
timer-of.c:74:51:    expected void [noderef] __percpu *percpu_dev_id
timer-of.c:74:51:    got struct clock_event_device *clkevt

It appears the code is incorrect as reported by Uros Bizjak:

"The referred code is questionable as it tries to reuse
the clkevent pointer once as percpu pointer and once as generic
pointer, which should be avoided."

This change removes the percpu related code as no drivers is using it.

[Daniel: Fixed the description]

Fixes: dc11bae785295 ("clocksource/drivers: Add timer-of common init routine")
Reported-by: Uros Bizjak <ubizjak@gmail.com>
Tested-by: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20240819100335.2394751-1-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-of.c | 17 ++++-------------
 drivers/clocksource/timer-of.h |  1 -
 2 files changed, 4 insertions(+), 14 deletions(-)

diff --git a/drivers/clocksource/timer-of.c b/drivers/clocksource/timer-of.c
index c3f54d9..420202b 100644
--- a/drivers/clocksource/timer-of.c
+++ b/drivers/clocksource/timer-of.c
@@ -25,10 +25,7 @@ static __init void timer_of_irq_exit(struct of_timer_irq *=
of_irq)
=20
 	struct clock_event_device *clkevt =3D &to->clkevt;
=20
-	if (of_irq->percpu)
-		free_percpu_irq(of_irq->irq, clkevt);
-	else
-		free_irq(of_irq->irq, clkevt);
+	free_irq(of_irq->irq, clkevt);
 }
=20
 /**
@@ -42,9 +39,6 @@ static __init void timer_of_irq_exit(struct of_timer_irq *o=
f_irq)
  * - Get interrupt number by name
  * - Get interrupt number by index
  *
- * When the interrupt is per CPU, 'request_percpu_irq()' is called,
- * otherwise 'request_irq()' is used.
- *
  * Returns 0 on success, < 0 otherwise
  */
 static __init int timer_of_irq_init(struct device_node *np,
@@ -69,12 +63,9 @@ static __init int timer_of_irq_init(struct device_node *np,
 		return -EINVAL;
 	}
=20
-	ret =3D of_irq->percpu ?
-		request_percpu_irq(of_irq->irq, of_irq->handler,
-				   np->full_name, clkevt) :
-		request_irq(of_irq->irq, of_irq->handler,
-			    of_irq->flags ? of_irq->flags : IRQF_TIMER,
-			    np->full_name, clkevt);
+	ret =3D request_irq(of_irq->irq, of_irq->handler,
+			  of_irq->flags ? of_irq->flags : IRQF_TIMER,
+			  np->full_name, clkevt);
 	if (ret) {
 		pr_err("Failed to request irq %d for %pOF\n", of_irq->irq, np);
 		return ret;
diff --git a/drivers/clocksource/timer-of.h b/drivers/clocksource/timer-of.h
index a5478f3..01a2c6b 100644
--- a/drivers/clocksource/timer-of.h
+++ b/drivers/clocksource/timer-of.h
@@ -11,7 +11,6 @@
 struct of_timer_irq {
 	int irq;
 	int index;
-	int percpu;
 	const char *name;
 	unsigned long flags;
 	irq_handler_t handler;

