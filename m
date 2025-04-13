Return-Path: <linux-tip-commits+bounces-4945-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC22FA87359
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 21:00:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC1AC18900B5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Apr 2025 18:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE095207E03;
	Sun, 13 Apr 2025 18:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ThqfxXgx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Vi2vjKyR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7FB1FF7BC;
	Sun, 13 Apr 2025 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744570593; cv=none; b=S7cS/DJ09toI8otxgRFLPVVS01BUmamgAL55HpDFcXzlTF3HLHsQst98VniD266NNwQeJvnLWYw9pRAi1d+nULTpyhAVSXC4O/tpsGNPaP5qfW8lb1mEzSz1dMa2kgnugNLVeNKDR2tTNZb6d4YzanmX+Ym94MaU6FVPMuqJ7r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744570593; c=relaxed/simple;
	bh=J73Mz/NKZpHeNimo00xLc9LTuw9lRQS982h1aDajP7k=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=bR83si/tMyr4/+8gPL3lnPHNFwqYoUs5d+MKDdCA63yDb/XpQSe1KJUxqCbFM1N7pvxy5Bq9LCunPkKetQQxG8jjtHHIIuySs3p2/65ZXJK+RTIUjcvLVFYGj2pYdkN/rB3DVDgdZ2n5kznsRvsOqWJJwv6k9C8oB9SJEAmj2iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ThqfxXgx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Vi2vjKyR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 13 Apr 2025 18:56:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744570587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Xr7bXR3eynWRG9J1SfkVNlHR+/NNoP03os0KbUT+aVE=;
	b=ThqfxXgxRDd1XmdlXprOKIX2bhv9/xsL6NlezT57DRrRrTASaNFzMAC2QVDBmI95eyKXMe
	hYlGgn9ZddWzuke8KkUD7P9YWJTdW3KmALmV+4JIqbchvac3gOOT78FQjI8+lukJyjAqOW
	fv4F8ugPtRY2sbWSLEF56Zwtk3ZmRAkGO/SB1/HKbxyJGvLlg5YMfFiQABcrVQbIoV8cax
	ed8moCyT5iLMajd8UmI9GamLl8BR9IAO939yhxjXYKEe31qs1vZhC3OQMiDVVNtwzt6YUV
	j/jHMcz8rmlBTOJ2bkN/tT8rjjkrAS6CuK7QQVwYYXxnKkeiLWYab6kgMa5BXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744570587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=Xr7bXR3eynWRG9J1SfkVNlHR+/NNoP03os0KbUT+aVE=;
	b=Vi2vjKyRGmHAlOmSHLCPXvg4ngbJawBmDopZM2FpRqGZ6UiVrpGGy4MHb0mE1xzzzSVd+F
	ttZiNrNpuxKdUEDw==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/msr] x86/msr: Standardize on u64 in <asm/msr-index.h>
Cc: Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@intel.com>, Xin Li <xin@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174457058717.31282.12158855594183369991.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/msr branch of tip:

Commit-ID:     f4138de5e41fae1a0b406f0d354a3028dc46bf1f
Gitweb:        https://git.kernel.org/tip/f4138de5e41fae1a0b406f0d354a3028dc46bf1f
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 09 Apr 2025 22:28:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 10 Apr 2025 11:57:57 +02:00

x86/msr: Standardize on u64 in <asm/msr-index.h>

Also fix some nearby whitespace damage while at it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Xin Li <xin@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
---
 arch/x86/include/asm/msr-index.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index e6134ef..e0d6080 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -525,7 +525,7 @@
 #define MSR_HWP_CAPABILITIES		0x00000771
 #define MSR_HWP_REQUEST_PKG		0x00000772
 #define MSR_HWP_INTERRUPT		0x00000773
-#define MSR_HWP_REQUEST 		0x00000774
+#define MSR_HWP_REQUEST			0x00000774
 #define MSR_HWP_STATUS			0x00000777
 
 /* CPUID.6.EAX */
@@ -542,16 +542,16 @@
 #define HWP_LOWEST_PERF(x)		(((x) >> 24) & 0xff)
 
 /* IA32_HWP_REQUEST */
-#define HWP_MIN_PERF(x) 		(x & 0xff)
-#define HWP_MAX_PERF(x) 		((x & 0xff) << 8)
+#define HWP_MIN_PERF(x)			(x & 0xff)
+#define HWP_MAX_PERF(x)			((x & 0xff) << 8)
 #define HWP_DESIRED_PERF(x)		((x & 0xff) << 16)
-#define HWP_ENERGY_PERF_PREFERENCE(x)	(((unsigned long long) x & 0xff) << 24)
+#define HWP_ENERGY_PERF_PREFERENCE(x)	(((u64)x & 0xff) << 24)
 #define HWP_EPP_PERFORMANCE		0x00
 #define HWP_EPP_BALANCE_PERFORMANCE	0x80
 #define HWP_EPP_BALANCE_POWERSAVE	0xC0
 #define HWP_EPP_POWERSAVE		0xFF
-#define HWP_ACTIVITY_WINDOW(x)		((unsigned long long)(x & 0xff3) << 32)
-#define HWP_PACKAGE_CONTROL(x)		((unsigned long long)(x & 0x1) << 42)
+#define HWP_ACTIVITY_WINDOW(x)		((u64)(x & 0xff3) << 32)
+#define HWP_PACKAGE_CONTROL(x)		((u64)(x & 0x1) << 42)
 
 /* IA32_HWP_STATUS */
 #define HWP_GUARANTEED_CHANGE(x)	(x & 0x1)

