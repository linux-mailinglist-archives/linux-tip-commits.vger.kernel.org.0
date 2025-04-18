Return-Path: <linux-tip-commits+bounces-5065-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8735BA934D2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:45:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A038D176CBA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8CE26FA42;
	Fri, 18 Apr 2025 08:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WL1HTX7+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nn2i80dE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0A51F7904;
	Fri, 18 Apr 2025 08:45:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965923; cv=none; b=nhKUAUuW4jAU8e1Q8X8hbxNOlWQCaOfhsoQVMgSZLZMOZwP6nCDhVGWGxmFBOT79Te0hXy1aixhKuBWw1w0Hzy/nTZJuS6ad9jbcGN8qGrv7UoSAQVZYpsIQ4OKyKJvxXlhCigPiFEustsDFsWHV1DwYwfoqFeOVzJ8rcdSHeYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965923; c=relaxed/simple;
	bh=Hto7DRER/gXAWoZ396TJHcqbwq/IzQ4S8COAuz0wFj4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ByAzKhffhtsu04ilWd9dctZ5q5GmroAlqCJyGiYTWNkEpCnCdS9uLCBe2YmNEqQdRHhLk5o+lSmfOhiNfWd6rLgn6IQE10COWKzUKRINAD5JfLu6qXUxZ9Vj2Fqdw5jdJiyKbs4Ij6ZlpykQUJnCwbFb7+w+jn4Yk+PSSAmFGaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WL1HTX7+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nn2i80dE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:45:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744965920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkRYH8R7hlf0cdSn4Sa5CmL64qs+PfySiYxLmk99lck=;
	b=WL1HTX7+cTQ0fhi+/RqbrFMz+KN1pfuuP7AiicXBGwsgp8Vc7lt9p1S62EqGcNgQR1hMvI
	utS3JPMAR+2mOcwTgLkIrSTePpRoHsnH9byI9rlhAgZY8rpJnUa91GId1+m6dbx0IipYlZ
	dMqMJzrQAnMZBHWezDpY2xZ2Svn3WDWNBx0/mScVIaqbnLoEbMMOEGiW35H8Dme52nqiZh
	f0QmMX7J84xd7i1kbZK2SBlS5ZS27/odqJ/A8omuRktsd0hgpzNsWt7x2LlvOJiZ139z/8
	84fjQhkCKVBwP5lc5k6aceAY0H//h15Pkr60CYzGn4+KuomayITrPw1G7fQuDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744965920;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZkRYH8R7hlf0cdSn4Sa5CmL64qs+PfySiYxLmk99lck=;
	b=nn2i80dEm+NoOWxzKYRyIRZ1xHxLRcK5qHbOtPzfzbw3c7mntJl/SjekmKduxAmRpr3J0Q
	0yZwzTNSjXY1XMAg==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/amd/uncore: Add parameter to configure hrtimer
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6cb0101da74955fa9c8361f168ffdf481ae8a200=2E17449?=
 =?utf-8?q?06694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C6cb0101da74955fa9c8361f168ffdf481ae8a200=2E174490?=
 =?utf-8?q?6694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496591954.31282.937617439361491537.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e1ed37b70fb355abf2e8032a2e972cdba53ae93c
Gitweb:        https://git.kernel.org/tip/e1ed37b70fb355abf2e8032a2e972cdba53ae93c
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 18 Apr 2025 09:13:02 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 10:35:33 +02:00

perf/x86/amd/uncore: Add parameter to configure hrtimer

Introduce a module parameter for configuring the hrtimer duration in
milliseconds. The default duration is 60000 milliseconds and the intent
is to allow users to customize it to suit jitter tolerances. It should
be noted that a longer duration will reduce jitter but affect accuracy
if the programmed events cause the counters to overflow multiple times
in a single interval.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/6cb0101da74955fa9c8361f168ffdf481ae8a200.1744906694.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index e09bfbb..70e0af3 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -87,6 +87,10 @@ struct amd_uncore {
 
 static struct amd_uncore uncores[UNCORE_TYPE_MAX];
 
+/* Interval for hrtimer, defaults to 60000 milliseconds */
+static unsigned int update_interval = 60 * MSEC_PER_SEC;
+module_param(update_interval, uint, 0444);
+
 static struct amd_uncore_pmu *event_to_amd_uncore_pmu(struct perf_event *event)
 {
 	return container_of(event->pmu, struct amd_uncore_pmu, pmu);
@@ -545,7 +549,7 @@ static int amd_uncore_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 			}
 
 			amd_uncore_init_hrtimer(curr);
-			curr->hrtimer_duration = 60LL * NSEC_PER_SEC;
+			curr->hrtimer_duration = (u64)update_interval * NSEC_PER_MSEC;
 
 			cpumask_set_cpu(cpu, &pmu->active_mask);
 		}

