Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 892A0359BFA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 12:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233413AbhDIK1o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 06:27:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49584 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231638AbhDIK1k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 06:27:40 -0400
Date:   Fri, 09 Apr 2021 10:27:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617964046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaltpgMDeGU4w9J2XYFo9OnQVGcnxAtDf+M7s4qot8s=;
        b=1nJFkDMU6/H6eMiUP/63HAoqpyfKRR3E9r9lIVUX6oicVyeVB+AmmncrfPLbLXjmfIKgb3
        fSJF734E4DzU/otwsyhhrAO9/jledOv11C9KS+KJgwrmsow9hvHniAPfftWpAVhy7yHhWt
        dX4xGtQmRTnKK0tejAB93LJ9oG/VwKvMgzt35/UGprCvWV/bNbdk0VH9XKd6ifzxTOEjog
        y6xL7jgDw9E1jOtxoyRFfhkeuhlNzCzwm+1apS4Ki1YEaWjkpQjKV+M93Tne85hX4Q8gi1
        vEQUIwKH2j3JIbZ0fuQs1mxKK6QEQQUvEYX8AGZEbNkc1zALzvu+vKntag0xWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617964046;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UaltpgMDeGU4w9J2XYFo9OnQVGcnxAtDf+M7s4qot8s=;
        b=BrYMyW/fiSi1rEmHt3eav7uPVKXUw8Du6by9saT/oZ0kItzgKcMFLUosx1Gd1iOYQgtbhw
        EBsQiSvwBN8+gtDg==
From:   tip-bot2 for Jonathan =?utf-8?q?Neusch=C3=A4fer?= 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/npcm: Add support for WPCM450
Cc:     j.neuschaefer@gmx.net, Daniel Lezcano <daniel.lezcano@linaro.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210320181610.680870-11-j.neuschaefer@gmx.net>
References: <20210320181610.680870-11-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Message-ID: <161796404618.29796.1158087389947920908.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     690daddcb60246d8a510aaad7b954bcc53eba17e
Gitweb:        https://git.kernel.org/tip/690daddcb60246d8a510aaad7b954bcc53e=
ba17e
Author:        Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
AuthorDate:    Sat, 20 Mar 2021 19:16:06 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 08 Apr 2021 13:24:16 +02:00

clocksource/drivers/npcm: Add support for WPCM450

Add a compatible string for WPCM450, which has essentially the same
timer controller.

Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20210320181610.680870-11-j.neuschaefer@gmx.net
---
 drivers/clocksource/timer-npcm7xx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-npcm7xx.c b/drivers/clocksource/timer-=
npcm7xx.c
index 9780ffd..a00520c 100644
--- a/drivers/clocksource/timer-npcm7xx.c
+++ b/drivers/clocksource/timer-npcm7xx.c
@@ -208,5 +208,6 @@ static int __init npcm7xx_timer_init(struct device_node *=
np)
 	return 0;
 }
=20
+TIMER_OF_DECLARE(wpcm450, "nuvoton,wpcm450-timer", npcm7xx_timer_init);
 TIMER_OF_DECLARE(npcm7xx, "nuvoton,npcm750-timer", npcm7xx_timer_init);
=20
