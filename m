Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7510A37BDFF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 15:19:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbhELNVB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbhELNU7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 09:20:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C891DC06174A;
        Wed, 12 May 2021 06:19:51 -0700 (PDT)
Date:   Wed, 12 May 2021 13:19:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620825590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Acq0UiJu58fd3XBYYmXKUmlAZxKkkJxpU8hN1cbC8o4=;
        b=r4n8tK44m/3lLHM0nkdi/EhfDGwzH0AAlJgupTcARQU5dCVQ7Fyw+6GxbD9zFnRI5MSl6K
        DJw3IM7ttlc3M1V1DbA24xYxgahT7N3XlcAV2PLK4TjKrjeTJI3T/o5cqTWcLhW6jH74yv
        2zHtJu9V15EjAql6P/pHj5oVB31dilTYw47gAuZgSSlPswoHDAYB4HjvGZCge/fQ8hTg11
        fGpx3jIB0CZFq5cW/12RwvgbyqQBP3t7zmKKvUS2nunYdl13aVs0KRSFXot1TBkFKMr+UA
        L4cliDveGDVfqtBOyevANoBSnSQJw2bwNwral0g1lIPVtBzSmxNhM3Pu2jWoOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620825590;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Acq0UiJu58fd3XBYYmXKUmlAZxKkkJxpU8hN1cbC8o4=;
        b=CN43NJ5p9IxxwCspl/S91345QDpJGct8DLYrL0aapRfsGuXNporyWoX/iTaWTW9Wm/Po+f
        e97+8Ix4VtmiEDCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] jump_label: Free jump_entry::key bit1 for build use
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210506194157.906893264@infradead.org>
References: <20210506194157.906893264@infradead.org>
MIME-Version: 1.0
Message-ID: <162082558969.29796.11337800382444633961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     5af0ea293d78c8b8f0b87ae2b13f7ac584057bc3
Gitweb:        https://git.kernel.org/tip/5af0ea293d78c8b8f0b87ae2b13f7ac584057bc3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 May 2021 21:34:00 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 14:54:55 +02:00

jump_label: Free jump_entry::key bit1 for build use

Have jump_label_init() set jump_entry::key bit1 to either 0 ot 1
unconditionally. This makes it available for build-time games.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210506194157.906893264@infradead.org
---
 include/linux/jump_label.h |  7 +++++--
 kernel/jump_label.c        | 10 ++++++----
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/linux/jump_label.h b/include/linux/jump_label.h
index 8c45f58..48b9b2a 100644
--- a/include/linux/jump_label.h
+++ b/include/linux/jump_label.h
@@ -171,9 +171,12 @@ static inline bool jump_entry_is_init(const struct jump_entry *entry)
 	return (unsigned long)entry->key & 2UL;
 }
 
-static inline void jump_entry_set_init(struct jump_entry *entry)
+static inline void jump_entry_set_init(struct jump_entry *entry, bool set)
 {
-	entry->key |= 2;
+	if (set)
+		entry->key |= 2;
+	else
+		entry->key &= ~2;
 }
 
 static inline int jump_entry_size(struct jump_entry *entry)
diff --git a/kernel/jump_label.c b/kernel/jump_label.c
index 521cafc..bdb0681 100644
--- a/kernel/jump_label.c
+++ b/kernel/jump_label.c
@@ -483,13 +483,14 @@ void __init jump_label_init(void)
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
 		struct static_key *iterk;
+		bool in_init;
 
 		/* rewrite NOPs */
 		if (jump_label_type(iter) == JUMP_LABEL_NOP)
 			arch_jump_label_transform_static(iter, JUMP_LABEL_NOP);
 
-		if (init_section_contains((void *)jump_entry_code(iter), 1))
-			jump_entry_set_init(iter);
+		in_init = init_section_contains((void *)jump_entry_code(iter), 1);
+		jump_entry_set_init(iter, in_init);
 
 		iterk = jump_entry_key(iter);
 		if (iterk == key)
@@ -634,9 +635,10 @@ static int jump_label_add_module(struct module *mod)
 
 	for (iter = iter_start; iter < iter_stop; iter++) {
 		struct static_key *iterk;
+		bool in_init;
 
-		if (within_module_init(jump_entry_code(iter), mod))
-			jump_entry_set_init(iter);
+		in_init = within_module_init(jump_entry_code(iter), mod);
+		jump_entry_set_init(iter, in_init);
 
 		iterk = jump_entry_key(iter);
 		if (iterk == key)
