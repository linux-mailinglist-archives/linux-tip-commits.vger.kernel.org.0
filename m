Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 540F2341CE2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 19 Mar 2021 13:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230166AbhCSMZa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 19 Mar 2021 08:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230114AbhCSMZM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 19 Mar 2021 08:25:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4746C06174A;
        Fri, 19 Mar 2021 05:25:09 -0700 (PDT)
Date:   Fri, 19 Mar 2021 12:25:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616156708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c41gDclJ74izuDFqleCjC4OEyVgBPimL3LJByFsY6WA=;
        b=CwTi6X1JlEx61lMo4tEBcWlTBNoFwwI5e8Ql3gggnBoxoP1s60LxcZev64nJCJYC06Olaz
        dc4V+QWphCcducKlQsqT5j5ekxOTLkecsfrdF/xbptFvHixnjvby75h+SMVRQjtkIFoRKa
        gbRajwngwvmnziCUf+YJwC51v2vfl6qzvlw5+r/r47Bds6FSVsOl/SZgRxT4K69Fi1KpvE
        mu5e6y+wRHp6DBb3aQBmmktykZp5PRU+d7y1Wz74QEemjB1/gwKaSDn5pslL/ZG769tFqo
        NXr02F/w2Kri13onzjMhTpbaPOLnbeN99YVa++W74PKb67dcMSFlpsVQJx2Liw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616156708;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=c41gDclJ74izuDFqleCjC4OEyVgBPimL3LJByFsY6WA=;
        b=DekgXNmkRliVBojOegXNQw50i7N2Y4hypcEEtlQEtA58df9JjRpJ6KhLuXMPsfpkQ1XrgV
        FjzRt/unZiVIVaDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] static_call: Fix static_call_update() sanity check
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210318113610.739542434@infradead.org>
References: <20210318113610.739542434@infradead.org>
MIME-Version: 1.0
Message-ID: <161615670760.398.14295497710199743924.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     38c93587375053c5b9ef093f4a5ea754538cba32
Gitweb:        https://git.kernel.org/tip/38c93587375053c5b9ef093f4a5ea754538cba32
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 18 Mar 2021 11:31:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 19 Mar 2021 13:16:44 +01:00

static_call: Fix static_call_update() sanity check

Sites that match init_section_contains() get marked as INIT. For
built-in code init_sections contains both __init and __exit text. OTOH
kernel_text_address() only explicitly includes __init text (and there
are no __exit text markers).

Match what jump_label already does and ignore the warning for INIT
sites. Also see the excellent changelog for commit: 8f35eaa5f2de
("jump_label: Don't warn on __exit jump entries")

Fixes: 9183c3f9ed710 ("static_call: Add inline static call infrastructure")
Reported-by: Sumit Garg <sumit.garg@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Jarkko Sakkinen <jarkko@kernel.org>
Tested-by: Sumit Garg <sumit.garg@linaro.org>
Link: https://lkml.kernel.org/r/20210318113610.739542434@infradead.org
---
 kernel/jump_label.c  |  8 ++++++++
 kernel/static_call.c | 11 ++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index c6a39d6..ba39fbb 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -407,6 +407,14 @@ static bool jump_label_can_update(struct jump_entry *entry, bool init)
 		return false;
 
 	if (!kernel_text_address(jump_entry_code(entry))) {
+		/*
+		 * This skips patching built-in __exit, which
+		 * is part of init_section_contains() but is
+		 * not part of kernel_text_address().
+		 *
+		 * Skipping built-in __exit is fine since it
+		 * will never be executed.
+		 */
 		WARN_ONCE(!jump_entry_is_init(entry),
 			  "can't patch jump_label at %pS",
 			  (void *)jump_entry_code(entry));
diff --git a/kernel/static_call.c b/kernel/static_call.c
index fc22590..2c5950b 100644
--- a/kernel/static_call.c
+++ b/kernel/static_call.c
@@ -181,7 +181,16 @@ void __static_call_update(struct static_call_key *key, void *tramp, void *func)
 				continue;
 
 			if (!kernel_text_address((unsigned long)site_addr)) {
-				WARN_ONCE(1, "can't patch static call site at %pS",
+				/*
+				 * This skips patching built-in __exit, which
+				 * is part of init_section_contains() but is
+				 * not part of kernel_text_address().
+				 *
+				 * Skipping built-in __exit is fine since it
+				 * will never be executed.
+				 */
+				WARN_ONCE(!static_call_is_init(site),
+					  "can't patch static call site at %pS",
 					  site_addr);
 				continue;
 			}
