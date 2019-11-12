Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DB25F8CDB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 11:32:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725957AbfKLKcp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 05:32:45 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33213 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfKLKcp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 05:32:45 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUTTV-0007tr-DX; Tue, 12 Nov 2019 11:32:41 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 09F051C0084;
        Tue, 12 Nov 2019 11:32:41 +0100 (CET)
Date:   Tue, 12 Nov 2019 10:32:40 -0000
From:   "tip-bot2 for Mukesh Ojha" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time: Fix spelling mistake in comment
Cc:     Mukesh Ojha <mojha@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1571124819-9639-1-git-send-email-mojha@codeaurora.org>
References: <1571124819-9639-1-git-send-email-mojha@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157355476063.29376.3227779653988744811.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1d6acc18fee71a0db6e4fbbfbdb247e0bd5b0655
Gitweb:        https://git.kernel.org/tip/1d6acc18fee71a0db6e4fbbfbdb247e0bd5b0655
Author:        Mukesh Ojha <mojha@codeaurora.org>
AuthorDate:    Tue, 15 Oct 2019 13:03:39 +05:30
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Nov 2019 11:30:46 +01:00

time: Fix spelling mistake in comment

witin => within

Signed-off-by: Mukesh Ojha <mojha@codeaurora.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/1571124819-9639-1-git-send-email-mojha@codeaurora.org

---
 kernel/time/time.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/time/time.c b/kernel/time/time.c
index 45a3589..ea6e7e4 100644
--- a/kernel/time/time.c
+++ b/kernel/time/time.c
@@ -179,7 +179,7 @@ int do_sys_settimeofday64(const struct timespec64 *tv, const struct timezone *tz
 		return error;
 
 	if (tz) {
-		/* Verify we're witin the +-15 hrs range */
+		/* Verify we're within the +-15 hrs range */
 		if (tz->tz_minuteswest > 15*60 || tz->tz_minuteswest < -15*60)
 			return -EINVAL;
 
