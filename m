Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8A70E9A55C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:14:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389850AbfHWCMq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:12:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33723 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389324AbfHWCMT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:12:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0z3o-0000xJ-TF; Fri, 23 Aug 2019 04:12:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8F44A1C0883;
        Fri, 23 Aug 2019 04:12:16 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:12:16 -0000
From:   tip-bot2 for Thomas Gleixner <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] alarmtimers: Avoid rtc.h include
Cc:     linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20190819143801.565389536@linutronix.de>
References: <20190819143801.565389536@linutronix.de>
MIME-Version: 1.0
Message-ID: <156652633652.11658.4484460911673616880.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     3758b0f86ef502e2f342055caef6d2232c2558b7
Gitweb:        https://git.kernel.org/tip/3758b0f86ef502e2f342055caef6d2232c2558b7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 19 Aug 2019 16:31:43 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Aug 2019 22:09:52 +02:00

alarmtimers: Avoid rtc.h include

rtc.h is not needed in alarmtimers when a forward declaration of struct
rtc_device is provided. That allows to include posix-timers.h without
adding more includes to alarmtimer.h or creating circular include
dependencies.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lkml.kernel.org/r/20190819143801.565389536@linutronix.de

---
 include/linux/alarmtimer.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/alarmtimer.h b/include/linux/alarmtimer.h
index 0760ca1..74748e3 100644
--- a/include/linux/alarmtimer.h
+++ b/include/linux/alarmtimer.h
@@ -5,7 +5,8 @@
 #include <linux/time.h>
 #include <linux/hrtimer.h>
 #include <linux/timerqueue.h>
-#include <linux/rtc.h>
+
+struct rtc_device;
 
 enum alarmtimer_type {
 	ALARM_REALTIME,
