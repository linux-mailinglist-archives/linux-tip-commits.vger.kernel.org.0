Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA6CE4547F2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Nov 2021 15:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhKQODm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Nov 2021 09:03:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60088 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbhKQOCx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Nov 2021 09:02:53 -0500
Date:   Wed, 17 Nov 2021 13:59:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637157594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/v1dTwBKuhdFUpu/elDgTQ2fQkYpt84Y+CQSLysfXk=;
        b=PlACaEUS7gzwJCSyMobPk2ujXVhk+U1vSu5xllhqAZ/GSeVMeKn9nrJ9yDRNm6TTL7F7YP
        wE8TUefDQ4f/Jwt+eRb58UMALwC93tNcLnL0lfhdnDZH/XdVlOldNk1xpyojtvFLzZ6T+N
        EXWBrAsUXFAK3GaD28+GVsJA/fBX1YqfmrRB84Gy7DDWd/E0IVqzvjVFyGkIl/U9SqZdLQ
        luLICy7CkGNJzLZmtAynCbhTGU9gxBudB3uCwHzDnLBCE35LLIBMHhzscge+/fx84EDcyG
        3/yGf7eWh9mPY3FCNlDzZ6zr/f6y42Lj9RO5UZawuMLsHW43tkOmpV9s68v02w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637157594;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/v1dTwBKuhdFUpu/elDgTQ2fQkYpt84Y+CQSLysfXk=;
        b=8XnE/A63LHOGwQugEFOoJ6rcO7Vtv8Vv3xFSvVJZYvd7HNNeJgC13lNhn2iwIvVnHNYnvy
        tzC90i1MR0ID7aDw==
From:   "tip-bot2 for Alexander Antonov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/uncore: Fix IIO event constraints
 for Skylake Server
Cc:     Alexander Antonov <alexander.antonov@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211115090334.3789-3-alexander.antonov@linux.intel.com>
References: <20211115090334.3789-3-alexander.antonov@linux.intel.com>
MIME-Version: 1.0
Message-ID: <163715759351.11128.8247170608950065417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     3866ae319c846a612109c008f43cba80b8c15e86
Gitweb:        https://git.kernel.org/tip/3866ae319c846a612109c008f43cba80b8c15e86
Author:        Alexander Antonov <alexander.antonov@linux.intel.com>
AuthorDate:    Mon, 15 Nov 2021 12:03:33 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Nov 2021 14:48:43 +01:00

perf/x86/intel/uncore: Fix IIO event constraints for Skylake Server

According to the latest uncore document, COMP_BUF_OCCUPANCY (0xd5) event
can be collected on 2-3 counters. Update uncore IIO event constraints for
Skylake Server.

Fixes: cd34cd97b7b4 ("perf/x86/intel/uncore: Add Skylake server uncore support")
Signed-off-by: Alexander Antonov <alexander.antonov@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lore.kernel.org/r/20211115090334.3789-3-alexander.antonov@linux.intel.com
---
 arch/x86/events/intel/uncore_snbep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore_snbep.c b/arch/x86/events/intel/uncore_snbep.c
index e5ee6bb..9aba4ef 100644
--- a/arch/x86/events/intel/uncore_snbep.c
+++ b/arch/x86/events/intel/uncore_snbep.c
@@ -3678,6 +3678,7 @@ static struct event_constraint skx_uncore_iio_constraints[] = {
 	UNCORE_EVENT_CONSTRAINT(0xc0, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xc5, 0xc),
 	UNCORE_EVENT_CONSTRAINT(0xd4, 0xc),
+	UNCORE_EVENT_CONSTRAINT(0xd5, 0xc),
 	EVENT_CONSTRAINT_END
 };
 
