Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 109E52B3A65
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgKOWvL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728001AbgKOWvJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27912C0613CF;
        Sun, 15 Nov 2020 14:51:09 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsWSRulLeLosLsdFBnTDTCpXYqZvup44/3AJpSLFJb0=;
        b=RXpcQxZzEtX4xCNRdkaBX3IP85ciqUFhwaCh4PE7GnoEGAHL1JRw+ekpjwZArttqOqVz8G
        1Hcb1zPb3C1xTLIISeGhJxqvPqxsvZcCcfD4Hpbnh01n+mVByDe2fGW7MznoRTOkXcNY9u
        McWtqG6s+rQhhCxKsMFObZyePzBuI6OZrN58jQxQY6i+xhe70m9MPNDJz2ILw+SF8e+E0M
        eV1DbdvsvojJkUT2r0+ZaURkJlFmFCWhsjwF/dtewvpYJ0cEvkFUowWr7WJdBQ5L9/alWj
        CjU5IzYnGla+FpML/FyCTft8ZN8PTPDvZUATyuedc5zx+XAbreqPyeVtAF7E0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vsWSRulLeLosLsdFBnTDTCpXYqZvup44/3AJpSLFJb0=;
        b=bMXBACBVPM/twdPvr+Q0j0kr/fBgY2Z6rjHh1cu8HoZhsyUX/VS4yI3yHo3M69z22WReHo
        NhYFGQkVlg4pHJBQ==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Add missing colons for parameter
 documentation of time64_to_tm()
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160548066689.11244.4338204668378465095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     a0f5a65fa5faeef708d022698d5fcba290a35856
Gitweb:        https://git.kernel.org/tip/a0f5a65fa5faeef708d022698d5fcba290a35856
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 15:24:30 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:47:23 +01:00

time: Add missing colons for parameter documentation of time64_to_tm()

Address these kernel-doc warnings:

 kernel/time/timeconv.c:79: warning: Function parameter or member
 'totalsecs' not described in 'time64_to_tm'
 kernel/time/timeconv.c:79: warning: Function parameter or member
 'offset' not described in 'time64_to_tm'
 kernel/time/timeconv.c:79: warning: Function parameter or member
 'result' not described in 'time64_to_tm'

The parameters are described but lack colons after the parameter name.

[ tglx: Massaged changelog ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1605252275-63652-1-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/time/timeconv.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/time/timeconv.c b/kernel/time/timeconv.c
index 589e0a5..62e3b46 100644
--- a/kernel/time/timeconv.c
+++ b/kernel/time/timeconv.c
@@ -70,10 +70,10 @@ static const unsigned short __mon_yday[2][13] = {
 /**
  * time64_to_tm - converts the calendar time to local broken-down time
  *
- * @totalsecs	the number of seconds elapsed since 00:00:00 on January 1, 1970,
+ * @totalsecs:	the number of seconds elapsed since 00:00:00 on January 1, 1970,
  *		Coordinated Universal Time (UTC).
- * @offset	offset seconds adding to totalsecs.
- * @result	pointer to struct tm variable to receive broken-down time
+ * @offset:	offset seconds adding to totalsecs.
+ * @result:	pointer to struct tm variable to receive broken-down time
  */
 void time64_to_tm(time64_t totalsecs, int offset, struct tm *result)
 {
