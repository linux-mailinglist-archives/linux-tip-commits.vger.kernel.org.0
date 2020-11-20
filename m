Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8868E2BAA60
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727818AbgKTMoy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgKTMox (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:44:53 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD6DC0613CF;
        Fri, 20 Nov 2020 04:44:53 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:44:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605876291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKLcV/WYYyGNgCWRgdFXboCOeLhVJZbJEql6VgEEZhY=;
        b=ji3GNGq5Dqa1TS5zAo16WwwAjFETTXPCmrX+cMAGJFizFKsDMBogco3tfg32PS1KZn951m
        m+5rZ5LBwGz3DwIxBbwJ3iUM3+Kkj7IGR8Rm9g5GV0gD0mbrvKiPyMqQulHtWpQJDHkOuR
        Su7gtP3dy0YFyowQSvPr/bDyV/JQ+K7aSMyI+bTqc+/SdlVmX+NlzN3Lr8gFlih8bCTMMH
        V2Y72H+sSzVUe9PDrMaDUZuO3u6l+Nlcy3dYahvu7SegGj0erPW7q2til1XzbnPbLaO2dy
        nwmYjP8vO3U9KWfiLZ9oeSZ7jP2mFLNNbrkklXiW279CnTRmLsrXuhPLndGPMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605876291;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eKLcV/WYYyGNgCWRgdFXboCOeLhVJZbJEql6VgEEZhY=;
        b=9rADVcmZlKL8lR8fqXv04sSAI9zu9mbRv7bA+dsiRf2rLypLwDcR7WwKSJJScyIIWIZrgC
        7H+ZplopmCr6+nCw==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201117151637.259084-2-frederic@kernel.org>
References: <20201117151637.259084-2-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <160587629107.11244.6940310491124628401.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     83c2da2e605c73aafcc02df04b2dbf1ccbfc24c0
Gitweb:        https://git.kernel.org/tip/83c2da2e605c73aafcc02df04b2dbf1ccbfc24c0
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Tue, 17 Nov 2020 16:16:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:41 +01:00

context_tracking: Introduce HAVE_CONTEXT_TRACKING_OFFSTACK

Historically, context tracking had to deal with fragile entry code path,
ie: before user_exit() is called and after user_enter() is called, in
case some of those spots would call schedule() or use RCU. On such
cases, the site had to be protected between exception_enter() and
exception_exit() that save the context tracking state in the task stack.

Such sleepable fragile code path had many different origins: tracing,
exceptions, early or late calls to context tracking on syscalls...

Aside of that not being pretty, saving the context tracking state on
the task stack forces us to run context tracking on all CPUs, including
housekeepers, and prevents us to completely shutdown nohz_full at
runtime on a CPU in the future as context tracking and its overhead
would still need to run system wide.

Now thanks to the extensive efforts to sanitize x86 entry code, those
conditions have been removed and we can now get rid of these workarounds
in this architecture.

Create a Kconfig feature to express this achievement.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201117151637.259084-2-frederic@kernel.org
---
 arch/Kconfig | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/Kconfig b/arch/Kconfig
index 56b6ccc..090ef35 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -618,6 +618,23 @@ config HAVE_CONTEXT_TRACKING
 	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
 	  handling on irq exit still need to be protected.
 
+config HAVE_CONTEXT_TRACKING_OFFSTACK
+	bool
+	help
+	  Architecture neither relies on exception_enter()/exception_exit()
+	  nor on schedule_user(). Also preempt_schedule_notrace() and
+	  preempt_schedule_irq() can't be called in a preemptible section
+	  while context tracking is CONTEXT_USER. This feature reflects a sane
+	  entry implementation where the following requirements are met on
+	  critical entry code, ie: before user_exit() or after user_enter():
+
+	  - Critical entry code isn't preemptible (or better yet:
+	    not interruptible).
+	  - No use of RCU read side critical sections, unless rcu_nmi_enter()
+	    got called.
+	  - No use of instrumentation, unless instrumentation_begin() got
+	    called.
+
 config HAVE_TIF_NOHZ
 	bool
 	help
