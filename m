Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9463B3E7BDC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 17:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbhHJPOA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 11:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242743AbhHJPN7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 11:13:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E33AC0613C1;
        Tue, 10 Aug 2021 08:13:37 -0700 (PDT)
Date:   Tue, 10 Aug 2021 15:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628608414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVSq6+DOVB1sy/QxS2RNmDmsQwr1DNYfMqvqQi7dBYQ=;
        b=NkRruUBksuDpwbJ3vTkgfkGBdjXVbIF9nzYjyOhjxkHbbyUHsF+UAxbfytN71FKracIzh4
        jcQDtEXgo8TrJHXwfGPDmAESFZaUwayyNWbjHF72RnWM8uMeh0sVjwTkIZqCTxKIvdCLgh
        amKvSWHvF/KOMckp/T8u8IurzXt9MUxUbDasLWyucn3rLdB/Lm1EBMJ0NwjleHD9ja6Q+s
        YxefYe7WF2xGIcUCvlBcjdd9Jq0MvtEth3cEtkVJcxQYbKafMCWvonIeQoe3erWQ22nuqe
        vgliXcJtRjbHXILaI136o2jbts4BD+aUTjhoMTrH6DxEZMXPziTMkJGs9Az48g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628608414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LVSq6+DOVB1sy/QxS2RNmDmsQwr1DNYfMqvqQi7dBYQ=;
        b=yPA6Zg2VliJh9mCfoYliLE6n6UX4vg/Ma/KNfFDYKNkDQAWsM/S5tJ8HPQ2XyFnSvFtRqB
        D6y2ucMF6z3Wa8Cg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Force next expiration recalc
 after itimer reset
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210726125513.271824-4-frederic@kernel.org>
References: <20210726125513.271824-4-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162860841395.395.9934714280931151215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     406dd42bd1ba0c01babf9cde169bb319e52f6147
Gitweb:        https://git.kernel.org/tip/406dd42bd1ba0c01babf9cde169bb319e52f6147
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 14:55:10 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:09:59 +02:00

posix-cpu-timers: Force next expiration recalc after itimer reset

When an itimer deactivates a previously armed expiration, it simply doesn't
do anything. As a result the process wide cputime counter keeps running and
the tick dependency stays set until it reaches the old ghost expiration
value.

This can be reproduced with the following snippet:

	void trigger_process_counter(void)
	{
		struct itimerval n = {};

		n.it_value.tv_sec = 100;
		setitimer(ITIMER_VIRTUAL, &n, NULL);
		n.it_value.tv_sec = 0;
		setitimer(ITIMER_VIRTUAL, &n, NULL);
	}

Fix this with resetting the relevant base expiration. This is similar to
disarming a timer.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210726125513.271824-4-frederic@kernel.org

---
 kernel/time/posix-cpu-timers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 61c78b6..5c71322 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -1379,8 +1379,6 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 			}
 		}
 
-		if (!*newval)
-			return;
 		*newval += now;
 	}
 
