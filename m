Return-Path: <linux-tip-commits+bounces-1947-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7310947CBE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 16:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 247AD1C21BCD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Aug 2024 14:22:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D3E13B585;
	Mon,  5 Aug 2024 14:22:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ux0esf55";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2hl9jvwp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 061657D3F4;
	Mon,  5 Aug 2024 14:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722867733; cv=none; b=munHSQSMGO/WvEXumVAbT1WaZh5/lGT/Nwh7AmgNwIri62IKlkK8Vl1gW/8BgG0zk8VCZS51lHIBWOxakVgVUZ46o9MCmZGMElaUHywWmN85zrjELeAAjIBC3ztsr4Qd6OoZWUiosCrNc+q7RAENRhHaYxXmREOnLxo9zb0kMTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722867733; c=relaxed/simple;
	bh=0qYVUGlTJ16jtPygVR0sEdGc13M7hyG3W9V2BqTX+yU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=G25hZE/EjlPyk3i8pmcPHlitmTcWrfnXuplDV2zAim9cPK+31ay2ifrDnc5SCiSOeekz+so1Vbfibu06MsijKpLEeT26SGiskgDwJyWeMHNdibpOwH/DdPXzNaXMehLtqyBsqfjrWr9WCrl33QqiScihUEUkQCXmQvSzpAc53kQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ux0esf55; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2hl9jvwp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 05 Aug 2024 14:22:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722867730;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAjYaEHGFd3zUYlHOqKZ9xwu5Pvhc2m+tk7cm5Fh1BI=;
	b=ux0esf55Ld0eh3SUWsfG+Sjg2GMWJKi8D2UdPLKb2TFXujljikYr/UfUPik3z2f5GQpsh2
	2jEFrk/2ceLoQHcMYKt0PwCQDbER9BFT55Wj6ZTfTwq6XvNY8YCCFKmiWABdzEsHHbgp1H
	BLL3UZJ+sDRJ56WlVlLQNFd3K9IWXlw/OoRKlTIrTAWWdtsqhZ8H0n5ZPm/LSUoZEW//7e
	pkVt1TXPLI8MS9BT/rRepAc7iP32bBUwbO2qomVwR2GnXG/qukgexde0Dhbe5SbURQXiNE
	ynJX3+UDSDuUeV4/Xjv99wyljQ5ZGicphyvS83w238CIZwZkwlww7u9OIMKGBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722867730;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PAjYaEHGFd3zUYlHOqKZ9xwu5Pvhc2m+tk7cm5Fh1BI=;
	b=2hl9jvwphQw9G4kHqJzJ0Mf27sESHcKZhVE3ljtVVg14xhMILhVPjwX13inJIrvSRtE36d
	VoGfWPKfiJhhhMCQ==
From: "tip-bot2 for Justin Stitt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/urgent] ntp: Clamp maxerror and esterror to operating range
Cc: Justin Stitt <justinstitt@google.com>,
 Thomas Gleixner <tglx@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
References: <20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172286772988.2215.12627503289545685175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     87d571d6fb77ec342a985afa8744bb9bb75b3622
Gitweb:        https://git.kernel.org/tip/87d571d6fb77ec342a985afa8744bb9bb75b3622
Author:        Justin Stitt <justinstitt@google.com>
AuthorDate:    Fri, 17 May 2024 20:22:44 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 05 Aug 2024 16:14:14 +02:00

ntp: Clamp maxerror and esterror to operating range

Using syzkaller alongside the newly reintroduced signed integer overflow
sanitizer spits out this report:

UBSAN: signed-integer-overflow in ../kernel/time/ntp.c:461:16
9223372036854775807 + 500 cannot be represented in type 'long'
Call Trace:
 handle_overflow+0x171/0x1b0
 second_overflow+0x2d6/0x500
 accumulate_nsecs_to_secs+0x60/0x160
 timekeeping_advance+0x1fe/0x890
 update_wall_time+0x10/0x30

time_maxerror is unconditionally incremented and the result is checked
against NTP_PHASE_LIMIT, but the increment itself can overflow, resulting
in wrap-around to negative space.

Before commit eea83d896e31 ("ntp: NTP4 user space bits update") the user
supplied value was sanity checked to be in the operating range. That change
removed the sanity check and relied on clamping in handle_overflow() which
does not work correctly when the user supplied value is in the overflow
zone of the '+ 500' operation.

The operation requires CAP_SYS_TIME and the side effect of the overflow is
NTP getting out of sync.

Miroslav confirmed that the input value should be clamped to the operating
range and the same applies to time_esterror. The latter is not used by the
kernel, but the value still should be in the operating range as it was
before the sanity check got removed.

Clamp them to the operating range.

[ tglx: Changed it to clamping and included time_esterror ] 

Fixes: eea83d896e31 ("ntp: NTP4 user space bits update")
Signed-off-by: Justin Stitt <justinstitt@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Miroslav Lichvar <mlichvar@redhat.com>
Link: https://lore.kernel.org/all/20240517-b4-sio-ntp-usec-v2-1-d539180f2b79@google.com
Closes: https://github.com/KSPP/linux/issues/354
---
 kernel/time/ntp.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/time/ntp.c b/kernel/time/ntp.c
index 406dccb..502e1e5 100644
--- a/kernel/time/ntp.c
+++ b/kernel/time/ntp.c
@@ -727,10 +727,10 @@ static inline void process_adjtimex_modes(const struct __kernel_timex *txc,
 	}
 
 	if (txc->modes & ADJ_MAXERROR)
-		time_maxerror = txc->maxerror;
+		time_maxerror = clamp(txc->maxerror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_ESTERROR)
-		time_esterror = txc->esterror;
+		time_esterror = clamp(txc->esterror, 0, NTP_PHASE_LIMIT);
 
 	if (txc->modes & ADJ_TIMECONST) {
 		time_constant = txc->constant;

