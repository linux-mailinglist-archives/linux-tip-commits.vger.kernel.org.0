Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4814348E86
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 12:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbhCYLIk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 07:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbhCYLId (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 07:08:33 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096B6C06174A;
        Thu, 25 Mar 2021 04:08:33 -0700 (PDT)
Date:   Thu, 25 Mar 2021 11:08:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616670511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DWOJYsfzcf2MYVUyOlGSR2fQztWAZ2/OrFW58S9EME=;
        b=a+tuLQclAmQh9OTyE1zKvC53T3ze1j8U6CeiBpDtEOjcYGJoLei1boXghihitpsa7OSYe9
        9MCnqaitZtOvHygjXfOqXrt5byv/Jo9VZU4t5t0t1QbXaOFZw9ysCtpCeYF8VVjSn7jPJC
        n0MS3sYpbpBo8LQDPJLoKq4tnlKQvZEMtCFmeI7zSJYCPEVmwBcMMFKIqQBZ1g1cWoNquo
        3X09oiZl+Ypp8KxIlcYobV9f/twVDFIdVH6lVgiKATg0JOtfwXKsPyYrBRhrqCsyyMgosY
        r8M9IfaINHCXNX6IHVTNV43txSb18ukC3lZdvuTAKS1KMBzqS4LSnb17DsogMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616670511;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DWOJYsfzcf2MYVUyOlGSR2fQztWAZ2/OrFW58S9EME=;
        b=/wgN0FnOxKgKJ2l8XTdFjuK/P4oHr2zGuOrBs4Ne7CDNha8hVvJ8WWrPk2i82NBMUQKmKo
        cK1eTdVh0FTuXRBw==
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
Message-ID: <161667051052.398.6239082761517753119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8af856d18bfbe89676ade38caa2a5d06f75f211d
Gitweb:        https://git.kernel.org/tip/8af856d18bfbe89676ade38caa2a5d06f75f211d
Author:        Shaokun Zhang <zhangshaokun@hisilicon.com>
AuthorDate:    Wed, 24 Mar 2021 13:40:40 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 25 Mar 2021 12:02:06 +01:00

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
