Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B35A1333B53
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Mar 2021 12:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232685AbhCJL0i (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Mar 2021 06:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232745AbhCJL0V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Mar 2021 06:26:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E78AC06174A;
        Wed, 10 Mar 2021 03:26:21 -0800 (PST)
Date:   Wed, 10 Mar 2021 11:26:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615375577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GaK0gw9duos7BG+qtRpU5Nw81+JXClrxQg5yL6fTE5c=;
        b=aOnqwloE1yJZXd8Wvd4CbF0BqgMI6IW8WiH5SRIpmpJmP13R9BWYDJ1rKH79CoaFAbmQOr
        FVC6WhbyN4ZJPQyfBePd+HgtjBP/28/7Mnee7Rog1Wh1f4B0fV3OpEjxaQexVY4lwXGWYN
        XA1r7tVIfLzAW9tkf3l9SKWv8cZ+6YLd0eVBT1Me5ksB+LFpvzAHmE7ZFdU1tm3NLuoWCc
        hKWiYSwUSpl+PJ54i/nKoMp4jlpf7o8JNlgtNZoQ2vR6X/cUsADhVBsmsX3KYwk1Rio0dc
        /9eOv2gDfFYbLjKc4lySDenb+X9NO6oM5xM+Q+pLSF9rYk6wcDszt8CcY9/q0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615375577;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GaK0gw9duos7BG+qtRpU5Nw81+JXClrxQg5yL6fTE5c=;
        b=i9A9W1S3dIo3KJ5Si+IATeSz45+DmknW7Ng/0W7w4z8qcB5VXzcB8yPcLq9oOTDESWR4/6
        CIBUVnCcPnoz5MCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] seqlock,lockdep: Fix seqcount_latch_init()
Cc:     Eric Dumazet <eric.dumazet@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YEeFEbNUVkZaXDp4@hirez.programming.kicks-ass.net>
References: <YEeFEbNUVkZaXDp4@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161537557650.398.8965215814632537258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     4817a52b306136c8b2b2271d8770401441e4cf79
Gitweb:        https://git.kernel.org/tip/4817a52b306136c8b2b2271d8770401441e4cf79
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Mar 2021 15:21:18 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Mar 2021 09:51:45 +01:00

seqlock,lockdep: Fix seqcount_latch_init()

seqcount_init() must be a macro in order to preserve the static
variable that is used for the lockdep key. Don't then wrap it in an
inline function, which destroys that.

Luckily there aren't many users of this function, but fix it before it
becomes a problem.

Fixes: 80793c3471d9 ("seqlock: Introduce seqcount_latch_t")
Reported-by: Eric Dumazet <eric.dumazet@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YEeFEbNUVkZaXDp4@hirez.programming.kicks-ass.net
---
 include/linux/seqlock.h | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 2f7bb92..f61e34f 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -664,10 +664,7 @@ typedef struct {
  * seqcount_latch_init() - runtime initializer for seqcount_latch_t
  * @s: Pointer to the seqcount_latch_t instance
  */
-static inline void seqcount_latch_init(seqcount_latch_t *s)
-{
-	seqcount_init(&s->seqcount);
-}
+#define seqcount_latch_init(s) seqcount_init(&(s)->seqcount)
 
 /**
  * raw_read_seqcount_latch() - pick even/odd latch data copy
