Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C46582D494E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 19:46:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728488AbgLISpV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 13:45:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730088AbgLISpV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 13:45:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA98C0613D6;
        Wed,  9 Dec 2020 10:44:41 -0800 (PST)
Date:   Wed, 09 Dec 2020 18:44:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607539479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qVh1lxee6E4EFRklLOaLoHEQT5kK2uqVuLnzC0Lc9l4=;
        b=LgDRMZn6FE2vhIkzuYifXA9vDvS/s3fXS5EzWEsa3EuZQALl/LxJn2/+MQ67R533SVfVPY
        uOyvK/vQj2+LdkOckMOokhMJeNpk3rJs1+f2Cipvc7TMSzW9k7MI7BL/r9Lv9tsNhsEZIR
        3m8nAGP1Bmf0K+jxSLpCoQp8OMvVefutYx9BlwW5TCGWosfL6FrBvs9JLH7PAj05hdIhWJ
        Uy+WAx4eC0Ry9b+qQFeDqrE/x2zxmFEOT4I0PxdPsD++IJtWlE4IAn8DEv45DHeNUFh/eA
        i4bQXFUUxJ+KZhvpuicOO3jMr4ASa/nw2/fo60wWngcLK1J+eSgfk/12g6Nz9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607539479;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=qVh1lxee6E4EFRklLOaLoHEQT5kK2uqVuLnzC0Lc9l4=;
        b=tevoWUVLz1lGmFxZ0rffA8nVVaMSGUxQd3H90ozWH+rOHxZTNf7re39iO89W8U0gWcC7Qq
        yOvd3YytfVapIhBw==
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Fix fall-through warnings for Clang
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160753947929.3364.12837434700943657500.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b6459575451769b0550621865d1ddb65afdb55a1
Gitweb:        https://git.kernel.org/tip/b6459575451769b0550621865d1ddb65afdb55a1
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Fri, 20 Nov 2020 12:31:36 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Dec 2020 17:08:59 +01:00

perf/x86: Fix fall-through warnings for Clang

In preparation to enable -Wimplicit-fallthrough for Clang, fix a warning
by explicitly adding a fallthrough pseudo-keyword as a replacement for
a /* fall through */ comment, instead of letting the code fall through
to the next case.

Notice that Clang doesn't recognize /* fall through */ comments as
implicit fall-through markings.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://github.com/KSPP/linux/issues/115
---
 arch/x86/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index a88c94d..550c5e7 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1174,7 +1174,7 @@ static inline void x86_assign_hw_event(struct perf_event *event,
 	case INTEL_PMC_IDX_METRIC_BASE ... INTEL_PMC_IDX_METRIC_END:
 		/* All the metric events are mapped onto the fixed counter 3. */
 		idx = INTEL_PMC_IDX_FIXED_SLOTS;
-		/* fall through */
+		fallthrough;
 	case INTEL_PMC_IDX_FIXED ... INTEL_PMC_IDX_FIXED_BTS-1:
 		hwc->config_base = MSR_ARCH_PERFMON_FIXED_CTR_CTRL;
 		hwc->event_base = MSR_ARCH_PERFMON_FIXED_CTR0 +
