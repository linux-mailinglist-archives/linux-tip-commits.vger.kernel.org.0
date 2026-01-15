Return-Path: <linux-tip-commits+bounces-8015-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C8B5D28CC9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 80E48300DB32
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D61473242D8;
	Thu, 15 Jan 2026 21:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JSy/lx1M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OJPQReX1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EB772E090B;
	Thu, 15 Jan 2026 21:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513443; cv=none; b=O7ZWVGE0t2bW6vDA+l4DcUMI4gY/QxyLz4DuCEerFwMx/wnfW0bmhon0hN2QZtP18WMVKwwPQtc430V/Eb3J5n9Cf6iMq7oLN72YtDaiFIe2/CcKAp2o5fN5rLgrKcFc/BcHh7CDJaORkHm/G0+cB1299P63h1DwX+w+iitTetg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513443; c=relaxed/simple;
	bh=FrzmvX6V7qRiuxZ14PjSs8k4ScQ/vJYLRvEgZVopqjo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=solEJ2erxepbIU6964QkIliqdAfIJ/1JXlwnjRCKgyhH8GpNwSuEwMm2/Rjdn97JXDLDJf496jaq/lvSg7+oQ9gHtwVQyPsdC1JFjHRSLyzyhdtd+3MmUpKlhujQYVEjn3ZB5VXcVFMUw5dk3ShARsLSwe+S9t5H9l5u1U8OMzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JSy/lx1M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OJPQReX1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:43:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw6mTvNnHe6MOk59VlkTnRvpCs6a5g1X1Jtqc3pK6sE=;
	b=JSy/lx1MRrHFQ7l9BioKXVacRcyXfcs0/0/tdL3JbpvYCuO2ddZvf5LVpLOgLyuRy892/z
	z/NbUBsOrzZjGhT8VbB3UvJUVtR/IOyZ8ujJnVaiQhH98+PFBBlHR/P/6zaGLBeewfCsbu
	NUZYn0Df4wBBYXsED1D/AY4Vlqlnpmw9+cd7jVlpVoS9Ts8lqYzuOITDc7ZZlAsVlVuIPd
	qYaOF1ZY4bAnOxXqdoFdCQ/O80gu/tzdusa1kAb7YkzLhyRTY5jLEAUZN9I/HCRwhq0v17
	DuRv/NEbr4o6/Vb9l9BpB1AIUbMIf5XUSxWsXXajovLWdIMveJX0JUd+Zdthhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513441;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tw6mTvNnHe6MOk59VlkTnRvpCs6a5g1X1Jtqc3pK6sE=;
	b=OJPQReX102rGKqCtITErR/gsNXajxnXgZG7DH/AlGUPcFLtkQ0/D3yLEYX656nxZ3IiwuG
	PvcTfrwAm19KSKCg==
From: "tip-bot2 for Chen Ni" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Convert comma to semicolon
Cc: Chen Ni <nichen@iscas.ac.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260114023652.3926117-1-nichen@iscas.ac.cn>
References: <20260114023652.3926117-1-nichen@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851343995.510.17194569540303589238.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     10d6d2416db2137a5a0ef9162662e5b7fee56dd4
Gitweb:        https://git.kernel.org/tip/10d6d2416db2137a5a0ef9162662e5b7fee=
56dd4
Author:        Chen Ni <nichen@iscas.ac.cn>
AuthorDate:    Wed, 14 Jan 2026 10:36:52 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 10:04:28 +01:00

perf/x86/intel/uncore: Convert comma to semicolon

Replace comma between expressions with semicolons.

Using a ',' in place of a ';' can have unintended side effects.
Although that is not the case here, it is seems best to use ';'
unless ',' is intended.

Found by inspection.
No functional change intended.
Compile tested only.

Fixes: e7d5f2ea0923 ("perf/x86/intel/uncore: Add Nova Lake support")
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20260114023652.3926117-1-nichen@iscas.ac.cn
---
 arch/x86/events/intel/uncore_snb.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/events/intel/uncore_snb.c b/arch/x86/events/intel/uncor=
e_snb.c
index e8e4474..3dbc6ba 100644
--- a/arch/x86/events/intel/uncore_snb.c
+++ b/arch/x86/events/intel/uncore_snb.c
@@ -2005,11 +2005,11 @@ static struct intel_uncore_type *nvl_msr_uncores[] =
=3D {
 void nvl_uncore_cpu_init(void)
 {
 	mtl_uncore_cbox.num_boxes =3D 12;
-	mtl_uncore_cbox.perf_ctr =3D NVL_UNC_CBOX_PER_CTR0,
-	mtl_uncore_cbox.event_ctl =3D NVL_UNC_CBOX_PERFEVTSEL0,
+	mtl_uncore_cbox.perf_ctr =3D NVL_UNC_CBOX_PER_CTR0;
+	mtl_uncore_cbox.event_ctl =3D NVL_UNC_CBOX_PERFEVTSEL0;
=20
-	ptl_uncore_santa.perf_ctr =3D NVL_UNC_SANTA_CTR0,
-	ptl_uncore_santa.event_ctl =3D NVL_UNC_SANTA_CTRL0,
+	ptl_uncore_santa.perf_ctr =3D NVL_UNC_SANTA_CTR0;
+	ptl_uncore_santa.event_ctl =3D NVL_UNC_SANTA_CTRL0;
=20
 	mtl_uncore_cncu.box_ctl =3D NVL_UNC_CNCU_BOX_CTL;
 	mtl_uncore_cncu.fixed_ctr =3D NVL_UNC_CNCU_FIXED_CTR;

