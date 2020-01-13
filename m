Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70E321399F2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jan 2020 20:11:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728738AbgAMTLs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Jan 2020 14:11:48 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:39889 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728865AbgAMTJh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Jan 2020 14:09:37 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ir55h-00011J-QW; Mon, 13 Jan 2020 20:09:33 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id A71A41C18E4;
        Mon, 13 Jan 2020 20:09:28 +0100 (CET)
Date:   Mon, 13 Jan 2020 19:09:28 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimer: Make nanosleep() time namespace aware
Cc:     Andrei Vagin <avagin@openvz.org>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-16-dima@arista.com>
References: <20191112012724.250792-16-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157894256854.19145.5832898443280847905.tip-bot2@tip-bot2>
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

Commit-ID:     a27f00cd18d392fadcaca463506303ab668a6891
Gitweb:        https://git.kernel.org/tip/a27f00cd18d392fadcaca463506303ab668a6891
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:04 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 13 Jan 2020 08:10:52 +01:00

alarmtimer: Make nanosleep() time namespace aware

clock_nanosleep() accepts absolute values of expiration time when the
TIMER_ABSTIME flag is set. This absolute value is inside the task's
time namespace and has to be converted to the host's time.

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@openvz.org>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-16-dima@arista.com

---
 kernel/time/alarmtimer.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/time/alarmtimer.c b/kernel/time/alarmtimer.c
index 9a8e81b..b51b36e 100644
--- a/kernel/time/alarmtimer.c
+++ b/kernel/time/alarmtimer.c
@@ -839,6 +839,8 @@ static int alarm_timer_nsleep(const clockid_t which_clock, int flags,
 		ktime_t now = alarm_bases[type].get_ktime();
 
 		exp = ktime_add_safe(now, exp);
+	} else {
+		exp = timens_ktime_to_host(which_clock, exp);
 	}
 
 	ret = alarmtimer_do_nsleep(&alarm, exp, type);
