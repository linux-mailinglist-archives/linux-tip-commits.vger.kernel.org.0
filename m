Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74EB1368D5D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Apr 2021 08:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229982AbhDWGxl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Apr 2021 02:53:41 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43960 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236912AbhDWGxj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Apr 2021 02:53:39 -0400
Date:   Fri, 23 Apr 2021 06:53:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619160782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNwC/AdgJh7IWk0JmaPbfWHUIUUbGUL+5EHo0wvdeSs=;
        b=qncua5bCAJs10tHh4atzoQy6QnoAGnWC5Q1Gxr0v/RUXgikYsbIBBxGZtFKoWlKC3qGhU/
        kus1xAHHK/c9LeK9Ypc2qQjdvUf8AyKUQr9OdiBzoFPFTGW7EfOYxVxkJ37nxwYnNehLQ3
        /Wa+DB/khASZmnQLML8WMCmSEH/sUoxpPbQMRGoRdm1ILPy8OHbaL7gu4rfWI1XFqgw2pA
        OKP/8Ct2jOnQJL5zYq+LM1nntEzw+b74/XvRJMdspdJLll0R+ZMlPYIUJfTRdM6OV/BzfX
        7EEjyNDEi/wcUGk7pEXVmOsssL7KgLry5xiK2Ch5HNWSuxLycDPlmw18JTEllA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619160782;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lNwC/AdgJh7IWk0JmaPbfWHUIUUbGUL+5EHo0wvdeSs=;
        b=T7cDiVFl2KBbi3FGXfLxj7xqUJiznVPR6cDY3wu4XhyhXvzlWf423kOtTk8T7cBu1LnudU
        IKiy3SF8+4FSu4Ag==
From:   "tip-bot2 for Jim Mattson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/kvm: Fix Broadwell Xeon stepping in
 isolation_ucodes[]
Cc:     Jim Mattson <jmattson@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Peter Shier <pshier@google.com>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422001834.1748319-1-jmattson@google.com>
References: <20210422001834.1748319-1-jmattson@google.com>
MIME-Version: 1.0
Message-ID: <161916078180.29796.11319206773894740858.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     4b2f1e59229b9da319d358828cdfa4ddbc140769
Gitweb:        https://git.kernel.org/tip/4b2f1e59229b9da319d358828cdfa4ddbc140769
Author:        Jim Mattson <jmattson@google.com>
AuthorDate:    Wed, 21 Apr 2021 17:18:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 22 Apr 2021 14:36:01 +02:00

perf/x86/kvm: Fix Broadwell Xeon stepping in isolation_ucodes[]

The only stepping of Broadwell Xeon parts is stepping 1. Fix the
relevant isolation_ucodes[] entry, which previously enumerated
stepping 2.

Although the original commit was characterized as an optimization, it
is also a workaround for a correctness issue.

If a PMI arrives between kvm's call to perf_guest_get_msrs() and the
subsequent VM-entry, a stale value for the IA32_PEBS_ENABLE MSR may be
restored at the next VM-exit. This is because, unbeknownst to kvm, PMI
throttling may clear bits in the IA32_PEBS_ENABLE MSR. CPUs with "PEBS
isolation" don't suffer from this issue, because perf_guest_get_msrs()
doesn't report the IA32_PEBS_ENABLE value.

Fixes: 9b545c04abd4f ("perf/x86/kvm: Avoid unnecessary work in guest filtering")
Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Peter Shier <pshier@google.com>
Acked-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20210422001834.1748319-1-jmattson@google.com
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 37ce384..c57ec8e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4516,7 +4516,7 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 3, 0x07000009),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 4, 0x0f000009),
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_D,		 5, 0x0e000002),
-	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
+	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 1, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 5, 0x00000000),
