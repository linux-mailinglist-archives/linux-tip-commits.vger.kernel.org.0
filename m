Return-Path: <linux-tip-commits+bounces-4867-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F9FA85904
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:09:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E317B9A7EC1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:07:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40CF2E339C;
	Fri, 11 Apr 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GTl9J8tu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VJx3VNxW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5760298CCF;
	Fri, 11 Apr 2025 10:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365730; cv=none; b=PbeJb1NsxboMaZRExhnpqMD3TKD1QYuxVriTxS/SJqDC7SO1mwvtaAQrH1HK45xHuiQdVli81m12ZpimXaJgAkZOBUcqBwEqvtVKjmCsYRKNggLOBADkIzXfMdqORCgwfpwfBIfcQYOAsVdwR40G+TzTqtkNA+yEcTKXof/k7Ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365730; c=relaxed/simple;
	bh=I3JrYKn5npSZMvRnw3tqS7Y6eV+93B/+KH6kt8lz6as=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mb2t/5K+nPZIG2aoG1KDkJmopYojdjweaap2SHWkstUgQZqpTmglm1MXsvCCpCeUT9Qnp1QDMot0uLXqGuj4JiVbIVLxPAQC86noUahV0GcLdA9F5q0zVtU6kov++Wo6UUaRMiO9c519VFJFyH0TEZ6MyIb2n3SjaGmXQSgee4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GTl9J8tu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VJx3VNxW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365727;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaHOvYCklfG4qU0oHS2QsMnoWR8ElinIk0bU5GD+O1M=;
	b=GTl9J8tu1sCKVwaG7fQbhmJWOeVahOg7/vnI7CCGv6KMc0SvqBlDe4W1CTnGCy1wKuRSlN
	8TJ6VPBnk8JIF7dVtNAw65oLpdB2Jfz90iaqARecJFdVYaMU+ZZtB7+fdSCTCXw3QTtoIs
	fJisLvZlRHNjjuI6veVTKUhvPNKjasEqJwgOriUmK74jfc80vlFWIw2iOBTunwEyxQm20B
	nz8XZZOO+yJPaUl22zaDaA6f+nWP6wy/kiNr3UAsyFFla4HGpbQebmpaPjk3HTnDxnbfvd
	o7r+/O8mEf86Dvv6ryHgpVo/+1CytjToCa5HPxoEO6xdXRQP4lKifPVbX5eo4g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365727;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BaHOvYCklfG4qU0oHS2QsMnoWR8ElinIk0bU5GD+O1M=;
	b=VJx3VNxW5SrstZZYa3V7LkCWI4OM5QEdr9zHBesjGZqugNgUvfGyNp1zy5Ihb1/BGwaRAY
	ewXc6yCPHwKjyQBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Add text_mutex) assert to
 smp_text_poke_batch_flush()
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-22-mingo@kernel.org>
References: <20250411054105.2341982-22-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436572670.31282.12593833218110116600.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     87836af1eafc6616bde680be556f49ba3325f798
Gitweb:        https://git.kernel.org/tip/87836af1eafc6616bde680be556f49ba3325f798
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:33 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:34 +02:00

x86/alternatives: Add text_mutex) assert to smp_text_poke_batch_flush()

It's possible to escape the text_mutex-held assert in
smp_text_poke_batch_process() if the caller uses a properly
batched and sorted series of patch requests, so add
an explicit lockdep_assert_held() to make sure it's
held by all callers.

All text_poke_int3_*() APIs will call either smp_text_poke_batch_process()
or smp_text_poke_batch_flush() internally.

The text_mutex must be held, because tp_vec and tp_vec_nr et al
are all globals, and the INT3 patching machinery itself relies on
external serialization.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-22-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index b97abfb..c53eb3b 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2860,6 +2860,8 @@ static bool tp_order_fail(void *addr)
 
 static void smp_text_poke_batch_flush(void *addr)
 {
+	lockdep_assert_held(&text_mutex);
+
 	if (tp_vec_nr == TP_VEC_MAX || tp_order_fail(addr)) {
 		smp_text_poke_batch_process(tp_vec, tp_vec_nr);
 		tp_vec_nr = 0;

