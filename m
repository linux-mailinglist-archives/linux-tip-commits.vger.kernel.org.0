Return-Path: <linux-tip-commits+bounces-5694-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5CABF402
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:16:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4448D17E6EC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB0268C49;
	Wed, 21 May 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YwTmdCtO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yJQRP1gu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA6FC267B01;
	Wed, 21 May 2025 12:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829761; cv=none; b=UiLQQJBBz9TPL0kLW0ZZprIFRMkrhtqDu3D49DFTLNpVIktQFxeS3eHK0NkCY+0VlxMx1t7qxXS8U32hMokkLg1qZ4le9cIHdu/GCvb3RtsYNYAbNHkgIXSmkZUEqAPqZn/UIPo4ZL0CQwiRXS9UvS7awziP+zTdWLjKEcXldEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829761; c=relaxed/simple;
	bh=6NjiJRUxfz7jG0b39JXNU59bbZUW6ryoFmdYwVIel7w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=L7sxidgEdsCGRpvO8/uX3a5AASml1McZAAZYBGPU/gVPC/7s9khTirfUpBrybtJnBXWlYCEKzfr3pZNBNmblzC0pPghRkNcblAiJg4SxFZuGiyCn2aVyarodruRsns+WSh0X7w07mcXluy0Q+gsDuBLJD10+kmQDFiLdqIUBNmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YwTmdCtO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yJQRP1gu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBFD/rRtS2wPZUEpO6W77cRrWGGtkZurSZ1yFwFDlRE=;
	b=YwTmdCtOZFnKqGXGigUkI+tVX3ShY/T9xit7bUxrVS4Ma/LCUVNGyRMYlcBYCa4w7rKZvk
	jMX71uGKH4D+osVSuPBjYyZowkc9XA0UP2Mg4tN7cbEARhhJyGijw5TLlxOjwu6IatQYgs
	QbBYWJHTIcrVwPsO/m3ewhRMjeyyHZ+57ONPfumLjUyKa8bybfLzjaM2rRdw47pa4qbSWR
	zb6BghXNkW7sFB7xU8f7buId6hpg5T0O0mxQ5ghD4lwrNMg42xzE8XQVtrtCdIKDpVSXge
	A3UJhOKGzqpYiD3aNzV6xRmWpSPH9y8Tl9m7wSLlnvpXP2SEq1VSeFOukeROlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829758;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QBFD/rRtS2wPZUEpO6W77cRrWGGtkZurSZ1yFwFDlRE=;
	b=yJQRP1gu4tr/V8y9+f3pyHQO4e/ww0bX5H4KsSOpnInbh9JCSzitvZe0hGelp4QRQWpx6G
	XRRrJp01BjHD0mDA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/apple_m1: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-10-kan.liang@linux.intel.com>
References: <20250520181644.2673067-10-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975749.406.1489987262212092748.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f1a6fe2ab1d937370e3f334cbf519c794eef4411
Gitweb:        https://git.kernel.org/tip/f1a6fe2ab1d937370e3f334cbf519c794eef4411
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:37 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:44 +02:00

perf/apple_m1: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-10-kan.liang@linux.intel.com
---
 drivers/perf/apple_m1_cpu_pmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/perf/apple_m1_cpu_pmu.c b/drivers/perf/apple_m1_cpu_pmu.c
index df9a28b..81b6f1a 100644
--- a/drivers/perf/apple_m1_cpu_pmu.c
+++ b/drivers/perf/apple_m1_cpu_pmu.c
@@ -474,8 +474,7 @@ static irqreturn_t m1_pmu_handle_irq(struct arm_pmu *cpu_pmu)
 		if (!armpmu_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			m1_pmu_disable_event(event);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	cpu_pmu->start(cpu_pmu);

