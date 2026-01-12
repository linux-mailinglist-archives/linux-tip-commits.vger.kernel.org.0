Return-Path: <linux-tip-commits+bounces-7889-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 64155D11195
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 09:11:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1FE47306E475
	for <lists+linux-tip-commits@lfdr.de>; Mon, 12 Jan 2026 08:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F3533446B7;
	Mon, 12 Jan 2026 08:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VOvcOlSJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M0r3vO53"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A5B346A1E;
	Mon, 12 Jan 2026 08:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768205016; cv=none; b=E45tOxdN5MRPAxPYvte0fMZRpimtwaxqVo5407RnPH3Qlg9ghg4LoKbDW9NLj8637m+BlXQkZb5l1qRhBsWBF+uSJ6T7Y18VJVHDyAKjEUPXZc3C+7M82Avsx1x5iyduHzx8mgqiHBI9JK48s57HpxvwcDVjOC/FyFTrWUNurxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768205016; c=relaxed/simple;
	bh=wqJm71Ums0ixLgyBqMGpMWoSir3PT93KsBpZN4/1I+I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K/lMHtlOUr1hemZsbQOoVHu+X2HgtkZVr1ZV7tsL3/J8g//t01YnYQsGwST84xza8/cgja+7t7GtaKjtlxNSLaDjWNgWZFOcTkLJ8iJQX71ilgYDUDhkZ/Qp47wKPtMlUJbdAz+BzYP+ENHs238Ff60vJ4HkEHK5uOgXesAWONs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VOvcOlSJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M0r3vO53; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 12 Jan 2026 08:03:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768205008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6EVOYB1pTf6wqC976QndkkQoM3vp0TjsEbVlf14RH0=;
	b=VOvcOlSJ1hnrNsLlOBYfW97qpIRXEUjV8oBGZf5GANQHCcEXmW1u2Obm/91Vsyo3oPPp2p
	s9gnm1xSMoZfBi0T7F53+5cVFzWtltTae2Ng3oB/7b2SqbmeHs4+m4lmEJWNTrwtRZqz9b
	HAGWb9EoZcgpJeMMLawDRyKB/Si0cW16cpg7jI0OHhND8gXtAdN6VcE7lHGTKrGdB463De
	whTr9YFd5ZZ5/Rsok8euFyvC20wgockgTTYLkkVuNOOG+M19SWsz5/u6l/3WVVbGttKgTN
	oQydwpjqHe8BLgZn6YY43N8figgUAFmcEk230LlP08CoDGpdchMxO0BMqtMj/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768205008;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X6EVOYB1pTf6wqC976QndkkQoM3vp0TjsEbVlf14RH0=;
	b=M0r3vO535QC82gxLKspeGy2BY1VrJBVin6n2w5nh2aQciycj3bs8Z2xC5Ge63ZA2iwsGzD
	dTe1BSrQWPTDTGAQ==
From: "tip-bot2 for Yury Norov (NVIDIA)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Simplify task_numa_find_cpu()
Cc: "Yury Norov (NVIDIA)" <yury.norov@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Phil Auld <pauld@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251207033037.399608-1-yury.norov@gmail.com>
References: <20251207033037.399608-1-yury.norov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176820500726.510.7772385026461136688.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0ab25ea2a3b3a973fb914d0e47dc9c3c26049e8b
Gitweb:        https://git.kernel.org/tip/0ab25ea2a3b3a973fb914d0e47dc9c3c260=
49e8b
Author:        Yury Norov (NVIDIA) <yury.norov@gmail.com>
AuthorDate:    Sat, 06 Dec 2025 22:30:36 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 08 Jan 2026 12:43:56 +01:00

sched/fair: Simplify task_numa_find_cpu()

Use for_each_cpu_and() and drop some housekeeping code.

Signed-off-by: Yury Norov (NVIDIA) <yury.norov@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://patch.msgid.link/20251207033037.399608-1-yury.norov@gmail.com
---
 kernel/sched/fair.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 64275d7..842a0f2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2494,11 +2494,8 @@ static void task_numa_find_cpu(struct task_numa_env *e=
nv,
 		maymove =3D !load_too_imbalanced(src_load, dst_load, env);
 	}
=20
-	for_each_cpu(cpu, cpumask_of_node(env->dst_nid)) {
-		/* Skip this CPU if the source task cannot migrate */
-		if (!cpumask_test_cpu(cpu, env->p->cpus_ptr))
-			continue;
-
+	/* Skip CPUs if the source task cannot migrate */
+	for_each_cpu_and(cpu, cpumask_of_node(env->dst_nid), env->p->cpus_ptr) {
 		env->dst_cpu =3D cpu;
 		if (task_numa_compare(env, taskimp, groupimp, maymove))
 			break;

