Return-Path: <linux-tip-commits+bounces-7051-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3124C196C2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 10:42:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C97A2421F1D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 29 Oct 2025 09:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3F6334369;
	Wed, 29 Oct 2025 09:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q/AKg9Ok";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z5iPw9QG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85D70333453;
	Wed, 29 Oct 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761730591; cv=none; b=V4Isj11XM1HLkt3uaGShCxLItxhFgxK6IFx27UpKjfGS8yWVluy2Y2cS1HlLNehHk0kH1vfMJrh3a3cPdousZpcds5+Ovsfah3TYwrSfpYtvfKkUM98nJWx1wUZN+mJKHTtyON4FXKiPwK/dBIH9RQ12YqP8HQULuMuGhN9GwTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761730591; c=relaxed/simple;
	bh=OOWszSODO1C2tIM2IDF6TnZ/E2EmrmPaXf+etZ3EUlY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YVJCQYkQSbQ67AtAzQDMdm5iNhesSvUbRvGXjf5r6IMQ7dRQcE6TxOd24IugWtLfDPz3bO8zerlcYb2M041mR6VTZrkdT3KxEHYfB8YXtv8vsiCRmBEuDQxcOrIDJ+e0vZyiI1eEFBQdGz2fXrGfO5sQPuitxRyhRgcbx9DAWoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q/AKg9Ok; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z5iPw9QG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 29 Oct 2025 09:36:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761730587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9hSg8l35fXWEvvLB5Gobrt82Zp0KDU9XKEFkxWcNAc=;
	b=Q/AKg9Okfhy+A4HPCOnv9ulnQ8A31ecc+vqTJ8vNHuoW/yf1qC9C2+ogVwWSXdbsZ06uwp
	gaN6mGwJpUV20/PJycMJeRZSklsEJ1m9tRNfJ+BwcnjdjJoOb77DUM7soL/fqqGnbtzJ43
	fapTytU2IfHjBhJyEX52bVOyJ5CTupXGWlHsSczuqUviXFT9zUmEc4rMUxAR19TImhSdUz
	LQWhfDQ4h/SdWAwqLW1/DbfigfToidzlLvQurGAaSsmaCkgFY5RucrtaaUaMrKBkyYsVl7
	IF3e9SSUy/ZnSQ0ORsyJ70NxD4fb+HrGoIO4515ACSAikE5Of6UleWyTVgWGzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761730587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=x9hSg8l35fXWEvvLB5Gobrt82Zp0KDU9XKEFkxWcNAc=;
	b=z5iPw9QGcaOLhoaAeQ/48HEgHYVXNIvxXlTVaS9TyhQ2C6Il4aG97MlXbM9EdNPcmC2fgR
	aJaEge05ySnj1cDg==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Clearwater Forest support
Cc: Zhenyu Wang <zhenyuw.linux@gmail.com>, Zide Chen <zide.chen@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Dapeng Mi <dapeng1.mi@linux.intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251023223754.1743928-2-zide.chen@intel.com>
References: <20251023223754.1743928-2-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176173058644.2601451.4553554490915980838.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e39b82f6cb0526c551d4651ba6d286b6b1f9e9c3
Gitweb:        https://git.kernel.org/tip/e39b82f6cb0526c551d4651ba6d286b6b1f=
9e9c3
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Thu, 23 Oct 2025 15:37:51 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Oct 2025 10:29:53 +01:00

perf/x86/intel/cstate: Add Clearwater Forest support

Clearwater Forest is based on the Darkmont Atom microarchitecture.
>From the perspective of C-state residency profiling, it supports the
same residency counters as Sierra Forest: CC1/CC6, PC2/PC6, and MC6.

Please note that the C1E residency counter can only be read via PMT,
not MSR. Therefore, tools relying on the perf_event framework cannot
access the C1E residency.

Signed-off-by: Zhenyu Wang <zhenyuw.linux@gmail.com>
Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251023223754.1743928-2-zide.chen@intel.com
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index ec753e3..a5f2e0b 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -628,6 +628,7 @@ static const struct x86_cpu_id intel_cstates_match[] __in=
itconst =3D {
 	X86_MATCH_VFM(INTEL_ATOM_GRACEMONT,	&adl_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT_X,	&srf_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_CRESTMONT,	&grr_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_DARKMONT_X,	&srf_cstates),
=20
 	X86_MATCH_VFM(INTEL_ICELAKE_L,		&icl_cstates),
 	X86_MATCH_VFM(INTEL_ICELAKE,		&icl_cstates),

