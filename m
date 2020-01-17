Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C45FF140815
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Jan 2020 11:37:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgAQKh3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Jan 2020 05:37:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55542 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgAQKh1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Jan 2020 05:37:27 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isP0A-0006Hp-TT; Fri, 17 Jan 2020 11:37:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 841621C19DA;
        Fri, 17 Jan 2020 11:37:18 +0100 (CET)
Date:   Fri, 17 Jan 2020 10:37:18 -0000
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf: Correctly handle failed perf_get_aux_event()
Cc:     Vince Weaver <vincent.weaver@maine.edu>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <157925743836.396.4515564402096923150.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     da9ec3d3dd0f1240a48920be063448a2242dbd90
Gitweb:        https://git.kernel.org/tip/da9ec3d3dd0f1240a48920be063448a2242dbd90
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Mon, 06 Jan 2020 12:03:39 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 17 Jan 2020 11:32:44 +01:00

perf: Correctly handle failed perf_get_aux_event()

Vince reports a worrying issue:

| so I was tracking down some odd behavior in the perf_fuzzer which turns
| out to be because perf_even_open() sometimes returns 0 (indicating a file
| descriptor of 0) even though as far as I can tell stdin is still open.

... and further the cause:

| error is triggered if aux_sample_size has non-zero value.
|
| seems to be this line in kernel/events/core.c:
|
| if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
|                goto err_locked;
|
| (note, err is never set)

This seems to be a thinko in commit:

  ab43762ef010967e ("perf: Allow normal events to output AUX data")

... and we should probably return -EINVAL here, as this should only
happen when the new event is mis-configured or does not have a
compatible aux_event group leader.

Fixes: ab43762ef010967e ("perf: Allow normal events to output AUX data")
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
---
 kernel/events/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index a1f8bde..2173c23 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11465,8 +11465,10 @@ SYSCALL_DEFINE5(perf_event_open,
 		}
 	}
 
-	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader))
+	if (perf_need_aux_event(event) && !perf_get_aux_event(event, group_leader)) {
+		err = -EINVAL;
 		goto err_locked;
+	}
 
 	/*
 	 * Must be under the same ctx::mutex as perf_install_in_context(),
