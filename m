Return-Path: <linux-tip-commits+bounces-7734-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C3771CC7BE8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:04:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 92DF43034590
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EF2533E341;
	Wed, 17 Dec 2025 12:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PbzH437W";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5KoHVTzD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7827733C522;
	Wed, 17 Dec 2025 12:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975084; cv=none; b=GNbBxazWbhayum2i7OSim0JT3GevibVbMzUSzQPGRAUN7NuDqlv+IKmmxbRE/vrv52tW7AJAZSUEoG8KWDSy2v35U90cgcoD0VeWpA1RV98jJdB0XtQMHAN4uMPp48bV5Sn5ocOQJzGzt7ZGq/902seeAR5q7cCjizL2EfnYupI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975084; c=relaxed/simple;
	bh=9X3cGWqZf9OQmsZKf4pdXttVlADhWGKfHaP+PQxyLvk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rx1c0U+HiK7RQmhs8XE/v2J+6RrqXGQUev2v5JagIQDpOGYf6yOLQGA1C6G+Waj0x/b0p7M0pGdYD825VvWrp1Yw0ga4tOVRn/PDYnCOzG10vAGFRK2HrDpio7fDRBakCaCO5SZ3+fpP4zdPM5D8mRwo1TQLOT7DfBCgU06uN1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PbzH437W; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5KoHVTzD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:37:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oZEnrxUlid2j12E8fSIXfKf2biAXf2NgPB/8iahx1U=;
	b=PbzH437W8vV2op9KZ0ZTQqUV/paVtHrM1HzJQV6sKC2P/LvXhtmgvEt8wLgRvsAv51Cl4E
	3eCxp2R9zPhvCbltxlZdENcBsEkBx1L+3Cxt6bSVTGQFreAdrabl4/dmwz7cgcVfz9Fg7R
	GKd/s3CPlHu6VMeu+ogftv161ipCbZc6TlJtQgdZPnBcPRd3cts3p810ChUA6VJ+st8/Ou
	JNf8urRuXI0G14WSQQeR0QFLdidHrC1U42D81nCOlL+WuOf7UD/T7kZ0Ncp1Aq5GagN9eX
	gsxlF9BzBvp/vkWBTPmydimVBvduSXgiIQINszPOSBWv+HtrSpCS36t5i+ZmJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975080;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7oZEnrxUlid2j12E8fSIXfKf2biAXf2NgPB/8iahx1U=;
	b=5KoHVTzDyZkHxY9Bt/O4A+sQZf62P/0S0m6/PKvDi1vjAdc9eoD9zSTGw2cl+gaMwEzi4H
	rRwvPJNHZyb5lkCQ==
From: "tip-bot2 for Martin Schiller" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/cstate: Add Airmont NP
Cc: Martin Schiller <ms@dev.tdt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251124074846.9653-4-ms@dev.tdt.de>
References: <20251124074846.9653-4-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597507931.510.4588704165245096188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     3006911f284d769b0f66c12b39da130325ef1440
Gitweb:        https://git.kernel.org/tip/3006911f284d769b0f66c12b39da130325e=
f1440
Author:        Martin Schiller <ms@dev.tdt.de>
AuthorDate:    Mon, 24 Nov 2025 08:48:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:09 +01:00

perf/x86/cstate: Add Airmont NP

>From the perspective of Intel cstate residency counters, the Airmont NP
(aka Lightning Mountain) is identical to the Airmont.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251124074846.9653-4-ms@dev.tdt.de
---
 arch/x86/events/intel/cstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 1e2658b..f3d5ee0 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -613,6 +613,7 @@ static const struct x86_cpu_id intel_cstates_match[] __in=
itconst =3D {
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT,	&slm_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_SILVERMONT_D,	&slm_cstates),
 	X86_MATCH_VFM(INTEL_ATOM_AIRMONT,	&slm_cstates),
+	X86_MATCH_VFM(INTEL_ATOM_AIRMONT_NP,	&slm_cstates),
=20
 	X86_MATCH_VFM(INTEL_BROADWELL,		&snb_cstates),
 	X86_MATCH_VFM(INTEL_BROADWELL_D,	&snb_cstates),

