Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F19221DECD8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 May 2020 18:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730679AbgEVQJE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 May 2020 12:09:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730505AbgEVQIx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 May 2020 12:08:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76FB7C05BD43;
        Fri, 22 May 2020 09:08:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jcAE4-0000AI-DD; Fri, 22 May 2020 18:08:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 03B351C0480;
        Fri, 22 May 2020 18:08:48 +0200 (CEST)
Date:   Fri, 22 May 2020 16:08:47 -0000
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/kcsan] kcsan: Pass option
 tsan-instrument-read-before-write to Clang
Cc:     Marco Elver <elver@google.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200521142047.169334-5-elver@google.com>
References: <20200521142047.169334-5-elver@google.com>
MIME-Version: 1.0
Message-ID: <159016372791.17951.6422316885550727878.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/kcsan branch of tip:

Commit-ID:     52dfbb97a90fbf6a9826f15a71fca37861330a13
Gitweb:        https://git.kernel.org/tip/52dfbb97a90fbf6a9826f15a71fca37861330a13
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 21 May 2020 16:20:40 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 22 May 2020 14:57:39 +02:00

kcsan: Pass option tsan-instrument-read-before-write to Clang

Clang (unlike GCC) removes reads before writes with matching addresses
in the same basic block. This is an optimization for TSAN, since writes
will always cause conflict if the preceding read would have.

However, for KCSAN we cannot rely on this option, because we apply
several special rules to writes, in particular when the
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC option is selected. To avoid missing
potential data races, pass the -tsan-instrument-read-before-write option
to Clang if it is available [1].

[1] https://github.com/llvm/llvm-project/commit/151ed6aa38a3ec6c01973b35f684586b6e1c0f7e

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200521142047.169334-5-elver@google.com
---
 scripts/Makefile.kcsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index 75d2942..bd4da1a 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -13,6 +13,7 @@ endif
 # of some options does not break KCSAN nor causes false positive reports.
 CFLAGS_KCSAN := -fsanitize=thread \
 	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
+	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
 	$(call cc-param,tsan-distinguish-volatile=1)
 
 endif # CONFIG_KCSAN
