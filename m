Return-Path: <linux-tip-commits+bounces-7729-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A0BACC35D9
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 14:55:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD7A930D2DBB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Dec 2025 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 350CF1DA60F;
	Tue, 16 Dec 2025 13:48:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fisxbgUN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QCr2Fuph"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699E325F7B9;
	Tue, 16 Dec 2025 13:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765892927; cv=none; b=NibJMn3mCrNbUmZSHH+0RHy34vPRFqfSsQHkcPmjlQ9xFrE+3Z7Q6V9VDbpdp+8Ya+CT0G/24qteFBkurjYc2yH6rn2upOPuhKdvB1FXSA57F8SuZh3l6xX2mnyUBM2mKiFouhaFBZzCHNqPoQkqCbbxLamvgLhyzr7Dt21QH5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765892927; c=relaxed/simple;
	bh=nh7X1bPi4fGeDd+FE5OIIq9pF3GB3scpqTLRGQ/ernI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aNl/i3tXpCKeGAoVxeV1pojGSjxI9CLOfmCaDp/hHnf1WTGP8YPdg77FPyEZF4Z2GAbiVKjgyF+jPhT0wwhKt62BRlSZUTi5T4lu5KgqcYG76NNzOzG1q8GLMuFtjpRG5nYlyQuqLbGMnRlQ5DyxlrpMaudJNq2OMooqVj70ZSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fisxbgUN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QCr2Fuph; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 16 Dec 2025 13:48:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765892919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UewFPbDf2rBRe3/INQNj0cqQJ9cVvJQoVi6Pw9J6zM=;
	b=fisxbgUNRc8cz+ypDWbjs2iCSM3zL3SHF3aTNZknYnSmRosQd7w2R7DiR7uJkYtHm/5P6q
	8Wa03PDJ2lPsFr3I5iJUWDcGjpcQStQC/t3/e7BN1i2vc8Zq+gX00/rxx9boQpEO4HDvBz
	XAMZ3vNdMT/4e003520hui3nTYeiur7KC403Is4KGfaNWQx5d19vXfwO3dKTY6mxJo6Ft+
	ixTl7BQfub1wq4eIOk2841dAoM7YH2w/NJyntuZiZulvtEwlFFporrIiiwYfFk3zn7evip
	TqImo6m8u3btErl8EhdITmm9XrgBI4DJa+27GDJnf8Hu2XTxKflOLYDZUplN1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765892919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8UewFPbDf2rBRe3/INQNj0cqQJ9cVvJQoVi6Pw9J6zM=;
	b=QCr2Fuph6OS/TKR/nGAX98HyAMQQ8vdgTjyDrRClhv2MqmgNDFTwDwZ6ItXkVM1oSefw4f
	6Wv2+RhWoaD4dfAA==
From: "tip-bot2 for Zide Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/cstate: Add Diamond Rapids support
Cc: Zide Chen <zide.chen@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251215182520.115822-3-zide.chen@intel.com>
References: <20251215182520.115822-3-zide.chen@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176589291813.510.6479806528717518018.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     7ac422cf7b16ec524bcd8e017459e328a4103f63
Gitweb:        https://git.kernel.org/tip/7ac422cf7b16ec524bcd8e017459e328a41=
03f63
Author:        Zide Chen <zide.chen@intel.com>
AuthorDate:    Mon, 15 Dec 2025 10:25:20 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 16 Dec 2025 14:35:59 +01:00

perf/x86/intel/cstate: Add Diamond Rapids support

>From a C-state residency profiling perspective, Diamond Rapids is
similar to SRF and GNR, supporting core C1/C6, module C6, and
package C2/C6 residency counters.  Similar to CWF, the C1E residency
can be accessed via PMT only.

Signed-off-by: Zide Chen <zide.chen@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251215182520.115822-3-zide.chen@intel.com
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 008f8ea..1e2658b 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -652,6 +652,7 @@ static const struct x86_cpu_id intel_cstates_match[] __in=
itconst =3D {
 	X86_MATCH_VFM(INTEL_EMERALDRAPIDS_X,	&icx_cstates),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_X,	&icx_cstates),
 	X86_MATCH_VFM(INTEL_GRANITERAPIDS_D,	&icx_cstates),
+	X86_MATCH_VFM(INTEL_DIAMONDRAPIDS_X,	&srf_cstates),
=20
 	X86_MATCH_VFM(INTEL_TIGERLAKE_L,	&icl_cstates),
 	X86_MATCH_VFM(INTEL_TIGERLAKE,		&icl_cstates),

