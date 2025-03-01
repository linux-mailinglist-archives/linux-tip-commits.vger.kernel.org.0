Return-Path: <linux-tip-commits+bounces-3753-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29E6EA4ADA4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:07:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 414A01701DF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C9CB1E98F4;
	Sat,  1 Mar 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BM1RXNko";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0AQJHoU/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C53621E5B99;
	Sat,  1 Mar 2025 20:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859655; cv=none; b=sI+a/Lwo0fDAkPf7EvGJzl0I5oOBxu80YiDY2mJYuLFKy4wa4x+g0Fhi8h8icfh3DhAtUiBax4qdcEXlHvCuCuxKgjNRjinQl/24FZp6XEBCMZBwoXUeflqBFEpTqARAjFO2e1tUjMiRcQcVyNrb8OrVqJkCfdo4oMNKLhbLls4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859655; c=relaxed/simple;
	bh=siIwgLCP+PYUROXcl8Un5qVAjJz/1ZPp5jmjpGtrAtQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SS1CaeItZuYpTCFdXUsV7EIUWB2WeQsmR0V+s//m8m28fILAKEIRzJlpQ7H+zSz2nLUa41cv7M02FCiP2hcYNQj+I0c3xcMoZkKr7fHEHpzchTHN4b3DxSnLmpVmNGv/9RkGterxhSiSV5MYGp4MC7qdDYVdBNXaxtS+kIl9pgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BM1RXNko; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0AQJHoU/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTqFQq3Fp5mhQzd8bXGsgAFwl02ZpFz6VYhimWe4tqM=;
	b=BM1RXNkolTUBDx+wFGyTpCc/4TDOKrix8zb5IZ2W7TKTsesj7kKB9awdSzL7TkGJtfij9W
	mKHDFHHQr+ofpMFd0qe/POBDChdxocygKT+JPI5puOXmJnoUbsMgxq1oaAfvmSsKOFo6AS
	BU6/ivXaBexiillaNfa4lawtPTsKpFqujb1VxK3UOm8F+PYDs8+rnaYiCg36fUDQolQ6lp
	oNY7uZu6fPki7ldkJhiT27q/wBO3zJLrjqc6NcLG/KXbsrRrjka1/OBQRkdrdkbirBbU8k
	ygKzvQ1BUbuBvIxzcfSH/gWwcWIF2/jTMLofBR8vkyaDBN4vRoJ+E+ztxbGLGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859652;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTqFQq3Fp5mhQzd8bXGsgAFwl02ZpFz6VYhimWe4tqM=;
	b=0AQJHoU/8AMmO0q7z7oE9WMaOQenxMFWS2PIM/uE4kaTi3Qr2uKWouOHHOb3vWENtqnIqe
	laYk07v8VpdeBIAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/bpf: Robustify perf_event_free_bpf_prog()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Alexei Starovoitov <ast@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.978956692@infradead.org>
References: <20241104135518.978956692@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965159.10177.16975783024452627213.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     26700b1359a121c42eb7517e053a86b07466b79b
Gitweb:        https://git.kernel.org/tip/26700b1359a121c42eb7517e053a86b07466b79b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 20:06:47 +01:00

perf/bpf: Robustify perf_event_free_bpf_prog()

Ensure perf_event_free_bpf_prog() is safe to call a second time;
notably without making any references to event->pmu when there is no
prog left.

Note: perf_event_detach_bpf_prog() might leave a stale event->prog

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>
Cc: Daniel Borkmann <daniel@iogearbox.net>
Cc: Andrii Nakryiko <andrii@kernel.org>
Link: https://lore.kernel.org/r/20241104135518.978956692@infradead.org
---
 kernel/events/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 525c64e..ab4e497 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -10905,6 +10905,9 @@ int perf_event_set_bpf_prog(struct perf_event *event, struct bpf_prog *prog,
 
 void perf_event_free_bpf_prog(struct perf_event *event)
 {
+	if (!event->prog)
+		return;
+
 	if (!perf_event_is_tracing(event)) {
 		perf_event_free_bpf_handler(event);
 		return;

