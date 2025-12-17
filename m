Return-Path: <linux-tip-commits+bounces-7736-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36E02CC7D65
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 14:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B041930821C9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Dec 2025 13:31:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32E69328B6C;
	Wed, 17 Dec 2025 12:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="CA4SNhow";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="epqxij6Y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B35340DA1;
	Wed, 17 Dec 2025 12:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765975087; cv=none; b=KzAAhfq9XrZ9bjJ3ziDWFCpmiMgiJt0+SWtHlRMUmKQ6y1NDEQ/18tQPnpSdD7ODy+fgFtluG9+suSNAyYv2m8/dPIiUGtha2MIQDliuigpdfQ6XwuugS5zP/4MQRtFSoBIpaaft0jWh9QphH7RrKcAiba1fDVZjdPYMaglSj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765975087; c=relaxed/simple;
	bh=cb9pcqEMqhUPuUPsqQ7sLcr0DTfbZDYTU/eFRUjIcsQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lypJ9gxp1bdPWtj4Fw45MInN4F0/6EnxLSP2FyRWBIiWAShiaRQZhBYfumS74FQWuFfFYqWDkK5K5dgcHtkoBo4jw7m+ScPIczqRo0lNYX77JcACC5xn8GvLUititU6zyqNX6VzjSfU7mCF75w/w2kRZBjZMc4iW8cbt4o/Zbgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=CA4SNhow; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=epqxij6Y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 17 Dec 2025 12:38:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765975082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwkHPql2pXVOcTanLM0zpX/5xZodwV0z0AqidGxhhs8=;
	b=CA4SNhowznnA6rmh+LL72Yg4vCfOjrRjUKEcOSmMMPz29YdfS+9QLtHB+pMAU0/YqbfpVo
	zCzJuq7Eo/cPN6/wSjJ6iPBy7E1Ufy81bkZ/5rjhsrpKqxpjFjVBrQazIhDcIJJmZiWCoE
	LX34h1RvSXRpyoWHjgJaiE2elPA0mUUbJA0g5FPwbZu3niATrxLkK3M2Fo3UiUZZrNBz9/
	inUBlsrjOMQOuA5fuCqI42qR5f5/p2jGw41V4CIa04bOW/ud9LF0JC98IxabkzlmEherUO
	rgQjyMVSOoVXzvC5jgwcZZiqKPDJsK/C4gV5CBC2DNrlQ0grBu1Z5K7rR/KvYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765975082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gwkHPql2pXVOcTanLM0zpX/5xZodwV0z0AqidGxhhs8=;
	b=epqxij6YMIuYVRvSDcw1UOnP9NZZreXgJNljbwc2afO/1yAU2v9dAhs5RXAMrDqFhcLp3Z
	505+i1lPv16yhnDg==
From: "tip-bot2 for Martin Schiller" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/msr: Add Airmont NP
Cc: Martin Schiller <ms@dev.tdt.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251124074846.9653-2-ms@dev.tdt.de>
References: <20251124074846.9653-2-ms@dev.tdt.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176597508125.510.7955284109554841354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     63dbadcafc1f4d1da796a8e2c0aea1e561f79ece
Gitweb:        https://git.kernel.org/tip/63dbadcafc1f4d1da796a8e2c0aea1e561f=
79ece
Author:        Martin Schiller <ms@dev.tdt.de>
AuthorDate:    Mon, 24 Nov 2025 08:48:44 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 17 Dec 2025 13:31:08 +01:00

perf/x86/msr: Add Airmont NP

Like Airmont, the Airmont NP (aka Intel / MaxLinear Lightning Mountain)
supports SMI_COUNT MSR.

Signed-off-by: Martin Schiller <ms@dev.tdt.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://patch.msgid.link/20251124074846.9653-2-ms@dev.tdt.de
---
 arch/x86/events/msr.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/msr.c b/arch/x86/events/msr.c
index 7f5007a..8052596 100644
--- a/arch/x86/events/msr.c
+++ b/arch/x86/events/msr.c
@@ -78,6 +78,7 @@ static bool test_intel(int idx, void *data)
 	case INTEL_ATOM_SILVERMONT:
 	case INTEL_ATOM_SILVERMONT_D:
 	case INTEL_ATOM_AIRMONT:
+	case INTEL_ATOM_AIRMONT_NP:
=20
 	case INTEL_ATOM_GOLDMONT:
 	case INTEL_ATOM_GOLDMONT_D:

