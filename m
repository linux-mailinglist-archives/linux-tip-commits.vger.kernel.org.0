Return-Path: <linux-tip-commits+bounces-7890-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56E6BD11174
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:11:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id CE9D530606E7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6525933EB1A;
	Mon, 12 Jan 2026 08:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0QrQ7fYO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ujn6bZ4K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F03133F361;
	Mon, 12 Jan 2026 08:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205022; cv=none; b=qdRKEm6UUIDwVJ+0IezEdxej6fQmS30hTOztxM6tmzs37jHloHoCKGqC9uIu3bypdWbrAEp6eoSWG8YvYLQ5zyJjegVky5dbzrU2oJk1y/0yw0h65eVqK0fWqQhZQ2KPuioeMUNYjuq/Ta2Vz/KEEZXv2Aso1g0S+/oVD3F61+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205022; c=relaxed/simple;
	bh=X0KJP6decgOyuZBVXLxtRFU36W9SdocAkBmZCWvxIAc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d6f4FYFQp7iO/RbSYI4IInAyy8hWLpKrtQrllamfytFSOzTbJBNRfBvzewxUXchnNs5FFJ5dctbOVszZp+cv5JrPexJjmku3qk05rOyG36nmfsX1DdjyCEw9QJ9FpVmmDVygWDbmuRrZOcpqWKEWt6whdUgGX2dphvBo8l18tnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0QrQ7fYO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ujn6bZ4K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768205009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiQshfIdfRZE0nTBXP6d5vs6hLjD0a+r2aKybJhSxJw=;
	b=0QrQ7fYOqFjzF7bNjOkcWSU4GBb2npKT8uwgNnErySIE/Hrv4MgW4qLYH7F+tlYxkUJrV4
	pjU9hTxcGqZUzr0kyiuQc1HNNLn6COJZNJXB+2nT8npDRu6/lx0Y6L+9RWH7aH0ARSicyj
	tlJ6dx4Kr3aW44V+QLR8RrujPG+g0MvZGEmp/6COfprqYj4slZDabotMExHwHRflJp5Mzp
	oXuejLw1KxanBlB5spTyKt/DHmZBdbRHH1J/5ils6aL/Wg8ov7Qpu/AJdiJES6gSyTLTn8
	fuSp7VgKwMRfHUr7bGvDKHx85g3Efs/6EOXIDitHwxVegWx1j7MzMyv2lKY2cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768205009;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tiQshfIdfRZE0nTBXP6d5vs6hLjD0a+r2aKybJhSxJw=;
	b=Ujn6bZ4KzcN8Cb0FzJA6tPpdZdTldyCGb4ylBLEw/7A6Ae1X358l/EyPxfh/e8pRtuaCQ8
	AMvzxB6XsC/RAQCQ==
From: "tip-bot2 for Yury Norov (NVIDIA)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Drop useless cpumask_empty() in
 find_energy_efficient_cpu()
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251207040543.407695-1-yury.norov@gmail.com>
References: <20251207040543.407695-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820500847.510.12871490155322269241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ff1de90dd7a69ef43586683535ad87ab899a1214
Gitweb:        https://git.kernel.org/tip/ff1de90dd7a69ef43586683535ad87ab899=
a1214
Author:        Yury Norov (NVIDIA) <yury.norov@gmail.com>
AuthorDate:    Sat, 06 Dec 2025 23:05:42 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jan 2026 12:43:56 +01:00

sched/fair: Drop useless cpumask_empty() in find_energy_efficient_cpu()

cpumask_empty() call is O(N) and useless because the previous
cpumask_and() returns false for empty 'cpus'. Drop it.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://patch.msgid.link/20251207040543.407695-1-yury.norov@gmail.com
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7377f91..64275d7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8359,9 +8359,7 @@ static int find_energy_efficient_cpu(struct task_struct=
 *p, int prev_cpu)
 		int max_spare_cap_cpu =3D -1;
 		int fits, max_fits =3D -1;
=20
-		cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask);
-
-		if (cpumask_empty(cpus))
+		if (!cpumask_and(cpus, perf_domain_span(pd), cpu_online_mask))
 			continue;
=20
 		/* Account external pressure for the energy estimation */

