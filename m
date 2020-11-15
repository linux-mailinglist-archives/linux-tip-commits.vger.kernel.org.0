Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 359DE2B3A61
	for <lists+linux-tip-commits@lfdr.de>; Sun, 15 Nov 2020 23:51:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728122AbgKOWvL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 15 Nov 2020 17:51:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgKOWvI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 15 Nov 2020 17:51:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91E81C0613CF;
        Sun, 15 Nov 2020 14:51:08 -0800 (PST)
Date:   Sun, 15 Nov 2020 22:51:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605480667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EynBt7yhjA5j4pXaQ3hwoHC4N06FLM/y8HOL57JWAQ=;
        b=pV9B6zVDGYkAOhcf+Z4Q0ZlYUCzhealv5SxIvaX7IXzEtnHTc2jgTB2RfJ0NQZl98HPMug
        pnM5dMli9TEjQDxZ09c8hCqq18UogqbqacildA6DhsxcRGEqQ4ehGBCJKIrZPw4tAuitjY
        lWOvDItAw7BAsPrf3mmrtq+Z9hgNFgCwItst8J0m9YBMPx1muBfLGEYKfuq2pUk/AYRjsa
        IaVTYex2qdPLRKMNh86YcpBl0SDe+EiDvTYHMHsDzfGcriZ1L0+nwoMmgUtqQzP/48vol6
        eB6IQVYH3DjW35iLhfF/AchXxwAUs2S0UltyCHjpFgCC0mB7hQeAP+SSjYxYmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605480667;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+EynBt7yhjA5j4pXaQ3hwoHC4N06FLM/y8HOL57JWAQ=;
        b=99nDKplcm3nnlsc3yZtrlexMJkDETESK9GYcXTzFpRuN5mCvd3EC5uZUFrS3aaj8cFkhvZ
        OZYOxX5mpknh45DA==
From:   "tip-bot2 for Alex Shi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Remove static functions from
 kernel-doc markup
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1605252275-63652-4-git-send-email-alex.shi@linux.alibaba.com>
References: <1605252275-63652-4-git-send-email-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <160548066628.11244.9491301360637842667.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     199d280c884de44c3b0daeb77438db43f6db01a2
Gitweb:        https://git.kernel.org/tip/199d280c884de44c3b0daeb77438db43f6db01a2
Author:        Alex Shi <alex.shi@linux.alibaba.com>
AuthorDate:    Fri, 13 Nov 2020 15:24:33 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 15 Nov 2020 23:47:23 +01:00

timekeeping: Remove static functions from kernel-doc markup

Various static functions in the timekeeping code have function comments
which pretend to be kernel-doc, but are incomplete and trigger parser
warnings.

As these functions are local to the timekeeping core code there is no need
to expose them via kernel-doc.

Remove the double star kernel-doc marker and remove excess newlines.

[ tglx: Massaged changelog and removed excess newlines ]

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/1605252275-63652-4-git-send-email-alex.shi@linux.alibaba.com

---
 kernel/time/timekeeping.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 6858a31..570fc50 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -1415,9 +1415,8 @@ void timekeeping_warp_clock(void)
 	}
 }
 
-/**
+/*
  * __timekeeping_set_tai_offset - Sets the TAI offset from UTC and monotonic
- *
  */
 static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
 {
@@ -1425,7 +1424,7 @@ static void __timekeeping_set_tai_offset(struct timekeeper *tk, s32 tai_offset)
 	tk->offs_tai = ktime_add(tk->offs_real, ktime_set(tai_offset, 0));
 }
 
-/**
+/*
  * change_clocksource - Swaps clocksources if a new one is available
  *
  * Accumulates current time interval and initializes new clocksource
@@ -2023,13 +2022,12 @@ static void timekeeping_adjust(struct timekeeper *tk, s64 offset)
 	}
 }
 
-/**
+/*
  * accumulate_nsecs_to_secs - Accumulates nsecs into secs
  *
  * Helper function that accumulates the nsecs greater than a second
  * from the xtime_nsec field to the xtime_secs field.
  * It also calls into the NTP code to handle leapsecond processing.
- *
  */
 static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
 {
@@ -2071,7 +2069,7 @@ static inline unsigned int accumulate_nsecs_to_secs(struct timekeeper *tk)
 	return clock_set;
 }
 
-/**
+/*
  * logarithmic_accumulation - shifted accumulation of cycles
  *
  * This functions accumulates a shifted interval of cycles into
@@ -2314,7 +2312,7 @@ ktime_t ktime_get_update_offsets_now(unsigned int *cwsseq, ktime_t *offs_real,
 	return base;
 }
 
-/**
+/*
  * timekeeping_validate_timex - Ensures the timex is ok for use in do_adjtimex
  */
 static int timekeeping_validate_timex(const struct __kernel_timex *txc)
