Return-Path: <linux-tip-commits+bounces-5698-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF65DABF40F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:17:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454BB161FC6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E9726B966;
	Wed, 21 May 2025 12:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0PRj144i";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0xb1bCnt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E8126A1DB;
	Wed, 21 May 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829764; cv=none; b=jhQvTWZRD8Cl7ZI3hl0Cenamu6NPLp+lo5KAqJRNfGh3GoR4Jza67V/QCclQ4gkHcoHc0ihvijpidaVc82op2Qyz+tYRJjHBQ2yNflSDHp2pBZVjsRuE4HHKqd3dUa0ho8wed+NvCtwJFhQTqtcwvcgwviSivr7zwXfNy6vTEig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829764; c=relaxed/simple;
	bh=YCNi7ylnYMNoYSNunmtOTDtwJsRsc+tITy15rGLeOtg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eB7Q6VnVZR70DOo+NVf9DDol0f42f1jjVA26eu+H8QYu3QA4SKWZDUljqeIKO9CflFri4/4fUcfqrmPr2zq3acs97OZ23YepUm5dthuRfpg5JNuZ0JXGiSkuhyD0r5gS87Qeg9cBjr/K9qSF+8F2m0TsfrrHfTuVI1/nQcF90QE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0PRj144i; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0xb1bCnt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yTz+tCrA4nfKckR7cOtLSianQ3CvYmJGJlgCGZrvMk=;
	b=0PRj144iuYImPnXYH+QL2JME6H7vZ4WJjAb3jY51Vkhii8bgtz7pqbh0GMgo+It6wBbPj1
	osRXNEQZr8bn5Xa8UlZbhpKvrN1ZbIGZmzMaUml+jVPhXqxu3xVN/6uUhHYre3pjmQ/Ifu
	W/D1XM2F/jaVbu1vlbzxlgprppq3RphrUWi0fa3Dltc0IhwpepKWC8fVz0KoC7gVQhpKtu
	0mTxbENaSkzqUQHGtGK7cZyvv0nGibFlYjKEXWm96KIchI92CLVwYV+0DPcP3Z/hRrlKRB
	rLJqPvQAWPak5cOj/5TWuAiGuz8844JUd31Y6gh2i/IEdFBwTQwRDCP2rGp6rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7yTz+tCrA4nfKckR7cOtLSianQ3CvYmJGJlgCGZrvMk=;
	b=0xb1bCntAlruSnwDX9xM6NvZiX0Lm8udWlJvRmYq5b+xCAigtRnSx5kN9qTX2OK2ee9104
	+Qm/XzIVYrBRsUDQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] powerpc/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-7-kan.liang@linux.intel.com>
References: <20250520181644.2673067-7-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782976005.406.12846739060537202982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     954617a7ccfe12808c30668a204eccc4ca7f089f
Gitweb:        https://git.kernel.org/tip/954617a7ccfe12808c30668a204eccc4ca7f089f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:34 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:44 +02:00

powerpc/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-7-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c  | 6 ++----
 arch/powerpc/perf/core-fsl-emb.c | 3 +--
 2 files changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 42ff4d1..8b00814 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2344,12 +2344,10 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			ppmu->get_mem_weight(&data.weight.full, event->attr.sample_type);
 			data.sample_flags |= PERF_SAMPLE_WEIGHT_TYPE;
 		}
-		if (perf_event_overflow(event, &data, regs))
-			power_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	} else if (period) {
 		/* Account for interrupt in case of invalid SIAR */
-		if (perf_event_account_interrupt(event))
-			power_pmu_stop(event, 0);
+		perf_event_account_interrupt(event);
 	}
 }
 
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index d2ffcc7..7120ab2 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -635,8 +635,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (perf_event_overflow(event, &data, regs))
-			fsl_emb_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 }
 

