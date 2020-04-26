Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D6A1B8D10
	for <lists+linux-tip-commits@lfdr.de>; Sun, 26 Apr 2020 08:48:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726400AbgDZGr5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 26 Apr 2020 02:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726396AbgDZGr4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 26 Apr 2020 02:47:56 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86818C061A0C;
        Sat, 25 Apr 2020 23:47:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jSb4m-0008Qu-CW; Sun, 26 Apr 2020 08:47:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E0B581C0330;
        Sun, 26 Apr 2020 08:47:39 +0200 (CEST)
Date:   Sun, 26 Apr 2020 06:47:39 -0000
From:   "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/unwind/orc: Fix error path for bad ORC entry type
Cc:     Miroslav Benes <mbenes@suse.cz>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Dave Jones <dsj@fb.com>,
        Jann Horn <jannh@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vince Weaver <vincent.weaver@maine.edu>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <a7fa668ca6eabbe81ab18b2424f15adbbfdc810a.1587808742.git.jpoimboe@redhat.com>
References: <a7fa668ca6eabbe81ab18b2424f15adbbfdc810a.1587808742.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Message-ID: <158788365953.28353.4461264863668999890.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     a0f81bf26888048100bf017fadf438a5bdffa8d8
Gitweb:        https://git.kernel.org/tip/a0f81bf26888048100bf017fadf438a5bdffa8d8
Author:        Josh Poimboeuf <jpoimboe@redhat.com>
AuthorDate:    Sat, 25 Apr 2020 05:06:13 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 25 Apr 2020 12:22:29 +02:00

x86/unwind/orc: Fix error path for bad ORC entry type

If the ORC entry type is unknown, nothing else can be done other than
reporting an error.  Exit the function instead of breaking out of the
switch statement.

Fixes: ee9f8fce9964 ("x86/unwind: Add the ORC unwinder")
Reviewed-by: Miroslav Benes <mbenes@suse.cz>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Dave Jones <dsj@fb.com>
Cc: Jann Horn <jannh@google.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/a7fa668ca6eabbe81ab18b2424f15adbbfdc810a.1587808742.git.jpoimboe@redhat.com
---
 arch/x86/kernel/unwind_orc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/unwind_orc.c b/arch/x86/kernel/unwind_orc.c
index cb11567..33b80a7 100644
--- a/arch/x86/kernel/unwind_orc.c
+++ b/arch/x86/kernel/unwind_orc.c
@@ -537,7 +537,7 @@ bool unwind_next_frame(struct unwind_state *state)
 	default:
 		orc_warn("unknown .orc_unwind entry type %d at %pB\n",
 			 orc->type, (void *)orig_ip);
-		break;
+		goto err;
 	}
 
 	/* Find BP: */
