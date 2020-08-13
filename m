Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74C09244011
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 Aug 2020 22:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726522AbgHMUuD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 Aug 2020 16:50:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60820 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726384AbgHMUuD (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 Aug 2020 16:50:03 -0400
Date:   Thu, 13 Aug 2020 20:49:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1597351800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bsd/TQ/ZE+yOfCb1hQeMBy6ashMeNuJmmWDs+KlvuU=;
        b=MemtrNgFW3qZC+f1iwjB0sY0iOfmjyEkCOkNLs5qayld+JmUFHHH6yXdZgM1hSPVpGaNeJ
        R1MF+SfHD2khep66i2PQXjL7BqVhfr32AgH6cffeoNRU78r9822ivi5r/YPea3ydHwGdOx
        iqGPrmLysgv0fLXl0FPyX3ip0OI4VeMnXVcT7MixS3W6bnqU5gA64/nAPp7VwTKkl38Zkq
        PJOpkF5bnYIoI1ShNnnhzGGvdv8/mtrZ5D+6rfnOtibs599l1WbuK9ctyELD4bLamdDgih
        r9J/in62J8Qw0gsb3xJNioeCqTf97gPV3ImRiqkoFu/bdG+nLimLYUUtFHdbew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1597351800;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8bsd/TQ/ZE+yOfCb1hQeMBy6ashMeNuJmmWDs+KlvuU=;
        b=VUfmMj01O2vihFvSNCtK1KiOS3z0DLVFvPsw7hteZC5xikWjAo9jN71s8Iy2EOtjvRRC7E
        5fAYerfSB6FXUqDQ==
From:   "tip-bot2 for Miaohe Lin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Convert to use the preferred 'fallthrough' macro
Cc:     Miaohe Lin <linmiaohe@huawei.com>, Ingo Molnar <mingo@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200813122117.51173-1-linmiaohe@huawei.com>
References: <20200813122117.51173-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Message-ID: <159735179972.3192.9928492577920549198.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     405fa8ac89e7aaa87282df659e525992f2639e76
Gitweb:        https://git.kernel.org/tip/405fa8ac89e7aaa87282df659e525992f2639e76
Author:        Miaohe Lin <linmiaohe@huawei.com>
AuthorDate:    Thu, 13 Aug 2020 08:21:17 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 Aug 2020 21:02:12 +02:00

futex: Convert to use the preferred 'fallthrough' macro

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20200813122117.51173-1-linmiaohe@huawei.com
---
 kernel/futex.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index 61e8153..a587669 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -3744,12 +3744,12 @@ long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	switch (cmd) {
 	case FUTEX_WAIT:
 		val3 = FUTEX_BITSET_MATCH_ANY;
-		/* fall through */
+		fallthrough;
 	case FUTEX_WAIT_BITSET:
 		return futex_wait(uaddr, flags, val, timeout, val3);
 	case FUTEX_WAKE:
 		val3 = FUTEX_BITSET_MATCH_ANY;
-		/* fall through */
+		fallthrough;
 	case FUTEX_WAKE_BITSET:
 		return futex_wake(uaddr, flags, val, val3);
 	case FUTEX_REQUEUE:
