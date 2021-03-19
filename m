Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B059D341CE0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 13:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhCSMZa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230203AbhCSMZM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 08:25:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18469C06175F;
        Fri, 19 Mar 2021 05:25:10 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:25:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616156708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuFN8GZSBvQdVGnuFOlfzsjSkAhg+4MNcecV7My0xNU=;
        b=Cm2r9omRdA2sy/IXNJ0vDXrkMMdSooH3GrDevAvIdmZ5Wo8zzGcQuJVza5B0iprA9WLKGW
        KTndrFy45V5o1bdyYxgr4uwlTVCZyGYU40mwjNrzG+lRp9FWXtKZ2hl4iptJcbr8D0U5El
        M9Spo1lEsvq8DgSNyIxpTnyyH16kHPkt5TJ0Pv/pTrM7JqZhQU+/JCiMICQqE64WMXyPZH
        5p6leFa5VVRt7MGEWnZJ/F8LEeqGZy0zUZCIz8wooIvvkQdgzLVoYXnqhtV+t72gWIttWP
        bzHbDk8gXRBhJOcuZMoeee/wFzpp07VrsvXQsrMIYGd0RHxsuoIm1k/qHPg4TQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616156708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EuFN8GZSBvQdVGnuFOlfzsjSkAhg+4MNcecV7My0xNU=;
        b=8lE0d5xzlUgOFrnPypq0KrZbefZDooYBTgKLbsKNjrL9bK7ZP/ARhpL0T/wPzFxzXYrMT2
        bYhTuwqHu53K8jCQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Align static_call_is_init()
 patching condition
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Sumit Garg <sumit.garg@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318113610.636651340@infradead.org>
References: <20210318113610.636651340@infradead.org>
MIME-Version: 1.0
Message-ID: <161615670801.398.11880263831906331601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     698bacefe993ad2922c9d3b1380591ad489355e9
Gitweb:        https://git.kernel.org/tip/698bacefe993ad2922c9d3b1380591ad489355e9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Mar 2021 11:29:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Mar 2021 13:16:44 +01:00

static_call: Align static_call_is_init() patching condition

The intent is to avoid writing init code after init (because the text
might have been freed). The code is needlessly different between
jump_label and static_call and not obviously correct.

The existing code relies on the fact that the module loader clears the
init layout, such that within_module_init() always fails, while
jump_label relies on the module state which is more obvious and
matches the kernel logic.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20210318113610.636651340@infradead.org
---
 kernel/static_call.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/kernel/static_call.c b/kernel/static_call.c
index 080c8a9..fc22590 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -149,6 +149,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 	};
 
 	for (site_mod = &first; site_mod; site_mod = site_mod->next) {
+		bool init = system_state < SYSTEM_RUNNING;
 		struct module *mod = site_mod->mod;
 
 		if (!site_mod->sites) {
@@ -168,6 +169,7 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 		if (mod) {
 			stop = mod->static_call_sites +
 			       mod->num_static_call_sites;
+			init = mod->state == MODULE_STATE_COMING;
 		}
 #endif
 
@@ -175,16 +177,8 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 		     site < stop && static_call_key(site) == key; site++) {
 			void *site_addr = static_call_addr(site);
 
-			if (static_call_is_init(site)) {
-				/*
-				 * Don't write to call sites which were in
-				 * initmem and have since been freed.
-				 */
-				if (!mod && system_state >= SYSTEM_RUNNING)
-					continue;
-				if (mod && !within_module_init((unsigned long)site_addr, mod))
-					continue;
-			}
+			if (!init && static_call_is_init(site))
+				continue;
 
 			if (!kernel_text_address((unsigned long)site_addr)) {
 				WARN_ONCE(1, "can't patch static call site at %pS",
