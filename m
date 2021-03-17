Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1E6E33F464
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbhCQPtZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232347AbhCQPs5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:57 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25F36C061762;
        Wed, 17 Mar 2021 08:48:57 -0700 (PDT)
Date:   Wed, 17 Mar 2021 15:48:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98qS5r7PdfUvF9XoNmmD8UxegvJf7Llc5j8PQ1Al1rQ=;
        b=bAbNfgsk3ZC8OodB9uoUTP1FmAafiViZVelX8oGApo6Mbv8D5pMPR+l8ggurMnW2an2LPN
        z5Qq2TbQCx4FsO/9dad2lk/ijm8otw0jEGQfIXv3srRWORC3Qpequ7ALzYW1gnH7Vzr9Lu
        zn5i/UTf17e3N53dmSDqfq2h0mEiiR+4GwtW9yAoKEp5jSCLepAKtcal5gjcycTtnnYSyk
        8dgPYwOIfBfYYiTiot7nzqztjiMErFpQJfU4ZM803limviuyS/lIIiP6HMYnobSKMDKl0j
        kHCPBE0YxMp8l7v363bwHaKG04zT0ievvMIlmRVnt4Y6LrOMJjXaSX8yDtkgUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996135;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=98qS5r7PdfUvF9XoNmmD8UxegvJf7Llc5j8PQ1Al1rQ=;
        b=KFylyS2u0XtSOxWyPhmPKgRQNg3E69T9UtA5zOItBcLNd0T2nHIh3aZ3nHaeuEySUnuiaf
        gUeFXn7HdhzRnTAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Switch tasklet_disable() to the sleep wait variant
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084242.726452321@linutronix.de>
References: <20210309084242.726452321@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613508.398.18146002292404774607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     6fd4e861250b5c89ad460a9f265caeb1bbbfc323
Gitweb:        https://git.kernel.org/tip/6fd4e861250b5c89ad460a9f265caeb1bbbfc323
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:07 +01:00

tasklets: Switch tasklet_disable() to the sleep wait variant

 -- NOT FOR IMMEDIATE MERGING --

Now that all users of tasklet_disable() are invoked from sleepable context,
convert it to use tasklet_unlock_wait() which might sleep.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084242.726452321@linutronix.de

---
 include/linux/interrupt.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 352db93..4777850 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -711,8 +711,7 @@ static inline void tasklet_disable_in_atomic(struct tasklet_struct *t)
 static inline void tasklet_disable(struct tasklet_struct *t)
 {
 	tasklet_disable_nosync(t);
-	/* Spin wait until all atomic users are converted */
-	tasklet_unlock_spin_wait(t);
+	tasklet_unlock_wait(t);
 	smp_mb();
 }
 
