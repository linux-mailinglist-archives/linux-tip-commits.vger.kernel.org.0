Return-Path: <linux-tip-commits+bounces-4023-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 594C0A54742
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 11:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01E423A689C
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 Mar 2025 10:03:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CE1FF7CC;
	Thu,  6 Mar 2025 10:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ChXtcqJk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/UtBLtOv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1082BE46;
	Thu,  6 Mar 2025 10:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741255369; cv=none; b=i2vlDqqbyPL6HaW19+BYBDFotURgW1zsElWw66nMoW7fqSbJ9jr6scLR1ioUVQxwkcW7HLvSpqH8y0zmAnzB+Xu1fnlafsXQX0AxkJVo2QhF9zg1TrPsvjuOWXSx7hQVCuKQgTiqNuNxCCJysHuRLF92sC/s1rERyV48w5SHpbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741255369; c=relaxed/simple;
	bh=ug0xsShtJe0iYZlMLkngTE5ljePsAAAgDXLvUIRCsn0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cl37bffzmGP7x/NY0tlRV+1GV4aa6hzwWOBsmWyc92KgmcqBad8UYRGY0SQE2nUXbE0P3XJncfP+FyJ12VNWeTSLlStCi7jVDHa+P4mQ3Dtmg8My9QjNXcc4O9AWXZQA2rBkVY/dbsiDbQOh9eEbIVyIF6/NXYh/S2G4LgROUBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ChXtcqJk; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/UtBLtOv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 06 Mar 2025 10:02:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741255366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9i021sxEL7auhzXYNpyo8jKItjpBvpxX9ZGTX/ROho=;
	b=ChXtcqJkkrh/vp3JDuWmopygZQYfwB07TZnO2BXBjOGvwR4iaqjTpIihulmKX1UWHkcVje
	Cd5o4U0WHH+voJj+ngisqwr5uk/+6u1uU+i0RrcPD0H3RGdpGglkUjvvM5c/wPDtb7Y0bq
	h7Y1txsk+2xmHxATh5cVsSSqr4uksNz/zmHn93IgM2zh20M5s5uv9CpWt01Llo3lNxRqsN
	UBsJ5OvP5gck3uPcWbPplfZlZM7vI/qlnKAJ7SuYIwfZjH1JjsD5UalSmKGobcNP2pEYCE
	vRkGUfq9K+Qoxo/H/lYthxSa5zapOn8sQbhd6ADNxlM+DZecW0PmixAHfy/l/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741255366;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=W9i021sxEL7auhzXYNpyo8jKItjpBvpxX9ZGTX/ROho=;
	b=/UtBLtOviezs+u/8pTX9hnTJP4Mtx3REOIQ4eBJVxiguYy4j4Z4HKNHJlekGraGIPfFCcz
	2Ijo/JDyaZ0tnuDg==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/deadline: Use online cpus for validating runtime
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>, Ingo Molnar <mingo@kernel.org>,
 Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250306052954.452005-2-sshegde@linux.ibm.com>
References: <20250306052954.452005-2-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174125536534.14745.5263095159289087777.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     14672f059d83f591afb2ee1fff56858efe055e5a
Gitweb:        https://git.kernel.org/tip/14672f059d83f591afb2ee1fff56858efe055e5a
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Thu, 06 Mar 2025 10:59:53 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 06 Mar 2025 10:21:31 +01:00

sched/deadline: Use online cpus for validating runtime

The ftrace selftest reported a failure because writing -1 to
sched_rt_runtime_us returns -EBUSY. This happens when the possible
CPUs are different from active CPUs.

Active CPUs are part of one root domain, while remaining CPUs are part
of def_root_domain. Since active cpumask is being used, this results in
cpus=0 when a non active CPUs is used in the loop.

Fix it by looping over the online CPUs instead for validating the
bandwidth calculations.

Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lore.kernel.org/r/20250306052954.452005-2-sshegde@linux.ibm.com
---
 kernel/sched/deadline.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 38e4537..ff4df16 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -3189,7 +3189,7 @@ int sched_dl_global_validate(void)
 	 * value smaller than the currently allocated bandwidth in
 	 * any of the root_domains.
 	 */
-	for_each_possible_cpu(cpu) {
+	for_each_online_cpu(cpu) {
 		rcu_read_lock_sched();
 
 		if (dl_bw_visited(cpu, gen))

