Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD3212B45C7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 15:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729558AbgKPOYI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 09:24:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgKPOYI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 09:24:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CCDDC0613CF;
        Mon, 16 Nov 2020 06:24:08 -0800 (PST)
Date:   Mon, 16 Nov 2020 14:24:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605536646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vAMQNzKZwAvqiy8he2bo54WfbX9H+On/tARTlkUlvs=;
        b=fCcEEc9BCnkzV/Od+GLB3WGDDnz40Qf0eed4imzqqbOrVHtsq6ulrg98F7/hmQ2QlYN3it
        LkF9sfIAItABjlB6wD5Z7+zgrya+fTS1uNIo3D/1/B8NcGg7GYfaQI9dkid5xSA2ran/J5
        CHDq6BNFLAOj1km4TP/SpM4XJy5HjqtaVq0NQp4VqKXigWIhf1xqD6NibB0uSmy4WLjF7V
        t2o7lEt5Co6VPCBwuCfJOGjBIb7yyOb2LvSHIJ4BwGImMjtmBgNxTRtLpq7n5OdpOOkgyz
        huRMHweWEiB6wm9jeladw+W2kQNsBRaNLpNSWgB850IrMb2kD5tTpkfT72H8Yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605536646;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+vAMQNzKZwAvqiy8he2bo54WfbX9H+On/tARTlkUlvs=;
        b=mcEozSh/54P35FrOdDIOJ5asmxrkhkHTqTRJJ3vwdjdQJ4KPSugIx5ezbsGex9q2X0xMN8
        Kq/ci4hwNoUxicCw==
From:   "tip-bot2 for Mauro Carvalho Chehab" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Fix kernel-doc markups
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C9dc87808c2fd07b7e050bafcd033c5ef05808fea=2E16055?=
 =?utf-8?q?21731=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
References: =?utf-8?q?=3C9dc87808c2fd07b7e050bafcd033c5ef05808fea=2E160552?=
 =?utf-8?q?1731=2Egit=2Emchehab+huawei=40kernel=2Eorg=3E?=
MIME-Version: 1.0
Message-ID: <160553664597.11244.10277265518241800560.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     66981c37b3199d293c58f84cf2366e86a06e1a3d
Gitweb:        https://git.kernel.org/tip/66981c37b3199d293c58f84cf2366e86a06e1a3d
Author:        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
AuthorDate:    Mon, 16 Nov 2020 11:18:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 15:20:01 +01:00

hrtimer: Fix kernel-doc markups

The hrtimer_get_remaining() markup is documenting, instead,
__hrtimer_get_remaining(), as it is placed at the C file.

In order to properly document it, a kernel-doc markup is needed together
with the function prototype. So, add a new one, while preserving the
existing one, just fixing the function name.

The hrtimer_is_queued prototype has a typo: it is using
'=' instead of '-' to split: identifier - description
as required by kernel-doc markup.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/9dc87808c2fd07b7e050bafcd033c5ef05808fea.1605521731.git.mchehab+huawei@kernel.org

---
 include/linux/hrtimer.h | 6 +++++-
 kernel/time/hrtimer.c   | 2 +-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 107cedd..bb5e7b0 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -447,6 +447,10 @@ static inline void hrtimer_restart(struct hrtimer *timer)
 /* Query timers: */
 extern ktime_t __hrtimer_get_remaining(const struct hrtimer *timer, bool adjust);
 
+/**
+ * hrtimer_get_remaining - get remaining time for the timer
+ * @timer:	the timer to read
+ */
 static inline ktime_t hrtimer_get_remaining(const struct hrtimer *timer)
 {
 	return __hrtimer_get_remaining(timer, false);
@@ -458,7 +462,7 @@ extern u64 hrtimer_next_event_without(const struct hrtimer *exclude);
 extern bool hrtimer_active(const struct hrtimer *timer);
 
 /**
- * hrtimer_is_queued = check, whether the timer is on one of the queues
+ * hrtimer_is_queued - check, whether the timer is on one of the queues
  * @timer:	Timer to check
  *
  * Returns: True if the timer is queued, false otherwise
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 3624b9b..61c39ff 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -1289,7 +1289,7 @@ int hrtimer_cancel(struct hrtimer *timer)
 EXPORT_SYMBOL_GPL(hrtimer_cancel);
 
 /**
- * hrtimer_get_remaining - get remaining time for the timer
+ * __hrtimer_get_remaining - get remaining time for the timer
  * @timer:	the timer to read
  * @adjust:	adjust relative timers when CONFIG_TIME_LOW_RES=y
  */
