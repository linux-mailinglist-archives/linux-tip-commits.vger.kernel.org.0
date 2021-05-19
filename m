Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33106388A89
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 11:21:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345305AbhESJWz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 05:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345570AbhESJW0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 05:22:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BC81C061342;
        Wed, 19 May 2021 02:21:07 -0700 (PDT)
Date:   Wed, 19 May 2021 09:21:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621416064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIEM/yqf7wBEhnj2QXyj6Skw92IKqyHG1488TEWb2lE=;
        b=2CKkyQDcY6MmVnoTboOCSOMvbZEOGhvqXu40ysFhBQDv0ZJSQD57crvFK9w0p/onjTSboN
        7WHDep8uXA9B2cZtJ8v8G4FnHv6PkzPsaAZ+eBNK0x+BSTgh/BsEotwvnxgq0UJlx2aX3n
        IxpP4wBk55mtihdH53xa4Lg51OpG7ImEoyvXbyZ8ZGDjjOaESgxAs49QJsjrLQAxtPNLqy
        0L2zlerj6zWKTi3nqjmaEilljIbGF6tTEqsWukxocKHjIHWqWV7fM6vSjZaZKxfHemy9Tt
        mK8XcHcPRXqsHR76RzUK3ZTl11H05PJDExudQR/pIP2JM+QytiwvBWJbIOBezw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621416064;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dIEM/yqf7wBEhnj2QXyj6Skw92IKqyHG1488TEWb2lE=;
        b=YNagUSZN9tAuxP/JsHzjubfw5RslaqH9/h1lTCFUAfxzprgyBqB4mShRravceWsVLRjL8j
        TS/i++nLn/O0T5DA==
From:   "tip-bot2 for Frederic Weisbecker" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] MAINTAINERS: Add myself as context tracking maintainer
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-11-frederic@kernel.org>
References: <20210512232924.150322-11-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162141606396.29796.5989172172453397776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     09fe880ed7a160ebbffb84a0a9096a075e314d2f
Gitweb:        https://git.kernel.org/tip/09fe880ed7a160ebbffb84a0a9096a075e314d2f
Author:        Frederic Weisbecker <frederic@kernel.org>
AuthorDate:    Thu, 13 May 2021 01:29:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 May 2021 10:30:28 +02:00

MAINTAINERS: Add myself as context tracking maintainer

I've been missing a lot of patches touching context tracking for which
I wasn't Cc'ed these last months. The code looks like a simple single
file but has a lot of subtle tentacles.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210512232924.150322-11-frederic@kernel.org
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index bd7aff0..bda71de 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4601,6 +4601,12 @@ S:	Supported
 F:	drivers/video/console/
 F:	include/linux/console*
 
+CONTEXT TRACKING
+M:	Frederic Weisbecker <frederic@kernel.org>
+S:	Maintained
+F:	kernel/context_tracking.c
+F:	include/linux/context_tracking*
+
 CONTROL GROUP (CGROUP)
 M:	Tejun Heo <tj@kernel.org>
 M:	Zefan Li <lizefan.x@bytedance.com>
