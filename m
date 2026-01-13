Return-Path: <linux-tip-commits+bounces-7965-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 72096D1B486
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 21:47:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E8046300533F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 20:47:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE222D7B1;
	Tue, 13 Jan 2026 20:47:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oRoFkkq5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NHjEHPs2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B153F318BB3;
	Tue, 13 Jan 2026 20:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768337276; cv=none; b=FiYATl1RYMV4oUDxcy7Lw9NHYBtpnqSmlN3fueygBYSP0HQIRvoifpD9D+3V4NM3I5Re9j79YwKi1w5R5+wXuwpr8y0av0jFn6Ls8/+FFFkxolXgw+Bhgl+/TztmhQngKNMAyDVvGgxrWmvX+Z5eNLq8FUf6xcxTnOvQz9j8gfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768337276; c=relaxed/simple;
	bh=zLw5SJA8FziciLZxXXGJNs0P4CFw/wEA1mRxOb+xcNc=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=mA06gD/q490I4ChaEHmnfbVAq6e1VPKlv2YatM6AznV5ORnt2NALl7TXFdBi8j+nh3mo0/NOAEWpWJeXr/vtNLaL8eMoYPVwjwb1su7UGKDC0kXP71ZtuBvp2LTjGcd3CdVardM55sQ00sY/2S4T9XcaJEQyGghPY2q7o4oYCOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oRoFkkq5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NHjEHPs2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 20:47:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768337272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e1BUqUPcJkQ+a3M7PIRzktu99yy/48uARu3M4JmGL2o=;
	b=oRoFkkq51y1hbaZgIXPpeaBRd1HUxPNE5qygYirn6+AyfBlU7sLZZ7YSe4cIyAR//MlEOB
	V83pTqn1dg9iIIXFKh8QMMUlIrKhhJal/B6mQ0p8rA6kXNgq0cuD7sNYQThcK/+WykMbaa
	JWpmxy4vGcUOSK5EtEGQkM8q8AHD2Nu9CRSE3bxmkbE2/Ndjcr3kY3VHUOlHjtoJoSx46F
	8hPmWECIPgJ7vEYJ/Wug1DqoEEFFUV8d+WxsQEJJCUZ0TgP9oIeErDWIPRMV1eh5AaKB4D
	dB4a/UC22afSkTDeJGQD5i9Hd36/wyVTcDqK/OpqwRVMrRBwZqnE9fDDpXUN8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768337272;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=e1BUqUPcJkQ+a3M7PIRzktu99yy/48uARu3M4JmGL2o=;
	b=NHjEHPs2O4Jf5onJlczHobf3aQGmGDh6kI13TPv+h11q6CIAjkmtmirycMilsI7nxg/O5X
	1fzKhospPK1DD/BA==
From:
 tip-bot2 for Jan =?utf-8?q?H=2E_Sch=C3=B6nherr?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Speed up kexec shutdown by avoiding
 unnecessary cross CPU calls
Cc: jschoenh@amazon.de, David Woodhouse <dwmw@amazon.co.uk>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176833727102.510.12375639823542577165.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eebe6446ccb75ecb36cb145ab1cbc3db06cbc8d6
Gitweb:        https://git.kernel.org/tip/eebe6446ccb75ecb36cb145ab1cbc3db06c=
bc8d6
Author:        Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
AuthorDate:    Tue, 13 Jan 2026 21:34:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 13 Jan 2026 21:39:01 +01:00

perf/core: Speed up kexec shutdown by avoiding unnecessary cross CPU calls

There are typically a lot of PMUs registered, but in many cases only few
of them have an event registered (like the "cpu" PMU in the presence of
the watchdog). As the mutex is already held, it's safe to just check for
existing events before doing the cross CPU call.

This change saves tens of milliseconds from kexec time (perceived as
steal time during a hypervisor host update), with <2ms remaining for
this step in the shutdown. There might be additional potential for
parallelization or we could just disable performance monitoring during
the actual shutdown and be less graceful about it.

Signed-off-by: Jan H. Sch=C3=B6nherr <jschoenh@amazon.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/events/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 376fb07..101da5c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -15066,7 +15066,8 @@ static void perf_event_exit_cpu_context(int cpu)
 	ctx =3D &cpuctx->ctx;
=20
 	mutex_lock(&ctx->mutex);
-	smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
+	if (ctx->nr_events)
+		smp_call_function_single(cpu, __perf_event_exit_context, ctx, 1);
 	cpuctx->online =3D 0;
 	mutex_unlock(&ctx->mutex);
 	mutex_unlock(&pmus_lock);

