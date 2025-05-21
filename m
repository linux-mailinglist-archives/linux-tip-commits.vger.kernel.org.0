Return-Path: <linux-tip-commits+bounces-5697-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AFCDABF410
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:17:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7B9301BC0CFA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E052826B95D;
	Wed, 21 May 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YAJVLk+P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6AhFyVcu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 396B826AA8A;
	Wed, 21 May 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829764; cv=none; b=VA6RYRn6/s3OiDjXB+v+aYVXzjSOXs1B+7/8imTluJQxCJc9WkE9Us3RlfUhUtLLuR98O5Hvxn06EiagZPYQX10STg/98p6Z/WbvmNaNQJcKNDnyI8OCf5+6FlMgTc/mx8n+S0WXekfLuOdV8JIPYKG3Hn+6s9UnHbWyUtpoysA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829764; c=relaxed/simple;
	bh=jbA3r9vLtt6UfK9Ja7Quz2OPmLJUUNKWCFR9et72lCM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pQ6UhDXSKvHuJBwigSO1ubj8lj//aJZQqfL0tDzFeChLy6RnP1Q43uJYndV0ygF8t8ERx4Cgr3BXGb0eaCAEjzYNMxgzGDxW3SQetJO2z4qNQ3b4Ps6574uM5y4igvMtdP2+N/WCxdMqtXnBunlcQ4yIdo3xPYd1KZ7W+Ndt2t4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YAJVLk+P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6AhFyVcu; arc=none smtp.client-ip=193.142.43.55
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
	bh=bHUptI3ZpTIQrp1EoEJPqPtovduwV9PrqLVVfPLc3Bo=;
	b=YAJVLk+P5UzSXviE4WzR8xVJIPo6nPIaxWNzVWMCFevT3+xJAtxQ9ndbG9BCtOnyDJv2EQ
	8/lv7g+TGcQjSWQqsoxFUHGdINBSNZFic4xf/CEDVWjL6fZZ/mb4rxwUL/uYwtU2325ZlZ
	PpqmkW3GXopYDWCXWAMIPBVruoAjLsDknkcXCMxHe7sxwshzOQuGx21bZgsxeoXWzDmyvv
	5DvZdiscybOuWShLZ7vclH46obPqkSbuqlACvHyQPJfsyykMhzH0os+6YZkICQHYyG/yPr
	auPABp4BZNXLieSlLZl9fT1rKHs/FYU85diWSjbcY7xawYGGsLfNkoNDwlkBxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bHUptI3ZpTIQrp1EoEJPqPtovduwV9PrqLVVfPLc3Bo=;
	b=6AhFyVcusf5wxu6wlWerX9TL/B1idbVJ/7oYVvFLi/tSbvRZ2ab1ULXrX31Uf+70aYi7ih
	APnFj5HdHpr4fACw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/zhaoxin: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-6-kan.liang@linux.intel.com>
References: <20250520181644.2673067-6-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782976087.406.3880414178178809150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6693da2181e435fcd8fdf776983c1b26ffee81c6
Gitweb:        https://git.kernel.org/tip/6693da2181e435fcd8fdf776983c1b26ffee81c6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:33 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:43 +02:00

perf/x86/zhaoxin: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-6-kan.liang@linux.intel.com
---
 arch/x86/events/zhaoxin/core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/events/zhaoxin/core.c b/arch/x86/events/zhaoxin/core.c
index 2fd9b0c..49a5944 100644
--- a/arch/x86/events/zhaoxin/core.c
+++ b/arch/x86/events/zhaoxin/core.c
@@ -397,8 +397,7 @@ again:
 		if (!x86_perf_event_set_period(event))
 			continue;
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*

