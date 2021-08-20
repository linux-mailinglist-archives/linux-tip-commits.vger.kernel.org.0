Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E29F3F2A08
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Aug 2021 12:20:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239059AbhHTKU6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Aug 2021 06:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232572AbhHTKUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Aug 2021 06:20:55 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6270DC061575;
        Fri, 20 Aug 2021 03:20:15 -0700 (PDT)
Date:   Fri, 20 Aug 2021 10:20:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629454813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhVI98u+hKxIZOFn9L3ifmYBnkwybH9zgonJjWoKzrs=;
        b=FBxL6Yl2vMWDyzmEjGEeC1ak7HmvxW3w0sTu7eDQa/IQp1SoUxe8toITUTVhkXAqNu6NL/
        2B3IPG4cfphxxfPML6zi0E42a2xUs8u3B2/eOk3ziCze1XcNiXhXbmDc+AUCj6DX6xtMtI
        5Z8ZkPqP1IuiM/5WWMQI2mPCZfjc+cOHpbhicO2xhTKm9amulbJ3gJMw4+eh14Ps7wv3Eb
        EB6rUZ1mTk7ArwbBHReWFEU4Gh8fWuHOUmQy4QhDwh+C52qJetUgdU/Ler8niop85ODh/P
        mCECIp/8aeQ4eBkm344TzCPqAmrzu3q7cmNuJ5X0DcaWr+VwuE+L3W9ih2rbxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629454813;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DhVI98u+hKxIZOFn9L3ifmYBnkwybH9zgonJjWoKzrs=;
        b=xC/9Sd2f5Mg+T8eJzxcTCbUObvJpH1/fFNT96ymRDlUk7SkaaIONiHQ/F++8i4NnntaHkE
        lXtDPzPS1YTdi4Dg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/ww_mutex: Initialize waiter.ww_ctx properly
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210819193030.zpwrpvvrmy7xxxiy@linutronix.de>
References: <20210819193030.zpwrpvvrmy7xxxiy@linutronix.de>
MIME-Version: 1.0
Message-ID: <162945481167.25758.210284056196004961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     b857174e68e26f9c4f0796971e11eb63ad5a3eb6
Gitweb:        https://git.kernel.org/tip/b857174e68e26f9c4f0796971e11eb63ad5a3eb6
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 19 Aug 2021 21:30:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 20 Aug 2021 12:15:54 +02:00

locking/ww_mutex: Initialize waiter.ww_ctx properly

The consolidation of the debug code for mutex waiter intialization sets
waiter::ww_ctx to a poison value unconditionally. For regular mutexes this
is intended to catch the case where waiter_ww_ctx is dereferenced
accidentally.

For ww_mutex the poison value has to be overwritten either with a context
pointer or NULL for ww_mutexes without context.

The rework broke this as it made the store conditional on the context
pointer instead of the argument which signals whether ww_mutex code should
be compiled in or optiized out. As a result waiter::ww_ctx ends up with the
poison pointer for contextless ww_mutexes which causes a later dereference of
the poison pointer because it is != NULL.

Use the build argument instead so for ww_mutex the poison value is always
overwritten.

Fixes: c0afb0ffc06e6 ("locking/ww_mutex: Gather mutex_waiter initialization")
Reported-by: Guenter Roeck <linux@roeck-us.net>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210819193030.zpwrpvvrmy7xxxiy@linutronix.de

---
 kernel/locking/mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index 3a65bf4..d456579 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -618,7 +618,7 @@ __mutex_lock_common(struct mutex *lock, unsigned int state, unsigned int subclas
 
 	debug_mutex_lock_common(lock, &waiter);
 	waiter.task = current;
-	if (ww_ctx)
+	if (use_ww_ctx)
 		waiter.ww_ctx = ww_ctx;
 
 	lock_contended(&lock->dep_map, ip);
