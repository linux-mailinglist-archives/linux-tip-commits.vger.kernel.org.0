Return-Path: <linux-tip-commits+bounces-4875-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A28A85902
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 12:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73DB41786B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 11 Apr 2025 10:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DD0C23424C;
	Fri, 11 Apr 2025 10:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i/LFaMRy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MsnFFVf2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9126D2D4B5C;
	Fri, 11 Apr 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744365739; cv=none; b=pdUr3LVMGkEwljBU7QFzw1HpUX1lsLMqfGTDN1Fwa2kuTPb7PChnDDQK9FYgZLY0pywB/K0BCs4GOKe0iGTSHP8XUTP0uTNasP0F5s5OESifKRQXpNjdAUe+qlIOEMF9h54comljU/fuc72pnz34WLBq1tsK0fJfba/yjwGi4NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744365739; c=relaxed/simple;
	bh=aQXigxxLGM3ThSVw5eSt7Gw9HIga7Pt4PlOgaCDPoQE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=J9P5k9lPndFy1SUhAsmD03UtCcZmRg/OT88ydcISET6lTrJuB4JdV/csLzjOEYytoJ8mAjZu8moNAfcMRQlmRUOOLmtpl8UHpGtpwojuRZNC81WHMJsdfv37WIv6Uy3QGRCUmC3JN2f0/zI6TBbBwRRY01Jw2fVOXDN5JUtQEz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i/LFaMRy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MsnFFVf2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 11 Apr 2025 10:02:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744365735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxSl+/kimHhv5P4fG+5w5SCvLTw3R2m5Xo/glKVJl9g=;
	b=i/LFaMRyyYoJGb2YKy2QHgMp7PziAG+OM/L4ciLoR1tmzimuxf6eWd+vrV788UMe3w1RjJ
	FGvSNDKTxfIGojJx7eTA8pL/+Ms79kjB0xXgCvPzJ9Mheey2p+W2eDg/JdghFtU3TRjXKx
	7p6QWxwuFBn8wkXO+xoj2rFu+NB5oTx7cvV8j+Ha2DVbj8jI1roFaZbooVhpQZOlTfm+J3
	Ym+QyXa0x/PVpqm0JyBIOHkMFTUHBWEt9eHeSh/B7sZkXeWWXn7n0kv9Rjoz7ommY89ieM
	UROtbMR0a5OXKJunYaCNjn5uVi+/6y/xBvMlTUxk7WnISymiKT0oT2RIOkH16g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744365735;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wxSl+/kimHhv5P4fG+5w5SCvLTw3R2m5Xo/glKVJl9g=;
	b=MsnFFVf2WaR54lcG3rGQaICxg2yLZ1TrWY73aOqXPPfl30Joyq616t5od4kYGk4Uj5Bvmt
	V8vRxa/PjTY5yUDg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/alternatives: Remove duplicate
 'text_poke_early()' prototype
Cc: Ingo Molnar <mingo@kernel.org>, Juergen Gross <jgross@suse.com>,
 "H . Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250411054105.2341982-12-mingo@kernel.org>
References: <20250411054105.2341982-12-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174436573504.31282.16222249480183339413.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     762255b743b81c5307c0e93b2eeee4e8b7424152
Gitweb:        https://git.kernel.org/tip/762255b743b81c5307c0e93b2eeee4e8b7424152
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Fri, 11 Apr 2025 07:40:23 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 11 Apr 2025 11:01:33 +02:00

x86/alternatives: Remove duplicate 'text_poke_early()' prototype

It's declared in <asm/text-patching.h> already.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: "H . Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250411054105.2341982-12-mingo@kernel.org
---
 arch/x86/kernel/alternative.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index c6d0ca3..b8794f7 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -176,7 +176,6 @@ extern s32 __return_sites[], __return_sites_end[];
 extern s32 __cfi_sites[], __cfi_sites_end[];
 extern s32 __ibt_endbr_seal[], __ibt_endbr_seal_end[];
 extern s32 __smp_locks[], __smp_locks_end[];
-void text_poke_early(void *addr, const void *opcode, size_t len);
 
 /*
  * Matches NOP and NOPL, not any of the other possible NOPs.

