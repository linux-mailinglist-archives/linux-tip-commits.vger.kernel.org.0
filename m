Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A0365684
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230408AbhDTKrP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbhDTKrO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E74DC06174A;
        Tue, 20 Apr 2021 03:46:42 -0700 (PDT)
Date:   Tue, 20 Apr 2021 10:46:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPjZ37km25NO7P5nR+TFY+2jHQtFFwXko13mnsqGnkY=;
        b=Tm5tjkLPBp2QqAuuypqe0aLKDHJlgbV6cWh9s6Kh4FHqvhEaoG5mxPm9iDrBedjDnZZqQc
        L1sRPn5rWnmYiUKdBnwvu9z24UU2E2rQf5PX+x709PS5omUScoro+P4NwM1dxjLEI/B1OO
        0RrkcdWUkoklBuw+ToXV3kiunTPdRsuLJZeB0sE3knUvMtYlDvFEUpTrPFmydS/p7wqXrf
        md/FnIwtOXL0GhPyKFSQi2xoUzGqa19ZazdQuSj4k0kS8FxJu/nn8UIDqxYSZ34dR6s3cI
        NL5G4jPWvyLtq03jaWeFqazW8DAMAaxD7AYjGBN5CLK/EY4E2toLl27k/7unkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915601;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JPjZ37km25NO7P5nR+TFY+2jHQtFFwXko13mnsqGnkY=;
        b=65wuD/oueWkuO6IxLZ+n8/eYZdEQv7gc/HfkHCGoulbYKmMX2qsl+JCstXCazSWYhPESl4
        tQc4FliXy6QX5eDQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Add support for Intel Alder Lake
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-26-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-26-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560025.29796.10364628260224993629.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6a5f4386798d81f7f413e93c87e2b6de7439beea
Gitweb:        https://git.kernel.org/tip/6a5f4386798d81f7f413e93c87e2b6de7439beea
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:31:05 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:30 +02:00

perf/x86/rapl: Add support for Intel Alder Lake

Alder Lake RAPL support is the same as previous Sky Lake.
Add Alder Lake model for RAPL.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-26-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/rapl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index f42a704..84a1042 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -800,6 +800,8 @@ static const struct x86_cpu_id rapl_model_match[] __initconst = {
 	X86_MATCH_INTEL_FAM6_MODEL(ICELAKE_X,		&model_hsx),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(COMETLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE,		&model_skl),
+	X86_MATCH_INTEL_FAM6_MODEL(ALDERLAKE_L,		&model_skl),
 	X86_MATCH_INTEL_FAM6_MODEL(SAPPHIRERAPIDS_X,	&model_spr),
 	X86_MATCH_VENDOR_FAM(AMD,	0x17,		&model_amd_fam17h),
 	X86_MATCH_VENDOR_FAM(HYGON,	0x18,		&model_amd_fam17h),
