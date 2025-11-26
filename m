Return-Path: <linux-tip-commits+bounces-7550-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C350C8A66D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:43:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 37D5F4ED06F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F41BA3093C6;
	Wed, 26 Nov 2025 14:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Avc3Qwfr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pL3XAiOz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AAE3081DF;
	Wed, 26 Nov 2025 14:40:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168050; cv=none; b=Q3Ab8YUYioQ4cx3l4YzH+h9XHlJxJcOIZtPjxFX/O30Upt1KCxm9gbWaBvlZLqdMld/65Rg+2CVnnEY0ioO3b/mkw0pl0waQZ6ppAstQOVLLy+GVucKDgkYdBCvhUwIPLSLAEVZBWiaD6iJGUqx4JmRlrVAvZUOeRBmkziQzA3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168050; c=relaxed/simple;
	bh=h+VDIP4/gp+E+wPtprqPdfK4SwrZ8Htp9zL8QxY1xhU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WLr89R9/ANyPBe+GDSHXzmBbZzPFFtqsjJWJqoG1j+96H/i4iGRLyBGo8BKzVupXKLy89B9Pqda6qxFkI6yr/43YnOi23Ha0g/la4yDOyH6C6QAcap7Pt3SKeqBkOpkcehGPMBpmMschtxhRk5XjvMjqKhNl9/GJmcMOwT5ExDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Avc3Qwfr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pL3XAiOz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/i8U5UcLUgCHAo/F+PDF+Z64l+JjuaNz4Y8qdUPvig=;
	b=Avc3QwfrE4jZVguKqIOhyNXFTl/DFKS9BtUEFKlzgTY82icYpm5pbr9YGlpbASV7r6JYKG
	X2h3JfPoWBVBlQY+eunKvoK5qlF4Obtt0LF3+RLnjyJorVc838UVJbA/ASrIgQ3SUKbgpE
	nX+fC5j2lbCrzt1THTjMCygKRR+VmRi2h5oDneJlkY/b7fKOdl2oSjprAJh2JFHJib0Kwl
	itQuhLy1KA/0N8j2jtyGqyvqbjxf+2jz6waLGBKWga7Nv1sVqa2ZcQCNo5mauA/tMeeMgt
	yJ+KsG3v2HYslflFblhMU7xPqquKIltj5KPsXmum798vcSfhKYfpjW2EeYLW4A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168047;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=N/i8U5UcLUgCHAo/F+PDF+Z64l+JjuaNz4Y8qdUPvig=;
	b=pL3XAiOzSrr32J+MOeM4JJ7GMTJmUt0Bo/V64vv2/TNDcP7vKrb8W6OZ5fgVbLElMMMbTZ
	fWhQVQ+wpLTZoBDQ==
From: "tip-bot2 for Stephen Eta Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/timer-sp804: Fix
 read_current_timer() issue when clock source is not registered
Cc: Stephen Eta Zhou <stephen.eta.zhou@gmail.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
References:
 <20250525-sp804-fix-read_current_timer-v4-1-87a9201fa4ec@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416804655.498.15475479090310855080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     640594a04f119338019b0aeed70c7301216595b3
Gitweb:        https://git.kernel.org/tip/640594a04f119338019b0aeed70c7301216=
595b3
Author:        Stephen Eta Zhou <stephen.eta.zhou@gmail.com>
AuthorDate:    Sun, 25 May 2025 16:43:28 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:24:32 +01:00

clocksource/drivers/timer-sp804: Fix read_current_timer() issue when clock so=
urce is not registered

Register a valid read_current_timer() function for the
SP804 timer on ARM32.

On ARM32 platforms, when the SP804 timer is selected as the clocksource,
the driver does not register a valid read_current_timer() function.
As a result, features that rely on this API=E2=80=94such as rdseed=E2=80=94co=
nsistently
return incorrect values.

To fix this, a delay_timer structure is registered during the SP804
driver's initialization. The read_current_timer() function is implemented
using the existing sp804_read() logic, and the timer frequency is reused
from the already-initialized clocksource.

Signed-off-by: Stephen Eta Zhou <stephen.eta.zhou@gmail.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20250525-sp804-fix-read_current_timer-v4-1-87a=
9201fa4ec@gmail.com
---
 drivers/clocksource/timer-sp804.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/clocksource/timer-sp804.c b/drivers/clocksource/timer-sp=
804.c
index cd1916c..e82a95e 100644
--- a/drivers/clocksource/timer-sp804.c
+++ b/drivers/clocksource/timer-sp804.c
@@ -21,6 +21,10 @@
 #include <linux/of_irq.h>
 #include <linux/sched_clock.h>
=20
+#ifdef CONFIG_ARM
+#include <linux/delay.h>
+#endif
+
 #include "timer-sp.h"
=20
 /* Hisilicon 64-bit timer(a variant of ARM SP804) */
@@ -102,6 +106,23 @@ static u64 notrace sp804_read(void)
 	return ~readl_relaxed(sched_clkevt->value);
 }
=20
+#ifdef CONFIG_ARM
+static struct delay_timer delay;
+static unsigned long sp804_read_delay_timer_read(void)
+{
+	return sp804_read();
+}
+
+static void sp804_register_delay_timer(int freq)
+{
+	delay.freq =3D freq;
+	delay.read_current_timer =3D sp804_read_delay_timer_read;
+	register_current_timer_delay(&delay);
+}
+#else
+static inline void sp804_register_delay_timer(int freq) {}
+#endif
+
 static int __init sp804_clocksource_and_sched_clock_init(void __iomem *base,
 							 const char *name,
 							 struct clk *clk,
@@ -114,6 +135,8 @@ static int __init sp804_clocksource_and_sched_clock_init(=
void __iomem *base,
 	if (rate < 0)
 		return -EINVAL;
=20
+	sp804_register_delay_timer(rate);
+
 	clkevt =3D sp804_clkevt_get(base);
=20
 	writel(0, clkevt->ctrl);
@@ -318,6 +341,7 @@ static int __init sp804_of_init(struct device_node *np, s=
truct sp804_timer *time
 		if (ret)
 			goto err;
 	}
+
 	initialized =3D true;
=20
 	return 0;

