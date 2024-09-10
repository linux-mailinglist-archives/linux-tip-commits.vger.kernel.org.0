Return-Path: <linux-tip-commits+bounces-2273-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9A1972BBC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:13:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8A87B25495
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8202C190049;
	Tue, 10 Sep 2024 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="msVynz/W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RuPdnDJg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FE8118C91B;
	Tue, 10 Sep 2024 08:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955771; cv=none; b=S822rscN0ZXtYzl4vrLGISVKrgAl+mzuKbv8blo5HxB2/f6x+W4SeKV83IYcM4tKOVihDkRuNiqyPMjV/EE/lHvjxe0sbGk45MbDzXvl+N8RhC36QfnyUeURPVdhmkVWv0IaSKqAYhpuCJk0BzNGcZBUFWS+BAXU02So8jqctKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955771; c=relaxed/simple;
	bh=Ek77Q4o+1owr4wRAAydn/pjZaTGbrXQA+Zk5Sdn0E5w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dw5y5Y5o0rUjOBZDPeDRwohEcq323x9tT0tgvP9drEu2O58TeUI3C8haSTx4muP/Ei90zmypupaf197zuP+SKVe995ezKIT+D1I6tGhcvFHA0HAk3fg+tEzVFwZ1anEt1/501hJy6TdkR5nrUTOBDPNfX5RYlMKqZguNL5Mqb+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=msVynz/W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RuPdnDJg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vazl9vX/SQPeGexYZW/lPUqTFyWl70oJjDWlqaZMJ+c=;
	b=msVynz/W6xl7TynWT3EDKzEH6M24JM8xWbrxxDH/m0LVB6wlJudAKdCDvJHAIlwI5HV1a+
	GugP4BBVxbpKiZ6VGNvUOB1QE1SbtIpS0tZm4fFEGyeIdBf8SjQLoHRLWXbd/3GozU1UML
	DCMX7PoLMlX0wfw+BA76jmgV9ZdS/RPf3xRmup4Hrst8g0JnnbyS8m/tUYSPIANmPDJs56
	ZxK6eeTX/rdy3qy/L71OGgZ9JrKqllzKgJeG66g/mg44w+GVrZ8uaWJ+CfDrErSDDTnsxj
	TC1eKWXBKuNN1E90XpwGGbZ6+h4/o6qAQnpJ919LvIIfAkQQDjL87RtARIgONg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955761;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vazl9vX/SQPeGexYZW/lPUqTFyWl70oJjDWlqaZMJ+c=;
	b=RuPdnDJggMD7dcC85hE/9sTxKvcz7942cAErdluUEw8PJtjBGlafI3sjw/upvVhJXSzgBA
	m3ht8k7UGmrZ3CCA==
From: "tip-bot2 for Christian Loehle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpufreq/cppc: Use NSEC_PER_MSEC for deadline task
Cc: Christian Loehle <christian.loehle@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240813144348.1180344-4-christian.loehle@arm.com>
References: <20240813144348.1180344-4-christian.loehle@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576134.2215.561579480768507809.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b3a47ff095544af206b8885391a7bad662d06a57
Gitweb:        https://git.kernel.org/tip/b3a47ff095544af206b8885391a7bad662d06a57
Author:        Christian Loehle <christian.loehle@arm.com>
AuthorDate:    Tue, 13 Aug 2024 15:43:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:16 +02:00

cpufreq/cppc: Use NSEC_PER_MSEC for deadline task

Convert the cppc deadline task attributes to use the available
definitions to make them more readable.
No functional change.

Signed-off-by: Christian Loehle <christian.loehle@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Rafael J. Wysocki <rafael@kernel.org>
Link: https://lore.kernel.org/r/20240813144348.1180344-4-christian.loehle@arm.com
---
 drivers/cpufreq/cppc_cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
index bafa32d..aff25b5 100644
--- a/drivers/cpufreq/cppc_cpufreq.c
+++ b/drivers/cpufreq/cppc_cpufreq.c
@@ -224,9 +224,9 @@ static void __init cppc_freq_invariance_init(void)
 		 * Fake (unused) bandwidth; workaround to "fix"
 		 * priority inheritance.
 		 */
-		.sched_runtime	= 1000000,
-		.sched_deadline = 10000000,
-		.sched_period	= 10000000,
+		.sched_runtime	= NSER_PER_MSEC,
+		.sched_deadline = 10 * NSEC_PER_MSEC
+		.sched_period	= 10 * NSEC_PER_MSEC,
 	};
 	int ret;
 

