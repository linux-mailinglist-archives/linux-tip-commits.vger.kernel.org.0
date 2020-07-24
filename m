Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C94622C0D9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jul 2020 10:34:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727916AbgGXIel (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 24 Jul 2020 04:34:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36452 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgGXIdr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 24 Jul 2020 04:33:47 -0400
Date:   Fri, 24 Jul 2020 08:33:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595579626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ai+PVwn3hOY+xxPVs8WOYdxxgvrbWPl2lj5CBkyf5+Y=;
        b=Zp4UOE99uU3n186vrjpeqVz4yLCIun5mM+klYiMnKlQKpBRJDQD3azcTJoUMgzfq866NOm
        I8M1RCsrYbTS6kUGSdYgdBMxBy6AOuSJsnkxxpQnfXFWio5hzTH9cgXbjTRmub/Uf13tDP
        TdyMDPzrwoDtG5BuLTW3BGZHLnBj64HnuE+GKn6t661ymdkmzEhRcfRuULjMwfr/2pSdfA
        RS1UJFjStQQV+uu2H8oNGykNe8BFr/FMCV3FPsXvzEYHVza5E/mFGAPBf/x4+O/YM+j56t
        tyftS1M6hCB1Oma40y1tXYsA7101iQ4mLO6oKiMhS66yh2vRqK8tSBEspyFW9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595579626;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ai+PVwn3hOY+xxPVs8WOYdxxgvrbWPl2lj5CBkyf5+Y=;
        b=248mMmqh7ELaLTDrjURjEC6uxFzRwDUhPRQt1AJNeEP9GvORP97pM/0NtD3o304Z7FoDID
        /2Z+a72VNhmTgyCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/fifo] sched,spi: Convert to sched_set_fifo*()
Cc:     broonie@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Douglas Anderson <dianders@chromium.org>,
        Guenter Roeck <groeck@chromium.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159557962585.4006.5223548174176221551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/fifo branch of tip:

Commit-ID:     3070da33400c18e0454832425a530d2d0e6a6fcf
Gitweb:        https://git.kernel.org/tip/3070da33400c18e0454832425a530d2d0e6a6fcf
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Apr 2020 12:09:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 15 Jun 2020 14:10:22 +02:00

sched,spi: Convert to sched_set_fifo*()

Because SCHED_FIFO is a broken scheduler model (see previous patches)
take away the priority field, the kernel can't possibly make an
informed decision.

No effective change.

Cc: broonie@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Guenter Roeck <groeck@chromium.org>
---
 drivers/platform/chrome/cros_ec_spi.c | 6 +-----
 drivers/spi/spi.c                     | 4 +---
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec_spi.c b/drivers/platform/chrome/cros_ec_spi.c
index debea5c..c20a43a 100644
--- a/drivers/platform/chrome/cros_ec_spi.c
+++ b/drivers/platform/chrome/cros_ec_spi.c
@@ -709,9 +709,6 @@ static void cros_ec_spi_high_pri_release(void *worker)
 static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 					   struct cros_ec_spi *ec_spi)
 {
-	struct sched_param sched_priority = {
-		.sched_priority = MAX_RT_PRIO / 2,
-	};
 	int err;
 
 	ec_spi->high_pri_worker =
@@ -728,8 +725,7 @@ static int cros_ec_spi_devm_high_pri_alloc(struct device *dev,
 	if (err)
 		return err;
 
-	err = sched_setscheduler_nocheck(ec_spi->high_pri_worker->task,
-					 SCHED_FIFO, &sched_priority);
+	err = sched_set_fifo(ec_spi->high_pri_worker->task);
 	if (err)
 		dev_err(dev, "Can't set cros_ec high pri priority: %d\n", err);
 	return err;
diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index 8158e28..5a4f0bf 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1592,11 +1592,9 @@ EXPORT_SYMBOL_GPL(spi_take_timestamp_post);
  */
 static void spi_set_thread_rt(struct spi_controller *ctlr)
 {
-	struct sched_param param = { .sched_priority = MAX_RT_PRIO / 2 };
-
 	dev_info(&ctlr->dev,
 		"will run message pump with realtime priority\n");
-	sched_setscheduler(ctlr->kworker_task, SCHED_FIFO, &param);
+	sched_set_fifo(ctlr->kworker_task);
 }
 
 static int spi_init_queue(struct spi_controller *ctlr)
