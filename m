Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9073231688C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:00:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhBJOAY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:24 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60182 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231419AbhBJOAO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:14 -0500
Date:   Wed, 10 Feb 2021 13:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5twxcMTESUJy4VsUJZl6DxaJC26vQah7lRxd18c0y4U=;
        b=w6N3urLKu9UZMLqxyN7q7nQ50Qi8AA0LSMFtHyDNO+nCEpwfyE4brNF+gt6BRqOVI/7Wfn
        d5WqlVzcsvdeiAGFWZ7LUcWtlQUkyQvBpu41HJMPlk29cx/+s4JBPJXi4agg4iBntketvw
        SFf5Oi/y4cbgL7vpcc29H79uiI6qiM0stIVl5KFG1ArJdW1+7k3zomRxABolFZnigymEX/
        3Su53p7r8Ah/cajfVRK6W7GuS66h3bD+cufT88QD5wp7T0Eq/SliuCzaDydbBZQsH8TYXS
        JS4uMNn11F0qNH2m7plT2TrfcxoIkKQfItHdgl68ZM4DAgQvKHFsxUZ4O0wI+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965571;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5twxcMTESUJy4VsUJZl6DxaJC26vQah7lRxd18c0y4U=;
        b=CY2XDSbuZjPdjzJfW1lJXi4H6LdCA4VerYFoKSfJlCBjAC/Lcsk2DirVQL5tSJzQQJwDA+
        LftQAiXzKPEDUnBA==
From:   "tip-bot2 for Jim Mattson" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/kvm: Add Cascade Lake Xeon steppings to
 isolation_ucodes[]
Cc:     Jim Mattson <jmattson@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210205191324.2889006-1-jmattson@google.com>
References: <20210205191324.2889006-1-jmattson@google.com>
MIME-Version: 1.0
Message-ID: <161296557060.23325.2852849746600741313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b3c3361fe325074d4144c29d46daae4fc5a268d5
Gitweb:        https://git.kernel.org/tip/b3c3361fe325074d4144c29d46daae4fc5a268d5
Author:        Jim Mattson <jmattson@google.com>
AuthorDate:    Fri, 05 Feb 2021 11:13:24 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:54 +01:00

perf/x86/kvm: Add Cascade Lake Xeon steppings to isolation_ucodes[]

Cascade Lake Xeon parts have the same model number as Skylake Xeon
parts, so they are tagged with the intel_pebs_isolation
quirk. However, as with Skylake Xeon H0 stepping parts, the PEBS
isolation issue is fixed in all microcode versions.

Add the Cascade Lake Xeon steppings (5, 6, and 7) to the
isolation_ucodes[] table so that these parts benefit from Andi's
optimization in commit 9b545c04abd4f ("perf/x86/kvm: Avoid unnecessary
work in guest filtering").

Signed-off-by: Jim Mattson <jmattson@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20210205191324.2889006-1-jmattson@google.com
---
 arch/x86/events/intel/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 67a7246..5bac48d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4513,6 +4513,9 @@ static const struct x86_cpu_desc isolation_ucodes[] = {
 	INTEL_CPU_DESC(INTEL_FAM6_BROADWELL_X,		 2, 0x0b000014),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 3, 0x00000021),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 4, 0x00000000),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 5, 0x00000000),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 6, 0x00000000),
+	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_X,		 7, 0x00000000),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE_L,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_SKYLAKE,		 3, 0x0000007c),
 	INTEL_CPU_DESC(INTEL_FAM6_KABYLAKE,		 9, 0x0000004e),
