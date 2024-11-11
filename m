Return-Path: <linux-tip-commits+bounces-2834-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 642079C3C88
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:58:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 962C81C218EA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 10:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B298F17C9BB;
	Mon, 11 Nov 2024 10:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P578phq0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OkZOjjDZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13A29175D34;
	Mon, 11 Nov 2024 10:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322723; cv=none; b=AJc6VNdUKaD8YUrrcZ4qcgq2dCiBFPLJ7amTrLEeQDZt7r/NM2ATAak/vRnlS7sqULvcSweZw67gpZdslm6ZbQ1aYUDfw3B8w91MhaGs3uRz3cb8azSVKC9p6865eKGbKgwnQ8X9MxMMZ2OqSPZAEmYdrwl3Bsu1+c7SzEiEilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322723; c=relaxed/simple;
	bh=eIlityUo7LmdVnGvh8CmVsxXaI12lNPUR9jy9r0hpa8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A5ctiMJ3esZ1np98IziVRWVn5BJdgf+ML0SuhFo0KAMoyAz7v9GfWIZqdVVwUAS9/K689Uo9J/ewHDyqiVBH37OxtdNcIrQnVub0M3OOH9Fx+vMO11HIWCk5IEiPEIMq2z2UC/U60MCPprPMdSp0crEBSuralQ0A1nnxVX9g5BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P578phq0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OkZOjjDZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 10:58:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731322720;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjEx7cV1d4egwCU31Fq27APnbaxOI7gHE4RJgNN8S6U=;
	b=P578phq0uzmCmCbP3yAG1ZosGkCRjgKp9QM8i6KNlXS8/I86OejCusZIw5JzXXxm//sdwy
	rJ0oxhWiiR9TV64vDXAb8nPDLysVdmpmmoQvF2CMrCGKSZ4nGIYgESPn0qqIJyqU03BFCd
	1si/5C3EoGFefJdB3WdRft2HRUfjIQa6ANTyzVa+41rBf3+6kSYUxR3Iku7tgbTO3ZQTao
	JfNbeqFWGXdA9mnFvhKa3QCKIftTtjqRP1kvpAgcmC8fdKUUL6qCctntqZ4hiSvN9fg1ub
	wGnePbwRweGGo4dpEPZmNh4ROrdGV8evv1yo/Dtk2NoHmcPtRQzeTDcfza3A4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731322720;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AjEx7cV1d4egwCU31Fq27APnbaxOI7gHE4RJgNN8S6U=;
	b=OkZOjjDZscpsV6Au/m4yu5bw342zoICg8/xcXEldK3iB7qUGHUpkOzIDL/CZsObL/Vp6kU
	nVpXyqFiHsHLLuDw==
From: "tip-bot2 for Jean Delvare" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Avoid a false positive warning
 about snprintf truncation in amd_uncore_umc_ctx_init
Cc: Jean Delvare <jdelvare@suse.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sandipan Das <sandipan.das@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241105095253.18f34b4d@endymion.delvare>
References: <20241105095253.18f34b4d@endymion.delvare>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132271966.32228.9904075526551618579.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2e71e8bc6f02275a67bcb882779ab6d21abc68c4
Gitweb:        https://git.kernel.org/tip/2e71e8bc6f02275a67bcb882779ab6d21ab=
c68c4
Author:        Jean Delvare <jdelvare@suse.de>
AuthorDate:    Tue, 05 Nov 2024 09:52:53 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 11 Nov 2024 11:49:47 +01:00

perf/x86/amd/uncore: Avoid a false positive warning about snprintf truncation=
 in amd_uncore_umc_ctx_init

Fix the following warning:
  CC [M]  arch/x86/events/amd/uncore.o
arch/x86/events/amd/uncore.c: In function =E2=80=98amd_uncore_umc_ctx_init=E2=
=80=99:
arch/x86/events/amd/uncore.c:951:52: warning: =E2=80=98%d=E2=80=99 directive =
output may be truncated writing between 1 and 10 bytes into a region of size =
8 [-Wformat-truncation=3D]
    snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
                                                    ^~
arch/x86/events/amd/uncore.c:951:43: note: directive argument in the range [0=
, 2147483647]
    snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
                                           ^~~~~~~~~~~~
arch/x86/events/amd/uncore.c:951:4: note: =E2=80=98snprintf=E2=80=99 output b=
etween 10 and 19 bytes into a destination of size 16
    snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

As far as I can see, there can't be more than UNCORE_GROUP_MAX (256)
groups and each group can't have more than 255 PMU, so the number
printed by this %d can't exceed 65279, that's only 5 digits and would
fit into the buffer. So it's a false positive warning. But we can
make the compiler happy by declaring index as a 16-bit number.

Signed-off-by: Jean Delvare <jdelvare@suse.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sandipan Das <sandipan.das@amd.com>
Link: https://lore.kernel.org/r/20241105095253.18f34b4d@endymion.delvare
---
 arch/x86/events/amd/uncore.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 0bfde2e..49c26ce 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -916,7 +916,8 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, un=
signed int cpu)
 	u8 group_num_pmcs[UNCORE_GROUP_MAX] =3D { 0 };
 	union amd_uncore_info info;
 	struct amd_uncore_pmu *pmu;
-	int index =3D 0, gid, i;
+	int gid, i;
+	u16 index =3D 0;
=20
 	if (pmu_version < 2)
 		return 0;
@@ -948,7 +949,7 @@ int amd_uncore_umc_ctx_init(struct amd_uncore *uncore, un=
signed int cpu)
 	for_each_set_bit(gid, gmask, UNCORE_GROUP_MAX) {
 		for (i =3D 0; i < group_num_pmus[gid]; i++) {
 			pmu =3D &uncore->pmus[index];
-			snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%d", index);
+			snprintf(pmu->name, sizeof(pmu->name), "amd_umc_%hu", index);
 			pmu->num_counters =3D group_num_pmcs[gid] / group_num_pmus[gid];
 			pmu->msr_base =3D MSR_F19H_UMC_PERF_CTL + i * pmu->num_counters * 2;
 			pmu->rdpmc_base =3D -1;

