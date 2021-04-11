Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0106935B519
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbhDKNpL (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:45:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33094 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235919AbhDKNoZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:25 -0400
Date:   Sun, 11 Apr 2021 13:43:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o/3kywJq0u3pRoQuZLhO//Dicz8PCnQvXbo9YkT4Arw=;
        b=X4YLqq7YloiShQrIc8J5WP/M6Sf3dCmRgpu5ELYNCvJiHglg50CDcthZ8K6u1LZa2vCcxw
        nfyBrkPrtDtVKdZDRBNfbReGZZJRmKJA/7f5W8m8xylVyPgeLnZ3SGFtrz4qL3Dlw65Jnz
        yN+I52vcpt9XYgVu1+ncuM7TAdsHiXA4JZL7JNdKfOq6Unc9wU0UefpUBP7OFkuHaFOjC7
        lULPMOnvZlt3YPc9swYVqonCEUc6zgzXAOtpqETywMKMvTpQRYRal/GoucnAhTAQawwNjE
        II3MzDht0HIN5ccH9wXtqKm0F/lVznQR+T4RI+Eg9MgSjwvggsNb4oDz/nmVoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148622;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=o/3kywJq0u3pRoQuZLhO//Dicz8PCnQvXbo9YkT4Arw=;
        b=EynoTZehHxSpxkUhUer8HtZuPUszDlHURIQeUJ4td7kZFMu9zA11Xrdb5nYXZ5V2psV0tN
        p0Ek0nXPhjLjNaCQ==
From:   "tip-bot2 for Zhouyi Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()
Cc:     Zhouyi Zhou <zhouzhouyi@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814862224.29796.9443095010968245696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     6494ccb93271bee596a12db32ff44867d5be2321
Gitweb:        https://git.kernel.org/tip/6494ccb93271bee596a12db32ff44867d5be2321
Author:        Zhouyi Zhou <zhouzhouyi@gmail.com>
AuthorDate:    Mon, 11 Jan 2021 09:08:59 +08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:17:35 -08:00

rcu: Remove spurious instrumentation_end() in rcu_nmi_enter()

In rcu_nmi_enter(), there is an erroneous instrumentation_end() in the
second branch of the "if" statement.  Oddly enough, "objtool check -f
vmlinux.o" fails to complain because it is unable to correctly cover
all cases.  Instead, objtool visits the third branch first, which marks
following trace_rcu_dyntick() as visited.  This commit therefore removes
the spurious instrumentation_end().

Fixes: 04b25a495bd6 ("rcu: Mark rcu_nmi_enter() call to rcu_cleanup_after_idle() noinstr")
Reported-by Neeraj Upadhyay <neeraju@codeaurora.org>
Signed-off-by: Zhouyi Zhou <zhouzhouyi@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e62c2de..4d90f20 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -1076,7 +1076,6 @@ noinstr void rcu_nmi_enter(void)
 	} else if (!in_nmi()) {
 		instrumentation_begin();
 		rcu_irq_enter_check_tick();
-		instrumentation_end();
 	} else  {
 		instrumentation_begin();
 	}
