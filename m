Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420A22D86B6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:10:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438918AbgLLM7w (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 07:59:52 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41368 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438903AbgLLM7d (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:33 -0500
Date:   Sat, 12 Dec 2020 12:58:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIH9RBM6w1uHKgwf2MxqPV0kICztpCuzgPZBkypU000=;
        b=HHFjCSqGSaWY/KNzbYo2kJiseD86B5sKa8tdDQdD3GCPR/lFMnAurDwtyuauIvxyGNXkri
        RGKU1zaQUfmSdLVT+TV7bW666zSt8Bfa6/rrVCtMdl1Z0oYlOF3jZ7xvyBXxkx7uTtX1Et
        2iWNag9m9ARRu3oPTwenN1VlMWPi4yr53gjH69hQVtWBspW1lcoext9/xMZklsvHZnafa7
        6o10hHgLzH7bzJQ5aBHDHb33yjTDu3ffn6JP/6ZM+w/lFmmOCVZ7KoxfyeWu1RH+e/XCw0
        KYy6UtLhQRmCnTXX/0dih44Oiq0gurz02FLhmhYk9XQrQyoolZe3yp+j+L5NfQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eIH9RBM6w1uHKgwf2MxqPV0kICztpCuzgPZBkypU000=;
        b=CrXE3+cYHvb5yZ+X6DyGZsK1sEfqrSD7/1sPoCPEqHv3ZsbgTg515pM+4VpJQzC7r50s4v
        gIYLa7D2lv5xKPDA==
From:   "tip-bot2 for Keqian Zhu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/arm_arch_timer: Correct fault
 programming of CNTKCTL_EL1.EVNTI
Cc:     Marc Zyngier <maz@kernel.org>, Keqian Zhu <zhukeqian1@huawei.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201204073126.6920-3-zhukeqian1@huawei.com>
References: <20201204073126.6920-3-zhukeqian1@huawei.com>
MIME-Version: 1.0
Message-ID: <160777793029.3364.11017925799580259560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     8b7770b877d187bfdae1eaf587bd2b792479a31c
Gitweb:        https://git.kernel.org/tip/8b7770b877d187bfdae1eaf587bd2b792479a31c
Author:        Keqian Zhu <zhukeqian1@huawei.com>
AuthorDate:    Fri, 04 Dec 2020 15:31:26 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Sat, 05 Dec 2020 19:34:04 +01:00

clocksource/drivers/arm_arch_timer: Correct fault programming of CNTKCTL_EL1.EVNTI

ARM virtual counter supports event stream, it can only trigger an event
when the trigger bit (the value of CNTKCTL_EL1.EVNTI) of CNTVCT_EL0 changes,
so the actual period of event stream is 2^(cntkctl_evnti + 1). For example,
when the trigger bit is 0, then virtual counter trigger an event for every
two cycles.

While we're at it, rework the way we compute the trigger bit position
by making it more obvious that when bits [n:n-1] are both set (with n
being the most significant bit), we pick bit (n + 1).

Fixes: 037f637767a8 ("drivers: clocksource: add support for ARM architected timer event stream")
Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Keqian Zhu <zhukeqian1@huawei.com>
Acked-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20201204073126.6920-3-zhukeqian1@huawei.com
---
 drivers/clocksource/arm_arch_timer.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/arm_arch_timer.c b/drivers/clocksource/arm_arch_timer.c
index 777d38c..d017782 100644
--- a/drivers/clocksource/arm_arch_timer.c
+++ b/drivers/clocksource/arm_arch_timer.c
@@ -822,15 +822,24 @@ static void arch_timer_evtstrm_enable(int divider)
 
 static void arch_timer_configure_evtstream(void)
 {
-	int evt_stream_div, pos;
+	int evt_stream_div, lsb;
+
+	/*
+	 * As the event stream can at most be generated at half the frequency
+	 * of the counter, use half the frequency when computing the divider.
+	 */
+	evt_stream_div = arch_timer_rate / ARCH_TIMER_EVT_STREAM_FREQ / 2;
+
+	/*
+	 * Find the closest power of two to the divisor. If the adjacent bit
+	 * of lsb (last set bit, starts from 0) is set, then we use (lsb + 1).
+	 */
+	lsb = fls(evt_stream_div) - 1;
+	if (lsb > 0 && (evt_stream_div & BIT(lsb - 1)))
+		lsb++;
 
-	/* Find the closest power of two to the divisor */
-	evt_stream_div = arch_timer_rate / ARCH_TIMER_EVT_STREAM_FREQ;
-	pos = fls(evt_stream_div);
-	if (pos > 1 && !(evt_stream_div & (1 << (pos - 2))))
-		pos--;
 	/* enable event stream */
-	arch_timer_evtstrm_enable(min(pos, 15));
+	arch_timer_evtstrm_enable(max(0, min(lsb, 15)));
 }
 
 static void arch_counter_set_user_access(void)
