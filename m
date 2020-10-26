Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACEF298A07
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 11:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1769090AbgJZKJT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 06:09:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38796 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1769086AbgJZKIm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 06:08:42 -0400
Date:   Mon, 26 Oct 2020 10:08:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603706920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs5OzYKLpnQ2AkS/hmuzsZRHAoKKIICOn5krQpUII3k=;
        b=r5HTo8uMpKqnBP+E3EIRryGDhAlfV7hM84oDX/EU51Xj+p3xE1Fi0wKXVnriMb8NBKsl3C
        xthV57tziCh7vdoPOyfKO2fRlbbasvnDf7ZB467qqguYsMmkZdYPVM9TON0IcKobjmQ3e2
        +HzWBb9uutyUgohUULXPXyGncazYOAU/Yw0ZtaDjJA5GghM4aUJWvxPt1rgXWK1KbKKk3K
        iT1dkV14mdosXZQPhdb/xYothuly0hzRpIy9CvSXEzf2nL1W6/ZRoCzZl6limSb49bb6QO
        4n5HMM99h6S1eWqCdvZMkYmkWqCKXpNyiBe3zTbrMD4zPYsewYbyt+fMeNUneQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603706920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vs5OzYKLpnQ2AkS/hmuzsZRHAoKKIICOn5krQpUII3k=;
        b=MbrcAeviOYshDvtXWc3PeWAhrBWaSxZNvkgFsrjcNzaY1F51YyBQ8f0EBExRXZh+zbxjb7
        GlfPbYfZB3LEJvBQ==
From:   "tip-bot2 for Davidlohr Bueso" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] timekeeping: Convert jiffies_seq to
 seqcount_raw_spinlock_t
Cc:     Davidlohr Bueso <dbueso@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201021190749.19363-1-dave@stgolabs.net>
References: <20201021190749.19363-1-dave@stgolabs.net>
MIME-Version: 1.0
Message-ID: <160370691856.397.3350703895486263181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     1a2b85f1e2a93a3f84243e654d225e4088735336
Gitweb:        https://git.kernel.org/tip/1a2b85f1e2a93a3f84243e654d225e4088735336
Author:        Davidlohr Bueso <dave@stgolabs.net>
AuthorDate:    Wed, 21 Oct 2020 12:07:49 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 11:04:14 +01:00

timekeeping: Convert jiffies_seq to seqcount_raw_spinlock_t

Use the new api and associate the seqcounter to the jiffies_lock enabling
lockdep support - although for this particular case the write-side locking
and non-preemptibility are quite obvious.

Signed-off-by: Davidlohr Bueso <dbueso@suse.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201021190749.19363-1-dave@stgolabs.net

---
 kernel/time/jiffies.c     | 3 ++-
 kernel/time/timekeeping.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/time/jiffies.c b/kernel/time/jiffies.c
index eddcf49..a5cffe2 100644
--- a/kernel/time/jiffies.c
+++ b/kernel/time/jiffies.c
@@ -59,7 +59,8 @@ static struct clocksource clocksource_jiffies = {
 };
 
 __cacheline_aligned_in_smp DEFINE_RAW_SPINLOCK(jiffies_lock);
-__cacheline_aligned_in_smp seqcount_t jiffies_seq;
+__cacheline_aligned_in_smp seqcount_raw_spinlock_t jiffies_seq =
+	SEQCNT_RAW_SPINLOCK_ZERO(jiffies_seq, &jiffies_lock);
 
 #if (BITS_PER_LONG < 64)
 u64 get_jiffies_64(void)
diff --git a/kernel/time/timekeeping.h b/kernel/time/timekeeping.h
index 099737f..6c2cbd9 100644
--- a/kernel/time/timekeeping.h
+++ b/kernel/time/timekeeping.h
@@ -26,7 +26,7 @@ extern void do_timer(unsigned long ticks);
 extern void update_wall_time(void);
 
 extern raw_spinlock_t jiffies_lock;
-extern seqcount_t jiffies_seq;
+extern seqcount_raw_spinlock_t jiffies_seq;
 
 #define CS_NAME_LEN	32
 
