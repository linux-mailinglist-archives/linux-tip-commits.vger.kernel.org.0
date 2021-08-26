Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1EE3F8389
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:10:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240501AbhHZIKp (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:45 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58836 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240461AbhHZIKn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:43 -0400
Date:   Thu, 26 Aug 2021 08:09:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAqW8T8xhvkfJM7DfZyLLgPU0ptDgIHYveKLys7kjFo=;
        b=OSF/r8XPUEwRVyl/4sb5R3oupC1I4flm/ooBV5pBW2Os5eGg+qLA4SDC7zrkX7+UumRD3i
        T5XDg4ttqn3ScBNktMFtefED1kDwJT3gF36YhAItOuJUy9zNiRyVO8ACx77gnLs5I9R6mw
        vMudrXn9l96Xe6P1jCThu97UMPzl79PiICkYc+j7swvENN8yuVpndbP4zz9nhf7tMLd/nX
        yDQ3N5a9teg3gfbGFGXVYAhqothC3ByJY2eEbWtEKcmTBbaXt5v9Xc//I3oGCJIrxyConb
        gyY+yhyOv13NrZjPpYl9R2T79yn+1j1XX14+yW1iCB4CuiJznlvTE081ikwDwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965395;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HAqW8T8xhvkfJM7DfZyLLgPU0ptDgIHYveKLys7kjFo=;
        b=8eB1/rJ+102TCMIlovzCDxY0/B97GLdUEgd6E4g1XoHwzu4QuGyTfQNMDkcHesnFJYIbuM
        3jjItgR2kZZYXkBg==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Remove unused assignment to pointer 'e'
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210804115710.109608-1-colin.king@canonical.com>
References: <20210804115710.109608-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <162996539449.25758.14195988009283240730.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4f32da76a1401dcd088930f0ac8658425524368b
Gitweb:        https://git.kernel.org/tip/4f32da76a1401dcd088930f0ac8658425524368b
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Wed, 04 Aug 2021 12:57:10 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

perf/x86: Remove unused assignment to pointer 'e'

The pointer 'e' is being assigned a value that is never read, the assignment
is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210804115710.109608-1-colin.king@canonical.com
---
 arch/x86/events/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 3092fbf..2a57dbe 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1087,10 +1087,8 @@ int x86_schedule_events(struct cpu_hw_events *cpuc, int n, int *assign)
 	 * validate an event group (assign == NULL)
 	 */
 	if (!unsched && assign) {
-		for (i = 0; i < n; i++) {
-			e = cpuc->event_list[i];
+		for (i = 0; i < n; i++)
 			static_call_cond(x86_pmu_commit_scheduling)(cpuc, i, assign[i]);
-		}
 	} else {
 		for (i = n0; i < n; i++) {
 			e = cpuc->event_list[i];
