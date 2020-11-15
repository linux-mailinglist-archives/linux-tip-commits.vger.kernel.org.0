Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6C2B3A71
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728000AbgKOWvZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:37492 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727302AbgKOWvH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:07 -0500
Date:   Sun, 15 Nov 2020 22:51:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQ5SIKX1MEW+/ik9Ld9qQpvQMwxtj5N+6M3bkwsmrKk=;
        b=EnWHqre2ii1immqTEChQnkDaSvOhPPGKAOPMbqfTQ/ewCkN3pCIpthVyG0apvub33XcE0i
        8wShz0j7LQaIwsN6lqwNdBTdKAuWkB2skk11fup2NPhscJkXXUNzyEuVqdkXWMWi+1A7jX
        HsXaw8LYGE0zkEDGIhFgvGVAwJKqCxs0myZCYji2rhQNrYsnw2O1g5y6puIIljpIKOaLSj
        lGlAEqk066tWLxBne1fBM+ulcDXPXQy/DN5J+vdAhwjTVBW0vVbh/Kv5hrxanVCEk/Ws/f
        a6cISs2TgYg2QKmC5+X6P7GRGdACGgIncmcRqDxK25QGFgdBzBcuKkMqa9/2AA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480664;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQ5SIKX1MEW+/ik9Ld9qQpvQMwxtj5N+6M3bkwsmrKk=;
        b=1Hig+0hKx6xppGbiugt7h5eh/MDAqBWuRYx/LepbrBRs+L2XPPne7B3DPVcxRqMVcaU6j9
        7GUpFnQ1jwH90sAA==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Fix parameter docs of
 read_persistent_wall_and_boot_offset()
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605252275-63652-6-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-6-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160548066377.11244.14222042480642061054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     29efc4612ac1b888e65da408b41dafa4dd00842f
Gitweb:        https://git.kernel.org/tip/29efc4612ac1b888e65da408b41dafa4dd00842f
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 15:24:35 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:47:24 +01:00

timekeeping: Fix parameter docs of read_persistent_wall_and_boot_offset()

Address the following kernel-doc markup warnings:

 kernel/time/timekeeping.c:1563: warning: Function parameter or member
 'wall_time' not described in 'read_persistent_wall_and_boot_offset'
 kernel/time/timekeeping.c:1563: warning: Function parameter or member
 'boot_offset' not described in 'read_persistent_wall_and_boot_offset'

The parameters are described but miss the leading '@' and the colon after
the parameter names.

[ tglx: Massaged changelog ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1605252275-63652-6-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/time/timekeeping.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 9c93923..75cba95 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1576,8 +1576,9 @@ void __weak read_persistent_clock64(struct timespec64 *ts)
  *                                        from the boot.
  *
  * Weak dummy function for arches that do not yet support it.
- * wall_time	- current time as returned by persistent clock
- * boot_offset	- offset that is defined as wall_time - boot_time
+ * @wall_time:	- current time as returned by persistent clock
+ * @boot_offset: - offset that is defined as wall_time - boot_time
+ *
  * The default function calculates offset based on the current value of
  * local_clock(). This way architectures that support sched_clock() but don't
  * support dedicated boot time clock will provide the best estimate of the
