Return-Path: <linux-tip-commits+bounces-7639-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A2DFCB877C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 10:31:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8041030877DE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Dec 2025 09:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97944313277;
	Fri, 12 Dec 2025 09:29:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sxwHQ5FJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Czc+4VFe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75A93128AC;
	Fri, 12 Dec 2025 09:29:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765531755; cv=none; b=PgxhhQ+PBYUi2r2UnYPq4k3VjI8x60NIfwQWfE6pBDcENygKHGm1SfDTj5AKWhzG7ZUdtwFBFQ7zv4cq0ETW/7rKAqKSsjrZFbuEuVXJYPeuMuoSaDris1fo5NGG9rMJtM6MmvBuvWLM4Sx6z5AcvcZcYfSoOeist+53xO8LfPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765531755; c=relaxed/simple;
	bh=DqnjFp/ZbCtSeM2+4RZ/w19ILgndgWII4cfNsxtUX3I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=D7amaTJduKV/6WJX5wkJIiTkTPzkXQR9TPk0feaDoBzKn5V//fLllJgvv9BSWuAF4SD+uemLrRgRx9f5J1CynJFxaLrgY2DvO5I5ELVO7j3SdTQxicpnN5jVsNZzeKjAnZpdZwU4pDEO0eDMqSgdnt6HBzYNZTYNxcHMWDIo5EY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sxwHQ5FJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Czc+4VFe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 12 Dec 2025 09:29:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765531749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq3O5gd3T6a6rMOtRFH9UZNZTqxEezuZndLpQPMPM6s=;
	b=sxwHQ5FJIrdVGByPoNTF0FYzMGQjXpKDL1jJJ44NuMi71tL1SgKQOmwTzXgr1iW5omkD6r
	F8Fi1dNmAq+1MDVgtJ0rhVhFO5jULNwmT4B5o6pJQns1O3HgvF1ABqX9I/FvHdGw/T4S2B
	eBe5z4v6FXtvNiwB2BLn5MhVEClMtPSL1pRetaT60XSfmq5xP1T/mDlsOFwkaoz7v4eLkj
	x7w3lycSzdAxfOIFfs/GUG/67tj1ac4kLkTTZ9i+cj79dcRYyJvPqdwX9IYKcMDFewxg7x
	rWG3OPFBZi3M5nxAMPqBPV9NezGU2VcWj8SkToK/3Gir8ZVCGswaEvgjuoierg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765531749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Dq3O5gd3T6a6rMOtRFH9UZNZTqxEezuZndLpQPMPM6s=;
	b=Czc+4VFepgxf7WGSM1Wu2T89HmNVQvQdWZeas/b/XMtuWB12AYyMW3XG03cwPGUwNfKxq7
	JBtcoA1xnSh5NNBQ==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] rseq: Always inline rseq_debug_syscall_return()
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251205100753.4073221-1-edumazet@google.com>
References: <20251205100753.4073221-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176553174748.498.517204626201697721.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     bdae29d6512ddc589200b9ae6bda467bdbab863d
Gitweb:        https://git.kernel.org/tip/bdae29d6512ddc589200b9ae6bda467bdba=
b863d
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Fri, 05 Dec 2025 10:07:53=20
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Dec 2025 10:26:26 +01:00

rseq: Always inline rseq_debug_syscall_return()

To get the full benefit of:

  eaa9088d568c ("rseq: Use static branch for syscall exit debug when GENERIC_=
IRQ_ENTRY=3Dy")

clang needs an __always_inline instead of a plain inline qualifier:

	$ for i in {1..10}; do taskset -c 4 perf5 bench syscall basic -l 100000000 |=
 grep "ops/sec"; done

		 Before	     After
	ops/sec  15424491    15872221   +2.9%

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Link: https://patch.msgid.link/20251205100753.4073221-1-edumazet@google.com
---
 include/linux/rseq_entry.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
index c92167f..a36b472 100644
--- a/include/linux/rseq_entry.h
+++ b/include/linux/rseq_entry.h
@@ -596,7 +596,7 @@ static __always_inline void rseq_exit_to_user_mode_legacy=
(void)
=20
 void __rseq_debug_syscall_return(struct pt_regs *regs);
=20
-static inline void rseq_debug_syscall_return(struct pt_regs *regs)
+static __always_inline void rseq_debug_syscall_return(struct pt_regs *regs)
 {
 	if (static_branch_unlikely(&rseq_debug_enabled))
 		__rseq_debug_syscall_return(regs);

