Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF5840F880
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:58:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244923AbhIQM72 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244966AbhIQM70 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA499C061574;
        Fri, 17 Sep 2021 05:58:04 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvSQFRyHNHjbPcLMyWvkief7NI98aQxuzRNEB6efZmA=;
        b=1oaBTSQGUj0G5jqVKAPSicWi60Fm0YKikhYXMJhDUtZAF94/nCOEMyO7CgDSzMxEN/P2eh
        Mh0oX5OzBQ3ETQ9HBL6ssA6NmW6m1gLI41yTkQmZUWkSqlhrlLmQo4F2MzS6wIr6GVQfMk
        MrvZOBVWepZrNq+ASqhZ1gvxASIz5R7U8qqPmBaxzvxSWoPxJO7Dkh7Zb1Xj2FAIIO0+W9
        40zrIkhyqKrd7BG1offsP742nTG1Xf2Ky2R2OALthjAiAyrSicKD/+7NqP3zfoeCpkmS13
        Z7TIU3C+D0gFa4TcAgfelAGteawt8M7FkKtkqOkPypglSyqKwWnYZB9QVe+qEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883483;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NvSQFRyHNHjbPcLMyWvkief7NI98aQxuzRNEB6efZmA=;
        b=SfPLpd4MwzA2bNKLBzA6j0422wT/yzTQ6yJ56tSqNI5wAcUR9KeUK+GaU3dbn4S7Y4E8aC
        OWU91VgABk5k+dAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Mark xen_force_evtchn_callback() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.996055323@infradead.org>
References: <20210624095148.996055323@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348273.25758.13348455357618226664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     847d9317b2b9c7ecc14b953e6ecf9c12bcdb42e9
Gitweb:        https://git.kernel.org/tip/847d9317b2b9c7ecc14b953e6ecf9c12bcdb42e9
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:20:25 +02:00

x86/xen: Mark xen_force_evtchn_callback() noinstr

vmlinux.o: warning: objtool: check_events()+0xd: call to xen_force_evtchn_callback() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.996055323@infradead.org
---
 arch/x86/include/asm/xen/hypercall.h | 2 +-
 arch/x86/xen/irq.c                   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 990b8aa..4a7ff8b 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -358,7 +358,7 @@ HYPERVISOR_event_channel_op(int cmd, void *arg)
 	return _hypercall2(int, event_channel_op, cmd, arg);
 }
 
-static inline int
+static __always_inline int
 HYPERVISOR_xen_version(int cmd, void *arg)
 {
 	return _hypercall2(int, xen_version, cmd, arg);
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index f52b60d..2f695b5 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -19,7 +19,7 @@
  * callback mask. We do this in a very simple manner, by making a call
  * down into Xen. The pending flag will be checked by Xen on return.
  */
-void xen_force_evtchn_callback(void)
+noinstr void xen_force_evtchn_callback(void)
 {
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
