Return-Path: <linux-tip-commits+bounces-5691-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47719ABF3FE
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:16:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECF144E191C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:16:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E766267B67;
	Wed, 21 May 2025 12:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L/U3Tpnb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="93LVmahp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701C4267389;
	Wed, 21 May 2025 12:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829759; cv=none; b=cFhChgHMTZo+qoSa3baMzuf5hbHAoTxFxGatkJ4yiATmuRF/hFkTKqjQz5T3/p4GE1Bp2pk/iog2Q/Yfrv+E3HLz7lgGeCgv+TpBHU3WBDg5Gwqo3ScLVBHvEKLZvRFK251ufOR+uFTwmi5DZdGMjjQ88hfzRMBA8NsdXiWZeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829759; c=relaxed/simple;
	bh=CKujW5gwq2c1ix4YLBvQBMorSn0i1MPdLMFYh6cfSdU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TcwPzNmwlKFq2adYdA+0v8eMExxyLXWtEMBW0iuuO4S/Do6U+FR7w51ocULgCOKhjfMWeLtbVOHYs6EkJiETB4Mn/lYh7TV29kRnvPEee24dKzkhq1K8YeiEjRwsGSMdaWlJxq86CNQLyKrcuWmAHTBVUFyqFN05wj6KvxfBeQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L/U3Tpnb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=93LVmahp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CN8bOL7ZatD8eD1Aak7eSTw4FJIC8kQ05UsnnTEdXGI=;
	b=L/U3TpnbDY/gWPWL5KNeYnq6MRmaJxlFyFA2itMU1ybmi8rR/WUbzlAoIUIa4Klrye3c82
	5NYuiPNwnnMw6KGWr8pAiA4mGA/xNhzV+SLet34jAESLc2hr+IlU0iSudnNClNsXQrzrml
	UXCc2JB2hxCE8+mHR0axk2jXb1nHawmqmT9HLiFcm+iA5RDaMea2wrtTjki+ICTBlKJQoh
	q5tKRTG+37y8KRCz6Z+JEfwuostqAESdvEAa8p3iWMnO8pEShTs9G0YXk+owqh4YoByFTn
	W7tLveolRoyEYFisZiY0kzmVQnhlU7111V0QBVjFg65Sry+Ob4EIdNF0RR3M6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CN8bOL7ZatD8eD1Aak7eSTw4FJIC8kQ05UsnnTEdXGI=;
	b=93LVmahpYr1g6O2Hj0/7oaG7PiGUhH6WfxQplpjuTsEw9JIbV8+pFyU24KRGSC7Qgp2osh
	XBqyZ0Ax9RqEZSAQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] csky/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, Guo Ren <guoren@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-13-kan.liang@linux.intel.com>
References: <20250520181644.2673067-13-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975489.406.16985571856610591319.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     141fedea798f3a89d791ff2eef3c6afd4906dcb7
Gitweb:        https://git.kernel.org/tip/141fedea798f3a89d791ff2eef3c6afd4906dcb7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:40 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:45 +02:00

csky/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Guo Ren <guoren@kernel.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-13-kan.liang@linux.intel.com
---
 arch/csky/kernel/perf_event.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/csky/kernel/perf_event.c b/arch/csky/kernel/perf_event.c
index e5f1842..e0a36ac 100644
--- a/arch/csky/kernel/perf_event.c
+++ b/arch/csky/kernel/perf_event.c
@@ -1139,8 +1139,7 @@ static irqreturn_t csky_pmu_handle_irq(int irq_num, void *dev)
 		perf_sample_data_init(&data, 0, hwc->last_period);
 		csky_pmu_event_set_period(event);
 
-		if (perf_event_overflow(event, &data, regs))
-			csky_pmu_stop_event(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	csky_pmu_enable(&csky_pmu.pmu);

