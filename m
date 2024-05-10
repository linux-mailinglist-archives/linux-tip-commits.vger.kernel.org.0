Return-Path: <linux-tip-commits+bounces-1248-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEBE58C1F51
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 09:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EF69B20F9E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 07:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0ACE415F3E1;
	Fri, 10 May 2024 07:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4Q5jLkSW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WiDYPmDe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AD3215ECFA;
	Fri, 10 May 2024 07:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715327670; cv=none; b=IU24BXgOQjc5PAsX0kTeN1Ka9SpDrLNTVtfjOGZI0X6Ak/6iir/ZKJSDkIFMYjCRO29hi/7b5D6k+WrzgLKdTfxY4nN+MfjwYCORtMBpzO1aOSvJs86/jD3z3i5LmpzpbBxV7zv3uVTM2Tur2UCu9qaVs+9r8BPRCrZeXECtofE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715327670; c=relaxed/simple;
	bh=vEC3kcI1ew7rGVRSQhXH7orLT4WGgL0RwJq9L82V8n0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=sqaX5p9g6+kue3MoNOhy7tEAFi7113r2K9dc6rv1P1yQOUoqz0lMW0LhzMygRTjC/SB6r3uWqEbBF+IWmUmFxFS3EwsrlsZ31fct8SnoCcQxQayTCyh9F2FXKgrfw6FEkDsnBhYVz4R8uGzvW83iW2EdxFWQwB2jd5mKBW3l2NU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4Q5jLkSW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WiDYPmDe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 07:54:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715327667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GoS44p5Zu/Cx1SabxNiVFz3l/boo5lVN7/b7TKg1gRA=;
	b=4Q5jLkSW4TUhyRv22qaIL2KglvxHAegv6yo2xerd4l69NA9HMwPSqTlKYlSNOvE0gCGBCW
	IkNaLM4yLc4LhTJdsHm72ZCRVusn0C85xq97nxterCdexyoRTzOxLNwBWxAVToy3hvKbf3
	NMrv7PIGJSL3PGPUq2ZYD15E4BAKlc7SYB33Jninj02iRjoB7owMhx8BJAtVwqXLZqHsno
	VFwLgKoIXTZFcSxYerk7N3c+skyxnA/ibWQtH4BfIBKM0DLcKCxcUYtPwro9l/CIsg9udM
	qzlLtNO0uDIbJXtALLIIVh+cjK3Urv7KEvnpj2N8Pp7YmxHxceWePCfdnjHGig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715327667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=GoS44p5Zu/Cx1SabxNiVFz3l/boo5lVN7/b7TKg1gRA=;
	b=WiDYPmDeMlrhcT3qx+ivYuhxFcgMs6jOxn/isrSCKzJ4K+465znVYlkh5acYMtk/JBxuGn
	+zxioApegAkodODg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/cstate: Remove unused 'struct perf_cstate_msr'
Cc: Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171532766734.10875.1641155549159573518.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9d351132ed706ae24325809afa821cabf6d72568
Gitweb:        https://git.kernel.org/tip/9d351132ed706ae24325809afa821cabf6d72568
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 08 May 2024 09:47:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 08 May 2024 09:53:23 +02:00

perf/x86/cstate: Remove unused 'struct perf_cstate_msr'

Use of this structure was removed in:

  8f2a28c5859b ("perf/x86/cstate: Use new probe function")

Remove the now stale type as well.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/x86/events/intel/cstate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/events/intel/cstate.c b/arch/x86/events/intel/cstate.c
index 54eb142..e64eaa8 100644
--- a/arch/x86/events/intel/cstate.c
+++ b/arch/x86/events/intel/cstate.c
@@ -143,12 +143,6 @@ struct cstate_model {
 #define SLM_PKG_C6_USE_C7_MSR	(1UL << 0)
 #define KNL_CORE_C6_MSR		(1UL << 1)
 
-struct perf_cstate_msr {
-	u64	msr;
-	struct	perf_pmu_events_attr *attr;
-};
-
-
 /* cstate_core PMU */
 static struct pmu cstate_core_pmu;
 static bool has_cstate_core;

