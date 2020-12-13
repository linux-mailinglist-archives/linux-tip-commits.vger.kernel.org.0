Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D19252D8FE3
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392438AbgLMTQz (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392046AbgLMTDI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DECEC0611CE;
        Sun, 13 Dec 2020 11:01:09 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=H3YgJEq4LYUQ3ezjb0CkeGil1mVwqCH8FIuwNs/eaTo=;
        b=eUAesJkOe78zlyQTUoC0A8O1M/gjEjUG96j5JximghWoOirwbAHax+7J9wHZ5rlPBDUPI4
        POlkxaIacvPaZNemmPrpAlZ+tyB0l9UAYlG+/hfqgKPl/rbUtjvQ1m48dZl+rJ8z+zvMQp
        /fiOXhkAPVbHdRzuBdrQKchMF0mv/JA5zMy9l6jx/pkzH2Wx3/z4eNoVlP4wSasdlrzn6J
        x2zQizo647bxkO7nnPyraH+j0IbwiRmIPC/fV1cxwewlvjaco8Dhh1iUI4ciJ1IoO1+OLq
        ToHXJSaYmZYs6ZGn9mgiSdmNgl9QHBI3YkEJm6X4zu4IWy2wxWCs+pg05ShDMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=H3YgJEq4LYUQ3ezjb0CkeGil1mVwqCH8FIuwNs/eaTo=;
        b=/GfpKS8kT5gpl2wNq8yUwCnUOxZqAsVdJVcgXxzzdtYsd/YQ+plxtFerVjWVdoaNqKFz7/
        J4gtjmPTyxjO9YAw==
From:   "tip-bot2 for Bhaskar Chowdhury" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Fix a spelling error in a comment
Cc:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606676.3364.14206290151138290950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     06dc8d4591b8d8ce0ece94474718b53f0a5c5de3
Gitweb:        https://git.kernel.org/tip/06dc8d4591b8d8ce0ece94474718b53f0a5c5de3
Author:        Bhaskar Chowdhury <unixbhaskar@gmail.com>
AuthorDate:    Tue, 20 Oct 2020 21:22:56 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:58 -08:00

tools/nolibc:  Fix a spelling error in a comment

Fix a spelling in the comment line.

s/memry/memory/p

This is on linux-next.

Signed-off-by: Bhaskar Chowdhury <unixbhaskar@gmail.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index d6d2623..e61d36c 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -107,7 +107,7 @@ static int errno;
 #endif
 
 /* errno codes all ensure that they will not conflict with a valid pointer
- * because they all correspond to the highest addressable memry page.
+ * because they all correspond to the highest addressable memory page.
  */
 #define MAX_ERRNO 4095
 
