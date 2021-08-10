Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F2AF3E7BD8
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 17:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242732AbhHJPN6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 11:13:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242681AbhHJPN6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 11:13:58 -0400
Date:   Tue, 10 Aug 2021 15:13:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628608414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWni45tFh4xKeuXPmHRIxPdSeAc4Ei3wEBFHv940tP4=;
        b=M0RrmiaFMWEAfx7dfO5SZa3IUTVPoxhIbqe6CfO24AtNcsTba3eWmdj+ejwLzLUIFFNLpz
        F9i8W1WudeZjUkHxSFABfT3gCRJS+Jr1Gl+zLAq9mpTCNbNCJmK/hbRyKTINEDk97vHTaB
        SU/EmM7VpxM4zyAloqcGXp3RyOdRq5JOspr26ZzpWA1H/y4tJCLy+nk48soPPp1xH3q8HT
        obt58qGe268hPq+sh32cq+AgFhPsQCSip4a16sLlAz3F+H6rk9T9uNNo7ItQ73uVdXn3N7
        PZcu0s0XhJPDXA8tIc2W9PivW1v4iV+Kaj89Nbu8I8S1b2gr9g3mUIIcLu5tUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628608414;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BWni45tFh4xKeuXPmHRIxPdSeAc4Ei3wEBFHv940tP4=;
        b=5TnNPP6VZm0BT3vmGy6QAHXzKaaOvvSC6WTJKe+bK1/JZjeBcObFz614Vqx16QdcaMQ3wf
        riqZim6lX/xxDNDg==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] posix-cpu-timers: Remove confusing return value override
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210726125513.271824-5-frederic@kernel.org>
References: <20210726125513.271824-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162860841334.395.4387988301567935487.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     d9c1b2a1089f606404284b9f5b045a584d73382d
Gitweb:        https://git.kernel.org/tip/d9c1b2a1089f606404284b9f5b045a584d73382d
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Mon, 26 Jul 2021 14:55:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 17:09:59 +02:00

posix-cpu-timers: Remove confusing return value override

The end of the function cannot be reached with an error in variable
ret. Unconfuse reviewers about that.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210726125513.271824-5-frederic@kernel.org

---
 kernel/time/posix-cpu-timers.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 5c71322..4fbbbc8 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -744,8 +744,6 @@ static int posix_cpu_timer_set(struct k_itimer *timer, int timer_flags,
 		 */
 		cpu_timer_fire(timer);
 	}
-
-	ret = 0;
  out:
 	rcu_read_unlock();
 	if (old)
