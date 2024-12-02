Return-Path: <linux-tip-commits+bounces-2916-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E313C9E0002
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:18:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A218B281384
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F7A205AC0;
	Mon,  2 Dec 2024 11:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c1ji67UR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oN7gtaqj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302D3204F65;
	Mon,  2 Dec 2024 11:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138067; cv=none; b=tOgcUcoW9thM9yZGuxaj5avv1bv7v5YDEDv7cum7weUJzIAh2QlW7VQtMCfX2I3dMWyn4hXJjmR9d1K82C2QFS+U4wqIWirh+ZaqbuE1pnMSSsJ3tLBiFUi+6ZYvmdED+lmTdwWBSFqX+CRPavUocxZAV2AyROcgXiEeDeXIK1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138067; c=relaxed/simple;
	bh=1MVASQHcLsWLOrEZI9U4pIx6/oJVFFqef0ACsIa1WhM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=APVuadUOLBhYZXkxYGDu7Yg+vhFhe2nCKPdX58KeL0EM60KFzHOrRRYOywW/iTdnQxx/RB0IVWWe0BzsPBa9e6ORCws0oR89DYDaNkbbMn/mlUz3CbU2qOMrpnTFlwAXlXmX4Ti7hd9MjP2OTiD6EdYqNGQkvA37F+uOr8BJf6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c1ji67UR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oN7gtaqj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHB6ZgZwdghVXYiznHtrDVc3zVIQopMOK167dHATJ3k=;
	b=c1ji67URJPhKYekBaMMk4VCt5NwxyqLoLwj3qDzj0sXogLaJ7kft9hBD2SxtdP+R0FtQNn
	j98Lw0Zpozyc6QufdnMGACRgUkiCmKlr6e8mOUUZhznn6pBqpzR+AzysuPPHYF2VuPl5Ms
	xrs9OhQpmWmkbjLEIkble1ZEeXxvjKzIrTmPXCKDFwikQt8f3O7tXHMxla5t/+rSStrNlG
	U+ZvhAc/CVr27Uyg0fHM47wvYG871o3vu78kGo02T7wtvXPxgMdPaWATXXGYEjmvFD/yuo
	WXBgvhgYSGd+HlgQL2sPRUZ5Tt/G4vN+K+1uwjOK/XAB/7iZHLaBDW4GqOHH1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kHB6ZgZwdghVXYiznHtrDVc3zVIQopMOK167dHATJ3k=;
	b=oN7gtaqj4HOVq10+w0lrvcbDu6D+X1YmLYuXFDsqLqZxU7xHDqo0RiXEhBvgcJ1Y4q2TUD
	/xkoZfLWUSM5eXBg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add Arrow Lake U support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241121180526.2364759-1-kan.liang@linux.intel.com>
References: <20241121180526.2364759-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313806298.412.16905990546904790095.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4e54ed496343702837ddca5f5af720161c6a5407
Gitweb:        https://git.kernel.org/tip/4e54ed496343702837ddca5f5af720161c6a5407
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 21 Nov 2024 10:05:26 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:33 +01:00

perf/x86/intel: Add Arrow Lake U support

>From PMU's perspective, the new Arrow Lake U is the same as the
Meteor Lake.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241121180526.2364759-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bb284af..2e1e268 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -7135,6 +7135,7 @@ __init int intel_pmu_init(void)
 
 	case INTEL_METEORLAKE:
 	case INTEL_METEORLAKE_L:
+	case INTEL_ARROWLAKE_U:
 		intel_pmu_init_hybrid(hybrid_big_small);
 
 		x86_pmu.pebs_latency_data = cmt_latency_data;

