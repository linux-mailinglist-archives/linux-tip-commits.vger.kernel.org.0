Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0428744D689
	for <lists+linux-tip-commits@lfdr.de>; Thu, 11 Nov 2021 13:22:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233273AbhKKMZH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 11 Nov 2021 07:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230358AbhKKMZG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 11 Nov 2021 07:25:06 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12EDC061766;
        Thu, 11 Nov 2021 04:22:17 -0800 (PST)
Date:   Thu, 11 Nov 2021 12:22:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1636633335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8u+18U3MCvAizRX1h/E8Pl1xmtaOoffX+olwk12KJZw=;
        b=YR7qHkkWojyikABQc/JgvcK8hJxS7LsA44mPgwh8P7TTgepVLQb724/NIKdNVkLIUDDrOT
        XG9xuvjfOjmPGpS5DVzImB4h/ZLB9D7FiYpFbZOjKc3I4Ihd6SYrSs+4XFTvMTp/hbtbEJ
        +km13OVMVLfTidwOR3PlLnAdt5gJa9kLj66pYyGc9Uc9dYrznJzBbzX6qaWt3dXdE9ukoO
        f5k+GbulP2dN7nN//fPUbJbgQl8qhrhbo2SkmpmWk8TaFf1HB6lw4cXNxKZEKxjd6zY6JK
        /adY0rCd2i3Pi1y78OP76VJ0lqbDtpDqS27CEtxdx7GJuv8V5LN9yd1HQ8drHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1636633335;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8u+18U3MCvAizRX1h/E8Pl1xmtaOoffX+olwk12KJZw=;
        b=UZ9C6HhDHjEpo+AyrEeYrCnh8x+MZ/K7d8BiZh1T4x+oXZWp9tC7Msq3+8aQwOMCZCciWS
        Pg+fGVxtoqAnmwDw==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/vlbr: Add c->flags to vlbr event constraints
Cc:     Wanpeng Li <wanpengli@tencent.com>, Like Xu <likexu@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211103091716.59906-1-likexu@tencent.com>
References: <20211103091716.59906-1-likexu@tencent.com>
MIME-Version: 1.0
Message-ID: <163663333418.414.6419093394165937919.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     5863702561e625903ec678551cb056a4b19e0b8a
Gitweb:        https://git.kernel.org/tip/5863702561e625903ec678551cb056a4b19e0b8a
Author:        Like Xu <likexu@tencent.com>
AuthorDate:    Wed, 03 Nov 2021 17:17:16 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 11 Nov 2021 13:09:34 +01:00

perf/x86/vlbr: Add c->flags to vlbr event constraints

Just like what we do in the x86_get_event_constraints(), the
PERF_X86_EVENT_LBR_SELECT flag should also be propagated
to event->hw.flags so that the host lbr driver can save/restore
MSR_LBR_SELECT for the special vlbr event created by KVM or BPF.

Fixes: 097e4311cda9 ("perf/x86: Add constraint to create guest LBR event without hw counter")
Reported-by: Wanpeng Li <wanpengli@tencent.com>
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Wanpeng Li <wanpengli@tencent.com>
Link: https://lore.kernel.org/r/20211103091716.59906-1-likexu@tencent.com
---
 arch/x86/events/intel/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6039644..42cf01e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3048,8 +3048,10 @@ intel_vlbr_constraints(struct perf_event *event)
 {
 	struct event_constraint *c = &vlbr_constraint;
 
-	if (unlikely(constraint_match(c, event->hw.config)))
+	if (unlikely(constraint_match(c, event->hw.config))) {
+		event->hw.flags |= c->flags;
 		return c;
+	}
 
 	return NULL;
 }
