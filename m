Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 679C333F473
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbhCQPte (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51106 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232422AbhCQPtA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:00 -0400
Date:   Wed, 17 Mar 2021 15:48:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZh6WyWmloLwmrqShQZRjmYOMn2bnlzSHEyNj8eennk=;
        b=m9pLLXTRXCZ57L01UmqaFc0rZeBvI9mXh/8wu+LaOxgq89FxvwReKSdn4nLdzqPXdmvc0S
        h2h21XlmAuuDGfISZzVd3BF3FJ6dkPGp4Taz8ReMw1aYJmkZB01uxo6Ng1IZaPYBR3xPsR
        coV9KWJ/mW84ygLnoH825Q+yZOtzNDmrGa3/do9Bzs2YwLCYebs7CP2EyQ/ZTM3byeYKjV
        yhnXDGWzuEORk+uo1vndrEbZVNrDRKUlp6ZR7CNfjI7+US2DZvVa3CJ/g2XJA9G75nCvQN
        yLL5EphWT1/ToNyDPj6Y+3HxatFAlCnSrUfowW/UrqCC1x8Aal4iDUytInxg6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PZh6WyWmloLwmrqShQZRjmYOMn2bnlzSHEyNj8eennk=;
        b=HPnEgNTznqjApjfjv5Gd1sN7HYLcfU+tZjANvnCS7BHvRze0QX4JqN5RlE5XZ63+YYyjzB
        VRbHrRkuplhVFmAA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Use spin wait in tasklet_disable() temporarily
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084241.685352806@linutronix.de>
References: <20210309084241.685352806@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613893.398.4032829140740447590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b0cd02c2a9494dbf0a1cc7dc7a3b8b400c158d37
Gitweb:        https://git.kernel.org/tip/b0cd02c2a9494dbf0a1cc7dc7a3b8b400c158d37
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:54 +01:00

tasklets: Use spin wait in tasklet_disable() temporarily

To ease the transition use spin waiting in tasklet_disable() until all
usage sites from atomic context have been cleaned up.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084241.685352806@linutronix.de

---
 include/linux/interrupt.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 3c8a291..b7f0012 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -728,7 +728,8 @@ static inline void tasklet_disable_in_atomic(struct tasklet_struct *t)
 static inline void tasklet_disable(struct tasklet_struct *t)
 {
 	tasklet_disable_nosync(t);
-	tasklet_unlock_wait(t);
+	/* Spin wait until all atomic users are converted */
+	tasklet_unlock_spin_wait(t);
 	smp_mb();
 }
 
