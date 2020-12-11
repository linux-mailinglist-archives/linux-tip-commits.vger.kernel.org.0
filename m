Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3ED92D737C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Dec 2020 11:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405797AbgLKKJE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 11 Dec 2020 05:09:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404366AbgLKKIb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 11 Dec 2020 05:08:31 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD786C0613D3;
        Fri, 11 Dec 2020 02:07:50 -0800 (PST)
Date:   Fri, 11 Dec 2020 10:07:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsjImkdAFWVRzner0mgqGAEOfz46qJ/MzfZkkhIFTjY=;
        b=EoNYr9r2sULHCuVZ/taeHsCTZKgLHM33jlAzqRSWybadN9E+0EMh4U7fCR86NEqy0fIWyP
        SBprYISvY5oTV3u2b0yBW3pOP0YskIYclETzhWImRCdjeh1f7pnqvmeXlSWewL2E9Jsvs9
        JeUlQ8HSE+Yt+VGH/HP17BwmLwsCK0aiyHHt0CigAJuEG/xJFQX1fwsux9o4/MopouYaXF
        hfxwaMDBl1/qo2d9LM9ycRdDoNXBgOm6KbFmGF+4kyaoUFrJ4SXmm44GCysrcD7zzhHQ/o
        OExPgQoBUu7k22gIqGciknXPw323wT7MI6075NilFrr4RqG+F6w8BmXWlWVtUg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607681269;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JsjImkdAFWVRzner0mgqGAEOfz46qJ/MzfZkkhIFTjY=;
        b=9VwfF+iy7+LXZskxKz7Xz9Aol+gaA0KdLbTkf0RMiM4UC1K8kcqsh+HT4f2ne8lvzBi5aA
        2CHZGKYq7e6QeRBw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] rtc: cmos: Make rtc_cmos sync offset correct
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20201206220541.830517160@linutronix.de>
References: <20201206220541.830517160@linutronix.de>
MIME-Version: 1.0
Message-ID: <160768126882.3364.17475010470329427231.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     b0ecd8e8c5ef376777277c4c2db7de92ac59f23f
Gitweb:        https://git.kernel.org/tip/b0ecd8e8c5ef376777277c4c2db7de92ac59f23f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 06 Dec 2020 22:46:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 11 Dec 2020 10:40:52 +01:00

rtc: cmos: Make rtc_cmos sync offset correct

The offset for rtc_cmos must be -500ms to work correctly with the current
implementation of rtc_set_ntp_time() due to the following:

  tsched       twrite(t2.tv_sec - 1) 	 t2 (seconds increment)

twrite - tsched is the transport time for the write to hit the device,
which is negligible for this chip because it's accessed directly.

t2 - twrite = 500ms according to the datasheet.

But rtc_set_ntp_time() calculation of tsched is:

    tsched = t2 - 1sec - (t2 - twrite)

The default for the sync offset is 500ms which means that the write happens
at t2 - 1.5 seconds which is obviously off by a second for this device.

Make the offset -500ms so it works correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Link: https://lore.kernel.org/r/20201206220541.830517160@linutronix.de

---
 drivers/rtc/rtc-cmos.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index c633319..7728fac 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -868,6 +868,9 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 	if (retval)
 		goto cleanup2;
 
+	/* Set the sync offset for the periodic 11min update correct */
+	cmos_rtc.rtc->set_offset_nsec = -(NSEC_PER_SEC / 2);
+
 	/* export at least the first block of NVRAM */
 	nvmem_cfg.size = address_space - NVRAM_OFFSET;
 	if (rtc_nvmem_register(cmos_rtc.rtc, &nvmem_cfg))
