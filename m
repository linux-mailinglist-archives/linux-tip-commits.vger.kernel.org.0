Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B3331BBB0
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230283AbhBOO6F (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:58:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230255AbhBOO5m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:42 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB66C0611C0;
        Mon, 15 Feb 2021 06:55:57 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8OP2kNk3YYts3rJN5GAH8YtyLFaTtysFHVN3S8CJDeg=;
        b=T/+1dJ4rFiAcC3C+smLuqUfiDsdSWYI39lEdWyrciybrdPtvQCHbqlBeGjtbNrAop3c7x9
        oCd3QsN2a9WJqdZJPiayfXahbJEZJ2mYIHU6oYgGCb1MT5iwobnCeAQjT4slUXn9pqZxoV
        1LHJUqMwNhVv8WPMUnq//RRnjdL6vy+ikZRxuZHa0RlldtyW6vcwAXEGeZD4R9gM1Rpkm9
        n2shO3h0Vc7llhDj1XfKZkF1jMgSa8vfFLSqsy/A1ZZwPlnLLvCCce0OmwoLsRwjKURzM1
        qhUC4Scfq+7xWU0WfhXb9vL4CHQ1cWu5+oakPHQlqk+uNoNX6gtP3H7RaeuaoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=8OP2kNk3YYts3rJN5GAH8YtyLFaTtysFHVN3S8CJDeg=;
        b=q5Vrhn9ftf9luAatO6+B8SsMT0RwWaBcR8SEsrqFLc3/B+TnkhXJ02iDmDu9ReViyehkPv
        KJsluiScAm1YLiAQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] random32: Re-enable KCSAN instrumentation
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340095553.20312.14429902541087017215.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     567a83e6872c15b2080d1d03de71868cd0ae7cea
Gitweb:        https://git.kernel.org/tip/567a83e6872c15b2080d1d03de71868cd0ae7cea
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 24 Nov 2020 12:02:10 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:39:07 -08:00

random32: Re-enable KCSAN instrumentation

Re-enable KCSAN instrumentation, now that KCSAN no longer relies on code
in lib/random32.c.

Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 lib/Makefile | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/lib/Makefile b/lib/Makefile
index afeff05..dc09208 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -27,9 +27,6 @@ KASAN_SANITIZE_string.o := n
 CFLAGS_string.o += -fno-stack-protector
 endif
 
-# Used by KCSAN while enabled, avoid recursion.
-KCSAN_SANITIZE_random32.o := n
-
 lib-y := ctype.o string.o vsprintf.o cmdline.o \
 	 rbtree.o radix-tree.o timerqueue.o xarray.o \
 	 idr.o extable.o sha1.o irq_regs.o argv_split.o \
