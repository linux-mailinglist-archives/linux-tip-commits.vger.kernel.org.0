Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AFD4B29E913
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:35:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgJ2Kfo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:35:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgJ2Kfn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:35:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F52AC0613CF;
        Thu, 29 Oct 2020 03:35:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:35:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603967741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYoHoXscEfjh6Eo+71TmTdjg6qJ/I8hjQkeRQTiBIy4=;
        b=3DT7F7mKVwhUliD3tLi8Xzm2gOLQuyZRm1pnZ2f/bmPmgUJKO7ACXQ8vodLB8Ch85TkZNB
        1EUU5VLocpPht2xeiwqWRP6yFd4+9aAITyL++p5/QecPs/Wr5UfnZedEai+OvhGr9n1E53
        rqlmNyPmFJ7NkS//lEHuQA070rOo8ZkC1dIBp0bpfvCB7NgsQF77ugXHj68So1E/3LB4Hv
        e2B3o0UwLNASru9EOJ2nWUz+U7HHfjiy17puejNtCR0b3w6BbVlbUhGI14xhvTfIGAAq3U
        0LZDz5ISglcncScoAjUHnJuqWb6B5XUufnhl4k4srztIHfCxY0b7AxywH8opkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603967741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gYoHoXscEfjh6Eo+71TmTdjg6qJ/I8hjQkeRQTiBIy4=;
        b=csnErMI3PYkJHC5rhr2DkFEdpz6ZZJOXxibGYb+6nZREw4s/M8wAArQXYtldx2DmEQgPIc
        Fr6ktCHnLwNsbYBg==
From:   "tip-bot2 for Ira Weiny" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Fixup irqentry_enter() comment
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ira Weiny <ira.weiny@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201028163632.965518-1-ira.weiny@intel.com>
References: <20201028163632.965518-1-ira.weiny@intel.com>
MIME-Version: 1.0
Message-ID: <160396774065.397.8041761320309530325.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     45ff510517f3b1354a3d9c273ad5e5e8d08312cb
Gitweb:        https://git.kernel.org/tip/45ff510517f3b1354a3d9c273ad5e5e8d08312cb
Author:        Ira Weiny <ira.weiny@intel.com>
AuthorDate:    Wed, 28 Oct 2020 09:36:32 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 29 Oct 2020 11:31:29 +01:00

entry: Fixup irqentry_enter() comment

irq_enter_from_user_mode() was changed to irqentry_enter_from_user_mode().
Update the comment within irqentry_enter() to reflect this change.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201028163632.965518-1-ira.weiny@intel.com


---
 kernel/entry/common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 42eff11..f7ed415 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -302,7 +302,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		/*
 		 * If RCU is not watching then the same careful
 		 * sequence vs. lockdep and tracing is required
-		 * as in irq_enter_from_user_mode().
+		 * as in irqentry_enter_from_user_mode().
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
 		rcu_irq_enter();
