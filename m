Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 24B6F283124
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Oct 2020 09:54:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725917AbgJEHyA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Oct 2020 03:54:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56800 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHyA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Oct 2020 03:54:00 -0400
Date:   Mon, 05 Oct 2020 07:53:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601884438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JrlK+rR8v4IwCjI2MWMAnNL4REFxgA/+kUXTxSm2qI=;
        b=SyapVYX8zwsekqMygVaMstSg3QpfWgfWZ1eexd25LexaLJZS3tiV28kansjWNxulJzv4jw
        hByjT+7zCocKZtx6VdIuQMKO9XN0HIH6dtChAscUd7CR9gxesi10tD+XXcP62HYP/ek6Hs
        nx8Ew0U/CXSzfuKAu3oy6pAy2b4YkXn0Y+cZdnYhrOGsg82wBcYsiPHYrChAcZUFiH3FyG
        0mKleQR8Wy3/mL1knocKCOjWN+NBiWv4hcbLkrmdJMzNpx1m3PUujR4RKYkyuFshN8oepz
        R58sLC8EPb2cFl8w81+CdsShfaNDOkWIctLrITNEoSJ3lDww9vtkA1as/wuLEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601884438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JrlK+rR8v4IwCjI2MWMAnNL4REFxgA/+kUXTxSm2qI=;
        b=jRsARHLx1ChYdbx+TPtgNablRtJdhDQcj7yIe1XVmE2iXnpcBT9OZZ+XD251Gjl8uPenop
        rUU2sApS3pr0swDw==
From:   "tip-bot2 for Colin Ian King" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/events/amd/iommu: Fix sizeof mismatch
Cc:     Colin Ian King <colin.king@canonical.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001113900.58889-1-colin.king@canonical.com>
References: <20201001113900.58889-1-colin.king@canonical.com>
MIME-Version: 1.0
Message-ID: <160188443750.7002.16043563500088423723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     59d5396a4666195f89a67e118e9e627ddd6f53a1
Gitweb:        https://git.kernel.org/tip/59d5396a4666195f89a67e118e9e627ddd6f53a1
Author:        Colin Ian King <colin.king@canonical.com>
AuthorDate:    Thu, 01 Oct 2020 12:39:00 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 Oct 2020 16:30:56 +02:00

x86/events/amd/iommu: Fix sizeof mismatch

An incorrect sizeof is being used, struct attribute ** is not correct,
it should be struct attribute *. Note that since ** is the same size as
* this is not causing any issues.  Improve this fix by using sizeof(*attrs)
as this allows us to not even reference the type of the pointer.

Addresses-Coverity: ("Sizeof not portable (SIZEOF_MISMATCH)")
Fixes: 51686546304f ("x86/events/amd/iommu: Fix sysfs perf attribute groups")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201001113900.58889-1-colin.king@canonical.com
---
 arch/x86/events/amd/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index fb61620..be50ef8 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -379,7 +379,7 @@ static __init int _init_events_attrs(void)
 	while (amd_iommu_v2_event_descs[i].attr.attr.name)
 		i++;
 
-	attrs = kcalloc(i + 1, sizeof(struct attribute **), GFP_KERNEL);
+	attrs = kcalloc(i + 1, sizeof(*attrs), GFP_KERNEL);
 	if (!attrs)
 		return -ENOMEM;
 
