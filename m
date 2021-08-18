Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27F1E3EFE69
	for <lists+linux-tip-commits@lfdr.de>; Wed, 18 Aug 2021 09:58:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239253AbhHRH7W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 18 Aug 2021 03:59:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239122AbhHRH7T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 18 Aug 2021 03:59:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD4D9C06179A;
        Wed, 18 Aug 2021 00:58:44 -0700 (PDT)
Date:   Wed, 18 Aug 2021 07:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629273520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lKQDLANLyUi+Sx81c732B4XqDoBUw5lthUZM0qaSLtY=;
        b=0iaP/xX6ejZglFKxV50mBfEcuAEuuWdDWfC4DBvM50CstWSrWL7g6jJ6IM2VobrNAV9IUl
        rfq55Au+2VNecWvsXV3Vu1lGouuITlbpBjNEryYexega+qQNeBguIDkWfG8CigNWT8KxM8
        VY6M5wMPhkTLTudvn5g8MIuITVm48KHlI+HXr5Wnuj629KzVnVyLo0xv+mdbocAMqqXC1x
        SSbS51q8Ig+nL9JZecXhW74MkgOPFfYlnsRh9epoxD4VOAw/ceipIrTOBjZi+iW5XNWt/v
        O6VviDOul7m2VtvJwlcg372g6vobOunCn0+eTu7OQaj8U4T1P20XAtOrupxqew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629273520;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=lKQDLANLyUi+Sx81c732B4XqDoBUw5lthUZM0qaSLtY=;
        b=s6r3UHA1sxhsOXnYDJGNX88ewqMWZrYydReQqHLe+IoMwCpFFVTniyvLEsEf95X6SXuvsT
        guq+4YG9HDFZQ7CQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/debug] tools/memory-model: Document data_race(READ_ONCE())
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162927351969.25758.3242624039733082077.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/debug branch of tip:

Commit-ID:     87859a8e3f083bd57b34e6a962544d775a76b15f
Gitweb:        https://git.kernel.org/tip/87859a8e3f083bd57b34e6a962544d775a76b15f
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 18 May 2021 10:47:43 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Tue, 27 Jul 2021 11:48:55 -07:00

tools/memory-model: Document data_race(READ_ONCE())

It is possible to cause KCSAN to ignore marked accesses by applying
__no_kcsan to the function or applying data_race() to the marked accesses.
These approaches allow the developer to restrict compiler optimizations
while also causing KCSAN to ignore diagnostic accesses.

This commit therefore updates the documentation accordingly.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/memory-model/Documentation/access-marking.txt | 49 ++++++++----
 1 file changed, 35 insertions(+), 14 deletions(-)

diff --git a/tools/memory-model/Documentation/access-marking.txt b/tools/memory-model/Documentation/access-marking.txt
index 82a4899..6577822 100644
--- a/tools/memory-model/Documentation/access-marking.txt
+++ b/tools/memory-model/Documentation/access-marking.txt
@@ -37,7 +37,9 @@ compiler's use of code-motion and common-subexpression optimizations.
 Therefore, if a given access is involved in an intentional data race,
 using READ_ONCE() for loads and WRITE_ONCE() for stores is usually
 preferable to data_race(), which in turn is usually preferable to plain
-C-language accesses.
+C-language accesses.  It is permissible to combine #2 and #3, for example,
+data_race(READ_ONCE(a)), which will both restrict compiler optimizations
+and disable KCSAN diagnostics.
 
 KCSAN will complain about many types of data races involving plain
 C-language accesses, but marking all accesses involved in a given data
@@ -86,6 +88,10 @@ that fail to exclude the updates.  In this case, it is important to use
 data_race() for the diagnostic reads because otherwise KCSAN would give
 false-positive warnings about these diagnostic reads.
 
+If it is necessary to both restrict compiler optimizations and disable
+KCSAN diagnostics, use both data_race() and READ_ONCE(), for example,
+data_race(READ_ONCE(a)).
+
 In theory, plain C-language loads can also be used for this use case.
 However, in practice this will have the disadvantage of causing KCSAN
 to generate false positives because KCSAN will have no way of knowing
@@ -279,19 +285,34 @@ tells KCSAN that data races are expected, and should be silently
 ignored.  This data_race() also tells the human reading the code that
 read_foo_diagnostic() might sometimes return a bogus value.
 
-However, please note that your kernel must be built with
-CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n in order for KCSAN to
-detect a buggy lockless write.  If you need KCSAN to detect such a
-write even if that write did not change the value of foo, you also
-need CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.  If you need KCSAN to
-detect such a write happening in an interrupt handler running on the
-same CPU doing the legitimate lock-protected write, you also need
-CONFIG_KCSAN_INTERRUPT_WATCHER=y.  With some or all of these Kconfig
-options set properly, KCSAN can be quite helpful, although it is not
-necessarily a full replacement for hardware watchpoints.  On the other
-hand, neither are hardware watchpoints a full replacement for KCSAN
-because it is not always easy to tell hardware watchpoint to conditionally
-trap on accesses.
+If it is necessary to suppress compiler optimization and also detect
+buggy lockless writes, read_foo_diagnostic() can be updated as follows:
+
+	void read_foo_diagnostic(void)
+	{
+		pr_info("Current value of foo: %d\n", data_race(READ_ONCE(foo)));
+	}
+
+Alternatively, given that KCSAN is to ignore all accesses in this function,
+this function can be marked __no_kcsan and the data_race() can be dropped:
+
+	void __no_kcsan read_foo_diagnostic(void)
+	{
+		pr_info("Current value of foo: %d\n", READ_ONCE(foo));
+	}
+
+However, in order for KCSAN to detect buggy lockless writes, your kernel
+must be built with CONFIG_KCSAN_ASSUME_PLAIN_WRITES_ATOMIC=n.  If you
+need KCSAN to detect such a write even if that write did not change
+the value of foo, you also need CONFIG_KCSAN_REPORT_VALUE_CHANGE_ONLY=n.
+If you need KCSAN to detect such a write happening in an interrupt handler
+running on the same CPU doing the legitimate lock-protected write, you
+also need CONFIG_KCSAN_INTERRUPT_WATCHER=y.  With some or all of these
+Kconfig options set properly, KCSAN can be quite helpful, although
+it is not necessarily a full replacement for hardware watchpoints.
+On the other hand, neither are hardware watchpoints a full replacement
+for KCSAN because it is not always easy to tell hardware watchpoint to
+conditionally trap on accesses.
 
 
 Lock-Protected Writes With Lockless Reads
