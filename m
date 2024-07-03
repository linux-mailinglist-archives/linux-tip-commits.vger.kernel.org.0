Return-Path: <linux-tip-commits+bounces-1590-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 24701926909
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 21:36:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20A4283441
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Jul 2024 19:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21FB619066B;
	Wed,  3 Jul 2024 19:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2gQ63K+9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5egnrAhV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C8318F2DF;
	Wed,  3 Jul 2024 19:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720035383; cv=none; b=V2Q9NDOXNWLMpIOb2T3P7ZuOfSKfLBEc2HBAF3P+1oMEc0KN4CWH1dRYv5/m9yruDcLWB4PLj7eHrI+VFqdpggJ6S/fgVUcWSeENeoj1ENG0x/e5bZXSQORFir5GbpK3n9CYY3vljcji/Xiss+g2CShFfEJ5+QtRanyQYjogQkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720035383; c=relaxed/simple;
	bh=HXa0CyLvgAEM6vHc/tl7i6TuL22CylJvpEEPoHjk2RI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V6vCkNXcGuXEtZ9893KQaqjshPsw4GRcg2qp2JSbRsRbPoWvlDtAXUZFLBRwaeJ2S+jqVUafWgaiO1YYuBn3NPBt1P7W0QkuMYqQ2b2koohqlMlYDm/GktDTXffhwqhf7zzDYmxhR/olW7BmPIiT+iCVw5ZitLoS/209BjNt578=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2gQ63K+9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5egnrAhV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Jul 2024 19:36:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720035379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=homCkb97o3r0I27C7xcjbUxK4GXumT3OYlzQz7iCkDU=;
	b=2gQ63K+9hnfEnYwjhWwQI2Uo9vRRTNQLcTJzPXZy9dGhPR359OwShmYt1ZvQYsmxqrPflV
	ZVAwgi8Q0Og/Tv2ok29glMX1qk0XTfVchF1lkbMMzlGCXOKOdNBnVxoyvnbwV7b43smyAz
	2EyOiaEx7Ss8s9zvfK/BnTONyKhdKOxQQgT6asxq9Y2gB4XvJOXTe74fPNoT9JisWgitNs
	ou1/CNx+1mPL1M2BGpXOtMvZYCdhMeLA3lvKIJKArWtnhEHxIowIr1ts/1oAtHiIKH7iJf
	f5bGcIBZ6JEr8oP4FLsxZfOPbyJneMUKPe0Y+dqQ7mNB7GTiolEu5uFs4naUMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720035379;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=homCkb97o3r0I27C7xcjbUxK4GXumT3OYlzQz7iCkDU=;
	b=5egnrAhVMSHWnKL9m8SPZ2bOwlJjaLrAfjthuX08kIN38r8gU6BjWLCFV/ynbq55QQAxDY
	E0IkiuoYiHhBwlDQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] x86/vdso: Fix function reference in comment
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240701-vdso-cleanup-v1-3-36eb64e7ece2@linutronix.de>
References: <20240701-vdso-cleanup-v1-3-36eb64e7ece2@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172003537949.2215.2179036360488663266.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     7239ae7f8349fba53c74b559b2059b1c20e8966d
Gitweb:        https://git.kernel.org/tip/7239ae7f8349fba53c74b559b2059b1c20e8966d
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 01 Jul 2024 16:47:56 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Jul 2024 21:27:04 +02:00

x86/vdso: Fix function reference in comment

Replace the reference to the non-existent function arch_vdso_cycles_valid()
by the proper function arch_vdso_cycles_ok().

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Link: https://lore.kernel.org/r/20240701-vdso-cleanup-v1-3-36eb64e7ece2@linutronix.de

---
 arch/x86/include/asm/vdso/gettimeofday.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/vdso/gettimeofday.h
index 0ef3619..b2d2df0 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -328,9 +328,8 @@ static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycles, 
 	 * due to unsigned comparison.
 	 *
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
-	 * arch_vdso_cycles_valid() above), the effective mask is S64_MAX,
-	 * but that case is also unlikely and will also take the unlikely path
-	 * here.
+	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
+	 * case is also unlikely and will also take the unlikely path here.
 	 */
 	if (unlikely(delta > vd->max_cycles)) {
 		/*

