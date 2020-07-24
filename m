Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6DFD22C0C0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 10:34:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgGXIdw (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 04:33:52 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727094AbgGXIdw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:52 -0400
Date:   Fri, 24 Jul 2020 08:33:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L9rfzZP7Vmr2GKgSrOY25cJ0+nHANdIrv+zPuhvVwF0=;
        b=EEdb+Dek57WLqEAQ5nld/zdwKmjDuu+NUW1FXk6bLUXYNA/Axfgy0uv3rTU2AFjZ9JePrc
        sX2NG1Gf+ug4S7Da59fXRlde0fXvJeT1zIUzkDTXZfVBuyG4HlYnONmnW7MqvBZxJ+cGz8
        coqwZXy3A+HV8wiTkOOLtJeluhMwruFU2qcvERNTNMfX0B4Yp2o881lnSNoSaUAKrwqqh5
        2MXML8b55EHeOnk5/MRGJE0D5QKytF8P1ggEbibe4ZeaPXLWM3K2m4WuK1DyDxos2GyFBF
        o5OhRMm6UMfMRt8l3KQ6hwsE8UMxcpKbXX4bLxZMvHW90Yv6w+k+xBP3Cr4kAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=L9rfzZP7Vmr2GKgSrOY25cJ0+nHANdIrv+zPuhvVwF0=;
        b=VD56yrh6MBI46roMG/D90ryUVHfpezw6N6ZGRFD1bl3DD66HhYFG5bw/eYz7Fm0iBbrmQ2
        xotaqwcgz2Uq7LAQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,acpi_pad: Convert to sched_set_fifo*()
Cc:     rafael.j.wysocki@intel.com,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557963028.4006.12754769388857924864.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     4ca6c1a060943161c6c2ce09e02ed58a69669cfe
Gitweb:        https://git.kernel.org/tip/4ca6c1a060943161c6c2ce09e02ed58a69669cfe
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:20 +02:00

sched,acpi_pad: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively no change in behaviour.

XXX: this driver is still complete crap; why isn't it using proper
idle injection or at the very least play_idle() ?

Cc: rafael.j.wysocki@intel.com
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/acpi/acpi_pad.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/acpi/acpi_pad.c b/drivers/acpi/acpi_pad.c
index e7dc013..0ad9f20 100644
--- a/drivers/acpi/acpi_pad.c
+++ b/drivers/acpi/acpi_pad.c
@@ -136,12 +136,11 @@ static unsigned int idle_pct = 5; /* percentage */
 static unsigned int round_robin_time = 1; /* second */
 static int power_saving_thread(void *data)
 {
-	struct sched_param param = {.sched_priority = 1};
 	int do_sleep;
 	unsigned int tsk_index = (unsigned long)data;
 	u64 last_jiffies = 0;
 
-	sched_setscheduler(current, SCHED_RR, &param);
+	sched_set_fifo_low(current);
 
 	while (!kthread_should_stop()) {
 		unsigned long expire_time;
