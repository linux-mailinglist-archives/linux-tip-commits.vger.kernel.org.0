Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12F91264EDD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Sep 2020 21:28:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727852AbgIJT2S (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Sep 2020 15:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731222AbgIJPsR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Sep 2020 11:48:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8EC061358;
        Thu, 10 Sep 2020 08:08:30 -0700 (PDT)
Date:   Thu, 10 Sep 2020 15:08:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599750508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2/hUdQLd7wur+pFlosSdnnkNuhfnbkcRAyfZezhqDs=;
        b=s+zIzTOKMTbUYLOVU9e4IE4wGdaXSk7tmLONJ7z/a+/EPs3XE7IZEMKR2TIRNRpDrgJE2o
        i6LPm0MQtTeQF76pfW1EeyC4AewS41eSQAzrVf7CY4PpNd+vu/+oqpTXzuD7jh+A8RPqAS
        2PG705z705JxQfHYzpkghTugDtY0SD6EwOfML6OHPdw1G1t7TJSjuVCNWVuLvEO6EC2S57
        u3Iohj1v6UwEeKUH6Zq3dgHnbiz8fiOgdh9Pe5lq6BL3PwSkWsj+Z2GHr1uI3Zt8ffe41o
        XCYIppNJwmqAkxmS9qTlQrzCEGsMkgRZFEB+fla6/i4F95+MX1HTFWoVdsisgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599750508;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2/hUdQLd7wur+pFlosSdnnkNuhfnbkcRAyfZezhqDs=;
        b=Gz904nsajQPQrH0HFwvIoTp4fSM2h3IA/Ic84+ltv5fZjvhXp69CVc/q4tEtBJ+n4vuTfa
        UVcpzx6mJvDr+TBw==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] time/sched_clock: Use seqcount_latch_t
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200827114044.11173-5-a.darwish@linutronix.de>
References: <20200827114044.11173-5-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159975050783.20229.16826459517712069243.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a690ed07353ec45f056b0a6f87c23a12a59c030d
Gitweb:        https://git.kernel.org/tip/a690ed07353ec45f056b0a6f87c23a12a59c030d
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Thu, 27 Aug 2020 13:40:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 10 Sep 2020 11:19:29 +02:00

time/sched_clock: Use seqcount_latch_t

Latch sequence counters have unique read and write APIs, and thus
seqcount_latch_t was recently introduced at seqlock.h.

Use that new data type instead of plain seqcount_t. This adds the
necessary type-safety and ensures only latching-safe seqcount APIs are
to be used.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200827114044.11173-5-a.darwish@linutronix.de
---
 kernel/time/sched_clock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 8c6b5fe..0642013 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -35,7 +35,7 @@
  * into a single 64-byte cache line.
  */
 struct clock_data {
-	seqcount_t		seq;
+	seqcount_latch_t	seq;
 	struct clock_read_data	read_data[2];
 	ktime_t			wrap_kt;
 	unsigned long		rate;
@@ -76,7 +76,7 @@ struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
 
 int sched_clock_read_retry(unsigned int seq)
 {
-	return read_seqcount_retry(&cd.seq, seq);
+	return read_seqcount_latch_retry(&cd.seq, seq);
 }
 
 unsigned long long notrace sched_clock(void)
