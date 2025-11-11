Return-Path: <linux-tip-commits+bounces-7293-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 471BFC4D6D6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:38:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E6D2B34D910
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:38:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7187B3590D1;
	Tue, 11 Nov 2025 11:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9YsZlih";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s4s98Qx/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F01F358D3F;
	Tue, 11 Nov 2025 11:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861033; cv=none; b=mx+gB4TPNOFt5v12EM1srPTyJkIYAxMZBD6ZeG78rJXFojib09Vy6ke0itLHKgYGpkb/dVBHR35AAVQwSki1DEtWyDlZJdBwjq+UtubjO5mAXZYHh6yXaYCadMuuAAvqsV/HeQ+wbTT51srqpnl+eHudfY9aOSFFXGvsZlfA+4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861033; c=relaxed/simple;
	bh=l1HDyuSWhxYketRw7Wr/YqKyXMrTT0XLiQC7P7kEJSk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h6ycpNL3epU+xk1dJGEDCGsikPzZykXIfyAsvfBs2jX+zCg5S0Jb2ILs+ZNNHua1yx3Knu02PVoX/QgbxBF+SsntByG1u5ILK1qCitRGlMwaKcKRVrxpPWT7dxlJZlCZ3/GqSDdYcTRj8PLNAjoR7A+nMCIYwZyDN+/ucnT1zm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9YsZlih; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s4s98Qx/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzJ83Oac4/DrYraqSHenm2m26W9LnsYGTu+NlXgqUmY=;
	b=n9YsZlihLRju2WQeqgja0ZYA5W4zfh5qWgyyxrcKdddIz3BIPXjokFNLWxOCDHyguLEHsH
	q10tSoRSrC6hOD3bvc6+JP95JWgVwH+6S15xlGFkoN49fhmth/7ly0dyeo4UAtml3Ds+l0
	rjJp72GfTDI+zDReQnSYaOrm7zh6cVjBCYddEQSNv892rkyohyeCsHFPvUgmQv9ioH1q8u
	i5iTE7r3lNqfxwH6UEH6ByLofGwPsV6vcSLrp/0m0a9XkWs3RLJ/wND1FB0tJrkS0OlUqk
	AQbNskTKFC9iqn9AjILyRaVPpHHkK6t9oNzadgWGajmJo1ctqxWIvy73CqznRw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861029;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzJ83Oac4/DrYraqSHenm2m26W9LnsYGTu+NlXgqUmY=;
	b=s4s98Qx/FMmk4Rje2FamkPYH4Vb7Kl8NodyAunCo2eB5XCqWEs2T60mCOkao5zVCwmInn4
	//1uRinUoQBgm+Dw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Replace x86_pmu.drain_pebs calling
 with static call
Cc: Peter Zijlstra <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-4-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102881.498.11981980290107226547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ee98b8bfc7c4baca69a6852c4ecc399794f7e53b
Gitweb:        https://git.kernel.org/tip/ee98b8bfc7c4baca69a6852c4ecc399794f=
7e53b
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:27 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:20 +01:00

perf/x86/intel: Replace x86_pmu.drain_pebs calling with static call

Use x86_pmu_drain_pebs static call to replace calling x86_pmu.drain_pebs
function pointer.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-4-dapeng1.mi@linux.intel.=
com
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 28f5468..46a000e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3269,7 +3269,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 =
status)
 		 * The PEBS buffer has to be drained before handling the A-PMI
 		 */
 		if (is_pebs_counter_event_group(event))
-			x86_pmu.drain_pebs(regs, &data);
+			static_call(x86_pmu_drain_pebs)(regs, &data);
=20
 		last_period =3D event->hw.last_period;
=20

