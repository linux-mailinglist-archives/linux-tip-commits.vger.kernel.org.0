Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D063004E0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 15:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbhAVOG6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 09:06:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728278AbhAVOGu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 09:06:50 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95DE9C0613D6;
        Fri, 22 Jan 2021 06:05:30 -0800 (PST)
Date:   Fri, 22 Jan 2021 14:05:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611324328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BWhAIW0d8KeWnEY2q1TqQVn3qHvwINutEg5PY1O/iZY=;
        b=NI6ltpgiAG72K9OPHXKOE0PE79qnefz/AkXP21ui7g+En76KJ0e4/n4VIFTct79uU07Vha
        /L8M1OmKu/m0e9lTlp36rYHCn7bgl+6qXPcmMJqVlWqMoH3I7Q9ENwbi1idICJQ8xqjoj1
        /Z0oGW6MtK1ROTARAozA+vzMqgv+30ahPmUWCRkL7Ubet2wdudR1xB0lo3E9VcGlQOLNgS
        dLJAouuheH8IGfQnj6V3d0YuBAujTGqjWRuuZjBunGropkelxGV27R6Gj9zAs0fBFVWoex
        H5uuRHvJc/zVVv/h2vu+7WlQ2PNOmq/SqY5RQXuIH+jy9ias5R67J0FbQEWvFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611324328;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BWhAIW0d8KeWnEY2q1TqQVn3qHvwINutEg5PY1O/iZY=;
        b=WNOsgpji+vYwvvi6FoxbHuf6k2vbmVo8jhCycsQEwD8D74tWWHxekUK50zU65h0STw/RQw
        g0vW0aAcyqPJpDAA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking: Add Reviewers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161132432817.414.211662341451283638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c7539258146844ebd8795c31275c720ded61bb84
Gitweb:        https://git.kernel.org/tip/c7539258146844ebd8795c31275c720ded61bb84
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 17 Dec 2020 10:32:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 11:08:55 +01:00

locking: Add Reviewers

Spread the love..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Acked-by: Boqun Feng <boqun.feng@gmail.com>
---
 MAINTAINERS | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6eff4f7..de903d1 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10373,6 +10373,8 @@ LOCKING PRIMITIVES
 M:	Peter Zijlstra <peterz@infradead.org>
 M:	Ingo Molnar <mingo@redhat.com>
 M:	Will Deacon <will@kernel.org>
+R:	Waiman Long <longman@redhat.com>
+R:	Boqun Feng <boqun.feng@gmail.com> (LOCKDEP)
 L:	linux-kernel@vger.kernel.org
 S:	Maintained
 T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git locking/core
