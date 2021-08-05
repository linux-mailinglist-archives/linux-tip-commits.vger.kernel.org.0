Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE6B83E1156
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237881AbhHEJeo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:34:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41612 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231775AbhHEJeo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:44 -0400
Date:   Thu, 05 Aug 2021 09:34:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WsqrNqs+4nsAmCYBAhqfSPPv+BLDokFxc7aRaebVPYQ=;
        b=XwuuEyQf9JwMJfhlJCpzDDlntZ6fz1cmmNa62nmMa/jNllTmRt7fqKrgJf9x7qlgG7GRNP
        mzZoXCULYhMxnpCXAvX9UCYCLS/6/aSMjVLHD4PnrZ42M3PYf3sIzJxg8p9OWkJWUwD0D3
        FBkE0P9GrU5Ays1+fVLg843ICqYncVCbIadJp4ZrSe7Qc2ek07p/UhvPwjlXkxGM2cJfw+
        0jCs0gnGxs6Y5GpK2bkTOavwlBPnv0FjuWz4UBTEj3/JL0wu4RyLW7LroI3YcNzdYENDb0
        AMiwqV8ahXHrlbDfCi6JEaRdWw5l7o0HgWrLvWFbXgDehyvkw7lAhxpHk+JOGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156069;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WsqrNqs+4nsAmCYBAhqfSPPv+BLDokFxc7aRaebVPYQ=;
        b=IOkr7FtR8JWLcAsMoqSb1RvsT8Z86bsQKWCSMB/VFFcJWoZNUn1RHJX7Gdlu/3UigRLJCy
        1V1a48gsKkJWywCA==
From:   "tip-bot2 for Like Xu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/amd: Don't touch the
 AMD64_EVENTSEL_HOSTONLY bit inside the guest
Cc:     Like Xu <likexu@tencent.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Liam Merwick <liam.merwick@oracle.com>,
        Kim Phillips <kim.phillips@amd.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210802070850.35295-1-likexu@tencent.com>
References: <20210802070850.35295-1-likexu@tencent.com>
MIME-Version: 1.0
Message-ID: <162815606869.395.8997137741272927624.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     df51fe7ea1c1c2c3bfdb81279712fdd2e4ea6c27
Gitweb:        https://git.kernel.org/tip/df51fe7ea1c1c2c3bfdb81279712fdd2e4ea6c27
Author:        Like Xu <likexu@tencent.com>
AuthorDate:    Mon, 02 Aug 2021 15:08:50 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:34 +02:00

perf/x86/amd: Don't touch the AMD64_EVENTSEL_HOSTONLY bit inside the guest

If we use "perf record" in an AMD Milan guest, dmesg reports a #GP
warning from an unchecked MSR access error on MSR_F15H_PERF_CTLx:

  [] unchecked MSR access error: WRMSR to 0xc0010200 (tried to write 0x0000020000110076) at rIP: 0xffffffff8106ddb4 (native_write_msr+0x4/0x20)
  [] Call Trace:
  []  amd_pmu_disable_event+0x22/0x90
  []  x86_pmu_stop+0x4c/0xa0
  []  x86_pmu_del+0x3a/0x140

The AMD64_EVENTSEL_HOSTONLY bit is defined and used on the host,
while the guest perf driver should avoid such use.

Fixes: 1018faa6cf23 ("perf/x86/kvm: Fix Host-Only/Guest-Only counting with SVM disabled")
Signed-off-by: Like Xu <likexu@tencent.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Liam Merwick <liam.merwick@oracle.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Tested-by: Liam Merwick <liam.merwick@oracle.com>
Link: https://lkml.kernel.org/r/20210802070850.35295-1-likexu@tencent.com
---
 arch/x86/events/perf_event.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2bf1c7e..2938c90 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1115,9 +1115,10 @@ void x86_pmu_stop(struct perf_event *event, int flags);
 
 static inline void x86_pmu_disable_event(struct perf_event *event)
 {
+	u64 disable_mask = __this_cpu_read(cpu_hw_events.perf_ctr_virt_mask);
 	struct hw_perf_event *hwc = &event->hw;
 
-	wrmsrl(hwc->config_base, hwc->config);
+	wrmsrl(hwc->config_base, hwc->config & ~disable_mask);
 
 	if (is_counter_pair(hwc))
 		wrmsrl(x86_pmu_config_addr(hwc->idx + 1), 0);
