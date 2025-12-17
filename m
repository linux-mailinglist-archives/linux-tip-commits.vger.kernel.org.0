Return-Path: <linux-tip-commits+bounces-7741-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B162CC7AF7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E737F301B3AF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA9B3346782;
	Wed, 17 Dec 2025 12:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZlr6o3N";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sEkwdovl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4407F3451DB;
	Wed, 17 Dec 2025 12:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975090; cv=none; b=hhKABEA+AyEqezYWYLuJE54D5prq3pgmSd4PK+Gb+GgcAwvYagXRYKcM9EwZwhR4tISLq+jf4H47YfD6QfEQqSxPAdp0IXu677BeWn6FtAaAQHW0Ya8hm9G2BT3ycORtZo+BpEPjbHlnOZ4vkdHnRNyTUC1remuWNpA/eH6Jhk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975090; c=relaxed/simple;
	bh=Ig070YKl+qQKGqtA3txSk05mFBCu5hb/W1WirOEIlz4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s4QCSZR90UtHVQ227ovAxX6wuuoR10S+PBCAReuzygAu3SsAJ8bR6p1qxZqPWPTtfB7eCMv9AMKBuLmecXfqOkTwQn7ttmKJyVdws84PyqDSI3ImIzSsdUoF6/pDw5EGOnhhW0Leh/SXUwGwUW9VjsaE/AAsZVpnY3SMRmhVzdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZlr6o3N; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sEkwdovl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pCs0n3iip2sTkyCvoMHZYLnSpjLZGEPE8F8Ncp7JdQ=;
	b=dZlr6o3NHMSOtFkQYSeAJTt5+LOUL2pCg0XIShJGSr/0QzJAzF5KWHJQqawTTB6ap+aMGJ
	pd2AFfWsuYXJl+or9H6ojBn9rRHOoJGZRyeqsbElrfCxZdR95fdMuDljyLzVEmTkN5Me0N
	BmT3ojaDcU4IM/VJlgATgFydydCHWasENdUSB46grgGndIBBZdYNuGykvr1GvID75c/QcE
	UqVEX68E1b2iPIWkqJOnUVkTt2Ad6UxZxVd1Fn00irFUP5yDU51xvOuMqZH2yn6w47wF+I
	kgyhKvQc9yq6/c4sOdF8KM9EoTgU48J2l3QYBkE/UnP+yxQQcAuIUFCi35xIcA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975087;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1pCs0n3iip2sTkyCvoMHZYLnSpjLZGEPE8F8Ncp7JdQ=;
	b=sEkwdovlCUF+XvmJ7C6SLTzkA6C6fsnuopT2csvhPPek4EyON0oE9j3C8qnK6XBEIWTpfN
	GLLPfTruESeOaPAA==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for
 AMD host
Cc: Sandipan Das <sandipan.das@amd.com>, Mingwei Zhang <mizhang@google.com>,
 Sean Christopherson <seanjc@google.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Xudong Hao <xudong.hao@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251206001720.468579-14-seanjc@google.com>
References: <20251206001720.468579-14-seanjc@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508637.510.5295271479609953725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     65eb3a9a8a34fa9188e0ab5e657d84ce4fa242a7
Gitweb:        https://git.kernel.org/tip/65eb3a9a8a34fa9188e0ab5e657d84ce4fa=
242a7
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 05 Dec 2025 16:16:49 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:07 +01:00

perf/x86/amd: Support PERF_PMU_CAP_MEDIATED_VPMU for AMD host

Apply the PERF_PMU_CAP_MEDIATED_VPMU flag for version 2 and later
implementations of the core PMU. Aside from having Global Control and
Status registers, virtualizing the PMU using the mediated model requires
an interface to set or clear the overflow bits in the Global Status MSRs
while restoring or saving the PMU context of a vCPU.

PerfMonV2-capable hardware has additional MSRs for this purpose, namely
PerfCntrGlobalStatusSet and PerfCntrGlobalStatusClr, thereby making it
suitable for use with mediated vPMU.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Mingwei Zhang <mizhang@google.com>
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Xudong Hao <xudong.hao@intel.com>
Link: https://patch.msgid.link/20251206001720.468579-14-seanjc@google.com
---
 arch/x86/events/amd/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 44656d2..0c92ed5 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -1439,6 +1439,8 @@ static int __init amd_core_pmu_init(void)
=20
 		amd_pmu_global_cntr_mask =3D x86_pmu.cntr_mask64;
=20
+		x86_get_pmu(smp_processor_id())->capabilities |=3D PERF_PMU_CAP_MEDIATED_V=
PMU;
+
 		/* Update PMC handling functions */
 		x86_pmu.enable_all =3D amd_pmu_v2_enable_all;
 		x86_pmu.disable_all =3D amd_pmu_v2_disable_all;

