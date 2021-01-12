Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6F822F3CD5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Jan 2021 01:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436784AbhALVhV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Jan 2021 16:37:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48390 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436824AbhALUSw (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Jan 2021 15:18:52 -0500
Date:   Tue, 12 Jan 2021 20:18:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610482689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AG036gacMsJ7cOPhUuL8X5chuyKH0VZhcXObnW7ezY=;
        b=zmbI6ecMD/1zj5wHe7Sf+zLdBZFgB7QAJkl/4MQndn1nleIMPqPWms6pHzd4Tsv90pO6D7
        6dbe5H5e+/Pai1zikR9VZn3qUTNVeUS+/UDQkIGZTZhCfwEZqtGjRcCtz9lhzeYRtkB7D+
        tSaxmoC/3a6XzYH2wOtuhGjPWNr0RC+ZiDgTtLNgzA0H06P1UrrUp1T5G1Z4cdUeHBFdFA
        ycGtGJB5E5MIf86chcRjuKrGSj25QEGkiFogt+182KdM7HQUyBHZrpcqmJAdgU+8vLQ8H8
        5IXVIlttHD8Mx6mKrROq3Z/3Y37NgCS0pnZx3DQnWOO0HbDhdh3IR0Rq47P3PQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610482689;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9AG036gacMsJ7cOPhUuL8X5chuyKH0VZhcXObnW7ezY=;
        b=NJ79J10ejnFV5VzMEsLvdjVqwRqDYHI/QlL0tM7OxPnw+heRaM/YxIKY1Jd9Km7rvhXwpP
        nwkw1ZcYlxVOPmDw==
From:   "tip-bot2 for Chunguang Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] timekeeping: Remove unused get_seconds()
Cc:     Chunguang Xu <brookxu@tencent.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1606816351-26900-1-git-send-email-brookxu@tencent.com>
References: <1606816351-26900-1-git-send-email-brookxu@tencent.com>
MIME-Version: 1.0
Message-ID: <161048268887.414.15933446514318366457.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     aba428a0c612bb259891307da12e22efd0fab14c
Gitweb:        https://git.kernel.org/tip/aba428a0c612bb259891307da12e22efd0fab14c
Author:        Chunguang Xu <brookxu@tencent.com>
AuthorDate:    Tue, 01 Dec 2020 17:52:31 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Jan 2021 21:13:01 +01:00

timekeeping: Remove unused get_seconds()

The get_seconds() cleanup seems to have been completed, now it is
time to delete the legacy interface to avoid misuse later.

Signed-off-by: Chunguang Xu <brookxu@tencent.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1606816351-26900-1-git-send-email-brookxu@tencent.com

---
 include/linux/ktime.h         |  1 -
 include/linux/timekeeping32.h | 14 --------------
 kernel/time/timekeeping.c     |  3 +--
 3 files changed, 1 insertion(+), 17 deletions(-)
 delete mode 100644 include/linux/timekeeping32.h

diff --git a/include/linux/ktime.h b/include/linux/ktime.h
index a12b552..73f20de 100644
--- a/include/linux/ktime.h
+++ b/include/linux/ktime.h
@@ -230,6 +230,5 @@ static inline ktime_t ms_to_ktime(u64 ms)
 }
 
 # include <linux/timekeeping.h>
-# include <linux/timekeeping32.h>
 
 #endif
diff --git a/include/linux/timekeeping32.h b/include/linux/timekeeping32.h
deleted file mode 100644
index 266017f..0000000
--- a/include/linux/timekeeping32.h
+++ /dev/null
@@ -1,14 +0,0 @@
-#ifndef _LINUX_TIMEKEEPING32_H
-#define _LINUX_TIMEKEEPING32_H
-/*
- * These interfaces are all based on the old timespec type
- * and should get replaced with the timespec64 based versions
- * over time so we can remove the file here.
- */
-
-static inline unsigned long get_seconds(void)
-{
-	return ktime_get_real_seconds();
-}
-
-#endif
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index a45cedd..6aee576 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -991,8 +991,7 @@ EXPORT_SYMBOL_GPL(ktime_get_seconds);
 /**
  * ktime_get_real_seconds - Get the seconds portion of CLOCK_REALTIME
  *
- * Returns the wall clock seconds since 1970. This replaces the
- * get_seconds() interface which is not y2038 safe on 32bit systems.
+ * Returns the wall clock seconds since 1970.
  *
  * For 64bit systems the fast access to tk->xtime_sec is preserved. On
  * 32bit systems the access must be protected with the sequence
