Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0350F3491A8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Mar 2021 13:13:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbhCYMM4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Mar 2021 08:12:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhCYMM0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Mar 2021 08:12:26 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE51DC06174A;
        Thu, 25 Mar 2021 05:12:25 -0700 (PDT)
Date:   Thu, 25 Mar 2021 12:12:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616674344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLDtoXm7aBWKdTn5SLecnTgVSGHF4sHYAWrkXJ1OvmQ=;
        b=kgMHZV4jryWO3FAw3Wb1POqM4czNzLYuks7R3V4oYwlOJv8FwtHbmZHZB+je9qey782KZC
        U/tTcURhotuG0MbwZcu10a0NC8LF0dZNZHJTP37KgLmEM2d6y7SX2RQ0Tcj/MvaBeIMamM
        e+UZDLy5xBBzW0SHIahPzbHFWVIPN4NJbqRaRCbEtu8FP1H1StuU+ygn4B5U079+jtDqXc
        1drKmP213A+odJeavN3j205tXU/HYnuaX3esadiJvEZ46+htBUl0wcAeL/N6h9iDlNx4v1
        sBf/C3I3fdn/5Kr107dla0dXFLw/j78vN+WMoivHFBhErQneJxuOOB2ApP38tQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616674344;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XLDtoXm7aBWKdTn5SLecnTgVSGHF4sHYAWrkXJ1OvmQ=;
        b=zSoBfU5IlTXFt3VgxWl/xMMGS1i7c+9TlRjv2Y2Vd/QPaIlsLq65DPraix7xKovSQe+fjh
        vJGz/sNcMlxvcjBQ==
From:   "tip-bot2 for Wei Yongjun" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/kprobes: Move 'inline' to the beginning of the
 kprobe_is_ss() declaration
Cc:     Hulk Robot <hulkci@huawei.com>,
        Wei Yongjun <weiyongjun1@huawei.com>,
        Ingo Molnar <mingo@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210324144502.1154883-1-weiyongjun1@huawei.com>
References: <20210324144502.1154883-1-weiyongjun1@huawei.com>
MIME-Version: 1.0
Message-ID: <161667434353.398.10598940136488963988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     2304d14db6595bea5292bece06c4c625b12d8f89
Gitweb:        https://git.kernel.org/tip/2304d14db6595bea5292bece06c4c625b12d8f89
Author:        Wei Yongjun <weiyongjun1@huawei.com>
AuthorDate:    Wed, 24 Mar 2021 14:45:02 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 25 Mar 2021 13:07:58 +01:00

x86/kprobes: Move 'inline' to the beginning of the kprobe_is_ss() declaration

Address this GCC warning:

  arch/x86/kernel/kprobes/core.c:940:1:
   warning: 'inline' is not at beginning of declaration [-Wold-style-declaration]
    940 | static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
        | ^~~~~~

[ mingo: Tidied up the changelog. ]

Fixes: 6256e668b7af: ("x86/kprobes: Use int3 instead of debug trap for single-step")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210324144502.1154883-1-weiyongjun1@huawei.com
---
 arch/x86/kernel/kprobes/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 922a6e2..dd09021 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -940,7 +940,7 @@ static int reenter_kprobe(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(reenter_kprobe);
 
-static int nokprobe_inline kprobe_is_ss(struct kprobe_ctlblk *kcb)
+static nokprobe_inline int kprobe_is_ss(struct kprobe_ctlblk *kcb)
 {
 	return (kcb->kprobe_status == KPROBE_HIT_SS ||
 		kcb->kprobe_status == KPROBE_REENTER);
