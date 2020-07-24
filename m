Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B912D22C0C2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 10:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgGXIdx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 04:33:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36554 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbgGXIdw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:52 -0400
Date:   Fri, 24 Jul 2020 08:33:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c8p4GjBW7Fkt78FU5GWacsoompexg5NkhQJgtVvLSkA=;
        b=O1Wl+S12zRIRSPPeD+dKsdiO6QcQvCCLE8I+wMHmDtHAkeo4lXJIqhQwbOq57NHNVf1nSs
        1WyyxHmXDbX4wVKkfFqzlfRJvSv3LesnYPs8QwL7DCccjUkC/7AbTtFaMGaAf3HGNI4A6i
        NNDChhCIjcGNcbdztZypZoROLpXFCetGw4nShB51DyfIkLnzsx+6Y0A+S4YuygBhD1oaRX
        kiiFcwJ1HT1Q5AVk0y3RchIcGyXvyU2SyRDlm4ClJXvdNPcb02x/ARBlwjktFMQdbt6NYE
        xlRa/6c82YO8bnfNEI5rROvGn9dukYxs7G1lp3bgLREfleE6OZIlm/9t5dN0PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579630;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=c8p4GjBW7Fkt78FU5GWacsoompexg5NkhQJgtVvLSkA=;
        b=Md/dsqTIrbirsAECPZpe7okGYtNuKogUEBdFDtI0QHXtna4tBjmkPFaYp7cOh4i9BnuSJ5
        1WxyWfVLMh+YaPCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,drbd: Convert to sched_set_fifo*()
Cc:     axboe@kernel.dk, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962968.4006.2581859841411241688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     c9ec0524706e580c78c61e38ef5e7761ed2f8485
Gitweb:        https://git.kernel.org/tip/c9ec0524706e580c78c61e38ef5e7761ed2f8485
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:21 +02:00

sched,drbd: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

In this case, use fifo_low, because it only cares about being above
SCHED_NORMAL. Effectively changes prio from 2 to 1.

Cc: axboe@kernel.dk
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
---
 drivers/block/drbd/drbd_receiver.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_receiver.c b/drivers/block/drbd/drbd_receiver.c
index 3a3f2b6..140fd98 100644
--- a/drivers/block/drbd/drbd_receiver.c
+++ b/drivers/block/drbd/drbd_receiver.c
@@ -6019,9 +6019,8 @@ int drbd_ack_receiver(struct drbd_thread *thi)
 	unsigned int header_size = drbd_header_size(connection);
 	int expect   = header_size;
 	bool ping_timeout_active = false;
-	struct sched_param param = { .sched_priority = 2 };
 
-	rv = sched_setscheduler(current, SCHED_RR, &param);
+	rv = sched_set_fifo_low(current);
 	if (rv < 0)
 		drbd_err(connection, "drbd_ack_receiver: ERROR set priority, ret=%d\n", rv);
 
