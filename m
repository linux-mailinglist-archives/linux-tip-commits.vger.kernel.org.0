Return-Path: <linux-tip-commits+bounces-5068-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 008B7A934D8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:46:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C6C3E1B6672B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65DC2270EC5;
	Fri, 18 Apr 2025 08:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XnQqdAnn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NDJGTbj7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B7E26FDB5;
	Fri, 18 Apr 2025 08:45:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965927; cv=none; b=aVDYBreLmhxsSqvI37IpE8wwUkZLSmB7syxfaMo2CrRnDNjuZt89gIXLF8XDbs7xdG0LZJwz8+fQP01QSyapxwjGgr6JEertTnmTgY+igj6sIo++HKSsWIuGfJCiXMdADZI2VcIM2RhHcJVkwZZkFFTvmg/RIOQzdI3UGTX/bEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965927; c=relaxed/simple;
	bh=e2+cC+AodO1PBttAXHMlB1mNCR9zze2F9gbi5GF5ato=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Cs9hFElEmoxNWwq+FC2L9zFpnGw2DY/Oifb8DrrXPJCQMQCisRbQbH6qMZs4inQtOA+WBmqG/3kqSpdFjFMYHewYmfDQrfLdFSvxM3AqvGbEi2Lzy9RFk4mq2HrKJN5nLCy4Va/lIGOZi2h9D0PMgUB0oU+7zUFnVr1gJ+oQSjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XnQqdAnn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NDJGTbj7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:45:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744965923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSC/e2tBv/m605MjjCHWho+WfJPsCqV7tzLK0KbBRVQ=;
	b=XnQqdAnnKcWk4a6gLG3SiXlUQeyldr9Vul9RZ3VGIXFll1X4MOni2d6lPhQUJ4TzLMfeSh
	ZhzGvxWy/dQ/iFXoN6eHFe+iLy/5NPmCt88ijbnLmidu8fedgZ2chHfKgqbocE1Rn/PlaA
	9997czwYi4Tvx1fvX9lEWnWF0x9OJ2vQcqQY+QUIOp4YPOhqwUNeMxHfH1vs9E5ZPS7ZlY
	5T2WjWOyWQG2bGVjlw9d0qaH73S0akbhSDWjiRmTuqJWGMrnEJSmpgw5/HloBWQYeHyR7w
	klwhl7eHatZ6+dwoRlPeFtMdT8w9HRgD5WIDnPoxyBUN2roUCLlH2bqqhRGoiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744965923;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSC/e2tBv/m605MjjCHWho+WfJPsCqV7tzLK0KbBRVQ=;
	b=NDJGTbj79IcgcvMws/7Q4rENr3+iRjBoXhauKa89SExnX+6aHCsggJj/EGEnF7J3iCAE3p
	YNBvIcAqilLcXxCQ==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Remove unused 'struct
 amd_uncore_ctx::node' member
Cc: Sandipan Das <sandipan.das@amd.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C30f9254c2de6c4318dd0809ef85a1677f68eef10=2E17449?=
 =?utf-8?q?06694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C30f9254c2de6c4318dd0809ef85a1677f68eef10=2E174490?=
 =?utf-8?q?6694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496592286.31282.7784906761677716263.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     4f81cc2d1bf91a49d33eb6578b58db2518deef01
Gitweb:        https://git.kernel.org/tip/4f81cc2d1bf91a49d33eb6578b58db2518deef01
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 18 Apr 2025 09:12:59 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 10:35:33 +02:00

perf/x86/amd/uncore: Remove unused 'struct amd_uncore_ctx::node' member

Fixes: d6389d3ccc13 ("perf/x86/amd/uncore: Refactor uncore management")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/30f9254c2de6c4318dd0809ef85a1677f68eef10.1744906694.git.sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 49c26ce..010024f 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -38,7 +38,6 @@ struct amd_uncore_ctx {
 	int refcnt;
 	int cpu;
 	struct perf_event **events;
-	struct hlist_node node;
 };
 
 struct amd_uncore_pmu {

