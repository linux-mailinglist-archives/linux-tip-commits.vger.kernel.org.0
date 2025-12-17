Return-Path: <linux-tip-commits+bounces-7735-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 94D7CCC7B39
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:51:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 548963048E60
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 12:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5E7033F8A2;
	Wed, 17 Dec 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nO46JBdj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sYHrGSwP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D8633D6DE;
	Wed, 17 Dec 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975084; cv=none; b=lJOCY5e4jrTdJqtiUS2VogE8JO5BA974eILf2aYXN9ZFtVEmosg/BJqSUUDTVNQ53Xyn6HbjY8DrlHoEmq8dOESFmf/dAPD60SSHVzIZ3QpY0bGj9cYYosyGQ6XdlCKQoyISxzpcMgcYsTg/2nfvUwlZcU7a93YAMCBhBici8kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975084; c=relaxed/simple;
	bh=mUO+xoKNEEdbDpXXS+CWYWyjxubhXcT/RPaUL+NYwzs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O98BWWZEYHPlvKFwDMwHRpHEmMgkDZ53b7VyLOad/dYDPGBd9yvWdkMUZhG01IhNOxD+65HpJ2r06J1Yt4nJpifzOOIfYxVruUUz8CqnE1/K3CGsRNLZW01xsYd8L7604D5Iuyuic8ofY4980bSI+ag1oTx66CJ+r7Z3k47VC9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nO46JBdj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sYHrGSwP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6F6bfxxgeep/Vr7AkQnnM8P7ix+IogUH/MvmC2qSv4=;
	b=nO46JBdjem7Z93cuSJMV41GlX2Ckf/ENTSgcEg3X/mPbKwC1DUKGYPMVS/lpx+nkQCNP2e
	n17enAjwl6XAQoVUmb5qnIzviSViTGXGiSM8TEKBLuLJT3kUrsYT7CYuqvwbKGXBoBgkmD
	PjT+iEeW0G9xOaijADigQqiMo2TYHT5kggi9ICrmgHHSKSarMPP+/2pngLpZSN1iKNGerb
	v2epwi0LNBZuLUuZLJ1QCSDf4XzKbNxigd5A8a9KCv1riffQsfxSYDIvLeBHZItDFD/Y9y
	UlZLQyRfZK3sSVYRW8cjLA7IBNP/1Y45H+J0IcpK4IiWGqLoZpY1mUzMqzI8nA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975081;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j6F6bfxxgeep/Vr7AkQnnM8P7ix+IogUH/MvmC2qSv4=;
	b=sYHrGSwP5UPQw3O4Vq3F/vXoVdfi8YF0ucAT1CesJPZlLPVgKh2DE58q9Ze9jrkt0VzYXT
	azPbUwYiFRE9MLDA==
From: "tip-bot2 for Martin Schiller" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Airmont NP
Cc: Martin Schiller <ms@dev.tdt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251124074846.9653-3-ms@dev.tdt.de>
References: <20251124074846.9653-3-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508029.510.14746218727638398447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     a08340fd291671c54d379d285b2325490ce90ddd
Gitweb:        https://git.kernel.org/tip/a08340fd291671c54d379d285b2325490ce=
90ddd
Author:        Martin Schiller <ms@dev.tdt.de>
AuthorDate:    Mon, 24 Nov 2025 08:48:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:08 +01:00

perf/x86/intel: Add Airmont NP

The Intel / MaxLinear Airmont NP (aka Lightning Mountain) supports the
same architectual and non-architecural events as Airmont.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251124074846.9653-3-ms@dev.tdt.de
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 0553c11..1840ca1 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7410,6 +7410,7 @@ __init int intel_pmu_init(void)
 	case INTEL_ATOM_SILVERMONT_D:
 	case INTEL_ATOM_SILVERMONT_MID:
 	case INTEL_ATOM_AIRMONT:
+	case INTEL_ATOM_AIRMONT_NP:
 	case INTEL_ATOM_SILVERMONT_MID2:
 		memcpy(hw_cache_event_ids, slm_hw_cache_event_ids,
 			sizeof(hw_cache_event_ids));

