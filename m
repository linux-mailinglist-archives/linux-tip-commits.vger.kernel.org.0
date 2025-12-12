Return-Path: <linux-tip-commits+bounces-7632-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A1677CB85DD
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:05:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 67FF630269B6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DD833101DB;
	Fri, 12 Dec 2025 09:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3FZ0/+Ic";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bntAxg8l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F82A3112B0;
	Fri, 12 Dec 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765530287; cv=none; b=m8yPdcUjmrQ7U7mgHxDW8N32gIcEtS47ZwJ7BNAXKzLogVs+vATUH8Fcu1eZMpA2CUpcfRSOnjRKE6cjCgayPueHxr7bWEJ9EUwsCb0ki3Kq8eY0w4Hdzui0wkVtNXIB+SrFpAjpRAbpZZpC+iOLxkgdxppeQwk3wZWK7og8SGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765530287; c=relaxed/simple;
	bh=6OyAtiZE8U34VuE5K9NMzJ0CivL0ubrJkFF1gwNxbUI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Y1V1qN2or8X+fXI0nA7V1w5NWQKIyuYGW2inKN3fDEsFVwhe0hnXmscaUkOYzDVkXO48xJYLKC0nJVQ8S3/qIOb9mJhlb+ZxJSmrSkub09ZShHss7HnQaAgYPKrg9fmEMYcYdG51IZ1ZbK7m2M6HYIHhHzjeARjRbonyWtREtXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3FZ0/+Ic; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bntAxg8l; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:04:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765530283;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vRNkLDTRui4bHk+0KHsI+3IhHRCR0bD33cJL33xs2Q=;
	b=3FZ0/+Icg+SO8l/yo68USSiVazuNGTtCkncDxV048EFwPTQLYhN0MgnzuYqVwMuVUqGD+l
	dr0l133THG+8RAx/P44QbGPUW64vgHk0Qn3F8mQB/+cA37V1ix5jvyrwajmE62I3/vppyT
	laqmx3tgh5Kfv0uHzTZn/YmvIzK+mWC6XpzGbtUKkQIncoOPheZwuwkjuphiTxxq/SP8bp
	E36KQGwEkD6P42KA6cR4JfVOTBPAhDA+/sBI708rUNfQ54BAhxggtpqRTILEc1rQ/x4PDa
	DYyR/TK1DHMWRyFWAIzUpQx5BaTVxCtrgy+k1TdAXuHeAvmlmcgYCtf5dlyTFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765530283;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0vRNkLDTRui4bHk+0KHsI+3IhHRCR0bD33cJL33xs2Q=;
	b=bntAxg8lRxxTb5ngKukTbJcizvWCG8AyOnU1GJ/sV0HytJ5NZgbvXkURnGU6UJzsii3zHc
	Zw/hk0mO4YbbeJBg==
From: "tip-bot2 for Evan Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix NULL event dereference crash
 in handle_pmi_common()
Cc: kitta <kitta@linux.alibaba.com>, Evan Li <evan.li@linux.alibaba.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251212084943.2124787-1-evan.li@linux.alibaba.com>
References: <20251212084943.2124787-1-evan.li@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553028144.498.11236460229358296060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     9415f749d34b926b9e4853da1462f4d941f89a0d
Gitweb:        https://git.kernel.org/tip/9415f749d34b926b9e4853da1462f4d941f=
89a0d
Author:        Evan Li <evan.li@linux.alibaba.com>
AuthorDate:    Fri, 12 Dec 2025 16:49:43 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 09:57:39 +01:00

perf/x86/intel: Fix NULL event dereference crash in handle_pmi_common()

handle_pmi_common() may observe an active bit set in cpuc->active_mask
while the corresponding cpuc->events[] entry has already been cleared,
which leads to a NULL pointer dereference.

This can happen when interrupt throttling stops all events in a group
while PEBS processing is still in progress. perf_event_overflow() can
trigger perf_event_throttle_group(), which stops the group and clears
the cpuc->events[] entry, but the active bit may still be set when
handle_pmi_common() iterates over the events.

The following recent fix:

  7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS record lo=
ss")

moved the cpuc->events[] clearing from x86_pmu_stop() to x86_pmu_del() and
relied on cpuc->active_mask/pebs_enabled checks. However,
handle_pmi_common() can still encounter a NULL cpuc->events[] entry
despite the active bit being set.

Add an explicit NULL check on the event pointer before using it,
to cover this legitimate scenario and avoid the NULL dereference crash.

Fixes: 7e772a93eb61 ("perf/x86: Fix NULL event access and potential PEBS reco=
rd loss")
Reported-by: kitta <kitta@linux.alibaba.com>
Co-developed-by: kitta <kitta@linux.alibaba.com>
Signed-off-by: Evan Li <evan.li@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251212084943.2124787-1-evan.li@linux.alibaba=
.com
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=3D220855
---
 arch/x86/events/intel/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 853fe07..bdf3f0d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3378,6 +3378,9 @@ static int handle_pmi_common(struct pt_regs *regs, u64 =
status)
=20
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
+		/* Event may have already been cleared: */
+		if (!event)
+			continue;
=20
 		/*
 		 * There may be unprocessed PEBS records in the PEBS buffer,

