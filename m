Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D9BC2B3A5F
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728091AbgKOWvI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgKOWvI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1C31C0613CF;
        Sun, 15 Nov 2020 14:51:07 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TeCZ0OfCU+0eDdsnMgprSfj4JoJBDbVvdz/BNhsRVo=;
        b=bkkIX6dEtM89qp3yOMDC/AMlTvCZOXlW/T8rk51SeDfhQXQmM7wfRJQ8oUcQiffApnm2Ta
        dtL8g+ecxVn8lHzBSP1WSYC2X7s+Y64p6Q8lalUiD6Zabt1iH/mgvCKoJ98GZEcX+EaMkB
        YkwD8qtDOKCPJ5PWldZ3VcQ+finrh0DJwejnon3SjAxo1f32LTTRhlEO09fnaEoynI52Tx
        bMUh9D6VpyVZikRpuEBf67BQEw7YvFiXH0Z1DYmDcZcHGl5PmgwRo0905/+KabDN1vB8Nx
        CdwZ2QjLnBdvX/ebLviSPkLUpP7FvG3/Zv1RUfzg7Hrptg2P5fOlXbI3wSAlxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480666;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3TeCZ0OfCU+0eDdsnMgprSfj4JoJBDbVvdz/BNhsRVo=;
        b=DphFIPrS3KqEGJxqfUc8KLsbcdl4dgvS0Yj+dqdbsOOiu2YJPL59irpLsljZaesfDPnvzZ
        wLbyRYxsBOolHMBQ==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Add missing parameter documentation
 for update_fast_timekeeper()
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605252275-63652-2-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-2-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160548066572.11244.17806537326315736019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e025b03113d27139ce2b28b82599018e4d8fa5f6
Gitweb:        https://git.kernel.org/tip/e025b03113d27139ce2b28b82599018e4d8fa5f6
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 15:24:31 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:47:24 +01:00

timekeeping: Add missing parameter documentation for update_fast_timekeeper()

Address the following warning:

 kernel/time/timekeeping.c:415: warning: Function parameter or member
 'tkf' not described in 'update_fast_timekeeper'

[ tglx: Remove the bogus ktime_get_mono_fast_ns() part ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1605252275-63652-2-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/time/timekeeping.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 570fc50..a823703 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -407,6 +407,7 @@ static inline u64 timekeeping_cycles_to_ns(const struct tk_read_base *tkr, u64 c
 /**
  * update_fast_timekeeper - Update the fast and NMI safe monotonic timekeeper.
  * @tkr: Timekeeping readout base from which we take the update
+ * @tkf: Pointer to NMI safe timekeeper
  *
  * We want to use this from any context including NMI and tracing /
  * instrumenting the timekeeping code itself.
