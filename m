Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A90DC2D7371
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391804AbgLKKJD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:03 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33658 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2394189AbgLKKIb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:31 -0500
Date:   Fri, 11 Dec 2020 10:07:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBvGKPV2OVTCkl+8K+EDqN/wn4WkHTO9C6ic/8Pxb8I=;
        b=UjsQan7NBXyp/wbWAGk+bBhvgaEMYJxFMYePjZez7fk8A4zWr612R0Ua8lZpZNvi1uXIW6
        TaTpt0jqTctdEVkbEYZvdBDMKkc1+pP7VvYuPlJ0ApXXwNixjAd7EY4zc1NdGiKk1RvIil
        Hx0NGgNzXBYRJ8nBSFuaBuXJeP3ZXeW15gZq9Cv/psTZA6YxsBRl3mABklcxaI0atgjFMv
        gdULIilinFmit0c5glBCOXvX446SW18CHDxYLR6J76bDql6pipArXCbSwZXFD6QXAKhvx0
        8yOIf7sYumlYXwj0V1DdnzLw1tjKEft6Nb3V7J8YB7MgErFAhGIs0Qk66y54kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SBvGKPV2OVTCkl+8K+EDqN/wn4WkHTO9C6ic/8Pxb8I=;
        b=sUHGLKxzlBZloX/azEl7qVTNEBMSHgWfSSV4DklCIPwvSw48VrvjZviH5aCVnqcfHv/vcz
        rrGaMjwN6N9rqvDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rtc: core: Make the sync offset default more realistic
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220541.960333166@linutronix.de>
References: <20201206220541.960333166@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126856.3364.5793452465667820989.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     354c796b9270eb4780e59e3bdb83a3ae4930a832
Gitweb:        https://git.kernel.org/tip/354c796b9270eb4780e59e3bdb83a3ae4930a832
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:52 +01:00

rtc: core: Make the sync offset default more realistic

The offset which is used to steer the start of an RTC synchronization
update via rtc_set_ntp_time() is huge. The math behind this is:

  tsched       twrite(t2.tv_sec - 1) 	 t2 (seconds increment)

twrite - tsched is the transport time for the write to hit the device.

t2 - twrite depends on the chip and is for most chips one second.

The rtc_set_ntp_time() calculation of tsched is:

    tsched = t2 - 1sec - (t2 - twrite)

The default for the sync offset is 500ms which means that twrite - tsched
is 500ms assumed that t2 - twrite is one second.

This is 0.5 seconds off for RTCs which are directly accessible by IO writes
and probably for the majority of i2C/SPI based RTC off by an order of
magnitude. Set it to 5ms which should bring it closer to reality.

The default can be adjusted by drivers (rtc_cmos does so) and could be
adjusted further by a calibration method which is an orthogonal problem.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220541.960333166@linutronix.de

---
 drivers/rtc/class.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/class.c b/drivers/rtc/class.c
index 7c88d19..d795737 100644
--- a/drivers/rtc/class.c
+++ b/drivers/rtc/class.c
@@ -201,7 +201,7 @@ static struct rtc_device *rtc_allocate_device(void)
 	device_initialize(&rtc->dev);
 
 	/* Drivers can revise this default after allocating the device. */
-	rtc->set_offset_nsec =  NSEC_PER_SEC / 2;
+	rtc->set_offset_nsec =  5 * NSEC_PER_MSEC;
 
 	rtc->irq_freq = 1;
 	rtc->max_user_freq = 64;
