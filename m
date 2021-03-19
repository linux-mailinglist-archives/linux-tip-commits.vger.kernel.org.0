Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3172341CDF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 13:26:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbhCSMZ3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 08:25:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230199AbhCSMZM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 08:25:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87DBAC061760;
        Fri, 19 Mar 2021 05:25:10 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616156709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qg1JTu4OzxPDk4dIjr7LZON45ZC7Q7hacDPqYo+Gw0I=;
        b=hIX52bIdkqWMiC9rxgbDrlIkYXu32kM1e7C0QM2F/gUuMiShMmFDtOShWimz5OFGODPNDU
        +JdAv2IsLR/sTYIndZVaJyHkuT3ZZXCSRBHYy3MtBKzeHeuGXZ5cihWnRADfp0VYlwQtYb
        9q+z01ycbF2Qid5VAIKZ6vPCJkuKorWvfHQ7R2kSu3pgwfI43vMWVBIOjRgo4drWV2VYF5
        x5KrMIfTh750VFVtQmQpaqqb51jNOCnPtxGZcCmxkjFg4EXGXhMnWzOEFm0kO6XbjrQxED
        vdxgIF1qbpqH/mIbL3gY6SWGddPP7vgjhMGj0OIcmDISIaiDkb0FphKd4QkxrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616156709;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Qg1JTu4OzxPDk4dIjr7LZON45ZC7Q7hacDPqYo+Gw0I=;
        b=YBo7y0ez2lMF/zJiOOILjZel6BFFKAxkRzAMzU+MyQugTdrlfk37apO960Dj6fUSKowhgl
        +MgrZEiiER9IA0Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Fix static_call_set_init()
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318113610.519406371@infradead.org>
References: <20210318113610.519406371@infradead.org>
MIME-Version: 1.0
Message-ID: <161615670851.398.10212740171410293456.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     68b1eddd421d2b16c6655eceb48918a1e896bbbc
Gitweb:        https://git.kernel.org/tip/68b1eddd421d2b16c6655eceb48918a1e896bbbc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Mar 2021 11:27:19 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Mar 2021 13:16:44 +01:00

static_call: Fix static_call_set_init()

It turns out that static_call_set_init() does not preserve the other
flags; IOW. it clears TAIL if it was set.

Fixes: 9183c3f9ed710 ("static_call: Add inline static call infrastructure")
Reported-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20210318113610.519406371@infradead.org
---
 kernel/static_call.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index ae82529..080c8a9 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -35,27 +35,30 @@ static inline void *static_call_addr(struct static_call_site *site)
 	return (void *)((long)site->addr + (long)&site->addr);
 }
 
+static inline unsigned long __static_call_key(const struct static_call_site *site)
+{
+	return (long)site->key + (long)&site->key;
+}
 
 static inline struct static_call_key *static_call_key(const struct static_call_site *site)
 {
-	return (struct static_call_key *)
-		(((long)site->key + (long)&site->key) & ~STATIC_CALL_SITE_FLAGS);
+	return (void *)(__static_call_key(site) & ~STATIC_CALL_SITE_FLAGS);
 }
 
 /* These assume the key is word-aligned. */
 static inline bool static_call_is_init(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_INIT;
+	return __static_call_key(site) & STATIC_CALL_SITE_INIT;
 }
 
 static inline bool static_call_is_tail(struct static_call_site *site)
 {
-	return ((long)site->key + (long)&site->key) & STATIC_CALL_SITE_TAIL;
+	return __static_call_key(site) & STATIC_CALL_SITE_TAIL;
 }
 
 static inline void static_call_set_init(struct static_call_site *site)
 {
-	site->key = ((long)static_call_key(site) | STATIC_CALL_SITE_INIT) -
+	site->key = (__static_call_key(site) | STATIC_CALL_SITE_INIT) -
 		    (long)&site->key;
 }
 
@@ -190,7 +193,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 			}
 
 			arch_static_call_transform(site_addr, NULL, func,
-				static_call_is_tail(site));
+						   static_call_is_tail(site));
 		}
 	}
 
@@ -349,7 +352,7 @@ static int static_call_add_module(struct module *mod)
 	struct static_call_site *site;
 
 	for (site = start; site != stop; site++) {
-		unsigned long s_key = (long)site->key + (long)&site->key;
+		unsigned long s_key = __static_call_key(site);
 		unsigned long addr = s_key & ~STATIC_CALL_SITE_FLAGS;
 		unsigned long key;
 
