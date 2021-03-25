Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F137E348BC7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 09:45:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229662AbhCYIop (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 04:44:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbhCYIoZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 04:44:25 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A02CC06174A;
        Thu, 25 Mar 2021 01:44:25 -0700 (PDT)
Date:   Thu, 25 Mar 2021 08:44:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616661863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/GelTDZEVzAgNspu6WxRyh/nQN+0sytDp3W/l3eS3w=;
        b=MEUYdvsaq6aTFEFlI/ZY9YBBhtCqi8SEezeXWpG2k6YKMDPmFwE8nQWQH6Gf9ZU0V2rOyC
        mBQiwZGV/HfWb0SeG/LppT5N4LTtgvI3enzTleOGqnjQ7AE1nU3XZNaBgoQOtsAo5n+XUV
        ibDtoL2XJvs5qpZzDn0E5e9L7YYcWC1sOHzz7sH7x308wp9HnKpnRGi25RP5cMWoYfZUgY
        cK0gG7gW1OX5TzFERAtEhcInuCnTzEKOGTe2pBPPB22fJubh/SjBrGwSWAyQs679dZWThv
        baj1lHIfwMtPEjmoGhEQRW/60mqMQxUXlWK1h/3IF8QdOquSfleyjpEn0dZ/Uw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616661863;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/GelTDZEVzAgNspu6WxRyh/nQN+0sytDp3W/l3eS3w=;
        b=jb7Hov0xgEDwH1lyhcDETlF1bjwCX8e7AQIRju6QdxEKa7F8BEScyuJ/ZoXWmj4XLgZekN
        vrw1W3eRP3KaRWBA==
From:   "tip-bot2 for Shaokun Zhang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/mutex: Remove repeated declaration
Cc:     Shaokun Zhang <zhangshaokun@hisilicon.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1616564440-61318-1-git-send-email-zhangshaokun@hisilicon.com>
References: <1616564440-61318-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Message-ID: <161666186260.398.16306380992993651837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     93b02d29fbdbc221c866664adcaf0e85be9f8008
Gitweb:        https://git.kernel.org/tip/93b02d29fbdbc221c866664adcaf0e85be9f8008
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Wed, 24 Mar 2021 13:40:40 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 25 Mar 2021 09:42:48 +01:00

locking/mutex: Remove repeated declaration

Commit 0cd39f4600ed ("locking/seqlock, headers: Untangle the spaghetti monster")
introduces 'struct ww_acquire_ctx' again, remove the repeated declaration and move
the pre-declarations to the top.

Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/1616564440-61318-1-git-send-email-zhangshaokun@hisilicon.com
---
 include/linux/mutex.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/include/linux/mutex.h b/include/linux/mutex.h
index 0cd631a..e7a1267 100644
--- a/include/linux/mutex.h
+++ b/include/linux/mutex.h
@@ -20,6 +20,7 @@
 #include <linux/osq_lock.h>
 #include <linux/debug_locks.h>
 
+struct ww_class;
 struct ww_acquire_ctx;
 
 /*
@@ -65,9 +66,6 @@ struct mutex {
 #endif
 };
 
-struct ww_class;
-struct ww_acquire_ctx;
-
 struct ww_mutex {
 	struct mutex base;
 	struct ww_acquire_ctx *ctx;
