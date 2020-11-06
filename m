Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C21572A94F5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Nov 2020 12:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbgKFLBt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Nov 2020 06:01:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726422AbgKFLBt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Nov 2020 06:01:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD38C0613CF;
        Fri,  6 Nov 2020 03:01:49 -0800 (PST)
Date:   Fri, 06 Nov 2020 11:01:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604660507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+Lr4luvqX5AY0oKUf3vEzGcztSHnX4u0eLOHWhgpkw=;
        b=zwfm3igvkySGAOyiB4zH/fTFSdev8dHh2d5EgU7kq5XXNptYX6qlk+aIqiOOW4BkXfrYFp
        sTm8eRUmXCac8HWFa5F43Ga+WqpAP9s0Kb1VsgaN2N4EpUE0dzpu0Yke64QnAKmJDm53zL
        drAq1p2zyN5gdUVgAuzacr2jN2a2SRH1G0Gp4mAk4E0SOyhwudA0HngqUVrOpkrg9Dw0oC
        6LvdppRlcFwUj9rwhtFZta/RJPVpBWqPHgxe3TCc9ue//kwIAkeugK8k/Wv5U4r836Ij3s
        2YlTMjwLSyGKv400RFf0oZmvBK4wKpTJhalwNYjFGnL7caBDbpo8T+yYvPXMmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604660507;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l+Lr4luvqX5AY0oKUf3vEzGcztSHnX4u0eLOHWhgpkw=;
        b=6X3twlw3vfhVXIQ/ZXk2cuUaNOrGKd73j7WZ4/ox8s1SKNEaeMsEemCFA2+kIbFMsC6yyG
        qLhxSh2/dyajqhDA==
From:   "tip-bot2 for Kaixu Xia" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] x86/mce: Assign boolean values to a bool variable
Cc:     Tosk Robot <tencent_os_robot@tencent.com>,
        Kaixu Xia <kaixuxia@tencent.com>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1604654363-1463-1-git-send-email-kaixuxia@tencent.com>
References: <1604654363-1463-1-git-send-email-kaixuxia@tencent.com>
MIME-Version: 1.0
Message-ID: <160466050594.397.9879783882609753138.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     77080929d56d87a57093869a15d2785b8b2d8cd5
Gitweb:        https://git.kernel.org/tip/77080929d56d87a57093869a15d2785b8b2d8cd5
Author:        Kaixu Xia <kaixuxia@tencent.com>
AuthorDate:    Fri, 06 Nov 2020 17:19:23 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Fri, 06 Nov 2020 11:51:04 +01:00

x86/mce: Assign boolean values to a bool variable

Fix the following coccinelle warnings:

  ./arch/x86/kernel/cpu/mce/core.c:1765:3-20: WARNING: Assignment of 0/1 to bool variable
  ./arch/x86/kernel/cpu/mce/core.c:1584:2-9: WARNING: Assignment of 0/1 to bool variable

 [ bp: Massage commit message. ]

Reported-by: Tosk Robot <tencent_os_robot@tencent.com>
Signed-off-by: Kaixu Xia <kaixuxia@tencent.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/1604654363-1463-1-git-send-email-kaixuxia@tencent.com
---
 arch/x86/kernel/cpu/mce/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
index 51bf910..888248a 100644
--- a/arch/x86/kernel/cpu/mce/core.c
+++ b/arch/x86/kernel/cpu/mce/core.c
@@ -1581,7 +1581,7 @@ static void __mcheck_cpu_mce_banks_init(void)
 		 * __mcheck_cpu_init_clear_banks() does the final bank setup.
 		 */
 		b->ctl = -1ULL;
-		b->init = 1;
+		b->init = true;
 	}
 }
 
@@ -1762,7 +1762,7 @@ static int __mcheck_cpu_apply_quirks(struct cpuinfo_x86 *c)
 		 */
 
 		if (c->x86 == 6 && c->x86_model < 0x1A && this_cpu_read(mce_num_banks) > 0)
-			mce_banks[0].init = 0;
+			mce_banks[0].init = false;
 
 		/*
 		 * All newer Intel systems support MCE broadcasting. Enable
