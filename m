Return-Path: <linux-tip-commits+bounces-6826-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C0E6BE2686
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:33:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 20DEF4FAEE6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 798DF319609;
	Thu, 16 Oct 2025 09:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yaERUeL6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7lCCNkJE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5C2B3191D3;
	Thu, 16 Oct 2025 09:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607199; cv=none; b=IDUIGHmOcxuIw0NhYA8RHpsz+IvRRgwEBt0qcbZi1eTiErTJ/GTHCJK61PPlt46uB0DAnLbpUFYbuC35c9vRKeCPWL6QsH/AFjlNXErsnbN98P/r1Rb7wlOi8mhhAuEO/WEDonpgAOPMQG46hSURIMjF6oDdO2sDDdxvWgak3pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607199; c=relaxed/simple;
	bh=fecNl9ISgBeTdRqlvQGM4Jt3pInY79zqrPwdq/52Bt8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IhzvPfFH9souxuMCn1vZIEJVRgHm/YbPhxoZKnluKGCVadAQQFPI2YCuNxJMqNjCZS4Gpl2go3wDniv3wNZikWzP5dA7/wokxjuqdsR4akE4E9hNRyOJKwhuxw+XNaPxUgI2WMRLyxmcT9x5cQj9+5nXJ5wcnnzXTLFt0+NKl0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaERUeL6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7lCCNkJE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w13JJpdIn3Sz7wl1jYAHGKc5U/bRAM2Wa0lA3i1PugY=;
	b=yaERUeL6GjZoQCXfER0+Vsxhx/TSt0RKunUoDQVBiVW75FaBfsKrhMpq4f1NtD3LG3uHAx
	5dbrBMPsj9BnCG73N6GYyt89Z15y6yXwJ7Rif841kS9vrVJsoh6E5Ozuu4+P87j/yexpmg
	gr7WdBU6rEPcFqDmno4l+q/AtTrLEV+NNJdKVfF/23EB1VhKV4C8+peI4+SM9MnjZ+2fYW
	jIT21631SEAeaVyTv9LWyEhzQuH2kGSsJfuwCKGkeo1ZTeW7zYbfM/dR3ZXaORd5vLIsPR
	hlkO9xdf79sSFcSrJoyUd/IMV+Snuo6fg/BBUSXyPthyoVJ3RiyCMZXmtNnU0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607196;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w13JJpdIn3Sz7wl1jYAHGKc5U/bRAM2Wa0lA3i1PugY=;
	b=7lCCNkJEj0vgrMmTwdgycB5PRbPRYEVFhxLd+t6ErUyjXj+YpGfORiVxkM50xAGpdJBo2E
	8oNInn8y7olPoABg==
From: "tip-bot2 for George Kennedy" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd: Check event before enable to avoid GPF
Cc: syzkaller <syzkaller@googlegroups.com>,
 George Kennedy <george.kennedy@oracle.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <1728392453-18658-1-git-send-email-george.kennedy@oracle.com>
References: <1728392453-18658-1-git-send-email-george.kennedy@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060719457.709179.10142302566518648596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     866cf36bfee4fba6a492d2dcc5133f857e3446b0
Gitweb:        https://git.kernel.org/tip/866cf36bfee4fba6a492d2dcc5133f857e3=
446b0
Author:        George Kennedy <george.kennedy@oracle.com>
AuthorDate:    Tue, 08 Oct 2024 08:00:53 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:47 +02:00

perf/x86/amd: Check event before enable to avoid GPF

On AMD machines cpuc->events[idx] can become NULL in a subtle race
condition with NMI->throttle->x86_pmu_stop().

Check event for NULL in amd_pmu_enable_all() before enable to avoid a GPF.
This appears to be an AMD only issue.

Syzkaller reported a GPF in amd_pmu_enable_all.

INFO: NMI handler (perf_event_nmi_handler) took too long to run: 13.143
    msecs
Oops: general protection fault, probably for non-canonical address
    0xdffffc0000000034: 0000  PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000001a0-0x00000000000001a7]
CPU: 0 UID: 0 PID: 328415 Comm: repro_36674776 Not tainted 6.12.0-rc1-syzk
RIP: 0010:x86_pmu_enable_event (arch/x86/events/perf_event.h:1195
    arch/x86/events/core.c:1430)
RSP: 0018:ffff888118009d60 EFLAGS: 00010012
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000034 RSI: 0000000000000000 RDI: 00000000000001a0
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000002
R13: ffff88811802a440 R14: ffff88811802a240 R15: ffff8881132d8601
FS:  00007f097dfaa700(0000) GS:ffff888118000000(0000) GS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 0000000103d56000 CR4: 00000000000006f0
Call Trace:
 <IRQ>
amd_pmu_enable_all (arch/x86/events/amd/core.c:760 (discriminator 2))
x86_pmu_enable (arch/x86/events/core.c:1360)
event_sched_out (kernel/events/core.c:1191 kernel/events/core.c:1186
    kernel/events/core.c:2346)
__perf_remove_from_context (kernel/events/core.c:2435)
event_function (kernel/events/core.c:259)
remote_function (kernel/events/core.c:92 (discriminator 1)
    kernel/events/core.c:72 (discriminator 1))
__flush_smp_call_function_queue (./arch/x86/include/asm/jump_label.h:27
    ./include/linux/jump_label.h:207 ./include/trace/events/csd.h:64
    kernel/smp.c:135 kernel/smp.c:540)
__sysvec_call_function_single (./arch/x86/include/asm/jump_label.h:27
    ./include/linux/jump_label.h:207
    ./arch/x86/include/asm/trace/irq_vectors.h:99 arch/x86/kernel/smp.c:272)
sysvec_call_function_single (arch/x86/kernel/smp.c:266 (discriminator 47)
    arch/x86/kernel/smp.c:266 (discriminator 47))
 </IRQ>

Reported-by: syzkaller <syzkaller@googlegroups.com>
Signed-off-by: George Kennedy <george.kennedy@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/events/amd/core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index b20661b..8868f5f 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -763,7 +763,12 @@ static void amd_pmu_enable_all(int added)
 		if (!test_bit(idx, cpuc->active_mask))
 			continue;
=20
-		amd_pmu_enable_event(cpuc->events[idx]);
+		/*
+		 * FIXME: cpuc->events[idx] can become NULL in a subtle race
+		 * condition with NMI->throttle->x86_pmu_stop().
+		 */
+		if (cpuc->events[idx])
+			amd_pmu_enable_event(cpuc->events[idx]);
 	}
 }
=20

