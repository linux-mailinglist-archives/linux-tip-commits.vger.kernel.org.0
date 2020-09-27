Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45FB827A03A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 27 Sep 2020 11:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbgI0J14 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 27 Sep 2020 05:27:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726526AbgI0J11 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 27 Sep 2020 05:27:27 -0400
Date:   Sun, 27 Sep 2020 09:27:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601198845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBOi2QwA5UCY/kAab7c/wiFdeGtE71L+PEKIG/bOL94=;
        b=TEnkOGcGX+EQljZPZFPq13++8MAEPrZ6A2i2oo2Z2UctZT0Vv75ii9wqdtIpfOtl4yM4aQ
        gSp6ENJHBAAy9QcUtW7xX1QUuAZT3FEtMKTWoieXYWWRQUrBQvhtznnqS7ER6H+3TbLIvI
        QTKOPokzKNELCrm8lFa3Am7SX0dX/WijcCetuaa5BKDmJKM+ezQ9Rsv4JFzTqZnQwd2FKF
        SVCRJWcnaGXMX38l3NSjqIYmSi0/dZwr3P1yMRCqfNGz5e05alkwgoV6iPZYzRPWOtygmn
        tIuge7T74DDOykuq2ebS2YlI+8cEr6cTvDfQhncLRrbjEzN+2oznngP16itTPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601198845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NBOi2QwA5UCY/kAab7c/wiFdeGtE71L+PEKIG/bOL94=;
        b=hlIfU+FBYqu8JdUms+07zgLbG3gaDTqiYybdXV5BWt/n3X+i5/oqZM6rmbmYWMZcpQ4Vhj
        P9NkukaWK3SY8pDg==
From:   "tip-bot2 for Guo Ren" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] clocksource/drivers/timer-gx6605s: Fixup counter reload
Cc:     Guo Ren <guoren@linux.alibaba.com>,
        Xu Kai <xukai@nationalchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1597735877-71115-1-git-send-email-guoren@kernel.org>
References: <1597735877-71115-1-git-send-email-guoren@kernel.org>
MIME-Version: 1.0
Message-ID: <160119884457.7002.14184229326058068620.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     bc6717d55d07110d8f3c6d31ec2af50c11b07091
Gitweb:        https://git.kernel.org/tip/bc6717d55d07110d8f3c6d31ec2af50c11b07091
Author:        Guo Ren <guoren@linux.alibaba.com>
AuthorDate:    Tue, 18 Aug 2020 07:31:17 
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Mon, 24 Aug 2020 13:01:39 +02:00

clocksource/drivers/timer-gx6605s: Fixup counter reload

When the timer counts to the upper limit, an overflow interrupt is
generated, and the count is reset with the value in the TIME_INI
register. But the software expects to start counting from 0 when
the count overflows, so it forces TIME_INI to 0 to solve the
potential interrupt storm problem.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Tested-by: Xu Kai <xukai@nationalchip.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/1597735877-71115-1-git-send-email-guoren@kernel.org
---
 drivers/clocksource/timer-gx6605s.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-gx6605s.c b/drivers/clocksource/timer-gx6605s.c
index 80d0939..8d386ad 100644
--- a/drivers/clocksource/timer-gx6605s.c
+++ b/drivers/clocksource/timer-gx6605s.c
@@ -28,6 +28,7 @@ static irqreturn_t gx6605s_timer_interrupt(int irq, void *dev)
 	void __iomem *base = timer_of_base(to_timer_of(ce));
 
 	writel_relaxed(GX6605S_STATUS_CLR, base + TIMER_STATUS);
+	writel_relaxed(0, base + TIMER_INI);
 
 	ce->event_handler(ce);
 
