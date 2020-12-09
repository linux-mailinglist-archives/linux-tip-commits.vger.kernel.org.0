Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D146D2D496E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgLISsF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:48:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733142AbgLISpV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:45:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB8CC061794;
        Wed,  9 Dec 2020 10:44:41 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:44:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fBsxs3/XZwS3msehcIWVlg2tC77oBTO8bCMzwEsFW9U=;
        b=Am/Huk9+Nm1uTtCfKBrOUuK7yB8IiNlQMo1Xu1t6BEMSVxNvHLJCmdm6cYhJ0s8skbnVmY
        nkcBGcEcf/L9RpriNh8xSn6qfdnFHIZqU5UarzVls+T2puHXQt38S760cBHuE7oHV4SXaZ
        CtlCyk/ozqfCWq7dWpi08lfcmw3enBjBSYvH7Ovwr2dweAjQNz+QAbA+lNAf4hLP9WuLTK
        XdfsTBKsgX5eBM1akj4+ltrHQlpGQCNSezXR5PEFpdJt7xKrbdCoUQ4Z6IQAG1JV6/+gcG
        Q5X270LFf2kcVM2HYkehBr1oH9+xcqnUgbZ71oIpAg4yDarpKMZfsIvvMzDgrw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539480;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=fBsxs3/XZwS3msehcIWVlg2tC77oBTO8bCMzwEsFW9U=;
        b=svx0tRdm0zSEid8JbSCCYC9JnwQBkatt4epmqOEUVuJ2eFZv4541SWeCWaX4C3Z+A/omj1
        rAm1/+CLKDEqF/Cw==
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kprobes/x86: Fix fall-through warnings for Clang
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160753947955.3364.11416380565722060677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e689b300c99ca2dd80d3f662e19499bba27cda09
Gitweb:        https://git.kernel.org/tip/e689b300c99ca2dd80d3f662e19499bba27cda09
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Fri, 20 Nov 2020 12:30:44 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:58 +01:00

kprobes/x86: Fix fall-through warnings for Clang

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a break statement instead of just letting the code
fall through to the next case.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/KSPP/linux/issues/115
---
 arch/x86/kernel/kprobes/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 39f7d8c..a65e9e9 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -864,6 +864,7 @@ static void resume_execution(struct kprobe *p, struct pt_regs *regs,
 			p->ainsn.boostable = true;
 			goto no_change;
 		}
+		break;
 	default:
 		break;
 	}
