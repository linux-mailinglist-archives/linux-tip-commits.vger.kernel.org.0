Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D211C4547E8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 14:59:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234257AbhKQOCn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:02:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60052 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbhKQOCm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:02:42 -0500
Date:   Wed, 17 Nov 2021 13:59:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYadU3Kg1g1lNdX5uJHY3PWZX0/y+a4Ub353ejOUNpc=;
        b=U8cybTrW6MtJSQ46oqDmj5upDUrk8IY0wh6dX2+86JZOHYMA/crpINKbz8T7ivKfn7s6w8
        0WWYDuXlAOPacJv7/A1F4/ilgqhThhs0PtlRdyQazjPTpcFfZXnY+EbTBVZRk2X/CbodOL
        CU1oboFHVFUcm5ljhR67zteupIsWGIvD0kY4U7CoF9RQpKbs+4DoYKzfC2pFmrS8GjAzcs
        HD3g4DLghUqkYLUFoxSR68ozwqS+y/XYtj+9xAsatbOAFJ+Uc2zMmxpt+jhf8mNNjH0sQg
        53vyjfUC0hqrW4FyJ4tmk1WpuOlz40OI7SgKWV51A7YeuDHBONn9PirA/zz22g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157583;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VYadU3Kg1g1lNdX5uJHY3PWZX0/y+a4Ub353ejOUNpc=;
        b=1rQX4anMcy65BLo1DUPxyUBb1xr8vO1KVRaa4U5Vb93HAMdZK/PdpRl4aIVOoDEcIk+2P3
        qBFwkO4iP3vcG/Dw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kernel/locking: Use a pointer in ww_mutex_trylock().
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211104122706.frk52zxbjorso2kv@linutronix.de>
References: <20211104122706.frk52zxbjorso2kv@linutronix.de>
MIME-Version: 1.0
Message-ID: <163715758187.11128.891998814032181051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     2202e15b2b1a946ce760d96748cd7477589701ab
Gitweb:        https://git.kernel.org/tip/2202e15b2b1a946ce760d96748cd7477589701ab
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 04 Nov 2021 13:27:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:49 +01:00

kernel/locking: Use a pointer in ww_mutex_trylock().

mutex_acquire_nest() expects a pointer, pass the pointer.

Fixes: 12235da8c80a1 ("kernel/locking: Add context to ww_mutex_trylock()")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211104122706.frk52zxbjorso2kv@linutronix.de
---
 kernel/locking/ww_rt_mutex.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/locking/ww_rt_mutex.c b/kernel/locking/ww_rt_mutex.c
index 0e00205..d1473c6 100644
--- a/kernel/locking/ww_rt_mutex.c
+++ b/kernel/locking/ww_rt_mutex.c
@@ -26,7 +26,7 @@ int ww_mutex_trylock(struct ww_mutex *lock, struct ww_acquire_ctx *ww_ctx)
 
 	if (__rt_mutex_trylock(&rtm->rtmutex)) {
 		ww_mutex_set_context_fastpath(lock, ww_ctx);
-		mutex_acquire_nest(&rtm->dep_map, 0, 1, ww_ctx->dep_map, _RET_IP_);
+		mutex_acquire_nest(&rtm->dep_map, 0, 1, &ww_ctx->dep_map, _RET_IP_);
 		return 1;
 	}
 
