Return-Path: <linux-tip-commits+bounces-5696-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D024AABF40C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F40BE1882455
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3883F26AA89;
	Wed, 21 May 2025 12:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YbgIDBub";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jktIXjTc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9618E268FEF;
	Wed, 21 May 2025 12:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829763; cv=none; b=UN2Eiu8bDr8Dx6Zbh4+9QEGKMi2zx9l2/NCCRKf8+C25nAmsKOFZYSD2EZLH0Jhh8u3JOOnS6sAykzjhLCbEAoSWfyG7tFUW7McjHfMYu8kfOmnu9Xwv0Som+Dd+rlyPZLmFK/4cCKYC5CXtxqZFcQJurhjraJBNDbFNhvBobls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829763; c=relaxed/simple;
	bh=Tr525ZBsrwoD6qhCfjT1VS4mW+atraz903ygmNRhAAQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ImqAe4m9HI6QTN1ktxft0Hli/xo8PFKqfTNisjUI3LyOy65IHF9Q0jZ28ZeODCJi/h8IDf5lodR3jRm+jVHE/Ox3dsg3cZbEjGQmShlnYV65kzNkw4lGUl6YqPqNWSxcEk1jh9OKFq2F0bKrkRK480m7rwRhmjcG8cREJ6q/fzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YbgIDBub; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jktIXjTc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:15:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYPCbnbNU7r3oyVbF/7CpygUlbowWuIZJOFBVA0V2Tc=;
	b=YbgIDBub0H3bqk6Boz4g7/oC3zVUiO6MrStjfw/s4CrLn2hcEBesTARjmsmumu9qJu/lA7
	xR0THouRC1ibMV9yaVlfZD33i8CaG+cSMWd97kui5Va4lLhF6/irCRM8GxnEyQ+C9fViHY
	/M3An3om0r3SQTWftbtKauCPe3AEp6AR9+NXWWs4IkB64AGDy+w3vVJZ0kf2hwJPTanL1P
	9SJ7vB8SPDeR8rrSayo6Ufq5MzWNRZCDhsLhDV1aUyJcQB99afUT0Kw7LvU3GccWEOnCp9
	sDxjPiQ7QIAa899Wv1VUAZFjbErTilM34fQjDCSH9BzsS6f3xChNji0nSE3uDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829760;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fYPCbnbNU7r3oyVbF/7CpygUlbowWuIZJOFBVA0V2Tc=;
	b=jktIXjTcmpbaahje7yC3n5hiCSxjPtyWnLZWpmpFbg6oWb0MXS8g/PNjabw7uRs6TIIajm
	7uYV1JB4jdJcmBAg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] s390/perf: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Richter <tmricht@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-8-kan.liang@linux.intel.com>
References: <20250520181644.2673067-8-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782975929.406.15710486577051819524.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     6792f74e8d6cbb062396ce4baabad21836b39ad2
Gitweb:        https://git.kernel.org/tip/6792f74e8d6cbb062396ce4baabad21836b39ad2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:35 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:44 +02:00

s390/perf: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Richter <tmricht@linux.ibm.com>
Link: https://lore.kernel.org/r/20250520181644.2673067-8-kan.liang@linux.intel.com
---
 arch/s390/kernel/perf_cpum_cf.c | 2 --
 arch/s390/kernel/perf_cpum_sf.c | 5 +----
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index e657fad..6a262e1 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -980,8 +980,6 @@ static int cfdiag_push_sample(struct perf_event *event,
 	}
 
 	overflow = perf_event_overflow(event, &data, &regs);
-	if (overflow)
-		event->pmu->stop(event, 0);
 
 	perf_event_update_userpage(event);
 	return overflow;
diff --git a/arch/s390/kernel/perf_cpum_sf.c b/arch/s390/kernel/perf_cpum_sf.c
index ad22799..9146940 100644
--- a/arch/s390/kernel/perf_cpum_sf.c
+++ b/arch/s390/kernel/perf_cpum_sf.c
@@ -1072,10 +1072,7 @@ static int perf_push_sample(struct perf_event *event,
 	overflow = 0;
 	if (perf_event_exclude(event, &regs, sde_regs))
 		goto out;
-	if (perf_event_overflow(event, &data, &regs)) {
-		overflow = 1;
-		event->pmu->stop(event, 0);
-	}
+	overflow = perf_event_overflow(event, &data, &regs);
 	perf_event_update_userpage(event);
 out:
 	return overflow;

