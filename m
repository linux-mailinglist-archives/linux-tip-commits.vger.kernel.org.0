Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A0F133F465
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbhCQPtZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232328AbhCQPs5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:57 -0400
Date:   Wed, 17 Mar 2021 15:48:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yprOe3MUS8I0UsAojgvhLPkYT/3Ku7djqa4YIoXdrmk=;
        b=dbQacbgjZTusx2iaLGxkv9/oC/BElgEIWBSbAZcQQI6buwbFUAw5+86BIPkWX4/fDhnug9
        RvSbtp2/4tYftiNqoyH7T6y4ZpOzMhaZYFr6Nh4cMd3pLcw751FL8hOzW4x3mn8XuM5hOv
        q4tYU4MlsxqBblvdC/ddMH57khh8W6x6+dhpWIZaEgfuhkiSBCUc1NpRsmPaA4V98Z2Pvm
        1qN4mxZlmr6uJyIVW2qMxHVtxuKcMWXx/ZYDf6OTPLqpkR/zQjDyPJgqfZRD5AZ0gsd5U/
        sesO/q9S3CHbcZDbOxAD3QSaBl0PSbo/T2WemMD89f8STHPpCLJ3QjDz4Qk9lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996136;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yprOe3MUS8I0UsAojgvhLPkYT/3Ku7djqa4YIoXdrmk=;
        b=FLVBcIvfxj5dkVRnODcBvjBdQrsd2UTTTpKlTJDP98anP9QrCKs21MoRHhwTLh3/vf4nYP
        4cfJP+i0uFocZ8Bg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] firewire: ohci: Use tasklet_disable_in_atomic() where
 required
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084242.616379058@linutronix.de>
References: <20210309084242.616379058@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613554.398.14947260695479924195.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f339fc16fba0167d67c4026678ef4c405bca3085
Gitweb:        https://git.kernel.org/tip/f339fc16fba0167d67c4026678ef4c405bca3085
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:16 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:05 +01:00

firewire: ohci: Use tasklet_disable_in_atomic() where required

tasklet_disable() is invoked in several places. Some of them are in atomic
context which prevents a conversion of tasklet_disable() to a sleepable
function.

The atomic callchains are:

 ar_context_tasklet()
   ohci_cancel_packet()
     tasklet_disable()

 ...
   ohci_flush_iso_completions()
     tasklet_disable()

The invocation of tasklet_disable() from at_context_flush() is always in
preemptible context.

Use tasklet_disable_in_atomic() for the two invocations in
ohci_cancel_packet() and ohci_flush_iso_completions().

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084242.616379058@linutronix.de

---
 drivers/firewire/ohci.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/firewire/ohci.c b/drivers/firewire/ohci.c
index 9811c40..17c9d82 100644
--- a/drivers/firewire/ohci.c
+++ b/drivers/firewire/ohci.c
@@ -2545,7 +2545,7 @@ static int ohci_cancel_packet(struct fw_card *card, struct fw_packet *packet)
 	struct driver_data *driver_data = packet->driver_data;
 	int ret = -ENOENT;
 
-	tasklet_disable(&ctx->tasklet);
+	tasklet_disable_in_atomic(&ctx->tasklet);
 
 	if (packet->ack != 0)
 		goto out;
@@ -3465,7 +3465,7 @@ static int ohci_flush_iso_completions(struct fw_iso_context *base)
 	struct iso_context *ctx = container_of(base, struct iso_context, base);
 	int ret = 0;
 
-	tasklet_disable(&ctx->context.tasklet);
+	tasklet_disable_in_atomic(&ctx->context.tasklet);
 
 	if (!test_and_set_bit_lock(0, &ctx->flushing_completions)) {
 		context_tasklet((unsigned long)&ctx->context);
