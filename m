Return-Path: <linux-tip-commits+bounces-5008-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8EEA8B334
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 10:18:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C06534449DA
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 08:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6969233711;
	Wed, 16 Apr 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lym2govl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G7pkwz0t"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1F423237F;
	Wed, 16 Apr 2025 08:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744791444; cv=none; b=OAEfCML6Ili10dyRv7oQ3qdkkiPYCC3yWuE1zVj/iWWS7z2Xby2c+DHdlMK0ar/Vx13nBq2vsOuqya1hoz4Jv07gzSt9tWoUZ0cPi9GjaQqIR0KTvFZuoM/Vd45mJdPdLuSVN+y5TTg5cAoaiM4ba0tdEutBxMqrfiIqQKWkjg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744791444; c=relaxed/simple;
	bh=4WI8Jm3+eEQTPyjMGlMiTrgHMql3U38jrswi+g5ODyM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ob5pdcQ5XA79YFgDm5ODiUrORxPDV2RNqLQCbJWtcvM9HLRAz/GpvV9wHmI6SHPh8VnZXiay4g1an+zcow5Ny2uugeW2nD9qFcxLFVhshHC9zSlmQqpPjX9VRif4mTXZSel80A7QwDLOAWSXoshxhf8VGqD0twmT447+Xmm0rRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lym2govl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G7pkwz0t; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 08:17:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744791442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JnF6W6MNFrg0xeWxdQQoJHqmPhGjbuo4KR7DgOQtLY=;
	b=lym2govluxfv1sYw29QzstTAVMMBIOYxw/SQAtMzc5Y2wi1OZN+Oikv4uCMU6Iwkt+9atx
	0E1umMl8rkGSHh8oXTvtr/qgrx4ubymkWHWS0Bjc08/qNK/BH3J2P8LcvuObKuXOxY8iE+
	jwaTPIdL+6DG4TwF5gWOGhclBW7bRMuRsnWY+ziUKnbD2VxJeaRJKym+xPgnG6HrSmcYd2
	xaUXCZCQThYcF0/tP6bgOceQgwPF20PM1Y/JyTATbPuEHuBcumtWm0e8pSycafwdjhAkAQ
	H+ctR4vWqmiRnrtmkScDVB9Ko/R8AstAzkuoi09rJoJSxJN1dQMDLmdTv6Ns6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744791442;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8JnF6W6MNFrg0xeWxdQQoJHqmPhGjbuo4KR7DgOQtLY=;
	b=G7pkwz0t8mWzwOspBCVv2t5Ye5OELRPvyy0nidbzjxOhsg2NjcLvk9c7oVn0az0cASh4Nw
	0VoGqtVLwuhyJhBg==
From: "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/apx: Enable APX state support
Cc: "Chang S. Bae" <chang.seok.bae@intel.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Oleg Nesterov <oleg@redhat.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250416021720.12305-5-chang.seok.bae@intel.com>
References: <20250416021720.12305-5-chang.seok.bae@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174479144113.31282.7440820130745566400.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     50c5b071e2833d2b61e3774cd792620311df157c
Gitweb:        https://git.kernel.org/tip/50c5b071e2833d2b61e3774cd792620311df157c
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 15 Apr 2025 19:16:54 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 16 Apr 2025 09:44:14 +02:00

x86/fpu/apx: Enable APX state support

With securing APX against conflicting MPX, it is now ready to be enabled.
Include APX in the enabled xfeature set.

Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>
Link: https://lore.kernel.org/r/20250416021720.12305-5-chang.seok.bae@intel.com
---
 arch/x86/include/asm/fpu/xstate.h | 3 ++-
 arch/x86/kernel/fpu/xstate.c      | 3 ++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/fpu/xstate.h b/arch/x86/include/asm/fpu/xstate.h
index 7f39fe7..b308a76 100644
--- a/arch/x86/include/asm/fpu/xstate.h
+++ b/arch/x86/include/asm/fpu/xstate.h
@@ -32,7 +32,8 @@
 				      XFEATURE_MASK_PKRU | \
 				      XFEATURE_MASK_BNDREGS | \
 				      XFEATURE_MASK_BNDCSR | \
-				      XFEATURE_MASK_XTILE)
+				      XFEATURE_MASK_XTILE | \
+				      XFEATURE_MASK_APX)
 
 /*
  * Features which are restored when returning to user space.
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 14f5c1b..2ac1fc1 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -371,7 +371,8 @@ static __init void os_xrstor_booting(struct xregs_state *xstate)
 	 XFEATURE_MASK_BNDCSR |			\
 	 XFEATURE_MASK_PASID |			\
 	 XFEATURE_MASK_CET_USER |		\
-	 XFEATURE_MASK_XTILE)
+	 XFEATURE_MASK_XTILE |			\
+	 XFEATURE_MASK_APX)
 
 /*
  * setup the xstate image representing the init state

