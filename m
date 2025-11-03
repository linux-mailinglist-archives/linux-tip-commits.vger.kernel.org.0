Return-Path: <linux-tip-commits+bounces-7211-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB3EBC2C8B6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 03 Nov 2025 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EFBEE1884902
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Nov 2025 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F12325491;
	Mon,  3 Nov 2025 14:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rqzvIKnK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oclX3H0x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E96C324B16;
	Mon,  3 Nov 2025 14:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762181290; cv=none; b=XqVSNqTdmyYlCoUP8W9FeopqCBBAOeG9do4/TNhQluJcr8yLcuCPIS705Uih/QNwSykyclx8vjocXrRxjEj3HtlwO5TUxkc2Yd8O8UnvT76VQpRvlhv2vSThk6ZQcRbXLfu6+cIPec25Zc+sepluEGz7SV7hLnEzNPj/PnOGxcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762181290; c=relaxed/simple;
	bh=0V5jhcwstA5K+EruZ1m8TXhLNpdoDb/Zu4oH02J2Am8=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=MBU5mI3MEsKyxFGWorG4IkFBGe5A0N5sYi8hR31epBknOYiZubypxdXD+lrhzabOuokIe4Pl3huMKLwm8P/kKxprZpuwYTHxOpft+w6zG0dhKkhpWd7ClJ2kx2QRi/x62QYUt+fSOzt3bkntyVFHN2Ej/ATPc7MlqcLzKHO4MiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rqzvIKnK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oclX3H0x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Nov 2025 14:48:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762181287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=X+k69GoXIqU2s2+m1xZL4KdB1u+q1UqY6JGma+Df6/s=;
	b=rqzvIKnKY+S2zE4KsOD9rgx+Vbt3fQ6G6E/eubhBLn36JjtHRIMYvxx4ftsnLV7Jp4Cb5b
	XPJTiLB6LACZeQf06uNhCjr1+kudlRRfkrmQ7nbQBFdT7U2be0ZIXs7p+C/FAxY8cy0o0g
	/QYt5fK/zMtBUjZ6zOwfjYoSzj3IPkBFGxmo/qCElO9LHwDeNELT4kveQ6hjHuIQuuf9ha
	vBKBpQZxNNC7cHyuKfePEakA5BTL/98QL74NmokPEK2rZf25zntrtoZazRCAWullDT8qtv
	7Yje6YOl8qGSTl+RIJXQLJlT1yHJ8YfwDET9FKBtyCOxBH2zqK7cx9nn5GPpVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762181287;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=X+k69GoXIqU2s2+m1xZL4KdB1u+q1UqY6JGma+Df6/s=;
	b=oclX3H0xNI58U2egFdW81+Jxy5tcFR626QHcW6hbaUd4Tal6rYJiqAGf983AEDPjVO6ZlY
	vRyZQbOMmfVjzkBg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: core/rseq] arm64: uaccess: Use unsafe wrappers for ASM GOTO
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, kernel test robot <lkp@intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176218128564.2601451.16817657974689426911.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the core/rseq branch of tip:

Commit-ID:     2e5a46fcf229c0226884dd92dd74a68ca8693eb5
Gitweb:        https://git.kernel.org/tip/2e5a46fcf229c0226884dd92dd74a68ca86=
93eb5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 31 Oct 2025 10:37:09 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 03 Nov 2025 15:26:10 +01:00

arm64: uaccess: Use unsafe wrappers for ASM GOTO

Clang propagates a provided label, which is outside of a cleanup scope to
ASM GOTO despite the fact that __raw_get_mem() has a local label for that
purpose:

  "error: cannot jump from this asm goto statement to one of its possible tar=
gets"

Using the unsafe wrapper with the extra local label indirection cures that.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/arm64/include/asm/uaccess.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/include/asm/uaccess.h b/arch/arm64/include/asm/uacces=
s.h
index 1aa4ecb..6490930 100644
--- a/arch/arm64/include/asm/uaccess.h
+++ b/arch/arm64/include/asm/uaccess.h
@@ -422,9 +422,9 @@ static __must_check __always_inline bool user_access_begi=
n(const void __user *pt
 }
 #define user_access_begin(a,b)	user_access_begin(a,b)
 #define user_access_end()	uaccess_ttbr0_disable()
-#define unsafe_put_user(x, ptr, label) \
+#define arch_unsafe_put_user(x, ptr, label) \
 	__raw_put_mem("sttr", x, uaccess_mask_ptr(ptr), label, U)
-#define unsafe_get_user(x, ptr, label) \
+#define arch_unsafe_get_user(x, ptr, label) \
 	__raw_get_mem("ldtr", x, uaccess_mask_ptr(ptr), label, U)
=20
 /*

