Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF053928A9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 May 2021 09:38:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234492AbhE0Hj7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 27 May 2021 03:39:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32812 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233284AbhE0Hj4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 27 May 2021 03:39:56 -0400
Date:   Thu, 27 May 2021 07:38:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622101103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rs8RICVtTMIR0duRixhXjZgs1a+gc2HbyPbdmHesWMo=;
        b=YPK8qEiK5JIyNnkcvloCXkzvcilVl5sMCdj78CPuXekRIOfJEELDc+9hRyt5QQIg3pFTgs
        OWjCZgq32FGrpE2Ol9qxsWRwF5uNwImxnBcZQJrQvXGnuSVyzvoAZhsteskQiDkAN9jFPN
        iuGkd1JZ+OigTI9t7ldsb0ZWEM7XPu/uZkflJCMLekjH4Glfi6APvAPH1JbbSPiCzchgDL
        un5RtRwLJuBaYrUNGSVRGHg0+f/97Dy1+9zb6VTfg4A5GD7JQ28Fl6Na9H+72Vkq/krDg+
        W3sDrll0Mk2C0bA8pWMBPyWdBiRGaFC0CAHnP1OiDUVPnYKA8Wlklw6H4qjYeg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622101103;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rs8RICVtTMIR0duRixhXjZgs1a+gc2HbyPbdmHesWMo=;
        b=DyT4ed+z/QAXkJpbrcPUq9wmv1mPaXTEyWbHDuL+ZNSVe54zn6/WSB/UyXN6/Nh1tNwWIo
        SbwMOXt/+3z98VDA==
From:   "tip-bot2 for Haocheng Xie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/hw_breakpoint: Fix DocBook warnings in perf
 hw_breakpoint
Cc:     Haocheng Xie <xiehaocheng.cn@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210527031947.1801-4-xiehaocheng.cn@gmail.com>
References: <20210527031947.1801-4-xiehaocheng.cn@gmail.com>
MIME-Version: 1.0
Message-ID: <162210110198.29796.2648863634376476070.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     875dd7bf548104bc1d2c5784a6af6cf38215a216
Gitweb:        https://git.kernel.org/tip/875dd7bf548104bc1d2c5784a6af6cf38215a216
Author:        Haocheng Xie <xiehaocheng.cn@gmail.com>
AuthorDate:    Thu, 27 May 2021 11:19:47 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 May 2021 09:35:22 +02:00

perf/hw_breakpoint: Fix DocBook warnings in perf hw_breakpoint

Fix the following W=1 kernel build warning(s):

  kernel/events/hw_breakpoint.c:461: warning: Function parameter or member 'context' not described in 'register_user_hw_breakpoint'
  kernel/events/hw_breakpoint.c:560: warning: Function parameter or member 'context' not described in 'register_wide_hw_breakpoint'

Signed-off-by: Haocheng Xie <xiehaocheng.cn@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210527031947.1801-4-xiehaocheng.cn@gmail.com
---
 kernel/events/hw_breakpoint.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/events/hw_breakpoint.c b/kernel/events/hw_breakpoint.c
index b48d703..8359734 100644
--- a/kernel/events/hw_breakpoint.c
+++ b/kernel/events/hw_breakpoint.c
@@ -451,6 +451,7 @@ int register_perf_hw_breakpoint(struct perf_event *bp)
  * register_user_hw_breakpoint - register a hardware breakpoint for user space
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
+ * @context: context data could be used in the triggered callback
  * @tsk: pointer to 'task_struct' of the process to which the address belongs
  */
 struct perf_event *
@@ -550,6 +551,7 @@ EXPORT_SYMBOL_GPL(unregister_hw_breakpoint);
  * register_wide_hw_breakpoint - register a wide breakpoint in the kernel
  * @attr: breakpoint attributes
  * @triggered: callback to trigger when we hit the breakpoint
+ * @context: context data could be used in the triggered callback
  *
  * @return a set of per_cpu pointers to perf events
  */
