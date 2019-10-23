Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8882CE1B49
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Oct 2019 14:51:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391775AbfJWMvD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Oct 2019 08:51:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49248 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391769AbfJWMvC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Oct 2019 08:51:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iNG6H-0001hc-O6; Wed, 23 Oct 2019 14:50:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5C7751C03AB;
        Wed, 23 Oct 2019 14:50:53 +0200 (CEST)
Date:   Wed, 23 Oct 2019 12:50:53 -0000
From:   "tip-bot2 for Ben Dooks (Codethink)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timers/sched_clock: Include local timekeeping.h
 for missing declarations
Cc:     "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191022131226.11465-1-ben.dooks@codethink.co.uk>
References: <20191022131226.11465-1-ben.dooks@codethink.co.uk>
MIME-Version: 1.0
Message-ID: <157183505310.29376.6098311175532476740.tip-bot2@tip-bot2>
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

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     086ee46b08634a999bcd1707eabe3b0dc1806674
Gitweb:        https://git.kernel.org/tip/086ee46b08634a999bcd1707eabe3b0dc1806674
Author:        Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
AuthorDate:    Tue, 22 Oct 2019 14:12:26 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 23 Oct 2019 14:48:23 +02:00

timers/sched_clock: Include local timekeeping.h for missing declarations

Include the timekeeping.h header to get the declaration of the
sched_clock_{suspend,resume} functions. Fixes the following sparse
warnings:

kernel/time/sched_clock.c:275:5: warning: symbol 'sched_clock_suspend' was not declared. Should it be static?
kernel/time/sched_clock.c:286:6: warning: symbol 'sched_clock_resume' was not declared. Should it be static?

Signed-off-by: Ben Dooks (Codethink) <ben.dooks@codethink.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20191022131226.11465-1-ben.dooks@codethink.co.uk

---
 kernel/time/sched_clock.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/sched_clock.c b/kernel/time/sched_clock.c
index 142b076..dbd6905 100644
--- a/kernel/time/sched_clock.c
+++ b/kernel/time/sched_clock.c
@@ -17,6 +17,8 @@
 #include <linux/seqlock.h>
 #include <linux/bitops.h>
 
+#include "timekeeping.h"
+
 /**
  * struct clock_read_data - data required to read from sched_clock()
  *
