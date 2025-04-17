Return-Path: <linux-tip-commits+bounces-5030-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4A7A91AE8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D978E19E4F0A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 11:30:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6223F23ED40;
	Thu, 17 Apr 2025 11:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1/G38Xhc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WXCCh9aI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26A523E351;
	Thu, 17 Apr 2025 11:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744889413; cv=none; b=XZJQ+fBUKv6pDgfzf1+41krVIjIpvg+7CEWw+tAqUAS4t23xV8YWdS+TfpRn15jp14dDrjkQXm3mm5JJnrCztgdreWykAxTVG75VR/baZWt+wFj2c5I0fyxRPA+E9FX86Xbd25l3wdMlmsWDiOarqrswukQl2T2PHVYY1D/DmY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744889413; c=relaxed/simple;
	bh=F2FkW6HpzGcrMfu76O8qYCIk3IsbJvtavVlnU3g/Dys=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=I1tLxecU7/IKfdm4tYedslrk4Jy71+2tayRTstJiqpLubl5H1CtTYD4bzBd6u8KAHz+/Jd7+Ls5aZcjj+MjfbjCs+bBkn7NgZYU5J33vcsPzM/wjYBJ4yTumvZrYmVdcQHBGUi0h1rL+BbpyVrcxJGD+MUQYDkg5gU3hHZHaf0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1/G38Xhc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WXCCh9aI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 11:30:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744889409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEVxWaYPmPTMnblGckSO4LjwU6cfLemZFXMtF0N2uv4=;
	b=1/G38Xhcd+PiQIxp+AAC9POXi9FGl1DMlS9glEUDHYw8N6HFyE4SZGsjp5oo5uN2q1WVm8
	cqkMsD8v3l2jix0BDsvz4iEpyEqbmwrZdqvXHOv7wq8LCwzKAUbaPbg3Miy6gjJ8r8aDvE
	7d7lHSSwjSSyXjLv5L8F+CjkActETkB6CnlEi9G9+QhHn6Njnpvm+pNEStmilSPVCw56h7
	TMlc2IlpFaA277XjjRwwZq4/jg4HkizZB/HZnwDTe3PnKRKnmsTJqtXuHvp1jlWg7umC7q
	NPu8fsS24Scv403lz1RGTpUkMCEW2nOQHmfWywfjlyOMK5aVU8H7qG3AOmK/Dg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744889409;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aEVxWaYPmPTMnblGckSO4LjwU6cfLemZFXMtF0N2uv4=;
	b=WXCCh9aIzHIlaEVVM2xg5POoUeOhRPwqtH6/qdW+HjweUQHC2usb9izIP6FT66GwoheY5z
	+fmiA4igb2+orbAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Fix perf-stat / read()
Cc: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>,
 James Clark <james.clark@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250417080725.GH38216@noisy.programming.kicks-ass.net>
References: <20250417080725.GH38216@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174488940302.31282.13464297816136814347.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     75195453f7b17ae604dc28a91f19937b1906b333
Gitweb:        https://git.kernel.org/tip/75195453f7b17ae604dc28a91f19937b1906b333
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 20:50:27 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 13:24:49 +02:00

perf/core: Fix perf-stat / read()

In the zeal to adjust all event->state checks to include the new
REVOKED state, one adjustment was made in error. Notably it resulted
in read() on the perf filedesc to stop working for any state lower
than ERROR, specifically EXIT.

This leads to problems with (among others) perf-stat, which wants to
read the counts after a program has finished execution.

Fixes: da916e96e2de ("perf: Make perf_pmu_unregister() useable")
Reported-by: "Mi, Dapeng" <dapeng1.mi@linux.intel.com>
Reported-by: James Clark <james.clark@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250417080725.GH38216@noisy.programming.kicks-ass.net
---
 kernel/events/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 2eb9cd5..e4d7a0c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6021,7 +6021,7 @@ __perf_read(struct perf_event *event, char __user *buf, size_t count)
 	 * error state (i.e. because it was pinned but it couldn't be
 	 * scheduled on to the CPU at some point).
 	 */
-	if (event->state <= PERF_EVENT_STATE_ERROR)
+	if (event->state == PERF_EVENT_STATE_ERROR)
 		return 0;
 
 	if (count < event->read_size)

