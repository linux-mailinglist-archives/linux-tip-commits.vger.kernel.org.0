Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E11828639C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:21:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727862AbgJGQUm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44648 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgJGQUR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:17 -0400
Date:   Wed, 07 Oct 2020 16:20:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtesYXCkhmcRFxqS24YUDba/2YoegbDjbo/a+wYh34w=;
        b=LXgJ+oZkWbE1r7HXL9E6hZZgzgZZQ7GVtW+ruYbCUYRVYLNrVOdDAsBKMHWKb01tp5gy05
        IR049Rjl9lXv2Hz4Y+SVdBMbGfGeCq7Cx0iQFUynqLDqhLbN1NFj6X7aV3VGYjHPsI4k/G
        EtzA/3sLE4slQZKKcsZgRbHBzk8FFaz96COU96+ZNzWAK5lSmoXjixNBgfAlj+17gSYOe4
        jW4/oFPcIZvYY/eeJZO8Xx+Gvp7XeIOCNG0kiAdkj5xqXIHTyVVzPB3JH9B/8Q0OT9r4nx
        8HENkHhnylkjZ2vJSEe0PU5I+wBVxMuJqehBLFcLOSbCzt+mnpgVT5TrDQ5ALQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087615;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GtesYXCkhmcRFxqS24YUDba/2YoegbDjbo/a+wYh34w=;
        b=LwNtZTKTStyKdmYFJFKdPZiZzqqQAeMEuARsvOSJxmQ5bJwAMSEz074DHIve1t2MVhFz0S
        a6DvwNt03OpLGMCw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/seqlock: Tweak DEFINE_SEQLOCK() kernel doc
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200924154851.skmswuyj322yuz4g@linutronix.de>
References: <20200924154851.skmswuyj322yuz4g@linutronix.de>
MIME-Version: 1.0
Message-ID: <160208761426.7002.2119481322411806116.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     24a1877286822293684ef3f7bada4ea48a6e129e
Gitweb:        https://git.kernel.org/tip/24a1877286822293684ef3f7bada4ea48a6e129e
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Thu, 24 Sep 2020 17:48:51 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Oct 2020 18:14:14 +02:00

locking/seqlock: Tweak DEFINE_SEQLOCK() kernel doc

ctags creates a warning:
|ctags: Warning: include/linux/seqlock.h:738: null expansion of name pattern "\2"

The DEFINE_SEQLOCK() macro is passed to ctags and being told to expect
an argument.

Add a dummy argument to keep ctags quiet.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200924154851.skmswuyj322yuz4g@linutronix.de
---
 include/linux/seqlock.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
index 76e44e6..ac5b07f 100644
--- a/include/linux/seqlock.h
+++ b/include/linux/seqlock.h
@@ -821,7 +821,7 @@ typedef struct {
 	} while (0)
 
 /**
- * DEFINE_SEQLOCK() - Define a statically allocated seqlock_t
+ * DEFINE_SEQLOCK(sl) - Define a statically allocated seqlock_t
  * @sl: Name of the seqlock_t instance
  */
 #define DEFINE_SEQLOCK(sl) \
